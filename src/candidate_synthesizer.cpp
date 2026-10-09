#include "../include/candidate_synthesizer.h"

struct Prompt {
    std::string mode;
    std::string input;
    std::string instructions;
};

struct Response {
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

        if (loopSymbols.empty()) {
            throw std::runtime_error("Target loop has no current-state symbols.");
        }

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

    const std::size_t lastSyntactic = feedbackText.rfind(syntacticMarker);
    const std::size_t lastSemantic = feedbackText.rfind(semanticMarker);

    std::size_t currentPosition = std::string::npos;
    if (lastSyntactic != std::string::npos && lastSemantic != std::string::npos) {
        currentPosition = std::max(lastSyntactic, lastSemantic);
    }
    else if (lastSyntactic != std::string::npos) {
        currentPosition = lastSyntactic;
    }
    else if (lastSemantic != std::string::npos) {
        currentPosition = lastSemantic;
    }

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

    if (synthesisMode == Initial) {
        mode = "Initial";
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
- RECURRENT_GUARD_CONTAINMENT: every state in the recurrent set must satisfy the loop guard.
- RECURRENT_CLOSURE: every completed loop iteration from a recurrent-set state must produce another recurrent-set state.
- RECURRENT_NO_NORMAL_EXIT: recurrent-set states must not permit normal loop exit.
- RECURRENT_NO_FUNCTION_RETURN: recurrent-set states must not permit function return.

Dependency loops provide reachability and execution context only. Construct the candidate only for the target loop.
)PROMPT";
    }

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

Use the feedback_history to avoid repeating previously rejected syntactic forms or errors.

Dependency loops provide context only. Repair the candidate only for the target loop.
)PROMPT";
    }

    else if (synthesisMode == SemanticRefinement) {
        mode = "SemanticRefinement";
        taskInstructions = R"PROMPT(
Analyze the previous candidate and current feedback, and repair the candidate so that it is semantically valid.

The previous_candidate is the candidate to repair. The current_feedback reports the semantic validation checks for that candidate.

Interpret the feedback as follows:
- "passed" means the corresponding requirement is satisfied.
- "failed" means the corresponding requirement is violated; use the failure explanation and any supplied counterexample to repair the relevant witness.
- "unknown" means the validator could not determine whether the requirement is satisfied.

If the candidate is terminating:
- repair the invariant only when an invariant check failed;
- repair the ranking function only when a ranking-function check failed;
- preserve a witness component when all of its checks passed.

If the candidate is non-terminating:
- repair the recurrent set according to its failed checks while preserving parts that remain valid whenever possible.

Do not change between terminating and non-terminating merely because the current witness failed validation. Change the classification only if the supplied loop semantics provide evidence that the previous classification is incorrect.

Use the feedback_history to avoid repeating previously rejected witnesses or semantic mistakes.

Dependency loops provide reachability and execution context only. Repair the candidate only for the target loop.
)PROMPT";
    }

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

        input["current_feedback"] = refinementFeedback.current;

        if (!refinementFeedback.history.empty()) {
            input["feedback_history"] = refinementFeedback.history;
        }
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

