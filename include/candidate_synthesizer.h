#ifndef CANDIDATE_SYNTHESIZER_H
#define CANDIDATE_SYNTHESIZER_H

#include <set>
#include <fstream>
#include <sstream>
#include <iostream>

#include <curl/curl.h>
#include <nlohmann/json.hpp>

enum SynthesisMode {
    Initial,
    SyntacticRefinement,
    SemanticRefinement
};

struct SynthesisResult {
    bool success = false;
    std::string kind;
    long long inputTokens = 0;
    long long outputTokens = 0;
    double latency = 0.0;
    double cost = 0.0;
};

class CandidateSynthesizer {
public:
    SynthesisResult synthesize(const std::string& loopId, const std::filesystem::path& loopInformationDirectory, const std::filesystem::path& candidateGrammarPath, const std::filesystem::path& refinementFeedbackPath, const std::filesystem::path& candidatePath, const std::string& llmModel, SynthesisMode synthesisMode, long timeout);
};

#endif // CANDIDATE_SYNTHESIZER_H