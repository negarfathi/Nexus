#ifndef EXPERIMENT_RECORDER_H
#define EXPERIMENT_RECORDER_H

#include <filesystem>

#include <OpenXLSX.hpp>

struct ExperimentResult {
    std::string program;

    int totalLoops = 0;
    int analyzedLoops = 0;

    std::string initialVerdict;
    std::string finalVerdict;

    double initialAnalysisTime = 0.0;
    double totalAnalysisTime = 0.0;

    int initialSynthesisCalls = 0;
    double initialSynthesisTime = 0.0;
    long long initialSynthesisInputTokens = 0;
    long long initialSynthesisOutputTokens = 0;
    double initialSynthesisCost = 0.0;

    int syntacticRefinementCalls = 0;
    double syntacticRefinementTime = 0.0;
    long long syntacticRefinementInputTokens = 0;
    long long syntacticRefinementOutputTokens = 0;
    double syntacticRefinementCost = 0.0;

    int sematicRefinementCalls = 0;
    double sematicRefinementTime = 0.0;
    long long sematicRefinementInputTokens = 0;
    long long sematicRefinementOutputTokens = 0;
    double sematicRefinementCost = 0.0;
};

class ExperimentRecorder {
public:
    bool record(const ExperimentResult& experimentResult, const std::string& llmModel, const std::filesystem::path& experimentResultsPath);
};

#endif // EXPERIMENT_RECORDER_H