#include "../include/candidate_parser.h"

// Checks that the candidate file parses as exactly one JSON object and contains no unexpected top-level fields.
static void checkStructure(nlohmann::json& candidate, const std::filesystem::path& candidatePath, ParseResult& parseResult) {
    std::ifstream candidateStream(candidatePath);
    if (!candidateStream) {
        throw std::runtime_error(std::string(strerror(errno)) + ": " + candidatePath.string());
    }
    std::ostringstream candidateBuffer;
    candidateBuffer << candidateStream.rdbuf();

    try {
        candidate = nlohmann::json::parse(candidateBuffer.str());
    }
    catch (const std::exception& ex) {
        parseResult.valid = false;
        parseResult.errors.push_back({
            {"check", "json-structure"},
            {"path", "$"},
            {"message", "Candidate output is not valid JSON: " + std::string(ex.what())}
        });
        return;
    }

    if (!candidate.is_object()) {
        parseResult.valid = false;
        parseResult.errors.push_back({
            {"check", "json-structure"},
            {"path", "$"},
            {"message", "Candidate output must be exactly one JSON object."}
        });
        return;
    }

    for (auto it = candidate.begin(); it != candidate.end(); ++it) {
        if (it.key() != "loop_id" && it.key() != "candidate_kind" && it.key() != "candidate_expressions") {
            parseResult.valid = false;
            parseResult.errors.push_back({
                {"check", "json-structure"},
                {"path", "$." + it.key()},
                {"message", "Unexpected candidate field '" + it.key() + "'."}
            });
        }
    }
}

// Checks that loop_id exists, is a string, and matches the target loop id.
static void checkLoopId(const nlohmann::json& candidate, const std::string& loopId, ParseResult& parseResult) {
    if (!candidate.is_object()) {
        return;
    }

    if (!candidate.contains("loop_id")) {
        parseResult.valid = false;
        parseResult.errors.push_back({
            {"check", "loop-id"},
            {"path", "$.loop_id"},
            {"message", "loop_id is missing."}
        });
        return;
    }

    if (!candidate.at("loop_id").is_string()) {
        parseResult.valid = false;
        parseResult.errors.push_back({
            {"check", "loop-id"},
            {"path", "$.loop_id"},
            {"message", "loop_id must be a string."}
        });
        return;
    }

    if (candidate.at("loop_id").get<std::string>() != loopId) {
        parseResult.valid = false;
        parseResult.errors.push_back({
            {"check", "loop-id"},
            {"path", "$.loop_id"},
            {"message", "loop_id must match target loop '" + loopId + "'."}
        });
    }
}

// Checks that candidate_kind exists, is a string, and is exactly terminating, non-terminating, or unknown.
static void checkCandidateKind(const nlohmann::json& candidate, ParseResult& parseResult) {
    if (!candidate.is_object()) {
        return;
    }

    if (!candidate.contains("candidate_kind")) {
        parseResult.valid = false;
        parseResult.errors.push_back({
            {"check", "candidate-kind"},
            {"path", "$.candidate_kind"},
            {"message", "candidate_kind is missing."}
        });
        return;
    }

    if (!candidate.at("candidate_kind").is_string()) {
        parseResult.valid = false;
        parseResult.errors.push_back({
            {"check", "candidate-kind"},
            {"path", "$.candidate_kind"},
            {"message", "candidate_kind must be a string."}
        });
        return;
    }

    const std::string candidateKind = candidate.at("candidate_kind").get<std::string>();
    if (candidateKind != "terminating" && candidateKind != "non-terminating" && candidateKind != "unknown") {
        parseResult.valid = false;
        parseResult.errors.push_back({
            {"check", "candidate-kind"},
            {"path", "$.candidate_kind"},
            {"message", "candidate_kind must be terminating, non-terminating, or unknown."}
        });
    }
}

