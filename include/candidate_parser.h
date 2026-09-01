#ifndef CANDIDATE_PARSER_H
#define CANDIDATE_PARSER_H

#include <set>
#include <fstream>
#include <sstream>
#include <iostream>

#include <nlohmann/json.hpp>

struct ParseResult {
    bool success = false;
    bool valid = true;
    std::vector<nlohmann::json> errors;
};

class CandidateParser {
public:
    ParseResult parse(const std::filesystem::path& candidatePath, const std::string& loopId, const std::filesystem::path& loopInformationDirectory, const std::filesystem::path& candidateGrammarPath, const std::filesystem::path& refinementFeedbackPath);
};

#endif // CANDIDATE_PARSER_H