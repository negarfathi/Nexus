#include "../include/candidate_synthesizer.h"

struct Prompt {
    std::string instructions;
    std::string input;
};

struct Response {
    std::string data;
    long long inputTokens = 0;
    long long outputTokens = 0;
    double latency = 0.0;
    double cost = 0.0;
};

static std::map<std::string, nlohmann::json> loadLoopInformation(const std::filesystem::path& loopInformationDirectory) {
    std::map<std::string, nlohmann::json> loopInformationList;

    for (const auto& entry : std::filesystem::recursive_directory_iterator(loopInformationDirectory)) {
        if (!entry.is_regular_file()) {
            continue;
        }

        std::ifstream inputStream(entry.path());
        if (!inputStream) {
            throw std::runtime_error(std::string(strerror(errno)) + ": " + entry.path().string()
            );
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

static std::string loadCandidateGrammar(const std::filesystem::path& candidateGrammarPath) {
    std::ifstream inputStream(candidateGrammarPath);
    if (!inputStream) {
        throw std::runtime_error(std::string(strerror(errno)) + ": " + candidateGrammarPath.string());
    }

    std::ostringstream  candidateGrammar;
    candidateGrammar << inputStream.rdbuf();

    return candidateGrammar.str();
}

static Prompt buildPrompt(const std::string& loopId, const nlohmann::json& loopBundle, const std::string& candidateGrammar, const std::filesystem::path& refinementFeedbackPath, const std::filesystem::path& candidatePath, SynthesisMode synthesisMode) {
    std::string taskInstructions;

    if (synthesisMode == Initial) {
        taskInstructions = R"PROMPT(
Construct a candidate witness for termination or non-termination of the target loop using the supplied loop information and candidate grammar.

For termination, construct an inductive invariant and a ranking expression that is non-negative under the loop guard and strictly decreases on every completed iteration.

For non-termination, construct a recurrent-set predicate over reachable loop-header states that satisfies the guard, is preserved by iteration, and permits continued execution.

Dependency loops provide context only; construct a candidate only for the target loop.
)PROMPT";
    }

    else if (synthesisMode == SyntacticRefinement) {
        taskInstructions = R"PROMPT(
Refine the previous candidate for the target loop using the supplied loop information, candidate grammar, and parsing feedback.

Correct the reported candidate-format, target-loop identifier, candidate-kind, expression-kind, grammar, typing, operator-arity, and target-current-state-symbol errors while preserving valid parts when possible.

Treat these as grammar and representation issues only; preserve the previous termination or non-termination classification.

Dependency loops provide context only; refine the candidate only for the target loop.
)PROMPT";
    }

    else if (synthesisMode == SemanticRefinement) {
        taskInstructions = R"PROMPT(
Refine the previous candidate for the target loop using the supplied loop information, candidate grammar, and validation feedback.

Repair or replace the previous witness according to the validation feedback.

If the loop information and validation feedback justify a different classification, change between termination and non-termination and construct a suitable witness for the revised classification.

Dependency loops provide context only; refine the candidate only for the target loop.
)PROMPT";
    }

    const std::string commonInstructions = R"PROMPT(
Interpret arithmetic over mathematical integers.

Classify the target loop as exactly one of the following:

- "terminating": every reachable execution of the target loop terminates.
  Provide one inductive invariant and one ranking function.

- "non-terminating": some reachable execution of the target loop can continue indefinitely.
  Provide one recurrent set.

- "unknown": neither a termination nor a non-termination witness can be constructed.
  Provide no candidate expressions.

Return exactly one JSON object:

Termination:
{
  "loop_id": "<TARGET_LOOP_ID>",
  "candidate_kind": "terminating",
  "candidate_expressions": [
    {"expression_kind": "invariant", "expression_ast": <BoolExpr as JSON AST>},
    {"expression_kind": "ranking-function", "expression_ast": <RankingExpr as JSON AST>}
  ]
}

Non-termination:
{
  "loop_id": "<TARGET_LOOP_ID>",
  "candidate_kind": "non-terminating",
  "candidate_expressions": [
    {"expression_kind": "recurrent-set", "expression_ast": <BoolExpr as JSON AST>}
  ]
}

Unknown:
{
  "loop_id": "<TARGET_LOOP_ID>",
  "candidate_kind": "unknown",
  "candidate_expressions": []
}

Each expression AST must conform exactly to the supplied candidate grammar and use only the target loop's current-state symbols listed in state_symbols[*].current. Do not use state_symbols[*].next, state_symbols[*].output, or nondeterministic_symbols in candidate expressions.

Return only the JSON object, with no mathematical-expression strings, Markdown, or explanations.
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

        input["previous_candidate"] = previousCandidateBuffer.str();

        std::ifstream refinementFeedbackStream(refinementFeedbackPath);
        if (!refinementFeedbackStream) {
            throw std::runtime_error(std::string(strerror(errno)) + ": " + refinementFeedbackPath.string());
        }
        std::ostringstream refinementFeedbackBuffer;
        refinementFeedbackBuffer << refinementFeedbackStream.rdbuf();

        if (synthesisMode == SyntacticRefinement) {
            input["syntactic_feedback"] = refinementFeedbackBuffer.str();
        }
        else if (synthesisMode == SemanticRefinement) {
            input["semantic_feedback"] = refinementFeedbackBuffer.str();
        }
    }

    return {taskInstructions + "\n" + commonInstructions, input.dump(2)};
}

