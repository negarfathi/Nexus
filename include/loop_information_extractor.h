#ifndef LOOP_INFORMATION_EXTRACTOR_H
#define LOOP_INFORMATION_EXTRACTOR_H

#include <filesystem>
#include <fstream>
#include <optional>
#include <string>
#include <vector>

#include "llvm/IR/DebugLoc.h"
#include "llvm/IR/Metadata.h"

#include <algorithm>
#include <cstdint>
#include <map>
#include <memory>
#include <queue>
#include <set>
#include <tuple>
#include <utility>

#include <nlohmann/json.hpp>

#include "llvm/IR/Module.h"
#include "llvm/IR/Constants.h"
#include "llvm/IR/Dominators.h"
#include "llvm/ADT/SmallString.h"
#include "llvm/IR/IntrinsicInst.h"
#include "llvm/IRReader/IRReader.h"
#include "llvm/Analysis/LoopInfo.h"
#include "llvm/Support/SourceMgr.h"

struct loopInformation {
    std::string id;
    std::optional<std::string> parent;
    std::vector<std::string> children;
};

class loopInformationExtractor {
public:
    bool extract(const std::filesystem::path& inlineBcPath, const std::filesystem::path& loopInformationDirectory);
    bool order(const std::filesystem::path& loopInformationDirectory, std::vector<loopInformation>& loopInformationList);
};

#endif // LOOP_INFORMATION_EXTRACTOR_H