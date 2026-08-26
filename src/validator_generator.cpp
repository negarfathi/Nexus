#include "../include/validator_generator.h"

struct CandidateInformation {
    std::string kind;
    std::size_t rankingComponents = 0;
};

struct PythonContext {
    std::ostringstream output;
    std::map<std::string, std::size_t> relations;
    std::set<std::string> declaredIntegers;
    std::set<std::string> fixedpointVariables;
};

static std::map<std::string, nlohmann::ordered_json> loadLoopInformation(const std::filesystem::path& loopInformationDirectory) {
    if (!std::filesystem::exists(loopInformationDirectory) || !std::filesystem::is_directory(loopInformationDirectory)) {
        throw std::runtime_error("Loop-information directory does not exist: " + loopInformationDirectory.string());
    }
    std::map<std::string, nlohmann::ordered_json> loopInformationList;
    for (const auto& entry : std::filesystem::recursive_directory_iterator(loopInformationDirectory)) {
        if (!entry.is_regular_file()) {
            continue;
        }
        std::string extension = entry.path().extension().string();
        std::transform(extension.begin(), extension.end(), extension.begin(), [](unsigned char c) {
            return static_cast<char>(std::tolower(c));
        });
        if (extension != ".json") {
            continue;
        }
        std::ifstream inputStream(entry.path());
        if (!inputStream) {
            throw std::runtime_error("Could not open loop-information JSON: " + entry.path().string());
        }
        nlohmann::ordered_json loopInformation;
        inputStream >> loopInformation;
        if (!loopInformation.is_object() || !loopInformation.contains("loop_id") || !loopInformation.at("loop_id").is_string()) {
            continue;
        }
        const std::string loopId = loopInformation.at("loop_id").get<std::string>();
        if (!loopInformationList.emplace(loopId, loopInformation).second) {
            throw std::runtime_error("More than one loop-information JSON was found for loop '" + loopId + "'.");
        }
    }
    if (loopInformationList.empty()) {
        throw std::runtime_error("No loop-information JSON files were found in: " + loopInformationDirectory.string());
    }
    return loopInformationList;
}

static std::map<std::string, std::set<std::string>> computeDependencyLoops(const std::map<std::string, nlohmann::ordered_json>& loopInformationList, const std::string& targetLoopId) {
    static const std::vector<std::string> relationFields = {
        "entry_states",
        "loop_iteration_steps",
        "loop_exit_steps",
        "loop_return_steps",
        "reachable_header_states",
        "header_to_exit",
        "header_to_return",
        "actual_exit"
    };
    if (!loopInformationList.contains(targetLoopId)) {
        throw std::runtime_error("No loop information was found for target loop '" + targetLoopId + "'.");
    }
    std::map<std::string, std::string> relationOwners;
    for (const auto& [loopId, loopInformation] : loopInformationList) {
        for (const std::string& field : relationFields) {
            if (!loopInformation.contains(field) || !loopInformation.at(field).is_object() ||
                !loopInformation.at(field).contains("id") || !loopInformation.at(field).at("id").is_string()) {
                throw std::runtime_error("Loop '" + loopId + "' has malformed relation field '" + field + "'.");
            }
            const std::string relationId = loopInformation.at(field).at("id").get<std::string>();
            if (!relationOwners.emplace(relationId, loopId).second) {
                throw std::runtime_error("Relation id '" + relationId + "' is defined by more than one loop.");
            }
        }
    }
    std::map<std::string, std::set<std::string>> dependencyGraph;
    std::set<std::string> visited;
    std::function<void(const std::string&)> visit = [&](const std::string& loopId) {
        if (visited.contains(loopId)) {
            return;
        }
        visited.insert(loopId);
        const nlohmann::ordered_json& loopInformation = loopInformationList.at(loopId);
        std::set<std::string> dependencies;
        if (loopInformation.contains("parent_loop_id") && loopInformation.at("parent_loop_id").is_string()) {
            dependencies.insert(loopInformation.at("parent_loop_id").get<std::string>());
        }
        for (const char* field : {"child_loop_ids", "previous_sequential_loop_ids"}) {
            if (loopInformation.contains(field) && loopInformation.at(field).is_array()) {
                for (const auto& referencedLoop : loopInformation.at(field)) {
                    if (referencedLoop.is_string()) {
                        dependencies.insert(referencedLoop.get<std::string>());
                    }
                }
            }
        }
        std::function<void(const nlohmann::ordered_json&)> collectRelationReferences = [&](const nlohmann::ordered_json& node) {
            if (node.is_object()) {
                if (node.contains("relation") && node.at("relation").is_string()) {
                    const std::string relationId = node.at("relation").get<std::string>();
                    const auto owner = relationOwners.find(relationId);
                    if (owner != relationOwners.end()) {
                        dependencies.insert(owner->second);
                    }
                }
                for (auto it = node.begin(); it != node.end(); ++it) {
                    collectRelationReferences(it.value());
                }
            }
            else if (node.is_array()) {
                for (const auto& value : node) {
                    collectRelationReferences(value);
                }
            }
        };
        collectRelationReferences(loopInformation);
        dependencies.erase(loopId);
        for (const std::string& dependency : dependencies) {
            if (!loopInformationList.contains(dependency)) {
                throw std::runtime_error("Loop '" + loopId + "' references missing dependency loop '" + dependency + "'.");
            }
        }
        dependencyGraph.emplace(loopId, dependencies);
        for (const std::string& dependency : dependencies) {
            visit(dependency);
        }
    };
    visit(targetLoopId);
    return dependencyGraph;
}

static std::vector<std::string> orderLoops(const std::map<std::string, std::set<std::string>>& dependencyGraph, const std::string& targetLoopId) {
    std::vector<std::string> orderedLoops;
    std::set<std::string> completed;
    std::set<std::string> active;
    std::function<void(const std::string&)> visit = [&](const std::string& loopId) {
        if (completed.contains(loopId)) {
            return;
        }
        if (active.contains(loopId)) {
            return;
        }
        active.insert(loopId);
        const auto dependencies = dependencyGraph.find(loopId);
        if (dependencies != dependencyGraph.end()) {
            for (const std::string& dependency : dependencies->second) {
                visit(dependency);
            }
        }
        active.erase(loopId);
        completed.insert(loopId);
        if (loopId != targetLoopId) {
            orderedLoops.push_back(loopId);
        }
    };
    visit(targetLoopId);
    orderedLoops.push_back(targetLoopId);
    return orderedLoops;
}

static const nlohmann::ordered_json& getStateSymbols(const nlohmann::ordered_json& loopInformation) {
    const std::string loopId = loopInformation.contains("loop_id") && loopInformation.at("loop_id").is_string() ? loopInformation.at("loop_id").get<std::string>() : "<unknown>";
    if (!loopInformation.contains("state_symbols") || !loopInformation.at("state_symbols").is_array()) {
        throw std::runtime_error("state_symbols must be an array for loop '" + loopId + "'.");
    }
    const nlohmann::ordered_json& stateSymbols = loopInformation.at("state_symbols");
    for (const auto& symbol : stateSymbols) {
        if (!symbol.is_object() || !symbol.contains("current") || !symbol.at("current").is_string() || !symbol.contains("next") || !symbol.at("next").is_string() || !symbol.contains("output") || !symbol.at("output").is_string() || !symbol.contains("type") || !symbol.at("type").is_string() || !symbol.contains("llvm_slot") || !symbol.at("llvm_slot").is_string()) {
            throw std::runtime_error("Malformed state_symbols entry for loop '" + loopId + "'.");
        }
    }
    return stateSymbols;
}

static std::vector<std::string> getStateSymbolNames(const nlohmann::ordered_json& loopInformation, const char* field) {
    std::vector<std::string> names;
    for (const auto& symbol : getStateSymbols(loopInformation)) {
        names.push_back(symbol.at(field).get<std::string>());
    }
    return names;
}

