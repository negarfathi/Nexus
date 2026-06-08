#include <sstream>
#include <iostream>

#include "clang/Tooling/Tooling.h"

#include "../include/inline_attribute_injector.h"
#include "../include/loop_summary_extractor.h"
#include "../include/candidate_synthesizer.h"
#include "../include/validator_generator.h"

int main(int argc, char *argv[]) {
    if (argc < 5) {
        std::cerr << "Usage: ./Nexus <path/to/SourceCode.c> mode=MI/BV grammar-refinement-attempts=X analysis-refinement-attempts=X\n";
        return 1;
    }

    auto start_time = std::chrono::steady_clock::now();

    std::filesystem::path toolPath = std::filesystem::canonical(argv[0]);
    std::filesystem::path projectRoot = toolPath.parent_path().parent_path();

    std::filesystem::path cPath = std::filesystem::canonical(argv[1]);
    std::ifstream cStream(cPath);
    if (!cStream) {
        std::cerr << strerror(errno) << ": " << cPath << "\n";
        return 1;
    }
    std::stringstream cBuffer;
    cBuffer << cStream.rdbuf();
    std::string cFile = cBuffer.str();

    std::string cName = cPath.stem().string();
    std::string cExtension = cPath.extension().string();
    std::filesystem::path cDirectory = cPath.parent_path();

    std::string mode = argv[2];
    mode.erase(mode.find("mode="), std::string("mode=").length());

    //if (mode == "MI") {
    //
    //}
    //else if mode == "BV") {
    //
    //}

    std::string grammarRefinementAttemptsStr = argv[3];
    grammarRefinementAttemptsStr.erase(grammarRefinementAttemptsStr.find("grammar-refinement-attempts="), std::string("grammar-refinement-attempts=").length());
    int grammarRefinementAttempts = std::stoi(grammarRefinementAttemptsStr);

    std::string analysisRefinementAttemptsStr = argv[4];
    analysisRefinementAttemptsStr.erase(analysisRefinementAttemptsStr.find("analysis-refinement-attempts="), std::string("analysis-refinement-attempts=").length());
    int analysisRefinementAttempts = std::stoi(analysisRefinementAttemptsStr);

    std::filesystem::path generatedDirectory  = cDirectory / "generated";
    std::filesystem::path summariesDirectory  = generatedDirectory / "summaries";
    std::filesystem::path candidatesDirectory = generatedDirectory / "candidates";
    std::filesystem::path validatorsDirectory = generatedDirectory / "validators";
    std::filesystem::path resultsDirectory = generatedDirectory / "results";

    std::filesystem::create_directories(generatedDirectory);
    std::filesystem::create_directories(summariesDirectory);
    std::filesystem::create_directories(candidatesDirectory);
    std::filesystem::create_directories(validatorsDirectory);
    std::filesystem::create_directories(resultsDirectory);

    std::filesystem::path grammarsDirectory = projectRoot / "grammars";

    std::filesystem::path outputPath = generatedDirectory / "output.txt";
    std::ofstream outputFile(outputPath);

    std::filesystem::path inlineCPath = generatedDirectory / (cName + ".inline" + cExtension);
    bool injectionResult = clang::tooling::runToolOnCode(std::make_unique<InlineAttributeInjectorAction>(inlineCPath), cFile);
    if (!injectionResult) {
        std::cerr << "Failed to inject inline attributes.\n";
        return 1;
    }

    std::filesystem::path bcPath = generatedDirectory / (cName + ".bc");
    std::string compileCommand = "clang -emit-llvm -c \"" + inlineCPath.string() + "\" -o \"" + bcPath.string() + "\"";
    int compileResult = std::system(compileCommand.c_str());
    if (compileResult != 0) {
        std::cerr << "Failed to compile to LLVM bitcode.\n";
        return 1;
    }

    std::filesystem::path inlineBcPath = generatedDirectory / (cName + ".inline.bc");
    std::string inlineBcCommand = "opt -passes='always-inline' \"" + bcPath.string() + "\" -o \"" + inlineBcPath.string() + "\"";
    int inlineBcResult = std::system(inlineBcCommand.c_str());
    if (inlineBcResult != 0) {
        std::cerr << "Failed to inline functions.\n";
        return 1;
    }

    std::filesystem::path inlineLlPath = generatedDirectory / (cName + ".inline.ll");
    std::string inlineLlCommand = "llvm-dis \"" + inlineBcPath.string() + "\" -o \"" + inlineLlPath.string() + "\"";
    int inlineLlResult = std::system(inlineLlCommand.c_str());
    if (inlineLlResult != 0) {
        std::cerr << "Failed to disassemble LLVM bitcode to LLVM IR.\n";
        return 1;
    }

    std::vector<LoopSummary> loopSummaries;
    LoopSummaryExtractor loopSummaryExtractor;

    if (!loopSummaryExtractor.extract(inlineBcPath, summariesDirectory)) {
        std::cerr << "Failed to extract loop summaries.\n";
        return 1;
    }

    if (!loopSummaryExtractor.order(summariesDirectory, loopSummaries)) {
        std::cerr << "Failed to order loop summaries.\n";
        return 1;
    }

    CandidateSynthesizer candidateSynthesizer;
    ValidatorGenerator validatorGenerator;

    for (const auto& loopSummary : loopSummaries) {
        SynthesisMode synthesisMode = Initial;

        std::filesystem::path candidatePath = candidatesDirectory / (loopSummary.id + "_candidate.json");
        std::filesystem::path validatorPath = validatorsDirectory / ("validate_" + loopSummary.id + ".py");
        std::filesystem::path resultPath = resultsDirectory / (loopSummary.id + "_result.txt");

        for (int i = 1; i <= analysisRefinementAttempts; i++) {
            for (int j = 1; j <= grammarRefinementAttempts; j++) {
                if (!candidateSynthesizer.synthesize(loopSummary.path, grammarsDirectory, resultPath, candidatePath, synthesisMode)) {
                    std::cerr << "Failed to synthesize candidate for loop " << loopSummary.id << ".\n";
                    return 1;
                }

                if (!candidateSynthesizer.parse(candidatePath, grammarsDirectory, resultPath)) {
                    if (j < grammarRefinementAttempts) {
                        synthesisMode = GrammarRefinement;
                        continue;
                    }

                    auto end_time = std::chrono::steady_clock::now();
                    auto runtime = std::chrono::duration_cast<std::chrono::milliseconds>(end_time - start_time).count();

                    outputFile << "Unknown\n";
                    outputFile << runtime << " milliseconds\n";
                    outputFile.close();

                    return 0;
                }

                break;
            }

            if (!validatorGenerator.generate(loopSummary.path, candidatePath, validatorPath)) {
                std::cerr << "Failed to generate validator for loop " << loopSummary.id << ".\n";
                return 1;
            }

            std::string validatorRunnerCommand = "\"" + (projectRoot / ".venv" / "bin" / "python").string() + "\" " +
                                                 "\"" + validatorPath.string() + "\" > \"" + resultPath.string() + "\" 2>&1";
            int validatorRunnerResult = std::system(validatorRunnerCommand.c_str());
            if (validatorRunnerResult != 0) {
                std::cerr << "Failed to run validator for loop " << loopSummary.id << ".\n";
                return 1;
            }

            std::ifstream resultFile(resultPath);
            std::string resultContent((std::istreambuf_iterator<char>(resultFile)), std::istreambuf_iterator<char>());

            if (resultContent.find("Valid Ranking Function") != std::string::npos) {
                break;
            }

            if (resultContent.find("Valid Recurrent Set") != std::string::npos) {
                auto end_time = std::chrono::steady_clock::now();
                auto runtime = std::chrono::duration_cast<std::chrono::milliseconds>(end_time - start_time).count();

                outputFile << "Non-Terminating\n";
                outputFile << runtime << " milliseconds\n";
                outputFile.close();

                return 0;
            }

            if (resultContent.find("Invalid Ranking Function") != std::string::npos || resultContent.find("Invalid Recurrent Set") != std::string::npos) {
                if (i < analysisRefinementAttempts) {
                    synthesisMode = AnalysisRefinement;
                    continue;
                }

                auto end_time = std::chrono::steady_clock::now();
                auto runtime = std::chrono::duration_cast<std::chrono::milliseconds>(end_time - start_time).count();

                outputFile << "Unknown\n";
                outputFile << runtime << " milliseconds\n";
                outputFile.close();

                return 0;
            }
        }
    }

    auto end_time = std::chrono::steady_clock::now();
    auto runtime = std::chrono::duration_cast<std::chrono::milliseconds>(end_time - start_time).count();

    outputFile << "Terminating\n";
    outputFile << runtime << " milliseconds\n";
    outputFile.close();

    return 0;
}