#ifndef VALIDATOR_GENERATOR_H
#define VALIDATOR_GENERATOR_H

#include <set>
#include <fstream>
#include <sstream>
#include <iostream>

#include <nlohmann/json.hpp>

class ValidatorGenerator {
public:
    bool generate(const std::string& loopId, const std::filesystem::path& loopInformationDirectory, const std::filesystem::path& candidatePath, const std::filesystem::path& validatorPath);
};

#endif // VALIDATOR_GENERATOR_H