static const nlohmann::ordered_json& getNondeterministicSymbols(const nlohmann::ordered_json& loopInformation) {
    const std::string loopId = loopInformation.contains("loop_id") && loopInformation.at("loop_id").is_string() ? loopInformation.at("loop_id").get<std::string>() : "<unknown>";
    if (!loopInformation.contains("nondeterministic_symbols") || !loopInformation.at("nondeterministic_symbols").is_array()) {
        throw std::runtime_error("nondeterministic_symbols must be an array for loop '" + loopId + "'.");
    }
    const nlohmann::ordered_json& symbols = loopInformation.at("nondeterministic_symbols");
    for (const auto& symbol : symbols) {
        if (!symbol.is_object() || !symbol.contains("name") || !symbol.at("name").is_string() || !symbol.contains("type") || !symbol.at("type").is_string()) {
            throw std::runtime_error("Malformed nondeterministic_symbols entry for loop '" + loopId + "'.");
        }
    }
    return symbols;
}

static void populateSymbolEnvironment(const nlohmann::ordered_json& loopInformation, std::map<std::string, std::string>& environment) {
    for (const auto& symbol : getStateSymbols(loopInformation)) {
        for (const char* field : {"current", "next", "output"}) {
            const std::string name = symbol.at(field).get<std::string>();
            environment.emplace(name, name);
        }
    }
    for (const auto& symbol : getNondeterministicSymbols(loopInformation)) {
        const std::string name = symbol.at("name").get<std::string>();
        environment.emplace(name, name);
    }
}

static void generateSymbols(PythonContext& context, const nlohmann::ordered_json& loopInformation) {
    const std::string loopId = loopInformation.at("loop_id").get<std::string>();
    const nlohmann::ordered_json& stateSymbols = getStateSymbols(loopInformation);
    const nlohmann::ordered_json& nondeterministicSymbols = getNondeterministicSymbols(loopInformation);
    context.output << "# " << loopId << "\n" << "# State symbols\n";
    std::vector<std::string> currentState;
    std::vector<std::string> nextState;
    std::vector<std::string> outputState;
    auto declareFixedpointInteger = [&](const std::string& symbol) {
        if (!context.declaredIntegers.contains(symbol)) {
            context.output << symbol << " = Int(" << nlohmann::ordered_json(symbol).dump() << ")\n";
            context.declaredIntegers.insert(symbol);
        }
        if (!context.fixedpointVariables.contains(symbol)) {
            context.output << "fp.declare_var(" << symbol << ")\n";
            context.fixedpointVariables.insert(symbol);
        }
    };
    for (const auto& stateSymbol : stateSymbols) {
        const std::string current = stateSymbol.at("current").get<std::string>();
        const std::string next = stateSymbol.at("next").get<std::string>();
        const std::string output = stateSymbol.at("output").get<std::string>();
        declareFixedpointInteger(current);
        declareFixedpointInteger(next);
        declareFixedpointInteger(output);
        currentState.push_back(current);
        nextState.push_back(next);
        outputState.push_back(output);
    }
    auto writeStateList = [&](const std::string& name, const std::vector<std::string>& values) {
        context.output << name << " = [";
        for (std::size_t i = 0; i < values.size(); ++i) {
            if (i != 0) {
                context.output << ", ";
            }
            context.output << values[i];
        }
        context.output << "]\n";
    };
    writeStateList(loopId + "_state", currentState);
    writeStateList(loopId + "_next_state", nextState);
    writeStateList(loopId + "_output_state", outputState);
    if (!nondeterministicSymbols.empty()) {
        context.output << "\n# Nondeterministic symbols\n";
        for (const auto& symbol : nondeterministicSymbols) {
            declareFixedpointInteger(symbol.at("name").get<std::string>());
        }
    }
    context.output << "\n";
}

static void generateRelationDeclarations(PythonContext& context, const std::map<std::string, nlohmann::ordered_json>& loopInformationList, const std::vector<std::string>& orderedLoops) {
    static const std::vector<std::string> relationFields = {
        "entry_states",
        "loop_iteration_steps",
        "loop_exit_steps",
        "loop_return_steps",
        "reachable_header_states",
        "header_to_exit",
        "header_to_return",
        "actual_exit"
    };
    context.output << "# ============================================================\n"
                   << "# Relation declarations\n"
                   << "# ============================================================\n\n";
    for (const std::string& loopId : orderedLoops) {
        const nlohmann::ordered_json& loopInformation = loopInformationList.at(loopId);
        const std::size_t stateSize = getStateSymbols(loopInformation).size();
        context.output << "# " << loopId << "\n";
        for (const std::string& field : relationFields) {
            const nlohmann::ordered_json& relationObject = loopInformation.at(field);
            if (!relationObject.is_object() || !relationObject.contains("id") || !relationObject.at("id").is_string()) {
                throw std::runtime_error("Loop '" + loopId + "' has malformed relation field '" + field + "'.");
            }
            const std::string relationId = relationObject.at("id").get<std::string>();
            const std::size_t arity = field == "loop_iteration_steps" || field == "loop_exit_steps" || field == "header_to_exit" ? 2 * stateSize : stateSize;
            if (!context.relations.emplace(relationId, arity).second) {
                throw std::runtime_error("Duplicate relation id '" + relationId + "'.");
            }
            context.output << relationId << " = Function(" << nlohmann::ordered_json(relationId).dump();
            for (std::size_t i = 0; i < arity; ++i) {
                context.output << ", IntSort()";
            }
            context.output << ", BoolSort())\n" << "fp.register_relation(" << relationId << ")\n";
        }
        context.output << "\n";
    }
}