static Response sendRequest(const std::string& llmModel, const Prompt& prompt, long timeout) {
    // Define the JSON schema for expression ASTs.
    const nlohmann::json expressionAstSchema = {
        {"anyOf", nlohmann::json::array({
            nlohmann::json{
                {"type", "integer"}
            },
            nlohmann::json{
                {"type", "boolean"}
            },
            nlohmann::json{
                {"type", "string"}
            },
            nlohmann::json{
                {"type", "object"},
                {"properties", {
                    {"op", {
                        {"type", "string"}
                    }},
                    {"args", {
                        {"type", "array"},
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
            }
        })}
    };

    // Define the JSON schema for candidates.
    const nlohmann::json candidateSchema = {
        {"type", "object"},
        {"properties", {
            {"loop_id", {
                {"type", "string"}
            }},
            {"candidate_kind", {
                {"type", "string"},
                {"enum", nlohmann::json::array({
                    "terminating",
                    "non-terminating",
                    "unknown"
                })}
            }},
            {"candidate_expressions", {
                {"type", "array"},
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
                {"enable_thinking", true}
            };
            request["include_reasoning"] = false;
        }
        else if (llmModel == "CodeLlama-7B-Instruct") {
            // Keep the default inference configuration.
        }
        else {
            throw std::runtime_error("Unsupported LLM model: " + llmModel);
        }

        url = std::string(baseUrl) + "/v1/chat/completions";
    }

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
    curl_easy_setopt(curl, CURLOPT_CONNECTTIMEOUT, 30L);
    curl_easy_setopt(curl, CURLOPT_TIMEOUT, timeout);

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

SynthesisResult CandidateSynthesizer::synthesize(const std::string& loopId, const std::filesystem::path& loopInformationDirectory, const std::filesystem::path& candidateGrammarPath, const std::filesystem::path& refinementFeedbackPath, const std::filesystem::path& candidatePath, const std::string& llmModel, SynthesisMode synthesisMode, long timeout) {
    SynthesisResult synthesisResult;

    try {
        const std::map<std::string, nlohmann::json> loopInformationList = loadLoopInformation(loopInformationDirectory);

        const std::vector<std::string> dependencyLoops = computeDependencyLoops(loopInformationList, loopId);

        const nlohmann::json loopBundle = buildLoopBundle(loopInformationList, loopId, dependencyLoops);

        const std::string candidateGrammar = loadCandidateGrammar(candidateGrammarPath);

        const Prompt prompt = buildPrompt(loopId, loopBundle, candidateGrammar, refinementFeedbackPath, candidatePath, synthesisMode);

        Response response = sendRequest(llmModel, prompt, timeout);

        saveCandidate(response, candidatePath);

        populateSynthesisResult(synthesisResult, response);

        synthesisResult.success = true;
    }
    catch (const std::exception& ex) {
        std::cerr << "CandidateSynthesizer::synthesize error: " << ex.what() << '\n';

        return synthesisResult;
    }

    return synthesisResult;
}