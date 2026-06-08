#ifndef CANDIDATE_SYNTHESIZER_H
#define CANDIDATE_SYNTHESIZER_H

#include <fstream>

enum SynthesisMode {
    Initial,
    GrammarRefinement,
    AnalysisRefinement
};

class CandidateSynthesizer {
    public:
        bool synthesize(const std::filesystem::path& loopSummaryPath, const std::filesystem::path& grammarsDirectory, const std::filesystem::path& resultPath, const std::filesystem::path& candidatePath, SynthesisMode& synthesisMode);
        bool parse(const std::filesystem::path& candidatePath, const std::filesystem::path& grammarsDirectory, const std::filesystem::path& resultPath);
};

#endif //CANDIDATE_SYNTHESIZER_H