static std::string encodeExpression(PythonContext& context, const nlohmann::ordered_json& expression, std::map<std::string, std::string>& environment, bool fixedpointContext, bool hornContext = false) {
    auto declareInteger = [&](const std::string& symbol, bool fixedpointVariable) {
        if (!context.declaredIntegers.contains(symbol)) {
            context.output << symbol << " = Int(" << nlohmann::ordered_json(symbol).dump() << ")\n";
            context.declaredIntegers.insert(symbol);
        }
        if (fixedpointVariable && !context.fixedpointVariables.contains(symbol)) {
            context.output << "fp.declare_var(" << symbol << ")\n";
            context.fixedpointVariables.insert(symbol);
        }
    };
    auto join = [](const std::vector<std::string>& expressions, const std::string& functionName, const std::string& emptyValue) {
        if (expressions.empty()) {
            return emptyValue;
        }
        if (expressions.size() == 1) {
            return expressions.front();
        }
        std::ostringstream result;
        result << functionName << "(";
        for (std::size_t i = 0; i < expressions.size(); ++i) {
            if (i != 0) {
                result << ", ";
            }
            result << expressions[i];
        }
        result << ")";
        return result.str();
    };
    if (expression.is_boolean()) {
        return expression.get<bool>() ? "BoolVal(True)" : "BoolVal(False)";
    }
    if (expression.is_number_integer()) {
        return "IntVal(" + std::to_string(expression.get<long long>()) + ")";
    }
    if (expression.is_number_unsigned()) {
        return "IntVal(" + std::to_string(expression.get<unsigned long long>()) + ")";
    }
    if (expression.is_string()) {
        const std::string value = expression.get<std::string>();
        if (value == "true") {
            return "BoolVal(True)";
        }
        if (value == "false") {
            return "BoolVal(False)";
        }
        const auto existing = environment.find(value);
        if (existing != environment.end()) {
            return existing->second;
        }
        if (context.declaredIntegers.contains(value)) {
            if (fixedpointContext && !context.fixedpointVariables.contains(value)) {
                context.output << "fp.declare_var(" << value << ")\n";
                context.fixedpointVariables.insert(value);
            }
            environment.emplace(value, value);
            return value;
        }
        const std::string inlineInteger = "Int(" + nlohmann::ordered_json(value).dump() + ")";
        if (fixedpointContext && !context.fixedpointVariables.contains(value)) {
            context.output << "fp.declare_var(" << inlineInteger << ")\n";
            context.fixedpointVariables.insert(value);
        }
        environment.emplace(value, inlineInteger);
        return inlineInteger;
    }
    if (!expression.is_object() || !expression.contains("op") || !expression.at("op").is_string()) {
        throw std::runtime_error("Unsupported expression AST: " + expression.dump());
    }
    const std::string op = expression.at("op").get<std::string>();
    if (op == "relation_call") {
        if (!expression.contains("relation") || !expression.at("relation").is_string()) {
            throw std::runtime_error("relation_call is missing relation.");
        }
        const std::string relationId = expression.at("relation").get<std::string>();
        const auto relation = context.relations.find(relationId);
        if (relation == context.relations.end()) {
            throw std::runtime_error("Unknown relation '" + relationId + "'.");
        }
        std::vector<std::string> arguments;
        auto appendArray = [&](const nlohmann::ordered_json& values) {
            if (!values.is_array()) {
                throw std::runtime_error("Relation argument group must be an array.");
            }
            for (const auto& value : values) {
                arguments.push_back(encodeExpression(context, value, environment, fixedpointContext, false));
            }
        };
        if (expression.contains("source_state")) {
            appendArray(expression.at("source_state"));
        }
        else if (expression.contains("input_state")) {
            appendArray(expression.at("input_state"));
            if (expression.contains("output_state")) {
                appendArray(expression.at("output_state"));
            }
        }
        else if (expression.contains("arguments") && expression.at("arguments").is_object()) {
            const nlohmann::ordered_json& groupedArguments = expression.at("arguments");
            for (const char* field : {"state", "current_state", "next_state", "output_state"}) {
                if (groupedArguments.contains(field)) {
                    appendArray(groupedArguments.at(field));
                }
            }
        }
        else {
            throw std::runtime_error("Relation call has no recognized argument fields.");
        }

        if (arguments.size() != relation->second) {
            throw std::runtime_error("Relation '" + relationId + "' expects " + std::to_string(relation->second) + " arguments but received " + std::to_string(arguments.size()) + ".");
        }
        std::ostringstream result;
        result << relationId << "(";
        for (std::size_t i = 0; i < arguments.size(); ++i) {
            if (i != 0) {
                result << ", ";
            }
            result << arguments[i];
        }
        result << ")";
        return result.str();
    }
    if (op == "exists") {
        if (!expression.contains("variables") || !expression.at("variables").is_array() || !expression.contains("body")) {
            throw std::runtime_error("exists requires variables and body.");
        }
        std::map<std::string, std::string> nestedEnvironment = environment;
        std::vector<std::string> quantifiedVariables;
        for (const auto& variable : expression.at("variables")) {
            if (!variable.is_string()) {
                throw std::runtime_error("exists variable must be a string.");
            }
            const std::string variableName = variable.get<std::string>();
            nestedEnvironment.erase(variableName);
            declareInteger(variableName, fixedpointContext && hornContext);
            nestedEnvironment.emplace(variableName, variableName);
            quantifiedVariables.push_back(variableName);
        }
        const std::string body = encodeExpression(context, expression.at("body"), nestedEnvironment, fixedpointContext, hornContext);
        if (hornContext) {
            return body;
        }
        std::ostringstream result;
        result << "Exists([";
        for (std::size_t i = 0; i < quantifiedVariables.size(); ++i) {
            if (i != 0) {
                result << ", ";
            }
            result << quantifiedVariables[i];
        }
        result << "], " << body << ")";
        return result.str();
    }
    if (!expression.contains("args") || !expression.at("args").is_array()) {
        throw std::runtime_error("Operator '" + op + "' requires an args array.");
    }
    const nlohmann::ordered_json& rawArguments = expression.at("args");
    std::vector<std::string> arguments;
    for (const auto& argument : rawArguments) {
        arguments.push_back(encodeExpression(context, argument, environment, fixedpointContext, hornContext));
    }
    auto requireArity = [&](std::size_t requiredArity) {
        if (arguments.size() != requiredArity) {
            throw std::runtime_error("Operator '" + op + "' requires " + std::to_string(requiredArity) + " arguments.");
        }
    };
    if (op == "and") {
        if (arguments.size() < 2) {
            throw std::runtime_error("and requires at least two arguments.");
        }
        return join(arguments, "And", "BoolVal(True)");
    }
    if (op == "or") {
        if (arguments.size() < 2) {
            throw std::runtime_error("or requires at least two arguments.");
        }
        return join(arguments, "Or", "BoolVal(False)");
    }
    if (op == "not") {
        requireArity(1);
        return "Not(" + arguments[0] + ")";
    }
    if (op == "implies") {
        requireArity(2);
        return "Implies(" + arguments[0] + ", " + arguments[1] + ")";
    }
    if (op == "iff") {
        requireArity(2);
        return "(" + arguments[0] + " == " + arguments[1] + ")";
    }
    if (op == "ite") {
        requireArity(3);
        return "If(" + arguments[0] + ", " + arguments[1] + ", " + arguments[2] + ")";
    }
    if (op == "=" || op == "!=" || op == "<" || op == "<=" || op == ">" || op == ">=") {
        requireArity(2);
        return "(" + arguments[0] + " " + (op == "=" ? "==" : op) + " " + arguments[1] + ")";
    }
    if (op == "+" || op == "*") {
        if (arguments.size() < 2) {
            throw std::runtime_error("Operator '" + op + "' requires at least two arguments.");
        }
        const std::string separator = op == "+" ? " + " : " * ";
        std::string result = "(" + arguments[0] + separator + arguments[1] + ")";
        for (std::size_t i = 2; i < arguments.size(); ++i) {
            result = "(" + result + separator + arguments[i] + ")";
        }
        return result;
    }
    if (op == "-") {
        requireArity(2);
        return "(" + arguments[0] + " - " + arguments[1] + ")";
    }
    if (op == "neg") {
        requireArity(1);
        return "(-" + arguments[0] + ")";
    }
    if (op == "div") {
        requireArity(2);
        return "(" + arguments[0] + " / " + arguments[1] + ")";
    }
    if (op == "mod") {
        requireArity(2);
        return "(" + arguments[0] + " % " + arguments[1] + ")";
    }
    if (op == "abs") {
        requireArity(1);
        return "If(" + arguments[0] + " >= 0, " + arguments[0] + ", -" + arguments[0] + ")";
    }
    if (op == "min" || op == "max") {
        if (arguments.size() < 2) {
            throw std::runtime_error("Operator '" + op + "' requires at least two arguments.");
        }
        std::string result = arguments.front();
        for (std::size_t i = 1; i < arguments.size(); ++i) {
            if (op == "min") {
                result = "If(" + result + " <= " + arguments[i] + ", " + result + ", " + arguments[i] + ")";
            }
            else {
                result = "If(" + result + " >= " + arguments[i] + ", " + result + ", " + arguments[i] + ")";
            }
        }
        return result;
    }
    if (op == "pow") {
        if (rawArguments.size() != 2 || !(rawArguments.at(1).is_number_integer() || rawArguments.at(1).is_number_unsigned())) {
            throw std::runtime_error("pow requires a fixed non-negative integer exponent.");
        }
        long long exponent = rawArguments.at(1).is_number_unsigned() ? static_cast<long long>(rawArguments.at(1).get<unsigned long long>()) : rawArguments.at(1).get<long long>();
        if (exponent < 0) {
            throw std::runtime_error("pow requires a non-negative exponent.");
        }
        const std::string base = arguments.at(0);
        std::string result = "IntVal(1)";
        for (long long i = 0; i < exponent; ++i) {
            result = "(" + result + " * " + base + ")";
        }
        return result;
    }
    if (op == "lex") {
        throw std::runtime_error("lex is a ranking constructor and cannot be used as a scalar expression.");
    }
    if (op == "u<" || op == "u<=" || op == "u>" || op == "u>=" || op == "bvand" || op == "bvor" || op == "bvxor" || op == "bvshl" || op == "bvlshr" || op == "bvashr") {
        throw std::runtime_error("Operator '" + op + "' requires bit-vector validation and is not soundly supported by the mathematical-integer validator.");
    }
    throw std::runtime_error("Unsupported operator '" + op + "'.");
}

static void generateGuard(PythonContext& context, const nlohmann::ordered_json& loopInformation) {
    const nlohmann::ordered_json& guard = loopInformation.at("loop_guard");
    if (!guard.is_object() || !guard.contains("id") || !guard.at("id").is_string() || !guard.contains("formula")) {
        throw std::runtime_error("Malformed loop_guard object.");
    }
    std::map<std::string, std::string> environment;
    populateSymbolEnvironment(loopInformation, environment);
    const std::string guardId = guard.at("id").get<std::string>();
    const std::string formula = encodeExpression(context, guard.at("formula"), environment, true, false);
    context.output << "# Guard\n" << guardId << " = " << formula << "\n\n";
}