// Checks that candidate_expressions exists and is an array.
// Checks that each candidate expression is a JSON object, contains no unexpected fields, has an expression_kind field that is a string and is exactly invariant, ranking-function, or recurrent-set, and has an expression_ast field.
// Checks that terminating, non-terminating, and unknown candidates contain exactly the candidate expressions required by their candidate_kind.
// Checks that a terminating candidate contains exactly one invariant and one ranking-function candidate expression.
// Checks that a non-terminating candidate contains exactly one recurrent-set candidate expression.
// Checks that an unknown candidate contains no candidate expressions.
static void checkCandidateExpressions(const nlohmann::json& candidate, ParseResult& parseResult) {
    if (!candidate.is_object()) {
        return;
    }

    if (!candidate.contains("candidate_expressions")) {
        parseResult.valid = false;
        parseResult.errors.push_back({
            {"check", "candidate-structure"},
            {"path", "$.candidate_expressions"},
            {"message", "candidate_expressions is missing."}
        });
        return;
    }

    if (!candidate.at("candidate_expressions").is_array()) {
        parseResult.valid = false;
        parseResult.errors.push_back({
            {"check", "candidate-structure"},
            {"path", "$.candidate_expressions"},
            {"message", "candidate_expressions must be an array."}
        });
        return;
    }

    const nlohmann::json& candidateExpressions = candidate.at("candidate_expressions");

    std::size_t invariantCount = 0;
    std::size_t rankingFunctionCount = 0;
    std::size_t recurrentSetCount = 0;
    std::size_t unsupportedKindCount = 0;

    for (std::size_t i = 0; i < candidateExpressions.size(); ++i) {
        const nlohmann::json& candidateExpression = candidateExpressions.at(i);

        const std::string path = "$.candidate_expressions[" + std::to_string(i) + "]";

        if (!candidateExpression.is_object()) {
            parseResult.valid = false;
            parseResult.errors.push_back({
                {"check", "candidate-structure"},
                {"path", path},
                {"message", "Each candidate expression must be a JSON object."}
            });
            continue;
        }

        for (auto it = candidateExpression.begin(); it != candidateExpression.end(); ++it) {
            if (it.key() != "expression_kind" && it.key() != "expression_ast") {
                parseResult.valid = false;
                parseResult.errors.push_back({
                    {"check", "candidate-structure"},
                    {"path", path + "." + it.key()},
                    {"message", "Unexpected candidate expression field '" + it.key() + "'."}
                });
            }
        }

        if (!candidateExpression.contains("expression_kind")) {
            parseResult.valid = false;
            parseResult.errors.push_back({
                {"check", "candidate-structure"},
                {"path", path + ".expression_kind"},
                {"message", "expression_kind is missing."}
            });
        }

        else if (!candidateExpression.at("expression_kind").is_string()) {
            parseResult.valid = false;
            parseResult.errors.push_back({
                {"check", "candidate-structure"},
                {"path", path + ".expression_kind"},
                {"message", "expression_kind must be a string."}
            });
        }

        else {
            const std::string expressionKind = candidateExpression.at("expression_kind").get<std::string>();

            if (expressionKind == "invariant") {
                ++invariantCount;
            }
            else if (expressionKind == "ranking-function") {
                ++rankingFunctionCount;
            }
            else if (expressionKind == "recurrent-set") {
                ++recurrentSetCount;
            }
            else {
                ++unsupportedKindCount;
                parseResult.valid = false;
                parseResult.errors.push_back({
                    {"check", "candidate-structure"},
                    {"path", path + ".expression_kind"},
                    {"message", "expression_kind must be invariant, ranking-function, or recurrent-set."}
                });
            }
        }

        if (!candidateExpression.contains("expression_ast")) {
            parseResult.valid = false;
            parseResult.errors.push_back({
                {"check", "candidate-structure"},
                {"path", path + ".expression_ast"},
                {"message", "expression_ast is missing."}
            });
        }
    }

    if (!candidate.contains("candidate_kind") || !candidate.at("candidate_kind").is_string()) {
        return;
    }

    const std::string candidateKind = candidate.at("candidate_kind").get<std::string>();

    if (candidateKind == "terminating") {
        if (candidateExpressions.size() != 2 || invariantCount != 1 || rankingFunctionCount != 1 || recurrentSetCount != 0 || unsupportedKindCount != 0) {
            parseResult.valid = false;
            parseResult.errors.push_back({
                {"check", "candidate-structure"},
                {"path", "$.candidate_expressions"},
                {"message", "A terminating candidate must contain exactly one invariant and one ranking-function candidate expression."}
            });
        }
    }

    else if (candidateKind == "non-terminating") {
        if (candidateExpressions.size() != 1 || invariantCount != 0 || rankingFunctionCount != 0 || recurrentSetCount != 1 || unsupportedKindCount != 0) {
            parseResult.valid = false;
            parseResult.errors.push_back({
                {"check", "candidate-structure"},
                {"path", "$.candidate_expressions"},
                {"message", "A non-terminating candidate must contain exactly one recurrent-set candidate expression."}
            });
        }
    }

    else if (candidateKind == "unknown") {
        if (!candidateExpressions.empty()) {
            parseResult.valid = false;
            parseResult.errors.push_back({
                {"check", "candidate-structure"},
                {"path", "$.candidate_expressions"},
                {"message", "An unknown candidate must contain an empty candidate_expressions array."}
            });
        }
    }
}

