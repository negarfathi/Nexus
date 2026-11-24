#include "../include/candidate_synthesizer.h"

struct Prompt {
    std::string mode;
    std::string input;
    std::string instructions;
};

struct Response {
    bool requestAttempted = false;
    std::string data;
    long long inputTokens = 0;
    long long outputTokens = 0;
    double latency = 0.0;
    double cost = 0.0;
};

struct RefinementFeedback {
    std::string current;
    std::string history;
};

class RequestTimeoutException : public std::runtime_error {
public:
    explicit RequestTimeoutException(const std::string& message)
        : std::runtime_error(message) {}
};

static std::map<std::string, nlohmann::json> loadLoopInformation(const std::filesystem::path& loopInformationDirectory) {
    std::map<std::string, nlohmann::json> loopInformationList;

    for (const auto& entry : std::filesystem::recursive_directory_iterator(loopInformationDirectory)) {
        if (!entry.is_regular_file()) {
            continue;
        }

        std::ifstream inputStream(entry.path());
        if (!inputStream) {
            throw std::runtime_error(std::string(strerror(errno)) + ": " + entry.path().string());
        }

        nlohmann::json loopInformation;
        inputStream >> loopInformation;

        const std::string loopId = loopInformation.at("loop_id").get<std::string>();

        loopInformationList.emplace(loopId, loopInformation);
    }

    return loopInformationList;
}

static std::vector<std::string> computeDependencyLoops(const std::map<std::string, nlohmann::json>& loopInformationList, const std::string& loopId) {
    std::vector<std::string> dependencyLoops;

    std::set<std::string> visitedLoops{loopId};

    std::function<void(const std::string&)> visit = [&](const std::string& id) {
        if (visitedLoops.contains(id)) {
            return;
        }

        visitedLoops.insert(id);
        dependencyLoops.push_back(id);

        const nlohmann::json& loopInformation = loopInformationList.at(id);

        if (loopInformation.contains("parent_loop_id") && loopInformation.at("parent_loop_id").is_string()) {
            visit(loopInformation.at("parent_loop_id").get<std::string>());
        }

        for (const char* field : {"child_loop_ids", "previous_sequential_loop_ids"}) {
            if (loopInformation.contains(field) && loopInformation.at(field).is_array()) {
                for (const auto& referencedLoop : loopInformation.at(field)) {
                    if (referencedLoop.is_string()) {
                        visit(referencedLoop.get<std::string>());
                    }
                }
            }
        }
    };

    const nlohmann::json& targetLoop = loopInformationList.at(loopId);

    if (targetLoop.contains("parent_loop_id") && targetLoop.at("parent_loop_id").is_string()) {
        visit(targetLoop.at("parent_loop_id").get<std::string>());
    }

    for (const char* field : {"child_loop_ids", "previous_sequential_loop_ids"}) {
        if (targetLoop.contains(field) && targetLoop.at(field).is_array()) {
            for (const auto& referencedLoop : targetLoop.at(field)) {
                if (referencedLoop.is_string()) {
                    visit(referencedLoop.get<std::string>());
                }
            }
        }
    }

    return dependencyLoops;
}

static nlohmann::json buildLoopBundle(const std::map<std::string, nlohmann::json>& loopInformationList, const std::string& loopId, const std::vector<std::string>& dependencyLoops) {
    nlohmann::json loopBundle = nlohmann::json::array();

    loopBundle.push_back({
        {"role", "target"},
        {"loop_id", loopId},
        {"information", loopInformationList.at(loopId)}
    });

    for (const auto& dependencyLoop : dependencyLoops) {
        loopBundle.push_back({
            {"role", "dependency"},
            {"loop_id", dependencyLoop},
            {"information", loopInformationList.at(dependencyLoop)}
        });
    }

    return loopBundle;
}

static std::vector<std::string> getLoopSymbols(const nlohmann::json& loopBundle) {
    for (const auto& loopEntry : loopBundle) {
        if (!loopEntry.is_object() || !loopEntry.contains("role") || !loopEntry.at("role").is_string() || loopEntry.at("role").get<std::string>() != "target") {
            continue;
        }

        if (!loopEntry.contains("information") || !loopEntry.at("information").is_object()) {
            throw std::runtime_error("Target loop bundle entry has no valid information object.");
        }

        const nlohmann::json& loopInformation = loopEntry.at("information");
        if (!loopInformation.contains("state_symbols") || !loopInformation.at("state_symbols").is_array()) {
            throw std::runtime_error("Target loop information has no valid state_symbols array.");
        }

        std::vector<std::string> loopSymbols;
        for (const auto& stateSymbol : loopInformation.at("state_symbols")) {
            if (!stateSymbol.is_object() || !stateSymbol.contains("current") || !stateSymbol.at("current").is_string()) {
                throw std::runtime_error("Target loop contains a malformed state_symbols entry.");
            }
            loopSymbols.push_back(stateSymbol.at("current").get<std::string>());
        }

        // >>> NEXUS CHANGE BEGIN [1.2 - support zero-state loops]
        // An empty state_symbols array is valid: some loops have no integer
        // state variables. Keep the empty symbol list so the output schema
        // permits only constants (and variable-free expressions), while
        // CandidateParser still rejects undeclared variable references.
        // The validator's state relations also support zero arguments.
        // <<< NEXUS CHANGE END [1.2 - support zero-state loops]
        return loopSymbols;
    }

    throw std::runtime_error("Target loop entry was not found in the loop bundle.");
}

static std::string loadCandidateGrammar(const std::filesystem::path& candidateGrammarPath) {
    std::ifstream inputStream(candidateGrammarPath);
    if (!inputStream) {
        throw std::runtime_error(std::string(strerror(errno)) + ": " + candidateGrammarPath.string());
    }

    std::ostringstream  candidateGrammar;
    candidateGrammar << inputStream.rdbuf();

    return candidateGrammar.str();
}