static void generateEntryStates(PythonContext& context, const nlohmann::ordered_json& loopInformation) {
    const nlohmann::ordered_json& relationObject = loopInformation.at("entry_states");
    const std::string relationId = relationObject.at("id").get<std::string>();
    context.output << "# Entry states\n";
    if (!relationObject.contains("paths") || !relationObject.at("paths").is_array()) {
        context.output << "\n";
        return;
    }
    const std::vector<std::string> currentVariables = getStateSymbolNames(loopInformation, "current");
    const nlohmann::ordered_json& paths = relationObject.at("paths");
    for (std::size_t pathIndex = 0; pathIndex < paths.size(); ++pathIndex) {
        const nlohmann::ordered_json& path = paths.at(pathIndex);
        const std::string pathId = path.contains("id") && path.at("id").is_string() ? path.at("id").get<std::string>() : relationId + "_p" + std::to_string(pathIndex + 1);
        std::map<std::string, std::string> environment;
        populateSymbolEnvironment(loopInformation, environment);
        std::vector<std::string> conjuncts;
        if (path.contains("condition") && !path.at("condition").is_null()) {
            conjuncts.push_back(encodeExpression(context, path.at("condition"), environment, true, false));
        }
        if (path.contains("source_call") && !path.at("source_call").is_null()) {
            nlohmann::ordered_json call = path.at("source_call");
            call["op"] = "relation_call";
            conjuncts.push_back(encodeExpression(context, call, environment, true, false));
        }
        if (path.contains("child_calls") && path.at("child_calls").is_array()) {
            for (const auto& childCall : path.at("child_calls")) {
                nlohmann::ordered_json call = childCall;
                call["op"] = "relation_call";
                conjuncts.push_back(encodeExpression(context, call, environment, true, false));
            }
        }
        const nlohmann::ordered_json updates = path.contains("updates") && path.at("updates").is_object() ? path.at("updates") : nlohmann::ordered_json::object();
        for (const std::string& current : currentVariables) {
            const nlohmann::ordered_json rhs = updates.contains(current) ? updates.at(current) : nlohmann::ordered_json(current);
            conjuncts.push_back("(" + current + " == " + encodeExpression(context, rhs, environment, true, false) + ")");
        }
        std::string body = "BoolVal(True)";
        if (conjuncts.size() == 1) {
            body = conjuncts.front();
        }
        else if (!conjuncts.empty()) {
            std::ostringstream conjunction;
            conjunction << "And(";
            for (std::size_t i = 0; i < conjuncts.size(); ++i) {
                if (i != 0) {
                    conjunction << ", ";
                }
                conjunction << conjuncts[i];
            }
            conjunction << ")";
            body = conjunction.str();
        }
        context.output << pathId << " = " << body << "\n" << "fp.rule(" << relationId << "(";
        for (std::size_t i = 0; i < currentVariables.size(); ++i) {
            if (i != 0) {
                context.output << ", ";
            }
            context.output << currentVariables[i];
        }
        context.output << "), " << pathId << ", name=" << nlohmann::ordered_json(pathId).dump() << ")\n\n";
    }
}

static void generateLoopIterationSteps(PythonContext& context, const nlohmann::ordered_json& loopInformation) {
    const nlohmann::ordered_json& relationObject = loopInformation.at("loop_iteration_steps");
    const std::string relationId = relationObject.at("id").get<std::string>();
    context.output << "# Iteration steps\n";
    if (!relationObject.contains("paths") || !relationObject.at("paths").is_array()) {
        context.output << "\n";
        return;
    }
    const std::vector<std::string> currentVariables = getStateSymbolNames(loopInformation, "current");
    const std::vector<std::string> nextVariables = getStateSymbolNames(loopInformation, "next");
    const nlohmann::ordered_json& paths = relationObject.at("paths");
    for (std::size_t pathIndex = 0; pathIndex < paths.size(); ++pathIndex) {
        const nlohmann::ordered_json& path = paths.at(pathIndex);
        const std::string pathId = path.contains("id") && path.at("id").is_string() ? path.at("id").get<std::string>() : relationId + "_p" + std::to_string(pathIndex + 1);
        std::map<std::string, std::string> environment;
        populateSymbolEnvironment(loopInformation, environment);
        std::vector<std::string> conjuncts;
        if (path.contains("condition") && !path.at("condition").is_null()) {
            conjuncts.push_back(encodeExpression(context, path.at("condition"), environment, true, false));
        }
        if (path.contains("source_call") && !path.at("source_call").is_null()) {
            nlohmann::ordered_json call = path.at("source_call");
            call["op"] = "relation_call";
            conjuncts.push_back(encodeExpression(context, call, environment, true, false));
        }
        if (path.contains("child_calls") && path.at("child_calls").is_array()) {
            for (const auto& childCall : path.at("child_calls")) {
                nlohmann::ordered_json call = childCall;
                call["op"] = "relation_call";
                conjuncts.push_back(encodeExpression(context, call, environment, true, false));
            }
        }
        const nlohmann::ordered_json updates = path.contains("updates") && path.at("updates").is_object() ? path.at("updates") : nlohmann::ordered_json::object();
        for (std::size_t i = 0; i < currentVariables.size(); ++i) {
            const std::string& current = currentVariables.at(i);
            const std::string& next = nextVariables.at(i);
            const nlohmann::ordered_json rhs = updates.contains(next) ? updates.at(next) : nlohmann::ordered_json(current);
            conjuncts.push_back("(" + next + " == " + encodeExpression(context, rhs, environment, true, false) + ")");
        }
        std::string body = "BoolVal(True)";
        if (conjuncts.size() == 1) {
            body = conjuncts.front();
        }
        else if (!conjuncts.empty()) {
            std::ostringstream conjunction;
            conjunction << "And(";
            for (std::size_t i = 0; i < conjuncts.size(); ++i) {
                if (i != 0) {
                    conjunction << ", ";
                }
                conjunction << conjuncts[i];
            }
            conjunction << ")";
            body = conjunction.str();
        }
        context.output << pathId << " = " << body << "\n" << "fp.rule(" << relationId << "(";
        bool first = true;
        for (const std::string& current : currentVariables) {
            if (!first) {
                context.output << ", ";
            }
            context.output << current;
            first = false;
        }
        for (const std::string& next : nextVariables) {
            if (!first) {
                context.output << ", ";
            }
            context.output << next;
            first = false;
        }
        context.output << "), " << pathId << ", name=" << nlohmann::ordered_json(pathId).dump() << ")\n\n";
    }
}

static void generateLoopExitSteps(PythonContext& context, const nlohmann::ordered_json& loopInformation) {
    const nlohmann::ordered_json& relationObject = loopInformation.at("loop_exit_steps");
    const std::string relationId = relationObject.at("id").get<std::string>();
    context.output << "# Exit steps\n";
    if (!relationObject.contains("paths") || !relationObject.at("paths").is_array()) {
        context.output << "\n";
        return;
    }
    const std::vector<std::string> currentVariables = getStateSymbolNames(loopInformation, "current");
    const std::vector<std::string> outputVariables = getStateSymbolNames(loopInformation, "output");
    const nlohmann::ordered_json& paths = relationObject.at("paths");
    for (std::size_t pathIndex = 0; pathIndex < paths.size(); ++pathIndex) {
        const nlohmann::ordered_json& path = paths.at(pathIndex);
        const std::string pathId = path.contains("id") && path.at("id").is_string() ? path.at("id").get<std::string>() : relationId + "_p" + std::to_string(pathIndex + 1);
        std::map<std::string, std::string> environment;
        populateSymbolEnvironment(loopInformation, environment);
        std::vector<std::string> conjuncts;
        if (path.contains("condition") && !path.at("condition").is_null()) {
            conjuncts.push_back(encodeExpression(context, path.at("condition"), environment, true, false));
        }
        if (path.contains("source_call") && !path.at("source_call").is_null()) {
            nlohmann::ordered_json call = path.at("source_call");
            call["op"] = "relation_call";
            conjuncts.push_back(encodeExpression(context, call, environment, true, false));
        }
        if (path.contains("child_calls") && path.at("child_calls").is_array()) {
            for (const auto& childCall : path.at("child_calls")) {
                nlohmann::ordered_json call = childCall;
                call["op"] = "relation_call";
                conjuncts.push_back(encodeExpression(context, call, environment, true, false));
            }
        }
        const nlohmann::ordered_json updates = path.contains("updates") && path.at("updates").is_object() ? path.at("updates") : nlohmann::ordered_json::object();
        for (std::size_t i = 0; i < currentVariables.size(); ++i) {
            const std::string& current = currentVariables.at(i);
            const std::string& output = outputVariables.at(i);
            const nlohmann::ordered_json rhs = updates.contains(output) ? updates.at(output) : nlohmann::ordered_json(current);
            conjuncts.push_back("(" + output + " == " + encodeExpression(context, rhs, environment, true, false) + ")");
        }
        std::string body = "BoolVal(True)";
        if (conjuncts.size() == 1) {
            body = conjuncts.front();
        }
        else if (!conjuncts.empty()) {
            std::ostringstream conjunction;
            conjunction << "And(";
            for (std::size_t i = 0; i < conjuncts.size(); ++i) {
                if (i != 0) {
                    conjunction << ", ";
                }
                conjunction << conjuncts[i];
            }
            conjunction << ")";
            body = conjunction.str();
        }
        context.output << pathId << " = " << body << "\n" << "fp.rule(" << relationId << "(";
        bool first = true;
        for (const std::string& current : currentVariables) {
            if (!first) {
                context.output << ", ";
            }
            context.output << current;
            first = false;
        }
        for (const std::string& output : outputVariables) {
            if (!first) {
                context.output << ", ";
            }
            context.output << output;
            first = false;
        }
        context.output << "), " << pathId << ", name=" << nlohmann::ordered_json(pathId).dump() << ")\n\n";
    }
}

