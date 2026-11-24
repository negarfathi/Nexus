#include "../include/loop_information_extractor.h"
// >>> NEXUS CHANGE BEGIN [2.4 - inspect source-level return markers]
#include <sstream>
#include "llvm/IR/InlineAsm.h"
#include "llvm/IR/CFG.h"
// <<< NEXUS CHANGE END [2.4 - inspect source-level return markers]

// Global extractor state.
unsigned nextLoopId = 1;
std::map<std::string, std::string> loopIds;

// Core data structures.
struct StateVariable {
    std::string name;
    std::string llvmName;
    std::string type;
    const llvm::Value* slot = nullptr;
};

struct Expression {
    std::string head;
    std::vector<Expression> arguments;
    bool isCompound = false;
    bool isRelationCall = false;
    bool isExists = false;
    std::vector<std::string> boundVariables;
};

struct ChildCall {
    std::string childId;
    std::string exitSourceBlockName;
    std::string exitBlockName;
    bool isReturn = false;
    std::map<std::string, Expression> entryState;
};

struct RawTransition {
    std::string kind;
    std::vector<Expression> literals;
    std::vector<std::string> basicBlocks;
    Expression pathCondition;
    std::map<std::string, Expression> updates;
    bool hasChildComposition = false;
    std::string childId;
    std::string childExitBlockName;
    std::map<std::string, Expression> childEntryState;
    std::vector<ChildCall> childCalls;
};

struct Transition {
    std::string branchId;
    std::string kind;
    std::vector<std::string> basicBlocks;
    Expression pathCondition;
    std::vector<Expression> extraConjuncts;
    std::vector<std::string> localVariables;
    std::map<std::string, Expression> updates;
    bool hasChildCompositions = false;
    std::string childId;
    std::string childExitBlockName;
    std::vector<ChildCall> childCalls;
};

struct LoopContext {
    llvm::Loop* loop = nullptr;
    llvm::Function* function = nullptr;
    llvm::DominatorTree* dominatorTree = nullptr;
    std::string loopId;
    std::vector<StateVariable> variables;
    std::map<const llvm::Value*, std::string> variableNames;
    std::vector<std::pair<std::string, std::string>> nondeterministicSymbols;
    std::vector<std::string> unsupported;
    unsigned nextNondetId = 1;
};

struct SymbolicState {
    std::map<const llvm::Value*, Expression> valueExpr;
    std::map<const llvm::Value*, Expression> memoryExpr;
    std::vector<Expression> pathConditions;
    std::vector<std::string> pathBlocks;
    bool hasChildComposition = false;
    std::string childId;
    std::string childExitBlockName;
    std::map<std::string, Expression> childEntryState;
    std::vector<ChildCall> childCalls;
};

// Expression operations.
Expression atom(const std::string& atomText) {
    Expression expression;
    expression.isCompound = false;
    expression.head = atomText;
    return expression;
}

Expression normalizeCondition(const Expression& expression) {
    Expression normalized = expression;
    normalized.arguments.clear();
    normalized.arguments.reserve(expression.arguments.size());
    for (const Expression& argument : expression.arguments) {
        normalized.arguments.push_back(normalizeCondition(argument));
    }
    if (!normalized.isCompound || normalized.head != "not" || normalized.arguments.size() != 1) {
        return normalized;
    }
    const Expression& operand = normalized.arguments.front();
    if (operand.isCompound && operand.head == "not" && operand.arguments.size() == 1) {
        return operand.arguments.front();
    }
    if (!operand.isCompound || operand.arguments.size() != 2) {
        return normalized;
    }
    static const std::map<std::string, std::string> negatedOperators = {
        {"=", "!="},
        {"!=", "="},
        {"<", ">="},
        {"<=", ">"},
        {">", "<="},
        {">=", "<"},
        {"u<", "u>="},
        {"u<=", "u>"},
        {"u>", "u<="},
        {"u>=", "u<"}
    };
    auto negatedOperatorIt = negatedOperators.find(operand.head);
    if (negatedOperatorIt == negatedOperators.end()) {
        return normalized;
    }
    Expression result;
    result.isCompound = true;
    result.head = negatedOperatorIt->second;
    result.arguments = operand.arguments;
    return result;
}

std::string exprKey(const Expression& expression) {
    if (expression.isRelationCall) {
        std::string key = "(rel " + expression.head;
        for (const auto& argument : expression.arguments) {
            key += " ";
            key += exprKey(argument);
        }
        key += ")";
        return key;
    }
    if (expression.isExists) {
        std::string key = "(exists";
        for (const auto& boundVariable : expression.boundVariables) {
            key += " ";
            key += boundVariable;
        }
        key += " ";
        if (!expression.arguments.empty()) {
            key += exprKey(expression.arguments.front());
        }
        key += ")";
        return key;
    }
    if (!expression.isCompound) {
        return expression.head;
    }
    std::string key = "(" + expression.head;
    for (const auto& argument : expression.arguments) {
        key += " ";
        key += exprKey(argument);
    }
    key += ")";
    return key;
}

bool exprEq(const Expression& leftExpression, const Expression& rightExpression) {
    if (leftExpression.isCompound != rightExpression.isCompound) {
        return false;
    }
    if (leftExpression.isRelationCall != rightExpression.isRelationCall) {
        return false;
    }
    if (leftExpression.isExists != rightExpression.isExists) {
        return false;
    }
    if (leftExpression.head != rightExpression.head) {
        return false;
    }
    if (leftExpression.boundVariables != rightExpression.boundVariables) {
        return false;
    }
    if (leftExpression.arguments.size() != rightExpression.arguments.size()) {
        return false;
    }
    for (size_t argumentIndex = 0; argumentIndex < leftExpression.arguments.size(); ++argumentIndex) {
        if (!exprEq(leftExpression.arguments[argumentIndex], rightExpression.arguments[argumentIndex])) {
            return false;
        }
    }
    return true;
}

Expression mkNary(const char* operatorName, const std::vector<Expression>& arguments) {
    if (arguments.empty()) {
        if (std::string(operatorName) == "and") {
            return atom("true");
        }
        if (std::string(operatorName) == "or") {
            return atom("false");
        }
        Expression result;
        result.isCompound = true;
        result.head = operatorName;
        result.arguments = {};
        return result;
    }
    if (arguments.size() == 1) {
        return arguments.front();
    }
    Expression result;
    result.isCompound = true;
    result.head = operatorName;
    result.arguments = arguments;
    return result;
}

Expression mkNot(const Expression& expression) {
    if (!expression.isCompound && expression.head == "true") {
        return atom("false");
    }
    if (!expression.isCompound && expression.head == "false") {
        return atom("true");
    }
    if (expression.isCompound && expression.head == "not" && expression.arguments.size() == 1) {
        return expression.arguments[0];
    }
    Expression result;
    result.isCompound = true;
    result.head = "not";
    result.arguments = {expression};
    return result;
}

Expression mkAnd(const std::vector<Expression>& inputArguments) {
    std::vector<Expression> arguments;
    std::set<std::string> seenArguments;
    for (const auto& argument : inputArguments) {
        if (!argument.isCompound && argument.head == "true") {
            continue;
        }
        if (!argument.isCompound && argument.head == "false") {
            return atom("false");
        }
        std::string argumentKey = exprKey(argument);
        std::string negatedArgumentKey = exprKey(mkNot(argument));
        if (seenArguments.count(negatedArgumentKey)) {
            return atom("false");
        }
        if (seenArguments.insert(argumentKey).second) {
            arguments.push_back(argument);
        }
    }
    return mkNary("and", arguments);
}

Expression mkOr(const std::vector<Expression>& inputArguments) {
    std::vector<Expression> arguments;
    std::set<std::string> seenArguments;
    for (const auto& argument : inputArguments) {
        if (!argument.isCompound && argument.head == "false") {
            continue;
        }
        if (!argument.isCompound && argument.head == "true") {
            return atom("true");
        }
        std::string argumentKey = exprKey(argument);
        std::string negatedArgumentKey = exprKey(mkNot(argument));
        if (seenArguments.count(negatedArgumentKey)) {
            return atom("true");
        }
        if (seenArguments.insert(argumentKey).second) {
            arguments.push_back(argument);
        }
    }
    return mkNary("or", arguments);
}

Expression mkBin(const char* operatorName, const Expression& leftExpression, const Expression& rightExpression) {
    const std::string operatorString(operatorName);
    std::int64_t leftIntegerValue = 0;
    std::int64_t rightIntegerValue = 0;
    bool leftIsInteger = false;
    if (!leftExpression.isCompound && !leftExpression.head.empty()) {
        char* parseEnd = nullptr;
        errno = 0;
        long long parsedValue = std::strtoll(leftExpression.head.c_str(), &parseEnd, 10);
        if (parseEnd == leftExpression.head.c_str() + leftExpression.head.size() && errno != ERANGE) {
            leftIntegerValue = static_cast<std::int64_t>(parsedValue);
            leftIsInteger = true;
        }
    }
    bool rightIsInteger = false;
    if (!rightExpression.isCompound && !rightExpression.head.empty()) {
        char* parseEnd = nullptr;
        errno = 0;
        long long parsedValue = std::strtoll(rightExpression.head.c_str(), &parseEnd, 10);
        if (parseEnd == rightExpression.head.c_str() + rightExpression.head.size() && errno != ERANGE) {
            rightIntegerValue = static_cast<std::int64_t>(parsedValue);
            rightIsInteger = true;
        }
    }
    if (operatorString == "=") {
        if (exprEq(leftExpression, rightExpression)) {
            return atom("true");
        }
        if ((!leftExpression.isCompound && (leftExpression.head == "true" || leftExpression.head == "false")) && (!rightExpression.isCompound && (rightExpression.head == "true" || rightExpression.head == "false"))) {
            return atom(leftExpression.head == rightExpression.head ? "true" : "false");
        }
        if (leftIsInteger && rightIsInteger) {
            return atom(leftIntegerValue == rightIntegerValue ? "true" : "false");
        }
    }
    if (operatorString == "!=") {
        if (exprEq(leftExpression, rightExpression)) {
            return atom("false");
        }
        if (leftIsInteger && rightIsInteger) {
            return atom(leftIntegerValue != rightIntegerValue ? "true" : "false");
        }
        return mkNot(mkBin("=", leftExpression, rightExpression));
    }
    if (operatorString == "+" && leftIsInteger && rightIsInteger) {
        return atom(std::to_string(leftIntegerValue + rightIntegerValue));
    }
    if (operatorString == "-" && leftIsInteger && rightIsInteger) {
        return atom(std::to_string(leftIntegerValue - rightIntegerValue));
    }
    if (operatorString == "*" && leftIsInteger && rightIsInteger) {
        return atom(std::to_string(leftIntegerValue * rightIntegerValue));
    }
    if (operatorString == "div" && leftIsInteger && rightIsInteger && rightIntegerValue != 0) {
        return atom(std::to_string(leftIntegerValue / rightIntegerValue));
    }
    if (operatorString == "mod" && leftIsInteger && rightIsInteger && rightIntegerValue != 0) {
        return atom(std::to_string(leftIntegerValue % rightIntegerValue));
    }
    if (operatorString == "<") {
        if (exprEq(leftExpression, rightExpression)) {
            return atom("false");
        }
        if (leftIsInteger && rightIsInteger) {
            return atom(leftIntegerValue < rightIntegerValue ? "true" : "false");
        }
    }
    if (operatorString == "<=") {
        if (exprEq(leftExpression, rightExpression)) {
            return atom("true");
        }
        if (leftIsInteger && rightIsInteger) {
            return atom(leftIntegerValue <= rightIntegerValue ? "true" : "false");
        }
    }
    if (operatorString == ">") {
        if (exprEq(leftExpression, rightExpression)) {
            return atom("false");
        }
        if (leftIsInteger && rightIsInteger) {
            return atom(leftIntegerValue > rightIntegerValue ? "true" : "false");
        }
    }
    if (operatorString == ">=") {
        if (exprEq(leftExpression, rightExpression)) {
            return atom("true");
        }
        if (leftIsInteger && rightIsInteger) {
            return atom(leftIntegerValue >= rightIntegerValue ? "true" : "false");
        }
    }
    if (operatorString == "and") {
        if (!leftExpression.isCompound && leftExpression.head == "true") {
            return rightExpression;
        }
        if (!rightExpression.isCompound && rightExpression.head == "true") {
            return leftExpression;
        }
        if ((!leftExpression.isCompound && leftExpression.head == "false") || (!rightExpression.isCompound && rightExpression.head == "false")) {
            return atom("false");
        }
    }
    if (operatorString == "or") {
        if (!leftExpression.isCompound && leftExpression.head == "false") {
            return rightExpression;
        }
        if (!rightExpression.isCompound && rightExpression.head == "false") {
            return leftExpression;
        }
        if ((!leftExpression.isCompound && leftExpression.head == "true") || (!rightExpression.isCompound && rightExpression.head == "true")) {
            return atom("true");
        }
    }
    Expression result;
    result.isCompound = true;
    result.head = operatorString;
    result.arguments = {leftExpression, rightExpression};
    return result;
}

Expression mkIte(const Expression& conditionExpression, const Expression& trueExpression, const Expression& falseExpression) {
    if (!conditionExpression.isCompound && conditionExpression.head == "true") {
        return trueExpression;
    }
    if (!conditionExpression.isCompound && conditionExpression.head == "false") {
        return falseExpression;
    }
    if (exprEq(trueExpression, falseExpression)) {
        return trueExpression;
    }
    Expression result;
    result.isCompound = true;
    result.head = "ite";
    result.arguments = {conditionExpression, trueExpression, falseExpression};
    return result;
}

// Shared LLVM and naming operations.
std::string intConstToString(const llvm::ConstantInt* constantInteger) {
    if (constantInteger->getType()->isIntegerTy(1)) {
        return constantInteger->isZero() ? "false" : "true";
    }
    llvm::SmallString<32> integerString;
    constantInteger->getValue().toString(integerString, 10, true);
    return std::string(integerString.str());
}

std::string getIntegerTypeName(const llvm::Type* type) {
    if (type && type->isIntegerTy()) {
        return "i" + std::to_string(type->getIntegerBitWidth());
    }
    return "<non-integer-type>";
}

std::string convertLLVMValueToString(const llvm::Value* V) {
    std::string S;
    llvm::raw_string_ostream OS(S);
    if (V) {
        V->printAsOperand(OS, false);
    }
    else {
        OS << "<null-llvm-value>";
    }
    return OS.str();
}

void addUnsupported(LoopContext& loopContext, const std::string& message) {
    for (const auto& existingMessage : loopContext.unsupported) {
        if (existingMessage == message) {
            return;
        }
    }
    loopContext.unsupported.push_back(message);
}

void addUnsupported(std::vector<std::string>& unsupportedMessages, const std::string& message) {
    for (const auto& existingMessage : unsupportedMessages) {
        if (existingMessage == message) {
            return;
        }
    }
    unsupportedMessages.push_back(message);
}

std::string getBasicBlockName(const llvm::BasicBlock* BB) {
    if (!BB) {
        return "<null-basic-block>";
    }
    if (BB->hasName()) {
        return BB->getName().str();
    }
    return convertLLVMValueToString(BB);
}

std::string makeNextVariableName(const std::string& variableName) {
    return variableName + "_next";
}

std::string makeOutputVariableName(const std::string& variableName) {
    return variableName + "_out";
}

std::string makeRelationName(const std::string& loopId, const std::string& relationSuffix) {
    return loopId + "_" + relationSuffix;
}

std::string childPcPlaceholder(const std::string& childId, size_t callIndex) {
    return "<" + childId + ":call" + std::to_string(callIndex) + ":pc>";
}

std::string childReturnPcPlaceholder(const std::string& childId, size_t callIndex) {
    return "<" + childId + ":call" + std::to_string(callIndex) + ":return_pc>";
}

std::string childValuePlaceholder(const std::string& childId, size_t callIndex, const std::string& variableName) {
    return "<" + childId + ":call" + std::to_string(callIndex) + ":" + variableName + ">";
}

std::vector<llvm::BasicBlock*> getSuccessorsOfTerminator(llvm::Instruction* terminator) {
    std::vector<llvm::BasicBlock*> successors;
    if (!terminator) {
        return successors;
    }
    if (auto* branchInstruction = dyn_cast<llvm::BranchInst>(terminator)) {
        for (unsigned index = 0; index < branchInstruction->getNumSuccessors(); ++index) {
            successors.push_back(branchInstruction->getSuccessor(index));
        }
        return successors;
    }
    if (auto* switchInstruction = dyn_cast<llvm::SwitchInst>(terminator)) {
        std::set<llvm::BasicBlock*> seen;
        for (auto switchCase : switchInstruction->cases()) {
            llvm::BasicBlock* successor = switchCase.getCaseSuccessor();
            if (seen.insert(successor).second) {
                successors.push_back(successor);
            }
        }
        llvm::BasicBlock* defaultSuccessor = switchInstruction->getDefaultDest();
        if (seen.insert(defaultSuccessor).second) {
            successors.push_back(defaultSuccessor);
        }
        return successors;
    }
    return successors;
}

// >>> NEXUS CHANGE BEGIN [2.4.4 - source-defined loop relationships]
// Cleared for each entry function. These maps capture source C nesting even
// when LLVM LoopInfo splits a syntactically nested return-only branch into
// disjoint top-level natural loops. Neither JSON nor witness semantics change.
std::map<const llvm::Loop*, unsigned> sourceLoopIdsByIRLoop;
std::map<const llvm::Loop*, const llvm::Loop*> sourceParentsByIRLoop;
std::map<const llvm::Loop*, std::vector<llvm::Loop*>> sourceChildrenByIRLoop;

const llvm::Loop* getSemanticParentLoop(const llvm::Loop* loop) {
    if (!loop) return nullptr;
    auto it = sourceParentsByIRLoop.find(loop);
    return it == sourceParentsByIRLoop.end() ? loop->getParentLoop() : it->second;
}
std::vector<llvm::Loop*> getSemanticChildLoops(const llvm::Loop* loop) {
    if (!loop) return {};
    auto it = sourceChildrenByIRLoop.find(loop);
    if (it != sourceChildrenByIRLoop.end()) return it->second;
    return std::vector<llvm::Loop*>(loop->getSubLoops().begin(), loop->getSubLoops().end());
}
// <<< NEXUS CHANGE END [2.4.4 - source-defined loop relationships]

// Loop discovery and relationships.
std::string getLoopId(const llvm::Loop* L) {
    std::string key;
    if (!L) {
        key = "<null-loop>";
    }
    else {
        const llvm::BasicBlock* BB = L->getHeader();
        std::string BBName = getBasicBlockName(BB);
        const llvm::Function* F = BB->getParent();
        std::string FName = F->getName().str();
        key = FName + "::" + BBName;
    }
    auto it = loopIds.find(key);
    if (it != loopIds.end()) {
        return it->second;
    }
    std::string id = "l" + std::to_string(nextLoopId++);
    loopIds[key] = id;
    return id;
}

std::vector<llvm::Loop*> collectLoops(llvm::LoopInfo& loopInfo) {
    std::vector<llvm::Loop*> loops;
    std::vector<llvm::Loop*> worklist;
    for (llvm::Loop* topLevelLoop : loopInfo) {
        worklist.push_back(topLevelLoop);
    }
    while (!worklist.empty()) {
        llvm::Loop* loop = worklist.back();
        worklist.pop_back();
        loops.push_back(loop);
        for (llvm::Loop* childLoop : loop->getSubLoops()) {
            worklist.push_back(childLoop);
        }
    }
    return loops;
}

bool loopIsBeforeLoopInFunctionOrder(const llvm::Loop* leftLoop, const llvm::Loop* rightLoop) {
    if (!leftLoop || !rightLoop || !leftLoop->getHeader() || !rightLoop->getHeader()) {
        return false;
    }
    const llvm::Function* function = leftLoop->getHeader()->getParent();
    if (!function || function != rightLoop->getHeader()->getParent()) {
        return false;
    }
    for (const llvm::BasicBlock& block : *function) {
        if (&block == leftLoop->getHeader()) {
            return true;
        }
        if (&block == rightLoop->getHeader()) {
            return false;
        }
    }
    return false;
}

void sortLoops(std::vector<llvm::Loop*>& loops) {
    auto getLoopSourceOccurrence = [&](const llvm::Loop* loop) -> std::optional<std::pair<unsigned, unsigned>> {
        if (!loop || !loop->getHeader()) {
            return std::nullopt;
        }
        for (const llvm::Instruction& instruction : *loop->getHeader()) {
            const llvm::DebugLoc& debugLocation = instruction.getDebugLoc();
            if (debugLocation && debugLocation.getLine() != 0) {
                return std::make_pair(debugLocation.getLine(), debugLocation.getCol());
            }
        }
        return std::nullopt;
    };
    bool allLoopsHaveSourceLocations = !loops.empty();
    std::map<const llvm::Loop*, std::pair<unsigned, unsigned>> sourceLocations;
    for (llvm::Loop* loop : loops) {
        const auto sourceLocation = getLoopSourceOccurrence(loop);
        if (!sourceLocation) {
            allLoopsHaveSourceLocations = false;
            break;
        }
        sourceLocations[loop] = *sourceLocation;
    }
    if (allLoopsHaveSourceLocations) {
        std::stable_sort(loops.begin(), loops.end(), [&](llvm::Loop* leftLoop, llvm::Loop* rightLoop) {
            const auto& leftLocation = sourceLocations.at(leftLoop);
            const auto& rightLocation = sourceLocations.at(rightLoop);
            if (leftLocation != rightLocation) {
                return leftLocation < rightLocation;
            }
            return loopIsBeforeLoopInFunctionOrder(leftLoop, rightLoop);
        });
        return;
    }
    std::stable_sort(loops.begin(), loops.end(), [](llvm::Loop* leftLoop, llvm::Loop* rightLoop) {
        return loopIsBeforeLoopInFunctionOrder(leftLoop, rightLoop);
    });
}

std::vector<llvm::BasicBlock*> getUniqueExitBlocks(llvm::Loop* loop) {
    std::vector<llvm::BasicBlock*> exits;
    if (!loop) {
        return exits;
    }
    llvm::SmallVector<llvm::BasicBlock*, 16> rawExits;
    loop->getExitBlocks(rawExits);
    std::set<llvm::BasicBlock*> seen;
    for (llvm::BasicBlock* exitBlock : rawExits) {
        if (exitBlock && seen.insert(exitBlock).second) {
            exits.push_back(exitBlock);
        }
    }
    return exits;
}

// >>> NEXUS CHANGE BEGIN [2.4.4 - exact source-level identity for return edges]
struct SourceReturnProvenance {
    unsigned depth = 0;
    bool hasLoopIds = false;
    std::set<unsigned> loopIds;
};

std::optional<SourceReturnProvenance> getSourceReturnProvenance(const llvm::BasicBlock* block) {
    if (!block) return std::nullopt;
    constexpr llvm::StringLiteral prefix("NEXUS_SOURCE_RETURN_DEPTH_");
    for (const llvm::Instruction& instruction : *block) {
        const auto* call = llvm::dyn_cast<llvm::CallBase>(&instruction);
        if (!call || !call->isInlineAsm()) continue;
        const auto* asmValue = llvm::dyn_cast<llvm::InlineAsm>(call->getCalledOperand()->stripPointerCasts());
        if (!asmValue) continue;
        const llvm::StringRef text = asmValue->getAsmString();
        const size_t start = text.find(prefix);
        if (start == llvm::StringRef::npos) continue;
        const llvm::StringRef payload = text.substr(start + prefix.size());
        auto parts = payload.split("_IDS");
        SourceReturnProvenance result;
        if (parts.first.getAsInteger(10, result.depth)) return std::nullopt;
        if (parts.second.empty()) return result; // Compatibility with older IR.
        result.hasLoopIds = true;
        llvm::StringRef rest = parts.second;
        if (rest == "_NONE") return result;
        // >>> NEXUS CHANGE BEGIN [2.4.4 - parse every nested ancestor ID]
        if (!rest.consume_front("_")) return std::nullopt;
        while (!rest.empty()) {
            auto split = rest.split('_');
            unsigned id = 0;
            if (split.first.getAsInteger(10, id) || id == 0) return std::nullopt;
            result.loopIds.insert(id);
            rest = split.second;
        }
        return result;
        // <<< NEXUS CHANGE END [2.4.4 - parse every nested ancestor ID]
    }
    return std::nullopt;
}