static RefinementFeedback splitRefinementFeedback(const std::string& feedbackText) {
    static const std::string syntacticMarker = "==================== SYNTACTIC FEEDBACK ====================";
    static const std::string semanticMarker = "===================== SEMANTIC FEEDBACK =====================";
    // >>> NEXUS CHANGE BEGIN [5.8 - control feedback is not a Z3 validator summary]
    static const std::string controlMarker = "===================== REFINEMENT CONTROL FEEDBACK =====================";
    const std::size_t lastControl = feedbackText.rfind(controlMarker);
    const std::size_t lastSyntactic = feedbackText.rfind(syntacticMarker);
    const std::size_t lastSemantic = feedbackText.rfind(semanticMarker);
    std::size_t currentPosition = std::string::npos;
    for (const auto position : {lastControl, lastSyntactic, lastSemantic}) {
        if (position != std::string::npos &&
            (currentPosition == std::string::npos || position > currentPosition)) {
            currentPosition = position;
        }
    }
    // <<< NEXUS CHANGE END [5.8 - control feedback is not a Z3 validator summary]

    if (currentPosition == std::string::npos) {
        return {
            feedbackText,
            ""
        };
    }

    return {
        feedbackText.substr(currentPosition),
        feedbackText.substr(0, currentPosition)
    };
}

static Prompt buildPrompt(const std::string& loopId, const nlohmann::json& loopBundle, const std::string& candidateGrammar, const std::filesystem::path& refinementFeedbackPath, const std::filesystem::path& candidatePath, SynthesisMode synthesisMode) {
    std::string mode;
    std::string taskInstructions;

    // >>> NEXUS CHANGE BEGIN [7.2 - synthesis strategy for complete witnesses]
    if (synthesisMode == Initial) {
        mode = "Initial";
        // >>> NEXUS CHANGE BEGIN [8.4 - Existential recurrent-set synthesis guidance]
        taskInstructions = R"PROMPT(
Analyze the supplied loop information and determine whether the target loop is terminating or non-terminating.

A target loop is "terminating" if every reachable execution of the target loop eventually leaves the loop.

A target loop is "non-terminating" if at least one reachable execution of the target loop can continue indefinitely.

If the target loop is terminating, construct one inductive invariant and one ranking function.

The invariant must satisfy:
- INVARIANT_INITIALIZATION: every reachable entry state must satisfy the invariant.
- INVARIANT_PRESERVATION: if the invariant and loop guard hold before a completed iteration, the invariant must hold in the resulting next state.

The ranking function must satisfy:
- RANKING_NONNEGATIVITY: whenever the invariant and loop guard hold, the ranking value must be non-negative.
- RANKING_DECREASE: on every completed iteration satisfying the invariant and loop guard, the next ranking value must be strictly smaller than the current ranking value.

If the target loop is non-terminating, construct one recurrent set.

The recurrent set must satisfy:
- RECURRENT_REACHABILITY: at least one reachable loop-header state must belong to the recurrent set.
- RECURRENT_EXISTENTIAL_PROGRESS: from EVERY state of the recurrent set, at least ONE legal guard-true completed loop iteration must reach another recurrent-set state. Existentially choose any nondeterministic guard decision, next state, and path-local witnesses. An infinite execution must remain possible at every step; dead ends are not recurrent.
- Exits and returns on OTHER nondeterministic paths do not invalidate a non-termination witness.

Dependency loops provide reachability and execution context only. Construct the candidate only for the target loop.

For terminating witnesses, determine a sufficient inductive invariant before choosing a ranking expression; confirm the ranking measure is compatible with all possible iteration paths and the invariant.
For non-terminating witnesses, derive a nonempty reachable recurrent region with one perpetually enabled continuing path from every region state. Do not require universal closure or forbid alternative exits/returns. All nondeterministic choices must be genuinely allowed by the extracted transition relation.
)PROMPT";
        // <<< NEXUS CHANGE END [8.4 - Existential recurrent-set synthesis guidance]
    }

    // <<< NEXUS CHANGE END [7.2 - synthesis strategy for complete witnesses]
    // >>> NEXUS CHANGE BEGIN [5.11 - syntax repair retains candidate hypothesis]
    else if (synthesisMode == SyntacticRefinement) {
        mode = "SyntacticRefinement";
        taskInstructions = R"PROMPT(
Analyze the previous candidate and current feedback, and repair the candidate so that it is syntactically valid.

The previous_candidate is the candidate to repair. The current_feedback identifies the errors that must be fixed now.

Do not change the previous candidate's terminating or non-terminating classification.

Repair only the syntactically invalid parts. Preserve syntactically valid parts unchanged whenever possible.

The repaired candidate must:
- use the target loop_id;
- contain exactly one invariant and one ranking function if terminating, or exactly one recurrent set if non-terminating;
- use only target-loop current-state variables;
- make invariant and recurrent-set expressions derive from BoolExpr;
- make ranking-function expressions derive from RankingExpr;
- conform exactly to the supplied candidate grammar.

Use candidate_history and feedback_history to avoid repeating previously rejected syntactic forms or errors.

Dependency loops provide context only. Repair the candidate only for the target loop.
)PROMPT";
    }
    // <<< NEXUS CHANGE END [5.11 - syntax repair retains candidate hypothesis]

    // >>> NEXUS CHANGE BEGIN [5.12 and 7.3 - semantic repair and dependent witnesses]
    // >>> NEXUS CHANGE BEGIN [6.0 - typed semantic-feedback instructions]
    else if (synthesisMode == SemanticRefinement) {
        mode = "SemanticRefinement";
        // >>> NEXUS CHANGE BEGIN [8.5 - Existential-progress refinement feedback]
        taskInstructions = R"PROMPT(
Analyze the previous candidate and current feedback, and repair the candidate so that it is semantically valid.

The previous_candidate is the candidate to repair. The current_feedback reports the human-readable checks.
When present, the validation_feedback object contains the authoritative structured validator status, check names, expected/observed results, and available Z3 counterexample data.
If the current_feedback is refinement-control feedback instead, use candidate_history and feedback_history to avoid repeating the earlier witness; control feedback is not a fresh Z3 result.
For a failed solver obligation, use concrete assignments only when supplied under counterexample.assignments; such model assignments may be partial.
For a failed fixedpoint obligation, counterexample.answer_expression may be a symbolic formula rather than a concrete valuation.
For an unknown check, reason_unknown is not evidence for or against the witness; do not invent a counterexample.

Interpret the feedback as follows:
- "passed" means the corresponding requirement is satisfied.
- "failed" means the corresponding requirement is violated; use the failure explanation and any supplied counterexample to repair the relevant witness.
- "unknown" means the validator could not determine whether the requirement is satisfied.

If the candidate is terminating:
- repair the invariant only when an invariant check failed;
- repair the ranking function only when a ranking-function check failed;
- preserve a witness component when all of its checks passed, unless a required change to the invariant alters the assumptions under which the other component was checked;
- if the invariant changes, re-evaluate the ranking-function obligations under the NEW invariant: a ranking function validated under the old invariant is not automatically valid under the new one.

If the candidate is non-terminating:
- repair the recurrent set according to its failed checks while preserving parts that remain valid whenever possible;
- RECURRENT_EXISTENTIAL_PROGRESS requires an enabled continuing successor for EACH recurrent-set state (not every successor). A solver model showing a dead-end state is evidence to strengthen or reshape the set;
- if progress is unknown due to dependent Horn transitions, do not invent a transition or regard unknown as non-termination proof.

Do not change between terminating and non-terminating merely because the current witness failed validation. Change the classification only if the supplied loop semantics provide evidence that the previous classification is incorrect.

Use candidate_history and feedback_history to avoid repeating previously rejected witnesses or semantic mistakes.
An invalid or unknown candidate does NOT establish that the opposite termination classification is correct; an alternative classification must be justified independently by the loop semantics.
After every repair, propose a complete candidate satisfying ALL obligations, not only those that failed in the previous attempt.

Dependency loops provide reachability and execution context only. Repair the candidate only for the target loop.
)PROMPT";
        // <<< NEXUS CHANGE END [8.5 - Existential-progress refinement feedback]
    }
    // <<< NEXUS CHANGE END [6.0 - typed semantic-feedback instructions]
    // <<< NEXUS CHANGE END [5.12 and 7.3 - semantic repair and dependent witnesses]

    // >>> NEXUS CHANGE BEGIN [7.1 - complete witness construction guidance]
    // >>> NEXUS CHANGE BEGIN [8.6 - Existential progress in shared synthesis instructions]
    const std::string commonInstructions = R"PROMPT(