static void generateFunctionReturnSteps(PythonContext& context, const nlohmann::ordered_json& loopInformation) {
    const nlohmann::ordered_json& relationObject = loopInformation.at("loop_return_steps");
    const std::string relationId = relationObject.at("id").get<std::string>();
    context.output << "# Return steps\n";
    if (!relationObject.contains("paths") || !relationObject.at("paths").is_array()) {
        context.output << "\n";
        return;
    }
    const std::vector<std::string> currentVariables = getStateSymbolNames(loopInformation, "current");
    const nlohmann::ordered_json& paths = relationObject.at("paths");
    for (std::size_t pathIndex = 0; pathIndex < paths.size(); ++pathIndex) {
        const nlohmann::ordered_json& path = paths.at(pathIndex);
        const std::string pathId = path.contains("id") && path.at("id").is_string() ? path.at("id").get<std::string>() : relationId + "_p" + std::to_string(pathIndex + 1);
        std::map<std::string, std::string> environment;
        populateSymbolEnvironment(loopInformation, environment);
        std::vector<std::string> conjuncts;
        if (path.contains("condition") && !path.at("condition").is_null()) {
            conjuncts.push_back(encodeExpression(context, path.at("condition"), environment, true, false));
        }
        if (path.contains("source_call") && !path.at("source_call").is_null()) {
            nlohmann::ordered_json call = path.at("source_call");
            call["op"] = "relation_call";
            conjuncts.push_back(encodeExpression(context, call, environment, true, false));
        }
        if (path.contains("child_calls") && path.at("child_calls").is_array()) {
            for (const auto& childCall : path.at("child_calls")) {
                nlohmann::ordered_json call = childCall;
                call["op"] = "relation_call";
                conjuncts.push_back(encodeExpression(context, call, environment, true, false));
            }
        }
        std::string body = "BoolVal(True)";
        if (conjuncts.size() == 1) {
            body = conjuncts.front();
        }
        else if (!conjuncts.empty()) {
            std::ostringstream conjunction;
            conjunction << "And(";
            for (std::size_t i = 0; i < conjuncts.size(); ++i) {
                if (i != 0) {
                    conjunction << ", ";
                }
                conjunction << conjuncts[i];
            }
            conjunction << ")";
            body = conjunction.str();
        }
        context.output << pathId << " = " << body << "\n" << "fp.rule(" << relationId << "(";
        for (std::size_t i = 0; i < currentVariables.size(); ++i) {
            if (i != 0) {
                context.output << ", ";
            }
            context.output << currentVariables[i];
        }
        context.output << "), " << pathId << ", name=" << nlohmann::ordered_json(pathId).dump() << ")\n\n";
    }
}

static void generateDerivedHornRules(PythonContext& context, const nlohmann::ordered_json& loopInformation, const std::string& field, const std::string& sectionTitle, std::size_t expectedRuleCount) {
    const nlohmann::ordered_json& relationObject = loopInformation.at(field);
    const std::string relationId = relationObject.at("id").get<std::string>();
    context.output << "# " << sectionTitle << "\n";
    if (!relationObject.contains("rules") || !relationObject.at("rules").is_array()) {
        throw std::runtime_error("Derived relation '" + relationId + "' is missing rules.");
    }
    const nlohmann::ordered_json& rules = relationObject.at("rules");
    if (rules.size() != expectedRuleCount) {
        throw std::runtime_error("Derived relation '" + relationId + "' must contain exactly " + std::to_string(expectedRuleCount) + " rule(s).");
    }
    for (std::size_t i = 0; i < rules.size(); ++i) {
        const nlohmann::ordered_json& rule = rules.at(i);
        if (!rule.is_object() || !rule.contains("id") || !rule.at("id").is_string() || !rule.contains("head") || !rule.contains("body")) {
            throw std::runtime_error("Malformed Horn rule in derived relation '" + relationId + "'.");
        }
        const std::string expectedRuleId = expectedRuleCount == 1 ? relationId + "_rule" : (i == 0 ? relationId + "_base" : relationId + "_recursive");
        const std::string ruleId = rule.at("id").get<std::string>();
        if (ruleId != expectedRuleId) {
            throw std::runtime_error("Derived relation '" + relationId + "' has rule id '" + ruleId + "' but expected '" + expectedRuleId + "'.");
        }
        std::map<std::string, std::string> environment;
        populateSymbolEnvironment(loopInformation, environment);
        const std::string body = encodeExpression(context, rule.at("body"), environment, true, true);
        const std::string head = encodeExpression(context, rule.at("head"), environment, true, true);
        context.output << ruleId << " = " << body << "\n" << "fp.rule(" << head << ", " << ruleId << ", name=" << nlohmann::ordered_json(ruleId).dump() << ")\n\n";
    }
}

static void generateReachableHeaderStates(PythonContext& context, const nlohmann::ordered_json& loopInformation) {
    generateDerivedHornRules(context, loopInformation, "reachable_header_states", "Reachable header states", 2);
}

static void generateHeaderToExit(PythonContext& context, const nlohmann::ordered_json& loopInformation) {
    generateDerivedHornRules(context, loopInformation, "header_to_exit", "Header to exit", 2);
}

static void generateHeaderToReturn(PythonContext& context, const nlohmann::ordered_json& loopInformation) {
    generateDerivedHornRules(context, loopInformation, "header_to_return", "Header to return", 2);
}

static void generateActualExit(PythonContext& context, const nlohmann::ordered_json& loopInformation) {
    generateDerivedHornRules(context, loopInformation, "actual_exit", "Actual exit", 1);
}