// Checks that every variable leaf in each expression_ast is a current-state symbol of the target loop.
static void checkVariables(const nlohmann::json& candidate, const std::string& loopId, const std::filesystem::path& loopInformationDirectory, ParseResult& parseResult) {
    if (!candidate.is_object() || !candidate.contains("candidate_expressions") || !candidate.at("candidate_expressions").is_array()) {
        return;
    }

    bool targetLoopFound = false;
    std::set<std::string> targetVariables;

    for (const auto& entry : std::filesystem::recursive_directory_iterator(loopInformationDirectory)) {
        if (!entry.is_regular_file()) {
            continue;
        }

        nlohmann::json loopInformation;

        std::ifstream entryStream(entry.path());
        if (!entryStream) {
            throw std::runtime_error(std::string(strerror(errno)) + ": " + entry.path().string());
        }
        entryStream >> loopInformation;

        if (!loopInformation.is_object() || !loopInformation.contains("loop_id") || !loopInformation.at("loop_id").is_string() || loopInformation.at("loop_id").get<std::string>() != loopId) {
            continue;
        }

        targetLoopFound = true;

        if (!loopInformation.contains("state_symbols") || !loopInformation.at("state_symbols").is_array()) {
            throw std::runtime_error("Loop information for '" + loopId + "' has no valid state_symbols array.");
        }

        for (const auto& stateSymbol : loopInformation.at("state_symbols")) {
            if (!stateSymbol.is_object() || !stateSymbol.contains("current") || !stateSymbol.at("current").is_string()) {
                throw std::runtime_error("Loop information for '" + loopId + "' contains a malformed state_symbols entry.");
            }

            targetVariables.insert(stateSymbol.at("current").get<std::string>());
        }

        break;
    }

    if (!targetLoopFound) {
        throw std::runtime_error("Loop information was not found for loop '" + loopId + "'.");
    }

    std::function<void(const nlohmann::json&, const std::string&)> checkExpressionAst = [&](const nlohmann::json& expressionAst, const std::string& path) {
        if (expressionAst.is_string()) {
            const std::string variable = expressionAst.get<std::string>();

            if (!targetVariables.contains(variable)) {
                parseResult.valid = false;
                parseResult.errors.push_back({
                    {"check", "target-variables"},
                    {"path", path},
                    {"message", "Variable '" + variable + "' is not a current-state symbol of the target loop."}
                });
            }

            return;
        }

        if (expressionAst.is_object() && expressionAst.contains("args") && expressionAst.at("args").is_array()) {
            for (std::size_t i = 0; i < expressionAst.at("args").size(); ++i) {
                checkExpressionAst(expressionAst.at("args").at(i), path + ".args[" + std::to_string(i) + "]");
            }
        }
    };

    for (std::size_t i = 0; i < candidate.at("candidate_expressions").size(); ++i) {
        const nlohmann::json& candidateExpression = candidate.at("candidate_expressions").at(i);

        if (candidateExpression.is_object() && candidateExpression.contains("expression_ast")) {
            checkExpressionAst(candidateExpression.at("expression_ast"), "$.candidate_expressions[" + std::to_string(i) + "].expression_ast");
        }
    }
}

