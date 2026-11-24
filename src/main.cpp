#include <sstream>
#include <iostream>
#include <sys/wait.h>
// >>> NEXUS CHANGE BEGIN [4.7 - explicit dependencies for summary parsing]
#include <algorithm>
#include <map>
#include <set>
#include <vector>
// <<< NEXUS CHANGE END [4.7 - explicit dependencies for summary parsing]
// >>> NEXUS CHANGE BEGIN [5.1 - explicit candidate-history dependencies]
#include <fstream>
#include <iterator>
// <<< NEXUS CHANGE END [5.1 - explicit candidate-history dependencies]

#include "clang/Tooling/Tooling.h"

#include "../include/inline_attribute_injector.h"
#include "../include/loop_information_extractor.h"
#include "../include/candidate_synthesizer.h"
#include "../include/candidate_parser.h"
#include "../include/validator_generator.h"
#include "../include/result_recorder.h"

// >>> NEXUS CHANGE BEGIN [4.1 - typed validator outcomes and exact proof-obligation parsing]
// A verdict is never inferred from human-readable output or from another
// candidate kind. Missing, malformed, contradictory or partial summaries are
// execution errors, not proof successes. Timeout remains the existing exit 124.
enum class InternalValidationStatus {
    Valid, Invalid, Unknown, Unsupported, Timeout, Error
};

struct InternalValidationResult {
    InternalValidationStatus status = InternalValidationStatus::Error;
    nlohmann::json summary;
};

static InternalValidationResult parseValidationSummary(const std::string& output,
                                                       const std::string& expectedLoopId,
                                                       const std::string& expectedKind) {
    static const std::string marker = "VALIDATION_SUMMARY_JSON:";
    nlohmann::json report;
    int count = 0;
    std::istringstream lines(output);
    std::string line;
    while (std::getline(lines, line)) {
        if (line.rfind(marker, 0) == 0) {
            ++count;
            report = nlohmann::json::parse(line.substr(marker.size()), nullptr, false);
        }
    }
    if (count != 1 || !report.is_object()) {
        throw std::runtime_error("Expected exactly one valid JSON validator summary.");
    }
    auto stringField = [&](const nlohmann::json& object, const char* key) -> std::string {
        if (!object.is_object() || !object.contains(key) || !object.at(key).is_string()) {
            throw std::runtime_error(std::string("Malformed validator field: ") + key);
        }
        return object.at(key).get<std::string>();
    };
    if (stringField(report, "loop_id") != expectedLoopId ||
        stringField(report, "candidate_kind") != expectedKind) {
        throw std::runtime_error("Validator summary does not match the target loop and candidate kind.");
    }
    const std::string overall = stringField(report, "status");
    if (overall == "unsupported") {
        if (!report.contains("reason") || !report.at("reason").is_string() ||
            !report.contains("checks") || !report.at("checks").is_array() ||
            !report.at("checks").empty()) {
            throw std::runtime_error("Malformed unsupported validation summary.");
        }
        return {InternalValidationStatus::Unsupported, report};
    }
    if (overall != "valid" && overall != "invalid" && overall != "unknown") {
        throw std::runtime_error("Unexpected validator outcome: " + overall);
    }
    if (!report.contains("checks") || !report.at("checks").is_array() ||
        !report.contains("components") || !report.at("components").is_object()) {
        throw std::runtime_error("Validator summary is missing checks or components.");
    }
    // Expected query polarity is part of the proof-obligation contract.
    const std::map<std::string, std::pair<std::string, std::string>> obligations =
        expectedKind == "terminating" ?
        std::map<std::string, std::pair<std::string, std::string>>{
            {"INVARIANT_INITIALIZATION", {"invariant", "unsat"}},
            {"INVARIANT_PRESERVATION", {"invariant", "unsat"}},
            {"RANKING_NONNEGATIVITY", {"ranking_function", "unsat"}},
            {"RANKING_DECREASE", {"ranking_function", "unsat"}}
        } :
        std::map<std::string, std::pair<std::string, std::string>>{
            // >>> NEXUS CHANGE BEGIN [8.4 - Enforce the existential non-termination validator contract]
            // #8 replaces universal guard/closure/no-exit obligations with
            // one existential progress obligation, in addition to the
            // reachable recurrent-state witness. Both checks are mandatory:
            // do not accept a partial or mixed old/new validator summary.
            {"RECURRENT_REACHABILITY", {"recurrent_set", "sat"}},
            {"RECURRENT_EXISTENTIAL_PROGRESS", {"recurrent_set", "unsat"}}
            // <<< NEXUS CHANGE END [8.4 - Enforce the existential non-termination validator contract]
        };
    if (report.at("checks").size() != obligations.size()) {
        throw std::runtime_error("Incomplete set of Z3 proof obligations.");
    }
    std::map<std::string, std::vector<std::string>> componentResults;
    std::set<std::string> seen;
    for (const auto& check : report.at("checks")) {
        const std::string name = stringField(check, "name");
        const auto obligation = obligations.find(name);
        if (obligation == obligations.end() || !seen.insert(name).second) {
            throw std::runtime_error("Unknown or repeated proof obligation: " + name);
        }
        const std::string expected = stringField(check, "expected");
        const std::string observed = stringField(check, "observed");
        const std::string status = stringField(check, "status");
        if (expected != obligation->second.second ||
            (observed != "sat" && observed != "unsat" && observed != "unknown") ||
            status != (observed == "unknown" ? "unknown" : (observed == expected ? "valid" : "invalid"))) {
            throw std::runtime_error("Contradictory Z3 result for " + name);
        }
        componentResults[obligation->second.first].push_back(status);
    }
    auto combine = [](const std::vector<std::string>& statuses) {
        if (std::find(statuses.begin(), statuses.end(), "invalid") != statuses.end()) return std::string("invalid");
        if (std::find(statuses.begin(), statuses.end(), "unknown") != statuses.end()) return std::string("unknown");
        return std::string("valid");
    };
    if (report.at("components").size() != componentResults.size()) {
        throw std::runtime_error("Incorrect validator component count.");
    }
    std::vector<std::string> componentStatuses;
    for (const auto& [component, checkStatuses] : componentResults) {
        const std::string computed = combine(checkStatuses);
        if (stringField(report.at("components"), component.c_str()) != computed) {
            throw std::runtime_error("Validator component status contradicts Z3 checks: " + component);
        }
        componentStatuses.push_back(computed);
    }
    if (combine(componentStatuses) != overall) {
        throw std::runtime_error("Overall validator status contradicts proof obligations.");
    }
    return {
        overall == "valid" ? InternalValidationStatus::Valid :
        overall == "invalid" ? InternalValidationStatus::Invalid : InternalValidationStatus::Unknown,
        report
    };
}
// <<< NEXUS CHANGE END [4.1 - typed validator outcomes and exact proof-obligation parsing]