static CandidateInformation generateCandidate(PythonContext& context, const nlohmann::ordered_json& candidate, const nlohmann::ordered_json& targetLoop) {
    const std::string targetLoopId = targetLoop.at("loop_id").get<std::string>();
    const std::string candidateKind = candidate.at("candidate_kind").get<std::string>();
    context.output << "# ============================================================\n"
                   << "# Target candidate: " << targetLoopId << " (" << candidateKind << ")\n"
                   << "# ============================================================\n\n";
    CandidateInformation candidateInformation;
    candidateInformation.kind = candidateKind;
    std::map<std::string, std::string> currentEnvironment;
    std::map<std::string, std::string> nextEnvironment;
    for (const auto& stateSymbol : getStateSymbols(targetLoop)) {
        const std::string current = stateSymbol.at("current").get<std::string>();
        const std::string next = stateSymbol.at("next").get<std::string>();
        currentEnvironment.emplace(current, current);
        nextEnvironment.emplace(current, next);
    }
    const auto findExpression = [&](const std::string& expressionKind) -> const nlohmann::ordered_json* {
        for (const auto& candidateExpression : candidate.at("candidate_expressions")) {
            if (candidateExpression.is_object() && candidateExpression.contains("expression_kind") && candidateExpression.at("expression_kind").is_string() && candidateExpression.contains("expression_ast") && candidateExpression.at("expression_kind").get<std::string>() == expressionKind) {
                return &candidateExpression.at("expression_ast");
            }
        }
        return nullptr;
    };
    if (candidateKind == "terminating") {
        const nlohmann::ordered_json* invariant = findExpression("invariant");
        const nlohmann::ordered_json* rankingFunction = findExpression("ranking-function");
        if (!invariant || !rankingFunction) {
            throw std::runtime_error("Terminating candidate must contain invariant and ranking-function expressions.");
        }
        std::map<std::string, std::string> currentInvariantEnvironment = currentEnvironment;
        std::map<std::string, std::string> nextInvariantEnvironment = nextEnvironment;
        context.output << targetLoopId << "_invariant = " << encodeExpression(context, *invariant, currentInvariantEnvironment, false, false) << "\n" << targetLoopId << "_invariant_next = " << encodeExpression(context, *invariant, nextInvariantEnvironment, false, false) << "\n\n";
        std::vector<nlohmann::ordered_json> rankingComponents;
        if (rankingFunction->is_object() && rankingFunction->contains("op") && rankingFunction->at("op").is_string() &&
            rankingFunction->at("op").get<std::string>() == "lex") {
            if (!rankingFunction->contains("args") || !rankingFunction->at("args").is_array() || rankingFunction->at("args").empty()) {
                throw std::runtime_error("lex ranking expression requires at least one component.");
            }
            for (const auto& component : rankingFunction->at("args")) {
                rankingComponents.push_back(component);
            }
        }
        else {
            rankingComponents.push_back(*rankingFunction);
        }
        candidateInformation.rankingComponents = rankingComponents.size();
        std::vector<std::string> currentRanking;
        std::vector<std::string> nextRanking;
        for (const nlohmann::ordered_json& component : rankingComponents) {
            std::map<std::string, std::string> currentRankingEnvironment = currentEnvironment;
            std::map<std::string, std::string> nextRankingEnvironment = nextEnvironment;
            currentRanking.push_back(encodeExpression(context, component, currentRankingEnvironment, false, false));
            nextRanking.push_back(encodeExpression(context, component, nextRankingEnvironment, false, false));
        }
        context.output << targetLoopId << "_ranking_function = [";
        for (std::size_t i = 0; i < currentRanking.size(); ++i) {
            if (i != 0) {
                context.output << ", ";
            }
            context.output << currentRanking[i];
        }
        context.output << "]\n";
        context.output << targetLoopId << "_ranking_function_next = [";
        for (std::size_t i = 0; i < nextRanking.size(); ++i) {
            if (i != 0) {
                context.output << ", ";
            }
            context.output << nextRanking[i];
        }
        context.output << "]\n\n";
    }
    else if (candidateKind == "non-terminating") {
        const nlohmann::ordered_json* recurrentSet = findExpression("recurrent-set");
        if (!recurrentSet) {
            throw std::runtime_error("Non-terminating candidate must contain a recurrent-set expression.");
        }
        std::map<std::string, std::string> currentRecurrentEnvironment = currentEnvironment;
        std::map<std::string, std::string> nextRecurrentEnvironment = nextEnvironment;
        context.output << targetLoopId << "_recurrent_set = " << encodeExpression(context, *recurrentSet, currentRecurrentEnvironment, false, false) << "\n" << targetLoopId << "_recurrent_set_next = " << encodeExpression(context, *recurrentSet, nextRecurrentEnvironment, false, false) << "\n\n";
    }
    else if (candidateKind != "unknown") {
        throw std::runtime_error("Unsupported candidate_kind '" + candidateKind + "'.");
    }
    return candidateInformation;
}

static void generateTerminationValidation(PythonContext& context, const nlohmann::ordered_json& targetLoop, std::size_t rankingComponents) {
    if (rankingComponents == 0) {
        throw std::runtime_error("Ranking function has no components.");
    }
    const std::string targetLoopId = targetLoop.at("loop_id").get<std::string>();
    const std::string entryStates = targetLoop.at("entry_states").at("id").get<std::string>();
    const std::string iterationSteps = targetLoop.at("loop_iteration_steps").at("id").get<std::string>();
    const std::string guard = targetLoop.at("loop_guard").at("id").get<std::string>();
    const std::vector<std::string> current = getStateSymbolNames(targetLoop, "current");
    const std::vector<std::string> next = getStateSymbolNames(targetLoop, "next");
    auto relationCall = [](const std::string& relation, const std::vector<std::string>& arguments) {
        std::ostringstream result;
        result << relation << "(";
        for (std::size_t i = 0; i < arguments.size(); ++i) {
            if (i != 0) {
                result << ", ";
            }
            result << arguments[i];
        }
        result << ")";
        return result.str();
    };
    auto join = [](const std::vector<std::string>& expressions, const std::string& functionName, const std::string& emptyValue) {
        if (expressions.empty()) {
            return emptyValue;
        }
        if (expressions.size() == 1) {
            return expressions.front();
        }
        std::ostringstream result;
        result << functionName << "(";
        for (std::size_t i = 0; i < expressions.size(); ++i) {
            if (i != 0) {
                result << ", ";
            }
            result << expressions[i];
        }
        result << ")";
        return result.str();
    };
    auto registerBooleanQuery = [&](const std::string& relationName, const std::string& body) {
        context.output << relationName << " = Function(" << nlohmann::ordered_json(relationName).dump() << ", BoolSort())\n" << "fp.register_relation(" << relationName << ")\n" << "fp.rule(" << relationName << "(), " << body << ", name=" << nlohmann::ordered_json(relationName + "_rule").dump() << ")\n\n";
    };
    context.output << "# ============================================================\n"
                   << "# Termination validation\n"
                   << "# ============================================================\n\n";
    const std::string badInitialization = targetLoopId + "_bad_invariant_initialization";
    registerBooleanQuery(badInitialization, "And(" + relationCall(entryStates, current) + ", Not(" + targetLoopId + "_invariant))");
    std::vector<std::string> currentNext = current;
    currentNext.insert(currentNext.end(), next.begin(), next.end());
    const std::string badPreservation = targetLoopId + "_bad_invariant_preservation";
    registerBooleanQuery(badPreservation, "And(" + targetLoopId + "_invariant, " + guard + ", " + relationCall(iterationSteps, currentNext) + ", Not(" + targetLoopId + "_invariant_next))");
    std::vector<std::string> negativeComponents;
    for (std::size_t i = 0; i < rankingComponents; ++i) {
        negativeComponents.push_back(targetLoopId + "_ranking_function[" + std::to_string(i) + "] < 0");
    }
    context.output << targetLoopId << "_ranking_nonnegativity_solver = Solver()\n" << targetLoopId << "_ranking_nonnegativity_solver.add(" << targetLoopId << "_invariant, " << guard << ", " << join(negativeComponents, "Or", "BoolVal(False)") << ")\n\n";
    std::vector<std::string> lexicographicAlternatives;
    std::vector<std::string> equalPrefix;
    for (std::size_t i = 0; i < rankingComponents; ++i) {
        std::vector<std::string> conjuncts = equalPrefix;
        conjuncts.push_back(targetLoopId + "_ranking_function_next[" + std::to_string(i) + "] < " + targetLoopId + "_ranking_function[" + std::to_string(i) + "]");
        lexicographicAlternatives.push_back(join(conjuncts, "And", "BoolVal(True)"));
        equalPrefix.push_back(targetLoopId + "_ranking_function_next[" + std::to_string(i) + "] == " + targetLoopId + "_ranking_function[" + std::to_string(i) + "]");
    }
    std::vector<std::string> iterationPathIds;
    const nlohmann::ordered_json& iterationRelation = targetLoop.at("loop_iteration_steps");
    if (iterationRelation.contains("paths") && iterationRelation.at("paths").is_array()) {
        const nlohmann::ordered_json& paths = iterationRelation.at("paths");
        for (std::size_t pathIndex = 0; pathIndex < paths.size(); ++pathIndex) {
            const nlohmann::ordered_json& path = paths.at(pathIndex);
            const std::string pathId = path.contains("id") && path.at("id").is_string() ? path.at("id").get<std::string>() : iterationSteps + "_p" + std::to_string(pathIndex + 1);
            iterationPathIds.push_back(pathId);
        }
    }
    const std::string iterationFormula = join(iterationPathIds, "Or", "BoolVal(False)");
    context.output << targetLoopId << "_ranking_decrease_solver = Solver()\n" << targetLoopId << "_ranking_decrease_solver.add(" << targetLoopId << "_invariant, " << guard << ", " << iterationFormula << ", Not(" << join(lexicographicAlternatives, "Or", "BoolVal(False)") << "))\n\n";
    context.output << R"PY(def check_fixedpoint(name, relation, expected):
    result = fp.query(relation())
    print(f'{name}: "{result}"')
    if result != expected and result == sat:
        print(f'COUNTEREXAMPLE_BEGIN: "{name}"')
        try:
            print(fp.get_ground_sat_answer())
        except Exception:
            try:
                print(fp.get_answer())
            except Exception as ex:
                print(f'Could not extract Spacer counterexample: {ex}')
        print(f'COUNTEREXAMPLE_END: "{name}"')
    if result == unknown:
        print(f'DETAIL_BEGIN: "{name}"')
        try:
            print(fp.reason_unknown())
        except Exception as ex:
            print(f'Z3 returned unknown: {ex}')
        print(f'DETAIL_END: "{name}"')
    return result

def check_solver(name, solver, expected):
    result = solver.check()
    print(f'{name}: "{result}"')
    if result != expected and result == sat:
        print(f'COUNTEREXAMPLE_BEGIN: "{name}"')
        print(solver.model())
        print(f'COUNTEREXAMPLE_END: "{name}"')
    if result == unknown:
        print(f'DETAIL_BEGIN: "{name}"')
        print(solver.reason_unknown())
        print(f'DETAIL_END: "{name}"')
    return result

def validation_status(checks):
    saw_unknown = False
    for result, expected in checks:
        if result == unknown:
            saw_unknown = True
        elif result != expected:
            return "invalid"
    return "unknown" if saw_unknown else "valid"

)PY";
    context.output << targetLoopId << "_invariant_initialization_result = check_fixedpoint(\n"
                   << "    \"INVARIANT_INITIALIZATION\",\n"
                   << "    " << badInitialization << ",\n"
                   << "    unsat\n"
                   << ")\n\n"
                   << targetLoopId << "_invariant_preservation_result = check_fixedpoint(\n"
                   << "    \"INVARIANT_PRESERVATION\",\n"
                   << "    " << badPreservation << ",\n"
                   << "    unsat\n"
                   << ")\n\n"
                   << targetLoopId << "_ranking_nonnegativity_result = check_solver(\n"
                   << "    \"RANKING_NONNEGATIVITY\",\n"
                   << "    " << targetLoopId << "_ranking_nonnegativity_solver,\n"
                   << "    unsat\n"
                   << ")\n\n"
                   << targetLoopId << "_ranking_decrease_result = check_solver(\n"
                   << "    \"RANKING_DECREASE\",\n"
                   << "    " << targetLoopId << "_ranking_decrease_solver,\n"
                   << "    unsat\n"
                   << ")\n\n"
                   << "INVARIANT_RESULT = validation_status([\n"
                   << "    (" << targetLoopId << "_invariant_initialization_result, unsat),\n"
                   << "    (" << targetLoopId << "_invariant_preservation_result, unsat)\n"
                   << "])\n\n"
                   << "RANKING_FUNCTION_RESULT = validation_status([\n"
                   << "    (" << targetLoopId << "_ranking_nonnegativity_result, unsat),\n"
                   << "    (" << targetLoopId << "_ranking_decrease_result, unsat)\n"
                   << "])\n\n"
                   << "print()\n"
                   << "print(f'INVARIANT_RESULT: \"{INVARIANT_RESULT}\"')\n"
                   << "print(f'RANKING_FUNCTION_RESULT: \"{RANKING_FUNCTION_RESULT}\"')\n";
}

