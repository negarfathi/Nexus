#include "../include/validator_generator.h"

const std::regex IDENT_RE("^[A-Za-z_][A-Za-z0-9_]*$");

std::string join(const std::vector<std::string>& items, const std::string& sep) {
    std::ostringstream out;
    for (std::size_t i = 0; i < items.size(); ++i) {
        if (i != 0) {
            out << sep;
        }
        out << items[i];
    }
    return out.str();
}

std::string join_lines(const std::vector<std::string>& lines) {
    return join(lines, "\n");
}

void extend(std::vector<std::string>& dst, const std::vector<std::string>& src) {
    dst.insert(dst.end(), src.begin(), src.end());
}

std::vector<std::string> set_to_vector(const std::set<std::string>& values) {
    return std::vector<std::string>(values.begin(), values.end());
}

std::string json_to_python_str(const nlohmann::json& value) {
    if (value.is_string()) {
        return value.get<std::string>();
    }
    if (value.is_boolean()) {
        return value.get<bool>() ? "True" : "False";
    }
    if (value.is_number_integer()) {
        return std::to_string(value.get<long long>());
    }
    if (value.is_number_unsigned()) {
        return std::to_string(value.get<unsigned long long>());
    }
    if (value.is_null()) {
        return "None";
    }
    return value.dump();
}

nlohmann::json get_array_or_empty(const nlohmann::json& obj, const std::string& key) {
    if (obj.contains(key)) {
        return obj.at(key);
    }
    return nlohmann::json::array();
}

std::set<std::string> set_difference_from_vector(
    std::set<std::string> values,
    const std::vector<std::string>& remove_values
) {
    for (const auto& value : remove_values) {
        values.erase(value);
    }
    return values;
}

std::set<std::string> set_difference_from_set(
    std::set<std::string> values,
    const std::set<std::string>& remove_values
) {
    for (const auto& value : remove_values) {
        values.erase(value);
    }
    return values;
}

nlohmann::json rewrite_expr(const nlohmann::json& expr, const std::map<std::string, std::string>& mapping) {
    if (expr.is_string()) {
        const std::string value = expr.get<std::string>();
        auto it = mapping.find(value);
        if (it != mapping.end()) {
            return it->second;
        }
        return value;
    }

    if (expr.is_object()) {
        nlohmann::json out;
        out["op"] = expr.at("op");
        out["args"] = nlohmann::json::array();

        const nlohmann::json args = get_array_or_empty(expr, "args");
        for (const auto& arg : args) {
            out["args"].push_back(rewrite_expr(arg, mapping));
        }

        return out;
    }

    return expr;
}

std::vector<nlohmann::json> load_loops(const std::string& path) {
    std::ifstream in(path);
    if (!in) {
        throw std::runtime_error("Could not open loop summary JSON: " + path);
    }

    nlohmann::json data;
    in >> data;

    if (data.is_array()) {
        return std::vector<nlohmann::json>(data.begin(), data.end());
    }

    if (data.is_object()) {
        if (data.contains("loop_id")) {
            return {data};
        }

        if (data.contains("loops") && data.at("loops").is_array()) {
            return std::vector<nlohmann::json>(data.at("loops").begin(), data.at("loops").end());
        }
    }

    throw std::runtime_error(
        "Loop summary JSON must be either a single loop object, "
        "a list of loop objects, or an object with a \"loops\" list"
    );
}

nlohmann::json load_candidate(const std::string& path) {
    std::ifstream in(path);
    if (!in) {
        throw std::runtime_error("Could not open candidate JSON: " + path);
    }

    nlohmann::json data;
    in >> data;

    if (!data.is_object()) {
        throw std::runtime_error("Candidate JSON must be an object");
    }

    if (!data.contains("loop_id")) {
        throw std::runtime_error("Candidate JSON must contain \"loop_id\"");
    }

    return data;
}

std::map<std::string, std::map<std::string, std::string>> candidate_cfg(const nlohmann::json& candidate) {
    const std::string loop_id = json_to_python_str(candidate.at("loop_id"));

    std::map<std::string, std::map<std::string, std::string>> cfg;
    cfg[loop_id] = {};

    for (const std::string key : {"inv", "rf", "rfp"}) {
        if (candidate.contains(key)) {
            if (candidate.at(key).is_string()) {
                cfg[loop_id][key] = candidate.at(key).get<std::string>();
            } else {
                cfg[loop_id][key] = candidate.at(key).dump();
            }
        }
    }

    return cfg;
}

