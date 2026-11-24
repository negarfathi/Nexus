#ifndef LOOP_INFORMATION_EXTRACTOR_H
#define LOOP_INFORMATION_EXTRACTOR_H

#include <queue>
#include <fstream>
// >>> NEXUS CHANGE BEGIN [2.5.1 - distinguish unsupported CFG from tool error]
#include <stdexcept>
// <<< NEXUS CHANGE END [2.5.1 - distinguish unsupported CFG from tool error]

#include "llvm/IR/Module.h"
#include "llvm/IR/Dominators.h"
#include "llvm/ADT/SmallString.h"
#include "llvm/IR/IntrinsicInst.h"
#include "llvm/Analysis/LoopInfo.h"
#include "llvm/IRReader/IRReader.h"
#include "llvm/Support/SourceMgr.h"

#include <nlohmann/json.hpp>

struct loopInformation {
    std::string id;
    std::optional<std::string> parent;
    std::vector<std::string> children;
};

// >>> NEXUS CHANGE BEGIN [2.5.1 - explicit no-loop unsupported condition]
class UnsupportedControlFlowError : public std::runtime_error {
public:
    explicit UnsupportedControlFlowError(const std::string& reason) : std::runtime_error(reason) {}
};
// <<< NEXUS CHANGE END [2.5.1 - explicit no-loop unsupported condition]

class loopInformationExtractor {
public:
    bool extract(const std::filesystem::path& inlineBcPath, const std::filesystem::path& loopInformationDirectory, const std::set<std::string>& entryFunctionNames);
    bool order(const std::filesystem::path& loopInformationDirectory, std::vector<loopInformation>& loopInformationList);
    // >>> NEXUS CHANGE BEGIN [2.5.2 - distinguish acyclic entry from missing extraction]
    bool hasAcyclicTerminationCertificate() const { return acyclicTerminationCertified_; }
private:
    bool acyclicTerminationCertified_ = false;
    // <<< NEXUS CHANGE END [2.5.2 - distinguish acyclic entry from missing extraction]
};

#endif // LOOP_INFORMATION_EXTRACTOR_H