// >>> NEXUS CHANGE BEGIN [5.2 - exact per-loop candidate history, no validator cache]
// Compare canonical JSON documents, not hash values. A duplicate is only an
// identical candidate (not merely a witness of the same kind). This check
// avoids redundant Z3 invocations; it never counts an old proof as a new one.
static std::string canonicalCandidateKey(const std::filesystem::path& candidatePath) {
    std::ifstream input(candidatePath);
    if (!input) {
        throw std::runtime_error("Cannot read synthesized candidate: " + candidatePath.string());
    }
    const std::string raw((std::istreambuf_iterator<char>(input)), std::istreambuf_iterator<char>());
    const nlohmann::json parsed = nlohmann::json::parse(raw, nullptr, false);
    return parsed.is_discarded() ? "raw:" + raw : "json:" + parsed.dump();
}

static void saveCandidateAttemptHistory(const std::filesystem::path& historyPath,
                                        const nlohmann::json& history) {
    std::ofstream output(historyPath, std::ios::trunc);
    if (!output) {
        throw std::runtime_error("Cannot write candidate history: " + historyPath.string());
    }
    output << history.dump(2) << '\n';
    if (!output) {
        throw std::runtime_error("Failed to write candidate history: " + historyPath.string());
    }
}

static nlohmann::json newCandidateAttempt(const std::filesystem::path& candidatePath,
                                          int attemptNumber, const std::string& kind) {
    std::ifstream input(candidatePath);
    if (!input) {
        throw std::runtime_error("Cannot read candidate for history: " + candidatePath.string());
    }
    const std::string raw((std::istreambuf_iterator<char>(input)), std::istreambuf_iterator<char>());
    const nlohmann::json parsed = nlohmann::json::parse(raw, nullptr, false);
    nlohmann::json item = {
        {"attempt", attemptNumber},
        {"candidate_kind", kind},
        {"outcome", "generated"}
    };
    // Preserve compact preceding witnesses for LLM deduplication guidance.
    // Avoid ballooning prompts with very large candidate ASTs.
    if (!parsed.is_discarded() && parsed.dump().size() <= 3000) {
        item["candidate"] = parsed;
    }
    else {
        item["candidate_omitted_large_or_malformed"] = true;
    }
    return item;
}

static void appendDuplicateControlFeedback(const std::filesystem::path& feedbackPath,
                                            int earlierAttempt) {
    std::ofstream output(feedbackPath, std::ios::app);
    if (!output) {
        throw std::runtime_error("Cannot append duplicate-candidate feedback: " + feedbackPath.string());
    }
    output << "\n===================== REFINEMENT CONTROL FEEDBACK =====================\n"
           << "The new candidate duplicates attempt " << earlierAttempt
           << " exactly. It has already been attempted; no proof was inferred "
              "from this repetition. Produce a genuinely different witness "
              "using the loop semantics and prior validator feedback. "
              "Do not infer that the opposite termination classification is true "
              "merely because one candidate failed.\n";
}
// <<< NEXUS CHANGE END [5.2 - exact per-loop candidate history, no validator cache]

std::chrono::steady_clock::time_point startTime;

int timeout = 0;

class TimeoutException : public std::runtime_error {
public:
    TimeoutException() : std::runtime_error("Analysis timed out.") {}
};

static long getRemainingTimeoutMilliseconds() {
    if (timeout <= 0) {
        return 0;
    }
    const long elapsedMilliseconds = static_cast<long>(std::chrono::duration_cast<std::chrono::milliseconds>(std::chrono::steady_clock::now() - startTime).count());
    const long remainingMilliseconds = timeout * 1000L - elapsedMilliseconds;
    if (remainingMilliseconds <= 0) {
        throw TimeoutException();
    }
    return remainingMilliseconds;
}

static void checkTimeout() {
    if (timeout > 0) {
        getRemainingTimeoutMilliseconds();
    }
}

