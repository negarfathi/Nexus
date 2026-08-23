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

    int grammarRefinementCalls = 0;
    double grammarRefinementTime = 0.0;
    long long grammarRefinementInputTokens = 0;
    long long grammarRefinementOutputTokens = 0;
    double grammarRefinementCost = 0.0;

    int analysisRefinementCalls = 0;
    double analysisRefinementTime = 0.0;
    long long analysisRefinementInputTokens = 0;
    long long analysisRefinementOutputTokens = 0;
    double analysisRefinementCost = 0.0;
};

class ExperimentRecorder {
public:
    bool record(const std::filesystem::path& experimentResultsPath, const ExperimentResult& experimentResult);
};

#endif // EXPERIMENT_RECORDER_H