static Response sendRequest(const std::string& llmModel, const Prompt& prompt, const std::string& loopId, const std::vector<std::string>& loopSymbols, long timeoutMilliseconds, int promptAttempt, const std::filesystem::path& promptHistoryPath) {
    nlohmann::json allowedStringLeaves = nlohmann::json::array();
    for (const std::string& symbol : loopSymbols) {
        allowedStringLeaves.push_back(symbol);
    }
    allowedStringLeaves.push_back("true");
    allowedStringLeaves.push_back("false");

    const std::vector<std::pair<std::string, std::size_t>> operatorArities = {
        {"and", 2},
        {"or", 2},
        {"not", 1},
        {"implies", 2},
        {"iff", 2},
        {"=", 2},
        {"!=", 2},
        {"<", 2},
        {"<=", 2},
        {">", 2},
        {">=", 2},
        {"+", 2},
        {"-", 2},
        {"neg", 1},
        {"*", 2},
        {"div", 2},
        {"mod", 2},
        {"pow", 2},
        {"abs", 1},
        {"min", 2},
        {"max", 2},
        {"ite", 3},
        {"lex", 2}
    };

    nlohmann::json expressionAlternatives = nlohmann::json::array();
    expressionAlternatives.push_back({
        {"type", "integer"}
    });
    expressionAlternatives.push_back({
        {"type", "string"},
        {"enum", allowedStringLeaves}
    });

    for (const auto& [operatorName, arity] : operatorArities) {
        expressionAlternatives.push_back({
            {"type", "object"},
            {"properties", {
                {"op", {
                    {"type", "string"},
                    {"enum", nlohmann::json::array({operatorName})}
                }},
                {"args", {
                    {"type", "array"},
                    {"minItems", arity},
                    {"maxItems", arity},
                    {"items", {
                        {"$ref", "#/$defs/expression_ast"}
                    }}
                }}
            }},
            {"required", nlohmann::json::array({
                "op",
                "args"
            })},
            {"additionalProperties", false}
        });
    }

    const nlohmann::json expressionAstSchema = {
        {"anyOf", expressionAlternatives}
    };

    const nlohmann::json candidateSchema = {
        {"type", "object"},
        {"properties", {
            {"loop_id", {
                {"type", "string"},
                {"enum", nlohmann::json::array({loopId})}
            }},
            {"candidate_kind", {
                {"type", "string"},
                {"enum", nlohmann::json::array({
                    "terminating",
                    "non-terminating"
                })}
            }},
            {"candidate_expressions", {
                {"type", "array"},
                {"minItems", 1},
                {"maxItems", 2},
                {"items", {
                    {"type", "object"},
                    {"properties", {
                        {"expression_kind", {
                            {"type", "string"},
                            {"enum", nlohmann::json::array({
                                "invariant",
                                "ranking-function",
                                "recurrent-set"
                            })}
                        }},
                        {"expression_ast", {
                            {"$ref", "#/$defs/expression_ast"}
                        }}
                    }},
                    {"required", nlohmann::json::array({
                        "expression_kind",
                        "expression_ast"
                    })},
                    {"additionalProperties", false}
                }}
            }}
        }},
        {"required", nlohmann::json::array({
            "loop_id",
            "candidate_kind",
            "candidate_expressions"
        })},
        {"additionalProperties", false},
        {"$defs", {
            {"expression_ast", expressionAstSchema}
        }}
    };

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
    const auto startTime = std::chrono::steady_clock::now();
    const CURLcode curlCode = curl_easy_perform(curl);
    const auto endTime = std::chrono::steady_clock::now();
    const double latency = std::chrono::duration_cast<std::chrono::milliseconds>(endTime - startTime).count();

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

    // Check for HTTP-level errors.
    if (statusCode < 200 || statusCode >= 300) {
        throw std::runtime_error("Failed to complete " + providerName + " request: HTTP " + std::to_string(statusCode) + ": " + responseData.dump());
    }

    Response response;

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
            response.cost =
                static_cast<double>(
                    uncachedInputTokens) /
                    1'000'000.0 *
                    2.00 +
                static_cast<double>(
                    cachedInputTokens) /
                    1'000'000.0 *
                    0.20 +
                static_cast<double>(
                    response.outputTokens) /
                    1'000'000.0 *
                    12.00;
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

        // Extract token-usage information from the vLLM response.
        if (responseData.contains("usage") && responseData.at("usage").is_object()) {
            const nlohmann::json& usage = responseData.at("usage");
            response.inputTokens = usage.value("prompt_tokens", 0LL);
            response.outputTokens = usage.value("completion_tokens", 0LL);
        }
    }

    // Record the measured request latency.
    response.latency = latency;

    // Return the normalized synthesis response.
    return response;
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
    synthesisResult.inputTokens = response.inputTokens;
    synthesisResult.outputTokens = response.outputTokens;
    synthesisResult.latency = response.latency;
    synthesisResult.cost = response.cost;
}

SynthesisResult CandidateSynthesizer::synthesize(const std::string& loopId, const std::filesystem::path& loopInformationDirectory, const std::filesystem::path& candidateGrammarPath, const std::filesystem::path& refinementFeedbackPath, const std::filesystem::path& candidatePath, const std::string& llmModel, SynthesisMode synthesisMode, long timeoutMilliseconds, int promptAttempt, const std::filesystem::path& promptHistoryPath) {
    SynthesisResult synthesisResult;

    try {
        const std::map<std::string, nlohmann::json> loopInformationList = loadLoopInformation(loopInformationDirectory);

        const std::vector<std::string> dependencyLoops = computeDependencyLoops(loopInformationList, loopId);

        const nlohmann::json loopBundle = buildLoopBundle(loopInformationList, loopId, dependencyLoops);

        const std::vector<std::string> loopSymbols = getLoopSymbols(loopBundle);

        const std::string candidateGrammar = loadCandidateGrammar(candidateGrammarPath);

        const Prompt prompt = buildPrompt(loopId, loopBundle, candidateGrammar, refinementFeedbackPath, candidatePath, synthesisMode);

        Response response = sendRequest(llmModel, prompt, loopId, loopSymbols, timeoutMilliseconds, promptAttempt, promptHistoryPath);

        saveCandidate(response, candidatePath);

        populateSynthesisResult(synthesisResult, response);

        synthesisResult.success = true;
    }
    catch (const RequestTimeoutException& ex) {
        std::cerr << "CandidateSynthesizer::synthesize timeout: " << ex.what() << '\n';
        synthesisResult.timedOut = true;
        return synthesisResult;
    }
    catch (const std::exception& ex) {
        std::cerr << "CandidateSynthesizer::synthesize error: " << ex.what() << '\n';
        return synthesisResult;
    }

    return synthesisResult;
}