static void generateNonTerminationValidation(PythonContext& context, const nlohmann::ordered_json& targetLoop) {
    const std::string targetLoopId = targetLoop.at("loop_id").get<std::string>();
    const std::string reachableHeaderStates = targetLoop.at("reachable_header_states").at("id").get<std::string>();
    const std::string iterationSteps = targetLoop.at("loop_iteration_steps").at("id").get<std::string>();
    const std::string exitSteps = targetLoop.at("loop_exit_steps").at("id").get<std::string>();
    const std::string returnSteps = targetLoop.at("loop_return_steps").at("id").get<std::string>();
    const std::string guard = targetLoop.at("loop_guard").at("id").get<std::string>();
    const std::vector<std::string> current = getStateSymbolNames(targetLoop, "current");
    const std::vector<std::string> next = getStateSymbolNames(targetLoop, "next");
    const std::vector<std::string> output = getStateSymbolNames(targetLoop, "output");
    auto relationCall = [](const std::string& relation, const std::vector<std::string>& arguments) {
        std::ostringstream result;
        result << relation << "(";
        for (std::size_t i = 0; i < arguments.size(); ++i) {
            if (i != 0) {
                result << ", ";
            }
            result << arguments[i];
        }
        result << ")";
        return result.str();
    };
    auto registerBooleanQuery = [&](const std::string& relationName, const std::string& body) {
        context.output << relationName << " = Function(" << nlohmann::ordered_json(relationName).dump() << ", BoolSort())\n" << "fp.register_relation(" << relationName << ")\n" << "fp.rule(" << relationName << "(), " << body << ", name=" << nlohmann::ordered_json(relationName + "_rule").dump() << ")\n\n";
    };
    context.output << "# ============================================================\n"
                   << "# Non-termination validation\n"
                   << "# ============================================================\n\n";
    const std::string reachableRecurrentSet = targetLoopId + "_reachable_recurrent_set";
    registerBooleanQuery(reachableRecurrentSet, "And(" + relationCall(reachableHeaderStates, current) + ", " + targetLoopId + "_recurrent_set)");
    context.output << targetLoopId << "_recurrent_guard_solver = Solver()\n" << targetLoopId << "_recurrent_guard_solver.add(" << targetLoopId << "_recurrent_set, Not(" << guard << "))\n\n";
    std::vector<std::string> currentNext = current;
    currentNext.insert(currentNext.end(), next.begin(), next.end());
    const std::string badClosure = targetLoopId + "_bad_recurrent_closure";
    registerBooleanQuery(badClosure, "And(" + targetLoopId + "_recurrent_set, " + relationCall(iterationSteps, currentNext) + ", Not(" + targetLoopId + "_recurrent_set_next))");
    std::vector<std::string> currentOutput = current;
    currentOutput.insert(currentOutput.end(), output.begin(), output.end());
    const std::string badExit = targetLoopId + "_bad_recurrent_exit";
    registerBooleanQuery(badExit, "And(" + targetLoopId + "_recurrent_set, " + relationCall(exitSteps, currentOutput) + ")");
    const std::string badReturn = targetLoopId + "_bad_recurrent_return";
    registerBooleanQuery(badReturn, "And(" + targetLoopId + "_recurrent_set, " + relationCall(returnSteps, current) + ")");
    context.output << R"PY(def check_fixedpoint(name, relation, expected):
    result = fp.query(relation())
    print(f'{name}: "{result}"')
    if result != expected and result == sat:
        print(f'COUNTEREXAMPLE_BEGIN: "{name}"')
        try:
            print(fp.get_ground_sat_answer())
        except Exception:
            try:
                print(fp.get_answer())
            except Exception as ex:
                print(f'Could not extract Spacer counterexample: {ex}')
        print(f'COUNTEREXAMPLE_END: "{name}"')
    if result == unknown:
        print(f'DETAIL_BEGIN: "{name}"')
        try:
            print(fp.reason_unknown())
        except Exception as ex:
            print(f'Z3 returned unknown: {ex}')
        print(f'DETAIL_END: "{name}"')

    return result

def check_solver(name, solver, expected):
    result = solver.check()
    print(f'{name}: "{result}"')
    if result != expected and result == sat:
        print(f'COUNTEREXAMPLE_BEGIN: "{name}"')
        print(solver.model())
        print(f'COUNTEREXAMPLE_END: "{name}"')
    if result == unknown:
        print(f'DETAIL_BEGIN: "{name}"')
        print(solver.reason_unknown())
        print(f'DETAIL_END: "{name}"')
    return result

def validation_status(checks):
    saw_unknown = False
    for result, expected in checks:
        if result == unknown:
            saw_unknown = True
        elif result != expected:
            return "invalid"
    return "unknown" if saw_unknown else "valid"

)PY";
    context.output << targetLoopId << "_recurrent_reachability_result = check_fixedpoint(\n"
                   << "    \"RECURRENT_REACHABILITY\",\n"
                   << "    " << reachableRecurrentSet << ",\n"
                   << "    sat\n"
                   << ")\n\n"
                   << targetLoopId << "_recurrent_guard_result = check_solver(\n"
                   << "    \"RECURRENT_GUARD_CONTAINMENT\",\n"
                   << "    " << targetLoopId << "_recurrent_guard_solver,\n"
                   << "    unsat\n"
                   << ")\n\n"
                   << targetLoopId << "_recurrent_closure_result = check_fixedpoint(\n"
                   << "    \"RECURRENT_CLOSURE\",\n"
                   << "    " << badClosure << ",\n"
                   << "    unsat\n"
                   << ")\n\n"
                   << targetLoopId << "_recurrent_exit_result = check_fixedpoint(\n"
                   << "    \"RECURRENT_NO_NORMAL_EXIT\",\n"
                   << "    " << badExit << ",\n"
                   << "    unsat\n"
                   << ")\n\n"
                   << targetLoopId << "_recurrent_return_result = check_fixedpoint(\n"
                   << "    \"RECURRENT_NO_FUNCTION_RETURN\",\n"
                   << "    " << badReturn << ",\n"
                   << "    unsat\n"
                   << ")\n\n"
                   << "RECURRENT_SET_RESULT = validation_status([\n"
                   << "    (" << targetLoopId << "_recurrent_reachability_result, sat),\n"
                   << "    (" << targetLoopId << "_recurrent_guard_result, unsat),\n"
                   << "    (" << targetLoopId << "_recurrent_closure_result, unsat),\n"
                   << "    (" << targetLoopId << "_recurrent_exit_result, unsat),\n"
                   << "    (" << targetLoopId << "_recurrent_return_result, unsat)\n"
                   << "])\n\n"
                   << "print()\n"
                   << "print(f'RECURRENT_SET_RESULT: \"{RECURRENT_SET_RESULT}\"')\n";
}