std::optional<SourceReturnProvenance> getReturnOnForcedExitPath(const llvm::BasicBlock* initialBlock) {
    std::set<const llvm::BasicBlock*> visited;
    const llvm::BasicBlock* block = initialBlock;
    while (block && visited.insert(block).second) {
        if (auto marker = getSourceReturnProvenance(block)) return marker;
        const auto* branch = llvm::dyn_cast<llvm::BranchInst>(block->getTerminator());
        if (!branch || !branch->isUnconditional()) return std::nullopt;
        for (const llvm::Instruction& instruction : *block) {
            if (llvm::isa<llvm::PHINode>(&instruction) ||
                llvm::isa<llvm::DbgInfoIntrinsic>(&instruction) ||
                &instruction == block->getTerminator()) continue;
            return std::nullopt;
        }
        block = branch->getSuccessor(0);
    }
    return std::nullopt;
}

bool returnBelongsToLoop(const llvm::Loop* loop, const SourceReturnProvenance& marker) {
    if (!loop) return false;
    if (marker.hasLoopIds) {
        auto it = sourceLoopIdsByIRLoop.find(loop);
        return it != sourceLoopIdsByIRLoop.end() && marker.loopIds.count(it->second) != 0;
    }
    // Only unannotated legacy bitcode uses the old depth comparison.
    return marker.depth >= loop->getLoopDepth();
}

bool isSemanticReturnExitEdge(const llvm::Loop* loop, const llvm::BasicBlock* sourceBlock,
                              const llvm::BasicBlock* successorBlock) {
    if (!loop || !sourceBlock || !successorBlock || loop->contains(successorBlock)) return false;
    if (llvm::isa<llvm::ReturnInst>(sourceBlock->getTerminator())) return true;
    if (auto marker = getSourceReturnProvenance(sourceBlock)) {
        if (returnBelongsToLoop(loop, *marker)) return true;
    }
    if (auto marker = getReturnOnForcedExitPath(successorBlock)) {
        return returnBelongsToLoop(loop, *marker);
    }
    return false;
}

// Inline assembly markers are intentional side-effect-free *source* tags.
// Read the tag only from blocks owned directly by a natural loop, never from
// its LLVM subloops, so the outer loop cannot accidentally inherit a child's ID.
std::optional<std::pair<unsigned, unsigned>> readSourceLoopTag(const llvm::BasicBlock* block) {
    constexpr llvm::StringLiteral prefix("NEXUS_SOURCE_LOOP_ID_");
    for (const llvm::Instruction& instruction : *block) {
        const auto* call = llvm::dyn_cast<llvm::CallBase>(&instruction);
        if (!call || !call->isInlineAsm()) continue;
        const auto* asmValue = llvm::dyn_cast<llvm::InlineAsm>(call->getCalledOperand()->stripPointerCasts());
        if (!asmValue) continue;
        llvm::StringRef text = asmValue->getAsmString();
        size_t markerStart = text.find(prefix);
        if (markerStart == llvm::StringRef::npos) continue;
        auto parts = text.substr(markerStart + prefix.size()).split("_PARENT_");
        unsigned sourceId = 0, sourceParent = 0;
        if (parts.first.getAsInteger(10, sourceId) ||
            parts.second.getAsInteger(10, sourceParent) || sourceId == 0) return std::nullopt;
        return std::make_pair(sourceId, sourceParent);
    }
    return std::nullopt;
}

void associateSourceLoops(llvm::LoopInfo& loopInfo, const std::vector<llvm::Loop*>& allLoops) {
    sourceLoopIdsByIRLoop.clear();
    sourceParentsByIRLoop.clear();
    sourceChildrenByIRLoop.clear();
    std::map<unsigned, llvm::Loop*> irBySourceId;
    std::map<llvm::Loop*, unsigned> parentIdByIR;
    for (llvm::Loop* loop : allLoops) {
        for (llvm::BasicBlock* block : loop->blocks()) {
            if (loopInfo.getLoopFor(block) != loop) continue;
            if (auto marker = readSourceLoopTag(block)) {
                sourceLoopIdsByIRLoop[loop] = marker->first;
                parentIdByIR[loop] = marker->second;
                irBySourceId[marker->first] = loop;
                break;
            }
        }
    }
    for (llvm::Loop* loop : allLoops) {
        auto parentIt = parentIdByIR.find(loop);
        if (parentIt == parentIdByIR.end()) continue;
        llvm::Loop* parent = nullptr;
        if (parentIt->second != 0) {
            auto found = irBySourceId.find(parentIt->second);
            if (found != irBySourceId.end()) parent = found->second;
            else continue; // Unknown source parent: retain LLVM relationship.
        }
        sourceParentsByIRLoop[loop] = parent;
    }
    for (llvm::Loop* loop : allLoops) {
        if (const llvm::Loop* parent = getSemanticParentLoop(loop)) {
            sourceChildrenByIRLoop[parent].push_back(loop);
        }
    }
    for (llvm::Loop* loop : allLoops) {
        sourceChildrenByIRLoop.try_emplace(loop);
    }
}

// A lexical C child loop may lie outside its parent's LLVM natural-loop
// blocks. Permit walking to its header only through *empty unconditional*
// blocks. Never silently skip a statement or a conditional branch.
bool isSourceChildCorridor(const llvm::Loop* parent, const llvm::BasicBlock* initialBlock) {
    const std::vector<llvm::Loop*> children = getSemanticChildLoops(parent);
    if (children.empty()) return false;
    const llvm::BasicBlock* block = initialBlock;
    std::set<const llvm::BasicBlock*> visited;
    while (block && visited.insert(block).second) {
        for (const llvm::Loop* child : children) {
            if (child->contains(block)) return true;
        }
        const auto* branch = llvm::dyn_cast<llvm::BranchInst>(block->getTerminator());
        if (!branch || !branch->isUnconditional()) return false;
        for (const llvm::Instruction& instruction : *block) {
            if (llvm::isa<llvm::PHINode>(&instruction) ||
                llvm::isa<llvm::DbgInfoIntrinsic>(&instruction) ||
                &instruction == block->getTerminator()) continue;
            return false;
        }
        block = branch->getSuccessor(0);
    }
    return false;
}
// >>> NEXUS CHANGE BEGIN [2.4.4 - refuse truncated source-scoped returns]
bool reachesUnmodeledSourceContinuation(const llvm::Loop* loop, const llvm::BasicBlock* start) {
    if (!loop || !start) return false;
    // >>> NEXUS CHANGE BEGIN [2.4.5 - bound exit-corridor search to this parent iteration]
    // The source-level parent iteration ends when control reaches its header.
    // Anything that occurs after that backedge belongs to a *future* parent
    // iteration, not to the current exit of this child.  This is essential
    // even when LLVM LoopInfo and source nesting are different.
    const llvm::Loop* enclosingLoop = getSemanticParentLoop(loop);
    // <<< NEXUS CHANGE END [2.4.5 - bound exit-corridor search to this parent iteration]
    std::queue<const llvm::BasicBlock*> work;
    std::set<const llvm::BasicBlock*> seen;
    work.push(start);
    seen.insert(start);
    while (!work.empty()) {
        const llvm::BasicBlock* block = work.front();
        work.pop();
        // >>> NEXUS CHANGE BEGIN [2.4.5 - do not inspect future parent iterations]
        if (enclosingLoop && block == enclosingLoop->getHeader()) {
            continue;  // Normal completion of the current enclosing iteration.
        }
        // <<< NEXUS CHANGE END [2.4.5 - do not inspect future parent iterations]
        if (auto marker = getSourceReturnProvenance(block)) {
            if (returnBelongsToLoop(loop, *marker)) return true;
        }
        // >>> NEXUS CHANGE BEGIN [2.4.4 - account for unmatched lexical continuation]
        // A path outside the LLVM parent that enters a lexical child or
        // returns to the parent header must not be modeled as a normal exit.
        if (block == loop->getHeader()) return true;
        for (llvm::Loop* child : getSemanticChildLoops(loop)) {
            if (child->contains(block)) return true;
        }
        // <<< NEXUS CHANGE END [2.4.4 - account for unmatched lexical continuation]
        const auto* terminator = block->getTerminator();
        for (unsigned i = 0; terminator && i < terminator->getNumSuccessors(); ++i) {
            const llvm::BasicBlock* succ = terminator->getSuccessor(i);
            // Do not treat a future iteration's return as the current exit.
            // >>> NEXUS CHANGE BEGIN [2.4.4 - catch reentry outside LLVM region]
            // >>> NEXUS CHANGE BEGIN [2.4.5 - distinguish parent backedge from child reentry]
            if (enclosingLoop && succ == enclosingLoop->getHeader()) {
                continue;  // Boundary: subsequent child executions are not this exit.
            }
            if (succ && loop->contains(succ)) {
                return true;  // Reentering the child (even via its body) is not a normal exit.
            }
            if (succ && seen.insert(succ).second) work.push(succ);
            // <<< NEXUS CHANGE END [2.4.5 - distinguish parent backedge from child reentry]
            // <<< NEXUS CHANGE END [2.4.4 - catch reentry outside LLVM region]
        }
    }
    return false;
}
// <<< NEXUS CHANGE END [2.4.4 - refuse truncated source-scoped returns]
// <<< NEXUS CHANGE END [2.4.4 - exact source-level identity for return edges]

bool isAncestorLoopOf(const llvm::Loop* possibleAncestor, const llvm::Loop* loop) {
    if (!possibleAncestor || !loop) {
        return false;
    }
    // >>> NEXUS CHANGE BEGIN [2.4.4 - source lexical parent traversal]
    for (const llvm::Loop* parent = getSemanticParentLoop(loop); parent; parent = getSemanticParentLoop(parent)) {
    // <<< NEXUS CHANGE END [2.4.4 - source lexical parent traversal]
        if (parent == possibleAncestor) {
            return true;
        }
    }
    return false;
}

bool loopsShareImmediateParent(const llvm::Loop* leftLoop, const llvm::Loop* rightLoop) {
    // >>> NEXUS CHANGE BEGIN [2.4.4 - compare source siblings, not LLVM siblings]
    return leftLoop && rightLoop && getSemanticParentLoop(leftLoop) == getSemanticParentLoop(rightLoop);
    // <<< NEXUS CHANGE END [2.4.4 - compare source siblings, not LLVM siblings]
}

// >>> NEXUS CHANGE BEGIN [1.1 - CFG-correct sibling loop ordering]
// A sequential dependency is a path from a normal exit of one sibling loop
// to the header of another sibling *within the same enclosing iteration*.
// In particular, an enclosing-loop backedge must NEVER be used to claim that
// a later sibling executes before an earlier sibling. LLVM basic-block order
// is not execution order, so this test is based exclusively on CFG edges.
// Both previous/next queries use this single predicate to ensure symmetry.
bool canReachFollowingSiblingInSameParentIteration(
    llvm::Loop* sourceLoop,
    llvm::Loop* targetLoop,
    const std::vector<llvm::Loop*>& allLoops) {
    if (!sourceLoop || !targetLoop || sourceLoop == targetLoop ||
        !sourceLoop->getHeader() || !targetLoop->getHeader() ||
        !loopsShareImmediateParent(sourceLoop, targetLoop) ||
        sourceLoop->getHeader()->getParent() != targetLoop->getHeader()->getParent()) {
        return false;
    }

    // >>> NEXUS CHANGE BEGIN [2.4.4 - source parent for sequential ordering]
    llvm::Loop* commonParent = const_cast<llvm::Loop*>(getSemanticParentLoop(sourceLoop));
    // <<< NEXUS CHANGE END [2.4.4 - source parent for sequential ordering]
    llvm::BasicBlock* parentHeader = commonParent ? commonParent->getHeader() : nullptr;
    llvm::BasicBlock* targetHeader = targetLoop->getHeader();
    llvm::Function* function = sourceLoop->getHeader()->getParent();

    // Treat other loops as atomic components: a path through their bodies
    // must be represented by their own exit summaries, not a raw CFG walk.
    // Never re-enter the source loop after using one of its normal exits.
    auto isAllowedBlock = [&](llvm::BasicBlock* block) -> bool {
        if (!block || block->getParent() != function) {
            return false;
        }
        if (commonParent && (!commonParent->contains(block) || block == parentHeader)) {
            return false; // Outside this parent iteration, or crossing its backedge.
        }
        if (sourceLoop->contains(block)) {
            return false;
        }
        if (targetLoop->contains(block) && block != targetHeader) {
            return false;
        }
        for (llvm::Loop* otherLoop : allLoops) {
            if (!otherLoop || otherLoop == sourceLoop || otherLoop == targetLoop ||
                isAncestorLoopOf(otherLoop, sourceLoop) ||
                isAncestorLoopOf(otherLoop, targetLoop)) {
                continue;
            }
            if (otherLoop->contains(block)) {
                return false;
            }
        }
        return true;
    };

    llvm::SmallVector<std::pair<llvm::BasicBlock*, llvm::BasicBlock*>, 16> exitEdges;
    sourceLoop->getExitEdges(exitEdges);
    for (const auto& [exitSource, exitTarget] : exitEdges) {
        // A function return is not a normal sequential predecessor exit.
        // This matches the return-exit filtering in generateEntryStates().
        if (!exitSource || !isAllowedBlock(exitTarget) ||
            isSemanticReturnExitEdge(sourceLoop, exitSource, exitTarget)) {
            continue;
        }

        std::queue<llvm::BasicBlock*> worklist;
        std::set<llvm::BasicBlock*> visited;
        worklist.push(exitTarget);
        visited.insert(exitTarget);
        while (!worklist.empty()) {
            llvm::BasicBlock* current = worklist.front();
            worklist.pop();
            if (current == targetHeader) {
                return true;
            }
            for (llvm::BasicBlock* successor : getSuccessorsOfTerminator(current->getTerminator())) {
                if (isAllowedBlock(successor) && visited.insert(successor).second) {
                    worklist.push(successor);
                }
            }
        }
    }
    return false;
}

std::vector<llvm::Loop*> getPreviousSequentialLoops(llvm::Loop* targetLoop, const std::vector<llvm::Loop*>& allLoops) {
    std::vector<llvm::Loop*> previousLoops;
    for (llvm::Loop* candidateLoop : allLoops) {
        if (canReachFollowingSiblingInSameParentIteration(candidateLoop, targetLoop, allLoops)) {
            previousLoops.push_back(candidateLoop);
        }
    }
    std::sort(previousLoops.begin(), previousLoops.end(), [](llvm::Loop* leftLoop, llvm::Loop* rightLoop) {
        return loopIsBeforeLoopInFunctionOrder(leftLoop, rightLoop);
    });
    return previousLoops;
}

std::vector<llvm::Loop*> getNextSequentialLoops(llvm::Loop* targetLoop, const std::vector<llvm::Loop*>& allLoops) {
    std::vector<llvm::Loop*> nextLoops;
    for (llvm::Loop* candidateLoop : allLoops) {
        if (canReachFollowingSiblingInSameParentIteration(targetLoop, candidateLoop, allLoops)) {
            nextLoops.push_back(candidateLoop);
        }
    }
    std::sort(nextLoops.begin(), nextLoops.end(), [](llvm::Loop* leftLoop, llvm::Loop* rightLoop) {
        return loopIsBeforeLoopInFunctionOrder(leftLoop, rightLoop);
    });
    return nextLoops;
}
// <<< NEXUS CHANGE END [1.1 - CFG-correct sibling loop ordering]

// Variable and state extraction.
std::vector<StateVariable> extractVariables(llvm::Loop* loop, const std::string& loopId) {
    std::vector<StateVariable> trackedVariables;
    llvm::Function* parentFunction = loop->getHeader()->getParent();
    llvm::BasicBlock& functionEntryBlock = parentFunction->getEntryBlock();
    unsigned nextVariableIndex = 1;
    for (llvm::Instruction& instruction : functionEntryBlock) {
        auto* stackAllocation = dyn_cast<llvm::AllocaInst>(&instruction);
        if (!stackAllocation) {
            continue;
        }
        if (!stackAllocation->getAllocatedType()->isIntegerTy()) {
            continue;
        }
        if (!stackAllocation->isStaticAlloca()) {
            continue;
        }
        StateVariable trackedVariable;
        trackedVariable.slot = stackAllocation;
        trackedVariable.name = loopId + "_v" + std::to_string(nextVariableIndex++);
        trackedVariable.llvmName = convertLLVMValueToString(stackAllocation);
        trackedVariable.type = getIntegerTypeName(stackAllocation->getAllocatedType());
        trackedVariables.push_back(std::move(trackedVariable));
    }
    llvm::Module* parentModule = parentFunction->getParent();
    for (llvm::GlobalVariable& globalVariable : parentModule->globals()) {
        if (!globalVariable.getValueType()->isIntegerTy()) {
            continue;
        }
        if (globalVariable.isConstant()) {
            continue;
        }
        bool isUsedInParentFunction = false;
        for (const llvm::User* user : globalVariable.users()) {
            const auto* userInstruction = dyn_cast<llvm::Instruction>(user);
            if (!userInstruction) {
                continue;
            }
            if (userInstruction->getFunction() == parentFunction) {
                isUsedInParentFunction = true;
                break;
            }
        }
        if (!isUsedInParentFunction) {
            continue;
        }
        StateVariable trackedVariable;
        trackedVariable.slot = &globalVariable;
        trackedVariable.name = loopId + "_v" + std::to_string(nextVariableIndex++);
        trackedVariable.llvmName = convertLLVMValueToString(&globalVariable);
        trackedVariable.type = getIntegerTypeName(globalVariable.getValueType());
        trackedVariables.push_back(std::move(trackedVariable));
    }
    return trackedVariables;
}

std::vector<std::string> getCurrentVariableNames(const std::vector<StateVariable>& variables) {
    std::vector<std::string> names;
    for (const auto& variable : variables) {
        names.push_back(variable.name);
    }
    return names;
}

std::vector<std::string> getNextVariableNames(const std::vector<StateVariable>& variables) {
    std::vector<std::string> names;
    for (const auto& variable : variables) {
        names.push_back(makeNextVariableName(variable.name));
    }
    return names;
}

std::vector<std::string> getOutputVariableNames(const std::vector<StateVariable>& variables) {
    std::vector<std::string> names;
    for (const auto& variable : variables) {
        names.push_back(makeOutputVariableName(variable.name));
    }
    return names;
}

// >>> NEXUS CHANGE BEGIN [2.3 - explicit benchmark primitive semantics]
// These are *Nexus benchmark contracts*, not general C/POSIX semantics:
//   int random(void) -> independently chosen mathematical integer per call;
//   void tick(int)   -> total, state-preserving cost observation (cost ignored).
// No configuration file or hardcoded assumptions for any other user function.
// Only *declarations* with the expected LLVM signature receive a summary.
enum class KnownCallSemantics { Unsupported, NondetInteger, StatePreservingVoid };

KnownCallSemantics classifyKnownCall(const llvm::CallBase* call) {
    if (!call) return KnownCallSemantics::Unsupported;
    if (call->isInlineAsm()) {
        const auto* inlineAssembly = llvm::dyn_cast<llvm::InlineAsm>(call->getCalledOperand()->stripPointerCasts());
        // >>> NEXUS CHANGE BEGIN [2.4.4 - loop markers are analysis-only calls]
        if (inlineAssembly && (inlineAssembly->getAsmString().find("NEXUS_SOURCE_RETURN") != std::string::npos ||
            inlineAssembly->getAsmString().find("NEXUS_SOURCE_LOOP_ID_") != std::string::npos) &&
            call->getType()->isVoidTy() && call->arg_size() == 0) {
        // <<< NEXUS CHANGE END [2.4.4 - loop markers are analysis-only calls]
            return KnownCallSemantics::StatePreservingVoid;
        }
        return KnownCallSemantics::Unsupported;
    }
    const llvm::Function* callee = call->getCalledFunction();
    if (!callee) return KnownCallSemantics::Unsupported;
    if (callee->isIntrinsic()) {
        if (callee->getIntrinsicID() == llvm::Intrinsic::lifetime_start ||
            callee->getIntrinsicID() == llvm::Intrinsic::lifetime_end) {
            return KnownCallSemantics::StatePreservingVoid;
        }
        return KnownCallSemantics::Unsupported;
    }
    if (!callee->isDeclaration()) return KnownCallSemantics::Unsupported;
    const auto name = callee->getName();
    if (call->getType()->isIntegerTy() && call->arg_size() == 0 &&
        (name.starts_with("__VERIFIER_nondet_") || name == "nondet")) {
        return KnownCallSemantics::NondetInteger;
    }
    if (name == "random" && call->getType()->isIntegerTy(32) && call->arg_size() == 0 &&
        callee->arg_size() == 0) {
        // In C, `int random();` is an old-style declaration: Clang emits
        // `declare i32 @random(...)` despite this zero-argument call.
        return KnownCallSemantics::NondetInteger;
    }
    if (name == "tick" && call->getType()->isVoidTy() && call->arg_size() == 1 &&
        call->getArgOperand(0)->getType()->isIntegerTy(32) &&
        !callee->isVarArg() && callee->arg_size() == 1) {
        return KnownCallSemantics::StatePreservingVoid;
    }
    return KnownCallSemantics::Unsupported;
}
// <<< NEXUS CHANGE END [2.3 - explicit benchmark primitive semantics]