// Checks that each expression_ast derives from the required typed nonterminal of the supplied candidate grammar.
static void checkGrammarAndTypes(const nlohmann::json& candidate, const std::filesystem::path& candidateGrammarPath, ParseResult& parseResult) {
    if (!candidate.is_object() || !candidate.contains("candidate_expressions") || !candidate.at("candidate_expressions").is_array()) {
        return;
    }

    struct GrammarToken {
        enum class Kind {
            Quoted,
            Identifier
        } kind;
        std::string text;
    };

    struct GrammarRule {
        enum class Kind {
            Literal,
            Reference,
            Application
        } kind;
        std::string value;
        std::vector<std::string> arguments;
    };

    std::map<std::string, std::vector<GrammarRule>> productions;

    auto trim = [](const std::string& value) -> std::string {
        const std::size_t begin = value.find_first_not_of(" \t\r\n");
        if (begin == std::string::npos) {
            return "";
        }
        const std::size_t end = value.find_last_not_of(" \t\r\n");
        return value.substr(begin, end - begin + 1);
    };

    auto tokenizeAlternative = [&](const std::string& alternative) -> std::vector<GrammarToken> {
        std::vector<GrammarToken> tokens;
        std::size_t i = 0;
        while (i < alternative.size()) {
            if (std::isspace(static_cast<unsigned char>(alternative[i]))) {
                ++i;
                continue;
            }
            if (alternative[i] == '"') {
                const std::size_t close = alternative.find('"', i + 1);
                if (close == std::string::npos) {
                    throw std::runtime_error("Unterminated quoted terminal in grammar alternative: " + alternative);
                }
                tokens.push_back({
                    GrammarToken::Kind::Quoted,
                    alternative.substr(i + 1, close - i - 1)
                });
                i = close + 1;
                continue;
            }
            if (std::isalpha(static_cast<unsigned char>(alternative[i])) || alternative[i] == '_') {
                std::size_t j = i + 1;
                while (j < alternative.size() && (std::isalnum(static_cast<unsigned char>(alternative[j])) || alternative[j] == '_')) {
                    ++j;
                }
                tokens.push_back({
                    GrammarToken::Kind::Identifier,
                    alternative.substr(i, j - i)
                });
                i = j;
                continue;
            }
            throw std::runtime_error("Unexpected token in grammar alternative: " + alternative.substr(i));
        }
        return tokens;
    };

    auto parseAlternative = [&](const std::string& alternative) -> GrammarRule {
        const std::vector<GrammarToken> tokens = tokenizeAlternative(alternative);
        if (tokens.empty()) {
            throw std::runtime_error("Empty grammar alternative.");
        }
        if (tokens.size() == 1) {
            if (tokens.at(0).kind == GrammarToken::Kind::Quoted) {
                return {
                    GrammarRule::Kind::Literal,
                    tokens.at(0).text,
                    {}
                };
            }
            return {
                GrammarRule::Kind::Reference,
                tokens.at(0).text,
                {}
            };
        }
        if (tokens.size() < 4 || tokens.at(0).kind != GrammarToken::Kind::Quoted || tokens.at(1).kind != GrammarToken::Kind::Quoted || tokens.at(1).text != "(" || tokens.back().kind != GrammarToken::Kind::Quoted || tokens.back().text != ")") {
            throw std::runtime_error("Unsupported grammar alternative: " + alternative);
        }
        GrammarRule rule{
            GrammarRule::Kind::Application,
            tokens.at(0).text,
            {}
        };
        std::size_t i = 2;
        bool expectArgument = true;
        while (i + 1 < tokens.size()) {
            if (expectArgument) {
                if (tokens.at(i).kind != GrammarToken::Kind::Identifier) {
                    throw std::runtime_error("Expected a nonterminal argument in grammar alternative: " + alternative);
                }
                rule.arguments.push_back(tokens.at(i).text);
                expectArgument = false;
                ++i;
            }
            else {
                if (tokens.at(i).kind != GrammarToken::Kind::Quoted || tokens.at(i).text != ",") {
                    throw std::runtime_error("Expected ',' in grammar alternative: " + alternative);
                }
                expectArgument = true;
                ++i;
            }
        }
        if (expectArgument || rule.arguments.empty()) {
            throw std::runtime_error("Malformed argument list in grammar alternative: " + alternative);
        }
        return rule;
    };

    std::set<std::string> activeMatches;
    std::function<bool(const std::string&, const nlohmann::json&)> derivesFrom = [&](const std::string& nonterminal, const nlohmann::json& expressionAst) -> bool {
        if (nonterminal == "Integer") {
            return expressionAst.is_number_integer() || expressionAst.is_number_unsigned();
        }
        if (nonterminal == "NonNegativeInteger") {
            if (expressionAst.is_number_unsigned()) {
                return true;
            }
            return expressionAst.is_number_integer() && expressionAst.get<long long>() >= 0;
        }
        if (nonterminal == "Variable") {
            return expressionAst.is_string();
        }
        const auto production = productions.find(nonterminal);
        if (production == productions.end()) {
            return false;
        }
        const std::string matchKey = nonterminal + "\n" + expressionAst.dump();
        if (!activeMatches.insert(matchKey).second) {
            return false;
        }
        for (const GrammarRule& rule : production->second) {
            bool matched = false;
            if (rule.kind == GrammarRule::Kind::Literal) {
                if (rule.value == "true") {
                    matched = expressionAst.is_boolean() && expressionAst.get<bool>();
                }
                else if (rule.value == "false") {
                    matched = expressionAst.is_boolean() && !expressionAst.get<bool>();
                }
                else {
                    matched = expressionAst.is_string() && expressionAst.get<std::string>() == rule.value;
                }
            }
            else if (rule.kind == GrammarRule::Kind::Reference) {
                matched = derivesFrom(rule.value, expressionAst);
            }
            else if (expressionAst.is_object() && expressionAst.size() == 2 && expressionAst.contains("op") && expressionAst.at("op").is_string() && expressionAst.contains("args") && expressionAst.at("args").is_array() && expressionAst.at("op").get<std::string>() == rule.value && expressionAst.at("args").size() == rule.arguments.size()) {
                matched = true;
                for (std::size_t i = 0; i < rule.arguments.size(); ++i) {
                    if (!derivesFrom(rule.arguments.at(i), expressionAst.at("args").at(i))) {
                        matched = false;
                        break;
                    }
                }
            }
            if (matched) {
                activeMatches.erase(matchKey);
                return true;
            }
        }
        activeMatches.erase(matchKey);
        return false;
    };

    std::ifstream grammarStream(candidateGrammarPath);
    if (!grammarStream) {
        throw std::runtime_error(std::string(strerror(errno)) + ": " + candidateGrammarPath.string());
    }
    std::ostringstream grammarBuffer;
    grammarBuffer << grammarStream.rdbuf();
    const std::string grammarText = grammarBuffer.str();

    std::string currentNonterminal;
    std::string rawLine;
    std::istringstream lineStream(grammarText);
    while (std::getline(lineStream, rawLine)) {
        std::string line = trim(rawLine);
        if (line.empty()) {
            continue;
        }
        const std::size_t assign = line.find("::=");
        std::string alternativesText;
        if (assign != std::string::npos) {
            currentNonterminal = trim(line.substr(0, assign));
            if (currentNonterminal.empty()) {
                throw std::runtime_error("Grammar production has an empty left-hand side.");
            }
            alternativesText = trim(line.substr(assign + 3));
        }
        else {
            if (currentNonterminal.empty()) {
                throw std::runtime_error("Grammar alternative appears before any production.");
            }
            if (!line.empty() && line.front() == '|') {
                line = trim(line.substr(1));
            }
            alternativesText = line;
        }
        if (currentNonterminal == "Variable" || currentNonterminal == "Integer" || currentNonterminal == "NonNegativeInteger" || alternativesText.empty()) {
            continue;
        }
        std::vector<std::string> alternatives;
        bool inQuote = false;
        std::size_t start = 0;
        for (std::size_t i = 0; i < alternativesText.size(); ++i) {
            if (alternativesText[i] == '"') {
                inQuote = !inQuote;
            }
            else if (alternativesText[i] == '|' && !inQuote) {
                const std::string alternative = trim(alternativesText.substr(start, i - start));
                if (!alternative.empty()) {
                    alternatives.push_back(alternative);
                }
                start = i + 1;
            }
        }
        const std::string finalAlternative = trim(alternativesText.substr(start));
        if (!finalAlternative.empty()) {
            alternatives.push_back(finalAlternative);
        }
        for (const std::string& alternative : alternatives) {
            productions[currentNonterminal].push_back(parseAlternative(alternative));
        }
    }
    for (const char* required : {"BoolExpr", "ArithExpr", "RankingExpr"}) {
        const auto production = productions.find(required);
        if (production == productions.end() || production->second.empty()) {
            throw std::runtime_error("Candidate grammar has no alternatives for " + std::string(required) + ".");
        }
    }

    for (std::size_t i = 0; i < candidate.at("candidate_expressions").size(); ++i) {
        const nlohmann::json& candidateExpression = candidate.at("candidate_expressions").at(i);
        if (!candidateExpression.is_object() || !candidateExpression.contains("expression_kind") || !candidateExpression.at("expression_kind").is_string() || !candidateExpression.contains("expression_ast")) {
            continue;
        }
        const std::string expressionKind = candidateExpression.at("expression_kind").get<std::string>();
        std::string requiredNonterminal;
        if (expressionKind == "invariant" || expressionKind == "recurrent-set") {
            requiredNonterminal = "BoolExpr";
        }
        else if (expressionKind == "ranking-function") {
            requiredNonterminal = "RankingExpr";
        }
        else {
            continue;
        }
        const std::string path = "$.candidate_expressions[" + std::to_string(i) + "].expression_ast";
        if (!derivesFrom(requiredNonterminal, candidateExpression.at("expression_ast"))) {
            parseResult.valid = false;
            parseResult.errors.push_back({
                {"check", "grammar-and-types"},
                {"path", path},
                {"message", "expression_ast does not derive from " + requiredNonterminal + " for expression_kind '" + expressionKind + "'."}
            });
        }
    }
}

