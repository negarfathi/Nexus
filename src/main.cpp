#include <sstream>
#include <iostream>
#include <sys/wait.h>

#include "clang/Tooling/Tooling.h"

#include "../include/inline_attribute_injector.h"
#include "../include/loop_information_extractor.h"
#include "../include/candidate_synthesizer.h"
#include "../include/candidate_parser.h"
#include "../include/validator_generator.h"
#include "../include/result_recorder.h"

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
                        std::cout << "Candidate for loop " << loopInformation.id << " is syntactically valid.\n";

                        break;
                    }

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

                const bool terminatingSemanticValid = validationFeedbackText.find("INVARIANT_RESULT: \"valid\"") != std::string::npos && validationFeedbackText.find("RANKING_FUNCTION_RESULT: \"valid\"") != std::string::npos;
                const bool nonTerminatingSemanticValid = validationFeedbackText.find("RECURRENT_SET_RESULT: \"valid\"") != std::string::npos;
                const bool semanticValid = terminatingSemanticValid || nonTerminatingSemanticValid;

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

                if (semanticRefinements >= maxSemanticRefinements) {
                    std::cout << "Maximum number of semantic refinement attempts reached for loop " << loopInformation.id << ".\n";

                    unresolvedLoops.insert(loopInformation.id);

                    std::cout << "Loop " << loopInformation.id << " is unknown.\n";

                    break;
                }

                std::cout << "Candidate for loop " << loopInformation.id << " is semantically invalid.\n";

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