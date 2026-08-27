/*
OPENAI_API_KEY=...
*/
/*
VLLM_BASE_URL=...
cd ~/Documents/Nexus
source .venv/bin/activate
VLLM_USE_FLASHINFER_SAMPLER=0 vllm serve openai/gpt-oss-20b \
  --served-model-name gpt-oss-20b \
  --download-dir ./models \
  --host 127.0.0.1 \
  --port 8000
VLLM_USE_FLASHINFER_SAMPLER=0 vllm serve Qwen/Qwen3-8B \
  --served-model-name Qwen3-8B \
  --download-dir ./models \
  --host 127.0.0.1 \
  --port 8000
VLLM_USE_FLASHINFER_SAMPLER=0 vllm serve codellama/CodeLlama-7b-Instruct-hf \
  --served-model-name CodeLlama-7B-Instruct \
  --download-dir ./models \
  --host 127.0.0.1 \
  --port 8000
*/

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
    const double elapsedTime = std::chrono::duration<double>(std::chrono::steady_clock::now() - startTime).count();
    if (timeout > 0 && elapsedTime >= timeout) {
        throw TimeoutException();
    }
}

static int recordExperimentResult(ExperimentRecorder& experimentRecorder, ExperimentResult& experimentResult, const std::string& llmModel, const std::filesystem::path& experimentResultsPath) {
    experimentResult.totalAnalysisTime = std::chrono::duration_cast<std::chrono::milliseconds>(std::chrono::steady_clock::now() - startTime).count();

    std::cout << "Program: " << experimentResult.finalVerdict << "\n";
    std::cout << "Runtime: " << experimentResult.totalAnalysisTime << " milliseconds\n";

    if (!experimentRecorder.record(experimentResult, llmModel, experimentResultsPath)) {
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
        bool injectionResult = clang::tooling::runToolOnCodeWithArgs(std::make_unique<InlineAttributeInjectorAction>(inlineCPath), cFile, {"-x", "c", "-std=c11"}, cName + cExtension);

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

        std::cout << "Extracting loop information..." << "\n";
        if (!loopInformationExtractor.extract(inlineBcPath, loopInformationDirectory)) {
            throw std::runtime_error("Failed to extract loop information.");
        }

        std::cout << "Ordering loop information..." << "\n";
        if (!loopInformationExtractor.order(loopInformationDirectory, loopInformationList)) {
            throw std::runtime_error("Failed to order loop information.");
        }

        experimentResult.totalLoops = static_cast<int>(loopInformationList.size());

        experimentResult.initialVerdict = "terminating";
        experimentResult.initialAnalysisTime = std::chrono::duration_cast<std::chrono::milliseconds>(std::chrono::steady_clock::now() - startTime).count();

        std::set<std::string> unresolvedLoops;

        CandidateSynthesizer candidateSynthesizer;
        CandidateParser candidateParser;
        ValidatorGenerator validatorGenerator;

        for (const auto& loopInformation : loopInformationList) {
            checkTimeout();

            std::cout << "Analyzing loop " << loopInformation.id << ":\n";

            ++experimentResult.analyzedLoops;

            std::filesystem::path candidatePath = candidatesDirectory / (loopInformation.id + "_candidate.json");
            std::filesystem::path validatorPath = validatorsDirectory / ("validate_" + loopInformation.id + ".py");
            std::filesystem::path refinementFeedbackPath = refinementFeedbackDirectory / (loopInformation.id + "_refinement_feedback.txt");
            std::ofstream(refinementFeedbackPath, std::ios::trunc).close();

            int semanticRefinements = 0;
            SynthesisMode synthesisMode = Initial;

            while (true) { // Semantic refinement
                checkTimeout();

                int syntacticRefinements = 0;
                bool loopUnresolved = false;

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

                    const SynthesisResult synthesisResult = candidateSynthesizer.synthesize(loopInformation.id, loopInformationDirectory, candidateGrammarPath, refinementFeedbackPath, candidatePath, llmModel, synthesisMode, timeout);
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
                    else if (synthesisMode == SyntacticRefinement) {
                        ++experimentResult.syntacticRefinementCalls;
                        experimentResult.syntacticRefinementTime += synthesisResult.latency;
                        experimentResult.syntacticRefinementInputTokens += synthesisResult.inputTokens;
                        experimentResult.syntacticRefinementOutputTokens += synthesisResult.outputTokens;
                        experimentResult.syntacticRefinementCost += synthesisResult.cost;
                    }
                    else if (synthesisMode == SemanticRefinement) {
                        ++experimentResult.sematicRefinementCalls;
                        experimentResult.sematicRefinementTime += synthesisResult.latency;
                        experimentResult.sematicRefinementInputTokens += synthesisResult.inputTokens;
                        experimentResult.sematicRefinementOutputTokens += synthesisResult.outputTokens;
                        experimentResult.sematicRefinementCost += synthesisResult.cost;
                    }

                    if (synthesisResult.kind != "terminating" && synthesisResult.kind != "non-terminating") {
                        loopUnresolved = true;
                        unresolvedLoops.insert(loopInformation.id);

                        std::cout << "Loop " << loopInformation.id << " is unknown.\n";

                        break;
                    }

                    std::cout << "Parsing candidate for loop " << loopInformation.id << "...\n";

                    const ParseResult parseResult = candidateParser.parse(candidatePath, loopInformation.id, loopInformationDirectory, candidateGrammarPath, refinementFeedbackPath);
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
                if (!validatorGenerator.generate(loopInformation.id, loopInformationDirectory, candidatePath, validatorPath)) {
                    throw std::runtime_error("Failed to generate validator for loop " + loopInformation.id + ".");
                }

                std::cout << "Running validator script for loop " << loopInformation.id << "...\n";
                const std::uintmax_t validationFeedbackStart = std::filesystem::exists(refinementFeedbackPath) ? std::filesystem::file_size(refinementFeedbackPath) : 0;
                std::string validatorRunnerCommand = "\"" + (projectRoot / ".venv" / "bin" / "python").string() + "\" " +
                                                     "\"" + validatorPath.string() + "\" >> \"" + refinementFeedbackPath.string() + "\" 2>&1";
                int validatorRunnerResult = std::system(validatorRunnerCommand.c_str());
                if (validatorRunnerResult != 0) {
                    throw std::runtime_error("Failed to run validator script for loop " + loopInformation.id + ".");
                }

                std::ifstream validationFeedbackStream(refinementFeedbackPath);
                if (!validationFeedbackStream) {
                    throw std::runtime_error("Failed to read refinement feedback: " + refinementFeedbackPath.string());
                }
                validationFeedbackStream.seekg(static_cast<std::streamoff>(validationFeedbackStart));
                std::string validationFeedbackText((std::istreambuf_iterator<char>(validationFeedbackStream)), std::istreambuf_iterator<char>());

                if (validationFeedbackText.find("INVARIANT_RESULT: \"valid\"") != std::string::npos && validationFeedbackText.find("RANKING_FUNCTION_RESULT: \"valid\"") != std::string::npos) {
                    std::cout << "Candidate for loop " << loopInformation.id << " is semantically valid.\n";

                    std::cout << "Loop " << loopInformation.id << " is terminating.\n";

                    unresolvedLoops.erase(loopInformation.id);
                    for (auto it = unresolvedLoops.begin(); it != unresolvedLoops.end();) {
                        if (hasTerminatingParent(*it, loopInformation.id, loopInformationList)) {
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

                    experimentResult.finalVerdict = "non-terminating";
                    std::cout << "Loop " << loopInformation.id << " is non-terminating.\n";

                    return recordExperimentResult(experimentRecorder, experimentResult, llmModel, experimentResultsPath);
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
        }

        if (unresolvedLoops.empty()) {
            experimentResult.finalVerdict = "terminating";
        }
        else {
            experimentResult.finalVerdict = "unknown";
        }

        return recordExperimentResult(experimentRecorder, experimentResult, llmModel, experimentResultsPath);
    }

    catch (const TimeoutException& ex) {
        experimentResult.finalVerdict = "timeout";

        std::cerr << ex.what() << "\n";

        const int recordingExitCode = recordExperimentResult(experimentRecorder, experimentResult, llmModel, experimentResultsPath);

        if (recordingExitCode != 0) {
            return recordingExitCode;
        }

        return 124;
    }

    catch (const std::exception& ex) {
        experimentResult.finalVerdict = "error";

        std::cerr << ex.what() << "\n";

        const int recordingExitCode = recordExperimentResult(experimentRecorder, experimentResult, llmModel, experimentResultsPath);

        if (recordingExitCode != 0) {
            return recordingExitCode;
        }

        return 1;
    }
}