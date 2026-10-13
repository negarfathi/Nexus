#ifndef RESULT_RECORDER_H
#define RESULT_RECORDER_H

#include <string>
#include <vector>
#include <filesystem>
#include <OpenXLSX.hpp>

struct ProgramResult {
    std::string programPath;

    int totalLoops = 0;
    int analyzedLoops = 0;

    std::string groundTruth;

    std::string firstVerdict = "unknown";
    bool firstSemanticCheckPassed = false;
    double firstAnalysisTime = 0.0;

    std::string finalVerdict = "unknown";

    double loopInformationExtractionTime = 0.0;

    double syntacticCheckTime = 0.0;
    double semanticCheckTime = 0.0;

    int initialSynthesisCalls = 0;
    long long initialSynthesisInputTokens = 0;
    long long initialSynthesisOutputTokens = 0;
    double initialSynthesisCost = 0.0;
    double initialSynthesisTime = 0.0;

    int syntacticRefinementCalls = 0;
    long long syntacticRefinementInputTokens = 0;
    long long syntacticRefinementOutputTokens = 0;
    double syntacticRefinementCost = 0.0;
    double syntacticRefinementTime = 0.0;

    int semanticRefinementCalls = 0;
    long long semanticRefinementInputTokens = 0;
    long long semanticRefinementOutputTokens = 0;
    double semanticRefinementCost = 0.0;
    double semanticRefinementTime = 0.0;

    double finalAnalysisTime = 0.0;
};

struct LoopResult {
    std::string loopId;
    std::string groundTruth;

    std::string firstVerdict = "unknown";
    bool firstSemanticCheckPassed = false;
    double firstAnalysisTime = 0.0;

    std::string finalVerdict = "unknown";

    double loopInformationExtractionTime = 0.0;

    double syntacticCheckTime = 0.0;
    double semanticCheckTime = 0.0;

    int initialSynthesisCalls = 0;
    long long initialSynthesisInputTokens = 0;
    long long initialSynthesisOutputTokens = 0;
    double initialSynthesisCost = 0.0;
    double initialSynthesisTime = 0.0;

    int syntacticRefinementCalls = 0;
    long long syntacticRefinementInputTokens = 0;
    long long syntacticRefinementOutputTokens = 0;
    double syntacticRefinementCost = 0.0;
    double syntacticRefinementTime = 0.0;

    int semanticRefinementCalls = 0;
    long long semanticRefinementInputTokens = 0;
    long long semanticRefinementOutputTokens = 0;
    double semanticRefinementCost = 0.0;
    double semanticRefinementTime = 0.0;

    double finalAnalysisTime = 0.0;
};

class ResultRecorder {
public:
    bool record(const ProgramResult& programResult, const std::vector<LoopResult>& loopResults, const std::string& llmModel, const std::filesystem::path& resultsPath);
};

#endif // RESULT_RECORDER_H