static int recordResult(ResultRecorder& resultRecorder, ProgramResult& programResult, std::vector<LoopResult>& loopResults, const std::string& llmModel, const std::filesystem::path& resultsPath) {
    for (auto& loopResult : loopResults) {
        loopResult.finalAnalysisTime = loopResult.loopInformationExtractionTime + loopResult.initialSynthesisTime + loopResult.syntacticRefinementTime + loopResult.semanticRefinementTime + loopResult.syntacticCheckTime + loopResult.semanticCheckTime;
    }

    if (loopResults.empty()) {
        programResult.firstVerdict = "unknown";
    }
    else {
        programResult.firstVerdict = "terminating";
        for (const auto& loopResult : loopResults) {
            if (loopResult.firstVerdict == "non-terminating") {
                programResult.firstVerdict = "non-terminating";
                break;
            }
            if (loopResult.firstVerdict == "unknown") {
                programResult.firstVerdict = "unknown";
            }
        }
    }

    programResult.firstSemanticCheckPassed = !loopResults.empty();
    for (const auto& loopResult : loopResults) {
        if (!loopResult.firstSemanticCheckPassed) {
            programResult.firstSemanticCheckPassed = false;
            break;
        }
    }

    programResult.finalAnalysisTime = programResult.loopInformationExtractionTime + programResult.initialSynthesisTime + programResult.syntacticRefinementTime + programResult.semanticRefinementTime + programResult.syntacticCheckTime + programResult.semanticCheckTime;

    std::cout << "Verdict: " << programResult.finalVerdict << "\n";
    std::cout << "Runtime: " << programResult.finalAnalysisTime << " milliseconds\n";

    if (!resultRecorder.record(programResult, loopResults, llmModel, resultsPath)) {
        std::cerr << "Failed to record experiment results.\n";
        return 1;
    }

    return 0;
}

static bool hasTerminatingParent(const std::string& unresolvedLoopId, const std::string& terminatingLoopId, const std::vector<loopInformation>& loopInformationList) {
    if (unresolvedLoopId == terminatingLoopId) {
        return false;
    }
    std::string currentLoopId = unresolvedLoopId;
    while (true) {
        const loopInformation* currentLoop = nullptr;
        for (const auto& loop : loopInformationList) {
            if (loop.id == currentLoopId) {
                currentLoop = &loop;
                break;
            }
        }
        if (currentLoop == nullptr) {
            return false;
        }
        if (!currentLoop->parent.has_value()) {
            return false;
        }
        const std::string& parentLoopId = currentLoop->parent.value();
        if (parentLoopId == terminatingLoopId) {
            return true;
        }
        currentLoopId = parentLoopId;
    }
}