Interpret arithmetic over mathematical integers.

Return exactly one candidate for the target loop.

A terminating candidate must have exactly this form:
{
  "loop_id": "<TARGET_LOOP_ID>",
  "candidate_kind": "terminating",
  "candidate_expressions": [
    {
      "expression_kind": "invariant",
      "expression_ast": <BoolExpr>
    },
    {
      "expression_kind": "ranking-function",
      "expression_ast": <RankingExpr>
    }
  ]
}

A non-terminating candidate must have exactly this form:
{
  "loop_id": "<TARGET_LOOP_ID>",
  "candidate_kind": "non-terminating",
  "candidate_expressions": [
    {
      "expression_kind": "recurrent-set",
      "expression_ast": <BoolExpr>
    }
  ]
}

Every expression_ast must conform to the supplied candidate grammar.

Reason from the precise loop relations, not from the source-code shape alone:
- Derive any useful bounds, equalities, phases, and parity constraints from entry_states and the complete loop_iteration_steps relation.
- Include enough states for invariant initialization AND inductiveness; never assume that an entry condition remains true after an iteration without checking it.
- A ranking function must be non-negative and strictly decrease on EVERY relevant completed iteration. Use a lexicographic RankingExpr, encoded as nested lex(first, rest), when different phases decrease different measures.
- Treat nondeterministic choices as fresh per transition. Termination obligations must hold for every choice admitted by the extracted relations; do not assume a favorable random value.
- For a recurrent-set witness, prove reachability and existential progress: every recurrent-set state must have at least one guard-enabled completed iteration back into the set. Exits/returns on other choices are allowed. Merely showing one finite trace or a set with no enabled iteration is insufficient.
- An unreachable loop does not need an invented ranking decrease on unreachable transitions, but any proposed witness must still satisfy the validator's universal proof obligations.
- Use only expressions supported by the grammar. Do not add extra witness fields, helper variables, unproved assumptions, or natural-language placeholders.

Candidate expressions may use only the target loop's current-state variables from state_symbols[*].current.

Use the following JSON AST encoding:
- Variable: "l1_v1"
- Integer: 0, 1, -2
- Boolean: "true" or "false"
- Operator application: {"op":"<operator>","args":[...]}

Examples:
{"op":"<","args":["l1_v1","l1_v2"]}
{"op":"*","args":[2,"l1_v1"]}