std::vector<std::string> loop_vars(const nlohmann::json& loop_obj) {
    std::vector<std::string> vars;

    for (const auto& v : loop_obj.at("variables")) {
        vars.push_back(v.at("name").get<std::string>());
    }

    return vars;
}

std::string expr_to_z3(const nlohmann::json& expr) {
    if (expr.is_boolean()) {
        return expr.get<bool>() ? "True" : "False";
    }

    if (expr.is_number_integer()) {
        return std::to_string(expr.get<long long>());
    }

    if (expr.is_number_unsigned()) {
        return std::to_string(expr.get<unsigned long long>());
    }

    if (expr.is_string()) {
        const std::string value = expr.get<std::string>();

        if (value == "true") {
            return "True";
        }

        if (value == "false") {
            return "False";
        }

        return value;
    }

    if (!expr.is_object()) {
        throw std::runtime_error("Unsupported expr node: " + expr.dump());
    }

    const std::string op = expr.at("op").get<std::string>();
    const nlohmann::json args = get_array_or_empty(expr, "args");

    std::vector<std::string> zargs;
    for (const auto& arg : args) {
        zargs.push_back(expr_to_z3(arg));
    }

    if (op == "and") {
        if (zargs.empty()) {
            return "True";
        }

        if (zargs.size() == 1) {
            return zargs[0];
        }

        return "And(" + join(zargs, ", ") + ")";
    }

    if (op == "or") {
        if (zargs.empty()) {
            return "False";
        }

        if (zargs.size() == 1) {
            return zargs[0];
        }

        return "Or(" + join(zargs, ", ") + ")";
    }

    if (op == "not") {
        return "Not(" + zargs[0] + ")";
    }

    if (op == "ite") {
        return "If(" + zargs[0] + ", " + zargs[1] + ", " + zargs[2] + ")";
    }

    if (op == "=" || op == "<" || op == "<=" || op == ">" || op == ">=") {
        const std::string pyop = (op == "=") ? "==" : op;

        if (zargs.size() == 2) {
            return "(" + zargs[0] + " " + pyop + " " + zargs[1] + ")";
        }

        std::vector<std::string> parts;
        for (std::size_t i = 0; i + 1 < zargs.size(); ++i) {
            parts.push_back("(" + zargs[i] + " " + pyop + " " + zargs[i + 1] + ")");
        }

        return "And(" + join(parts, ", ") + ")";
    }

    if (op == "+" || op == "-" || op == "*" || op == "div" || op == "mod") {
        std::string pyop = op;

        if (op == "div") {
            pyop = "/";
        } else if (op == "mod") {
            pyop = "%";
        }

        if (zargs.size() == 1) {
            return zargs[0];
        }

        std::string out = zargs[0];
        for (std::size_t i = 1; i < zargs.size(); ++i) {
            out = "(" + out + " " + pyop + " " + zargs[i] + ")";
        }

        return out;
    }

    if (op == "u<" || op == "u<=" || op == "u>" || op == "u>=") {
        throw std::runtime_error(
            "Unsigned comparison '" + op + "' is not directly supported in generated Z3 Python"
        );
    }

    throw std::runtime_error("Unsupported operator: '" + op + "'");
}

void collect_identifiers(const nlohmann::json& expr, std::set<std::string>& out) {
    if (expr.is_string()) {
        const std::string value = expr.get<std::string>();

        if (std::regex_match(value, IDENT_RE) && value != "true" && value != "false") {
            out.insert(value);
        }

        return;
    }

    if (expr.is_object()) {
        const nlohmann::json args = get_array_or_empty(expr, "args");
        for (const auto& arg : args) {
            collect_identifiers(arg, out);
        }
    }
}

std::set<std::string> gather_loop_extra_identifiers(const nlohmann::json& loop_obj) {
    std::set<std::string> ids;

    for (const auto& e : get_array_or_empty(loop_obj, "init_constraints")) {
        collect_identifiers(e, ids);
    }

    collect_identifiers(loop_obj.at("guard"), ids);

    for (const auto& cc : get_array_or_empty(loop_obj, "child_calls")) {
        if (cc.contains("entry_state")) {
            for (auto it = cc.at("entry_state").begin(); it != cc.at("entry_state").end(); ++it) {
                collect_identifiers(it.value(), ids);
            }
        }

        if (cc.contains("exit_state")) {
            for (auto it = cc.at("exit_state").begin(); it != cc.at("exit_state").end(); ++it) {
                collect_identifiers(it.value(), ids);
            }
        }
    }

    for (const auto& tr : get_array_or_empty(loop_obj, "transitions")) {
        collect_identifiers(tr.at("path_condition"), ids);

        for (auto it = tr.at("updates").begin(); it != tr.at("updates").end(); ++it) {
            collect_identifiers(it.value(), ids);
        }
    }

    return ids;
}

