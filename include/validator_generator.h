#ifndef VALIDATOR_GENERATOR_H
#define VALIDATOR_GENERATOR_H

#include <set>
#include <regex>
#include <fstream>
#include <sstream>
#include <iostream>
#include <filesystem>

#include <nlohmann/json.hpp>

class ValidatorGenerator {
    public:
        bool generate(const std::filesystem::path& loopSummaryPath, const std::filesystem::path& candidatePath, const std::filesystem::path& validatorPath);
};

#endif // VALIDATOR_GENERATOR_H