// Symbolic execution.
Expression evaluateValue(const llvm::Value* llvmValue, LoopContext& loopContext, SymbolicState& symbolicState) {
    if (!llvmValue) {
        return atom("<null>");
    }
    auto cachedExpressionIt = symbolicState.valueExpr.find(llvmValue);
    if (cachedExpressionIt != symbolicState.valueExpr.end()) {
        return cachedExpressionIt->second;
    }
    if (const auto* constantInteger = dyn_cast<llvm::ConstantInt>(llvmValue)) {
        Expression result = atom(intConstToString(constantInteger));
        symbolicState.valueExpr[llvmValue] = result;
        return result;
    }
    if (isa<llvm::UndefValue>(llvmValue)) {
        addUnsupported(loopContext, "undef value encountered");
        return atom("<undef>");
    }
    if (isa<llvm::PoisonValue>(llvmValue)) {
        addUnsupported(loopContext, "poison value encountered");
        return atom("<poison>");
    }
    if (const auto* functionArgument = dyn_cast<llvm::Argument>(llvmValue)) {
        std::string argumentName;
        if (!functionArgument) {
            argumentName = "<null-arg>";
        }
        else if (functionArgument->hasName()) {
            argumentName = functionArgument->getName().str();
        }
        else {
            argumentName = "arg" + std::to_string(functionArgument->getArgNo());
        }
        Expression result = atom(argumentName);
        symbolicState.valueExpr[llvmValue] = result;
        return result;
    }
    if (const auto* stackAllocation = dyn_cast<llvm::AllocaInst>(llvmValue)) {
        auto variableNameIt = loopContext.variableNames.find(stackAllocation);
        if (variableNameIt != loopContext.variableNames.end()) {
            Expression result = atom(variableNameIt->second);
            symbolicState.valueExpr[llvmValue] = result;
            return result;
        }
        addUnsupported(loopContext, "untracked alloca used inside symbolic expression: " + convertLLVMValueToString(stackAllocation));
        return atom("<untracked-alloca>");
    }
    if (const auto* globalVariable = dyn_cast<llvm::GlobalVariable>(llvmValue)) {
        auto variableNameIt = loopContext.variableNames.find(globalVariable);
        if (variableNameIt != loopContext.variableNames.end()) {
            Expression result = atom(variableNameIt->second);
            symbolicState.valueExpr[llvmValue] = result;
            return result;
        }
        addUnsupported(loopContext, "untracked global used inside symbolic expression: " + convertLLVMValueToString(globalVariable));
        return atom("<untracked-global>");
    }
    const auto* instruction = dyn_cast<llvm::Instruction>(llvmValue);
    if (!instruction) {
        addUnsupported(loopContext, "unsupported value kind in symbolic evaluator");
        return atom("<unsupported-value>");
    }
    if (isa<llvm::PHINode>(instruction)) {
        auto phiExpressionIt = symbolicState.valueExpr.find(instruction);
        if (phiExpressionIt != symbolicState.valueExpr.end()) {
            return phiExpressionIt->second;
        }
        addUnsupported(loopContext, "phi node used before predecessor-sensitive resolution: " + convertLLVMValueToString(instruction));
        return atom("<unresolved-phi>");
    }
    Expression result = atom("<unsupported>");
    if (const auto* loadInstruction = dyn_cast<llvm::LoadInst>(instruction)) {
        const llvm::Value* loadedPointer = loadInstruction->getPointerOperand()->stripPointerCasts();
        if (isa<llvm::AllocaInst>(loadedPointer) || isa<llvm::GlobalVariable>(loadedPointer)) {
            auto memoryExpressionIt = symbolicState.memoryExpr.find(loadedPointer);
            if (memoryExpressionIt != symbolicState.memoryExpr.end()) {
                result = memoryExpressionIt->second;
            }
            else {
                addUnsupported(loopContext, "load from tracked slot without current symbolic memory: " + convertLLVMValueToString(loadedPointer));
                result = atom("<missing-memory>");
            }
        }
        else {
            addUnsupported(loopContext, "load from non-tracked memory is unsupported: " + convertLLVMValueToString(loadedPointer));
            result = atom("<unsupported-load>");
        }
    }
    else if (const auto* binaryInstruction = dyn_cast<llvm::BinaryOperator>(instruction)) {
        Expression leftOperand = evaluateValue(binaryInstruction->getOperand(0), loopContext, symbolicState);
        Expression rightOperand = evaluateValue(binaryInstruction->getOperand(1), loopContext, symbolicState);
        switch (binaryInstruction->getOpcode()) {
            case llvm::Instruction::Add:
                result = mkBin("+", leftOperand, rightOperand);
                break;
            case llvm::Instruction::Sub:
                result = mkBin("-", leftOperand, rightOperand);
                break;
            case llvm::Instruction::Mul:
                result = mkBin("*", leftOperand, rightOperand);
                break;
            case llvm::Instruction::SDiv:
            case llvm::Instruction::UDiv:
                result = mkBin("div", leftOperand, rightOperand);
                break;
            case llvm::Instruction::SRem:
            case llvm::Instruction::URem:
                result = mkBin("mod", leftOperand, rightOperand);
                break;
            case llvm::Instruction::And:
                if (binaryInstruction->getType() && binaryInstruction->getType()->isIntegerTy(1)) {
                    result = mkBin("and", leftOperand, rightOperand);
                }
                else {
                    result = mkBin("bvand", leftOperand, rightOperand);
                }
                break;
            case llvm::Instruction::Or:
                if (binaryInstruction->getType() && binaryInstruction->getType()->isIntegerTy(1)) {
                    result = mkBin("or", leftOperand, rightOperand);
                }
                else {
                    result = mkBin("bvor", leftOperand, rightOperand);
                }
                break;
            case llvm::Instruction::Xor:
                if (binaryInstruction->getType() && binaryInstruction->getType()->isIntegerTy(1)) {
                    result = mkOr({mkAnd({leftOperand, mkNot(rightOperand)}), mkAnd({mkNot(leftOperand), rightOperand})});
                }
                else {
                    result = mkBin("bvxor", leftOperand, rightOperand);
                }
                break;
            case llvm::Instruction::Shl:
                result = mkBin("bvshl", leftOperand, rightOperand);
                break;
            case llvm::Instruction::LShr:
                result = mkBin("bvlshr", leftOperand, rightOperand);
                break;
            case llvm::Instruction::AShr:
                result = mkBin("bvashr", leftOperand, rightOperand);
                break;
            default:
                addUnsupported(loopContext, "unsupported binary opcode in symbolic evaluation");
                result = atom("<unsupported>");
                break;
        }
    }
    else if (const auto* compareInstruction = dyn_cast<llvm::ICmpInst>(instruction)) {
        Expression leftOperand = evaluateValue(compareInstruction->getOperand(0), loopContext, symbolicState);
        Expression rightOperand = evaluateValue(compareInstruction->getOperand(1), loopContext, symbolicState);
        switch (compareInstruction->getPredicate()) {
            case llvm::ICmpInst::ICMP_EQ:
                result = mkBin("=", leftOperand, rightOperand);
                break;
            case llvm::ICmpInst::ICMP_NE:
                result = mkNot(mkBin("=", leftOperand, rightOperand));
                break;
            case llvm::ICmpInst::ICMP_SLT:
                result = mkBin("<", leftOperand, rightOperand);
                break;
            case llvm::ICmpInst::ICMP_SLE:
                result = mkBin("<=", leftOperand, rightOperand);
                break;
            case llvm::ICmpInst::ICMP_SGT:
                result = mkBin(">", leftOperand, rightOperand);
                break;
            case llvm::ICmpInst::ICMP_SGE:
                result = mkBin(">=", leftOperand, rightOperand);
                break;
            case llvm::ICmpInst::ICMP_ULT:
                result = mkBin("u<", leftOperand, rightOperand);
                break;
            case llvm::ICmpInst::ICMP_ULE:
                result = mkBin("u<=", leftOperand, rightOperand);
                break;
            case llvm::ICmpInst::ICMP_UGT:
                result = mkBin("u>", leftOperand, rightOperand);
                break;
            case llvm::ICmpInst::ICMP_UGE:
                result = mkBin("u>=", leftOperand, rightOperand);
                break;
            default:
                result = atom("<unsupported-icmp>");
                break;
        }
    }
    else if (const auto* selectInstruction = dyn_cast<llvm::SelectInst>(instruction)) {
        Expression condition = evaluateValue(selectInstruction->getCondition(), loopContext, symbolicState);
        Expression trueValue = evaluateValue(selectInstruction->getTrueValue(), loopContext, symbolicState);
        Expression falseValue = evaluateValue(selectInstruction->getFalseValue(), loopContext, symbolicState);
        result = mkIte(condition, trueValue, falseValue);
    }
    else if (const auto* castInstruction = dyn_cast<llvm::CastInst>(instruction)) {
        Expression castOperand = evaluateValue(castInstruction->getOperand(0), loopContext, symbolicState);
        llvm::Type* sourceType = castInstruction->getSrcTy();
        llvm::Type* destinationType = castInstruction->getDestTy();
        switch (castInstruction->getOpcode()) {
            case llvm::Instruction::ZExt:
                if (sourceType->isIntegerTy(1) && destinationType->isIntegerTy()) {
                    result = mkIte(castOperand, atom("1"), atom("0"));
                }
                else {
                    result = castOperand;
                }
                break;
            case llvm::Instruction::SExt:
                if (sourceType->isIntegerTy(1) && destinationType->isIntegerTy()) {
                    result = mkIte(castOperand, atom("-1"), atom("0"));
                }
                else {
                    result = castOperand;
                }
                break;
            case llvm::Instruction::Trunc:
                if (sourceType->isIntegerTy() && destinationType->isIntegerTy(1)) {
                    result = mkNot(mkBin("=", castOperand, atom("0")));
                }
                else {
                    result = castOperand;
                }
                break;
            case llvm::Instruction::BitCast:
            case llvm::Instruction::PtrToInt:
            case llvm::Instruction::IntToPtr:
                addUnsupported(loopContext, "unsupported cast in symbolic evaluator: " + convertLLVMValueToString(instruction));
                result = atom("<unsupported-cast>");
                break;
            default:
                result = castOperand;
                break;
        }
    }
    else if (isa<llvm::FreezeInst>(instruction)) {
        result = evaluateValue(instruction->getOperand(0), loopContext, symbolicState);
    }
    // >>> NEXUS CHANGE BEGIN [2.3 - sound call evaluation]
    else if (const auto* callInstruction = dyn_cast<llvm::CallInst>(instruction)) {
        // Evaluate operands even for the modeled no-op: an operand may contain
        // a previously executed value whose symbolic semantics must be checked.
        for (unsigned argumentIndex = 0; argumentIndex < callInstruction->arg_size(); ++argumentIndex) {
            (void)evaluateValue(callInstruction->getArgOperand(argumentIndex), loopContext, symbolicState);
        }
        const KnownCallSemantics semantics = classifyKnownCall(callInstruction);
        if (semantics == KnownCallSemantics::NondetInteger) {
            const std::string nondeterministicName = loopContext.loopId + "_nd" + std::to_string(loopContext.nextNondetId++);
            loopContext.nondeterministicSymbols.emplace_back(nondeterministicName, getIntegerTypeName(callInstruction->getType()));
            result = atom(nondeterministicName);
        }
        else if (semantics == KnownCallSemantics::StatePreservingVoid) {
            result = atom("true"); // Void result is not used; no state update.
        }
        else {
            addUnsupported(loopContext, "unsupported call: " + convertLLVMValueToString(instruction));
            result = atom("<unsupported-call>");
        }
    }
    // <<< NEXUS CHANGE END [2.3 - sound call evaluation]
    else {
        addUnsupported(loopContext, "unsupported instruction in symbolic evaluator: " + convertLLVMValueToString(instruction));
        result = atom("<unsupported-inst>");
    }
    symbolicState.valueExpr[llvmValue] = result;
    return result;
}

void executeBlock(llvm::BasicBlock* basicBlock, LoopContext& loopContext, SymbolicState& symbolicState) {
    for (llvm::Instruction& instruction : *basicBlock) {
        if (isa<llvm::PHINode>(&instruction)) {
            continue;
        }
        if (instruction.isTerminator()) {
            break;
        }
        if (auto* storeInstruction = dyn_cast<llvm::StoreInst>(&instruction)) {
            const llvm::Value* storedPointer = storeInstruction->getPointerOperand()->stripPointerCasts();
            if (isa<llvm::AllocaInst>(storedPointer) || isa<llvm::GlobalVariable>(storedPointer)) {
                auto variableNameIt = loopContext.variableNames.find(storedPointer);
                if (variableNameIt != loopContext.variableNames.end()) {
                    Expression rightHandSide = evaluateValue(storeInstruction->getValueOperand(), loopContext, symbolicState);
                    symbolicState.memoryExpr[storedPointer] = rightHandSide;
                    continue;
                }
            }
            addUnsupported(loopContext, "store to non-tracked memory is unsupported: " + convertLLVMValueToString(storedPointer));
            continue;
        }
        if (isa<llvm::DbgInfoIntrinsic>(&instruction)) {
            continue;
        }
        (void)evaluateValue(&instruction, loopContext, symbolicState);
    }
}

bool addPathConstraint(SymbolicState& symbolicState, const Expression& newCondition) {
    if (!newCondition.isCompound && newCondition.head == "true") {
        return true;
    }
    if (!newCondition.isCompound && newCondition.head == "false") {
        return false;
    }
    Expression negatedCondition = mkNot(newCondition);
    for (const auto& existingCondition : symbolicState.pathConditions) {
        if (exprEq(existingCondition, newCondition)) {
            return true;
        }
        if (exprEq(existingCondition, negatedCondition)) {
            return false;
        }
    }
    symbolicState.pathConditions.push_back(newCondition);
    return true;
}

void bindPhiNodesForEntryEdge(LoopContext& loopContext, llvm::BasicBlock* predecessorBlock, llvm::BasicBlock* successorBlock, SymbolicState& stateAtSuccessor) {
    for (llvm::Instruction& instruction : *successorBlock) {
        auto* phiNode = dyn_cast<llvm::PHINode>(&instruction);
        if (!phiNode) {
            break;
        }
        llvm::Value* incomingValue = phiNode->getIncomingValueForBlock(predecessorBlock);
        Expression incomingExpression = evaluateValue(incomingValue, loopContext, stateAtSuccessor);
        stateAtSuccessor.valueExpr[phiNode] = incomingExpression;
    }
}

SymbolicState createStateFromVariableNames(const std::vector<StateVariable>& variables, const std::vector<std::string>& namesForSlots) {
    SymbolicState state;
    for (size_t variableIndex = 0; variableIndex < variables.size(); ++variableIndex) {
        const StateVariable& variable = variables[variableIndex];
        std::string name = variableIndex < namesForSlots.size() ? namesForSlots[variableIndex] : variable.name;
        state.valueExpr[variable.slot] = atom(name);
        state.memoryExpr[variable.slot] = atom(name);
    }
    return state;
}