bool ValidatorGenerator::generate(const std::string& loopId, const std::filesystem::path& loopInformationDirectory, const std::filesystem::path& candidatePath, const std::filesystem::path& validatorPath) {
    try {
        if (loopId.empty()) {
            throw std::runtime_error("loopId must not be empty.");
        }
        const std::map<std::string, nlohmann::ordered_json> loopInformationList = loadLoopInformation(loopInformationDirectory);
        if (!loopInformationList.contains(loopId)) {
            throw std::runtime_error("No loop information was found for target loop '" + loopId + "'.");
        }
        const std::map<std::string, std::set<std::string>> dependencyGraph = computeDependencyLoops(loopInformationList, loopId);
        const std::vector<std::string> orderedLoops = orderLoops(dependencyGraph, loopId);
        std::ifstream candidateStream(candidatePath);
        if (!candidateStream) {
            throw std::runtime_error("Could not open candidate JSON: " + candidatePath.string());
        }
        nlohmann::ordered_json candidate;
        candidateStream >> candidate;
        if (!candidate.is_object() || !candidate.contains("loop_id") || !candidate.at("loop_id").is_string() || candidate.at("loop_id").get<std::string>() != loopId) {
            throw std::runtime_error("Candidate loop_id does not match target loop '" + loopId + "'.");
        }
        if (!candidate.contains("candidate_kind") || !candidate.at("candidate_kind").is_string() || !candidate.contains("candidate_expressions") || !candidate.at("candidate_expressions").is_array()) {
            throw std::runtime_error("Candidate is missing candidate_kind or candidate_expressions.");
        }
        const std::string candidateKind = candidate.at("candidate_kind").get<std::string>();
        if (candidateKind != "terminating" && candidateKind != "non-terminating" && candidateKind != "unknown") {
            throw std::runtime_error("Unsupported candidate_kind '" + candidateKind + "'.");
        }
        if (!validatorPath.parent_path().empty()) {
            std::filesystem::create_directories(validatorPath.parent_path());
        }
        std::ofstream validatorStream(validatorPath);
        if (!validatorStream) {
            throw std::runtime_error("Could not create validator: " + validatorPath.string());
        }
        std::vector<std::string> unsupported;
        for (const std::string& currentLoopId : orderedLoops) {
            const nlohmann::ordered_json& loopInformation = loopInformationList.at(currentLoopId);
            if (!loopInformation.contains("unsupported") || !loopInformation.at("unsupported").is_array()) {
                throw std::runtime_error("Loop '" + currentLoopId + "' is missing unsupported array.");
            }
            for (const auto& value : loopInformation.at("unsupported")) {
                unsupported.push_back(
                    currentLoopId + ": " + (value.is_string() ? value.get<std::string>() : value.dump()));
            }
        }
        if (!unsupported.empty()) {
            std::ostringstream message;
            for (std::size_t i = 0; i < unsupported.size(); ++i) {
                if (i != 0) {
                    message << " | ";
                }
                message << unsupported[i];
            }
            validatorStream << "#!/usr/bin/env python3\n\n" << "print(" << nlohmann::ordered_json("UNSUPPORTED: \"" + message.str() + "\"").dump() << ")\n";
            if (candidateKind == "terminating") {
                validatorStream << "print('INVARIANT_RESULT: \"unknown\"')\n" << "print('RANKING_FUNCTION_RESULT: \"unknown\"')\n";
            }
            else if (candidateKind == "non-terminating") {
                validatorStream << "print('RECURRENT_SET_RESULT: \"unknown\"')\n";
            }
            return static_cast<bool>(validatorStream);
        }
        if (candidateKind == "unknown") {
            validatorStream << "#!/usr/bin/env python3\n\n";
            return static_cast<bool>(validatorStream);
        }
        PythonContext context;
        context.output << "#!/usr/bin/env python3\n\n"
                   << "from z3 import *\n\n"
                   << "fp = Fixedpoint()\n"
                   << "fp.set(engine=\"spacer\")\n\n"
                   << "# ============================================================\n"
                   << "# Variables\n"
                   << "# ============================================================\n\n";
        for (const std::string& currentLoopId : orderedLoops) {
            const nlohmann::ordered_json& loopInformation = loopInformationList.at(currentLoopId);
            generateSymbols(context, loopInformation);
        }
        generateRelationDeclarations(context, loopInformationList, orderedLoops);
        for (const std::string& currentLoopId : orderedLoops) {
            const nlohmann::ordered_json& loopInformation = loopInformationList.at(currentLoopId);
            context.output << "# ============================================================\n"
                           << "# " << (currentLoopId == loopId ? "Target loop: " : "Dependency loop: ") << currentLoopId << "\n"
                           << "# ============================================================\n\n";
            generateGuard(context, loopInformation);
            generateEntryStates(context, loopInformation);
            generateLoopIterationSteps(context, loopInformation);
            generateLoopExitSteps(context, loopInformation);
            generateFunctionReturnSteps(context, loopInformation);
            generateReachableHeaderStates(context, loopInformation);
            generateHeaderToExit(context, loopInformation);
            generateHeaderToReturn(context, loopInformation);
            generateActualExit(context, loopInformation);
        }
        const CandidateInformation candidateInformation = generateCandidate(context, candidate, loopInformationList.at(loopId));
        if (candidateInformation.kind == "terminating") {
            generateTerminationValidation(context, loopInformationList.at(loopId), candidateInformation.rankingComponents);
        }
        else {
            generateNonTerminationValidation(context, loopInformationList.at(loopId));
        }
        validatorStream << context.output.str();
        if (!validatorStream) {
            throw std::runtime_error("Could not write validator: " + validatorPath.string());
        }
        return true;
    }
    catch (const std::exception& ex) {
        std::cerr << "ValidatorGenerator::generate error: " << ex.what() << '\n';
        return false;
    }
}