Return only the JSON candidate object. Do not return Markdown, explanations, comments, or mathematical-expression strings.
)PROMPT";
    // <<< NEXUS CHANGE END [8.6 - Existential progress in shared synthesis instructions]
    // <<< NEXUS CHANGE END [7.1 - complete witness construction guidance]

    nlohmann::json input = {
        {"target_loop_id", loopId},
        {"loop_information", loopBundle},
        {"candidate_grammar", candidateGrammar}
    };

    if (synthesisMode != Initial) {
        std::ifstream previousCandidateStream(candidatePath);
        if (!previousCandidateStream) {
            throw std::runtime_error(std::string(strerror(errno)) + ": " + candidatePath.string());
        }
        std::ostringstream previousCandidateBuffer;
        previousCandidateBuffer << previousCandidateStream.rdbuf();

        const std::string previousCandidateText = previousCandidateBuffer.str();
        const nlohmann::json previousCandidateJson = nlohmann::json::parse(previousCandidateText, nullptr, false);
        if (!previousCandidateJson.is_discarded()) {
            input["previous_candidate"] = previousCandidateJson;
        }
        else {
            input["previous_candidate"] = previousCandidateText;
        }

        std::ifstream refinementFeedbackStream(refinementFeedbackPath);
        if (!refinementFeedbackStream) {
            throw std::runtime_error(std::string(strerror(errno)) + ": " + refinementFeedbackPath.string());
        }
        std::ostringstream refinementFeedbackBuffer;
        refinementFeedbackBuffer << refinementFeedbackStream.rdbuf();
        const std::string refinementFeedbackText = refinementFeedbackBuffer.str();

        const RefinementFeedback refinementFeedback = splitRefinementFeedback(refinementFeedbackText);

        // >>> NEXUS CHANGE BEGIN [6.1 - expose structured Z3 feedback to LLM]
        // The validator emits one authoritative summary for each validation.
        // Keep the earlier readable feedback, but put the structured record in
        // a separate input field so the LLM can use exact failed obligations.
        if (synthesisMode == SemanticRefinement) {
            static const std::string marker = "VALIDATION_SUMMARY_JSON:";
            std::istringstream lines(refinementFeedback.current);
            std::string line;
            std::string readable;
            bool found = false;
            while (std::getline(lines, line)) {
                if (line.rfind(marker, 0) == 0) {
                    const nlohmann::json record = nlohmann::json::parse(line.substr(marker.size()), nullptr, false);
                    if (record.is_discarded() || !record.is_object() || found) {
                        throw std::runtime_error("Malformed or duplicated structured validator feedback.");
                    }
                    input["validation_feedback"] = record;
                    found = true;
                }
                else {
                    readable += line + "\n";
                }
            }
            // >>> NEXUS CHANGE BEGIN [5.9 - semantic refinement after duplicate control]
            const bool isControlFeedback = refinementFeedback.current.rfind(
                "===================== REFINEMENT CONTROL FEEDBACK =====================", 0) == 0;
            if (!found && !isControlFeedback) {
                throw std::runtime_error("Structured validator feedback is missing for semantic refinement.");
            }
            // Control feedback is not validator evidence; never fabricate a
            // check, status, or counterexample for a duplicated candidate.
            input["current_feedback"] = readable;
            // <<< NEXUS CHANGE END [5.9 - semantic refinement after duplicate control]
        }
        else {
            input["current_feedback"] = refinementFeedback.current;
        }
        // <<< NEXUS CHANGE END [6.1 - expose structured Z3 feedback to LLM]

        if (!refinementFeedback.history.empty()) {
            input["feedback_history"] = refinementFeedback.history;
        }
        // >>> NEXUS CHANGE BEGIN [5.10 - compact previous witness outcomes]
        const std::filesystem::path candidateHistoryPath = candidatePath.parent_path() /
            (loopId + "_attempt_history.json");
        if (std::filesystem::exists(candidateHistoryPath)) {
            std::ifstream historyInput(candidateHistoryPath);
            if (!historyInput) {
                throw std::runtime_error("Cannot open candidate attempt history.");
            }
            nlohmann::json history;
            historyInput >> history;
            if (!history.is_array()) {
                throw std::runtime_error("Malformed candidate attempt history.");
            }
            nlohmann::json recent = nlohmann::json::array();
            // Keep the feedback focused without losing the exact current
            // previous_candidate supplied in its own field.
            const std::size_t first = history.size() > 6 ? history.size() - 6 : 0;
            for (std::size_t i = first; i < history.size(); ++i) {
                recent.push_back(history.at(i));
            }
            input["candidate_history"] = std::move(recent);
        }
        // <<< NEXUS CHANGE END [5.10 - compact previous witness outcomes]
    }

    return {mode, input.dump(), taskInstructions + "\n" + commonInstructions};
}

static void appendPromptHistory(const std::filesystem::path& promptHistoryPath, int promptAttempt, const std::string& llmModel, const nlohmann::json& request, const Prompt& prompt, const nlohmann::json& candidateSchema) {
    std::ofstream historyStream(promptHistoryPath, std::ios::app);
    if (!historyStream) {
        throw std::runtime_error(std::string(strerror(errno)) + ": " + promptHistoryPath.string());
    }

    historyStream << "==================== PROMPT ====================\n"
                  << "ATTEMPT: " << promptAttempt << "\n"
                  << "MODE: " << prompt.mode << "\n"
                  << "MODEL: " << llmModel << "\n";

    if (request.contains("reasoning") && request.at("reasoning").is_object() && request.at("reasoning").contains("effort")) {
        historyStream << "REASONING_EFFORT: "
                      << request.at("reasoning").at("effort").get<std::string>()
                      << "\n";
    }

    if (request.contains("reasoning_effort")) {
        historyStream << "REASONING_EFFORT: "
                      << request.at("reasoning_effort").get<std::string>()
                      << "\n";
    }

    if (request.contains("include_reasoning")) {
        historyStream << "INCLUDE_REASONING: "
                      << (request.at("include_reasoning").get<bool>() ? "true" : "false")
                      << "\n";
    }

    if (request.contains("chat_template_kwargs") && request.at("chat_template_kwargs").is_object() && request.at("chat_template_kwargs").contains("enable_thinking")) {
        historyStream << "ENABLE_THINKING: "
                      << (request.at("chat_template_kwargs").at("enable_thinking").get<bool>() ? "true" : "false")
                      << "\n";
    }

    if (llmModel == "CodeLlama-7B-Instruct") {
        historyStream << "INFERENCE_CONFIG: default\n";
    }

    historyStream << "RESPONSE_FORMAT: json_schema\n"
                  << "SCHEMA_NAME: nexus_candidate\n"
                  << "STRICT_SCHEMA: true\n\n"

                  << "INSTRUCTIONS:\n"
                  << prompt.instructions
                  << "\n\n"

                  << "INPUT:\n"
                  << prompt.input
                  << "\n\n"

                  << "OUTPUT_SCHEMA:\n"
                  << candidateSchema.dump(2)
                  << "\n\n";

    if (!historyStream) {
        throw std::runtime_error("Failed to write prompt history: " + promptHistoryPath.string());
    }
}