std::vector<nlohmann::json> order_child_calls_used(const nlohmann::json& loop_obj) {
    const std::string transitions_text = get_array_or_empty(loop_obj, "transitions").dump();

    std::vector<nlohmann::json> used;
    const nlohmann::json child_calls = get_array_or_empty(loop_obj, "child_calls");

    for (const auto& cc : child_calls) {
        const std::string child_id = json_to_python_str(cc.at("child_id"));
        const std::string marker = "\"" + child_id + "_v";

        if (transitions_text.find(marker) != std::string::npos) {
            used.push_back(cc);
        }
    }

    if (!used.empty()) {
        return used;
    }

    return std::vector<nlohmann::json>(child_calls.begin(), child_calls.end());
}

std::vector<std::string> subtree_ids(
    const std::string& root_id,
    const std::map<std::string, nlohmann::json>& loops_by_id
) {
    std::vector<std::string> out;
    std::set<std::string> seen;

    std::function<void(const std::string&)> dfs = [&](const std::string& lid) {
        if (seen.count(lid) != 0) {
            return;
        }

        seen.insert(lid);

        auto it = loops_by_id.find(lid);
        if (it == loops_by_id.end()) {
            throw std::runtime_error(
                "Missing summary for descendant loop '" + lid + "'. "
                "For nested loops, pass a subtree/full summary JSON containing the target loop and all descendants."
            );
        }

        for (const auto& c : get_array_or_empty(it->second, "child_loops")) {
            dfs(json_to_python_str(c));
        }

        out.push_back(lid);
    };

    dfs(root_id);
    return out;
}

std::string emit_ints(const std::vector<std::string>& names, int wrap = 8) {
    if (names.empty()) {
        return "";
    }

    const std::string joined = join(names, " ");
    const std::string lhs = join(names, ", ");

    if (static_cast<int>(names.size()) <= wrap) {
        return lhs + " = Ints('" + joined + "')";
    }

    return lhs + " = Ints(\n    '" + joined + "'\n)";
}

std::string default_inv(const std::string& loop_id, const std::map<std::string, std::map<std::string, std::string>>& cfg) {
    auto lit = cfg.find(loop_id);

    if (lit == cfg.end()) {
        return "BoolVal(True)";
    }

    auto kit = lit->second.find("inv");

    if (kit == lit->second.end()) {
        return "BoolVal(True)";
    }

    return kit->second;
}

std::tuple<std::string, std::string> default_rf(const std::string& loop_id, const std::map<std::string, std::map<std::string, std::string>>& cfg) {
    std::string rf = "IntVal(0)";
    std::string rfp = "IntVal(0)";

    auto lit = cfg.find(loop_id);

    if (lit != cfg.end()) {
        auto rfit = lit->second.find("rf");
        if (rfit != lit->second.end()) {
            rf = rfit->second;
        }

        auto rfpit = lit->second.find("rfp");
        if (rfpit != lit->second.end()) {
            rfp = rfpit->second;
        }
    }

    return {rf, rfp};
}