void exploreLoopPaths(LoopContext& loopContext, llvm::BasicBlock* currentBlock, SymbolicState currentState, std::set<const llvm::BasicBlock*> visitedBlocks, std::vector<RawTransition>& rawTransitions) {
    struct ChildPlaceholderCase {
        std::string childId;
        llvm::BasicBlock* exitSourceBlock = nullptr;
        llvm::BasicBlock* exitBlock = nullptr;
        std::set<const llvm::Value*> modifiedSlots;
        std::map<std::string, Expression> entryState;
    };
    auto appendChildCall = [&](SymbolicState& symbolicState, const std::string& childId, const std::string& exitSourceBlockName, const std::string& exitBlockName, bool isReturn, const std::map<std::string, Expression>& entryState) -> size_t {
        ChildCall childCall;
        childCall.childId = childId;
        childCall.exitSourceBlockName = exitSourceBlockName;
        childCall.exitBlockName = exitBlockName;
        childCall.isReturn = isReturn;
        childCall.entryState = entryState;
        symbolicState.childCalls.push_back(childCall);
        symbolicState.hasChildComposition = true;
        symbolicState.childId = childId;
        symbolicState.childExitBlockName = exitBlockName;
        symbolicState.childEntryState = entryState;
        return symbolicState.childCalls.size();
    };
    auto recordRawTransition = [&](const std::string& transitionKind, const std::vector<std::string>& visitedBlocks, const SymbolicState& symbolicState, const LoopContext& loopContext, std::vector<RawTransition>& rawTransitions) -> void {
        RawTransition rawTransition;
        rawTransition.kind = transitionKind;
        rawTransition.literals = symbolicState.pathConditions;
        rawTransition.basicBlocks = visitedBlocks;
        rawTransition.pathCondition = mkAnd(symbolicState.pathConditions);
        if (!symbolicState.childCalls.empty()) {
            rawTransition.hasChildComposition = true;
            rawTransition.childCalls = symbolicState.childCalls;
            const ChildCall& lastChildCall = symbolicState.childCalls.back();
            rawTransition.childId = lastChildCall.childId;
            rawTransition.childExitBlockName = lastChildCall.exitBlockName;
            rawTransition.childEntryState = lastChildCall.entryState;
        }
        else if (symbolicState.hasChildComposition) {
            rawTransition.hasChildComposition = true;
            rawTransition.childId = symbolicState.childId;
            rawTransition.childExitBlockName = symbolicState.childExitBlockName;
            rawTransition.childEntryState = symbolicState.childEntryState;
        }
        if (transitionKind == "loop_back" || transitionKind == "exit") {
            for (const auto& variable : loopContext.variables) {
                std::string outputVariableName = transitionKind == "loop_back" ? makeNextVariableName(variable.name) : makeOutputVariableName(variable.name);
                auto currentSymbolicValue = symbolicState.memoryExpr.find(variable.slot);
                rawTransition.updates[outputVariableName] = (currentSymbolicValue != symbolicState.memoryExpr.end()) ? currentSymbolicValue->second : atom(variable.name);
            }
        }
        rawTransitions.push_back(std::move(rawTransition));
    };
    auto loopContainsReturn = [&](const llvm::Loop* loop) -> bool {
        if (!loop) {
            return false;
        }
        for (const llvm::BasicBlock* block : loop->blocks()) {
            if (!block) {
                continue;
            }
            if (isa<llvm::ReturnInst>(block->getTerminator())) {
                return true;
            }
            const llvm::Instruction* terminator = block->getTerminator();
            if (!terminator) {
                continue;
            }
            for (unsigned successorIndex = 0; successorIndex < terminator->getNumSuccessors(); ++successorIndex) {
                const llvm::BasicBlock* successorBlock = terminator->getSuccessor(successorIndex);
                if (isSemanticReturnExitEdge(loop, block, successorBlock)) {
                    return true;
                }
            }
        }
        return false;
    };
    auto recordChildReturnTransitionIfNeeded = [&](llvm::Loop* childLoop, const std::string& childLoopId, const SymbolicState& stateBeforeChild, const std::map<std::string, Expression>& childEntryState, LoopContext& loopContext, std::vector<RawTransition>& rawTransitions) -> void {
        if (!loopContainsReturn(childLoop)) {
            return;
        }
        SymbolicState childReturnState = stateBeforeChild;
        size_t callIndex = appendChildCall(childReturnState, childLoopId, "", "", true, childEntryState);
        if (!addPathConstraint(childReturnState, atom(childReturnPcPlaceholder(childLoopId, callIndex)))) {
            return;
        }
        std::vector<std::string> completedPath = childReturnState.pathBlocks;
        completedPath.push_back("<child_return:" + childLoopId + ">");
        recordRawTransition("return", completedPath, childReturnState, loopContext, rawTransitions);
    };
    if (visitedBlocks.count(currentBlock)) {
        addUnsupported(loopContext, "internal cycle before reaching loop header detected at " + getBasicBlockName(currentBlock));
        return;
    }
    visitedBlocks.insert(currentBlock);
    currentState.pathBlocks.push_back(getBasicBlockName(currentBlock));
    executeBlock(currentBlock, loopContext, currentState);
    llvm::Instruction* terminator = currentBlock->getTerminator();
    if (!terminator) {
        addUnsupported(loopContext, "block without terminator: " + getBasicBlockName(currentBlock));
        return;
    }
    if (isa<llvm::ReturnInst>(terminator)) {
        recordRawTransition("return", currentState.pathBlocks, currentState, loopContext, rawTransitions);
        return;
    }
    if (auto* branchInst = dyn_cast<llvm::BranchInst>(terminator)) {
        Expression branchCondition;
        unsigned successorCount = 1;
        if (branchInst->isConditional()) {
            branchCondition = evaluateValue(branchInst->getCondition(), loopContext, currentState);
            successorCount = 2;
        }
        for (unsigned successorIndex = 0; successorIndex < successorCount; ++successorIndex) {
            llvm::BasicBlock* successorBlock = branchInst->getSuccessor(successorIndex);
            SymbolicState successorState = currentState;
            Expression edgeCondition = !branchInst->isConditional() ? atom("true") : (successorIndex == 0 ? branchCondition : mkNot(branchCondition));
            if (!addPathConstraint(successorState, edgeCondition)) {
                continue;
            }
            if (successorBlock == loopContext.loop->getHeader()) {
                std::vector<std::string> completedPath = successorState.pathBlocks;
                completedPath.push_back(getBasicBlockName(successorBlock));
                recordRawTransition("loop_back", completedPath, successorState, loopContext, rawTransitions);
                continue;
            }
            // >>> NEXUS CHANGE BEGIN [2.4.4 - enter C child outside LLVM parent]
            if (!loopContext.loop->contains(successorBlock) &&
                !isSourceChildCorridor(loopContext.loop, successorBlock)) {
            // <<< NEXUS CHANGE END [2.4.4 - enter C child outside LLVM parent]
                std::vector<std::string> completedPath = successorState.pathBlocks;
                completedPath.push_back(getBasicBlockName(successorBlock));
                // >>> NEXUS CHANGE BEGIN [2.4.4 - no invented normal exit]
                if (!isSemanticReturnExitEdge(loopContext.loop, currentBlock, successorBlock) &&
                    reachesUnmodeledSourceContinuation(loopContext.loop, successorBlock)) {
                    addUnsupported(loopContext, "source-scoped return or continuation is reachable beyond an unmodeled LLVM exit corridor: " + getBasicBlockName(successorBlock));
                }
                // <<< NEXUS CHANGE END [2.4.4 - no invented normal exit]
                const std::string transitionKind = isSemanticReturnExitEdge(loopContext.loop, currentBlock, successorBlock) ? "return" : "exit";
                recordRawTransition(transitionKind, completedPath, successorState, loopContext, rawTransitions);
                continue;
            }
            llvm::Loop* childLoop = nullptr;
            // >>> NEXUS CHANGE BEGIN [2.4.4 - use source children for composed steps]
            for (llvm::Loop* subLoop : getSemanticChildLoops(loopContext.loop)) {
            // <<< NEXUS CHANGE END [2.4.4 - use source children for composed steps]
                if (subLoop->contains(successorBlock)) {
                    childLoop = subLoop;
                    break;
                }
            }
            if (childLoop) {
                std::map<std::string, Expression> childEntryState;
                for (const auto& variable : loopContext.variables) {
                    auto variableValueIt = successorState.memoryExpr.find(variable.slot);
                    childEntryState[variable.name] = (variableValueIt != successorState.memoryExpr.end()) ? variableValueIt->second : atom(variable.name);
                }
                std::string childLoopId = getLoopId(childLoop);
                recordChildReturnTransitionIfNeeded(childLoop, childLoopId, successorState, childEntryState, loopContext, rawTransitions);
                std::set<const llvm::Value*> childModifiedSlots;
                for (llvm::BasicBlock* childBlock : childLoop->blocks()) {
                    for (llvm::Instruction& instruction : *childBlock) {
                        auto* storeInst = dyn_cast<llvm::StoreInst>(&instruction);
                        if (!storeInst) {
                            continue;
                        }
                        const llvm::Value* storedSlot = storeInst->getPointerOperand()->stripPointerCasts();
                        if (loopContext.variableNames.count(storedSlot)) {
                            childModifiedSlots.insert(storedSlot);
                        }
                    }
                }
                std::vector<ChildPlaceholderCase> childExitCases;
                llvm::SmallVector<std::pair<llvm::BasicBlock*, llvm::BasicBlock*>, 8> childExitEdges;
                childLoop->getExitEdges(childExitEdges);
                std::set<std::pair<llvm::BasicBlock*, llvm::BasicBlock*>> seenExitEdges;
                for (const auto& childExitEdge : childExitEdges) {
                    llvm::BasicBlock* exitSourceBlock = childExitEdge.first;
                    llvm::BasicBlock* exitBlock = childExitEdge.second;
                    if (!exitSourceBlock || !exitBlock || !seenExitEdges.insert(childExitEdge).second) {
                        continue;
                    }
                    if (isSemanticReturnExitEdge(childLoop, exitSourceBlock, exitBlock)) {
                        continue;
                    }
                    ChildPlaceholderCase childExitCase;
                    childExitCase.childId = childLoopId;
                    childExitCase.exitSourceBlock = exitSourceBlock;
                    childExitCase.exitBlock = exitBlock;
                    childExitCase.modifiedSlots = childModifiedSlots;
                    childExitCase.entryState = childEntryState;
                    childExitCases.push_back(std::move(childExitCase));
                }
                if (childExitCases.empty()) {
                    continue;
                }
                for (const auto& childExitCase : childExitCases) {
                    SymbolicState afterChildState = successorState;
                    if (!childExitCase.exitSourceBlock || !childExitCase.exitBlock) {
                        addUnsupported(loopContext, "child placeholder without complete exit edge: " + childExitCase.childId);
                        continue;
                    }
                    const std::string childExitBlockName = getBasicBlockName(childExitCase.exitBlock);
                    size_t callIndex = appendChildCall(afterChildState, childExitCase.childId, getBasicBlockName(childExitCase.exitSourceBlock), childExitBlockName, false, childExitCase.entryState);
                    if (!addPathConstraint(afterChildState, atom(childPcPlaceholder(childExitCase.childId, callIndex)))) {
                        continue;
                    }
                    for (const auto& variable : loopContext.variables) {
                        if (childExitCase.modifiedSlots.count(variable.slot)) {
                            afterChildState.memoryExpr[variable.slot] = atom(childValuePlaceholder(childExitCase.childId, callIndex, variable.name));
                        }
                    }
                    afterChildState.pathBlocks.push_back("<child_call:" + childExitCase.childId + ":call" + std::to_string(callIndex) + ">");
                    for (llvm::Instruction& instruction : *childExitCase.exitBlock) {
                        auto* phiNode = dyn_cast<llvm::PHINode>(&instruction);
                        if (!phiNode) {
                            break;
                        }
                        afterChildState.valueExpr[phiNode] = atom("<" + childExitCase.childId + ":phi:" + convertLLVMValueToString(phiNode) + ">");
                    }
                    if (childExitCase.exitBlock == loopContext.loop->getHeader()) {
                        std::vector<std::string> completedPath = afterChildState.pathBlocks;
                        completedPath.push_back(getBasicBlockName(childExitCase.exitBlock));
                        recordRawTransition("loop_back", completedPath, afterChildState, loopContext, rawTransitions);
                        continue;
                    }
                    if (!loopContext.loop->contains(childExitCase.exitBlock)) {

                        std::vector<std::string> completedPath = afterChildState.pathBlocks;

                        completedPath.push_back(getBasicBlockName(childExitCase.exitBlock));

                        // >>> NEXUS CHANGE BEGIN [2.4.2 - classify child exit relative to parent]

                        // Normal child EXIT can immediately enter a source-level RETURN

                        // belonging to the enclosing loop (but not to the child).

                        const auto sourceReturn = getReturnOnForcedExitPath(childExitCase.exitBlock);

                        const std::string parentTransition =

                            (sourceReturn && returnBelongsToLoop(loopContext.loop, *sourceReturn)) ? "return" : "exit";

                        // >>> NEXUS CHANGE BEGIN [2.4.4 - avoid missing parent continuation]
                        if (parentTransition != "return" &&
                            (!loopContext.loop->contains(childLoop->getHeader()) ||
                             reachesUnmodeledSourceContinuation(loopContext.loop, childExitCase.exitBlock))) {
                            addUnsupported(loopContext, "source-nested child exits outside LLVM parent through an unsummarized continuation: " + childExitBlockName);
                        }
                        // <<< NEXUS CHANGE END [2.4.4 - avoid missing parent continuation]
                        recordRawTransition(parentTransition, completedPath, afterChildState, loopContext, rawTransitions);

                        // <<< NEXUS CHANGE END [2.4.2 - classify child exit relative to parent]

                        continue;

                    }
                    exploreLoopPaths(loopContext, childExitCase.exitBlock, std::move(afterChildState), visitedBlocks, rawTransitions);
                }
                continue;
            }
            for (llvm::Instruction& instruction : *successorBlock) {
                auto* phiNode = dyn_cast<llvm::PHINode>(&instruction);
                if (!phiNode) {
                    break;
                }
                llvm::Value* incomingValue = phiNode->getIncomingValueForBlock(currentBlock);
                Expression incomingExpression = evaluateValue(incomingValue, loopContext, successorState);
                successorState.valueExpr[phiNode] = incomingExpression;
            }
            exploreLoopPaths(loopContext, successorBlock, std::move(successorState), visitedBlocks, rawTransitions);
        }
        return;
    }
    if (auto* switchInst = dyn_cast<llvm::SwitchInst>(terminator)) {
        Expression switchCondition = evaluateValue(switchInst->getCondition(), loopContext, currentState);
        for (auto switchCase : switchInst->cases()) {
            SymbolicState caseState = currentState;
            Expression caseValue = atom(intConstToString(switchCase.getCaseValue()));
            if (!addPathConstraint(caseState, mkBin("=", switchCondition, caseValue))) {
                continue;
            }
            llvm::BasicBlock* successorBlock = switchCase.getCaseSuccessor();
            if (successorBlock == loopContext.loop->getHeader()) {
                std::vector<std::string> completedPath = caseState.pathBlocks;
                completedPath.push_back(getBasicBlockName(successorBlock));
                recordRawTransition("loop_back", completedPath, caseState, loopContext, rawTransitions);
                continue;
            }
            // >>> NEXUS CHANGE BEGIN [2.4.4 - enter C child outside LLVM parent]
            if (!loopContext.loop->contains(successorBlock) &&
                !isSourceChildCorridor(loopContext.loop, successorBlock)) {
            // <<< NEXUS CHANGE END [2.4.4 - enter C child outside LLVM parent]
                std::vector<std::string> completedPath = caseState.pathBlocks;
                completedPath.push_back(getBasicBlockName(successorBlock));
                // >>> NEXUS CHANGE BEGIN [2.4.4 - no invented normal exit]
                if (!isSemanticReturnExitEdge(loopContext.loop, currentBlock, successorBlock) &&
                    reachesUnmodeledSourceContinuation(loopContext.loop, successorBlock)) {
                    addUnsupported(loopContext, "source-scoped return or continuation is reachable beyond an unmodeled LLVM exit corridor: " + getBasicBlockName(successorBlock));
                }
                // <<< NEXUS CHANGE END [2.4.4 - no invented normal exit]
                const std::string transitionKind = isSemanticReturnExitEdge(loopContext.loop, currentBlock, successorBlock) ? "return" : "exit";
                recordRawTransition(transitionKind, completedPath, caseState, loopContext, rawTransitions);
                continue;
            }
            llvm::Loop* childLoop = nullptr;
            // >>> NEXUS CHANGE BEGIN [2.4.4 - use source children for composed steps]
            for (llvm::Loop* subLoop : getSemanticChildLoops(loopContext.loop)) {
            // <<< NEXUS CHANGE END [2.4.4 - use source children for composed steps]
                if (subLoop->contains(successorBlock)) {
                    childLoop = subLoop;
                    break;
                }
            }
            if (childLoop) {
                std::map<std::string, Expression> childEntryState;
                for (const auto& variable : loopContext.variables) {
                    auto variableValueIt = caseState.memoryExpr.find(variable.slot);
                    childEntryState[variable.name] = (variableValueIt != caseState.memoryExpr.end()) ? variableValueIt->second : atom(variable.name);
                }
                std::string childLoopId = getLoopId(childLoop);
                recordChildReturnTransitionIfNeeded(childLoop, childLoopId, caseState, childEntryState, loopContext, rawTransitions);
                std::set<const llvm::Value*> childModifiedSlots;
                for (llvm::BasicBlock* childBlock : childLoop->blocks()) {
                    for (llvm::Instruction& instruction : *childBlock) {
                        auto* storeInst = dyn_cast<llvm::StoreInst>(&instruction);
                        if (!storeInst) {
                            continue;
                        }
                        const llvm::Value* storedSlot = storeInst->getPointerOperand()->stripPointerCasts();
                        if (loopContext.variableNames.count(storedSlot)) {
                            childModifiedSlots.insert(storedSlot);
                        }
                    }
                }
                std::vector<ChildPlaceholderCase> childExitCases;
                llvm::SmallVector<std::pair<llvm::BasicBlock*, llvm::BasicBlock*>, 8> childExitEdges;
                childLoop->getExitEdges(childExitEdges);
                std::set<std::pair<llvm::BasicBlock*, llvm::BasicBlock*>> seenExitEdges;
                for (const auto& childExitEdge : childExitEdges) {
                    llvm::BasicBlock* exitSourceBlock = childExitEdge.first;
                    llvm::BasicBlock* exitBlock = childExitEdge.second;
                    if (!exitSourceBlock || !exitBlock || !seenExitEdges.insert(childExitEdge).second) {
                        continue;
                    }
                    if (isSemanticReturnExitEdge(childLoop, exitSourceBlock, exitBlock)) {
                        continue;
                    }
                    ChildPlaceholderCase childExitCase;
                    childExitCase.childId = childLoopId;
                    childExitCase.exitSourceBlock = exitSourceBlock;
                    childExitCase.exitBlock = exitBlock;
                    childExitCase.modifiedSlots = childModifiedSlots;
                    childExitCase.entryState = childEntryState;
                    childExitCases.push_back(std::move(childExitCase));
                }
                if (childExitCases.empty()) {
                    continue;
                }
                for (const auto& childExitCase : childExitCases) {
                    SymbolicState afterChildState = caseState;
                    if (!childExitCase.exitSourceBlock || !childExitCase.exitBlock) {
                        addUnsupported(loopContext, "child placeholder without complete exit edge: " + childExitCase.childId);
                        continue;
                    }
                    const std::string childExitBlockName = getBasicBlockName(childExitCase.exitBlock);
                    size_t callIndex = appendChildCall(afterChildState, childExitCase.childId, getBasicBlockName(childExitCase.exitSourceBlock), childExitBlockName, false, childExitCase.entryState);
                    if (!addPathConstraint(afterChildState, atom(childPcPlaceholder(childExitCase.childId, callIndex)))) {
                        continue;
                    }
                    for (const auto& variable : loopContext.variables) {
                        if (childExitCase.modifiedSlots.count(variable.slot)) {
                            afterChildState.memoryExpr[variable.slot] = atom(childValuePlaceholder(childExitCase.childId, callIndex, variable.name));
                        }
                    }
                    afterChildState.pathBlocks.push_back("<child_call:" + childExitCase.childId + ":call" + std::to_string(callIndex) + ">");
                    for (llvm::Instruction& instruction : *childExitCase.exitBlock) {
                        auto* phiNode = dyn_cast<llvm::PHINode>(&instruction);
                        if (!phiNode) {
                            break;
                        }
                        afterChildState.valueExpr[phiNode] = atom("<" + childExitCase.childId + ":phi:" + convertLLVMValueToString(phiNode) + ">");
                    }
                    if (childExitCase.exitBlock == loopContext.loop->getHeader()) {
                        std::vector<std::string> completedPath = afterChildState.pathBlocks;
                        completedPath.push_back(getBasicBlockName(childExitCase.exitBlock));
                        recordRawTransition("loop_back", completedPath, afterChildState, loopContext, rawTransitions);
                        continue;
                    }
                    if (!loopContext.loop->contains(childExitCase.exitBlock)) {

                        std::vector<std::string> completedPath = afterChildState.pathBlocks;

                        completedPath.push_back(getBasicBlockName(childExitCase.exitBlock));

                        // >>> NEXUS CHANGE BEGIN [2.4.2 - classify child exit relative to parent]

                        // Normal child EXIT can immediately enter a source-level RETURN

                        // belonging to the enclosing loop (but not to the child).

                        const auto sourceReturn = getReturnOnForcedExitPath(childExitCase.exitBlock);

                        const std::string parentTransition =

                            (sourceReturn && returnBelongsToLoop(loopContext.loop, *sourceReturn)) ? "return" : "exit";

                        // >>> NEXUS CHANGE BEGIN [2.4.4 - avoid missing parent continuation]
                        if (parentTransition != "return" &&
                            (!loopContext.loop->contains(childLoop->getHeader()) ||
                             reachesUnmodeledSourceContinuation(loopContext.loop, childExitCase.exitBlock))) {
                            addUnsupported(loopContext, "source-nested child exits outside LLVM parent through an unsummarized continuation: " + childExitBlockName);
                        }
                        // <<< NEXUS CHANGE END [2.4.4 - avoid missing parent continuation]
                        recordRawTransition(parentTransition, completedPath, afterChildState, loopContext, rawTransitions);

                        // <<< NEXUS CHANGE END [2.4.2 - classify child exit relative to parent]

                        continue;

                    }
                    exploreLoopPaths(loopContext, childExitCase.exitBlock, std::move(afterChildState), visitedBlocks, rawTransitions);
                }
                continue;
            }
            for (llvm::Instruction& instruction : *successorBlock) {
                auto* phiNode = dyn_cast<llvm::PHINode>(&instruction);
                if (!phiNode) {
                    break;
                }
                llvm::Value* incomingValue = phiNode->getIncomingValueForBlock(currentBlock);
                Expression incomingExpression = evaluateValue(incomingValue, loopContext, caseState);
                caseState.valueExpr[phiNode] = incomingExpression;
            }
            exploreLoopPaths(loopContext, successorBlock, std::move(caseState), visitedBlocks, rawTransitions);
        }
        SymbolicState defaultState = currentState;
        for (auto switchCase : switchInst->cases()) {
            Expression caseValue = atom(intConstToString(switchCase.getCaseValue()));
            if (!addPathConstraint(defaultState, mkNot(mkBin("=", switchCondition, caseValue)))) {
                return;
            }
        }
        llvm::BasicBlock* defaultSuccessorBlock = switchInst->getDefaultDest();
        if (defaultSuccessorBlock == loopContext.loop->getHeader()) {
            std::vector<std::string> completedPath = defaultState.pathBlocks;
            completedPath.push_back(getBasicBlockName(defaultSuccessorBlock));
            recordRawTransition("loop_back", completedPath, defaultState, loopContext, rawTransitions);
            return;
        }
        // >>> NEXUS CHANGE BEGIN [2.4.4 - enter C child outside LLVM parent]
        if (!loopContext.loop->contains(defaultSuccessorBlock) &&
            !isSourceChildCorridor(loopContext.loop, defaultSuccessorBlock)) {
        // <<< NEXUS CHANGE END [2.4.4 - enter C child outside LLVM parent]
            std::vector<std::string> completedPath = defaultState.pathBlocks;
            completedPath.push_back(getBasicBlockName(defaultSuccessorBlock));
            // >>> NEXUS CHANGE BEGIN [2.4.4 - no invented normal exit]
            if (!isSemanticReturnExitEdge(loopContext.loop, currentBlock, defaultSuccessorBlock) &&
                reachesUnmodeledSourceContinuation(loopContext.loop, defaultSuccessorBlock)) {
                addUnsupported(loopContext, "source-scoped return or continuation is reachable beyond an unmodeled LLVM exit corridor: " + getBasicBlockName(defaultSuccessorBlock));
            }
            // <<< NEXUS CHANGE END [2.4.4 - no invented normal exit]
            const std::string transitionKind = isSemanticReturnExitEdge(loopContext.loop, currentBlock, defaultSuccessorBlock) ? "return" : "exit";
            recordRawTransition(transitionKind, completedPath, defaultState, loopContext, rawTransitions);
            return;
        }
        llvm::Loop* childLoop = nullptr;
        // >>> NEXUS CHANGE BEGIN [2.4.4 - use source children for composed steps]
        for (llvm::Loop* subLoop : getSemanticChildLoops(loopContext.loop)) {
        // <<< NEXUS CHANGE END [2.4.4 - use source children for composed steps]
            if (subLoop->contains(defaultSuccessorBlock)) {
                childLoop = subLoop;
                break;
            }
        }
        if (childLoop) {
            std::map<std::string, Expression> childEntryState;
            for (const auto& variable : loopContext.variables) {
                auto variableValueIt = defaultState.memoryExpr.find(variable.slot);
                childEntryState[variable.name] = (variableValueIt != defaultState.memoryExpr.end()) ? variableValueIt->second : atom(variable.name);
            }
            std::string childLoopId = getLoopId(childLoop);
            recordChildReturnTransitionIfNeeded(childLoop, childLoopId, defaultState, childEntryState, loopContext, rawTransitions);
            std::set<const llvm::Value*> childModifiedSlots;
            for (llvm::BasicBlock* childBlock : childLoop->blocks()) {
                for (llvm::Instruction& instruction : *childBlock) {
                    auto* storeInst = dyn_cast<llvm::StoreInst>(&instruction);
                    if (!storeInst) {
                        continue;
                    }
                    const llvm::Value* storedSlot = storeInst->getPointerOperand()->stripPointerCasts();
                    if (loopContext.variableNames.count(storedSlot)) {
                        childModifiedSlots.insert(storedSlot);
                    }
                }
            }
            std::vector<ChildPlaceholderCase> childExitCases;
            llvm::SmallVector<std::pair<llvm::BasicBlock*, llvm::BasicBlock*>, 8> childExitEdges;
            childLoop->getExitEdges(childExitEdges);
            std::set<std::pair<llvm::BasicBlock*, llvm::BasicBlock*>> seenExitEdges;
            for (const auto& childExitEdge : childExitEdges) {
                llvm::BasicBlock* exitSourceBlock = childExitEdge.first;
                llvm::BasicBlock* exitBlock = childExitEdge.second;
                if (!exitSourceBlock || !exitBlock || !seenExitEdges.insert(childExitEdge).second) {
                    continue;
                }
                if (isSemanticReturnExitEdge(childLoop, exitSourceBlock, exitBlock)) {
                    continue;
                }
                ChildPlaceholderCase childExitCase;
                childExitCase.childId = childLoopId;
                childExitCase.exitSourceBlock = exitSourceBlock;
                childExitCase.exitBlock = exitBlock;
                childExitCase.modifiedSlots = childModifiedSlots;
                childExitCase.entryState = childEntryState;
                childExitCases.push_back(std::move(childExitCase));
            }
            if (childExitCases.empty()) {
                return;
            }
            for (const auto& childExitCase : childExitCases) {
                SymbolicState afterChildState = defaultState;
                if (!childExitCase.exitSourceBlock || !childExitCase.exitBlock) {
                    addUnsupported(loopContext, "child placeholder without complete exit edge: " + childExitCase.childId);
                    continue;
                }
                const std::string childExitBlockName = getBasicBlockName(childExitCase.exitBlock);
                size_t callIndex = appendChildCall(afterChildState, childExitCase.childId, getBasicBlockName(childExitCase.exitSourceBlock), childExitBlockName, false, childExitCase.entryState);
                if (!addPathConstraint(afterChildState, atom(childPcPlaceholder(childExitCase.childId, callIndex)))) {
                    continue;
                }
                for (const auto& variable : loopContext.variables) {
                    if (childExitCase.modifiedSlots.count(variable.slot)) {
                        afterChildState.memoryExpr[variable.slot] = atom(childValuePlaceholder(childExitCase.childId, callIndex, variable.name));
                    }
                }
                afterChildState.pathBlocks.push_back("<child_call:" + childExitCase.childId + ":call" + std::to_string(callIndex) + ">");
                for (llvm::Instruction& instruction : *childExitCase.exitBlock) {
                    auto* phiNode = dyn_cast<llvm::PHINode>(&instruction);
                    if (!phiNode) {
                        break;
                    }
                    afterChildState.valueExpr[phiNode] = atom("<" + childExitCase.childId + ":phi:" + convertLLVMValueToString(phiNode) + ">");
                }
                if (childExitCase.exitBlock == loopContext.loop->getHeader()) {
                    std::vector<std::string> completedPath = afterChildState.pathBlocks;
                    completedPath.push_back(getBasicBlockName(childExitCase.exitBlock));
                    recordRawTransition("loop_back", completedPath, afterChildState, loopContext, rawTransitions);
                    continue;
                }
                if (!loopContext.loop->contains(childExitCase.exitBlock)) {

                    std::vector<std::string> completedPath = afterChildState.pathBlocks;

                    completedPath.push_back(getBasicBlockName(childExitCase.exitBlock));

                    // >>> NEXUS CHANGE BEGIN [2.4.2 - classify child exit relative to parent]

                    // Normal child EXIT can immediately enter a source-level RETURN

                    // belonging to the enclosing loop (but not to the child).

                    const auto sourceReturn = getReturnOnForcedExitPath(childExitCase.exitBlock);

                    const std::string parentTransition =

                        (sourceReturn && returnBelongsToLoop(loopContext.loop, *sourceReturn)) ? "return" : "exit";

                    // >>> NEXUS CHANGE BEGIN [2.4.4 - avoid missing parent continuation]
                        if (parentTransition != "return" &&
                            (!loopContext.loop->contains(childLoop->getHeader()) ||
                             reachesUnmodeledSourceContinuation(loopContext.loop, childExitCase.exitBlock))) {
                            addUnsupported(loopContext, "source-nested child exits outside LLVM parent through an unsummarized continuation: " + childExitBlockName);
                        }
                        // <<< NEXUS CHANGE END [2.4.4 - avoid missing parent continuation]
                        recordRawTransition(parentTransition, completedPath, afterChildState, loopContext, rawTransitions);

                    // <<< NEXUS CHANGE END [2.4.2 - classify child exit relative to parent]

                    continue;

                }
                exploreLoopPaths(loopContext, childExitCase.exitBlock, std::move(afterChildState), visitedBlocks, rawTransitions);
            }
            return;
        }
        for (llvm::Instruction& instruction : *defaultSuccessorBlock) {
            auto* phiNode = dyn_cast<llvm::PHINode>(&instruction);
            if (!phiNode) {
                break;
            }
            llvm::Value* incomingValue = phiNode->getIncomingValueForBlock(currentBlock);
            Expression incomingExpression = evaluateValue(incomingValue, loopContext, defaultState);
            defaultState.valueExpr[phiNode] = incomingExpression;
        }
        exploreLoopPaths(loopContext, defaultSuccessorBlock, std::move(defaultState), visitedBlocks, rawTransitions);
        return;
    }
    addUnsupported(loopContext, "unsupported terminator in loop block: " + getBasicBlockName(currentBlock));
}

// Transition processing.
std::string childVariableNameFromIndex(const std::string& childLoopId, size_t variableIndex) {
    return childLoopId + "_v" + std::to_string(variableIndex + 1);
}