static void sendRequest(const std::string& llmModel, const Prompt& prompt, const std::string& loopId, const std::vector<std::string>& loopSymbols, long timeoutMilliseconds, int promptAttempt, const std::filesystem::path& promptHistoryPath, Response& response) {
    // >>> NEXUS CHANGE BEGIN [3.1 - grammar-typed AST response schema]
    // Keep the exact candidate JSON/AST shape. A positional tuple schema is
    // necessary: "ite" takes (Bool, Arith, Arith), comparisons take (Arith,
    // Arith), and "lex" takes (Arith, Ranking). CandidateParser remains the
    // final authority if a serving backend cannot enforce every constraint.
    auto ref = [](const std::string& name) -> nlohmann::json {
        return {{"$ref", "#/$defs/" + name}};
    };
    auto opSchema = [&](const std::string& op, const std::vector<std::string>& argumentKinds) -> nlohmann::json {
        nlohmann::json prefix = nlohmann::json::array();
        for (const std::string& kind : argumentKinds) {
            prefix.push_back(ref(kind));
        }
        return {
            {"type", "object"},
            {"properties", {
                {"op", {{"type", "string"}, {"enum", nlohmann::json::array({op})}}},
                {"args", {
                    {"type", "array"},
                    {"minItems", argumentKinds.size()},
                    {"maxItems", argumentKinds.size()},
                    {"prefixItems", prefix}
                }}
            }},
            {"required", nlohmann::json::array({"op", "args"})},
            {"additionalProperties", false}
        };
    };
    nlohmann::json boolAlternatives = nlohmann::json::array({
        {{"type", "string"}, {"enum", nlohmann::json::array({"true", "false"})}}
    });
    for (const char* op : {"and", "or", "implies", "iff"}) {
        boolAlternatives.push_back(opSchema(op, {"bool_expr", "bool_expr"}));
    }
    boolAlternatives.push_back(opSchema("not", {"bool_expr"}));
    for (const char* op : {"=", "!=", "<", "<=", ">", ">="}) {
        boolAlternatives.push_back(opSchema(op, {"arith_expr", "arith_expr"}));
    }

    nlohmann::json arithAlternatives = nlohmann::json::array({{{"type", "integer"}}});
    if (!loopSymbols.empty()) {
        arithAlternatives.push_back({{"type", "string"}, {"enum", loopSymbols}});
    }
    for (const char* op : {"+", "-", "*", "div", "mod", "min", "max"}) {
        arithAlternatives.push_back(opSchema(op, {"arith_expr", "arith_expr"}));
    }
    for (const char* op : {"neg", "abs"}) {
        arithAlternatives.push_back(opSchema(op, {"arith_expr"}));
    }
    arithAlternatives.push_back(opSchema("ite", {"bool_expr", "arith_expr", "arith_expr"}));
    arithAlternatives.push_back(opSchema("pow", {"arith_expr", "nonnegative_integer"}));

    const nlohmann::json expressionSchemas = nlohmann::json::array({
        {
            {"type", "object"},
            {"properties", {
                {"expression_kind", {{"type", "string"}, {"enum", nlohmann::json::array({"invariant"})}}},
                {"expression_ast", ref("bool_expr")}
            }},
            {"required", nlohmann::json::array({"expression_kind", "expression_ast"})},
            {"additionalProperties", false}
        },
        {
            {"type", "object"},
            {"properties", {
                {"expression_kind", {{"type", "string"}, {"enum", nlohmann::json::array({"ranking-function"})}}},
                {"expression_ast", ref("ranking_expr")}
            }},
            {"required", nlohmann::json::array({"expression_kind", "expression_ast"})},
            {"additionalProperties", false}
        },
        {
            {"type", "object"},
            {"properties", {
                {"expression_kind", {{"type", "string"}, {"enum", nlohmann::json::array({"recurrent-set"})}}},
                {"expression_ast", ref("bool_expr")}
            }},
            {"required", nlohmann::json::array({"expression_kind", "expression_ast"})},
            {"additionalProperties", false}
        }
    });
    const nlohmann::json candidateSchema = {
        {"type", "object"},
        {"properties", {
            {"loop_id", {{"type", "string"}, {"enum", nlohmann::json::array({loopId})}}},
            {"candidate_kind", {{"type", "string"}, {"enum", nlohmann::json::array({"terminating", "non-terminating"})}}},
            {"candidate_expressions", {
                {"type", "array"}, {"minItems", 1}, {"maxItems", 2},
                {"items", {{"anyOf", expressionSchemas}}}
            }}
        }},
        {"required", nlohmann::json::array({"loop_id", "candidate_kind", "candidate_expressions"})},
        {"additionalProperties", false},
        {"$defs", {
            {"bool_expr", {{"anyOf", boolAlternatives}}},
            {"arith_expr", {{"anyOf", arithAlternatives}}},
            {"ranking_expr", {{"anyOf", nlohmann::json::array({
                ref("arith_expr"), opSchema("lex", {"arith_expr", "ranking_expr"})
            })}}},
            {"nonnegative_integer", {{"type", "integer"}, {"minimum", 0}}}
        }}
    };
    // <<< NEXUS CHANGE END [3.1 - grammar-typed AST response schema]

    nlohmann::json request;
    std::string url;
    std::string authorizationHeader;

    if (llmModel == "gpt-5.6-terra") {
        // Read the OpenAI API key from the environment.
        const char* apiKey = std::getenv("OPENAI_API_KEY");
        if (!apiKey || !*apiKey) {
            throw std::runtime_error("OPENAI_API_KEY is not set.");
        }

        // Construct the OpenAI Responses API request.
        request = {
            {"model", llmModel},
            {"instructions", prompt.instructions},
            {"input", prompt.input},
            {"reasoning", {
                {"effort", "medium"}
            }},
            {"text", {
                {"format", {
                    {"type", "json_schema"},
                    {"name", "nexus_candidate"},
                    {"strict", true},
                    {"schema", candidateSchema}
                }}
            }}
        };

        url = "https://api.openai.com/v1/responses";

        authorizationHeader = "Authorization: Bearer " + std::string(apiKey);
    }

    else {
        // Read the vLLM server base URL from the environment.
        const char* baseUrl = std::getenv("VLLM_BASE_URL");
        if (!baseUrl || !*baseUrl) {
            throw std::runtime_error("VLLM_BASE_URL is not set.");
        }

        // Construct the vLLM Chat Completions request.
        request = {
            {"model", llmModel},
            {"messages", nlohmann::json::array({
                {
                    {"role", "system"},
                    {"content", prompt.instructions}
                },
                {
                    {"role", "user"},
                    {"content", prompt.input}
                }
            })},
            {"response_format", {
                {"type", "json_schema"},
                {"json_schema", {
                    {"name", "nexus_candidate"},
                    {"strict", true},
                    {"schema", candidateSchema}
                }}
            }}
        };

        // Apply model-specific inference configuration.
        if (llmModel == "gpt-oss-20b") {
            request["reasoning_effort"] = "medium";
            request["include_reasoning"] = true;
        }
        else if (llmModel == "Qwen3-8B") {
            request["chat_template_kwargs"] = {
                {"enable_thinking", false}
            };
        }
        else if (llmModel == "CodeLlama-7B-Instruct") {
            // Keep the default inference configuration.
        }
        else {
            throw std::runtime_error("Unsupported LLM model: " + llmModel);
        }

        url = std::string(baseUrl) + "/v1/chat/completions";
    }

    appendPromptHistory(promptHistoryPath, promptAttempt, llmModel, request, prompt, candidateSchema);

    // Serialize the request body.
    const std::string requestBody = request.dump();

    // Initialize libcurl once for the entire program.
    static const bool curlInitialized = []() {
        return curl_global_init(CURL_GLOBAL_DEFAULT) == CURLE_OK;
    }();
    if (!curlInitialized) {
        throw std::runtime_error(
            "Failed to initialize libcurl.");
    }

    // Create the CURL request handle.
    CURL* curl = curl_easy_init();
    if (!curl) {
        throw std::runtime_error("Failed to create CURL request handle.");
    }

    // Prepare the HTTP request headers.
    struct curl_slist* headers = nullptr;
    headers = curl_slist_append(headers, "Content-Type: application/json");
    if (llmModel == "gpt-5.6-terra") {
        headers = curl_slist_append(headers, authorizationHeader.c_str());
    }

    // Prepare storage for the HTTP response body.
    std::string responseBody;

    // Configure the HTTP request.
    curl_easy_setopt(curl, CURLOPT_URL, url.c_str());
    curl_easy_setopt(curl, CURLOPT_HTTPHEADER, headers);
    curl_easy_setopt(curl, CURLOPT_POST, 1L);
    curl_easy_setopt(curl, CURLOPT_POSTFIELDS, requestBody.c_str());
    curl_easy_setopt(curl, CURLOPT_POSTFIELDSIZE, static_cast<long>(requestBody.size()));

    // Configure response-body collection.
    curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, +[](char* ptr, size_t size, size_t nmemb, void* userdata) -> size_t {
        auto* output = static_cast<std::string*>(userdata);
        output->append(ptr, size * nmemb);
        return size * nmemb;
    });
    curl_easy_setopt(curl, CURLOPT_WRITEDATA, &responseBody);

    // Configure connection and request timeouts.
    curl_easy_setopt(curl, CURLOPT_TIMEOUT_MS, timeoutMilliseconds);

    // Send the request and measure latency.
    response.requestAttempted = true;
    const auto startTime = std::chrono::steady_clock::now();
    const CURLcode curlCode = curl_easy_perform(curl);
    const auto endTime = std::chrono::steady_clock::now();
    response.latency = std::chrono::duration_cast<std::chrono::milliseconds>(endTime - startTime).count();

    // Retrieve the HTTP status code.
    long statusCode = 0;
    curl_easy_getinfo(curl, CURLINFO_RESPONSE_CODE, &statusCode);

    // Release CURL resources.
    curl_slist_free_all(headers);
    curl_easy_cleanup(curl);

    const std::string providerName = llmModel == "gpt-5.6-terra" ? "OpenAI" : "vLLM";

    // Check for network or transport errors.
    if (curlCode == CURLE_OPERATION_TIMEDOUT) {
        throw RequestTimeoutException(providerName + " request timed out.");
    }
    if (curlCode != CURLE_OK) {
        throw std::runtime_error("Failed to send " + providerName + " request: " + std::string(curl_easy_strerror(curlCode)) + ".");
    }

    // Parse the HTTP response body.
    nlohmann::json responseData;
    try {
        responseData = nlohmann::json::parse(responseBody);
    }
    catch (const std::exception& exception) {
        throw std::runtime_error("Failed to parse " + providerName + " response: " + std::string(exception.what()) + ".");
    }

    if (llmModel == "gpt-5.6-terra") {
        // Extract token-usage and cost information from the OpenAI response.
        if (responseData.contains("usage") && responseData.at("usage").is_object()) {
            const nlohmann::json& usage = responseData.at("usage");
            response.inputTokens = usage.value("input_tokens", 0LL);
            response.outputTokens = usage.value("output_tokens", 0LL);
            long long cachedInputTokens = 0;
            if (usage.contains("input_tokens_details") && usage.at("input_tokens_details").is_object()) {
                cachedInputTokens = usage.at("input_tokens_details").value("cached_tokens", 0LL);
            }
            const long long uncachedInputTokens = std::max(0LL, response.inputTokens - cachedInputTokens);
            response.cost = static_cast<double>(uncachedInputTokens) / 1'000'000.0 * 2.00 + static_cast<double>(cachedInputTokens) / 1'000'000.0 * 0.20 + static_cast<double>(response.outputTokens) / 1'000'000.0 * 12.00;
            }
    }
    else {
        // Extract token-usage information from the vLLM response.
        if (responseData.contains("usage") && responseData.at("usage").is_object()) {
            const nlohmann::json& usage = responseData.at("usage");
            response.inputTokens = usage.value("prompt_tokens", 0LL);
            response.outputTokens = usage.value("completion_tokens", 0LL);
        }
    }

    // Check for HTTP-level errors.
    if (statusCode < 200 || statusCode >= 300) {
        throw std::runtime_error("Failed to complete " + providerName + " request: HTTP " + std::to_string(statusCode) + ": " + responseData.dump());
    }

    if (llmModel == "gpt-5.6-terra") {
        // Extract the generated candidate text from the OpenAI response.
        if (responseData.contains("output") && responseData.at("output").is_array()) {
            for (const auto& outputItem : responseData.at("output")) {
                if (!outputItem.contains("content") || !outputItem.at("content").is_array()) {
                    continue;
                }
                for (const auto& contentItem : outputItem.at("content")) {
                    if (contentItem.contains("type") && contentItem.at("type").is_string() && contentItem.at("type").get<std::string>() == "output_text" && contentItem.contains("text") && contentItem.at("text").is_string()) {
                        response.data = contentItem.at("text").get<std::string>();
                        break;
                    }
                }
                if (!response.data.empty()) {
                    break;
                }
            }
        }
        if (response.data.empty()) {
            throw std::runtime_error("OpenAI returned empty candidate content: " + responseData.dump());
        }
    }

    else {
        // Extract the generated candidate text from the vLLM response.
        if (!responseData.contains("choices") || !responseData.at("choices").is_array() || responseData.at("choices").empty()) {
            throw std::runtime_error("vLLM response contains no choices: " + responseData.dump());
        }
        const nlohmann::json& choice = responseData.at("choices").at(0);
        if (!choice.contains("message") || !choice.at("message").is_object()) {
            throw std::runtime_error("vLLM response contains no message: " + responseData.dump());
        }
        const nlohmann::json& message = choice.at("message");
        if (!message.contains("content") || !message.at("content").is_string() || message.at("content").get<std::string>().empty()) {
            throw std::runtime_error("vLLM returned empty candidate content: " + responseData.dump());
        }
        response.data = message.at("content").get<std::string>();
    }
}