std::string emit_leaf_script(const nlohmann::json& loop_obj, const std::map<std::string, std::map<std::string, std::string>>& cfg) {
    const std::string lid = json_to_python_str(loop_obj.at("loop_id"));
    const std::vector<std::string> vars = loop_vars(loop_obj);
    const std::vector<std::string> curr = vars;

    std::vector<std::string> nxt;
    for (const auto& v : vars) {
        nxt.push_back(v + "p");
    }

    std::set<std::string> extra_set = gather_loop_extra_identifiers(loop_obj);
    extra_set = set_difference_from_vector(extra_set, vars);

    const std::vector<std::string> extras = set_to_vector(extra_set);

    std::vector<std::string> lines;

    lines.push_back("from z3 import *");
    lines.push_back("");
    lines.push_back("# Auto-generated for loop " + lid);
    lines.push_back("# Leaf loop: exact one-step transition relation from JSON");
    lines.push_back("");
    lines.push_back(emit_ints(curr));
    lines.push_back(emit_ints(nxt));

    if (!extras.empty()) {
        lines.push_back("");
        lines.push_back(emit_ints(extras));
    }

    lines.push_back("");
    lines.push_back("guard = " + expr_to_z3(loop_obj.at("guard")));
    lines.push_back("");
    lines.push_back("# Edit this invariant if you have one");
    lines.push_back("inv = " + default_inv(lid, cfg));
    lines.push_back("");

    std::vector<std::string> branch_names;

    int i = 1;
    for (const auto& tr : loop_obj.at("transitions")) {
        const std::string bname = "branch" + std::to_string(i++);
        branch_names.push_back(bname);

        std::vector<std::string> conjuncts;
        conjuncts.push_back(expr_to_z3(tr.at("path_condition")));

        for (const auto& v : vars) {
            const std::string next_key = v + "'";
            conjuncts.push_back(v + "p == " + expr_to_z3(tr.at("updates").at(next_key)));
        }

        lines.push_back("# " + tr.at("branch_id").get<std::string>());
        lines.push_back(bname + " = And(");

        for (std::size_t j = 0; j < conjuncts.size(); ++j) {
            const std::string comma = (j + 1 != conjuncts.size()) ? "," : "";
            lines.push_back("    " + conjuncts[j] + comma);
        }

        lines.push_back(")");
        lines.push_back("");
    }

    if (!branch_names.empty()) {
        lines.push_back("transition = Or(" + join(branch_names, ", ") + ")");
    } else {
        lines.push_back("transition = BoolVal(False)");
    }

    lines.push_back("");

    auto [rf, rfp] = default_rf(lid, cfg);

    lines.push_back("# Edit this ranking function candidate");
    lines.push_back("rf = " + rf);
    lines.push_back("rfp = " + rfp);
    lines.push_back("");
    lines.push_back("def check_unsat(name, formula):");
    lines.push_back("    s = Solver()");
    lines.push_back("    s.add(formula)");
    lines.push_back("    r = s.check()");
    lines.push_back("    print(f\"{name}: {r}\")");
    lines.push_back("    if r == sat:");
    lines.push_back("        print(\"counterexample:\")");
    lines.push_back("        print(s.model())");
    lines.push_back("    print()");
    lines.push_back("    return r");
    lines.push_back("");
    lines.push_back("r1 = check_unsat(");
    lines.push_back("    \"nonnegativity violated\",");
    lines.push_back("    And(inv, guard, rf < 0)");
    lines.push_back(")");
    lines.push_back("");
    lines.push_back("r2 = check_unsat(");
    lines.push_back("    \"decrease violated\",");
    lines.push_back("    And(inv, guard, transition, Not(rfp < rf))");
    lines.push_back(")");
    lines.push_back("");
    lines.push_back("if r1 == unsat and r2 == unsat:");
    lines.push_back("    print(\"" + lid + " ranking candidate proved.\")");
    lines.push_back("else:");
    lines.push_back("    print(\"" + lid + " ranking candidate not proved.\")");
    lines.push_back("");

    return join_lines(lines);
}

std::tuple<std::vector<std::string>, std::string> emit_private_tuple(
    const std::string& prefix,
    const std::vector<std::string>& var_names,
    const std::string& suffix
) {
    std::vector<std::string> names;

    for (const auto& v : var_names) {
        names.push_back(prefix + "_" + v + "_" + suffix);
    }

    return {names, emit_ints(names)};
}

std::tuple<
    std::vector<std::string>,
    std::vector<std::string>,
    std::vector<std::string>,
    std::vector<std::string>