std::vector<Transition> extractTransitions(const std::vector<RawTransition>& rawTransitions, const std::string& parentLoopId, const std::vector<StateVariable>& variables, std::vector<std::string>& unsupportedMessages, const std::string& wantedKind) {
    auto mkRelationCallExpression = [&](const std::string& relationName, const std::vector<Expression>& relationArguments) -> Expression {
        Expression expression;
        expression.isCompound = false;
        expression.isRelationCall = true;
        expression.head = relationName;
        expression.arguments = relationArguments;
        return expression;
    };
    auto sanitizeRelationSuffixPart = [&](const std::string& rawName) -> std::string {
        std::string sanitized;
        std::uint32_t checksum = 0;
        for (unsigned char c : rawName) {
            checksum = checksum * 131u + static_cast<std::uint32_t>(c);
            const bool isAlpha = (c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z');
            const bool isDigit = (c >= '0' && c <= '9');
            if (isAlpha || isDigit || c == '_') {
                sanitized.push_back(static_cast<char>(c));
            }
            else {
                sanitized.push_back('_');
            }
        }
        if (sanitized.empty()) {
            sanitized = "unknown_exit";
        }
        return sanitized + "_" + std::to_string(checksum);
    };
    auto makeEntry2ExitRelationName = [&](const std::string& loopId) -> std::string {
        return makeRelationName(loopId, "entry2exit");
    };
    auto makeExitEdgeId = [&](const std::string& loopId, const std::string& sourceBlockName, const std::string& targetBlockName) -> std::string {
        return loopId + "_x_" + sanitizeRelationSuffixPart(sourceBlockName + "_to_" + targetBlockName);
    };
    auto childInputLocalName = [&](const std::string& parentLoopId, const std::string& childLoopId, size_t callIndex, size_t variableIndex) -> std::string {
        return parentLoopId + "_call" + std::to_string(callIndex) + "_" + childVariableNameFromIndex(childLoopId, variableIndex) + "_in";
    };
    auto childOutputLocalName = [&](const std::string& parentLoopId, const std::string& childLoopId, size_t callIndex, size_t variableIndex) -> std::string {
        (void)parentLoopId;
        (void)callIndex;
        return makeOutputVariableName(childVariableNameFromIndex(childLoopId, variableIndex));
    };
    struct BranchAllocator {
        unsigned nextBranchId = 1;
        std::string getNextBranchId() {
            return "B" + std::to_string(nextBranchId++);
        }
    };
    std::vector<Transition> normalizedTransitions;
    auto expressionContainsText = [&](auto&& containsText, const Expression& expression, const std::string& targetText) -> bool {
        if (expression.head.find(targetText) != std::string::npos) {
            return true;
        }
        for (const auto& argument : expression.arguments) {
            if (containsText(containsText, argument, targetText)) {
                return true;
            }
        }
        return false;
    };
    auto replaceAtomInExpression = [&](auto&& replaceAtomRecursive, const Expression& expression, const std::string& oldAtomName, const std::string& newAtomName) -> Expression {
        if (!expression.isCompound && !expression.isRelationCall && !expression.isExists) {
            if (expression.head == oldAtomName) {
                return atom(newAtomName);
            }
            return expression;
        }
        Expression rewrittenExpression;
        rewrittenExpression.isCompound = expression.isCompound;
        rewrittenExpression.isRelationCall = expression.isRelationCall;
        rewrittenExpression.isExists = expression.isExists;
        rewrittenExpression.boundVariables = expression.boundVariables;
        rewrittenExpression.head = expression.head;
        for (const auto& argument : expression.arguments) {
            rewrittenExpression.arguments.push_back(replaceAtomRecursive(replaceAtomRecursive, argument, oldAtomName, newAtomName));
        }
        return rewrittenExpression;
    };
    for (const auto& rawTransition : rawTransitions) {
        if (rawTransition.kind != wantedKind) {
            continue;
        }
        std::map<std::string, std::string> childPlaceholderToOutputName;
        std::vector<Expression> childSummaryConjuncts;
        std::vector<std::string> childLocalVariables;
        const std::vector<ChildCall> childCalls = rawTransition.childCalls.empty() && rawTransition.hasChildComposition ? std::vector<ChildCall>{{rawTransition.childId, "", rawTransition.childExitBlockName, false, rawTransition.childEntryState}} : rawTransition.childCalls;
        for (size_t childCallIndex = 0; childCallIndex < childCalls.size(); ++childCallIndex) {
            const ChildCall& childCall = childCalls[childCallIndex];
            const size_t callIndex = childCallIndex + 1;
            if (childCall.isReturn) {
                addUnsupported(unsupportedMessages, "internal error: child return call appeared in non-return transition for child loop: " + childCall.childId);
                continue;
            }
            const std::string childExitBlockName = childCall.exitBlockName.empty() ? "unknown_exit" : childCall.exitBlockName;
            std::vector<std::string> childInputNames;
            std::vector<std::string> childOutputNames;
            for (size_t variableIndex = 0; variableIndex < variables.size(); ++variableIndex) {
                const StateVariable& variable = variables[variableIndex];
                const std::string inputName = childInputLocalName(parentLoopId, childCall.childId, callIndex, variableIndex);
                const std::string outputName = childOutputLocalName(parentLoopId, childCall.childId, callIndex, variableIndex);
                childInputNames.push_back(inputName);
                childOutputNames.push_back(outputName);
                childLocalVariables.push_back(inputName);
                childLocalVariables.push_back(outputName);
                auto entryStateIt = childCall.entryState.find(variable.name);
                Expression entryValue = entryStateIt != childCall.entryState.end() ? entryStateIt->second : atom(variable.name);
                childSummaryConjuncts.push_back(mkBin("=", atom(inputName), entryValue));
                childPlaceholderToOutputName[childValuePlaceholder(childCall.childId, callIndex, variable.name)] = outputName;
                if (childCalls.size() == 1) {
                    childPlaceholderToOutputName["<" + childCall.childId + ":" + variable.name + ">"] = outputName;
                }
            }
            std::vector<Expression> entry2ExitArguments;
            for (const auto& inputName : childInputNames) {
                entry2ExitArguments.push_back(atom(inputName));
            }
            entry2ExitArguments.push_back(atom(makeExitEdgeId(childCall.childId, childCall.exitSourceBlockName.empty() ? "unknown_source" : childCall.exitSourceBlockName, childExitBlockName)));
            for (const auto& outputName : childOutputNames) {
                entry2ExitArguments.push_back(atom(outputName));
            }
            childSummaryConjuncts.push_back(mkRelationCallExpression(makeEntry2ExitRelationName(childCall.childId), entry2ExitArguments));
        }
        Transition normalizedTransition;
        normalizedTransition.kind = wantedKind;
        normalizedTransition.basicBlocks = rawTransition.basicBlocks;
        normalizedTransition.extraConjuncts = childSummaryConjuncts;
        normalizedTransition.localVariables = childLocalVariables;
        normalizedTransition.childCalls = childCalls;
        if (!childCalls.empty()) {
            normalizedTransition.hasChildCompositions = true;
            normalizedTransition.childId = childCalls.back().childId;
            normalizedTransition.childExitBlockName = childCalls.back().exitBlockName;
        }
        std::vector<Expression> rewrittenPathLiterals;
        for (const auto& pathLiteral : rawTransition.literals) {
            bool skipLiteral = false;
            for (size_t childCallIndex = 0; childCallIndex < childCalls.size(); ++childCallIndex) {
                const ChildCall& childCall = childCalls[childCallIndex];
                const size_t callIndex = childCallIndex + 1;
                if (exprEq(pathLiteral, atom(childPcPlaceholder(childCall.childId, callIndex))) || exprEq(pathLiteral, atom(childReturnPcPlaceholder(childCall.childId, callIndex))) || (childCalls.size() == 1 && exprEq(pathLiteral, atom("<" + childCall.childId + ":pc>")))) {
                    skipLiteral = true;
                    break;
                }
            }
            if (skipLiteral) {
                continue;
            }
            Expression rewrittenLiteral = pathLiteral;
            for (const auto& replacement : childPlaceholderToOutputName) {
                rewrittenLiteral = replaceAtomInExpression(replaceAtomInExpression, rewrittenLiteral, replacement.first, replacement.second);
            }
            if (expressionContainsText(expressionContainsText, rewrittenLiteral, "<l")) {
                addUnsupported(unsupportedMessages, "child placeholder remained after e2e composition in path literal: " + exprKey(rewrittenLiteral));
            }
            rewrittenPathLiterals.push_back(rewrittenLiteral);
        }
        normalizedTransition.pathCondition = mkAnd(rewrittenPathLiterals);
        for (const auto& update : rawTransition.updates) {
            Expression rewrittenRightHandSide = update.second;
            for (const auto& replacement : childPlaceholderToOutputName) {
                rewrittenRightHandSide = replaceAtomInExpression(replaceAtomInExpression, rewrittenRightHandSide, replacement.first, replacement.second);
            }
            if (expressionContainsText(expressionContainsText, rewrittenRightHandSide, "<l")) {
                addUnsupported(unsupportedMessages, "child placeholder remained after e2e composition in update: " + exprKey(rewrittenRightHandSide));
            }
            normalizedTransition.updates[update.first] = rewrittenRightHandSide;
        }
        normalizedTransitions.push_back(std::move(normalizedTransition));
    }
    std::vector<Transition> mergedTransitions;
    std::map<std::string, size_t> mergeKeyToTransitionIndex;
    BranchAllocator branchAllocator;
    for (const auto& normalizedTransition : normalizedTransitions) {
        std::string mergeKey;
        mergeKey += "|children:";
        for (const auto& childCall : normalizedTransition.childCalls) {
            mergeKey += childCall.childId + "@" + childCall.exitBlockName + ":" + (childCall.isReturn ? "return" : "exit") + ";";
        }
        mergeKey += "|locals:";
        for (const auto& localVariable : normalizedTransition.localVariables) {
            mergeKey += localVariable;
            mergeKey += ";";
        }
        mergeKey += "|extra:";
        for (const auto& extraConjunct : normalizedTransition.extraConjuncts) {
            mergeKey += exprKey(extraConjunct);
            mergeKey += ";";
        }
        mergeKey += "|updates:";
        for (const auto& update : normalizedTransition.updates) {
            mergeKey += update.first;
            mergeKey += "=";
            mergeKey += exprKey(update.second);
            mergeKey += ";";
        }
        auto existingTransitionIt = mergeKeyToTransitionIndex.find(mergeKey);
        if (existingTransitionIt == mergeKeyToTransitionIndex.end()) {
            Transition newTransition = normalizedTransition;
            newTransition.branchId = branchAllocator.getNextBranchId();
            mergeKeyToTransitionIndex[mergeKey] = mergedTransitions.size();
            mergedTransitions.push_back(std::move(newTransition));
        }
        else {
            Transition& existingTransition = mergedTransitions[existingTransitionIt->second];
            existingTransition.pathCondition = mkOr({existingTransition.pathCondition, normalizedTransition.pathCondition});
        }
    }
    return mergedTransitions;
}

Expression replaceAtomNames(const Expression& expression, const std::map<std::string, std::string>& replacements) {
    if (!expression.isCompound && !expression.isRelationCall && !expression.isExists) {
        auto replacementIt = replacements.find(expression.head);
        return replacementIt == replacements.end() ? expression : atom(replacementIt->second);
    }
    Expression rewrittenExpression;
    rewrittenExpression.head = expression.head;
    rewrittenExpression.isCompound = expression.isCompound;
    rewrittenExpression.isRelationCall = expression.isRelationCall;
    rewrittenExpression.isExists = expression.isExists;
    rewrittenExpression.boundVariables = expression.boundVariables;
    rewrittenExpression.arguments.reserve(expression.arguments.size());
    for (const Expression& argument : expression.arguments) {
        rewrittenExpression.arguments.push_back(replaceAtomNames(argument, replacements));
    }
    return rewrittenExpression;
}

std::vector<RawTransition> exploreReadablePrimitivePaths(LoopContext& loopContext) {
    SymbolicState initialLoopState;
    for (const StateVariable& variable : loopContext.variables) {
        initialLoopState.valueExpr[variable.slot] = atom(variable.name);
        initialLoopState.memoryExpr[variable.slot] = atom(variable.name);
    }
    std::vector<RawTransition> rawTransitions;
    exploreLoopPaths(loopContext, loopContext.loop->getHeader(), std::move(initialLoopState), {}, rawTransitions);
    return rawTransitions;
}

// JSON conversion.
nlohmann::ordered_json convertExpressionToJson(const Expression& E) {
    if (E.isRelationCall) {
        nlohmann::ordered_json relationCallJson;
        relationCallJson["rel"] = E.head;
        relationCallJson["args"] = nlohmann::ordered_json::array();
        for (const auto& argument : E.arguments) {
            relationCallJson["args"].push_back(convertExpressionToJson(argument));
        }
        return relationCallJson;
    }
    if (E.isExists) {
        nlohmann::ordered_json existsExpressionJson;
        existsExpressionJson["exists"] = E.boundVariables;
        existsExpressionJson["body"] = E.arguments.empty() ? nlohmann::ordered_json(true) : convertExpressionToJson(E.arguments.front());
        return existsExpressionJson;
    }
    if (!E.isCompound) {
        if (E.head == "true") {
            return true;
        }
        if (E.head == "false") {
            return false;
        }
        if (!E.head.empty()) {
            errno = 0;
            char* parseEnd = nullptr;
            long long parsedValue = std::strtoll(E.head.c_str(), &parseEnd, 10);
            if (parseEnd == E.head.c_str() + E.head.size() && errno != ERANGE) {
                std::int64_t integerValue = static_cast<std::int64_t>(parsedValue);
                return integerValue;
            }
        }
        return E.head;
    }
    nlohmann::ordered_json compoundExpressionJson;
    compoundExpressionJson["op"] = E.head;
    compoundExpressionJson["args"] = nlohmann::ordered_json::array();
    for (const auto& argument : E.arguments) {
        compoundExpressionJson["args"].push_back(convertExpressionToJson(argument));
    }
    return compoundExpressionJson;
}

// Append only semantically unique paths.
void appendUniquePath(nlohmann::ordered_json& pathsJson, const nlohmann::ordered_json& semanticPathJson, const std::string& identityField, const std::string& identityPrefix, std::set<std::string>& seenSemanticPathKeys) {
    const std::string semanticKey = semanticPathJson.dump();
    if (!seenSemanticPathKeys.insert(semanticKey).second) {
        return;
    }
    nlohmann::ordered_json pathJson;
    pathJson[identityField] = identityPrefix + "_p" + std::to_string(pathsJson.size() + 1);
    for (auto itemIt = semanticPathJson.begin(); itemIt != semanticPathJson.end(); ++itemIt) {
        pathJson[itemIt.key()] = itemIt.value();
    }
    pathsJson.push_back(std::move(pathJson));
}

// Guard analysis.
nlohmann::ordered_json generateLoopGuard(LoopContext& loopContext) {
    auto getGuardedSuccessors = [&](llvm::BasicBlock* block, LoopContext& loopContext, SymbolicState& stateAfterBlock) -> std::vector<std::pair<llvm::BasicBlock*, Expression>> {
        std::vector<std::pair<llvm::BasicBlock*, Expression>> result;
        llvm::Instruction* terminator = block ? block->getTerminator() : nullptr;
        if (!terminator) {
            addUnsupported(loopContext, "block without terminator while building CFG relation: " + getBasicBlockName(block));
            return result;
        }
        if (auto* branchInstruction = dyn_cast<llvm::BranchInst>(terminator)) {
            if (!branchInstruction->isConditional()) {
                result.push_back({branchInstruction->getSuccessor(0), atom("true")});
                return result;
            }
            Expression branchCondition = evaluateValue(branchInstruction->getCondition(), loopContext, stateAfterBlock);
            result.push_back({branchInstruction->getSuccessor(0), branchCondition});
            result.push_back({branchInstruction->getSuccessor(1), mkNot(branchCondition)});
            return result;
        }
        if (auto* switchInstruction = dyn_cast<llvm::SwitchInst>(terminator)) {
            Expression switchCondition = evaluateValue(switchInstruction->getCondition(), loopContext, stateAfterBlock);
            for (auto switchCase : switchInstruction->cases()) {
                Expression caseValue = atom(intConstToString(switchCase.getCaseValue()));
                result.push_back({switchCase.getCaseSuccessor(), mkBin("=", switchCondition, caseValue)});
            }
            std::vector<Expression> defaultConjuncts;
            for (auto switchCase : switchInstruction->cases()) {
                Expression caseValue = atom(intConstToString(switchCase.getCaseValue()));
                defaultConjuncts.push_back(mkNot(mkBin("=", switchCondition, caseValue)));
            }
            result.push_back({switchInstruction->getDefaultDest(), mkAnd(defaultConjuncts)});
            return result;
        }
        if (isa<llvm::ReturnInst>(terminator) || isa<llvm::UnreachableInst>(terminator)) {
            return result;
        }
        addUnsupported(loopContext, "unsupported terminator while building CFG relation: " + getBasicBlockName(block));
        return result;
    };
    auto isInsideDirectChildLoop = [&](const llvm::Loop* parentLoop, const llvm::BasicBlock* block) -> bool {
        if (!parentLoop || !block) {
            return false;
        }
        for (llvm::Loop* childLoop : parentLoop->getSubLoops()) {
            if (childLoop && childLoop->contains(block)) {
                return true;
            }
        }
        return false;
    };
    auto collectLoopCFGBlocks = [&](llvm::Loop* loop) -> std::vector<llvm::BasicBlock*> {
        std::vector<llvm::BasicBlock*> blocks;
        std::set<llvm::BasicBlock*> seen;
        for (llvm::BasicBlock* block : loop->blocks()) {
            if (!block) {
                continue;
            }
            if (isInsideDirectChildLoop(loop, block)) {
                continue;
            }
            if (seen.insert(block).second) {
                blocks.push_back(block);
            }
        }
        return blocks;
    };
    auto loopBlockHasInsideAndOutsideSuccessors = [&](llvm::Loop* loop, llvm::BasicBlock* block) -> bool {
        if (!loop || !block) {
            return false;
        }
        bool hasInsideSuccessor = false;
        bool hasOutsideSuccessor = false;
        llvm::Instruction* terminator = block->getTerminator();
        if (!terminator) {
            return false;
        }
        for (unsigned successorIndex = 0; successorIndex < terminator->getNumSuccessors(); ++successorIndex) {
            llvm::BasicBlock* successorBlock = terminator->getSuccessor(successorIndex);
            if (!successorBlock) {
                continue;
            }
            if (loop->contains(successorBlock)) {
                hasInsideSuccessor = true;
            }
            else {
                hasOutsideSuccessor = true;
            }
        }
        return hasInsideSuccessor && hasOutsideSuccessor;
    };
    auto blockDominatesAllLoopLatches = [&](LoopContext& loopContext, llvm::BasicBlock* block) -> bool {
        if (!loopContext.loop || !block) {
            return false;
        }
        llvm::SmallVector<llvm::BasicBlock*, 8> latchBlocks;
        loopContext.loop->getLoopLatches(latchBlocks);
        if (latchBlocks.empty()) {
            return false;
        }
        if (!loopContext.dominatorTree) {
            return true;
        }
        for (llvm::BasicBlock* latchBlock : latchBlocks) {
            if (!latchBlock) {
                continue;
            }
            if (!loopContext.dominatorTree->dominates(block, latchBlock)) {
                return false;
            }
        }
        return true;
    };
    auto isLoopGuardDecisionBlock = [&](LoopContext& loopContext, llvm::BasicBlock* block) -> bool {
        if (!loopContext.loop || !block) {
            return false;
        }
        return loopBlockHasInsideAndOutsideSuccessors(loopContext.loop, block) && blockDominatesAllLoopLatches(loopContext, block);
    };
    auto blockHasBackedgeToLoopHeader = [&](LoopContext& loopContext, llvm::BasicBlock* block) -> bool {
        if (!loopContext.loop || !loopContext.loop->getHeader() || !block) {
            return false;
        }
        llvm::Instruction* terminator = block->getTerminator();
        if (!terminator) {
            return false;
        }
        for (llvm::BasicBlock* successorBlock : getSuccessorsOfTerminator(terminator)) {
            if (successorBlock == loopContext.loop->getHeader()) {
                return true;
            }
        }
        return false;
    };

    auto collectLoopGuardRegionBlocks = [&](LoopContext& loopContext) -> std::set<llvm::BasicBlock*> {
        std::set<llvm::BasicBlock*> guardRegion;
        if (!loopContext.loop || !loopContext.loop->getHeader()) {
            return guardRegion;
        }
        std::vector<llvm::BasicBlock*> loopBlocks = collectLoopCFGBlocks(loopContext.loop);
        std::set<llvm::BasicBlock*> loopBlockSet(loopBlocks.begin(), loopBlocks.end());
        std::map<llvm::BasicBlock*, std::vector<llvm::BasicBlock*>> predecessors;
        for (llvm::BasicBlock* block : loopBlocks) {
            llvm::Instruction* terminator = block ? block->getTerminator() : nullptr;
            for (llvm::BasicBlock* successorBlock : getSuccessorsOfTerminator(terminator)) {
                if (successorBlock && loopBlockSet.count(successorBlock)) {
                    predecessors[successorBlock].push_back(block);
                }
            }
        }
        auto distanceFromHeader = [&](llvm::BasicBlock* targetBlock) -> int {
            if (!targetBlock || !loopContext.loop || !loopContext.loop->getHeader()) {
                return -1;
            }
            std::queue<std::pair<llvm::BasicBlock*, int>> distanceWorklist;
            std::set<llvm::BasicBlock*> seen;
            distanceWorklist.push({loopContext.loop->getHeader(), 0});
            seen.insert(loopContext.loop->getHeader());
            while (!distanceWorklist.empty()) {
                auto [block, distance] = distanceWorklist.front();
                distanceWorklist.pop();
                if (block == targetBlock) {
                    return distance;
                }
                llvm::Instruction* terminator = block ? block->getTerminator() : nullptr;
                for (llvm::BasicBlock* successorBlock : getSuccessorsOfTerminator(terminator)) {
                    if (!successorBlock || !loopBlockSet.count(successorBlock)) {
                        continue;
                    }
                    if (blockHasBackedgeToLoopHeader(loopContext, successorBlock)) {
                        continue;
                    }
                    if (seen.insert(successorBlock).second) {
                        distanceWorklist.push({successorBlock, distance + 1});
                    }
                }
            }
            return -1;
        };
        std::vector<std::pair<int, llvm::BasicBlock*>> guardDecisionCandidates;
        for (llvm::BasicBlock* block : loopBlocks) {
            if (!isLoopGuardDecisionBlock(loopContext, block)) {
                continue;
            }
            int distance = distanceFromHeader(block);
            if (distance >= 0) {
                guardDecisionCandidates.push_back({distance, block});
            }
        }
        std::queue<llvm::BasicBlock*> worklist;
        if (!guardDecisionCandidates.empty()) {
            std::sort(guardDecisionCandidates.begin(), guardDecisionCandidates.end(), [](const auto& left, const auto& right) {
                return left.first < right.first;
            });
            const int nearestGuardDistance = guardDecisionCandidates.front().first;
            for (const auto& [distance, block] : guardDecisionCandidates) {
                if (distance != nearestGuardDistance) {
                    break;
                }
                if (guardRegion.insert(block).second) {
                    worklist.push(block);
                }
            }
        }
        if (guardRegion.empty()) {
            guardRegion.insert(loopContext.loop->getHeader());
            return guardRegion;
        }
        while (!worklist.empty()) {
            llvm::BasicBlock* block = worklist.front();
            worklist.pop();
            auto predecessorIt = predecessors.find(block);
            if (predecessorIt == predecessors.end()) {
                continue;
            }
            for (llvm::BasicBlock* predecessorBlock : predecessorIt->second) {
                if (!predecessorBlock) {
                    continue;
                }
                if (predecessorBlock == loopContext.loop->getHeader()) {
                    if (guardRegion.insert(predecessorBlock).second) {
                        worklist.push(predecessorBlock);
                    }
                    continue;
                }
                if (blockHasBackedgeToLoopHeader(loopContext, predecessorBlock)) {
                    continue;
                }
                if (loopContext.dominatorTree && !loopContext.dominatorTree->dominates(loopContext.loop->getHeader(), predecessorBlock)) {
                    continue;
                }
                if (guardRegion.insert(predecessorBlock).second) {
                    worklist.push(predecessorBlock);
                }
            }
        }
        guardRegion.insert(loopContext.loop->getHeader());
        return guardRegion;
    };
    std::function<void(LoopContext&, const std::set<llvm::BasicBlock*>&, llvm::BasicBlock*, SymbolicState, std::set<const llvm::BasicBlock*>, std::vector<Expression>&)> collectGuardDisjunctsFromHeaderToBody;
    collectGuardDisjunctsFromHeaderToBody = [&](LoopContext& loopContext, const std::set<llvm::BasicBlock*>& guardRegion, llvm::BasicBlock* currentBlock, SymbolicState currentState, std::set<const llvm::BasicBlock*> visitedBlocks, std::vector<Expression>& guardDisjuncts) -> void {
        if (!currentBlock || !loopContext.loop) {
            return;
        }
        // >>> NEXUS CHANGE BEGIN [2.1 - guard-region traversal completeness]
        if (visitedBlocks.count(currentBlock)) {
            addUnsupported(loopContext, "cycle inside loop-guard region before a body transition: " + getBasicBlockName(currentBlock));
            return;
        }
        // <<< NEXUS CHANGE END [2.1 - guard-region traversal completeness]
        visitedBlocks.insert(currentBlock);
        executeBlock(currentBlock, loopContext, currentState);
        for (const auto& [successorBlock, edgeCondition] : getGuardedSuccessors(currentBlock, loopContext, currentState)) {
            if (!successorBlock) {
                continue;
            }
            SymbolicState successorState = currentState;
            if (!addPathConstraint(successorState, edgeCondition)) {
                continue;
            }
            if (!loopContext.loop->contains(successorBlock)) {
                continue;
            }
            // >>> NEXUS CHANGE BEGIN [2.1 - unconditional header self-backedges]
            if (successorBlock == loopContext.loop->getHeader()) {
                // The header-to-header edge itself performs an iteration.
                // Discarding it makes `while(1){}` incorrectly have guard false.
                guardDisjuncts.push_back(mkAnd(successorState.pathConditions));
                continue;
            }
            // <<< NEXUS CHANGE END [2.1 - unconditional header self-backedges]
            bindPhiNodesForEntryEdge(loopContext, currentBlock, successorBlock, successorState);
            if (isInsideDirectChildLoop(loopContext.loop, successorBlock)) {
                guardDisjuncts.push_back(mkAnd(successorState.pathConditions));
                continue;
            }
            if (guardRegion.count(successorBlock)) {
                collectGuardDisjunctsFromHeaderToBody(loopContext, guardRegion, successorBlock, std::move(successorState), visitedBlocks, guardDisjuncts);
                continue;
            }
            guardDisjuncts.push_back(mkAnd(successorState.pathConditions));
        }
    };
    auto extractExactLoopHeaderGuard = [&](LoopContext& loopContext) -> Expression {
        if (!loopContext.loop || !loopContext.loop->getHeader()) {
            return atom("false");
        }
        std::vector<std::string> currentArgs = getCurrentVariableNames(loopContext.variables);
        SymbolicState headerState = createStateFromVariableNames(loopContext.variables, currentArgs);
        std::vector<Expression> guardDisjuncts;
        std::set<const llvm::BasicBlock*> visitedBlocks;
        std::set<llvm::BasicBlock*> guardRegion = collectLoopGuardRegionBlocks(loopContext);
        collectGuardDisjunctsFromHeaderToBody(loopContext, guardRegion, loopContext.loop->getHeader(), std::move(headerState), visitedBlocks, guardDisjuncts);
        // >>> NEXUS CHANGE BEGIN [2.1 - empty guard is a valid false formula]
        // Empty disjunction = false.  Exploration failures are explicitly
        // reported by the traversal; absence of a feasible body edge is not
        // itself an unsupported extraction (e.g. `while (0)`).
        return mkOr(guardDisjuncts);
        // <<< NEXUS CHANGE END [2.1 - empty guard is a valid false formula]
    };
    const std::string loopId = getLoopId(loopContext.loop);
    nlohmann::ordered_json guardJson;
    guardJson["id"] = makeRelationName(loopId, "guard");
    guardJson["formula"] = convertExpressionToJson(extractExactLoopHeaderGuard(loopContext));
    return guardJson;
}

// Entry-state analysis.
nlohmann::ordered_json generateEntryStates(LoopContext& loopContext, const std::vector<llvm::Loop*>& allLoops) {
    struct ReadableEntrySourceCall {
        std::string purpose;
        std::string loopId;
        std::string relation;
        std::vector<std::string> sourceState;
    };
    struct ReadableEntryPath {
        Expression condition;
        std::vector<ReadableEntrySourceCall> sourceCalls;
        std::map<std::string, Expression> updates;
    };
    auto blockIsInsideDisallowedEntryLoop = [&](LoopContext& loopContext, const std::vector<llvm::Loop*>& allLoops, llvm::BasicBlock* block) -> bool {
        if (!loopContext.loop || !block) {
            return false;
        }
        for (llvm::Loop* otherLoop : allLoops) {
            if (!otherLoop || otherLoop == loopContext.loop) {
                continue;
            }
            if (isAncestorLoopOf(otherLoop, loopContext.loop)) {
                continue;
            }
            if (otherLoop->contains(block)) {
                return true;
            }
        }
        return false;
    };
    auto isAllowedEntryCFGBlock = [&](LoopContext& loopContext, llvm::Loop* parentLoop, const std::vector<llvm::Loop*>& allLoops, llvm::BasicBlock* block) -> bool {
        if (!block || !loopContext.loop) {
            return false;
        }
        llvm::BasicBlock* targetHeader = loopContext.loop->getHeader();
        if (parentLoop) {
            // >>> NEXUS CHANGE BEGIN [2.4.4 - lexical child entry beyond LLVM loop region]
            if (!parentLoop->contains(block) && block != targetHeader &&
                !isSourceChildCorridor(parentLoop, block)) {
                return false;
            }
            // <<< NEXUS CHANGE END [2.4.4 - lexical child entry beyond LLVM loop region]
            if (loopContext.loop->contains(block) && block != targetHeader) {
                return false;
            }
        }
        else if (block->getParent() != loopContext.function) {
            return false;
        }
        else if (loopContext.loop->contains(block) && block != targetHeader) {
            return false;
        }

        if (blockIsInsideDisallowedEntryLoop(loopContext, allLoops, block)) {
            return false;
        }
        return true;
    };
    auto isAllowedEntryCFGEdge = [&](LoopContext& loopContext, llvm::Loop* parentLoop, const std::vector<llvm::Loop*>& allLoops, llvm::BasicBlock* sourceBlock, llvm::BasicBlock* successorBlock) -> bool {
        if (!sourceBlock || !successorBlock) {
            return false;
        }
        if (!isAllowedEntryCFGBlock(loopContext, parentLoop, allLoops, successorBlock)) {
            return false;
        }
        if (parentLoop && successorBlock == parentLoop->getHeader() && sourceBlock != parentLoop->getHeader()) {
            return false;
        }
        return true;
    };
    auto createFunctionEntryState = [&](LoopContext& loopContext) -> SymbolicState {
        SymbolicState stateAtFunctionEntry;
        for (const auto& trackedVariable : loopContext.variables) {
            stateAtFunctionEntry.valueExpr[trackedVariable.slot] = atom(trackedVariable.name);
            if (const auto* globalVariable = dyn_cast<llvm::GlobalVariable>(trackedVariable.slot)) {
                if (globalVariable->hasInitializer()) {
                    if (const auto* constantInteger = dyn_cast<llvm::ConstantInt>(globalVariable->getInitializer())) {
                        stateAtFunctionEntry.memoryExpr[trackedVariable.slot] = atom(intConstToString(constantInteger));
                    }
                    else {
                        addUnsupported(loopContext, "unsupported global initializer: " + convertLLVMValueToString(globalVariable));
                        stateAtFunctionEntry.memoryExpr[trackedVariable.slot] = atom(trackedVariable.name);
                    }
                }
                else {
                    addUnsupported(loopContext, "unsupported global initializer: " + convertLLVMValueToString(globalVariable));
                    stateAtFunctionEntry.memoryExpr[trackedVariable.slot] = atom(trackedVariable.name);
                }
            }
            else {
                stateAtFunctionEntry.memoryExpr[trackedVariable.slot] = atom(trackedVariable.name);
            }
        }
        return stateAtFunctionEntry;
    };
    auto getUniqueExitEdges = [&](llvm::Loop* loop) -> std::vector<std::pair<llvm::BasicBlock*, llvm::BasicBlock*>> {
        std::vector<std::pair<llvm::BasicBlock*, llvm::BasicBlock*>> exits;
        if (!loop) {
            return exits;
        }
        llvm::SmallVector<std::pair<llvm::BasicBlock*, llvm::BasicBlock*>, 16> rawExits;
        loop->getExitEdges(rawExits);
        std::set<std::pair<llvm::BasicBlock*, llvm::BasicBlock*>> seen;
        for (const auto& exitEdge : rawExits) {
            if (exitEdge.first && exitEdge.second && seen.insert(exitEdge).second) {
                exits.push_back(exitEdge);
            }
        }
        return exits;
    };
    auto collectEntryCFGSources = [&](LoopContext& loopContext, llvm::Loop* parentLoop, const std::vector<llvm::Loop*>& previousLoops, const std::set<llvm::BasicBlock*>& candidateSet) -> std::vector<llvm::BasicBlock*> {
        std::vector<llvm::BasicBlock*> sources;
        std::set<llvm::BasicBlock*> seen;
        auto addSource = [&](llvm::BasicBlock* sourceBlock) {
            if (sourceBlock && candidateSet.count(sourceBlock) && seen.insert(sourceBlock).second) {
                sources.push_back(sourceBlock);
            }
        };
        if (parentLoop) {
            addSource(parentLoop->getHeader());
        }
        else if (loopContext.function) {
            addSource(&loopContext.function->getEntryBlock());
        }
        for (llvm::Loop* previousLoop : previousLoops) {
            for (llvm::BasicBlock* exitBlock : getUniqueExitBlocks(previousLoop)) {
                addSource(exitBlock);
            }
        }
        return sources;
    };
    auto collectEntryCFGBlocks = [&](LoopContext& loopContext, llvm::Loop* parentLoop, const std::vector<llvm::Loop*>& allLoops, const std::vector<llvm::Loop*>& previousLoops) -> std::vector<llvm::BasicBlock*> {
        std::vector<llvm::BasicBlock*> candidates;
        std::set<llvm::BasicBlock*> seenCandidates;
        auto addCandidateIfAllowed = [&](llvm::BasicBlock* block) {
            if (isAllowedEntryCFGBlock(loopContext, parentLoop, allLoops, block) && seenCandidates.insert(block).second) {
                candidates.push_back(block);
            }
        };
        // >>> NEXUS CHANGE BEGIN [2.4.4 - include lexical entry corridors]
        // The source parent may not contain its child in LLVM LoopInfo.
        // Include only structurally admissible corridor blocks plus the child
        // header; the filter below still forbids another loop's body.
        for (llvm::BasicBlock& block : *loopContext.function) {
            addCandidateIfAllowed(&block);
        }
        // <<< NEXUS CHANGE END [2.4.4 - include lexical entry corridors]
        llvm::BasicBlock* targetHeader = loopContext.loop ? loopContext.loop->getHeader() : nullptr;
        if (!targetHeader || !seenCandidates.count(targetHeader)) {
            return {};
        }
        std::set<llvm::BasicBlock*> candidateSet(candidates.begin(), candidates.end());
        std::map<llvm::BasicBlock*, std::vector<llvm::BasicBlock*>> predecessors;
        for (llvm::BasicBlock* block : candidates) {
            llvm::Instruction* terminator = block ? block->getTerminator() : nullptr;
            for (llvm::BasicBlock* successorBlock : getSuccessorsOfTerminator(terminator)) {
                if (!candidateSet.count(successorBlock)) {
                    continue;
                }
                if (!isAllowedEntryCFGEdge(loopContext, parentLoop, allLoops, block, successorBlock)) {
                    continue;
                }
                predecessors[successorBlock].push_back(block);
            }
        }
        std::set<llvm::BasicBlock*> forwardReachable;
        std::queue<llvm::BasicBlock*> worklist;
        for (llvm::BasicBlock* sourceBlock : collectEntryCFGSources(loopContext, parentLoop, previousLoops, candidateSet)) {
            if (forwardReachable.insert(sourceBlock).second) {
                worklist.push(sourceBlock);
            }
        }
        while (!worklist.empty()) {
            llvm::BasicBlock* block = worklist.front();
            worklist.pop();
            llvm::Instruction* terminator = block ? block->getTerminator() : nullptr;
            for (llvm::BasicBlock* successorBlock : getSuccessorsOfTerminator(terminator)) {
                if (!candidateSet.count(successorBlock)) {
                    continue;
                }
                if (!isAllowedEntryCFGEdge(loopContext, parentLoop, allLoops, block, successorBlock)) {
                    continue;
                }
                if (forwardReachable.insert(successorBlock).second) {
                    worklist.push(successorBlock);
                }
            }
        }
        std::set<llvm::BasicBlock*> canReachTarget;
        if (candidateSet.count(targetHeader)) {
            canReachTarget.insert(targetHeader);
            worklist.push(targetHeader);
        }
        while (!worklist.empty()) {
            llvm::BasicBlock* block = worklist.front();
            worklist.pop();
            auto predecessorIt = predecessors.find(block);
            if (predecessorIt == predecessors.end()) {
                continue;
            }
            for (llvm::BasicBlock* predecessorBlock : predecessorIt->second) {
                if (canReachTarget.insert(predecessorBlock).second) {
                    worklist.push(predecessorBlock);
                }
            }
        }
        std::vector<llvm::BasicBlock*> result;
        for (llvm::BasicBlock* block : candidates) {
            if (forwardReachable.count(block) && canReachTarget.count(block)) {
                result.push_back(block);
            }
        }
        return result;
    };
    auto recordReadableEntryPath = [&](LoopContext& loopContext, const SymbolicState& stateAtHeader, const std::vector<ReadableEntrySourceCall>& sourceCalls, std::vector<ReadableEntryPath>& entryPaths) -> void {
        ReadableEntryPath entryPath;
        entryPath.condition = mkAnd(stateAtHeader.pathConditions);
        entryPath.sourceCalls = sourceCalls;
        for (const StateVariable& variable : loopContext.variables) {
            auto valueIt = stateAtHeader.memoryExpr.find(variable.slot);
            Expression value = valueIt == stateAtHeader.memoryExpr.end() ? atom(variable.name) : valueIt->second;
            entryPath.updates[variable.name] = value;
        }
        entryPaths.push_back(std::move(entryPath));
    };
    std::function<void(LoopContext&, llvm::Loop*, const std::vector<llvm::Loop*>&, const std::set<llvm::BasicBlock*>&, llvm::BasicBlock*, SymbolicState, std::set<const llvm::BasicBlock*>, const std::vector<ReadableEntrySourceCall>&, std::vector<ReadableEntryPath>&)> exploreReadableEntryPaths;
    exploreReadableEntryPaths = [&](LoopContext& loopContext, llvm::Loop* parentLoop, const std::vector<llvm::Loop*>& allLoops, const std::set<llvm::BasicBlock*>& allowedBlocks, llvm::BasicBlock* currentBlock, SymbolicState currentState, std::set<const llvm::BasicBlock*> visitedBlocks, const std::vector<ReadableEntrySourceCall>& sourceCalls, std::vector<ReadableEntryPath>& entryPaths) -> void {
        llvm::BasicBlock* targetHeader = loopContext.loop ? loopContext.loop->getHeader() : nullptr;
        if (!currentBlock || !targetHeader) {
            addUnsupported(loopContext, "null block while generating readable entry paths");
            return;
        }
        if (currentBlock == targetHeader) {
            recordReadableEntryPath(loopContext, currentState, sourceCalls, entryPaths);
            return;
        }
        if (!allowedBlocks.count(currentBlock)) {
            return;
        }
        if (visitedBlocks.count(currentBlock)) {
            addUnsupported(loopContext, "cycle before loop header while generating readable entry paths: " + getBasicBlockName(currentBlock));
            return;
        }
        visitedBlocks.insert(currentBlock);
        executeBlock(currentBlock, loopContext, currentState);
        llvm::Instruction* terminator = currentBlock->getTerminator();
        if (!terminator) {
            addUnsupported(loopContext, "block without terminator while generating readable entry paths: " + getBasicBlockName(currentBlock));
            return;
        }
        if (isa<llvm::ReturnInst>(terminator) || isa<llvm::UnreachableInst>(terminator)) {
            return;
        }
        if (auto* branchInstruction = dyn_cast<llvm::BranchInst>(terminator)) {
            Expression branchCondition;
            const unsigned successorCount = branchInstruction->isConditional() ? 2 : 1;
            if (branchInstruction->isConditional()) {
                branchCondition = evaluateValue(branchInstruction->getCondition(), loopContext, currentState);
            }
            for (unsigned successorIndex = 0; successorIndex < successorCount; ++successorIndex) {
                llvm::BasicBlock* successorBlock = branchInstruction->getSuccessor(successorIndex);
                if (!isAllowedEntryCFGEdge(loopContext, parentLoop, allLoops, currentBlock, successorBlock) || !allowedBlocks.count(successorBlock)) {
                    continue;
                }
                SymbolicState successorState = currentState;
                Expression edgeCondition = !branchInstruction->isConditional() ? atom("true") : (successorIndex == 0 ? branchCondition : mkNot(branchCondition));
                if (!addPathConstraint(successorState, edgeCondition)) {
                    continue;
                }
                bindPhiNodesForEntryEdge(loopContext, currentBlock, successorBlock, successorState);
                exploreReadableEntryPaths(loopContext, parentLoop, allLoops, allowedBlocks, successorBlock, std::move(successorState), visitedBlocks, sourceCalls, entryPaths);
            }
            return;
        }
        if (auto* switchInstruction = dyn_cast<llvm::SwitchInst>(terminator)) {
            Expression switchCondition = evaluateValue(switchInstruction->getCondition(), loopContext, currentState);
            for (auto switchCase : switchInstruction->cases()) {
                llvm::BasicBlock* successorBlock = switchCase.getCaseSuccessor();
                if (!isAllowedEntryCFGEdge(loopContext, parentLoop, allLoops, currentBlock, successorBlock) || !allowedBlocks.count(successorBlock)) {
                    continue;
                }
                SymbolicState caseState = currentState;
                Expression caseValue = atom(intConstToString(switchCase.getCaseValue()));
                if (!addPathConstraint(caseState, mkBin("=", switchCondition, caseValue))) {
                    continue;
                }
                bindPhiNodesForEntryEdge(loopContext, currentBlock, successorBlock, caseState);
                exploreReadableEntryPaths(loopContext, parentLoop, allLoops, allowedBlocks, successorBlock, std::move(caseState), visitedBlocks, sourceCalls, entryPaths);
            }
            llvm::BasicBlock* defaultSuccessor = switchInstruction->getDefaultDest();
            if (isAllowedEntryCFGEdge(loopContext, parentLoop, allLoops, currentBlock, defaultSuccessor) && allowedBlocks.count(defaultSuccessor)) {
                SymbolicState defaultState = currentState;
                bool feasible = true;
                for (auto switchCase : switchInstruction->cases()) {
                    Expression caseValue = atom(intConstToString(switchCase.getCaseValue()));
                    if (!addPathConstraint(defaultState, mkNot(mkBin("=", switchCondition, caseValue)))) {
                        feasible = false;
                        break;
                    }
                }
                if (feasible) {
                    bindPhiNodesForEntryEdge(loopContext, currentBlock, defaultSuccessor, defaultState);
                    exploreReadableEntryPaths(loopContext, parentLoop, allLoops, allowedBlocks, defaultSuccessor, std::move(defaultState), visitedBlocks, sourceCalls, entryPaths);
                }
            }
            return;
        }
        addUnsupported(loopContext, "unsupported terminator before loop header while generating readable entry paths: " + getBasicBlockName(currentBlock));
    };
    auto readableEntrySourceCallJson = [&](const ReadableEntrySourceCall& sourceCall) -> nlohmann::ordered_json {
        nlohmann::ordered_json sourceCallJson;
        sourceCallJson["purpose"] = sourceCall.purpose;
        sourceCallJson["relation"] = sourceCall.relation;
        sourceCallJson["source_state"] = sourceCall.sourceState;
        return sourceCallJson;
    };
    const std::string loopId = getLoopId(loopContext.loop);
    // >>> NEXUS CHANGE BEGIN [2.4.4 - entry constraints from lexical parent]
    llvm::Loop* parentLoop = loopContext.loop ? const_cast<llvm::Loop*>(getSemanticParentLoop(loopContext.loop)) : nullptr;
    // <<< NEXUS CHANGE END [2.4.4 - entry constraints from lexical parent]
    const std::vector<llvm::Loop*> previousLoops = getPreviousSequentialLoops(loopContext.loop, allLoops);
    const std::vector<llvm::BasicBlock*> blocks = collectEntryCFGBlocks(loopContext, parentLoop, allLoops, previousLoops);
    const std::set<llvm::BasicBlock*> allowedBlocks(blocks.begin(), blocks.end());
    std::vector<ReadableEntryPath> entryPaths;
    if (parentLoop && allowedBlocks.count(parentLoop->getHeader())) {
        const std::string parentLoopId = getLoopId(parentLoop);
        const std::vector<StateVariable> parentVariables = extractVariables(parentLoop, parentLoopId);
        const std::vector<std::string> parentCurrentNames = getCurrentVariableNames(parentVariables);
        ReadableEntrySourceCall parentReachCall;
        parentReachCall.purpose = "parent_loop_reachability";
        parentReachCall.loopId = parentLoopId;
        parentReachCall.relation = makeRelationName(parentLoopId, "reachable_header_states");
        parentReachCall.sourceState = parentCurrentNames;
        SymbolicState parentHeaderState = createStateFromVariableNames(loopContext.variables, parentCurrentNames);
        exploreReadableEntryPaths(loopContext, parentLoop, allLoops, allowedBlocks, parentLoop->getHeader(), std::move(parentHeaderState), {}, {parentReachCall}, entryPaths);
    }
    else if (!parentLoop && loopContext.function) {
        llvm::BasicBlock* functionEntry = &loopContext.function->getEntryBlock();
        if (allowedBlocks.count(functionEntry)) {
            SymbolicState functionEntryState = createFunctionEntryState(loopContext);
            exploreReadableEntryPaths(loopContext, parentLoop, allLoops, allowedBlocks, functionEntry, std::move(functionEntryState), {}, {}, entryPaths);
        }
    }
    for (llvm::Loop* previousLoop : previousLoops) {
        const std::string previousLoopId = getLoopId(previousLoop);
        const std::vector<StateVariable> previousVariables = extractVariables(previousLoop, previousLoopId);
        const std::vector<std::string> previousOutNames = getOutputVariableNames(previousVariables);
        for (const auto& exitEdge : getUniqueExitEdges(previousLoop)) {
            llvm::BasicBlock* exitSourceBlock = exitEdge.first;
            llvm::BasicBlock* exitTargetBlock = exitEdge.second;
            if (!exitSourceBlock || !exitTargetBlock || !allowedBlocks.count(exitTargetBlock)) {
                continue;
            }
            if (isSemanticReturnExitEdge(previousLoop, exitSourceBlock, exitTargetBlock)) {
                continue;
            }
            ReadableEntrySourceCall previousExitCall;
            previousExitCall.purpose = "sequential_predecessor_exit";
            previousExitCall.loopId = previousLoopId;
            previousExitCall.relation = makeRelationName(previousLoopId, "actual_exit");
            previousExitCall.sourceState = previousOutNames;
            SymbolicState previousExitState = createStateFromVariableNames(loopContext.variables, previousOutNames);
            bindPhiNodesForEntryEdge(loopContext, exitSourceBlock, exitTargetBlock, previousExitState);
            exploreReadableEntryPaths(loopContext, parentLoop, allLoops, allowedBlocks, exitTargetBlock, std::move(previousExitState), {}, {previousExitCall}, entryPaths);
        }
    }
    // >>> NEXUS CHANGE BEGIN [2.2 - empty entry is false, not automatically unsupported]
    // No enumerated path may represent a genuinely unreachable loop header.
    // Before accepting it, audit for structurally reachable paths excluded by
    // the summarized entry CFG. The explorer itself reports cycles/unsupported
    // instructions while enumerating its admitted paths.
    if (loopContext.loop && loopContext.function) {
        std::set<const llvm::BasicBlock*> rawReachable;
        std::queue<const llvm::BasicBlock*> rawQueue;
        rawQueue.push(&loopContext.function->getEntryBlock());
        rawReachable.insert(rawQueue.front());
        while (!rawQueue.empty()) {
            const llvm::BasicBlock* block = rawQueue.front();
            rawQueue.pop();
            const llvm::Instruction* terminator = block->getTerminator();
            for (unsigned i = 0; terminator && i < terminator->getNumSuccessors(); ++i) {
                const llvm::BasicBlock* successor = terminator->getSuccessor(i);
                if (successor && rawReachable.insert(successor).second) rawQueue.push(successor);
            }
        }
        if (allowedBlocks.empty() && rawReachable.count(loopContext.loop->getHeader())) {
            addUnsupported(loopContext, "entry CFG excluded a structurally reachable loop header");
        }
        // Check both complete and empty entry relations: missing *one*
        // predecessor path is just as unsound as missing *all* of them.
        for (llvm::BasicBlock* allowedBlock : allowedBlocks) {
            for (const llvm::BasicBlock* predecessor : llvm::predecessors(allowedBlock)) {
                if (!predecessor || !rawReachable.count(predecessor) ||
                    allowedBlocks.count(const_cast<llvm::BasicBlock*>(predecessor)) ||
                    loopContext.loop->contains(predecessor)) continue;
                const llvm::Loop* outsidePredecessorLoop = nullptr;
                for (llvm::Loop* otherLoop : allLoops) {
                    if (otherLoop && otherLoop != loopContext.loop &&
                        !isAncestorLoopOf(otherLoop, loopContext.loop) &&
                        otherLoop->contains(predecessor)) {
                        outsidePredecessorLoop = otherLoop;
                    }
                }
                if (!outsidePredecessorLoop) continue;
                bool summarized = false;
                for (llvm::Loop* previousLoop : previousLoops) {
                    if (previousLoop && previousLoop->contains(predecessor)) {
                        summarized = true;
                        break;
                    }
                }
                if (!summarized) {
                    addUnsupported(loopContext, "entry path may traverse unsummarized predecessor loop: " +
                        getBasicBlockName(predecessor));
                }
            }
        }
    }
    // <<< NEXUS CHANGE END [2.2 - empty entry is false, not automatically unsupported]
    nlohmann::ordered_json entryJson;
    entryJson["id"] = makeRelationName(loopId, "entry_states");
    entryJson["path_semantics"] = "existential_disjunction";
    entryJson["paths"] = nlohmann::ordered_json::array();
    std::set<std::string> seenSemanticPathKeys;
    for (const ReadableEntryPath& entryPath : entryPaths) {
        nlohmann::ordered_json pathJson;
        pathJson["condition"] = convertExpressionToJson(normalizeCondition(entryPath.condition));
        if (!entryPath.sourceCalls.empty()) {
            if (entryPath.sourceCalls.size() > 1) {
                addUnsupported(loopContext, "entry path has more than one semantic source_call");
            }
            pathJson["source_call"] = readableEntrySourceCallJson(entryPath.sourceCalls.front());
        }
        pathJson["updates"] = nlohmann::ordered_json::object();
        for (const StateVariable& variable : loopContext.variables) {
            auto updateIt = entryPath.updates.find(variable.name);
            const Expression value = updateIt == entryPath.updates.end() ? atom(variable.name) : updateIt->second;
            pathJson["updates"][variable.name] = convertExpressionToJson(value);
        }
        appendUniquePath(entryJson["paths"], pathJson, "id", makeRelationName(loopId, "entry_states"), seenSemanticPathKeys);
    }
    return entryJson;
}

// Child-loop composition.
nlohmann::ordered_json serializeChildCalls(LoopContext& loopContext, const std::vector<ChildCall>& childCalls, const std::string& contextDescription) {
    std::function<llvm::Loop*(llvm::Loop*, const std::string&)> findLoopById;
    findLoopById = [&](llvm::Loop* rootLoop, const std::string& wantedLoopId) -> llvm::Loop* {
        if (!rootLoop) {
            return nullptr;
        }
        if (getLoopId(rootLoop) == wantedLoopId) {
            return rootLoop;
        }
        // >>> NEXUS CHANGE BEGIN [2.4.5 - resolve child summaries by source nesting]
        // The emitted parent_loop_id/child_loop_ids and exploration already use
        // the source-level parent map.  LLVM getSubLoops() can omit a lexical
        // child whose loop lies on an early-return branch; looking it up here
        // via LLVM alone incorrectly emits an unsupported relation.
        for (llvm::Loop* childLoop : getSemanticChildLoops(rootLoop)) {
            if (llvm::Loop* foundLoop = findLoopById(childLoop, wantedLoopId)) {
                return foundLoop;
            }
        }
        // <<< NEXUS CHANGE END [2.4.5 - resolve child summaries by source nesting]
        return nullptr;
    };
    nlohmann::ordered_json childCallsJson = nlohmann::ordered_json::array();
    std::map<std::string, std::string> priorChildOutputReplacements;
    std::set<std::string> seenNormalExitChildren;
    for (size_t childCallIndex = 0; childCallIndex < childCalls.size(); ++childCallIndex) {
        const ChildCall& childCall = childCalls[childCallIndex];
        const size_t callNumber = childCallIndex + 1;
        llvm::Loop* childLoop = findLoopById(loopContext.loop, childCall.childId);
        std::vector<StateVariable> childVariables;
        if (childLoop) {
            childVariables = extractVariables(childLoop, childCall.childId);
        }
        else {
            addUnsupported(loopContext, "could not resolve child loop while serializing " + contextDescription + ": " + childCall.childId);
        }

        if (!childVariables.empty() && childVariables.size() != loopContext.variables.size()) {
            addUnsupported(loopContext, "parent/child tracked-state size mismatch while serializing " + contextDescription + ": " + getLoopId(loopContext.loop) + " -> " + childCall.childId);
        }

        if (!childCall.isReturn && !seenNormalExitChildren.insert(childCall.childId).second) {
            addUnsupported(loopContext, "same child loop occurs more than once on one semantic path; " "direct child output symbols would alias: " + childCall.childId);
        }
        nlohmann::ordered_json childCallJson;
        childCallJson["relation"] = makeRelationName(childCall.childId, childCall.isReturn ? "header_to_return" : "header_to_exit");
        childCallJson["input_state"] = nlohmann::ordered_json::array();
        for (size_t variableIndex = 0; variableIndex < loopContext.variables.size(); ++variableIndex) {
            const StateVariable& parentVariable = loopContext.variables[variableIndex];
            auto entryStateIt = childCall.entryState.find(parentVariable.name);
            const Expression rawEntryValue = entryStateIt != childCall.entryState.end() ? entryStateIt->second : atom(parentVariable.name);
            const Expression entryValue = replaceAtomNames(rawEntryValue, priorChildOutputReplacements);
            childCallJson["input_state"].push_back(convertExpressionToJson(entryValue));
        }
        if (!childCall.isReturn) {
            childCallJson["output_state"] = nlohmann::ordered_json::array();
            for (size_t variableIndex = 0; variableIndex < loopContext.variables.size(); ++variableIndex) {
                const std::string childCurrentName = variableIndex < childVariables.size() ? childVariables[variableIndex].name : childVariableNameFromIndex(childCall.childId, variableIndex);
                const std::string childOutName = makeOutputVariableName(childCurrentName);
                childCallJson["output_state"].push_back(childOutName);
                priorChildOutputReplacements[childValuePlaceholder(childCall.childId, callNumber, loopContext.variables[variableIndex].name)] = childOutName;
                if (childCalls.size() == 1) {
                    priorChildOutputReplacements["<" + childCall.childId + ":" + loopContext.variables[variableIndex].name + ">"] = childOutName;
                }
            }
        }
        childCallsJson.push_back(std::move(childCallJson));
    }
    return childCallsJson;
}

// Base semantic relations.
nlohmann::ordered_json generateLoopIterationSteps(LoopContext& loopContext) {
    const std::string loopId = getLoopId(loopContext.loop);
    SymbolicState initialLoopState;
    for (const StateVariable& variable : loopContext.variables) {
        initialLoopState.valueExpr[variable.slot] = atom(variable.name);
        initialLoopState.memoryExpr[variable.slot] = atom(variable.name);
    }
    std::vector<RawTransition> rawTransitions;
    exploreLoopPaths(loopContext, loopContext.loop->getHeader(), std::move(initialLoopState), {}, rawTransitions);
    std::vector<Transition> transitions = extractTransitions(rawTransitions, loopId, loopContext.variables, loopContext.unsupported, "loop_back");
    nlohmann::ordered_json transitionJson;
    transitionJson["id"] = makeRelationName(loopId, "iteration_steps");
    transitionJson["path_semantics"] = "existential_disjunction";
    transitionJson["paths"] = nlohmann::ordered_json::array();
    std::set<std::string> seenSemanticPathKeys;
    for (const Transition& transition : transitions) {
        nlohmann::ordered_json pathJson;
        pathJson["condition"] = convertExpressionToJson(normalizeCondition(transition.pathCondition));
        if (!transition.childCalls.empty()) {
            pathJson["child_calls"] = serializeChildCalls(loopContext, transition.childCalls, "loop_iteration_steps path");
        }
        pathJson["updates"] = nlohmann::ordered_json::object();
        for (const StateVariable& variable : loopContext.variables) {
            const std::string oldNextName = makeNextVariableName(variable.name);
            auto updateIt = transition.updates.find(oldNextName);
            const Expression value = updateIt == transition.updates.end() ? atom(variable.name) : updateIt->second;
            pathJson["updates"][oldNextName] = convertExpressionToJson(value);
        }
        appendUniquePath(transitionJson["paths"], pathJson, "id", makeRelationName(loopId, "iteration_steps"), seenSemanticPathKeys);
    }
    return transitionJson;
}

nlohmann::ordered_json generateLoopExitSteps(LoopContext& loopContext) {
    const std::string loopId = getLoopId(loopContext.loop);
    const std::vector<RawTransition> rawTransitions = exploreReadablePrimitivePaths(loopContext);
    std::vector<Transition> exitTransitions = extractTransitions(rawTransitions, loopId, loopContext.variables, loopContext.unsupported, "exit");
    nlohmann::ordered_json exitStepJson;
    exitStepJson["id"] = makeRelationName(loopId, "exit_steps");
    exitStepJson["path_semantics"] = "existential_disjunction";
    exitStepJson["paths"] = nlohmann::ordered_json::array();
    std::set<std::string> seenSemanticPathKeys;
    for (const Transition& exitTransition : exitTransitions) {
        nlohmann::ordered_json pathJson;
        pathJson["condition"] = convertExpressionToJson(normalizeCondition(exitTransition.pathCondition));
        if (!exitTransition.childCalls.empty()) {
            pathJson["child_calls"] = serializeChildCalls(loopContext, exitTransition.childCalls, "loop_exit_steps path");
        }
        pathJson["updates"] = nlohmann::ordered_json::object();
        for (const StateVariable& variable : loopContext.variables) {
            const std::string oldOutName = makeOutputVariableName(variable.name);
            auto updateIt = exitTransition.updates.find(oldOutName);
            const Expression value = updateIt == exitTransition.updates.end() ? atom(variable.name) : updateIt->second;
            pathJson["updates"][oldOutName] = convertExpressionToJson(value);
        }
        appendUniquePath(exitStepJson["paths"], pathJson, "id", makeRelationName(loopId, "exit_steps"), seenSemanticPathKeys);
    }
    return exitStepJson;
}

nlohmann::ordered_json generateFunctionReturnSteps(LoopContext& loopContext) {
    const std::string loopId = getLoopId(loopContext.loop);
    const std::vector<RawTransition> rawTransitions = exploreReadablePrimitivePaths(loopContext);
    nlohmann::ordered_json returnStepJson;
    returnStepJson["id"] = makeRelationName(loopId, "return_steps");
    returnStepJson["path_semantics"] = "existential_disjunction";
    returnStepJson["paths"] = nlohmann::ordered_json::array();
    std::set<std::string> seenSemanticPathKeys;
    for (const RawTransition& rawTransition : rawTransitions) {
        if (rawTransition.kind != "return") {
            continue;
        }
        const std::vector<ChildCall> childCalls = rawTransition.childCalls.empty() && rawTransition.hasChildComposition ? std::vector<ChildCall>{{rawTransition.childId, "", rawTransition.childExitBlockName, rawTransition.childExitBlockName.empty(), rawTransition.childEntryState}} : rawTransition.childCalls;
        std::map<std::string, std::string> childOutputReplacements;
        for (size_t childCallIndex = 0; childCallIndex < childCalls.size(); ++childCallIndex) {
            const ChildCall& childCall = childCalls[childCallIndex];
            if (childCall.isReturn) {
                continue;
            }
            const size_t callNumber = childCallIndex + 1;
            for (size_t variableIndex = 0; variableIndex < loopContext.variables.size(); ++variableIndex) {
                const std::string childOutName = makeOutputVariableName(childVariableNameFromIndex(childCall.childId, variableIndex));
                childOutputReplacements[childValuePlaceholder(childCall.childId, callNumber, loopContext.variables[variableIndex].name)] = childOutName;
                if (childCalls.size() == 1) {
                    childOutputReplacements["<" + childCall.childId + ":" + loopContext.variables[variableIndex].name + ">"] = childOutName;
                }
            }
        }
        std::vector<Expression> readableLiterals;
        for (const Expression& pathLiteral : rawTransition.literals) {
            bool skipLiteral = false;
            for (size_t childCallIndex = 0; childCallIndex < childCalls.size(); ++childCallIndex) {
                const ChildCall& childCall = childCalls[childCallIndex];
                const size_t callNumber = childCallIndex + 1;
                if (exprEq(pathLiteral, atom(childPcPlaceholder(childCall.childId, callNumber))) || exprEq(pathLiteral, atom(childReturnPcPlaceholder(childCall.childId, callNumber))) || (childCalls.size() == 1 && (exprEq(pathLiteral, atom("<" + childCall.childId + ":pc>")) || exprEq(pathLiteral, atom("<" + childCall.childId + ":return_pc>"))))) {
                    skipLiteral = true;
                    break;
                }
            }
            if (skipLiteral) {
                continue;
            }
            Expression readableLiteral = pathLiteral;
            readableLiteral = replaceAtomNames(readableLiteral, childOutputReplacements);
            readableLiterals.push_back(readableLiteral);
        }
        Expression readableCondition = normalizeCondition(mkAnd(readableLiterals));
        nlohmann::ordered_json pathJson;
        pathJson["condition"] = convertExpressionToJson(readableCondition);
        if (!childCalls.empty()) {
            pathJson["child_calls"] = serializeChildCalls(loopContext, childCalls, "loop_return_steps path");
        }
        appendUniquePath(returnStepJson["paths"], pathJson, "id", makeRelationName(loopId, "return_steps"), seenSemanticPathKeys);
    }
    return returnStepJson;
}

// Derived Horn relations.
nlohmann::ordered_json generateReachableHeaderStates(const std::string& loopId, const std::vector<StateVariable>& variables) {
    const std::vector<std::string> currentArgs = getCurrentVariableNames(variables);
    const std::vector<std::string> nextArgs = getNextVariableNames(variables);
    const std::string relationId = makeRelationName(loopId, "reachable_header_states");
    nlohmann::ordered_json baseHead = {
        {"op", "relation_call"},
        {"relation", relationId},
        {"arguments", {{"state", currentArgs}}}
    };
    nlohmann::ordered_json baseBody = {
        {"op", "relation_call"},
        {"relation", makeRelationName(loopId, "entry_states")},
        {"arguments", {{"state", currentArgs}}}
    };
    nlohmann::ordered_json recursiveHead = {
        {"op", "relation_call"},
        {"relation", relationId},
        {"arguments", {{"state", nextArgs}}}
    };
    nlohmann::ordered_json reachableCurrentCall = {
        {"op", "relation_call"},
        {"relation", relationId},
        {"arguments", {{"state", currentArgs}}}
    };
    nlohmann::ordered_json iterationCall = {
        {"op", "relation_call"},
        {"relation", makeRelationName(loopId, "iteration_steps")},
        {"arguments", {
                {"current_state", currentArgs},
                {"next_state", nextArgs}
        }}
    };
    nlohmann::ordered_json reachJson;
    reachJson["id"] = relationId;
    reachJson["formula_semantics"] = "least_fixedpoint";
    reachJson["rules"] = nlohmann::ordered_json::array({ nlohmann::ordered_json{ {"id", relationId + "_base"}, {"head", baseHead}, {"body", baseBody} }, nlohmann::ordered_json{ {"id", relationId + "_recursive"}, {"head", recursiveHead}, {"body", { {"op", "and"}, {"args", nlohmann::ordered_json::array({ reachableCurrentCall, iterationCall })} }} } });
    return reachJson;
}

nlohmann::ordered_json generateHeaderToExit(const std::string& loopId, const std::vector<StateVariable>& variables) {
    const std::vector<std::string> currentArgs = getCurrentVariableNames(variables);
    const std::vector<std::string> nextArgs = getNextVariableNames(variables);
    const std::vector<std::string> outArgs = getOutputVariableNames(variables);
    const std::string relationId = makeRelationName(loopId, "header_to_exit");
    nlohmann::ordered_json headCall = {
        {"op", "relation_call"},
        {"relation", relationId},
        {"arguments", {
                {"state", currentArgs},
                {"output_state", outArgs}
        }}
    };
    nlohmann::ordered_json exitStepCall = {
        {"op", "relation_call"},
        {"relation", makeRelationName(loopId, "exit_steps")},
        {"arguments", {
                {"current_state", currentArgs},
                {"output_state", outArgs}
        }}
    };
    nlohmann::ordered_json iterationCall = {
        {"op", "relation_call"},
        {"relation", makeRelationName(loopId, "iteration_steps")},
        {"arguments", {
                {"current_state", currentArgs},
                {"next_state", nextArgs}
        }}
    };
    nlohmann::ordered_json recursiveCall = {
        {"op", "relation_call"},
        {"relation", relationId},
        {"arguments", {
                {"state", nextArgs},
                {"output_state", outArgs}
        }}
    };
    nlohmann::ordered_json headerToExitJson;
    headerToExitJson["id"] = relationId;
    headerToExitJson["formula_semantics"] = "least_fixedpoint";
    headerToExitJson["rules"] = nlohmann::ordered_json::array({ nlohmann::ordered_json{ {"id", relationId + "_base"}, {"head", headCall}, {"body", exitStepCall} }, nlohmann::ordered_json{ {"id", relationId + "_recursive"}, {"head", headCall}, {"body", { {"op", "and"}, {"args", nlohmann::ordered_json::array({ iterationCall, recursiveCall })} }} } });
    return headerToExitJson;
}

nlohmann::ordered_json generateHeaderToReturn(const std::string& loopId, const std::vector<StateVariable>& variables) {
    const std::vector<std::string> currentArgs = getCurrentVariableNames(variables);
    const std::vector<std::string> nextArgs = getNextVariableNames(variables);
    const std::string relationId = makeRelationName(loopId, "header_to_return");
    nlohmann::ordered_json headCall = {
        {"op", "relation_call"},
        {"relation", relationId},
        {"arguments", {{"state", currentArgs}}}
    };
    nlohmann::ordered_json returnStepCall = {
        {"op", "relation_call"},
        {"relation", makeRelationName(loopId, "return_steps")},
        {"arguments", {{"state", currentArgs}}}
    };
    nlohmann::ordered_json iterationCall = {
        {"op", "relation_call"},
        {"relation", makeRelationName(loopId, "iteration_steps")},
        {"arguments", {
                {"current_state", currentArgs},
                {"next_state", nextArgs}
        }}
    };
    nlohmann::ordered_json recursiveCall = {
        {"op", "relation_call"},
        {"relation", relationId},
        {"arguments", {{"state", nextArgs}}}
    };
    nlohmann::ordered_json headerToReturnJson;
    headerToReturnJson["id"] = relationId;
    headerToReturnJson["formula_semantics"] = "least_fixedpoint";
    headerToReturnJson["rules"] = nlohmann::ordered_json::array({ nlohmann::ordered_json{ {"id", relationId + "_base"}, {"head", headCall}, {"body", returnStepCall} }, nlohmann::ordered_json{ {"id", relationId + "_recursive"}, {"head", headCall}, {"body", { {"op", "and"}, {"args", nlohmann::ordered_json::array({ iterationCall, recursiveCall })} }} } });
    return headerToReturnJson;
}

nlohmann::ordered_json generateActualExit(const std::string& loopId, const std::vector<StateVariable>& variables) {
    const std::vector<std::string> currentArgs = getCurrentVariableNames(variables);
    const std::vector<std::string> outArgs = getOutputVariableNames(variables);
    const std::string relationId = makeRelationName(loopId, "actual_exit");
    nlohmann::ordered_json headCall = {
        {"op", "relation_call"},
        {"relation", relationId},
        {"arguments", {{"state", outArgs}}}
    };
    nlohmann::ordered_json entryCall = {
        {"op", "relation_call"},
        {"relation", makeRelationName(loopId, "entry_states")},
        {"arguments", {{"state", currentArgs}}}
    };
    nlohmann::ordered_json headerToExitCall = {
        {"op", "relation_call"},
        {"relation", makeRelationName(loopId, "header_to_exit")},
        {"arguments", {
                {"state", currentArgs},
                {"output_state", outArgs}
        }}
    };
    nlohmann::ordered_json actualExitJson;
    actualExitJson["id"] = relationId;
    actualExitJson["rules"] = nlohmann::ordered_json::array({ nlohmann::ordered_json{ {"id", relationId + "_rule"}, {"head", headCall}, {"body", { {"op", "and"}, {"args", nlohmann::ordered_json::array({ entryCall, headerToExitCall })} }} } });
    return actualExitJson;
}

// >>> NEXUS CHANGE BEGIN [2.5 - verify coverage of executable control flow]
// LoopInfo can omit irreducible cycles. Likewise, a remaining (not inlined)
// call anywhere reachable from the entry function may hide nontermination.
// Report these as unsupported, rather than proving a truncated program model.
// This check is deliberately conservative; it does not create synthetic loops.
std::vector<std::string> auditFunctionControlFlowCoverage(
    llvm::Function& function, const std::vector<llvm::Loop*>& allLoops) {
    std::set<std::string> issues;
    std::set<llvm::BasicBlock*> reachable;
    std::queue<llvm::BasicBlock*> worklist;
    worklist.push(&function.getEntryBlock());
    reachable.insert(&function.getEntryBlock());
    while (!worklist.empty()) {
        llvm::BasicBlock* block = worklist.front();
        worklist.pop();
        for (const llvm::Instruction& instruction : *block) {
            if (isa<llvm::DbgInfoIntrinsic>(&instruction)) {
                continue;
            }
            if (const auto* call = dyn_cast<llvm::CallBase>(&instruction)) {
                if (classifyKnownCall(call) == KnownCallSemantics::Unsupported) {
                    issues.insert("reachable call lacks a termination-safe summary or inlined body: " + convertLLVMValueToString(&instruction));
                }
            }
        }
        const llvm::Instruction* terminator = block->getTerminator();
        if (!terminator) {
            issues.insert("reachable basic block has no terminator: " + getBasicBlockName(block));
            continue;
        }
        if (!isa<llvm::BranchInst>(terminator) && !isa<llvm::SwitchInst>(terminator) &&
            !isa<llvm::ReturnInst>(terminator) && !isa<llvm::UnreachableInst>(terminator)) {
            issues.insert("reachable CFG terminator is not modeled: " + getBasicBlockName(block));
        }
        for (unsigned i = 0; i < terminator->getNumSuccessors(); ++i) {
            llvm::BasicBlock* next = terminator->getSuccessor(i);
            if (next && reachable.insert(next).second) {
                worklist.push(next);
            }
        }
    }
    // >>> NEXUS CHANGE BEGIN [2.4.4 - flag source return scopes without IR matches]
    // A source return that names an unmatched lexical loop must never be
    // reinterpreted as a normal loop exit just because an LLVM nesting ID
    // could not be reconstructed (for example an uneditable macro body).
    std::set<unsigned> knownSourceLoops;
    for (const auto& [loop, id] : sourceLoopIdsByIRLoop) {
        if (loop && loop->getHeader()->getParent() == &function) knownSourceLoops.insert(id);
    }
    for (llvm::BasicBlock* block : reachable) {
        if (auto marker = getSourceReturnProvenance(block)) {
            if (!marker->hasLoopIds) continue;
            for (unsigned id : marker->loopIds) {
                if (!knownSourceLoops.count(id)) {
                    issues.insert("source return references an unmatched lexical loop ID " + std::to_string(id));
                }
            }
        }
    }
    // <<< NEXUS CHANGE END [2.4.4 - flag source return scopes without IR matches]
    // >>> NEXUS CHANGE BEGIN [2.5.1 - audit cycles after removing modeled natural backedges]
    // A full SCC can contain *both* an LLVM-recognized natural loop and an
    // irreducible subcycle. Merely requiring the SCC to lie inside a LoopInfo
    // loop incorrectly declares those subcycles covered. Every remaining
    // cycle after dropping the modeled backedges is unmodeled control flow.
    std::set<std::pair<llvm::BasicBlock*, llvm::BasicBlock*>> modeledBackedges;
    for (llvm::Loop* loop : allLoops) {
        if (!loop) continue;
        for (llvm::BasicBlock* block : loop->blocks()) {
            const llvm::Instruction* terminator = block->getTerminator();
            for (unsigned i = 0; terminator && i < terminator->getNumSuccessors(); ++i) {
                if (terminator->getSuccessor(i) == loop->getHeader()) {
                    modeledBackedges.insert({block, loop->getHeader()});
                }
            }
        }
    }
    // Tarjan SCCs on residual CFG edges, with known LoopInfo backedges removed.
    // <<< NEXUS CHANGE END [2.5.1 - audit cycles after removing modeled natural backedges]
    std::map<llvm::BasicBlock*, int> indexes, lowlinks;
    std::set<llvm::BasicBlock*> onStack;
    std::vector<llvm::BasicBlock*> stack;
    int nextIndex = 0;
    std::function<void(llvm::BasicBlock*)> visit;
    visit = [&](llvm::BasicBlock* block) {
        indexes[block] = nextIndex;
        lowlinks[block] = nextIndex++;
        stack.push_back(block);
        onStack.insert(block);
        const llvm::Instruction* terminator = block->getTerminator();
        if (terminator) {
            for (unsigned i = 0; i < terminator->getNumSuccessors(); ++i) {
                llvm::BasicBlock* next = terminator->getSuccessor(i);
                // >>> NEXUS CHANGE BEGIN [2.5.1 - ignore only modeled backedges]
                if (!next || !reachable.count(next) || modeledBackedges.count({block, next})) continue;
                // <<< NEXUS CHANGE END [2.5.1 - ignore only modeled backedges]
                if (!indexes.count(next)) {
                    visit(next);
                    lowlinks[block] = std::min(lowlinks[block], lowlinks[next]);
                }
                else if (onStack.count(next)) {
                    lowlinks[block] = std::min(lowlinks[block], indexes[next]);
                }
            }
        }
        if (lowlinks[block] != indexes[block]) return;
        std::vector<llvm::BasicBlock*> component;
        while (!stack.empty()) {
            llvm::BasicBlock* node = stack.back();
            stack.pop_back();
            onStack.erase(node);
            component.push_back(node);
            if (node == block) break;
        }
        bool cyclic = component.size() > 1;
        if (!cyclic && !component.empty()) {
            const llvm::Instruction* term = component.front()->getTerminator();
            for (unsigned i = 0; term && i < term->getNumSuccessors(); ++i) {
                // >>> NEXUS CHANGE BEGIN [2.5.1 - self-edge residual coverage]
                cyclic = cyclic || (term->getSuccessor(i) == component.front() &&
                                    !modeledBackedges.count({component.front(), component.front()}));
                // <<< NEXUS CHANGE END [2.5.1 - self-edge residual coverage]
            }
        }
        if (!cyclic) return;
        // >>> NEXUS CHANGE BEGIN [2.5.1 - residual CFG SCC is genuinely unmodeled]
        // The component remains cyclic after ALL modeled natural backedges
        // were removed; LoopInfo summaries cannot account for this cycle.
        issues.insert("reachable irreducible or otherwise unmodeled CFG cycle at " + getBasicBlockName(component.front()));
        // <<< NEXUS CHANGE END [2.5.1 - residual CFG SCC is genuinely unmodeled]
    };
    for (llvm::BasicBlock* block : reachable) {
        if (!indexes.count(block)) {
            visit(block);
        }
    }
    return {issues.begin(), issues.end()};
}
// <<< NEXUS CHANGE END [2.5 - verify coverage of executable control flow]

// >>> NEXUS CHANGE BEGIN [2.5.2 - certify source loops without a backedge]
// LLVM may erase the natural-loop structure of a source C loop whose every
// feasible body path returns or breaks. This is a TERMINATION proof only when
// the *entire reachable entry-function CFG* is a finite DAG and all executed
// calls/terminators are modeled. Merely failing to find a LoopInfo loop is NOT
// sufficient: irreducible cycles and uninlined calls must remain unsupported.
struct AcyclicEntryCheck {
    bool proven = false;
    std::string reason;
};

AcyclicEntryCheck certifyAcyclicEntryFunction(
    llvm::Function& function, const std::vector<std::string>& coverageIssues) {
    constexpr llvm::StringLiteral unmatchedPrefix("source return references an unmatched lexical loop ID ");
    for (const std::string& issue : coverageIssues) {
        if (llvm::StringRef(issue).starts_with(unmatchedPrefix)) continue;
        return {false, issue}; // Never discard a genuine coverage warning.
    }

    std::set<const llvm::BasicBlock*> reachable;
    std::queue<const llvm::BasicBlock*> pending;
    reachable.insert(&function.getEntryBlock());
    pending.push(&function.getEntryBlock());
    std::set<unsigned> observedSourceLoopIds;
    std::map<unsigned, unsigned> sourceParentIds;
    std::set<unsigned> returnScopeIds;
    constexpr llvm::StringLiteral loopMarkerPrefix("NEXUS_SOURCE_LOOP_ID_");
    constexpr llvm::StringLiteral returnMarkerPrefix("NEXUS_SOURCE_RETURN_DEPTH_");

    while (!pending.empty()) {
        const llvm::BasicBlock* block = pending.front();
        pending.pop();
        const llvm::Instruction* terminator = block->getTerminator();
        if (!terminator ||
            !(llvm::isa<llvm::BranchInst>(terminator) ||
              llvm::isa<llvm::SwitchInst>(terminator) ||
              llvm::isa<llvm::ReturnInst>(terminator))) {
            // In particular, `unreachable` represents undefined execution,
            // not an ordinary successfully terminating path.
            return {false, "acyclic certificate requires modeled branch/switch/return terminators"};
        }
        for (const llvm::Instruction& instruction : *block) {
            const auto* call = llvm::dyn_cast<llvm::CallBase>(&instruction);
            if (!call) continue;
            if (classifyKnownCall(call) == KnownCallSemantics::Unsupported) {
                return {false, "acyclic certificate rejected an unsupported reachable call"};
            }
            if (!call->isInlineAsm()) continue;
            const auto* assembly = llvm::dyn_cast<llvm::InlineAsm>(call->getCalledOperand()->stripPointerCasts());
            if (!assembly) return {false, "acyclic certificate cannot read inline assembly"};
            const llvm::StringRef text = assembly->getAsmString();
            const size_t loopStart = text.find(loopMarkerPrefix);
            if (loopStart != llvm::StringRef::npos) {
                auto fields = text.substr(loopStart + loopMarkerPrefix.size()).split("_PARENT_");
                unsigned id = 0, parent = 0;
                if (fields.first.getAsInteger(10, id) ||
                    fields.second.getAsInteger(10, parent) || id == 0) {
                    return {false, "malformed source-loop marker in an acyclic entry"};
                }
                auto existing = sourceParentIds.find(id);
                if (existing != sourceParentIds.end() && existing->second != parent) {
                    return {false, "conflicting source-loop markers in an acyclic entry"};
                }
                observedSourceLoopIds.insert(id);
                sourceParentIds[id] = parent;
            }
            if (text.find(returnMarkerPrefix) != llvm::StringRef::npos) {
                auto marker = getSourceReturnProvenance(block);
                if (!marker || !marker->hasLoopIds) {
                    return {false, "unverifiable source-return marker in an acyclic entry"};
                }
                returnScopeIds.insert(marker->loopIds.begin(), marker->loopIds.end());
            }
        }
        for (unsigned i = 0; i < terminator->getNumSuccessors(); ++i) {
            const llvm::BasicBlock* successor = terminator->getSuccessor(i);
            if (successor && reachable.insert(successor).second) pending.push(successor);
        }
    }

    // A stale/incorrectly injected return scope must NEVER be excused just
    // because LoopInfo found no natural loop.
    for (unsigned id : returnScopeIds) {
        if (!observedSourceLoopIds.count(id)) {
            return {false, "source return has no corresponding executable source-loop marker"};
        }
    }
    for (const auto& [id, parent] : sourceParentIds) {
        if (parent != 0 && !observedSourceLoopIds.count(parent)) {
            return {false, "source-loop marker references an unobserved lexical parent"};
        }
    }

    // Independent topological check on the *full* reachable CFG, not just
    // LoopInfo backedges. This also rejects irreducible cycles.
    std::map<const llvm::BasicBlock*, unsigned> inDegree;
    for (const llvm::BasicBlock* block : reachable) inDegree[block] = 0;
    for (const llvm::BasicBlock* block : reachable) {
        const llvm::Instruction* terminator = block->getTerminator();
        for (unsigned i = 0; i < terminator->getNumSuccessors(); ++i) {
            const llvm::BasicBlock* successor = terminator->getSuccessor(i);
            if (successor && reachable.count(successor)) ++inDegree[successor];
        }
    }
    std::queue<const llvm::BasicBlock*> zeroDegree;
    for (const auto& [block, degree] : inDegree) {
        if (degree == 0) zeroDegree.push(block);
    }
    std::size_t visited = 0;
    while (!zeroDegree.empty()) {
        const llvm::BasicBlock* block = zeroDegree.front();
        zeroDegree.pop();
        ++visited;
        const llvm::Instruction* terminator = block->getTerminator();
        for (unsigned i = 0; i < terminator->getNumSuccessors(); ++i) {
            const llvm::BasicBlock* successor = terminator->getSuccessor(i);
            if (successor && --inDegree[successor] == 0) zeroDegree.push(successor);
        }
    }
    if (visited != reachable.size()) {
        return {false, "reachable CFG contains a cycle not certified by LLVM LoopInfo"};
    }
    return {true, {}};
}
// <<< NEXUS CHANGE END [2.5.2 - certify source loops without a backedge]

// Public operations.
bool loopInformationExtractor::extract(const std::filesystem::path& inlineBcPath, const std::filesystem::path& summariesDir, const std::set<std::string>& entryFunctionNames) {
    auto convertStringsToJson = [&](const std::vector<std::string>& S) -> nlohmann::ordered_json {
        nlohmann::ordered_json stringsJson = nlohmann::ordered_json::array();
        for (const auto& string : S) {
            stringsJson.push_back(string);
        }
        return stringsJson;
    };
    auto convertStateSymbolsToJson = [&](const std::vector<StateVariable>& variables) -> nlohmann::ordered_json {
        nlohmann::ordered_json stateSymbolsJson = nlohmann::ordered_json::array();
        for (const auto& variable : variables) {
            nlohmann::ordered_json symbolJson;
            symbolJson["current"] = variable.name;
            symbolJson["next"] = makeNextVariableName(variable.name);
            symbolJson["output"] = makeOutputVariableName(variable.name);
            symbolJson["type"] = variable.type;
            symbolJson["llvm_slot"] = variable.llvmName;
            stateSymbolsJson.push_back(std::move(symbolJson));
        }
        return stateSymbolsJson;
    };
    auto convertNondeterministicSymbolsToJson = [&](const std::vector<std::pair<std::string, std::string>>& symbols) -> nlohmann::ordered_json {
        nlohmann::ordered_json symbolsJson = nlohmann::ordered_json::array();
        for (const auto& [name, type] : symbols) {
            nlohmann::ordered_json symbolJson;
            symbolJson["name"] = name;
            symbolJson["type"] = type;
            symbolsJson.push_back(std::move(symbolJson));
        }
        return symbolsJson;
    };
    // >>> NEXUS CHANGE BEGIN [2.5.2 - reset the acyclic certificate per extraction]
    acyclicTerminationCertified_ = false;
    unsigned analyzedEntryFunctions = 0;
    bool allEntriesAcyclic = true;
    // <<< NEXUS CHANGE END [2.5.2 - reset the acyclic certificate per extraction]
    nextLoopId = 1;
    loopIds.clear();
    llvm::SMDiagnostic error;
    llvm::LLVMContext context;
    std::unique_ptr<llvm::Module> module = parseIRFile(inlineBcPath.string(), error, context);
    if (!module) {
        return false;
    }
    std::map<std::string, nlohmann::ordered_json> jsonsByLoopId;
    for (llvm::Function& function : *module) {
        if (function.isDeclaration()) {
            continue;
        }
        if (entryFunctionNames.find(function.getName().str()) == entryFunctionNames.end()) {
            continue;
        }
        // >>> NEXUS CHANGE BEGIN [2.5.2 - account for every entry function]
        ++analyzedEntryFunctions;
        // <<< NEXUS CHANGE END [2.5.2 - account for every entry function]
        llvm::DominatorTree dominatorTree(function);
        llvm::LoopInfo loopInfo;
        loopInfo.analyze(dominatorTree);
        std::vector<llvm::Loop*> allLoops = collectLoops(loopInfo);
        sortLoops(allLoops);
        // >>> NEXUS CHANGE BEGIN [2.4.4 - correlate C lexical loops with LLVM natural loops]
        associateSourceLoops(loopInfo, allLoops);
        // <<< NEXUS CHANGE END [2.4.4 - correlate C lexical loops with LLVM natural loops]
        // >>> NEXUS CHANGE BEGIN [2.5 - coverage audit for entry function]
        const std::vector<std::string> functionCoverageIssues =
            auditFunctionControlFlowCoverage(function, allLoops);
        // <<< NEXUS CHANGE END [2.5 - coverage audit for entry function]
        // >>> NEXUS CHANGE BEGIN [2.5.1 - unsupported CFG with zero LLVM loops]
        // If an entry function has no recognized loops, there is no honest
        // loop JSON to attach the findings to. Never invent a loop merely to
        // populate `unsupported`: keep the JSON schema unchanged and report
        // the source-level extraction limitation explicitly instead.
        // >>> NEXUS CHANGE BEGIN [2.5.2 - distinguish acyclic source loops from unsupported CFG]
        if (allLoops.empty()) {
            const AcyclicEntryCheck certificate =
                certifyAcyclicEntryFunction(function, functionCoverageIssues);
            if (certificate.proven) {
                // Source loops with no backedge have no iteration relation;
                // do not invent a Loop Information JSON or an LLM witness.
                continue;
            }
            std::filesystem::create_directories(summariesDir);
            std::ostringstream message;
            message << "unsupported control flow in entry function " << function.getName().str() << ": ";
            for (const std::string& issue : functionCoverageIssues) {
                message << issue << " | ";
            }
            message << certificate.reason;
            std::ofstream diagnostic(summariesDir / "unsupported_extraction.txt");
            if (diagnostic) diagnostic << message.str() << '\n';
            throw UnsupportedControlFlowError(message.str());
        }
        allEntriesAcyclic = false;
        // <<< NEXUS CHANGE END [2.5.2 - distinguish acyclic source loops from unsupported CFG]
        // <<< NEXUS CHANGE END [2.5.1 - unsupported CFG with zero LLVM loops]
        for (llvm::Loop* loop : allLoops) {
            (void)getLoopId(loop);
        }
        for (llvm::Loop* loop : allLoops) {
            nlohmann::ordered_json loopJson;
            const std::string loopId = getLoopId(loop);
            loopJson["loop_id"] = loopId;
            loopJson["function"] = function.getName().str();
            loopJson["llvm_header_block"] = getBasicBlockName(loop->getHeader());
            // >>> NEXUS CHANGE BEGIN [2.4.4 - emit C lexical parent relationship]
            if (const llvm::Loop* parent = getSemanticParentLoop(loop)) {
            // <<< NEXUS CHANGE END [2.4.4 - emit C lexical parent relationship]
                loopJson["parent_loop_id"] = getLoopId(parent);
            }
            else {
                loopJson["parent_loop_id"] = nullptr;
            }
            std::vector<std::string> childLoops;
            // >>> NEXUS CHANGE BEGIN [2.4.4 - emit C lexical children]
            for (llvm::Loop* child : getSemanticChildLoops(loop)) {
            // <<< NEXUS CHANGE END [2.4.4 - emit C lexical children]
                childLoops.push_back(getLoopId(child));
            }
            loopJson["child_loop_ids"] = convertStringsToJson(childLoops);
            std::vector<std::string> previousSequentialLoops;
            for (llvm::Loop* previousLoop : getPreviousSequentialLoops(loop, allLoops)) {
                previousSequentialLoops.push_back(getLoopId(previousLoop));
            }
            loopJson["previous_sequential_loop_ids"] = convertStringsToJson(previousSequentialLoops);
            std::vector<std::string> nextSequentialLoops;
            for (llvm::Loop* nextLoop : getNextSequentialLoops(loop, allLoops)) {
                nextSequentialLoops.push_back(getLoopId(nextLoop));
            }
            loopJson["next_sequential_loop_ids"] = convertStringsToJson(nextSequentialLoops);
            LoopContext loopContext;
            loopContext.loop = loop;
            loopContext.function = &function;
            loopContext.dominatorTree = &dominatorTree;
            loopContext.loopId = loopId;
            loopContext.variables = extractVariables(loop, loopId);
            for (const auto& variable : loopContext.variables) {
                loopContext.variableNames[variable.slot] = variable.name;
            }
            // >>> NEXUS CHANGE BEGIN [2.5 - preserve coverage failures]
            for (const std::string& issue : functionCoverageIssues) {
                addUnsupported(loopContext, issue);
            }
            // <<< NEXUS CHANGE END [2.5 - preserve coverage failures]
            nlohmann::ordered_json loopGuardJson = generateLoopGuard(loopContext);
            nlohmann::ordered_json entryStatesJson = generateEntryStates(loopContext, allLoops);
            nlohmann::ordered_json iterationStepsJson = generateLoopIterationSteps(loopContext);
            nlohmann::ordered_json exitStepsJson = generateLoopExitSteps(loopContext);
            nlohmann::ordered_json returnStepsJson = generateFunctionReturnSteps(loopContext);
            loopJson["state_symbols"] = convertStateSymbolsToJson(loopContext.variables);
            loopJson["nondeterministic_symbols"] = convertNondeterministicSymbolsToJson(loopContext.nondeterministicSymbols);
            loopJson["loop_guard"] = std::move(loopGuardJson);
            loopJson["entry_states"] = std::move(entryStatesJson);
            loopJson["loop_iteration_steps"] = std::move(iterationStepsJson);
            loopJson["loop_exit_steps"] = std::move(exitStepsJson);
            loopJson["loop_return_steps"] = std::move(returnStepsJson);
            loopJson["reachable_header_states"] = generateReachableHeaderStates(loopId, loopContext.variables);
            loopJson["header_to_exit"] = generateHeaderToExit(loopId, loopContext.variables);
            loopJson["header_to_return"] = generateHeaderToReturn(loopId, loopContext.variables);
            loopJson["actual_exit"] = generateActualExit(loopId, loopContext.variables);
            loopJson["unsupported"] = convertStringsToJson(loopContext.unsupported);
            jsonsByLoopId[loopId] = std::move(loopJson);
        }
    }
    // >>> NEXUS CHANGE BEGIN [2.5.2 - explicit zero-loop structural termination certificate]
    // Never certify an empty/missing set of entries. All selected definitions
    // must have passed the fully supported acyclic-CFG check above.
    if (jsonsByLoopId.empty() && analyzedEntryFunctions != 0 &&
        analyzedEntryFunctions == entryFunctionNames.size() && allEntriesAcyclic) {
        acyclicTerminationCertified_ = true;
        std::filesystem::create_directories(summariesDir);
        std::ofstream proof(summariesDir / "acyclic_termination.txt");
        if (proof) proof << "Termination certified: all reachable entry-function CFGs are finite DAGs, with supported calls and valid source-loop markers.\n";
        return true;
    }
    // <<< NEXUS CHANGE END [2.5.2 - explicit zero-loop structural termination certificate]
    if (jsonsByLoopId.empty()) {
        return false;
    }
    std::filesystem::create_directories(summariesDir);
    for (const auto& [loopId, loopJson] : jsonsByLoopId) {
        const std::filesystem::path summaryPath = summariesDir / (loopId + "_loop_information.json");
        std::ofstream summaryFile(summaryPath);
        if (!summaryFile) {
            return false;
        }
        summaryFile << loopJson.dump(2);
    }
    return true;
}

bool loopInformationExtractor::order(const std::filesystem::path& loopInformationDirectory, std::vector<loopInformation>& loopInformationList) {
    loopInformationList.clear();
    if (!std::filesystem::exists(loopInformationDirectory) || !std::filesystem::is_directory(loopInformationDirectory)) {
        return false;
    }
    std::vector<std::filesystem::path> summaryFiles;
    for (const auto& entry : std::filesystem::directory_iterator(loopInformationDirectory)) {
        if (!entry.is_regular_file()) continue;
        if (entry.path().extension() != ".json") continue;
        summaryFiles.push_back(entry.path());
    }
    std::sort(summaryFiles.begin(), summaryFiles.end());
    std::map<std::string, std::vector<std::string>> previousSequentialLoopsById;
    for (const auto& path : summaryFiles) {
        std::ifstream input(path);
        if (!input) {
            return false;
        }
        nlohmann::ordered_json payload;
        input >> payload;
        if (!payload.is_object() || !payload.contains("loop_id")) {
            continue;
        }
        loopInformation info;
        info.id = payload.at("loop_id").get<std::string>();
        if (payload.contains("parent_loop_id") && !payload["parent_loop_id"].is_null()) {
            info.parent = payload["parent_loop_id"].get<std::string>();
        }
        if (payload.contains("child_loop_ids") && payload["child_loop_ids"].is_array()) {
            for (const auto& child : payload["child_loop_ids"]) {
                info.children.push_back(child.get<std::string>());
            }
        }
        if (payload.contains("previous_sequential_loop_ids") && payload["previous_sequential_loop_ids"].is_array()) {
            for (const auto& previousLoop : payload["previous_sequential_loop_ids"]) {
                previousSequentialLoopsById[info.id].push_back(previousLoop.get<std::string>());
            }
        }
        loopInformationList.push_back(std::move(info));
    }
    if (loopInformationList.empty()) {
        return false;
    }
    std::vector<loopInformation> orderedLoops;
    std::set<std::string> processed;
    while (orderedLoops.size() < loopInformationList.size()) {
        bool progress = false;
        for (const auto& loop : loopInformationList) {
            if (processed.count(loop.id)) continue;
            bool allDependenciesProcessed = true;
            for (const auto& childId : loop.children) {
                if (!processed.count(childId)) {
                    allDependenciesProcessed = false;
                    break;
                }
            }
            if (allDependenciesProcessed) {
                auto previousIt = previousSequentialLoopsById.find(loop.id);
                if (previousIt != previousSequentialLoopsById.end()) {
                    for (const auto& previousLoopId : previousIt->second) {
                        if (!processed.count(previousLoopId)) {
                            allDependenciesProcessed = false;
                            break;
                        }
                    }
                }
            }
            if (allDependenciesProcessed) {
                orderedLoops.push_back(loop);
                processed.insert(loop.id);
                progress = true;
            }
        }
        if (!progress) {
            return false;
        }
    }
    loopInformationList = std::move(orderedLoops);
    return true;
}