int main(int argc, char *argv[]) {
    if (argc < 6) {
        std::cerr << "Usage: ./Nexus <path/to/SourceCode.c> llm-model=<gpt-5.6-terra|gpt-oss-20b|Qwen3-8B|CodeLlama-7B-Instruct> max-syntactic-refinements=X max-semantic-refinements=X timeout=X(s)\n";
        return 1;
    }

    startTime = std::chrono::steady_clock::now();

    std::string llmModel;
    std::filesystem::path resultsPath;

    ProgramResult programResult;
    std::vector<LoopResult> loopResults;
    ResultRecorder resultRecorder;

    int activeLoopResultIndex = -1;

    try {
        std::filesystem::path toolPath = std::filesystem::canonical(argv[0]);
        std::filesystem::path projectRoot = toolPath.parent_path().parent_path();

        std::filesystem::path cPath = std::filesystem::canonical(argv[1]);

        programResult.programPath = cPath.string();
        resultsPath = projectRoot / "results_Nexus.xlsx";

        std::ifstream cStream(cPath);
        if (!cStream) {
            throw std::runtime_error(std::string(strerror(errno)) + ": " + cPath.string());
        }
        std::stringstream cBuffer;
        cBuffer << cStream.rdbuf();
        std::string cFile = cBuffer.str();

        std::string cName = cPath.stem().string();
        std::string cExtension = cPath.extension().string();
        std::filesystem::path cDirectory = cPath.parent_path();

        llmModel = argv[2];
        llmModel.erase(llmModel.find("llm-model="), std::string("llm-model=").length());

        std::string maxSyntacticRefinementsStr = argv[3];
        maxSyntacticRefinementsStr.erase(maxSyntacticRefinementsStr.find("max-syntactic-refinements="), std::string("max-syntactic-refinements=").length());
        int maxSyntacticRefinements = std::stoi(maxSyntacticRefinementsStr);

        std::string maxSemanticRefinementsStr = argv[4];
        maxSemanticRefinementsStr.erase(maxSemanticRefinementsStr.find("max-semantic-refinements="), std::string("max-semantic-refinements=").length());
        int maxSemanticRefinements = std::stoi(maxSemanticRefinementsStr);

        std::string timeoutStr = argv[5];
        timeoutStr.erase(timeoutStr.find("timeout="), std::string("timeout=").length());
        timeout = std::stoi(timeoutStr);

        std::filesystem::path generatedDirectory  = cDirectory / "generated";
        if (std::filesystem::exists(generatedDirectory)) {
            std::filesystem::remove_all(generatedDirectory);
        }
        std::filesystem::path loopInformationDirectory  = generatedDirectory / "loop_information";
        std::filesystem::path candidatesDirectory = generatedDirectory / "candidates";
        std::filesystem::path validatorsDirectory = generatedDirectory / "validators";
        std::filesystem::path promptHistoryDirectory = generatedDirectory / "prompt_history";
        std::filesystem::path refinementFeedbackDirectory = generatedDirectory / "refinement_feedback";

        std::filesystem::create_directories(generatedDirectory);
        std::filesystem::create_directories(loopInformationDirectory);
        std::filesystem::create_directories(candidatesDirectory);
        std::filesystem::create_directories(validatorsDirectory);
        std::filesystem::create_directories(promptHistoryDirectory);
        std::filesystem::create_directories(refinementFeedbackDirectory);

        std::filesystem::path candidateGrammarPath = projectRoot/ "candidate_grammar.txt";

        std::cout << "Injecting inline attributes..." << "\n";
        std::set<std::string> entryFunctionNames;
        std::filesystem::path inlineCPath = generatedDirectory / (cName + ".inline" + cExtension);
        bool injectionResult = clang::tooling::runToolOnCodeWithArgs(std::make_unique<InlineAttributeInjectorAction>(inlineCPath, entryFunctionNames), cFile, {"-x", "c", "-std=c11"}, cName + cExtension);
        if (!injectionResult) {
            throw std::runtime_error("Failed to inject inline attributes.");
        }

        std::cout << "Compiling to LLVM bitcode..." << "\n";
        std::filesystem::path inlineBcPath = generatedDirectory / (cName + ".inline.bc");
        std::string inlineBcCommand = "\"" + std::string(NEXUS_CLANG_EXECUTABLE) + "\" -O0 -Xclang -disable-O0-optnone -emit-llvm -c \"" + inlineCPath.string() + "\" -o - | \"" +
                                      std::string(NEXUS_OPT_EXECUTABLE) + "\" -passes=always-inline - -o \"" + inlineBcPath.string() + "\"";
        int inlineBcResult = std::system(inlineBcCommand.c_str());
        if (inlineBcResult != 0 || !std::filesystem::exists(inlineBcPath) || std::filesystem::file_size(inlineBcPath) == 0) {
            throw std::runtime_error("Failed to compile to LLVM bitcode and inline functions.");
        }

        std::cout << "Disassembling LLVM bitcode to LLVM IR..." << "\n";
        std::filesystem::path inlineLlPath = generatedDirectory / (cName + ".inline.ll");
        std::string inlineLlCommand = "\"" + std::string(NEXUS_LLVM_DIS_EXECUTABLE) + "\" \"" + inlineBcPath.string() + "\" -o \"" + inlineLlPath.string() + "\"";
        int inlineLlResult = std::system(inlineLlCommand.c_str());
        if (inlineLlResult != 0) {
            throw std::runtime_error("Failed to disassemble LLVM bitcode to LLVM IR.");
        }

        std::vector<loopInformation> loopInformationList;
        loopInformationExtractor loopInformationExtractor;

        const auto loopInformationExtractionStart = std::chrono::steady_clock::now();

        std::cout << "Extracting loop information..." << "\n";
        if (!loopInformationExtractor.extract(inlineBcPath, loopInformationDirectory, entryFunctionNames)) {
            programResult.loopInformationExtractionTime = std::chrono::duration_cast<std::chrono::milliseconds>(std::chrono::steady_clock::now() - loopInformationExtractionStart).count();

            throw std::runtime_error("Failed to extract loop information.");
        }

        // >>> NEXUS CHANGE BEGIN [2.5.2 - accept only certified finite acyclic entries]
        // This is a direct CFG termination certificate, not an LLM witness:
        // there is no loop iteration to synthesize a ranking function for.
        // Unknown calls, genuine cycles, and incomplete source-loop tags
        // cannot reach this branch and remain `unknown` as before.
        if (loopInformationExtractor.hasAcyclicTerminationCertificate()) {
            programResult.loopInformationExtractionTime =
                std::chrono::duration_cast<std::chrono::milliseconds>(
                    std::chrono::steady_clock::now() - loopInformationExtractionStart).count();
            programResult.totalLoops = 0;
            programResult.analyzedLoops = 0;
            programResult.finalVerdict = "terminating";
            std::cout << "No recurring CFG cycle; termination certified structurally for all entry functions.\n";
            return recordResult(resultRecorder, programResult, loopResults, llmModel, resultsPath);
        }
        // <<< NEXUS CHANGE END [2.5.2 - accept only certified finite acyclic entries]
        std::cout << "Ordering loop information..." << "\n";
        if (!loopInformationExtractor.order(loopInformationDirectory, loopInformationList)) {
            programResult.loopInformationExtractionTime = std::chrono::duration_cast<std::chrono::milliseconds>(std::chrono::steady_clock::now() - loopInformationExtractionStart).count();

            throw std::runtime_error("Failed to order loop information.");
        }

        programResult.loopInformationExtractionTime = std::chrono::duration_cast<std::chrono::milliseconds>(std::chrono::steady_clock::now() - loopInformationExtractionStart).count();

        programResult.totalLoops = static_cast<int>(loopInformationList.size());

        std::set<std::string> unresolvedLoops;

        CandidateSynthesizer candidateSynthesizer;
        CandidateParser candidateParser;
        ValidatorGenerator validatorGenerator;

        for (const auto& loopInformation : loopInformationList) {
            checkTimeout();

            std::cout << "Analyzing loop " << loopInformation.id << ":\n";

            ++programResult.analyzedLoops;

            loopResults.emplace_back();
            activeLoopResultIndex = static_cast<int>(loopResults.size() - 1);
            LoopResult& loopResult = loopResults.back();
            loopResult.loopId = loopInformation.id;
            loopResult.loopInformationExtractionTime = programResult.loopInformationExtractionTime / programResult.totalLoops;

            std::filesystem::path candidatePath = candidatesDirectory / (loopInformation.id + "_candidate.json");
            std::filesystem::path validatorPath = validatorsDirectory / ("validate_" + loopInformation.id + ".py");
            std::filesystem::path promptHistoryPath = promptHistoryDirectory / (loopInformation.id + "_prompt_history.txt");
            std::filesystem::path refinementFeedbackPath = refinementFeedbackDirectory / (loopInformation.id + "_refinement_feedback.txt");

            int promptAttempt = 0;
            int semanticRefinements = 0;
            SynthesisMode synthesisMode = Initial;
            // >>> NEXUS CHANGE BEGIN [5.3 - per-loop witness-attempt tracking]
            const std::filesystem::path candidateHistoryPath = candidatesDirectory /
                (loopInformation.id + "_attempt_history.json");
            nlohmann::json candidateAttemptHistory = nlohmann::json::array();
            std::map<std::string, int> firstAttemptForCandidate;
            saveCandidateAttemptHistory(candidateHistoryPath, candidateAttemptHistory);
            // <<< NEXUS CHANGE END [5.3 - per-loop witness-attempt tracking]
            // >>> NEXUS CHANGE BEGIN [4.2 - bind validator result to accepted candidate kind]
            std::string candidateKindForValidation;
            // <<< NEXUS CHANGE END [4.2 - bind validator result to accepted candidate kind]

            while (true) { // Semantic refinement
                checkTimeout();

                bool loopUnresolved = false;
                int syntacticRefinements = 0;

                while (true) { // Syntactic refinement
                    checkTimeout();

                    if (synthesisMode == Initial) {
                        std::cout << "Synthesizing candidate for loop " << loopInformation.id << "...\n";
                    }
                    else if (synthesisMode == SyntacticRefinement) {
                        std::cout << "Refining candidate for loop " << loopInformation.id << " using syntactic feedback, attempt " << syntacticRefinements << "...\n";
                    }
                    else if (synthesisMode == SemanticRefinement) {
                        std::cout << "Refining candidate for loop " << loopInformation.id << " using semantic feedback, attempt " << semanticRefinements << "...\n";
                    }

                    ++promptAttempt;

                    const SynthesisResult synthesisResult = candidateSynthesizer.synthesize(loopInformation.id, loopInformationDirectory, candidateGrammarPath, refinementFeedbackPath, candidatePath, llmModel, synthesisMode, getRemainingTimeoutMilliseconds(), promptAttempt, promptHistoryPath);

                    if (synthesisResult.requestAttempted) {
                        if (synthesisMode == Initial) {
                            ++loopResult.initialSynthesisCalls;
                            ++programResult.initialSynthesisCalls;
                        }
                        else if (synthesisMode == SyntacticRefinement) {
                            ++loopResult.syntacticRefinementCalls;
                            ++programResult.syntacticRefinementCalls;
                        }
                        else if (synthesisMode == SemanticRefinement) {
                            ++loopResult.semanticRefinementCalls;
                            ++programResult.semanticRefinementCalls;
                        }
                    }

                    if (synthesisMode == Initial) {
                        if (synthesisResult.kind == "terminating" || synthesisResult.kind == "non-terminating") {
                            loopResult.firstVerdict = synthesisResult.kind;
                        }
                        loopResult.firstAnalysisTime += synthesisResult.latency;
                        loopResult.initialSynthesisTime += synthesisResult.latency;
                        loopResult.initialSynthesisInputTokens += synthesisResult.inputTokens;
                        loopResult.initialSynthesisOutputTokens += synthesisResult.outputTokens;
                        loopResult.initialSynthesisCost += synthesisResult.cost;

                        programResult.firstAnalysisTime += synthesisResult.latency;
                        programResult.initialSynthesisTime += synthesisResult.latency;
                        programResult.initialSynthesisInputTokens += synthesisResult.inputTokens;
                        programResult.initialSynthesisOutputTokens += synthesisResult.outputTokens;
                        programResult.initialSynthesisCost += synthesisResult.cost;
                    }
                    else if (synthesisMode == SyntacticRefinement) {
                        loopResult.syntacticRefinementTime += synthesisResult.latency;
                        loopResult.syntacticRefinementInputTokens += synthesisResult.inputTokens;
                        loopResult.syntacticRefinementOutputTokens += synthesisResult.outputTokens;
                        loopResult.syntacticRefinementCost += synthesisResult.cost;

                        programResult.syntacticRefinementTime += synthesisResult.latency;
                        programResult.syntacticRefinementInputTokens += synthesisResult.inputTokens;
                        programResult.syntacticRefinementOutputTokens += synthesisResult.outputTokens;
                        programResult.syntacticRefinementCost += synthesisResult.cost;
                    }
                    else if (synthesisMode == SemanticRefinement) {
                        loopResult.semanticRefinementTime += synthesisResult.latency;
                        loopResult.semanticRefinementInputTokens += synthesisResult.inputTokens;
                        loopResult.semanticRefinementOutputTokens += synthesisResult.outputTokens;
                        loopResult.semanticRefinementCost += synthesisResult.cost;

                        programResult.semanticRefinementTime += synthesisResult.latency;
                        programResult.semanticRefinementInputTokens += synthesisResult.inputTokens;
                        programResult.semanticRefinementOutputTokens += synthesisResult.outputTokens;
                        programResult.semanticRefinementCost += synthesisResult.cost;
                    }

                    if (synthesisResult.requestTimedOut) {
                        throw TimeoutException();
                    }
                    checkTimeout();
                    if (!synthesisResult.synthesisSucceeded) {
                        throw std::runtime_error("Failed to synthesize or refine candidate for loop " + loopInformation.id + ".");
                    }

                    if (synthesisResult.kind != "terminating" && synthesisResult.kind != "non-terminating") {
                        loopUnresolved = true;
                        unresolvedLoops.insert(loopInformation.id);

                        std::cout << "Loop " << loopInformation.id << " is unknown.\n";

                        break;
                    }

                    // >>> NEXUS CHANGE BEGIN [5.4 - reject exact repeated candidates before Z3]
                    const std::string candidateKey = canonicalCandidateKey(candidatePath);
                    const auto [firstAttempt, fresh] = firstAttemptForCandidate.emplace(candidateKey, promptAttempt);
                    nlohmann::json attemptRecord = newCandidateAttempt(
                        candidatePath, promptAttempt, synthesisResult.kind);
                    if (!candidateAttemptHistory.empty()) {
                        const std::string previousKind = candidateAttemptHistory.back().value(
                            "candidate_kind", std::string{});
                        if (!previousKind.empty() && previousKind != synthesisResult.kind) {
                            attemptRecord["classification_changed_from"] = previousKind;
                        }
                    }
                    // A syntax-only repair cannot reclassify a witness. For
                    // semantic refinement, reclassification remains possible,
                    // but it is tracked and STILL requires complete Z3 proof.
                    if (synthesisMode == SyntacticRefinement &&
                        attemptRecord.contains("classification_changed_from")) {
                        attemptRecord["outcome"] = "wrong_kind_for_syntax_repair";
                        candidateAttemptHistory.push_back(std::move(attemptRecord));
                        saveCandidateAttemptHistory(candidateHistoryPath, candidateAttemptHistory);
                        std::ofstream control(refinementFeedbackPath, std::ios::app);
                        if (!control) {
                            throw std::runtime_error("Cannot append syntactic repair feedback.");
                        }
                        control << "\n===================== REFINEMENT CONTROL FEEDBACK =====================\n"
                                << "Syntactic repair must preserve the prior candidate_kind. "
                                   "Repair the grammar error without changing the proof hypothesis.\n";
                        if (syntacticRefinements >= maxSyntacticRefinements) {
                            loopUnresolved = true;
                            unresolvedLoops.insert(loopInformation.id);
                            std::cout << "Loop " << loopInformation.id
                                      << " is unknown after invalid syntax-only reclassification.\n";
                            break;
                        }
                        ++syntacticRefinements;
                        continue;
                    }
                    if (!fresh) {
                        attemptRecord["outcome"] = "duplicate";
                        attemptRecord["duplicate_of_attempt"] = firstAttempt->second;
                        candidateAttemptHistory.push_back(std::move(attemptRecord));
                        saveCandidateAttemptHistory(candidateHistoryPath, candidateAttemptHistory);
                        appendDuplicateControlFeedback(refinementFeedbackPath, firstAttempt->second);
                        std::cout << "Candidate for loop " << loopInformation.id
                                  << " duplicates an earlier attempt; skipping parsing and Z3.\n";
                        // A duplicate still consumes an available LLM refinement
                        // attempt. Otherwise the loop could request indefinitely.
                        if (synthesisMode == SyntacticRefinement) {
                            if (syntacticRefinements >= maxSyntacticRefinements) {
                                loopUnresolved = true;
                            }
                            else {
                                ++syntacticRefinements;
                            }
                        }
                        else {
                            if (semanticRefinements >= maxSemanticRefinements) {
                                loopUnresolved = true;
                            }
                            else {
                                ++semanticRefinements;
                                synthesisMode = SemanticRefinement;
                            }
                        }
                        if (loopUnresolved) {
                            unresolvedLoops.insert(loopInformation.id);
                            std::cout << "Loop " << loopInformation.id
                                      << " is unknown after duplicate refinement attempts.\n";
                            break;
                        }
                        continue;
                    }
                    candidateAttemptHistory.push_back(std::move(attemptRecord));
                    saveCandidateAttemptHistory(candidateHistoryPath, candidateAttemptHistory);
                    // <<< NEXUS CHANGE END [5.4 - reject exact repeated candidates before Z3]

                    std::cout << "Parsing candidate for loop " << loopInformation.id << "...\n";

                    const auto parseStart = std::chrono::steady_clock::now();

                    const ParseResult parseResult = candidateParser.parse(candidatePath, loopInformation.id, loopInformationDirectory, candidateGrammarPath, refinementFeedbackPath);

                    const double parseTime = std::chrono::duration_cast<std::chrono::milliseconds>(std::chrono::steady_clock::now() - parseStart).count();
                    programResult.syntacticCheckTime += parseTime;
                    loopResult.syntacticCheckTime += parseTime;

                    if (!parseResult.success) {
                        throw std::runtime_error("Failed to parse candidate for loop " + loopInformation.id + ".");
                    }

                    if (parseResult.valid) {
                        // >>> NEXUS CHANGE BEGIN [5.5 - record exact grammar acceptance]
                        candidateAttemptHistory.back()["outcome"] = "syntax_valid";
                        saveCandidateAttemptHistory(candidateHistoryPath, candidateAttemptHistory);
                        // <<< NEXUS CHANGE END [5.5 - record exact grammar acceptance]
                        std::cout << "Candidate for loop " << loopInformation.id << " is syntactically valid.\n";
                        // >>> NEXUS CHANGE BEGIN [4.3 - retain the exact validated candidate kind]
                        candidateKindForValidation = synthesisResult.kind;
                        // <<< NEXUS CHANGE END [4.3 - retain the exact validated candidate kind]
                        break;
                    }

                    // >>> NEXUS CHANGE BEGIN [5.6 - record rejected syntax without treating it as proof]
                    candidateAttemptHistory.back()["outcome"] = "syntax_invalid";
                    saveCandidateAttemptHistory(candidateHistoryPath, candidateAttemptHistory);
                    // <<< NEXUS CHANGE END [5.6 - record rejected syntax without treating it as proof]
                    std::cout << "Candidate for loop " << loopInformation.id << " is syntactically invalid.\n";

                    if (syntacticRefinements >= maxSyntacticRefinements) {
                        std::cout << "Maximum number of syntactic refinement attempts reached for loop " << loopInformation.id << ".\n";

                        loopUnresolved = true;
                        unresolvedLoops.insert(loopInformation.id);

                        std::cout << "Loop " << loopInformation.id << " is unknown.\n";

                        break;
                    }

                    ++syntacticRefinements;
                    synthesisMode = SyntacticRefinement;
                }

                if (loopUnresolved) {
                    break;
                }

                std::cout << "Generating validator script for loop " << loopInformation.id << "...\n";

                const auto validatorGenerationStart = std::chrono::steady_clock::now();

                const bool validatorGenerationResult = validatorGenerator.generate(loopInformation.id, loopInformationDirectory, candidatePath, validatorPath, getRemainingTimeoutMilliseconds());

                const double validatorGenerationTime = std::chrono::duration_cast<std::chrono::milliseconds>(std::chrono::steady_clock::now() - validatorGenerationStart).count();
                programResult.semanticCheckTime += validatorGenerationTime;
                loopResult.semanticCheckTime += validatorGenerationTime;

                if (!validatorGenerationResult) {
                    throw std::runtime_error("Failed to generate validator for loop " + loopInformation.id + ".");
                }

                std::cout << "Running validator script for loop " << loopInformation.id << "...\n";

                const std::uintmax_t validationFeedbackStart = std::filesystem::exists(refinementFeedbackPath) ? std::filesystem::file_size(refinementFeedbackPath) : 0;
                std::string validatorRunnerCommand = "\"" + (projectRoot / ".venv" / "bin" / "python").string() + "\" " +
                                                     "\"" + validatorPath.string() + "\" >> \"" + refinementFeedbackPath.string() + "\" 2>&1";

                const auto validatorRunnerStart = std::chrono::steady_clock::now();

                int validatorRunnerResult = std::system(validatorRunnerCommand.c_str());

                const double validatorExecutionTime = std::chrono::duration_cast<std::chrono::milliseconds>(std::chrono::steady_clock::now() - validatorRunnerStart).count();
                programResult.semanticCheckTime += validatorExecutionTime;
                loopResult.semanticCheckTime += validatorExecutionTime;

                if (validatorRunnerResult != -1 && WIFEXITED(validatorRunnerResult) && WEXITSTATUS(validatorRunnerResult) == 124) {
                    throw TimeoutException();
                }
                checkTimeout();
                if (validatorRunnerResult != 0) {
                    throw std::runtime_error("Failed to run validator script for loop " + loopInformation.id + ".");
                }

                std::ifstream validationFeedbackStream(refinementFeedbackPath);
                if (!validationFeedbackStream) {
                    throw std::runtime_error("Failed to read refinement feedback: " + refinementFeedbackPath.string());
                }
                validationFeedbackStream.seekg(static_cast<std::streamoff>(validationFeedbackStart));
                std::string validationFeedbackText((std::istreambuf_iterator<char>(validationFeedbackStream)), std::istreambuf_iterator<char>());

                // >>> NEXUS CHANGE BEGIN [4.4 - trust only the complete typed Z3 summary]
                const InternalValidationResult semanticResult = parseValidationSummary(
                    validationFeedbackText, loopInformation.id, candidateKindForValidation);
                // >>> NEXUS CHANGE BEGIN [5.7 - retain proof-obligation dependencies per attempt]
                // Do not reuse a previous ranking success if the invariant
                // changes. The validator still checks every obligation in full.
                candidateAttemptHistory.back()["outcome"] =
                    "validation_" + semanticResult.summary.at("status").get<std::string>();
                candidateAttemptHistory.back()["components"] =
                    semanticResult.summary.value("components", nlohmann::json::object());
                nlohmann::json failedChecks = nlohmann::json::array();
                if (semanticResult.summary.contains("checks") &&
                    semanticResult.summary.at("checks").is_array()) {
                    for (const auto& check : semanticResult.summary.at("checks")) {
                        if (check.is_object() && check.value("status", std::string{}) != "valid") {
                            failedChecks.push_back({
                                {"name", check.value("name", std::string{})},
                                {"status", check.value("status", std::string{})}
                            });
                        }
                    }
                }
                candidateAttemptHistory.back()["unresolved_checks"] = std::move(failedChecks);
                saveCandidateAttemptHistory(candidateHistoryPath, candidateAttemptHistory);
                // <<< NEXUS CHANGE END [5.7 - retain proof-obligation dependencies per attempt]
                const bool semanticValid = semanticResult.status == InternalValidationStatus::Valid;
                const bool terminatingSemanticValid = semanticValid && candidateKindForValidation == "terminating";
                const bool nonTerminatingSemanticValid = semanticValid && candidateKindForValidation == "non-terminating";
                // <<< NEXUS CHANGE END [4.4 - trust only the complete typed Z3 summary]

                if (semanticRefinements == 0) {
                    loopResult.firstSemanticCheckPassed = semanticValid;
                }

                if (terminatingSemanticValid) {
                    std::cout << "Candidate for loop " << loopInformation.id << " is semantically valid.\n";

                    loopResult.finalVerdict = "terminating";
                    std::cout << "Loop " << loopInformation.id << " is terminating.\n";

                    unresolvedLoops.erase(loopInformation.id);
                    for (auto it = unresolvedLoops.begin(); it != unresolvedLoops.end();) {
                        if (hasTerminatingParent(*it, loopInformation.id, loopInformationList)) {
                            std::cout << "Loop " << *it << " was unknown, but is terminating because parent loop " << loopInformation.id << " is terminating.\n";

                            for (auto& previousLoopResult : loopResults) {
                                if (previousLoopResult.loopId == *it) {
                                    previousLoopResult.finalVerdict = "terminating";
                                    break;
                                }
                            }

                            it = unresolvedLoops.erase(it);
                        }
                        else {
                            ++it;
                        }
                    }

                    break;
                }

                if (nonTerminatingSemanticValid) {
                    std::cout << "Candidate for loop " << loopInformation.id << " is semantically valid.\n";

                    loopResult.finalVerdict = "non-terminating";
                    programResult.finalVerdict = "non-terminating";
                    std::cout << "Loop " << loopInformation.id << " is non-terminating.\n";

                    return recordResult(resultRecorder, programResult, loopResults, llmModel, resultsPath);
                }

                // >>> NEXUS CHANGE BEGIN [4.5 - unsupported extraction does not invite witness repair]
                if (semanticResult.status == InternalValidationStatus::Unsupported) {
                    unresolvedLoops.insert(loopInformation.id);
                    std::cout << "Loop " << loopInformation.id
                              << " is unknown because its extraction is unsupported.\n";
                    break;
                }
                if (semanticResult.status == InternalValidationStatus::Unknown) {
                    std::cout << "Z3 could not decide all proof obligations for loop "
                              << loopInformation.id << "; no verdict is accepted.\n";
                }
                // <<< NEXUS CHANGE END [4.5 - unsupported extraction does not invite witness repair]
                if (semanticRefinements >= maxSemanticRefinements) {
                    std::cout << "Maximum number of semantic refinement attempts reached for loop " << loopInformation.id << ".\n";

                    unresolvedLoops.insert(loopInformation.id);

                    std::cout << "Loop " << loopInformation.id << " is unknown.\n";

                    break;
                }

                // >>> NEXUS CHANGE BEGIN [4.6 - distinguish invalid from undecidable validation]
                std::cout << "Candidate for loop " << loopInformation.id
                          << (semanticResult.status == InternalValidationStatus::Invalid
                              ? " is semantically invalid.\n"
                              : " has undecided semantic obligations.\n");
                // <<< NEXUS CHANGE END [4.6 - distinguish invalid from undecidable validation]

                ++semanticRefinements;
                synthesisMode = SemanticRefinement;
            }

            activeLoopResultIndex = -1;
        }

        if (unresolvedLoops.empty()) {
            programResult.finalVerdict = "terminating";
        }

        return recordResult(resultRecorder, programResult, loopResults, llmModel, resultsPath);
    }

    catch (const TimeoutException& ex) {
        programResult.finalVerdict = "timeout";

        if (activeLoopResultIndex >= 0) {
            loopResults[activeLoopResultIndex].finalVerdict = "timeout";
        }

        std::cerr << ex.what() << "\n";

        const int recordingExitCode = recordResult(resultRecorder, programResult, loopResults, llmModel, resultsPath);

        if (recordingExitCode != 0) {
            return recordingExitCode;
        }

        return 124;
    }

    // >>> NEXUS CHANGE BEGIN [2.5.1 - report unsupported no-loop CFG as unknown]
    // This is an analysis limitation, not a compiler/runtime error and not a
    // proof of either termination or non-termination. No synthetic loop JSON.
    catch (const UnsupportedControlFlowError& ex) {
        programResult.finalVerdict = "unknown";
        std::cerr << "Unsupported extraction: " << ex.what() << "\n";
        return recordResult(resultRecorder, programResult, loopResults, llmModel, resultsPath);
    }
    // <<< NEXUS CHANGE END [2.5.1 - report unsupported no-loop CFG as unknown]
    catch (const std::exception& ex) {
        programResult.finalVerdict = "error";

        if (activeLoopResultIndex >= 0) {
            loopResults[activeLoopResultIndex].finalVerdict = "error";
        }

        std::cerr << ex.what() << "\n";

        const int recordingExitCode = recordResult(resultRecorder, programResult, loopResults, llmModel, resultsPath);

        if (recordingExitCode != 0) {
            return recordingExitCode;
        }

        return 1;
    }
}