> emit_subtree_relations(
    const std::string& root_id,
    const std::map<std::string, nlohmann::json>& loops_by_id
) {
    const std::vector<std::string> order = subtree_ids(root_id, loops_by_id);

    std::vector<std::string> descendants;
    for (const auto& lid : order) {
        if (lid != root_id) {
            descendants.push_back(lid);
        }
    }

    std::vector<std::string> decl_lines;
    std::vector<std::string> rule_lines;
    std::vector<std::string> register_names;
    std::vector<std::string> declare_vars;

    for (const auto& lid : descendants) {
        const nlohmann::json& loop_obj = loops_by_id.at(lid);
        const std::vector<std::string> vars = loop_vars(loop_obj);

        auto [in_names, in_decl] = emit_private_tuple(lid, vars, "in");
        auto [mid_names, mid_decl] = emit_private_tuple(lid, vars, "mid");
        auto [out_names, out_decl] = emit_private_tuple(lid, vars, "out");

        decl_lines.push_back(in_decl);
        decl_lines.push_back(mid_decl);
        decl_lines.push_back(out_decl);
        decl_lines.push_back(lid + "_I = [" + join(in_names, ", ") + "]");
        decl_lines.push_back(lid + "_M = [" + join(mid_names, ", ") + "]");
        decl_lines.push_back(lid + "_O = [" + join(out_names, ", ") + "]");
        decl_lines.push_back("");

        extend(declare_vars, in_names);
        extend(declare_vars, mid_names);
        extend(declare_vars, out_names);

        register_names.push_back("STEP_" + lid);
        register_names.push_back("E2E_" + lid);

        std::set<std::string> extra_set = gather_loop_extra_identifiers(loop_obj);
        extra_set = set_difference_from_vector(extra_set, vars);

        const std::vector<std::string> extras = set_to_vector(extra_set);

        if (!extras.empty()) {
            decl_lines.push_back(emit_ints(extras));
            decl_lines.push_back("");
            extend(declare_vars, extras);
        }

        rule_lines.push_back("# ---------- " + lid + " ----------");
        rule_lines.push_back(
            "STEP_" + lid + " = mk_rel(\"STEP_" + lid + "\", " +
            std::to_string(2 * vars.size()) + ")"
        );
        rule_lines.push_back(
            "E2E_" + lid + " = mk_rel(\"E2E_" + lid + "\", " +
            std::to_string(2 * vars.size()) + ")"
        );
        rule_lines.push_back("");

        std::map<std::string, std::string> in_map;
        std::map<std::string, std::string> mid_map;
        std::map<std::string, std::string> out_map;

        for (std::size_t idx = 0; idx < vars.size(); ++idx) {
            in_map[vars[idx]] = in_names[idx];
            mid_map[vars[idx]] = mid_names[idx];
            out_map[vars[idx]] = out_names[idx];
        }

        for (const auto& tr : loop_obj.at("transitions")) {
            std::vector<std::string> conjuncts;

            conjuncts.push_back(expr_to_z3(rewrite_expr(tr.at("path_condition"), in_map)));

            for (const auto& v : vars) {
                const std::string next_key = v + "'";
                conjuncts.push_back(
                    mid_map[v] + " == " +
                    expr_to_z3(rewrite_expr(tr.at("updates").at(next_key), in_map))
                );
            }

            rule_lines.push_back("fp.rule(");
            rule_lines.push_back("    rel_call(STEP_" + lid + ", " + lid + "_I, " + lid + "_M),");
            rule_lines.push_back("    [");

            for (std::size_t ci = 0; ci < conjuncts.size(); ++ci) {
                const std::string comma = (ci + 1 != conjuncts.size()) ? "," : "";
                rule_lines.push_back("        " + conjuncts[ci] + comma);
            }

            rule_lines.push_back("    ],");
            rule_lines.push_back("    name=\"" + lid + "_" + tr.at("branch_id").get<std::string>() + "\"");
            rule_lines.push_back(")");
            rule_lines.push_back("");
        }

        const std::string g = expr_to_z3(rewrite_expr(loop_obj.at("guard"), in_map));

        std::vector<std::string> exit_conds;
        exit_conds.push_back("Not(" + g + ")");

        for (const auto& v : vars) {
            exit_conds.push_back(out_map[v] + " == " + in_map[v]);
        }

        rule_lines.push_back("fp.rule(");
        rule_lines.push_back("    rel_call(E2E_" + lid + ", " + lid + "_I, " + lid + "_O),");
        rule_lines.push_back("    [");

        for (std::size_t ci = 0; ci < exit_conds.size(); ++ci) {
            const std::string comma = (ci + 1 != exit_conds.size()) ? "," : "";
            rule_lines.push_back("        " + exit_conds[ci] + comma);
        }

        rule_lines.push_back("    ],");
        rule_lines.push_back("    name=\"E2E_" + lid + "_base\"");
        rule_lines.push_back(")");
        rule_lines.push_back("");

        rule_lines.push_back("fp.rule(");
        rule_lines.push_back("    rel_call(E2E_" + lid + ", " + lid + "_I, " + lid + "_O),");
        rule_lines.push_back("    [");
        rule_lines.push_back("        rel_call(STEP_" + lid + ", " + lid + "_I, " + lid + "_M),");
        rule_lines.push_back("        rel_call(E2E_" + lid + ", " + lid + "_M, " + lid + "_O)");
        rule_lines.push_back("    ],");
        rule_lines.push_back("    name=\"E2E_" + lid + "_step\"");
        rule_lines.push_back(")");
        rule_lines.push_back("");
    }

    return {decl_lines, rule_lines, register_names, declare_vars};
}