static void saveCandidate(const Response& response, const std::filesystem::path& candidatePath) {
    std::string candidateText = response.data;

    try {
        const nlohmann::json candidate = nlohmann::json::parse(response.data);

        if (candidate.is_object()) {
            std::function<nlohmann::ordered_json(const nlohmann::json&)> orderAst = [&](const nlohmann::json& ast) -> nlohmann::ordered_json {
                if (ast.is_array()) {
                    nlohmann::ordered_json orderedArray = nlohmann::ordered_json::array();
                    for (const auto& element : ast) {
                        orderedArray.push_back(orderAst(element));
                    }
                    return orderedArray;
                }
                if (ast.is_object()) {
                    nlohmann::ordered_json orderedObject;
                    if (ast.contains("op")) {
                        orderedObject["op"] = orderAst(ast.at("op"));
                    }
                    if (ast.contains("args")) {
                        orderedObject["args"] = orderAst(ast.at("args"));
                    }
                    for (auto it = ast.begin(); it != ast.end(); ++it) {
                        if (it.key() == "op" || it.key() == "args") {
                            continue;
                        }
                        orderedObject[it.key()] = orderAst(it.value());
                    }
                    return orderedObject;
                }
                return ast;
            };

            auto orderExpression = [&](const nlohmann::json& expression) -> nlohmann::ordered_json {
                if (!expression.is_object()) {
                    return orderAst(expression);
                }
                nlohmann::ordered_json orderedExpression;
                if (expression.contains("expression_kind")) {
                    orderedExpression["expression_kind"] = expression.at("expression_kind");
                }
                if (expression.contains("expression_ast")) {
                    orderedExpression["expression_ast"] = orderAst(expression.at("expression_ast"));
                }
                for (auto it = expression.begin(); it != expression.end(); ++it) {
                    if (it.key() == "expression_kind" || it.key() == "expression_ast") {
                        continue;
                    }
                    orderedExpression[it.key()] = orderAst(it.value());
                }
                return orderedExpression;
            };

            nlohmann::ordered_json orderedCandidate;

            if (candidate.contains("loop_id")) {
                orderedCandidate["loop_id"] = candidate.at("loop_id");
            }

            if (candidate.contains("candidate_kind")) {
                orderedCandidate["candidate_kind"] = candidate.at("candidate_kind");
            }

            if (candidate.contains("candidate_expressions") && candidate.at("candidate_expressions").is_array()) {
                const nlohmann::json& expressions = candidate.at("candidate_expressions");

                nlohmann::ordered_json orderedExpressions = nlohmann::ordered_json::array();

                const std::string candidateKind = candidate.contains("candidate_kind") && candidate.at("candidate_kind").is_string() ? candidate.at("candidate_kind").get<std::string>() : "";

                if (candidateKind == "terminating") {
                    for (const char* requiredKind : {"invariant", "ranking-function"}) {
                        for (const auto& expression : expressions) {
                            if (expression.is_object() && expression.contains("expression_kind") && expression.at("expression_kind").is_string() && expression.at("expression_kind").get<std::string>() == requiredKind) {
                                orderedExpressions.push_back(orderExpression(expression));
                            }
                        }
                    }
                    for (const auto& expression : expressions) {
                        if (!expression.is_object() || !expression.contains("expression_kind") || !expression.at("expression_kind").is_string()) {
                            orderedExpressions.push_back(orderExpression(expression));
                            continue;
                        }
                        const std::string expressionKind = expression.at("expression_kind").get<std::string>();
                        if (expressionKind != "invariant" && expressionKind != "ranking-function") {
                            orderedExpressions.push_back(orderExpression(expression));
                        }
                    }
                }

                else if (candidateKind == "non-terminating") {
                    for (const auto& expression : expressions) {
                        if (expression.is_object() && expression.contains("expression_kind") && expression.at("expression_kind").is_string() && expression.at("expression_kind").get<std::string>() == "recurrent-set") {
                            orderedExpressions.push_back(orderExpression(expression));
                        }
                    }
                    for (const auto& expression : expressions) {
                        if (!expression.is_object() || !expression.contains("expression_kind") || !expression.at("expression_kind").is_string()) {
                            orderedExpressions.push_back(orderExpression(expression));
                            continue;
                        }
                        if (expression.at("expression_kind").get<std::string>() != "recurrent-set") {
                            orderedExpressions.push_back(orderExpression(expression));
                        }
                    }
                }

                else {
                    for (const auto& expression : expressions) {
                        orderedExpressions.push_back(orderExpression(expression));
                    }
                }

                orderedCandidate["candidate_expressions"] = std::move(orderedExpressions);
            }

            for (auto it = candidate.begin(); it != candidate.end(); ++it) {
                if (it.key() == "loop_id" || it.key() == "candidate_kind" || it.key() == "candidate_expressions") {
                    continue;
                }
                orderedCandidate[it.key()] = orderAst(it.value());
            }

            candidateText = orderedCandidate.dump(2);
        }
    }
    catch (const std::exception&) {
        // CandidateParser will handle malformed output.
    }

    std::ofstream candidateStream(candidatePath);
    if (!candidateStream) {
        throw std::runtime_error(std::string(strerror(errno)) + ": " + candidatePath.string());
    }
    candidateStream << candidateText << '\n';
    if (!candidateStream) {
        throw std::runtime_error("Failed to write candidate: " + candidatePath.string());
    }
}

