#ifndef VALIDATOR_GENERATOR_H
#define VALIDATOR_GENERATOR_H

#include <filesystem>
#include <string>

#include <algorithm>
#include <cctype>
#include <fstream>
#include <functional>
#include <iostream>
#include <map>
#include <set>
#include <sstream>
#include <stdexcept>
#include <utility>
#include <vector>

#include <nlohmann/json.hpp>

class ValidatorGenerator {
public:
    bool generate(
        const std::string& loopId,
        const std::filesystem::path& loopInformationDirectory,
        const std::filesystem::path& candidatePath,
        const std::filesystem::path& validatorPath
    ) const;
};

#endif // VALIDATOR_GENERATOR_H