std::string emit_root_fixedpoint_script(
    const nlohmann::json& loop_obj,
    const std::map<std::string, nlohmann::json>& loops_by_id,
    const std::map<std::string, std::map<std::string, std::string>>& cfg
) {
    const std::string lid = json_to_python_str(loop_obj.at("loop_id"));
    const std::vector<std::string> vars = loop_vars(loop_obj);
    const std::vector<std::string> curr = vars;

    std::vector<std::string> nxt;
    for (const auto& v : vars) {
        nxt.push_back(v + "p");
    }

    const std::vector<nlohmann::json> child_calls = order_child_calls_used(loop_obj);

    std::set<std::string> child_exit_name_set;

    for (const auto& cc : child_calls) {
        const std::string child_id = json_to_python_str(cc.at("child_id"));

        if (loops_by_id.find(child_id) == loops_by_id.end()) {
            throw std::runtime_error(
                "Missing summary for child loop '" + child_id + "'. "
                "For nested loops, pass a subtree/full summary JSON containing the target loop and descendants."
            );
        }

        for (const auto& v : loop_vars(loops_by_id.at(child_id))) {
            child_exit_name_set.insert(cc.at("exit_state").at(v).get<std::string>());
        }
    }

    const std::vector<std::string> child_exit_names = set_to_vector(child_exit_name_set);

    auto [subtree_decl_lines, subtree_rule_lines, subtree_registers, subtree_declare_vars] =
        emit_subtree_relations(lid, loops_by_id);

    std::set<std::string> extra_set = gather_loop_extra_identifiers(loop_obj);
    extra_set = set_difference_from_vector(extra_set, vars);
    extra_set = set_difference_from_set(extra_set, child_exit_name_set);

    const std::vector<std::string> extras = set_to_vector(extra_set);

    std::vector<std::string> lines;

    lines.push_back("from z3 import *");
    lines.push_back("");
    lines.push_back("# Auto-generated for loop " + lid);
    lines.push_back("# Parent loop: exact compositional fixedpoint script");
    lines.push_back("");
    lines.push_back(emit_ints(curr));
    lines.push_back(emit_ints(nxt));

    if (!child_exit_names.empty()) {
        lines.push_back("");
        lines.push_back(emit_ints(child_exit_names));
    }

    if (!extras.empty()) {
        lines.push_back("");
        lines.push_back(emit_ints(extras));
    }

    if (!subtree_decl_lines.empty()) {
        lines.push_back("");
        extend(lines, subtree_decl_lines);
    }

    lines.push_back("V = [" + join(curr, ", ") + "]");
    lines.push_back("Vp = [" + join(nxt, ", ") + "]");
    lines.push_back("");
    lines.push_back("def mk_rel(name, n_ints):");
    lines.push_back("    return Function(name, *([IntSort()] * n_ints), BoolSort())");
    lines.push_back("");
    lines.push_back("def rel_call(R, xs, ys):");
    lines.push_back("    return R(*(xs + ys))");
    lines.push_back("");
    lines.push_back("def check_fp(name, query):");
    lines.push_back("    r = fp.query(query)");
    lines.push_back("    print(f\"{name}: {r}\")");
    lines.push_back("    if r == sat:");
    lines.push_back("        try:");
    lines.push_back("            print(\"ground counterexample:\")");
    lines.push_back("            print(fp.get_ground_sat_answer())");
    lines.push_back("        except Exception:");
    lines.push_back("            print(\"ground counterexample unavailable\")");
    lines.push_back("        try:");
    lines.push_back("            print(\"rule names along trace:\")");
    lines.push_back("            print(fp.get_rule_names_along_trace())");
    lines.push_back("        except Exception:");
    lines.push_back("            print(\"trace unavailable\")");
    lines.push_back("    elif r == unknown:");
    lines.push_back("        print(\"reason unknown:\")");
    lines.push_back("        print(fp.reason_unknown())");
    lines.push_back("    print()");
    lines.push_back("    return r");
    lines.push_back("");

    extend(lines, subtree_rule_lines);

    lines.push_back(
        "STEP_" + lid + " = mk_rel(\"STEP_" + lid + "\", " +
        std::to_string(2 * vars.size()) + ")"
    );
    lines.push_back(
        "REACH_" + lid + " = Function(\"REACH_" + lid +
        "\", *([IntSort()] * " + std::to_string(vars.size()) + "), BoolSort())"
    );
    lines.push_back(
        "BAD_NONNEG = Function(\"BAD_NONNEG\", *([IntSort()] * " +
        std::to_string(vars.size()) + "), BoolSort())"
    );
    lines.push_back(
        "BAD_DECREASE = Function(\"BAD_DECREASE\", *([IntSort()] * " +
        std::to_string(2 * vars.size()) + "), BoolSort())"
    );
    lines.push_back("");
    lines.push_back("fp = Fixedpoint()");
    lines.push_back("fp.set(engine=\"spacer\")");

    std::vector<std::string> regs = subtree_registers;
    regs.push_back("STEP_" + lid);
    regs.push_back("REACH_" + lid);
    regs.push_back("BAD_NONNEG");
    regs.push_back("BAD_DECREASE");

    lines.push_back("fp.register_relation(");

    for (std::size_t i = 0; i < regs.size(); ++i) {
        const std::string comma = (i + 1 != regs.size()) ? "," : "";
        lines.push_back("    " + regs[i] + comma);
    }

    lines.push_back(")");
    lines.push_back("");

    std::vector<std::string> declared;
    extend(declared, curr);
    extend(declared, nxt);
    extend(declared, child_exit_names);
    extend(declared, extras);
    extend(declared, subtree_declare_vars);

    if (!declared.empty()) {
        lines.push_back("fp.declare_var(");

        for (std::size_t i = 0; i < declared.size(); ++i) {
            const std::string comma = (i + 1 != declared.size()) ? "," : "";
            lines.push_back("    " + declared[i] + comma);
        }

        lines.push_back(")");
        lines.push_back("");
    }

    std::map<std::string, nlohmann::json> used_cc_by_id;

    for (const auto& cc : child_calls) {
        used_cc_by_id[json_to_python_str(cc.at("child_id"))] = cc;
    }

    for (const auto& tr : loop_obj.at("transitions")) {
        std::vector<std::string> conjuncts;

        const std::string referenced_text = tr.dump();

        for (const auto& item : used_cc_by_id) {
            const std::string& child_id = item.first;
            const nlohmann::json& cc = item.second;

            std::vector<std::string> exit_names;

            for (const auto& v : loop_vars(loops_by_id.at(child_id))) {
                exit_names.push_back(cc.at("exit_state").at(v).get<std::string>());
            }

            bool referenced = false;

            for (const auto& name : exit_names) {
                if (referenced_text.find(name) != std::string::npos) {
                    referenced = true;
                    break;
                }
            }

            if (referenced) {
                std::vector<std::string> entry_exprs;
                std::vector<std::string> exit_exprs;

                for (const auto& v : loop_vars(loops_by_id.at(child_id))) {
                    entry_exprs.push_back(expr_to_z3(cc.at("entry_state").at(v)));
                    exit_exprs.push_back(cc.at("exit_state").at(v).get<std::string>());
                }

                conjuncts.push_back(
                    "rel_call(E2E_" + child_id + ", [" + join(entry_exprs, ", ") +
                    "], [" + join(exit_exprs, ", ") + "])"
                );
            }
        }

        conjuncts.push_back(expr_to_z3(tr.at("path_condition")));

        for (const auto& v : vars) {
            const std::string next_key = v + "'";
            conjuncts.push_back(v + "p == " + expr_to_z3(tr.at("updates").at(next_key)));
        }

        lines.push_back("fp.rule(");
        lines.push_back("    rel_call(STEP_" + lid + ", V, Vp),");
        lines.push_back("    [");

        for (std::size_t i = 0; i < conjuncts.size(); ++i) {
            const std::string comma = (i + 1 != conjuncts.size()) ? "," : "";
            lines.push_back("        " + conjuncts[i] + comma);
        }

        lines.push_back("    ],");
        lines.push_back("    name=\"" + lid + "_" + tr.at("branch_id").get<std::string>() + "\"");
        lines.push_back(")");
        lines.push_back("");
    }

    const nlohmann::json init_constraints = get_array_or_empty(loop_obj, "init_constraints");

    std::vector<std::string> init_expr;

    for (const auto& e : init_constraints) {
        init_expr.push_back(expr_to_z3(e));
    }

    if (init_expr.empty()) {
        init_expr.push_back("True");
    }

    lines.push_back("guard = " + expr_to_z3(loop_obj.at("guard")));
    lines.push_back("");
    lines.push_back("fp.rule(");
    lines.push_back("    REACH_" + lid + "(*V),");
    lines.push_back("    [");

    for (std::size_t i = 0; i < init_expr.size(); ++i) {
        const std::string comma = (i + 1 != init_expr.size()) ? "," : "";
        lines.push_back("        " + init_expr[i] + comma);
    }

    lines.push_back("    ],");
    lines.push_back("    name=\"REACH_" + lid + "_init\"");
    lines.push_back(")");
    lines.push_back("");

    lines.push_back("fp.rule(");
    lines.push_back("    REACH_" + lid + "(*Vp),");
    lines.push_back("    [");
    lines.push_back("        REACH_" + lid + "(*V),");
    lines.push_back("        rel_call(STEP_" + lid + ", V, Vp)");
    lines.push_back("    ],");
    lines.push_back("    name=\"REACH_" + lid + "_step\"");
    lines.push_back(")");
    lines.push_back("");

    auto [rf, rfp] = default_rf(lid, cfg);

    lines.push_back("# Edit this ranking function candidate");
    lines.push_back("rf = " + rf);
    lines.push_back("rfp = " + rfp);
    lines.push_back("");
    lines.push_back("fp.rule(");
    lines.push_back("    BAD_NONNEG(*V),");
    lines.push_back("    [");
    lines.push_back("        REACH_" + lid + "(*V),");
    lines.push_back("        guard,");
    lines.push_back("        rf < 0");
    lines.push_back("    ],");
    lines.push_back("    name=\"BAD_NONNEG_rule\"");
    lines.push_back(")");
    lines.push_back("");

    lines.push_back("fp.rule(");
    lines.push_back("    BAD_DECREASE(*(V + Vp)),");
    lines.push_back("    [");
    lines.push_back("        REACH_" + lid + "(*V),");
    lines.push_back("        guard,");
    lines.push_back("        rel_call(STEP_" + lid + ", V, Vp),");
    lines.push_back("        Not(rfp < rf)");
    lines.push_back("    ],");
    lines.push_back("    name=\"BAD_DECREASE_rule\"");
    lines.push_back(")");
    lines.push_back("");
    lines.push_back("r1 = check_fp(\"nonnegativity violated\", BAD_NONNEG(*V))");
    lines.push_back("r2 = check_fp(\"decrease violated\", BAD_DECREASE(*(V + Vp)))");
    lines.push_back("");
    lines.push_back("if r1 == unsat and r2 == unsat:");
    lines.push_back("    print(\"" + lid + " ranking candidate proved.\")");
    lines.push_back("else:");
    lines.push_back("    print(\"" + lid + " ranking candidate not proved.\")");
    lines.push_back("");

    return join_lines(lines);
}