ParseResult CandidateParser::parse(const std::filesystem::path& candidatePath, const std::string& loopId, const std::filesystem::path& loopInformationDirectory, const std::filesystem::path& candidateGrammarPath, const std::filesystem::path& refinementFeedbackPath) {
    ParseResult parseResult;
    nlohmann::json candidate;

    try {
        checkStructure(candidate, candidatePath, parseResult);

        checkLoopId(candidate, loopId, parseResult);

        checkCandidateKind(candidate, parseResult);

        checkCandidateExpressions(candidate, parseResult);

        checkVariables(candidate, loopId, loopInformationDirectory, parseResult);

        checkGrammarAndTypes(candidate, candidateGrammarPath, parseResult);

        std::ofstream parsingFeedbackStream(refinementFeedbackPath, std::ios::app);
        if (!parsingFeedbackStream) {
            throw std::runtime_error(std::string(strerror(errno)) + ": " + refinementFeedbackPath.string());
        }
        parsingFeedbackStream << "==================== SYNTACTIC FEEDBACK ====================\n"
                              << "TARGET_LOOP: " << loopId << "\n";
        if (candidate.is_object() && candidate.contains("candidate_kind") && candidate.at("candidate_kind").is_string()) {
            parsingFeedbackStream << "CANDIDATE_KIND: " << candidate.at("candidate_kind").get<std::string>() << "\n\n";
        }
        if (candidate.is_object() && candidate.contains("candidate_expressions") && candidate.at("candidate_expressions").is_array()) {
            for (const auto& candidateExpression : candidate.at("candidate_expressions")) {
                if (!candidateExpression.is_object() || !candidateExpression.contains("expression_kind") || !candidateExpression.at("expression_kind").is_string() || !candidateExpression.contains("expression_ast")) {
                    continue;
                }
                const std::string expressionKind = candidateExpression.at("expression_kind").get<std::string>();
                if (expressionKind == "invariant") {
                    parsingFeedbackStream << "INVARIANT:\n";
                }
                else if (expressionKind == "ranking-function") {
                    parsingFeedbackStream << "RANKING_FUNCTION:\n";
                }
                else if (expressionKind == "recurrent-set") {
                    parsingFeedbackStream << "RECURRENT_SET:\n";
                }
                else {
                    continue;
                }
                parsingFeedbackStream << candidateExpression.at("expression_ast").dump(2) << "\n\n";
            }
        }
        parsingFeedbackStream << "FEEDBACK:\n";
        if (parseResult.valid) {
            parsingFeedbackStream << "No syntactic issues.\n\n";
        }
        else {
            parsingFeedbackStream << nlohmann::json(parseResult.errors).dump(2) << "\n\n";
        }
        if (!parsingFeedbackStream) {
            throw std::runtime_error("Failed to append refinement feedback: " + refinementFeedbackPath.string());
        }

        parseResult.success = true;
    }
    catch (const std::exception& ex) {
        std::cerr << "CandidateParser::parse error: " << ex.what() << '\n';
        return parseResult;
    }

    return parseResult;
}