static void populateSynthesisResult(SynthesisResult& synthesisResult, const Response& response) {
    try {
        const nlohmann::json candidate = nlohmann::json::parse(response.data);
        if (candidate.contains("candidate_kind") && candidate.at("candidate_kind").is_string()) {
            synthesisResult.kind = candidate.at("candidate_kind").get<std::string>();
        }
    }
    catch (const std::exception&) {
        // CandidateParser will handle malformed output.
    }
    synthesisResult.requestAttempted = response.requestAttempted;
    synthesisResult.inputTokens = response.inputTokens;
    synthesisResult.outputTokens = response.outputTokens;
    synthesisResult.latency = response.latency;
    synthesisResult.cost = response.cost;
}

SynthesisResult CandidateSynthesizer::synthesize(const std::string& loopId, const std::filesystem::path& loopInformationDirectory, const std::filesystem::path& candidateGrammarPath, const std::filesystem::path& refinementFeedbackPath, const std::filesystem::path& candidatePath, const std::string& llmModel, SynthesisMode synthesisMode, long timeoutMilliseconds, int promptAttempt, const std::filesystem::path& promptHistoryPath) {
    Response response;
    SynthesisResult synthesisResult;

    try {
        const std::map<std::string, nlohmann::json> loopInformationList = loadLoopInformation(loopInformationDirectory);

        const std::vector<std::string> dependencyLoops = computeDependencyLoops(loopInformationList, loopId);

        const nlohmann::json loopBundle = buildLoopBundle(loopInformationList, loopId, dependencyLoops);

        const std::vector<std::string> loopSymbols = getLoopSymbols(loopBundle);

        const std::string candidateGrammar = loadCandidateGrammar(candidateGrammarPath);

        const Prompt prompt = buildPrompt(loopId, loopBundle, candidateGrammar, refinementFeedbackPath, candidatePath, synthesisMode);

        sendRequest(llmModel, prompt, loopId, loopSymbols, timeoutMilliseconds, promptAttempt, promptHistoryPath, response);

        saveCandidate(response, candidatePath);

        synthesisResult.synthesisSucceeded = true;
    }
    catch (const RequestTimeoutException& ex) {
        std::cerr << "CandidateSynthesizer::synthesize timeout: " << ex.what() << '\n';
        synthesisResult.requestTimedOut = true;
    }
    catch (const std::exception& ex) {
        std::cerr << "CandidateSynthesizer::synthesize error: " << ex.what() << '\n';
    }

    populateSynthesisResult(synthesisResult, response);

    return synthesisResult;
}