std::string generate_script(
    const std::vector<nlohmann::json>& loop_data,
    const std::string& out_path,
    const std::map<std::string, std::map<std::string, std::string>>& cfg,
    const std::string& target_loop_id
) {
    std::map<std::string, nlohmann::json> loops_by_id;

    for (const auto& obj : loop_data) {
        loops_by_id[json_to_python_str(obj.at("loop_id"))] = obj;
    }

    auto it = loops_by_id.find(target_loop_id);

    if (it == loops_by_id.end()) {
        throw std::runtime_error(
            "Target loop '" + target_loop_id + "' not found in loop summary JSON. "
            "Pass the summary for this loop, or a subtree/full summary JSON containing it."
        );
    }

    const nlohmann::json& loop_obj = it->second;

    std::string code;

    if (loop_obj.contains("child_loops") && !loop_obj.at("child_loops").empty()) {
        code = emit_root_fixedpoint_script(loop_obj, loops_by_id, cfg);
    } else {
        code = emit_leaf_script(loop_obj, cfg);
    }

    const std::filesystem::path output_path(out_path);
    const std::filesystem::path parent_dir = output_path.parent_path();

    if (!parent_dir.empty()) {
        std::filesystem::create_directories(parent_dir);
    }

    std::ofstream out(out_path);

    if (!out) {
        throw std::runtime_error("Could not open output file: " + out_path);
    }

    out << code;

    return out_path;
}

bool ValidatorGenerator::generate(
    const std::filesystem::path& loopSummaryPath,
    const std::filesystem::path& candidatePath,
    const std::filesystem::path& validatorPath
) {
    try {
        const std::vector<nlohmann::json> loops = load_loops(loopSummaryPath.string());
        const nlohmann::json candidate = load_candidate(candidatePath.string());
        const std::map<std::string, std::map<std::string, std::string>> cfg = candidate_cfg(candidate);

        generate_script(
            loops,
            validatorPath.string(),
            cfg,
            json_to_python_str(candidate.at("loop_id"))
        );

        return true;
    } catch (const std::exception& ex) {
        std::cerr << "ValidatorGenerator error: " << ex.what() << "\n";
        return false;
    }
}