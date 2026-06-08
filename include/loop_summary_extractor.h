#ifndef LOOP_SUMMARY_EXTRACTOR_H
#define LOOP_SUMMARY_EXTRACTOR_H

#include <fstream>
#include <nlohmann/json.hpp>

#include "llvm/IR/Module.h"
#include "llvm/IR/Constants.h"
#include "llvm/IR/Dominators.h"
#include "llvm/ADT/SmallString.h"
#include "llvm/IR/IntrinsicInst.h"
#include "llvm/IRReader/IRReader.h"
#include "llvm/Analysis/LoopInfo.h"
#include "llvm/Support/SourceMgr.h"

struct LoopSummary {
    std::string id;
    std::optional<std::string> parent;
    std::vector<std::string> children;
    std::filesystem::path path;
};

class LoopSummaryExtractor {
    public:
        bool extract(const std::filesystem::path& inlineBcPath, const std::filesystem::path& summariesDir);
        bool order(const std::filesystem::path& summariesDir, std::vector<LoopSummary>& loopSummaries);
};

#endif // LOOP_SUMMARY_EXTRACTOR_H