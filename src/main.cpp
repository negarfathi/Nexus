#include <sstream>
#include <iostream>

#include "clang/Tooling/Tooling.h"

#include "../include/inline_attribute_injector.h"
#include "../include/loop_information_extractor.h"
#include "../include/candidate_synthesizer.h"
#include "../include/candidate_parser.h"
#include "../include/validator_generator.h"
#include "../include/experiment_recorder.h"

std::chrono::steady_clock::time_point startTime;

int timeout = 0;

class TimeoutException : public std::runtime_error {
public:
    TimeoutException() : std::runtime_error("Analysis timed out.") {}
};

static void checkTimeout() {
    const double elapsedSeconds = std::chrono::duration<double>(std::chrono::steady_clock::now() - startTime).count();
    if (timeout > 0 && elapsedSeconds >= timeout) {
        throw TimeoutException();
    }
}

static bool isDescendant(const std::string& childId, const std::string& parentId, const std::vector<loopInformation>& loopInformationList) {
    if (childId == parentId) {
        return false;
    }
    std::string currentId = childId;
    while (true) {
        const loopInformation* currentLoop = nullptr;
        for (const auto& loop : loopInformationList) {
            if (loop.id == currentId) {
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
        const std::string& currentParentId = currentLoop->parent.value();
        if (currentParentId == parentId) {
            return true;
        }
        currentId = currentParentId;
    }
}

static int recordExperimentResult(ExperimentRecorder& experimentRecorder, ExperimentResult& experimentResult, const std::filesystem::path& experimentResultsPath) {
    const auto endTime = std::chrono::steady_clock::now();
    experimentResult.totalAnalysisTime = std::chrono::duration_cast<std::chrono::milliseconds>(endTime - startTime).count();

    std::cout << "Program: " << experimentResult.finalVerdict << "\n";
    std::cout << "Runtime: " << experimentResult.totalAnalysisTime << " milliseconds\n";

    if (!experimentRecorder.record(experimentResultsPath, experimentResult)) {
        std::cerr << "Failed to record experiment results.\n";
        return 1;
    }

    return 0;
}

int main(int argc, char *argv[]) {
    if (argc < 6) {
        std::cerr << "Usage: ./Nexus <path/to/SourceCode.c> llm-model=<gpt-oss-20b|Qwen3-8B|CodeLlama-7B-Instruct> max-grammar-refinements=X max-analysis-refinements=X timeout=X(s)\n";
        return 1;
    }

    startTime = std::chrono::steady_clock::now();

    ExperimentResult experimentResult;
    ExperimentRecorder experimentRecorder;
    std::filesystem::path experimentResultsPath;

    try {
        std::filesystem::path toolPath = std::filesystem::canonical(argv[0]);
        std::filesystem::path projectRoot = toolPath.parent_path().parent_path();

        std::filesystem::path cPath = std::filesystem::canonical(argv[1]);

        experimentResult.program = cPath;
        experimentResultsPath = projectRoot / "experiment_results.xlsx";

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

        std::string llmModel = argv[2];
        llmModel.erase(llmModel.find("llm-model="), std::string("llm-model=").length());

        std::string maxGrammarRefinementsStr = argv[3];
        maxGrammarRefinementsStr.erase(maxGrammarRefinementsStr.find("max-grammar-refinements="), std::string("max-grammar-refinements=").length());
        int maxGrammarRefinements = std::stoi(maxGrammarRefinementsStr);

        std::string maxAnalysisRefinementsStr = argv[4];
        maxAnalysisRefinementsStr.erase(maxAnalysisRefinementsStr.find("max-analysis-refinements="), std::string("max-analysis-refinements=").length());
        int maxAnalysisRefinements = std::stoi(maxAnalysisRefinementsStr);

        std::string timeoutStr = argv[5];
        timeoutStr.erase(timeoutStr.find("timeout="), std::string("timeout=").length());
        timeout = std::stoi(timeoutStr);

        std::filesystem::path generatedDirectory  = cDirectory / "generated";
        std::filesystem::path loopInformationDirectory  = generatedDirectory / "loop_information";
        std::filesystem::path candidatesDirectory = generatedDirectory / "candidates";
        std::filesystem::path validatorsDirectory = generatedDirectory / "validators";
        std::filesystem::path refinementFeedbackDirectory = generatedDirectory / "refinement_feedback";

        std::filesystem::create_directories(generatedDirectory);
        std::filesystem::create_directories(loopInformationDirectory);
        std::filesystem::create_directories(candidatesDirectory);
        std::filesystem::create_directories(validatorsDirectory);
        std::filesystem::create_directories(refinementFeedbackDirectory);

        std::filesystem::path candidateGrammarPath = projectRoot/ "candidate_grammar.txt";

        std::cout << "Injecting inline attributes..." << "\n";
        std::filesystem::path inlineCPath = generatedDirectory / (cName + ".inline" + cExtension);
        bool injectionResult = clang::tooling::runToolOnCode(std::make_unique<InlineAttributeInjectorAction>(inlineCPath), cFile);
        if (!injectionResult) {
            throw std::runtime_error("Failed to inject inline attributes.");
        }

        std::cout << "Compiling to LLVM bitcode..." << "\n";
        std::filesystem::path inlineBcPath = generatedDirectory / (cName + ".inline.bc");
        std::string inlineBcCommand = "set -o pipefail; "
                                      "clang -O0 -Xclang -disable-O0-optnone -emit-llvm -c \"" + inlineCPath.string() + "\" -o - "
                                      "| opt -passes=always-inline - -o \"" + inlineBcPath.string() + "\"";
        int inlineBcResult = std::system(inlineBcCommand.c_str());
        if (inlineBcResult != 0) {
            throw std::runtime_error("Failed to compile to LLVM bitcode and inline functions.");
        }

        std::cout << "Disassembling LLVM bitcode to LLVM IR..." << "\n";
        std::filesystem::path inlineLlPath = generatedDirectory / (cName + ".inline.ll");
        std::string inlineLlCommand = "llvm-dis \"" + inlineBcPath.string() + "\" -o \"" + inlineLlPath.string() + "\"";
        int inlineLlResult = std::system(inlineLlCommand.c_str());
        if (inlineLlResult != 0) {
            throw std::runtime_error("Failed to disassemble LLVM bitcode to LLVM IR.");
        }

        std::vector<loopInformation> loopInformationList;
        loopInformationExtractor loopInformationExtractor;

        std::cout << "Extracting loop information..." << "\n";
        if (!loopInformationExtractor.extract(inlineBcPath, loopInformationDirectory)) {
            throw std::runtime_error("Failed to extract loop information.");
        }

        std::cout << "Ordering loop information..." << "\n";
        if (!loopInformationExtractor.order(loopInformationDirectory, loopInformationList)) {
            throw std::runtime_error("Failed to order loop information.");
        }

        experimentResult.totalLoops = static_cast<int>(loopInformationList.size());

        const auto preprocessingTime = std::chrono::steady_clock::now();
        experimentResult.initialAnalysisTime = std::chrono::duration_cast<std::chrono::milliseconds>(preprocessingTime - startTime).count();

        CandidateSynthesizer candidateSynthesizer;
        CandidateParser candidateParser;
        ValidatorGenerator validatorGenerator;

        std::set<std::string> unresolvedLoops;

        experimentResult.initialVerdict = "terminating";

        for (const auto& loopInformation : loopInformationList) {
            checkTimeout();

            std::cout << "Analyzing loop " << loopInformation.id << ":\n";

            ++experimentResult.analyzedLoops;

            std::filesystem::path candidatePath = candidatesDirectory / (loopInformation.id + "_candidate.json");
            std::filesystem::path validatorPath = validatorsDirectory / ("validate_" + loopInformation.id + ".py");
            std::filesystem::path refinementFeedbackPath = refinementFeedbackDirectory / (loopInformation.id + "_refinement_feedback.txt");

            int analysisRefinements = 0;
            SynthesisMode synthesisMode = Initial;

            while (true) { // Analysis refinement
                checkTimeout();

                int grammarRefinements = 0;
                bool loopUnresolved = false;

                while (true) { // Grammar refinement
                    checkTimeout();

                    if (synthesisMode == Initial) {
                        std::cout << "Synthesizing candidate for loop " << loopInformation.id << "...\n";
                    }
                    else if (synthesisMode == GrammarRefinement) {
                        std::cout << "Refining candidate for loop " << loopInformation.id << " using parsing feedback, attempt " << grammarRefinements << "...\n";
                    }
                    else if (synthesisMode == AnalysisRefinement) {
                        std::cout << "Refining candidate for loop " << loopInformation.id << " using validation feedback, attempt " << analysisRefinements << "...\n";
                    }

                    const SynthesisResult synthesisResult = candidateSynthesizer.synthesize(loopInformation.id, loopInformationDirectory, candidateGrammarPath, refinementFeedbackPath, candidatePath, llmModel, synthesisMode);
                    if (!synthesisResult.success) {
                        throw std::runtime_error("Failed to synthesize or refine candidate for loop " + loopInformation.id + ".");
                    }

                    if (synthesisMode == Initial) {
                        experimentResult.initialAnalysisTime += synthesisResult.latency;

                        ++experimentResult.initialSynthesisCalls;
                        experimentResult.initialSynthesisTime += synthesisResult.latency;
                        experimentResult.initialSynthesisInputTokens += synthesisResult.inputTokens;
                        experimentResult.initialSynthesisOutputTokens += synthesisResult.outputTokens;
                        experimentResult.initialSynthesisCost += synthesisResult.cost;

                        if (synthesisResult.kind == "non-terminating") {
                            experimentResult.initialVerdict = "non-terminating";
                        }
                        else if (synthesisResult.kind != "terminating" && experimentResult.initialVerdict != "non-terminating") {
                            experimentResult.initialVerdict = "unknown";
                        }
                    }
                    else if (synthesisMode == GrammarRefinement) {
                        ++experimentResult.grammarRefinementCalls;
                        experimentResult.grammarRefinementTime += synthesisResult.latency;
                        experimentResult.grammarRefinementInputTokens += synthesisResult.inputTokens;
                        experimentResult.grammarRefinementOutputTokens += synthesisResult.outputTokens;
                        experimentResult.grammarRefinementCost += synthesisResult.cost;
                    }
                    else if (synthesisMode == AnalysisRefinement) {
                        ++experimentResult.analysisRefinementCalls;
                        experimentResult.analysisRefinementTime += synthesisResult.latency;
                        experimentResult.analysisRefinementInputTokens += synthesisResult.inputTokens;
                        experimentResult.analysisRefinementOutputTokens += synthesisResult.outputTokens;
                        experimentResult.analysisRefinementCost += synthesisResult.cost;
                    }

                    if (synthesisResult.kind != "terminating" && synthesisResult.kind != "non-terminating") {
                        std::cout << "Loop " << loopInformation.id << " is unknown.\n";
                        unresolvedLoops.insert(loopInformation.id);

                        loopUnresolved = true;

                        break;
                    }

                    std::cout << "Parsing candidate for loop " << loopInformation.id << "...\n";

                    const ParseResult parseResult = candidateParser.parse(candidatePath, loopInformation.id, loopInformationDirectory, candidateGrammarPath, refinementFeedbackPath);
                    if (!parseResult.success) {
                        throw std::runtime_error("Failed to parse candidate for loop " + loopInformation.id + ".");
                    }

                    if (parseResult.valid) {
                        std::cout << "Candidate for loop " << loopInformation.id << " is grammar-valid.\n";

                        break;
                    }

                    std::cout << "Candidate for loop " << loopInformation.id << " is grammar-invalid.\n";

                    if (grammarRefinements >= maxGrammarRefinements) {
                        std::cout << "Maximum number of grammar refinement attempts reached for loop " << loopInformation.id << ".\n";

                        std::cout << "Loop " << loopInformation.id << " is unknown.\n";
                        unresolvedLoops.insert(loopInformation.id);

                        loopUnresolved = true;

                        break;
                    }

                    ++grammarRefinements;
                    synthesisMode = GrammarRefinement;
                }

                if (loopUnresolved) {
                    break;
                }

                std::cout << "Generating validator for loop " << loopInformation.id << "...\n";
                if (!validatorGenerator.generate(loopInformation.id, loopInformationDirectory, candidatePath, validatorPath)) {
                    throw std::runtime_error("Failed to generate validator for loop " + loopInformation.id + ".");
                }

                std::cout << "Running validator for loop " << loopInformation.id << "...\n";
                std::string validatorRunnerCommand = "\"" + (projectRoot / ".venv" / "bin" / "python").string() + "\" " +
                                                     "\"" + validatorPath.string() + "\" > \"" + refinementFeedbackPath.string() + "\" 2>&1";
                int validatorRunnerResult = std::system(validatorRunnerCommand.c_str());
                if (validatorRunnerResult != 0) {
                    throw std::runtime_error("Failed to run validator for loop " + loopInformation.id + ".");
                }

                std::ifstream validationFeedbackStream(refinementFeedbackPath);
                std::string validationFeedbackText((std::istreambuf_iterator<char>(validationFeedbackStream)), std::istreambuf_iterator<char>());

                if (validationFeedbackText.find("INVARIANT_RESULT: \"valid\"") != std::string::npos && validationFeedbackText.find("RANKING_FUNCTION_RESULT: \"valid\"") != std::string::npos) {
                    std::cout << "Candidate for loop " << loopInformation.id << " is semantically valid.\n";

                    std::cout << "Loop " << loopInformation.id << " is terminating.\n";

                    unresolvedLoops.erase(loopInformation.id);
                    for (auto it = unresolvedLoops.begin(); it != unresolvedLoops.end();) {
                        if (isDescendant(*it, loopInformation.id, loopInformationList)) {
                            std::cout << "Loop " << *it << " was unknown, but is terminating because parent loop " << loopInformation.id << " is terminating.\n";
                            it = unresolvedLoops.erase(it);
                        }
                        else {
                            ++it;
                        }
                    }

                    break;
                }

                if (validationFeedbackText.find("RECURRENT_SET_RESULT: \"valid\"") != std::string::npos) {
                    std::cout << "Candidate for loop " << loopInformation.id << " is semantically valid.\n";

                    std::cout << "Loop " << loopInformation.id << " is non-terminating.\n";
                    experimentResult.finalVerdict = "non-terminating";

                    return recordExperimentResult(experimentRecorder, experimentResult, experimentResultsPath);
                }

                if (analysisRefinements >= maxAnalysisRefinements) {
                    std::cout << "Maximum number of analysis refinement attempts reached for loop " << loopInformation.id << ".\n";

                    std::cout << "Loop " << loopInformation.id << " is unknown.\n";
                    unresolvedLoops.insert(loopInformation.id);

                    break;
                }

                std::cout << "Candidate for loop " << loopInformation.id << " is semantically invalid.\n";

                ++analysisRefinements;
                synthesisMode = AnalysisRefinement;
            }
        }

        if (unresolvedLoops.empty()) {
            experimentResult.finalVerdict = "terminating";
        }
        else {
            experimentResult.finalVerdict = "unknown";
        }

        return recordExperimentResult(experimentRecorder, experimentResult, experimentResultsPath);
    }

    catch (const TimeoutException& ex) {
        experimentResult.finalVerdict = "timeout";

        std::cerr << ex.what() << "\n";

        const int saveResult = recordExperimentResult(experimentRecorder, experimentResult, experimentResultsPath);

        if (saveResult != 0) {
            return saveResult;
        }

        return 124;
    }

    catch (const std::exception& ex) {
        experimentResult.finalVerdict = "error";

        std::cerr << ex.what() << "\n";

        const int saveResult = recordExperimentResult(experimentRecorder, experimentResult, experimentResultsPath);

        if (saveResult != 0) {
            return saveResult;
        }

        return 1;
    }
}