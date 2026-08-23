#include "../include/loop_information_extractor.h"

unsigned nextLoopId = 1;
std::map<std::string, std::string> loopIds;

struct Variable {
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

struct ChildComposition {
    std::string childId;
    std::string exitBlockName;
    std::map<std::string, Expression> entryState;
    std::map<std::string, Expression> exitState;
};

struct ChildCall {
    std::string childId;
    std::string exitSourceBlockName;
    std::string exitBlockName;
    bool isReturn = false;
    std::map<std::string, Expression> entryState;
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

struct LoopBundle {
    std::vector<Variable> variables;
    Expression entry;
    Expression guard;
    std::vector<ChildComposition> childCompositions;
    std::vector<Transition> transitionSteps;
    std::vector<Transition> exitSteps;
    Expression returnStep;
    std::vector<std::string> unsupported;
};



struct LoopContext {
    llvm::Loop* loop = nullptr;
    llvm::Function* function = nullptr;
    llvm::DominatorTree* dominatorTree = nullptr;
    std::vector<Variable> variables;
    std::map<const llvm::Value*, std::string> variableNames;
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

struct ExplorationResult {
    std::vector<RawTransition> RawTransitions;
};



struct ChildPlaceholderCase {
    std::string childId;
    llvm::BasicBlock* exitSourceBlock = nullptr;
    llvm::BasicBlock* exitBlock = nullptr;
    std::set<const llvm::Value*> modifiedSlots;
    std::map<std::string, Expression> entryState;
};



struct BranchAllocator {
    unsigned nextBranchId = 1;
    std::string getNextBranchId() {
        return "B" + std::to_string(nextBranchId++);
    }
};

std::vector<std::string> getCurrentVariableNames(const std::vector<Variable>& variables);
std::vector<std::string> getOutVariableNames(const std::vector<Variable>& variables);
std::vector<Expression> atomArgumentsFromNames(const std::vector<std::string>& names);


Expression normalizeReadableCondition(const Expression& expression) {
    Expression normalized = expression;
    normalized.arguments.clear();
    normalized.arguments.reserve(expression.arguments.size());
    for (const Expression& argument : expression.arguments) {
        normalized.arguments.push_back(normalizeReadableCondition(argument));
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


Expression atom(const std::string& atomText) {
    Expression expression;
    expression.isCompound = false;
    expression.head = atomText;
    return expression;
}

Expression mkRelationCallExpression(const std::string& relationName, const std::vector<Expression>& relationArguments) {
    Expression expression;
    expression.isCompound = false;
    expression.isRelationCall = true;
    expression.head = relationName;
    expression.arguments = relationArguments;
    return expression;
}

Expression mkExistsExpression(const std::vector<std::string>& boundVariables, const Expression& body) {
    if (boundVariables.empty()) {
        return body;
    }
    Expression expression;
    expression.isCompound = false;
    expression.isExists = true;
    expression.boundVariables = boundVariables;
    expression.arguments = {body};
    return expression;
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

std::string makeOutVariableName(const std::string& variableName) {
    return variableName + "_out";
}

std::string makePrevVariableName(const std::string& variableName) {
    return variableName + "_prev";
}

std::string makeRelationName(const std::string& loopId, const std::string& relationSuffix) {
    return loopId + "_" + relationSuffix;
}

std::string sanitizeRelationSuffixPart(const std::string& rawName) {
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
}

std::string makeEntry2ExitRelationName(const std::string& loopId) {
    return makeRelationName(loopId, "entry2exit");
}

std::string makeEntry2ReturnRelationName(const std::string& loopId) {
    return makeRelationName(loopId, "entry2return");
}

std::string makeExitEdgeId(const std::string& loopId,
                           const std::string& sourceBlockName,
                           const std::string& targetBlockName) {
    return loopId + "_x_" +
           sanitizeRelationSuffixPart(sourceBlockName + "_to_" + targetBlockName);
}

std::string makeCFGBlockRelationName(const std::string& loopId, const std::string& prefix, const llvm::BasicBlock* block) {
    return makeRelationName(loopId, prefix + "_bb_" + sanitizeRelationSuffixPart(getBasicBlockName(block)));
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

size_t appendChildCall(SymbolicState& symbolicState,
                       const std::string& childId,
                       const std::string& exitSourceBlockName,
                       const std::string& exitBlockName,
                       bool isReturn,
                       const std::map<std::string, Expression>& entryState) {
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
}

bool isSyntheticPathBlockName(const std::string& blockName) {
    return !blockName.empty() && blockName.front() == '<';
}

template <typename PathRecord>
std::pair<std::string, std::string> getPathExitEdgeNames(const PathRecord& pathRecord) {
    std::string targetBlockName = "unknown_exit";
    for (auto blockIt = pathRecord.basicBlocks.rbegin();
         blockIt != pathRecord.basicBlocks.rend();
         ++blockIt) {
        if (!isSyntheticPathBlockName(*blockIt)) {
            targetBlockName = *blockIt;
            break;
        }
    }

    if (!pathRecord.childCalls.empty()) {
        const ChildCall& lastChildCall = pathRecord.childCalls.back();
        if (!lastChildCall.isReturn &&
            !lastChildCall.exitSourceBlockName.empty() &&
            !lastChildCall.exitBlockName.empty() &&
            lastChildCall.exitBlockName == targetBlockName) {
            return {lastChildCall.exitSourceBlockName, targetBlockName};
        }
    }

    bool skippedTarget = false;
    for (auto blockIt = pathRecord.basicBlocks.rbegin();
         blockIt != pathRecord.basicBlocks.rend();
         ++blockIt) {
        if (isSyntheticPathBlockName(*blockIt)) {
            continue;
        }
        if (!skippedTarget) {
            skippedTarget = true;
            continue;
        }
        return {*blockIt, targetBlockName};
    }

    return {"unknown_source", targetBlockName};
}

std::string getTransitionExitBlockName(const Transition& transition) {
    return getPathExitEdgeNames(transition).second;
}

std::string getTransitionExitSourceBlockName(const Transition& transition) {
    return getPathExitEdgeNames(transition).first;
}

std::string getRawTransitionExitEdgeId(const std::string& loopId,
                                       const RawTransition& rawTransition) {
    const auto [sourceBlockName, targetBlockName] =
        getPathExitEdgeNames(rawTransition);
    return makeExitEdgeId(loopId, sourceBlockName, targetBlockName);
}

const llvm::Value* findFunctionReturnSlot(const llvm::Function* function) {
    if (!function) {
        return nullptr;
    }

    for (const llvm::BasicBlock& block : *function) {
        const auto* returnInstruction = dyn_cast<llvm::ReturnInst>(block.getTerminator());
        if (!returnInstruction || returnInstruction->getNumOperands() == 0) {
            continue;
        }

        const llvm::Value* returnValue = returnInstruction->getReturnValue();
        const auto* loadInstruction = dyn_cast_or_null<llvm::LoadInst>(returnValue);
        if (!loadInstruction) {
            continue;
        }

        const llvm::Value* loadedPointer = loadInstruction->getPointerOperand()->stripPointerCasts();
        if (isa<llvm::AllocaInst>(loadedPointer) || isa<llvm::GlobalVariable>(loadedPointer)) {
            return loadedPointer;
        }
    }

    return nullptr;
}

bool blockStoresToSlot(const llvm::BasicBlock* block, const llvm::Value* slot) {
    if (!block || !slot) {
        return false;
    }

    for (const llvm::Instruction& instruction : *block) {
        const auto* storeInstruction = dyn_cast<llvm::StoreInst>(&instruction);
        if (!storeInstruction) {
            continue;
        }

        const llvm::Value* storedPointer = storeInstruction->getPointerOperand()->stripPointerCasts();
        if (storedPointer == slot) {
            return true;
        }
    }

    return false;
}

bool blockCanReachReturnInstWithoutReenteringLoop(const llvm::BasicBlock* startBlock, const llvm::Loop* forbiddenLoop) {
    if (!startBlock) {
        return false;
    }

    std::queue<const llvm::BasicBlock*> worklist;
    std::set<const llvm::BasicBlock*> seen;
    worklist.push(startBlock);
    seen.insert(startBlock);

    while (!worklist.empty()) {
        const llvm::BasicBlock* block = worklist.front();
        worklist.pop();

        const llvm::Instruction* terminator = block ? block->getTerminator() : nullptr;
        if (!terminator) {
            continue;
        }

        if (isa<llvm::ReturnInst>(terminator)) {
            return true;
        }

        for (unsigned successorIndex = 0; successorIndex < terminator->getNumSuccessors(); ++successorIndex) {
            const llvm::BasicBlock* successorBlock = terminator->getSuccessor(successorIndex);
            if (!successorBlock) {
                continue;
            }

            if (forbiddenLoop && forbiddenLoop->contains(successorBlock)) {
                continue;
            }

            if (seen.insert(successorBlock).second) {
                worklist.push(successorBlock);
            }
        }
    }

    return false;
}

bool isSemanticReturnExitEdge(const llvm::Loop* loop,
                              const llvm::BasicBlock* sourceBlock,
                              const llvm::BasicBlock* successorBlock) {
    if (!loop || !sourceBlock || !successorBlock) {
        return false;
    }

    if (loop->contains(successorBlock)) {
        return false;
    }

    const llvm::Function* function = sourceBlock->getParent();
    const llvm::Value* returnSlot = findFunctionReturnSlot(function);

    // At -O0, Clang usually lowers source-level `return e;` to a store into a
    // unified return slot followed by a branch to the function epilogue block.
    // A normal loop exit may also eventually reach the same epilogue, but it
    // does not store the return slot on the exiting edge.  This distinguishes
    // source-level return exits from ordinary fall-through/break exits.
    if (returnSlot) {
        // Case A: the loop block itself stores the source-level return value
        // and then exits to the unified function epilogue.
        if (blockStoresToSlot(sourceBlock, returnSlot) &&
            blockCanReachReturnInstWithoutReenteringLoop(successorBlock, loop)) {
            return true;
        }

        // Case B: at -O0 Clang often puts the return-value store in the first
        // block *outside* the loop.  The loop edge exits to that block, which
        // immediately stores into the unified return slot and then reaches the
        // final ret block.  The previous version missed exactly this pattern.
        if (blockStoresToSlot(successorBlock, returnSlot) &&
            blockCanReachReturnInstWithoutReenteringLoop(successorBlock, loop)) {
            return true;
        }
    }

    // Some IR forms may contain a direct ReturnInst inside the loop.
    if (isa<llvm::ReturnInst>(sourceBlock->getTerminator())) {
        return true;
    }

    return false;
}

bool loopContainsReturn(const llvm::Loop* loop) {
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
}

const llvm::Loop* directChildLoopContainingBlock(const llvm::Loop* parentLoop, const llvm::BasicBlock* block) {
    if (!parentLoop || !block) {
        return nullptr;
    }
    for (llvm::Loop* subLoop : parentLoop->getSubLoops()) {
        if (subLoop && subLoop->contains(block)) {
            return subLoop;
        }
    }
    return nullptr;
}

bool isLoopHeaderOfAnyLoop(const llvm::LoopInfo& loopInfo, const llvm::BasicBlock* block) {
    if (!block) {
        return false;
    }
    const llvm::Loop* loop = loopInfo.getLoopFor(block);
    return loop && loop->getHeader() == block;
}

std::vector<llvm::Loop*> collectLoopsInFunction(llvm::LoopInfo& loopInfo) {
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

std::optional<std::pair<unsigned, unsigned>> getLoopSourceOccurrence(
    const llvm::Loop* loop) {
    if (!loop || !loop->getHeader()) {
        return std::nullopt;
    }

    for (const llvm::Instruction& instruction : *loop->getHeader()) {
        const llvm::DebugLoc& debugLocation = instruction.getDebugLoc();
        if (debugLocation && debugLocation.getLine() != 0) {
            return std::make_pair(debugLocation.getLine(),
                                  debugLocation.getCol());
        }
    }

    return std::nullopt;
}

void sortLoopsByProgramOccurrence(std::vector<llvm::Loop*>& loops) {
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
        std::stable_sort(
            loops.begin(),
            loops.end(),
            [&](llvm::Loop* leftLoop, llvm::Loop* rightLoop) {
                const auto& leftLocation = sourceLocations.at(leftLoop);
                const auto& rightLocation = sourceLocations.at(rightLoop);
                if (leftLocation != rightLocation) {
                    return leftLocation < rightLocation;
                }
                return loopIsBeforeLoopInFunctionOrder(leftLoop, rightLoop);
            });
        return;
    }

    // Bitcode without debug locations: preserve the program occurrence order
    // represented by LLVM basic-block order.
    std::stable_sort(
        loops.begin(),
        loops.end(),
        [](llvm::Loop* leftLoop, llvm::Loop* rightLoop) {
            return loopIsBeforeLoopInFunctionOrder(leftLoop, rightLoop);
        });
}

bool loopHasMustProgressMetadata(const llvm::Loop* loop) {
    if (!loop) {
        return false;
    }

    const llvm::MDNode* loopIdMetadata = loop->getLoopID();
    if (!loopIdMetadata) {
        return false;
    }

    for (unsigned operandIndex = 1;
         operandIndex < loopIdMetadata->getNumOperands();
         ++operandIndex) {
        const llvm::Metadata* propertyMetadata =
            loopIdMetadata->getOperand(operandIndex).get();
        const auto* propertyNode =
            llvm::dyn_cast_or_null<llvm::MDNode>(propertyMetadata);
        if (!propertyNode || propertyNode->getNumOperands() == 0) {
            continue;
        }

        const auto* propertyName = llvm::dyn_cast_or_null<llvm::MDString>(
            propertyNode->getOperand(0).get());
        if (propertyName &&
            propertyName->getString() == "llvm.loop.mustprogress") {
            return true;
        }
    }

    return false;
}



bool loopsHaveSameParent(const llvm::Loop* leftLoop, const llvm::Loop* rightLoop) {
    if (!leftLoop || !rightLoop) {
        return false;
    }
    return leftLoop->getParentLoop() == rightLoop->getParentLoop();
}

std::vector<llvm::Loop*> getSiblingLoopsInOrder(llvm::Loop* targetLoop, const std::vector<llvm::Loop*>& allLoops) {
    std::vector<llvm::Loop*> siblings;
    for (llvm::Loop* loop : allLoops) {
        if (loop && loop != targetLoop && loopsHaveSameParent(loop, targetLoop)) {
            siblings.push_back(loop);
        }
    }
    std::sort(siblings.begin(), siblings.end(), [](llvm::Loop* leftLoop, llvm::Loop* rightLoop) {
        return loopIsBeforeLoopInFunctionOrder(leftLoop, rightLoop);
    });
    return siblings;
}

llvm::Loop* getPreviousSequentialLoop(llvm::Loop* targetLoop, const std::vector<llvm::Loop*>& allLoops) {
    llvm::Loop* previousLoop = nullptr;
    for (llvm::Loop* loop : allLoops) {
        if (!loop || loop == targetLoop) {
            continue;
        }
        if (!loopsHaveSameParent(loop, targetLoop)) {
            continue;
        }
        if (!loopIsBeforeLoopInFunctionOrder(loop, targetLoop)) {
            continue;
        }
        if (!previousLoop || loopIsBeforeLoopInFunctionOrder(previousLoop, loop)) {
            previousLoop = loop;
        }
    }
    return previousLoop;
}

llvm::Loop* getNextSequentialLoop(llvm::Loop* targetLoop, const std::vector<llvm::Loop*>& allLoops) {
    llvm::Loop* nextLoop = nullptr;
    for (llvm::Loop* loop : allLoops) {
        if (!loop || loop == targetLoop) {
            continue;
        }
        if (!loopsHaveSameParent(loop, targetLoop)) {
            continue;
        }
        if (!loopIsBeforeLoopInFunctionOrder(targetLoop, loop)) {
            continue;
        }
        if (!nextLoop || loopIsBeforeLoopInFunctionOrder(loop, nextLoop)) {
            nextLoop = loop;
        }
    }
    return nextLoop;
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

std::vector<std::pair<llvm::BasicBlock*, llvm::BasicBlock*>>
getUniqueExitEdges(llvm::Loop* loop) {
    std::vector<std::pair<llvm::BasicBlock*, llvm::BasicBlock*>> exits;
    if (!loop) {
        return exits;
    }

    llvm::SmallVector<
        std::pair<llvm::BasicBlock*, llvm::BasicBlock*>, 16> rawExits;
    loop->getExitEdges(rawExits);
    std::set<std::pair<llvm::BasicBlock*, llvm::BasicBlock*>> seen;
    for (const auto& exitEdge : rawExits) {
        if (exitEdge.first && exitEdge.second &&
            seen.insert(exitEdge).second) {
            exits.push_back(exitEdge);
        }
    }
    return exits;
}



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
    result.arguments = {
        conditionExpression,
        trueExpression,
        falseExpression
    };
    return result;
}

Expression evalValue(const llvm::Value* llvmValue, LoopContext& loopContext, SymbolicState& symbolicState) {
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
            argumentName =
                "arg" + std::to_string(functionArgument->getArgNo());
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
        Expression leftOperand = evalValue(binaryInstruction->getOperand(0), loopContext, symbolicState);
        Expression rightOperand = evalValue(binaryInstruction->getOperand(1), loopContext, symbolicState);
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
        Expression leftOperand = evalValue(compareInstruction->getOperand(0), loopContext, symbolicState);
        Expression rightOperand = evalValue(compareInstruction->getOperand(1), loopContext, symbolicState);
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
        Expression condition = evalValue(selectInstruction->getCondition(), loopContext, symbolicState);
        Expression trueValue = evalValue(selectInstruction->getTrueValue(), loopContext, symbolicState);
        Expression falseValue = evalValue(selectInstruction->getFalseValue(), loopContext, symbolicState);
        result = mkIte(condition, trueValue, falseValue);
    }
    else if (const auto* castInstruction = dyn_cast<llvm::CastInst>(instruction)) {
        Expression castOperand = evalValue(castInstruction->getOperand(0), loopContext, symbolicState);
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
        result = evalValue(instruction->getOperand(0), loopContext, symbolicState);
    }
    else if (const auto* callInstruction = dyn_cast<llvm::CallInst>(instruction)) {
        const llvm::Function* calledFunction = callInstruction->getCalledFunction();
        if (calledFunction && callInstruction->getType()->isIntegerTy() &&
            (calledFunction->getName().starts_with("__VERIFIER_nondet_") || calledFunction->getName() == "nondet")) {
            result = atom("nd" + std::to_string(loopContext.nextNondetId++));
        }
        else {
            addUnsupported(loopContext, "unsupported call: " + convertLLVMValueToString(instruction));
            result = atom("<unsupported-call>");
        }

    }
    else {
        addUnsupported(loopContext, "unsupported instruction in symbolic evaluator: " + convertLLVMValueToString(instruction));
        result = atom("<unsupported-inst>");
    }
    symbolicState.valueExpr[llvmValue] = result;
    return result;
}

void executeNonTerminatorInstructions(llvm::BasicBlock* basicBlock, LoopContext& loopContext, SymbolicState& symbolicState) {
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
                    Expression rightHandSide = evalValue(storeInstruction->getValueOperand(), loopContext, symbolicState);
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
        (void)evalValue(&instruction, loopContext, symbolicState);
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

void recordRawTransition(const std::string& transitionKind, const std::vector<std::string>& visitedBlocks, const SymbolicState& symbolicState, const LoopContext& loopContext, ExplorationResult& explorationResult) {
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
            std::string outputVariableName = transitionKind == "loop_back"
                ? makeNextVariableName(variable.name)
                : makeOutVariableName(variable.name);
            auto currentSymbolicValue = symbolicState.memoryExpr.find(variable.slot);
            rawTransition.updates[outputVariableName] = (currentSymbolicValue != symbolicState.memoryExpr.end()) ? currentSymbolicValue->second : atom(variable.name);
        }
    }
    explorationResult.RawTransitions.push_back(std::move(rawTransition));
}

void recordChildReturnTransitionIfNeeded(llvm::Loop* childLoop,
                                         const std::string& childLoopId,
                                         const SymbolicState& stateBeforeChild,
                                         const std::map<std::string, Expression>& childEntryState,
                                         LoopContext& loopContext,
                                         ExplorationResult& explorationResult) {
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
    recordRawTransition("return", completedPath, childReturnState, loopContext, explorationResult);
}

void exploreLoopPaths(LoopContext& loopContext, llvm::BasicBlock* currentBlock, SymbolicState currentState, std::set<const llvm::BasicBlock*> visitedBlocks, ExplorationResult& explorationResult) {
    if (visitedBlocks.count(currentBlock)) {
        addUnsupported(loopContext, "internal cycle before reaching loop header detected at " + getBasicBlockName(currentBlock));
        return;
    }
    visitedBlocks.insert(currentBlock);
    currentState.pathBlocks.push_back(getBasicBlockName(currentBlock));
    executeNonTerminatorInstructions(currentBlock, loopContext, currentState);
    llvm::Instruction* terminator = currentBlock->getTerminator();
    if (!terminator) {
        addUnsupported(loopContext, "block without terminator: " + getBasicBlockName(currentBlock));
        return;
    }
    if (isa<llvm::ReturnInst>(terminator)) {
        recordRawTransition("return", currentState.pathBlocks, currentState, loopContext, explorationResult);
        return;
    }

    if (auto* branchInst = dyn_cast<llvm::BranchInst>(terminator)) {
        Expression branchCondition;
        unsigned successorCount = 1;
        if (branchInst->isConditional()) {
            branchCondition = evalValue(branchInst->getCondition(), loopContext, currentState);
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
                recordRawTransition("loop_back", completedPath, successorState, loopContext, explorationResult);
                continue;
            }
            if (!loopContext.loop->contains(successorBlock)) {
                std::vector<std::string> completedPath = successorState.pathBlocks;
                completedPath.push_back(getBasicBlockName(successorBlock));
                const std::string transitionKind =
                    isSemanticReturnExitEdge(loopContext.loop, currentBlock, successorBlock)
                        ? "return"
                        : "exit";
                recordRawTransition(transitionKind, completedPath, successorState, loopContext, explorationResult);
                continue;
            }
            llvm::Loop* childLoop = nullptr;
            for (llvm::Loop* subLoop : loopContext.loop->getSubLoops()) {
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
                recordChildReturnTransitionIfNeeded(childLoop, childLoopId, successorState, childEntryState, loopContext, explorationResult);
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
                    if (!exitSourceBlock || !exitBlock ||
                        !seenExitEdges.insert(childExitEdge).second) {
                        continue;
                    }
                    if (isSemanticReturnExitEdge(childLoop,
                                                 exitSourceBlock,
                                                 exitBlock)) {
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

                    size_t callIndex = appendChildCall(afterChildState,
                                                       childExitCase.childId,
                                                       getBasicBlockName(childExitCase.exitSourceBlock),
                                                       childExitBlockName,
                                                       false,
                                                       childExitCase.entryState);

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
                        recordRawTransition("loop_back", completedPath, afterChildState, loopContext, explorationResult);
                        continue;
                    }
                    if (!loopContext.loop->contains(childExitCase.exitBlock)) {
                        std::vector<std::string> completedPath = afterChildState.pathBlocks;
                        completedPath.push_back(getBasicBlockName(childExitCase.exitBlock));
                        recordRawTransition("exit", completedPath, afterChildState, loopContext, explorationResult);
                        continue;
                    }
                    exploreLoopPaths(loopContext, childExitCase.exitBlock, std::move(afterChildState), visitedBlocks, explorationResult);
                }
                continue;
            }
            for (llvm::Instruction& instruction : *successorBlock) {
                auto* phiNode = dyn_cast<llvm::PHINode>(&instruction);
                if (!phiNode) {
                    break;
                }
                llvm::Value* incomingValue = phiNode->getIncomingValueForBlock(currentBlock);
                Expression incomingExpression = evalValue(incomingValue, loopContext, successorState);
                successorState.valueExpr[phiNode] = incomingExpression;
            }
            exploreLoopPaths(loopContext, successorBlock, std::move(successorState), visitedBlocks, explorationResult);
        }
        return;
    }
    if (auto* switchInst = dyn_cast<llvm::SwitchInst>(terminator)) {
        Expression switchCondition = evalValue(switchInst->getCondition(), loopContext, currentState);
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
                recordRawTransition("loop_back", completedPath, caseState, loopContext, explorationResult);
                continue;
            }
            if (!loopContext.loop->contains(successorBlock)) {
                std::vector<std::string> completedPath = caseState.pathBlocks;
                completedPath.push_back(getBasicBlockName(successorBlock));
                const std::string transitionKind =
                    isSemanticReturnExitEdge(loopContext.loop, currentBlock, successorBlock)
                        ? "return"
                        : "exit";
                recordRawTransition(transitionKind, completedPath, caseState, loopContext, explorationResult);
                continue;
            }
            llvm::Loop* childLoop = nullptr;
            for (llvm::Loop* subLoop : loopContext.loop->getSubLoops()) {
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
                recordChildReturnTransitionIfNeeded(childLoop, childLoopId, caseState, childEntryState, loopContext, explorationResult);
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
                    if (!exitSourceBlock || !exitBlock ||
                        !seenExitEdges.insert(childExitEdge).second) {
                        continue;
                    }
                    if (isSemanticReturnExitEdge(childLoop,
                                                 exitSourceBlock,
                                                 exitBlock)) {
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

                    size_t callIndex = appendChildCall(afterChildState,
                                                       childExitCase.childId,
                                                       getBasicBlockName(childExitCase.exitSourceBlock),
                                                       childExitBlockName,
                                                       false,
                                                       childExitCase.entryState);

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
                        recordRawTransition("loop_back", completedPath, afterChildState, loopContext, explorationResult);
                        continue;
                    }

                    if (!loopContext.loop->contains(childExitCase.exitBlock)) {
                        std::vector<std::string> completedPath = afterChildState.pathBlocks;
                        completedPath.push_back(getBasicBlockName(childExitCase.exitBlock));
                        recordRawTransition("exit", completedPath, afterChildState, loopContext, explorationResult);
                        continue;
                    }
                    exploreLoopPaths(loopContext, childExitCase.exitBlock, std::move(afterChildState), visitedBlocks, explorationResult);
                }
                continue;
            }
            for (llvm::Instruction& instruction : *successorBlock) {
                auto* phiNode = dyn_cast<llvm::PHINode>(&instruction);
                if (!phiNode) {
                    break;
                }
                llvm::Value* incomingValue = phiNode->getIncomingValueForBlock(currentBlock);
                Expression incomingExpression = evalValue(incomingValue, loopContext, caseState);
                caseState.valueExpr[phiNode] = incomingExpression;
            }
            exploreLoopPaths(loopContext, successorBlock, std::move(caseState), visitedBlocks, explorationResult);
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
            recordRawTransition("loop_back", completedPath, defaultState, loopContext, explorationResult);
            return;
        }
        if (!loopContext.loop->contains(defaultSuccessorBlock)) {
            std::vector<std::string> completedPath = defaultState.pathBlocks;
            completedPath.push_back(getBasicBlockName(defaultSuccessorBlock));
            const std::string transitionKind =
                isSemanticReturnExitEdge(loopContext.loop, currentBlock, defaultSuccessorBlock)
                    ? "return"
                    : "exit";
            recordRawTransition(transitionKind, completedPath, defaultState, loopContext, explorationResult);
            return;
        }
        llvm::Loop* childLoop = nullptr;
        for (llvm::Loop* subLoop : loopContext.loop->getSubLoops()) {
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
            recordChildReturnTransitionIfNeeded(childLoop, childLoopId, defaultState, childEntryState, loopContext, explorationResult);
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
                if (!exitSourceBlock || !exitBlock ||
                    !seenExitEdges.insert(childExitEdge).second) {
                    continue;
                }
                if (isSemanticReturnExitEdge(childLoop,
                                             exitSourceBlock,
                                             exitBlock)) {
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

                size_t callIndex = appendChildCall(afterChildState,
                                                       childExitCase.childId,
                                                       getBasicBlockName(childExitCase.exitSourceBlock),
                                                       childExitBlockName,
                                                       false,
                                                       childExitCase.entryState);

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
                    recordRawTransition("loop_back", completedPath, afterChildState, loopContext, explorationResult);
                    continue;
                }
                if (!loopContext.loop->contains(childExitCase.exitBlock)) {
                    std::vector<std::string> completedPath = afterChildState.pathBlocks;
                    completedPath.push_back(getBasicBlockName(childExitCase.exitBlock));
                    recordRawTransition("exit", completedPath, afterChildState, loopContext, explorationResult);
                    continue;
                }
                exploreLoopPaths(loopContext, childExitCase.exitBlock, std::move(afterChildState), visitedBlocks, explorationResult);
            }
            return;
        }
        for (llvm::Instruction& instruction : *defaultSuccessorBlock) {
            auto* phiNode = dyn_cast<llvm::PHINode>(&instruction);
            if (!phiNode) {
                break;
            }
            llvm::Value* incomingValue = phiNode->getIncomingValueForBlock(currentBlock);
            Expression incomingExpression = evalValue(incomingValue, loopContext, defaultState);
            defaultState.valueExpr[phiNode] = incomingExpression;
        }
        exploreLoopPaths(loopContext, defaultSuccessorBlock, std::move(defaultState), visitedBlocks, explorationResult);
        return;
    }
    addUnsupported(loopContext, "unsupported terminator in loop block: " + getBasicBlockName(currentBlock));
}



std::vector<Variable> extractVariables(llvm::Loop* loop, const std::string& loopId) {
    std::vector<Variable> trackedVariables;
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
        Variable trackedVariable;
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
        Variable trackedVariable;
        trackedVariable.slot = &globalVariable;
        trackedVariable.name = loopId + "_v" + std::to_string(nextVariableIndex++);
        trackedVariable.llvmName = convertLLVMValueToString(&globalVariable);
        trackedVariable.type = getIntegerTypeName(globalVariable.getValueType());
        trackedVariables.push_back(std::move(trackedVariable));
    }
    return trackedVariables;
}



void bindPhiNodesForEntryEdge(LoopContext& loopContext, llvm::BasicBlock* predecessorBlock, llvm::BasicBlock* successorBlock, SymbolicState& stateAtSuccessor) {
    for (llvm::Instruction& instruction : *successorBlock) {
        auto* phiNode = dyn_cast<llvm::PHINode>(&instruction);
        if (!phiNode) {
            break;
        }
        llvm::Value* incomingValue = phiNode->getIncomingValueForBlock(predecessorBlock);
        Expression incomingExpression = evalValue(incomingValue, loopContext, stateAtSuccessor);
        stateAtSuccessor.valueExpr[phiNode] = incomingExpression;
    }
}

void appendStateEqualitiesAtEntry(LoopContext& loopContext,
                                  const SymbolicState& stateAtHeader,
                                  std::vector<Expression>& entryPathClause) {
    for (const auto& trackedVariable : loopContext.variables) {
        auto memoryExpressionIt = stateAtHeader.memoryExpr.find(trackedVariable.slot);
        if (memoryExpressionIt == stateAtHeader.memoryExpr.end()) {
            continue;
        }
        if (exprEq(memoryExpressionIt->second, atom(trackedVariable.name))) {
            continue;
        }
        entryPathClause.push_back(mkBin("=", atom(trackedVariable.name), memoryExpressionIt->second));
    }
}

void exploreEntryPaths(LoopContext& loopContext,
                       llvm::BasicBlock* currentBlock,
                       SymbolicState stateAtCurrentBlock,
                       std::set<const llvm::BasicBlock*> visitedEntryBlocks,
                       const std::vector<Expression>& baseConjuncts,
                       std::vector<Expression>& entryPathClauses) {
    llvm::BasicBlock* loopHeaderBlock = loopContext.loop->getHeader();
    if (!currentBlock) {
        addUnsupported(loopContext, "null block while extracting entry");
        return;
    }
    if (currentBlock == loopHeaderBlock) {
        std::vector<Expression> entryPathClause = baseConjuncts;
        entryPathClause.insert(entryPathClause.end(), stateAtCurrentBlock.pathConditions.begin(), stateAtCurrentBlock.pathConditions.end());
        appendStateEqualitiesAtEntry(loopContext, stateAtCurrentBlock, entryPathClause);
        entryPathClauses.push_back(mkAnd(entryPathClause));
        return;
    }
    if (loopContext.loop->contains(currentBlock)) {
        addUnsupported(loopContext, "entered target loop before reaching its header while extracting entry: " + getBasicBlockName(currentBlock));
        return;
    }
    if (visitedEntryBlocks.count(currentBlock)) {
        addUnsupported(loopContext, "cycle before loop header while extracting entry: " + getBasicBlockName(currentBlock));
        return;
    }
    visitedEntryBlocks.insert(currentBlock);
    executeNonTerminatorInstructions(currentBlock, loopContext, stateAtCurrentBlock);
    llvm::Instruction* terminator = currentBlock->getTerminator();
    if (!terminator) {
        addUnsupported(loopContext, "block without terminator while extracting entry: " + getBasicBlockName(currentBlock));
        return;
    }
    if (isa<llvm::ReturnInst>(terminator) || isa<llvm::UnreachableInst>(terminator)) {
        return;
    }
    if (auto* branchInstruction = dyn_cast<llvm::BranchInst>(terminator)) {
        unsigned successorCount = branchInstruction->isConditional() ? 2 : 1;
        Expression branchCondition;
        if (branchInstruction->isConditional()) {
            branchCondition = evalValue(branchInstruction->getCondition(), loopContext, stateAtCurrentBlock);
        }
        for (unsigned successorIndex = 0; successorIndex < successorCount; ++successorIndex) {
            llvm::BasicBlock* successorBlock = branchInstruction->getSuccessor(successorIndex);
            SymbolicState stateAtSuccessor = stateAtCurrentBlock;
            Expression edgeCondition = !branchInstruction->isConditional()
                ? atom("true")
                : (successorIndex == 0 ? branchCondition : mkNot(branchCondition));
            if (!addPathConstraint(stateAtSuccessor, edgeCondition)) {
                continue;
            }
            bindPhiNodesForEntryEdge(loopContext, currentBlock, successorBlock, stateAtSuccessor);
            exploreEntryPaths(loopContext, successorBlock, stateAtSuccessor, visitedEntryBlocks, baseConjuncts, entryPathClauses);
        }
        return;
    }
    if (auto* switchInstruction = dyn_cast<llvm::SwitchInst>(terminator)) {
        Expression switchCondition = evalValue(switchInstruction->getCondition(), loopContext, stateAtCurrentBlock);
        for (auto switchCase : switchInstruction->cases()) {
            SymbolicState caseState = stateAtCurrentBlock;
            Expression caseValue = atom(intConstToString(switchCase.getCaseValue()));
            if (!addPathConstraint(caseState, mkBin("=", switchCondition, caseValue))) {
                continue;
            }
            llvm::BasicBlock* caseSuccessorBlock = switchCase.getCaseSuccessor();
            bindPhiNodesForEntryEdge(loopContext, currentBlock, caseSuccessorBlock, caseState);
            exploreEntryPaths(loopContext, caseSuccessorBlock, caseState, visitedEntryBlocks, baseConjuncts, entryPathClauses);
        }
        SymbolicState defaultCaseState = stateAtCurrentBlock;
        for (auto switchCase : switchInstruction->cases()) {
            Expression caseValue = atom(intConstToString(switchCase.getCaseValue()));
            if (!addPathConstraint(defaultCaseState, mkNot(mkBin("=", switchCondition, caseValue)))) {
                return;
            }
        }
        llvm::BasicBlock* defaultSuccessorBlock = switchInstruction->getDefaultDest();
        bindPhiNodesForEntryEdge(loopContext, currentBlock, defaultSuccessorBlock, defaultCaseState);
        exploreEntryPaths(loopContext, defaultSuccessorBlock, defaultCaseState, visitedEntryBlocks, baseConjuncts, entryPathClauses);
        return;
    }
    addUnsupported(loopContext, "unsupported terminator before loop header while extracting entry: " + getBasicBlockName(currentBlock));
}

SymbolicState createFunctionEntryState(LoopContext& loopContext) {
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
}

std::vector<const llvm::PHINode*> getPhiNodesInBlock(const llvm::BasicBlock* block) {
    std::vector<const llvm::PHINode*> phiNodes;
    if (!block) {
        return phiNodes;
    }

    for (const llvm::Instruction& instruction : *block) {
        const auto* phiNode = dyn_cast<llvm::PHINode>(&instruction);
        if (!phiNode) {
            break;
        }
        phiNodes.push_back(phiNode);
    }

    return phiNodes;
}

SymbolicState createStateFromVariableNames(const std::vector<Variable>& variables,
                                           const std::vector<std::string>& namesForSlots) {
    SymbolicState state;
    for (size_t variableIndex = 0; variableIndex < variables.size(); ++variableIndex) {
        const Variable& variable = variables[variableIndex];
        std::string name = variableIndex < namesForSlots.size() ? namesForSlots[variableIndex] : variable.name;
        state.valueExpr[variable.slot] = atom(name);
        state.memoryExpr[variable.slot] = atom(name);
    }
    return state;
}

SymbolicState createStateFromBlockStateNames(LoopContext& loopContext,
                                             llvm::BasicBlock* block,
                                             const std::vector<std::string>& namesForBlockState) {
    SymbolicState state = createStateFromVariableNames(loopContext.variables, namesForBlockState);
    const size_t variableCount = loopContext.variables.size();
    std::vector<const llvm::PHINode*> phiNodes = getPhiNodesInBlock(block);

    for (size_t phiIndex = 0; phiIndex < phiNodes.size(); ++phiIndex) {
        const size_t nameIndex = variableCount + phiIndex;
        if (nameIndex < namesForBlockState.size()) {
            state.valueExpr[phiNodes[phiIndex]] = atom(namesForBlockState[nameIndex]);
        }
    }

    return state;
}

std::vector<std::string> getVariableNamesForLoop(llvm::Loop* loop) {
    if (!loop) {
        return {};
    }
    const std::string loopId = getLoopId(loop);
    std::vector<Variable> variables = extractVariables(loop, loopId);
    std::vector<std::string> names;
    for (const auto& variable : variables) {
        names.push_back(variable.name);
    }
    return names;
}

std::vector<std::string> getOutVariableNamesForLoop(llvm::Loop* loop) {
    if (!loop) {
        return {};
    }
    const std::string loopId = getLoopId(loop);
    std::vector<Variable> variables = extractVariables(loop, loopId);
    return getOutVariableNames(variables);
}

Expression extractFunctionEntryExpression(LoopContext& loopContext) {
    SymbolicState stateAtFunctionEntry = createFunctionEntryState(loopContext);
    std::vector<Expression> entryPathClauses;
    exploreEntryPaths(loopContext, &loopContext.function->getEntryBlock(), stateAtFunctionEntry, {}, {}, entryPathClauses);
    if (entryPathClauses.empty()) {
        addUnsupported(loopContext, "entry is false because no function-entry path to the loop header was summarized");
        return atom("false");
    }
    return mkOr(entryPathClauses);
}

Expression extractNestedEntryExpression(LoopContext& loopContext, llvm::Loop* parentLoop) {
    const std::string parentLoopId = getLoopId(parentLoop);
    std::vector<Variable> parentVariables = extractVariables(parentLoop, parentLoopId);
    std::vector<std::string> parentCurrentNames = getCurrentVariableNames(parentVariables);

    std::vector<Expression> baseConjuncts;
    baseConjuncts.push_back(mkRelationCallExpression(makeRelationName(parentLoopId, "reach"), atomArgumentsFromNames(parentCurrentNames)));

    SymbolicState stateAtParentHeader = createStateFromVariableNames(loopContext.variables, parentCurrentNames);
    std::vector<Expression> entryPathClauses;
    exploreEntryPaths(loopContext, parentLoop->getHeader(), stateAtParentHeader, {}, baseConjuncts, entryPathClauses);
    if (entryPathClauses.empty()) {
        addUnsupported(loopContext, "nested entry is false because no parent-reach path to the child loop header was summarized");
        return atom("false");
    }
    return mkExistsExpression(parentCurrentNames, mkOr(entryPathClauses));
}

Expression extractSequentialEntryExpression(LoopContext& loopContext, llvm::Loop* previousLoop) {
    const std::string previousLoopId = getLoopId(previousLoop);
    std::vector<Variable> previousVariables = extractVariables(previousLoop, previousLoopId);
    std::vector<std::string> previousOutNames = getOutVariableNames(previousVariables);

    std::vector<Expression> entryPathClauses;
    for (const auto& exitEdge : getUniqueExitEdges(previousLoop)) {
        llvm::BasicBlock* exitSourceBlock = exitEdge.first;
        llvm::BasicBlock* exitTargetBlock = exitEdge.second;
        if (!exitSourceBlock || !exitTargetBlock) {
            continue;
        }
        if (isSemanticReturnExitEdge(previousLoop,
                                     exitSourceBlock,
                                     exitTargetBlock)) {
            continue;
        }

        std::vector<Expression> exitArguments;
        exitArguments.push_back(atom(makeExitEdgeId(previousLoopId,
                                                    getBasicBlockName(exitSourceBlock),
                                                    getBasicBlockName(exitTargetBlock))));
        std::vector<Expression> outArguments = atomArgumentsFromNames(previousOutNames);
        exitArguments.insert(exitArguments.end(), outArguments.begin(), outArguments.end());

        std::vector<Expression> baseConjuncts;
        baseConjuncts.push_back(mkRelationCallExpression(makeRelationName(previousLoopId, "exit"),
                                                         exitArguments));
        SymbolicState stateAtPreviousExit = createStateFromVariableNames(loopContext.variables, previousOutNames);
        exploreEntryPaths(loopContext,
                          exitTargetBlock,
                          stateAtPreviousExit,
                          {},
                          baseConjuncts,
                          entryPathClauses);
    }

    if (entryPathClauses.empty()) {
        addUnsupported(loopContext, "sequential entry is false because no previous-loop-exit path to the loop header was summarized");
        return atom("false");
    }
    return mkExistsExpression(previousOutNames, mkOr(entryPathClauses));
}

Expression extractEntryExpression(LoopContext& loopContext, const std::vector<llvm::Loop*>& allLoops) {
    if (llvm::Loop* previousSequentialLoop = getPreviousSequentialLoop(loopContext.loop, allLoops)) {
        return extractSequentialEntryExpression(loopContext, previousSequentialLoop);
    }
    if (llvm::Loop* parentLoop = loopContext.loop->getParentLoop()) {
        return extractNestedEntryExpression(loopContext, parentLoop);
    }
    return extractFunctionEntryExpression(loopContext);
}



bool isDnfFormulaTautology(const std::vector<std::vector<Expression>>& dnfClauses) {
    for (const auto& clause : dnfClauses) {
        if (clause.empty()) {
            return true;
        }
    }
    std::set<std::string> atomicConditionKeys;
    for (const auto& clause : dnfClauses) {
        for (const auto& literal : clause) {
            if (literal.isCompound && literal.head == "not" && literal.arguments.size() == 1) {
                atomicConditionKeys.insert(exprKey(literal.arguments[0]));
            }
            else {
                atomicConditionKeys.insert(exprKey(literal));
            }
        }
    }
    if (atomicConditionKeys.size() > 20) {
        return false;
    }
    std::map<std::string, unsigned> atomicConditionToIndex;
    unsigned nextAtomicConditionIndex = 0;
    for (const auto& atomicConditionKey : atomicConditionKeys) {
        atomicConditionToIndex[atomicConditionKey] = nextAtomicConditionIndex++;
    }
    std::uint64_t assignmentCount = 1ULL << atomicConditionKeys.size();
    for (std::uint64_t assignmentMask = 0; assignmentMask < assignmentCount; ++assignmentMask) {
        bool formulaIsTrueUnderAssignment = false;
        for (const auto& clause : dnfClauses) {
            bool clauseIsTrueUnderAssignment = true;
            for (const auto& literal : clause) {
                Expression atomicCondition;
                if (literal.isCompound && literal.head == "not" && literal.arguments.size() == 1) {
                    atomicCondition = literal.arguments[0];
                }
                else {
                    atomicCondition = literal;
                }
                std::string atomicConditionKey = exprKey(atomicCondition);
                auto atomicConditionIt = atomicConditionToIndex.find(atomicConditionKey);
                bool literalIsTrue = false;
                if (atomicConditionIt != atomicConditionToIndex.end()) {
                    bool atomicConditionValue = ((assignmentMask >> atomicConditionIt->second) & 1ULL) != 0ULL;
                    literalIsTrue = (literal.isCompound && literal.head == "not" && literal.arguments.size() == 1) ? !atomicConditionValue : atomicConditionValue;
                }
                if (!literalIsTrue) {
                    clauseIsTrueUnderAssignment = false;
                    break;
                }
            }
            if (clauseIsTrueUnderAssignment) {
                formulaIsTrueUnderAssignment = true;
                break;
            }
        }
        if (!formulaIsTrueUnderAssignment) {
            return false;
        }
    }
    return true;
}

Expression extractGuard(const std::vector<RawTransition>& rawTransitions) {
    const std::string childPlaceholderPrefix = "<l";
    auto expressionContainsText = [&](auto&& self, const Expression& expression, const std::string& targetText) -> bool {
        if (expression.head.find(targetText) != std::string::npos) {
            return true;
        }
        for (const auto& argument : expression.arguments) {
            if (self(self, argument, targetText)) {
                return true;
            }
        }
        return false;
    };
    std::vector<std::vector<Expression>> loopBackDnfClauses;
    for (const auto& rawTransition : rawTransitions) {
        if (rawTransition.kind != "loop_back") {
            continue;
        }
        std::vector<Expression> filteredPathLiterals;
        for (const auto& literal : rawTransition.literals) {
            if (!expressionContainsText(expressionContainsText, literal, childPlaceholderPrefix)) {
                filteredPathLiterals.push_back(literal);
            }
        }
        loopBackDnfClauses.push_back(std::move(filteredPathLiterals));
    }
    if (loopBackDnfClauses.empty()) {
        return atom("false");
    }
    std::vector<Expression> commonLiterals;
    for (const auto& literal : loopBackDnfClauses.front()) {
        bool appearsInEveryClause = true;
        for (size_t clauseIndex = 1; clauseIndex < loopBackDnfClauses.size() && appearsInEveryClause; ++clauseIndex) {
            bool foundInCurrentClause = false;
            for (const auto& otherLiteral : loopBackDnfClauses[clauseIndex]) {
                if (exprEq(otherLiteral, literal)) {
                    foundInCurrentClause = true;
                    break;
                }
            }
            if (!foundInCurrentClause) {
                appearsInEveryClause = false;
            }
        }
        if (appearsInEveryClause) {
            commonLiterals.push_back(literal);
        }
    }
    std::vector<std::vector<Expression>> residualClauses;
    residualClauses.reserve(loopBackDnfClauses.size());
    for (const auto& clause : loopBackDnfClauses) {
        std::vector<Expression> residualClause;
        for (const auto& literal : clause) {
            bool isCommonLiteral = false;
            for (const auto& commonLiteral : commonLiterals) {
                if (exprEq(literal, commonLiteral)) {
                    isCommonLiteral = true;
                    break;
                }
            }
            if (!isCommonLiteral) {
                residualClause.push_back(literal);
            }
        }
        residualClauses.push_back(std::move(residualClause));
    }
    if (isDnfFormulaTautology(residualClauses)) {
        return mkAnd(commonLiterals);
    }
    std::vector<Expression> residualConjuncts;
    for (const auto& residualClause : residualClauses) {
        residualConjuncts.push_back(mkAnd(residualClause));
    }
    Expression residualDisjunction = mkOr(residualConjuncts);
    if (commonLiterals.empty()) {
        return residualDisjunction;
    }
    std::vector<Expression> guardConjuncts = commonLiterals;
    guardConjuncts.push_back(residualDisjunction);
    return mkAnd(guardConjuncts);
}



std::vector<Expression> atomArgumentsFromNames(const std::vector<std::string>& names) {
    std::vector<Expression> arguments;
    arguments.reserve(names.size());
    for (const auto& name : names) {
        arguments.push_back(atom(name));
    }
    return arguments;
}

std::string childVariableNameFromIndex(const std::string& childLoopId, size_t variableIndex) {
    return childLoopId + "_v" + std::to_string(variableIndex + 1);
}

std::string childInputLocalName(const std::string& parentLoopId, const std::string& childLoopId, size_t callIndex, size_t variableIndex) {
    return parentLoopId + "_call" + std::to_string(callIndex) + "_" + childVariableNameFromIndex(childLoopId, variableIndex) + "_in";
}

std::string childOutputLocalName(const std::string& parentLoopId,
                                 const std::string& childLoopId,
                                 size_t callIndex,
                                 size_t variableIndex) {
    (void)parentLoopId;
    (void)callIndex;
    return makeOutVariableName(childVariableNameFromIndex(childLoopId, variableIndex));
}

std::vector<Transition> extractTransitions(const std::vector<RawTransition>& rawTransitions,
                                                   const std::string& parentLoopId,
                                                   const std::vector<Variable>& variables,
                                                   std::vector<ChildComposition>& childCompositions,
                                                   std::vector<std::string>& unsupportedMessages,
                                                   const std::string& wantedKind) {
    std::map<std::string, ChildComposition> childCompositionMap;
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

    auto replaceAtomInExpression = [&](auto&& replaceAtomRecursive,
                                       const Expression& expression,
                                       const std::string& oldAtomName,
                                       const std::string& newAtomName) -> Expression {
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

        const std::vector<ChildCall> childCalls = rawTransition.childCalls.empty() && rawTransition.hasChildComposition
            ? std::vector<ChildCall>{{rawTransition.childId, "", rawTransition.childExitBlockName, false, rawTransition.childEntryState}}
            : rawTransition.childCalls;

        for (size_t childCallIndex = 0; childCallIndex < childCalls.size(); ++childCallIndex) {
            const ChildCall& childCall = childCalls[childCallIndex];
            const size_t callIndex = childCallIndex + 1;

            if (childCall.isReturn) {
                addUnsupported(unsupportedMessages,
                               "internal error: child return call appeared in non-return transition for child loop: " + childCall.childId);
                continue;
            }

            const std::string childExitBlockName = childCall.exitBlockName.empty()
                ? "unknown_exit"
                : childCall.exitBlockName;

            ChildComposition& childComposition = childCompositionMap[childCall.childId + "@" + childExitBlockName + "@call" + std::to_string(callIndex)];
            if (childComposition.childId.empty()) {
                childComposition.childId = childCall.childId;
                childComposition.exitBlockName = childExitBlockName;
                childComposition.entryState = childCall.entryState;
            }

            std::vector<std::string> childInputNames;
            std::vector<std::string> childOutputNames;
            for (size_t variableIndex = 0; variableIndex < variables.size(); ++variableIndex) {
                const Variable& variable = variables[variableIndex];
                const std::string inputName = childInputLocalName(parentLoopId, childCall.childId, callIndex, variableIndex);
                const std::string outputName = childOutputLocalName(parentLoopId, childCall.childId, callIndex, variableIndex);

                childInputNames.push_back(inputName);
                childOutputNames.push_back(outputName);
                childLocalVariables.push_back(inputName);
                childLocalVariables.push_back(outputName);

                auto entryStateIt = childCall.entryState.find(variable.name);
                Expression entryValue = entryStateIt != childCall.entryState.end()
                    ? entryStateIt->second
                    : atom(variable.name);
                childSummaryConjuncts.push_back(mkBin("=", atom(inputName), entryValue));

                childPlaceholderToOutputName[childValuePlaceholder(childCall.childId, callIndex, variable.name)] = outputName;
                if (childCalls.size() == 1) {
                    childPlaceholderToOutputName["<" + childCall.childId + ":" + variable.name + ">"] = outputName;
                }
                childComposition.exitState[variable.name] = atom(outputName);
            }

            std::vector<Expression> entry2ExitArguments;
            for (const auto& inputName : childInputNames) {
                entry2ExitArguments.push_back(atom(inputName));
            }
            entry2ExitArguments.push_back(
                atom(makeExitEdgeId(childCall.childId,
                                    childCall.exitSourceBlockName.empty()
                                        ? "unknown_source"
                                        : childCall.exitSourceBlockName,
                                    childExitBlockName)));
            for (const auto& outputName : childOutputNames) {
                entry2ExitArguments.push_back(atom(outputName));
            }
            childSummaryConjuncts.push_back(
                mkRelationCallExpression(
                    makeEntry2ExitRelationName(childCall.childId),
                    entry2ExitArguments));
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
                if (exprEq(pathLiteral, atom(childPcPlaceholder(childCall.childId, callIndex))) ||
                    exprEq(pathLiteral, atom(childReturnPcPlaceholder(childCall.childId, callIndex))) ||
                    (childCalls.size() == 1 && exprEq(pathLiteral, atom("<" + childCall.childId + ":pc>")))) {
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
                addUnsupported(unsupportedMessages,
                               "child placeholder remained after e2e composition in path literal: " + exprKey(rewrittenLiteral));
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
                addUnsupported(unsupportedMessages,
                               "child placeholder remained after e2e composition in update: " + exprKey(rewrittenRightHandSide));
            }
            normalizedTransition.updates[update.first] = rewrittenRightHandSide;
        }
        normalizedTransitions.push_back(std::move(normalizedTransition));
    }

    for (auto& childCompositionEntry : childCompositionMap) {
        childCompositions.push_back(childCompositionEntry.second);
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



Expression extractReturnStepExpression(const std::vector<RawTransition>& rawTransitions,
                                           const std::string& parentLoopId,
                                           const std::vector<Variable>& variables,
                                           std::vector<std::string>& unsupportedMessages) {
    std::vector<Expression> returnClauses;

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

    auto replaceAtomInExpression = [&](auto&& replaceAtomRecursive,
                                       const Expression& expression,
                                       const std::string& oldAtomName,
                                       const std::string& newAtomName) -> Expression {
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
        if (rawTransition.kind != "return") {
            continue;
        }

        const std::vector<ChildCall> childCalls = rawTransition.childCalls.empty() && rawTransition.hasChildComposition
            ? std::vector<ChildCall>{{rawTransition.childId, "", rawTransition.childExitBlockName, rawTransition.childExitBlockName.empty(), rawTransition.childEntryState}}
            : rawTransition.childCalls;

        std::vector<Expression> conjuncts;
        std::vector<std::string> localVariables;
        std::map<std::string, std::string> childPlaceholderToOutputName;

        for (size_t childCallIndex = 0; childCallIndex < childCalls.size(); ++childCallIndex) {
            const ChildCall& childCall = childCalls[childCallIndex];
            const size_t callIndex = childCallIndex + 1;

            std::vector<std::string> childInputNames;
            std::vector<std::string> childOutputNames;
            for (size_t variableIndex = 0; variableIndex < variables.size(); ++variableIndex) {
                const Variable& variable = variables[variableIndex];
                const std::string inputName = childInputLocalName(parentLoopId, childCall.childId, callIndex, variableIndex);
                childInputNames.push_back(inputName);
                localVariables.push_back(inputName);

                auto entryStateIt = childCall.entryState.find(variable.name);
                Expression entryValue = entryStateIt != childCall.entryState.end()
                    ? entryStateIt->second
                    : atom(variable.name);
                conjuncts.push_back(mkBin("=", atom(inputName), entryValue));

                if (!childCall.isReturn) {
                    const std::string outputName = childOutputLocalName(parentLoopId, childCall.childId, callIndex, variableIndex);
                    childOutputNames.push_back(outputName);
                    localVariables.push_back(outputName);
                    childPlaceholderToOutputName[childValuePlaceholder(childCall.childId, callIndex, variable.name)] = outputName;
                    if (childCalls.size() == 1) {
                        childPlaceholderToOutputName["<" + childCall.childId + ":" + variable.name + ">"] = outputName;
                    }
                }
            }

            if (childCall.isReturn) {
                std::vector<Expression> e2ReturnArguments;
                for (const auto& inputName : childInputNames) {
                    e2ReturnArguments.push_back(atom(inputName));
                }
                conjuncts.push_back(
                    mkRelationCallExpression(
                        makeEntry2ReturnRelationName(childCall.childId),
                        e2ReturnArguments));
            }
            else {
                std::vector<Expression> entry2ExitArguments;
                for (const auto& inputName : childInputNames) {
                    entry2ExitArguments.push_back(atom(inputName));
                }
                const std::string childExitBlockName =
                    childCall.exitBlockName.empty()
                        ? "unknown_exit"
                        : childCall.exitBlockName;
                entry2ExitArguments.push_back(
                    atom(makeExitEdgeId(
                        childCall.childId,
                        childCall.exitSourceBlockName.empty()
                            ? "unknown_source"
                            : childCall.exitSourceBlockName,
                        childExitBlockName)));
                for (const auto& outputName : childOutputNames) {
                    entry2ExitArguments.push_back(atom(outputName));
                }
                conjuncts.push_back(
                    mkRelationCallExpression(
                        makeEntry2ExitRelationName(childCall.childId),
                        entry2ExitArguments));
            }
        }

        for (const auto& pathLiteral : rawTransition.literals) {
            bool skipLiteral = false;
            for (size_t childCallIndex = 0; childCallIndex < childCalls.size(); ++childCallIndex) {
                const ChildCall& childCall = childCalls[childCallIndex];
                const size_t callIndex = childCallIndex + 1;
                if (exprEq(pathLiteral, atom(childPcPlaceholder(childCall.childId, callIndex))) ||
                    exprEq(pathLiteral, atom(childReturnPcPlaceholder(childCall.childId, callIndex))) ||
                    (childCalls.size() == 1 &&
                     (exprEq(pathLiteral, atom("<" + childCall.childId + ":pc>")) ||
                      exprEq(pathLiteral, atom("<" + childCall.childId + ":return_pc>"))))) {
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
                addUnsupported(unsupportedMessages,
                               "child placeholder remained after e2return composition in return path literal: " + exprKey(rewrittenLiteral));
            }
            conjuncts.push_back(rewrittenLiteral);
        }

        returnClauses.push_back(mkExistsExpression(localVariables, mkAnd(conjuncts)));
    }

    return mkOr(returnClauses);
}



LoopBundle getLoopBundle(llvm::Function& loopFunction, llvm::Loop* targetLoop, const std::vector<llvm::Loop*>& allLoops) {
    LoopBundle loopBundle;
    LoopContext loopContext;

    loopContext.loop = targetLoop;
    loopContext.function = &loopFunction;
    const std::string targetLoopId = getLoopId(targetLoop);
    loopContext.variables = extractVariables(targetLoop, targetLoopId);
    for (const auto& variable : loopContext.variables) {
        loopContext.variableNames[variable.slot] = variable.name;
    }

    loopBundle.variables = loopContext.variables;
    if (loopContext.variables.empty()) {
        loopBundle.entry = atom("false");
        loopBundle.guard = atom("false");
        loopBundle.returnStep = atom("false");
        loopBundle.unsupported = loopContext.unsupported;
        return loopBundle;
    }

    loopBundle.entry = extractEntryExpression(loopContext, allLoops);

    SymbolicState initialLoopState;
    for (const auto& variable : loopContext.variables) {
        initialLoopState.valueExpr[variable.slot] = atom(variable.name);
        initialLoopState.memoryExpr[variable.slot] = atom(variable.name);
    }

    ExplorationResult explorationResult;
    exploreLoopPaths(loopContext, targetLoop->getHeader(), initialLoopState, {}, explorationResult);

    loopBundle.guard = extractGuard(explorationResult.RawTransitions);
    loopBundle.transitionSteps = extractTransitions(explorationResult.RawTransitions, targetLoopId, loopContext.variables, loopBundle.childCompositions, loopContext.unsupported, "loop_back");
    loopBundle.exitSteps = extractTransitions(explorationResult.RawTransitions, targetLoopId, loopContext.variables, loopBundle.childCompositions, loopContext.unsupported, "exit");
    loopBundle.returnStep = extractReturnStepExpression(explorationResult.RawTransitions, targetLoopId, loopContext.variables, loopContext.unsupported);
    loopBundle.unsupported = loopContext.unsupported;

    return loopBundle;
}



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

nlohmann::ordered_json convertStringsToJson(const std::vector<std::string>& S) {
    nlohmann::ordered_json stringsJson = nlohmann::ordered_json::array();
    for (const auto& string : S) {
        stringsJson.push_back(string);
    }
    return stringsJson;
}

nlohmann::ordered_json convertVariablesToJson(const std::vector<Variable>& variables) {
    nlohmann::ordered_json variablesJson = nlohmann::ordered_json::array();
    for (const auto& variable : variables) {
        nlohmann::ordered_json variableJson;
        variableJson["name"] = variable.name;
        variableJson["type"] = variable.type;
        variableJson["llvm_slot"] = variable.llvmName;
        variablesJson.push_back(std::move(variableJson));
    }
    return variablesJson;
}

std::vector<std::string> getCurrentVariableNames(const std::vector<Variable>& variables) {
    std::vector<std::string> names;
    for (const auto& variable : variables) {
        names.push_back(variable.name);
    }
    return names;
}

std::vector<std::string> getNextVariableNames(const std::vector<Variable>& variables) {
    std::vector<std::string> names;
    for (const auto& variable : variables) {
        names.push_back(makeNextVariableName(variable.name));
    }
    return names;
}

std::vector<std::string> getPrevVariableNames(const std::vector<Variable>& variables) {
    std::vector<std::string> names;
    for (const auto& variable : variables) {
        names.push_back(makePrevVariableName(variable.name));
    }
    return names;
}

std::vector<std::string> getStepVariableNames(const std::vector<Variable>& variables) {
    std::vector<std::string> names;
    for (const auto& variable : variables) {
        names.push_back(variable.name + "_step");
    }
    return names;
}

std::vector<std::string> getEntryVariableNames(const std::vector<Variable>& variables) {
    std::vector<std::string> names;
    for (const auto& variable : variables) {
        names.push_back(variable.name + "_entry");
    }
    return names;
}

nlohmann::ordered_json makeLocalSymbolsJson(const std::set<std::string>& symbols) {
    if (symbols.empty()) {
        return nlohmann::ordered_json::array();
    }

    nlohmann::ordered_json localSymbolsJson;
    localSymbolsJson["quantifier"] = "exists";
    localSymbolsJson["symbols"] = nlohmann::ordered_json::array();
    for (const auto& symbol : symbols) {
        localSymbolsJson["symbols"].push_back(symbol);
    }
    return localSymbolsJson;
}

nlohmann::ordered_json makeLocalSymbolsJson(const std::vector<std::string>& symbols) {
    if (symbols.empty()) {
        return nlohmann::ordered_json::array();
    }

    nlohmann::ordered_json localSymbolsJson;
    localSymbolsJson["quantifier"] = "exists";
    localSymbolsJson["symbols"] = nlohmann::ordered_json::array();
    for (const auto& symbol : symbols) {
        localSymbolsJson["symbols"].push_back(symbol);
    }
    return localSymbolsJson;
}


std::vector<std::string> getOutVariableNames(const std::vector<Variable>& variables) {
    std::vector<std::string> names;
    for (const auto& variable : variables) {
        names.push_back(makeOutVariableName(variable.name));
    }
    return names;
}

std::vector<std::string> concatenateNames(const std::vector<std::string>& first, const std::vector<std::string>& second) {
    std::vector<std::string> result = first;
    result.insert(result.end(), second.begin(), second.end());
    return result;
}

nlohmann::ordered_json relationCallJson(const std::string& relationName, const std::vector<std::string>& relationArgs) {
    nlohmann::ordered_json call;
    call["rel"] = relationName;
    call["args"] = relationArgs;
    return call;
}

nlohmann::ordered_json andJson(const std::vector<nlohmann::ordered_json>& arguments) {
    if (arguments.empty()) {
        return true;
    }
    if (arguments.size() == 1) {
        return arguments.front();
    }
    nlohmann::ordered_json result;
    result["op"] = "and";
    result["args"] = arguments;
    return result;
}

nlohmann::ordered_json existsJson(const std::vector<std::string>& boundVariables, const nlohmann::ordered_json& body) {
    nlohmann::ordered_json result;
    result["exists"] = boundVariables;
    result["body"] = body;
    return result;
}

nlohmann::ordered_json relationDefinitionJson(const std::string& relationName, const std::vector<std::string>& relationArgs, const Expression& expression) {
    nlohmann::ordered_json relationJson;
    relationJson["name"] = relationName;
    relationJson["args"] = relationArgs;
    relationJson["expr"] = convertExpressionToJson(expression);
    return relationJson;
}


nlohmann::ordered_json orJson(const std::vector<nlohmann::ordered_json>& arguments) {
    if (arguments.empty()) {
        return false;
    }
    if (arguments.size() == 1) {
        return arguments.front();
    }
    nlohmann::ordered_json result;
    result["op"] = "or";
    result["args"] = arguments;
    return result;
}

nlohmann::ordered_json ruleJson(const std::string& headRelation,
                        const std::vector<std::string>& headArguments,
                        const nlohmann::ordered_json& body) {
    return {
        {"head", relationCallJson(headRelation, headArguments)},
        {"body", body}
    };
}

std::vector<std::string> makeIndexedNames(const std::string& prefix, size_t count) {
    std::vector<std::string> names;
    names.reserve(count);
    for (size_t index = 0; index < count; ++index) {
        names.push_back(prefix + "_v" + std::to_string(index + 1));
    }
    return names;
}

std::vector<std::string> makeBlockStateNames(const std::string& loopId,
                                             const std::string& prefix,
                                             const llvm::BasicBlock* block,
                                             size_t count) {
    return makeIndexedNames(loopId + "_" + prefix + "_" + sanitizeRelationSuffixPart(getBasicBlockName(block)), count);
}

std::vector<std::string> makeBlockStateNames(const std::string& loopId,
                                             const std::string& prefix,
                                             const llvm::BasicBlock* block,
                                             LoopContext& loopContext) {
    const size_t variableCount = loopContext.variables.size();
    const size_t phiCount = getPhiNodesInBlock(block).size();
    return makeIndexedNames(loopId + "_" + prefix + "_" + sanitizeRelationSuffixPart(getBasicBlockName(block)),
                            variableCount + phiCount);
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

std::vector<std::pair<llvm::BasicBlock*, Expression>> getGuardedSuccessors(llvm::BasicBlock* block,
                                                                           LoopContext& loopContext,
                                                                           SymbolicState& stateAfterBlock) {
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
        Expression branchCondition = evalValue(branchInstruction->getCondition(), loopContext, stateAfterBlock);
        result.push_back({branchInstruction->getSuccessor(0), branchCondition});
        result.push_back({branchInstruction->getSuccessor(1), mkNot(branchCondition)});
        return result;
    }
    if (auto* switchInstruction = dyn_cast<llvm::SwitchInst>(terminator)) {
        Expression switchCondition = evalValue(switchInstruction->getCondition(), loopContext, stateAfterBlock);
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
}


nlohmann::ordered_json buildBlockTransferBodyFromState(LoopContext& loopContext,
                                               llvm::BasicBlock* sourceBlock,
                                               llvm::BasicBlock* successorBlock,
                                               const SymbolicState& stateAfterSourceBlock,
                                               const std::vector<std::string>& inputNames,
                                               const std::vector<std::string>& outputNames,
                                               const Expression& edgeCondition,
                                               const nlohmann::ordered_json& sourceReachBody) {
    std::vector<nlohmann::ordered_json> conjuncts;
    conjuncts.push_back(sourceReachBody);
    conjuncts.push_back(convertExpressionToJson(edgeCondition));

    SymbolicState stateAtSuccessor = stateAfterSourceBlock;
    if (successorBlock) {
        bindPhiNodesForEntryEdge(loopContext, sourceBlock, successorBlock, stateAtSuccessor);
    }

    const size_t variableCount = loopContext.variables.size();
    for (size_t variableIndex = 0; variableIndex < variableCount && variableIndex < outputNames.size(); ++variableIndex) {
        const Variable& variable = loopContext.variables[variableIndex];
        Expression valueAtSuccessor = variableIndex < inputNames.size() ? atom(inputNames[variableIndex]) : atom(variable.name);
        auto memoryIt = stateAtSuccessor.memoryExpr.find(variable.slot);
        if (memoryIt != stateAtSuccessor.memoryExpr.end()) {
            valueAtSuccessor = memoryIt->second;
        }
        conjuncts.push_back(convertExpressionToJson(mkBin("=", atom(outputNames[variableIndex]), valueAtSuccessor)));
    }

    if (successorBlock && outputNames.size() > variableCount) {
        std::vector<const llvm::PHINode*> successorPhiNodes = getPhiNodesInBlock(successorBlock);
        for (size_t phiIndex = 0; phiIndex < successorPhiNodes.size(); ++phiIndex) {
            const size_t outputIndex = variableCount + phiIndex;
            if (outputIndex >= outputNames.size()) {
                break;
            }
            auto phiExpressionIt = stateAtSuccessor.valueExpr.find(successorPhiNodes[phiIndex]);
            Expression phiExpression = (phiExpressionIt != stateAtSuccessor.valueExpr.end())
                ? phiExpressionIt->second
                : atom("<missing-phi>");
            if (phiExpression.head == "<missing-phi>") {
                addUnsupported(loopContext, "missing predecessor-sensitive phi value for " + convertLLVMValueToString(successorPhiNodes[phiIndex]));
            }
            conjuncts.push_back(convertExpressionToJson(mkBin("=", atom(outputNames[outputIndex]), phiExpression)));
        }
    }

    return andJson(conjuncts);
}

// Legacy wrapper kept only for old path-enumeration helpers.  The CFG-to-Horn
// generator below uses buildBlockTransferBodyFromState so a block is symbolically
// executed exactly once per outgoing CFG edge.
nlohmann::ordered_json buildBlockTransferBody(LoopContext& loopContext,
                                      llvm::BasicBlock* sourceBlock,
                                      llvm::BasicBlock* successorBlock,
                                      const std::vector<std::string>& inputNames,
                                      const std::vector<std::string>& outputNames,
                                      const Expression& edgeCondition,
                                      const nlohmann::ordered_json& sourceReachBody) {
    SymbolicState stateAfterSourceBlock = createStateFromBlockStateNames(loopContext, sourceBlock, inputNames);
    executeNonTerminatorInstructions(sourceBlock, loopContext, stateAfterSourceBlock);
    return buildBlockTransferBodyFromState(loopContext,
                                           sourceBlock,
                                           successorBlock,
                                           stateAfterSourceBlock,
                                           inputNames,
                                           outputNames,
                                           edgeCondition,
                                           sourceReachBody);
}

bool isInsideDirectChildLoop(const llvm::Loop* parentLoop, const llvm::BasicBlock* block) {
    if (!parentLoop || !block) {
        return false;
    }
    for (llvm::Loop* childLoop : parentLoop->getSubLoops()) {
        if (childLoop && childLoop->contains(block)) {
            return true;
        }
    }
    return false;
}


bool isAncestorLoopOf(const llvm::Loop* possibleAncestor, const llvm::Loop* loop) {
    if (!possibleAncestor || !loop) {
        return false;
    }
    for (const llvm::Loop* parent = loop->getParentLoop(); parent; parent = parent->getParentLoop()) {
        if (parent == possibleAncestor) {
            return true;
        }
    }
    return false;
}

bool loopsShareImmediateParent(const llvm::Loop* leftLoop, const llvm::Loop* rightLoop) {
    return leftLoop && rightLoop && leftLoop->getParentLoop() == rightLoop->getParentLoop();
}

bool blockIsInsideDisallowedEntryLoop(LoopContext& loopContext,
                                      const std::vector<llvm::Loop*>& allLoops,
                                      llvm::BasicBlock* block) {
    if (!loopContext.loop || !block) {
        return false;
    }

    for (llvm::Loop* otherLoop : allLoops) {
        if (!otherLoop || otherLoop == loopContext.loop) {
            continue;
        }

        // Ancestors of the target loop are allowed entry regions for nested loops.
        if (isAncestorLoopOf(otherLoop, loopContext.loop)) {
            continue;
        }

        if (otherLoop->contains(block)) {
            return true;
        }
    }

    return false;
}

bool isAllowedEntryCFGBlock(LoopContext& loopContext,
                            llvm::Loop* parentLoop,
                            const std::vector<llvm::Loop*>& allLoops,
                            llvm::BasicBlock* block) {
    if (!block || !loopContext.loop) {
        return false;
    }

    llvm::BasicBlock* targetHeader = loopContext.loop->getHeader();

    if (parentLoop) {
        if (!parentLoop->contains(block)) {
            return false;
        }
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
}

bool isAllowedEntryCFGEdge(LoopContext& loopContext,
                           llvm::Loop* parentLoop,
                           const std::vector<llvm::Loop*>& allLoops,
                           llvm::BasicBlock* sourceBlock,
                           llvm::BasicBlock* successorBlock) {
    if (!sourceBlock || !successorBlock) {
        return false;
    }
    if (!isAllowedEntryCFGBlock(loopContext, parentLoop, allLoops, successorBlock)) {
        return false;
    }

    // For a nested loop, compute the entry from one parent-iteration prefix:
    // parent reach -> child header.  Do not wrap around the parent backedge.
    if (parentLoop && successorBlock == parentLoop->getHeader() && sourceBlock != parentLoop->getHeader()) {
        return false;
    }

    return true;
}

std::vector<llvm::Loop*> getCFGPreviousSequentialLoops(llvm::Loop* targetLoop,
                                                       const std::vector<llvm::Loop*>& allLoops) {
    std::vector<llvm::Loop*> previousLoops;
    if (!targetLoop || !targetLoop->getHeader()) {
        return previousLoops;
    }

    for (llvm::Loop* candidateLoop : allLoops) {
        if (!candidateLoop || candidateLoop == targetLoop) {
            continue;
        }
        if (!loopsShareImmediateParent(candidateLoop, targetLoop)) {
            continue;
        }

        bool reachesTargetHeader = false;
        for (llvm::BasicBlock* exitBlock : getUniqueExitBlocks(candidateLoop)) {
            if (!exitBlock) {
                continue;
            }

            std::queue<llvm::BasicBlock*> worklist;
            std::set<llvm::BasicBlock*> seen;
            worklist.push(exitBlock);
            seen.insert(exitBlock);

            while (!worklist.empty() && !reachesTargetHeader) {
                llvm::BasicBlock* block = worklist.front();
                worklist.pop();

                if (block == targetLoop->getHeader()) {
                    reachesTargetHeader = true;
                    break;
                }

                llvm::Instruction* terminator = block ? block->getTerminator() : nullptr;
                for (llvm::BasicBlock* successorBlock : getSuccessorsOfTerminator(terminator)) {
                    if (!successorBlock) {
                        continue;
                    }
                    if (targetLoop->contains(successorBlock) && successorBlock != targetLoop->getHeader()) {
                        continue;
                    }

                    bool insideUnrelatedLoop = false;
                    for (llvm::Loop* otherLoop : allLoops) {
                        if (!otherLoop || otherLoop == targetLoop || otherLoop == candidateLoop) {
                            continue;
                        }
                        if (isAncestorLoopOf(otherLoop, targetLoop) || isAncestorLoopOf(otherLoop, candidateLoop)) {
                            continue;
                        }
                        if (otherLoop->contains(successorBlock)) {
                            insideUnrelatedLoop = true;
                            break;
                        }
                    }
                    if (insideUnrelatedLoop) {
                        continue;
                    }

                    if (seen.insert(successorBlock).second) {
                        worklist.push(successorBlock);
                    }
                }
            }

            if (reachesTargetHeader) {
                break;
            }
        }

        if (reachesTargetHeader) {
            previousLoops.push_back(candidateLoop);
        }
    }

    std::sort(previousLoops.begin(), previousLoops.end(), [](llvm::Loop* leftLoop, llvm::Loop* rightLoop) {
        return loopIsBeforeLoopInFunctionOrder(leftLoop, rightLoop);
    });

    return previousLoops;
}

std::vector<llvm::Loop*> getCFGNextSequentialLoops(llvm::Loop* targetLoop,
                                                   const std::vector<llvm::Loop*>& allLoops) {
    std::vector<llvm::Loop*> nextLoops;
    if (!targetLoop) {
        return nextLoops;
    }

    for (llvm::Loop* candidateLoop : allLoops) {
        if (!candidateLoop || candidateLoop == targetLoop) {
            continue;
        }
        if (!loopsShareImmediateParent(candidateLoop, targetLoop)) {
            continue;
        }

        bool targetCanReachCandidate = false;
        for (llvm::BasicBlock* exitBlock : getUniqueExitBlocks(targetLoop)) {
            if (!exitBlock) {
                continue;
            }

            std::queue<llvm::BasicBlock*> worklist;
            std::set<llvm::BasicBlock*> seen;
            worklist.push(exitBlock);
            seen.insert(exitBlock);

            while (!worklist.empty() && !targetCanReachCandidate) {
                llvm::BasicBlock* block = worklist.front();
                worklist.pop();

                if (block == candidateLoop->getHeader()) {
                    targetCanReachCandidate = true;
                    break;
                }

                llvm::Instruction* terminator = block ? block->getTerminator() : nullptr;
                for (llvm::BasicBlock* successorBlock : getSuccessorsOfTerminator(terminator)) {
                    if (!successorBlock) {
                        continue;
                    }
                    if (candidateLoop->contains(successorBlock) && successorBlock != candidateLoop->getHeader()) {
                        continue;
                    }

                    bool insideUnrelatedLoop = false;
                    for (llvm::Loop* otherLoop : allLoops) {
                        if (!otherLoop || otherLoop == targetLoop || otherLoop == candidateLoop) {
                            continue;
                        }
                        if (isAncestorLoopOf(otherLoop, targetLoop) || isAncestorLoopOf(otherLoop, candidateLoop)) {
                            continue;
                        }
                        if (otherLoop->contains(successorBlock)) {
                            insideUnrelatedLoop = true;
                            break;
                        }
                    }
                    if (insideUnrelatedLoop) {
                        continue;
                    }

                    if (seen.insert(successorBlock).second) {
                        worklist.push(successorBlock);
                    }
                }
            }

            if (targetCanReachCandidate) {
                break;
            }
        }

        if (targetCanReachCandidate) {
            nextLoops.push_back(candidateLoop);
        }
    }

    std::sort(nextLoops.begin(), nextLoops.end(), [](llvm::Loop* leftLoop, llvm::Loop* rightLoop) {
        return loopIsBeforeLoopInFunctionOrder(leftLoop, rightLoop);
    });

    return nextLoops;
}

std::vector<llvm::BasicBlock*> collectEntryCFGSources(LoopContext& loopContext,
                                                      llvm::Loop* parentLoop,
                                                      const std::vector<llvm::Loop*>& previousLoops,
                                                      const std::set<llvm::BasicBlock*>& candidateSet) {
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
}

std::vector<llvm::BasicBlock*> collectEntryCFGBlocks(LoopContext& loopContext,
                                                     llvm::Loop* parentLoop,
                                                     const std::vector<llvm::Loop*>& allLoops,
                                                     const std::vector<llvm::Loop*>& previousLoops) {
    std::vector<llvm::BasicBlock*> candidates;
    std::set<llvm::BasicBlock*> seenCandidates;

    auto addCandidateIfAllowed = [&](llvm::BasicBlock* block) {
        if (isAllowedEntryCFGBlock(loopContext, parentLoop, allLoops, block) && seenCandidates.insert(block).second) {
            candidates.push_back(block);
        }
    };

    if (parentLoop) {
        for (llvm::BasicBlock* block : parentLoop->blocks()) {
            addCandidateIfAllowed(block);
        }
    }
    else {
        for (llvm::BasicBlock& block : *loopContext.function) {
            addCandidateIfAllowed(&block);
        }
    }

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
}


void collectNondeterministicSymbols(const Expression& expression,
                                    std::set<std::string>& symbols);

struct ReadableEntrySourceCall {
    std::string purpose;
    std::string loopId;
    std::string relation;
    std::vector<std::string> sourceState;
};

struct ReadableEntryPath {
    Expression condition;
    std::set<std::string> localSymbols;
    std::vector<ReadableEntrySourceCall> sourceCalls;
    std::map<std::string, Expression> updates;
};

void recordReadableEntryPath(LoopContext& loopContext,
                             const SymbolicState& stateAtHeader,
                             const std::vector<ReadableEntrySourceCall>& sourceCalls,
                             std::vector<ReadableEntryPath>& entryPaths) {
    ReadableEntryPath entryPath;
    entryPath.condition = mkAnd(stateAtHeader.pathConditions);
    entryPath.sourceCalls = sourceCalls;

    collectNondeterministicSymbols(entryPath.condition,
                                   entryPath.localSymbols);

    for (const Variable& variable : loopContext.variables) {
        auto valueIt = stateAtHeader.memoryExpr.find(variable.slot);
        Expression value = valueIt == stateAtHeader.memoryExpr.end()
            ? atom(variable.name)
            : valueIt->second;
        entryPath.updates[variable.name] = value;
        collectNondeterministicSymbols(value,
                                       entryPath.localSymbols);
    }

    entryPaths.push_back(std::move(entryPath));
}

void exploreReadableEntryPaths(
    LoopContext& loopContext,
    llvm::Loop* parentLoop,
    const std::vector<llvm::Loop*>& allLoops,
    const std::set<llvm::BasicBlock*>& allowedBlocks,
    llvm::BasicBlock* currentBlock,
    SymbolicState currentState,
    std::set<const llvm::BasicBlock*> visitedBlocks,
    const std::vector<ReadableEntrySourceCall>& sourceCalls,
    std::vector<ReadableEntryPath>& entryPaths) {
    llvm::BasicBlock* targetHeader =
        loopContext.loop ? loopContext.loop->getHeader() : nullptr;

    if (!currentBlock || !targetHeader) {
        addUnsupported(loopContext,
                       "null block while generating readable entry paths");
        return;
    }

    if (currentBlock == targetHeader) {
        recordReadableEntryPath(loopContext,
                                currentState,
                                sourceCalls,
                                entryPaths);
        return;
    }

    if (!allowedBlocks.count(currentBlock)) {
        return;
    }

    if (visitedBlocks.count(currentBlock)) {
        addUnsupported(loopContext,
                       "cycle before loop header while generating readable entry paths: " +
                           getBasicBlockName(currentBlock));
        return;
    }

    visitedBlocks.insert(currentBlock);
    executeNonTerminatorInstructions(currentBlock,
                                     loopContext,
                                     currentState);

    llvm::Instruction* terminator = currentBlock->getTerminator();
    if (!terminator) {
        addUnsupported(loopContext,
                       "block without terminator while generating readable entry paths: " +
                           getBasicBlockName(currentBlock));
        return;
    }

    if (isa<llvm::ReturnInst>(terminator) ||
        isa<llvm::UnreachableInst>(terminator)) {
        return;
    }

    if (auto* branchInstruction =
            dyn_cast<llvm::BranchInst>(terminator)) {
        Expression branchCondition;
        const unsigned successorCount =
            branchInstruction->isConditional() ? 2 : 1;

        if (branchInstruction->isConditional()) {
            branchCondition = evalValue(branchInstruction->getCondition(),
                                        loopContext,
                                        currentState);
        }

        for (unsigned successorIndex = 0;
             successorIndex < successorCount;
             ++successorIndex) {
            llvm::BasicBlock* successorBlock =
                branchInstruction->getSuccessor(successorIndex);

            if (!isAllowedEntryCFGEdge(loopContext,
                                       parentLoop,
                                       allLoops,
                                       currentBlock,
                                       successorBlock) ||
                !allowedBlocks.count(successorBlock)) {
                continue;
            }

            SymbolicState successorState = currentState;
            Expression edgeCondition =
                !branchInstruction->isConditional()
                    ? atom("true")
                    : (successorIndex == 0
                           ? branchCondition
                           : mkNot(branchCondition));

            if (!addPathConstraint(successorState,
                                   edgeCondition)) {
                continue;
            }

            bindPhiNodesForEntryEdge(loopContext,
                                     currentBlock,
                                     successorBlock,
                                     successorState);

            exploreReadableEntryPaths(loopContext,
                                      parentLoop,
                                      allLoops,
                                      allowedBlocks,
                                      successorBlock,
                                      std::move(successorState),
                                      visitedBlocks,
                                      sourceCalls,
                                      entryPaths);
        }
        return;
    }

    if (auto* switchInstruction =
            dyn_cast<llvm::SwitchInst>(terminator)) {
        Expression switchCondition =
            evalValue(switchInstruction->getCondition(),
                      loopContext,
                      currentState);

        for (auto switchCase : switchInstruction->cases()) {
            llvm::BasicBlock* successorBlock =
                switchCase.getCaseSuccessor();

            if (!isAllowedEntryCFGEdge(loopContext,
                                       parentLoop,
                                       allLoops,
                                       currentBlock,
                                       successorBlock) ||
                !allowedBlocks.count(successorBlock)) {
                continue;
            }

            SymbolicState caseState = currentState;
            Expression caseValue =
                atom(intConstToString(switchCase.getCaseValue()));

            if (!addPathConstraint(caseState,
                                   mkBin("=",
                                         switchCondition,
                                         caseValue))) {
                continue;
            }

            bindPhiNodesForEntryEdge(loopContext,
                                     currentBlock,
                                     successorBlock,
                                     caseState);

            exploreReadableEntryPaths(loopContext,
                                      parentLoop,
                                      allLoops,
                                      allowedBlocks,
                                      successorBlock,
                                      std::move(caseState),
                                      visitedBlocks,
                                      sourceCalls,
                                      entryPaths);
        }

        llvm::BasicBlock* defaultSuccessor =
            switchInstruction->getDefaultDest();
        if (isAllowedEntryCFGEdge(loopContext,
                                  parentLoop,
                                  allLoops,
                                  currentBlock,
                                  defaultSuccessor) &&
            allowedBlocks.count(defaultSuccessor)) {
            SymbolicState defaultState = currentState;
            bool feasible = true;

            for (auto switchCase : switchInstruction->cases()) {
                Expression caseValue =
                    atom(intConstToString(switchCase.getCaseValue()));
                if (!addPathConstraint(
                        defaultState,
                        mkNot(mkBin("=",
                                    switchCondition,
                                    caseValue)))) {
                    feasible = false;
                    break;
                }
            }

            if (feasible) {
                bindPhiNodesForEntryEdge(loopContext,
                                         currentBlock,
                                         defaultSuccessor,
                                         defaultState);

                exploreReadableEntryPaths(loopContext,
                                          parentLoop,
                                          allLoops,
                                          allowedBlocks,
                                          defaultSuccessor,
                                          std::move(defaultState),
                                          visitedBlocks,
                                          sourceCalls,
                                          entryPaths);
            }
        }
        return;
    }

    addUnsupported(loopContext,
                   "unsupported terminator before loop header while generating readable entry paths: " +
                       getBasicBlockName(currentBlock));
}

nlohmann::ordered_json readableEntrySourceCallJson(
    const ReadableEntrySourceCall& sourceCall) {
    nlohmann::ordered_json sourceCallJson;
    sourceCallJson["purpose"] = sourceCall.purpose;
    sourceCallJson["loop_id"] = sourceCall.loopId;
    sourceCallJson["relation"] = sourceCall.relation;
    sourceCallJson["source_state"] = sourceCall.sourceState;
    return sourceCallJson;
}

// Append a path only if its emitted semantic body is new.  Raw CFG paths may
// differ only by internal routing details (for example, which concrete child
// exit edge was taken) that are intentionally absent from the semantic JSON.
// Deduplicating here is therefore safer than merging raw CFG paths: two paths
// are collapsed only after condition/calls/locals/updates have become exactly
// the same semantic object.
void appendUniqueSemanticPath(nlohmann::ordered_json& pathsJson,
                              const nlohmann::ordered_json& semanticPathJson,
                              const std::string& identityField,
                              const std::string& identityPrefix,
                              std::set<std::string>& seenSemanticPathKeys) {
    const std::string semanticKey = semanticPathJson.dump();
    if (!seenSemanticPathKeys.insert(semanticKey).second) {
        return;
    }

    nlohmann::ordered_json pathJson;
    pathJson[identityField] =
        identityPrefix + "_p" + std::to_string(pathsJson.size() + 1);
    for (auto itemIt = semanticPathJson.begin();
         itemIt != semanticPathJson.end();
         ++itemIt) {
        pathJson[itemIt.key()] = itemIt.value();
    }
    pathsJson.push_back(std::move(pathJson));
}

nlohmann::ordered_json generateCFGEntryJson(
    LoopContext& loopContext,
    const std::vector<llvm::Loop*>& allLoops) {
    const std::string loopId = getLoopId(loopContext.loop);

    llvm::Loop* parentLoop =
        loopContext.loop ? loopContext.loop->getParentLoop() : nullptr;
    const std::vector<llvm::Loop*> previousLoops =
        getCFGPreviousSequentialLoops(loopContext.loop,
                                      allLoops);

    const std::vector<llvm::BasicBlock*> blocks =
        collectEntryCFGBlocks(loopContext,
                              parentLoop,
                              allLoops,
                              previousLoops);
    const std::set<llvm::BasicBlock*> allowedBlocks(blocks.begin(),
                                                    blocks.end());

    std::vector<ReadableEntryPath> entryPaths;

    if (parentLoop &&
        allowedBlocks.count(parentLoop->getHeader())) {
        const std::string parentLoopId = getLoopId(parentLoop);
        const std::vector<Variable> parentVariables =
            extractVariables(parentLoop,
                             parentLoopId);
        const std::vector<std::string> parentCurrentNames =
            getCurrentVariableNames(parentVariables);

        ReadableEntrySourceCall parentReachCall;
        parentReachCall.purpose = "parent_loop_reachability";
        parentReachCall.loopId = parentLoopId;
        parentReachCall.relation =
            makeRelationName(parentLoopId,
                             "reachable_header_states");
        parentReachCall.sourceState = parentCurrentNames;

        SymbolicState parentHeaderState =
            createStateFromVariableNames(loopContext.variables,
                                         parentCurrentNames);

        exploreReadableEntryPaths(loopContext,
                                  parentLoop,
                                  allLoops,
                                  allowedBlocks,
                                  parentLoop->getHeader(),
                                  std::move(parentHeaderState),
                                  {},
                                  {parentReachCall},
                                  entryPaths);
    }
    else if (!parentLoop && loopContext.function) {
        llvm::BasicBlock* functionEntry =
            &loopContext.function->getEntryBlock();

        if (allowedBlocks.count(functionEntry)) {
            SymbolicState functionEntryState =
                createFunctionEntryState(loopContext);

            exploreReadableEntryPaths(loopContext,
                                      parentLoop,
                                      allLoops,
                                      allowedBlocks,
                                      functionEntry,
                                      std::move(functionEntryState),
                                      {},
                                      {},
                                      entryPaths);
        }
    }

    // A top-level loop may be entered after a preceding sequential loop.
    // Exact predecessor exit edges remain an internal CFG-routing detail; the
    // emitted semantic dependency is predecessor.actual_exit(output_state).
    for (llvm::Loop* previousLoop : previousLoops) {
        const std::string previousLoopId =
            getLoopId(previousLoop);
        const std::vector<Variable> previousVariables =
            extractVariables(previousLoop,
                             previousLoopId);
        const std::vector<std::string> previousOutNames =
            getOutVariableNames(previousVariables);

        for (const auto& exitEdge : getUniqueExitEdges(previousLoop)) {
            llvm::BasicBlock* exitSourceBlock = exitEdge.first;
            llvm::BasicBlock* exitTargetBlock = exitEdge.second;

            if (!exitSourceBlock ||
                !exitTargetBlock ||
                !allowedBlocks.count(exitTargetBlock)) {
                continue;
            }
            if (isSemanticReturnExitEdge(previousLoop,
                                         exitSourceBlock,
                                         exitTargetBlock)) {
                continue;
            }

            ReadableEntrySourceCall previousExitCall;
            previousExitCall.purpose = "sequential_predecessor_exit";
            previousExitCall.loopId = previousLoopId;
            previousExitCall.relation =
                makeRelationName(previousLoopId,
                                 "actual_exit");
            previousExitCall.sourceState = previousOutNames;

            SymbolicState previousExitState =
                createStateFromVariableNames(loopContext.variables,
                                             previousOutNames);
            bindPhiNodesForEntryEdge(loopContext,
                                     exitSourceBlock,
                                     exitTargetBlock,
                                     previousExitState);

            exploreReadableEntryPaths(loopContext,
                                      parentLoop,
                                      allLoops,
                                      allowedBlocks,
                                      exitTargetBlock,
                                      std::move(previousExitState),
                                      {},
                                      {previousExitCall},
                                      entryPaths);
        }
    }

    if (entryPaths.empty()) {
        addUnsupported(loopContext,
                       "entry_states has no summarized source-to-header path");
    }

    nlohmann::ordered_json entryJson;
    entryJson["id"] = makeRelationName(loopId, "entry_states");
    entryJson["path_semantics"] = "existential_disjunction";
    entryJson["paths"] = nlohmann::ordered_json::array();
    std::set<std::string> seenSemanticPathKeys;

    for (const ReadableEntryPath& entryPath : entryPaths) {

        nlohmann::ordered_json pathJson;
        pathJson["condition"] =
            convertExpressionToJson(normalizeReadableCondition(entryPath.condition));

        if (!entryPath.sourceCalls.empty()) {
            if (entryPath.sourceCalls.size() > 1) {
                addUnsupported(loopContext,
                               "entry path has more than one semantic source_call");
            }
            pathJson["source_call"] =
                readableEntrySourceCallJson(entryPath.sourceCalls.front());
        }

        pathJson["local_symbols"] =
            makeLocalSymbolsJson(entryPath.localSymbols);

        pathJson["updates"] = nlohmann::ordered_json::object();
        for (const Variable& variable : loopContext.variables) {
            auto updateIt = entryPath.updates.find(variable.name);
            const Expression value =
                updateIt == entryPath.updates.end()
                    ? atom(variable.name)
                    : updateIt->second;
            pathJson["updates"][variable.name] =
                convertExpressionToJson(value);
        }

        appendUniqueSemanticPath(entryJson["paths"],
                                 pathJson,
                                 "path_id",
                                 makeRelationName(loopId, "entry_states"),
                                 seenSemanticPathKeys);
    }

    return entryJson;
}

enum class CFGFinalRelationKind {
    Transition,
    ExitStep,
    ReturnStep
};

std::vector<llvm::BasicBlock*> collectLoopCFGBlocks(llvm::Loop* loop) {
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
}


void addChildLoopCFGSummaryRules(LoopContext& loopContext,
                                 nlohmann::ordered_json& relationJson,
                                 CFGFinalRelationKind kind,
                                 const std::string& finalRelationName,
                                 const std::string& requestedExitBlockName,
                                 llvm::Loop* childLoop,
                                 llvm::BasicBlock* sourceBlock,
                                 const std::vector<std::string>& currentArgs,
                                 const std::vector<std::string>& sourceNames,
                                 const SymbolicState& stateAfterSourceBlock,
                                 const nlohmann::ordered_json& sourceBody,
                                 const Expression& edgeCondition,
                                 const std::string& blockPrefix) {
    if (!childLoop) {
        return;
    }

    const std::string loopId = getLoopId(loopContext.loop);
    const std::string childLoopId = getLoopId(childLoop);
    const size_t variableCount = loopContext.variables.size();
    std::vector<std::string> childInputNames =
        makeIndexedNames(loopId + "_" + blockPrefix + "_" +
                             childLoopId + "_in",
                         variableCount);

    nlohmann::ordered_json edgeBody =
        buildBlockTransferBodyFromState(loopContext,
                                        sourceBlock,
                                        childLoop->getHeader(),
                                        stateAfterSourceBlock,
                                        sourceNames,
                                        childInputNames,
                                        edgeCondition,
                                        sourceBody);

    if (loopContainsReturn(childLoop) &&
        kind == CFGFinalRelationKind::ReturnStep) {
        std::vector<nlohmann::ordered_json> body;
        body.push_back(edgeBody);
        body.push_back(
            relationCallJson(
                makeEntry2ReturnRelationName(childLoopId),
                childInputNames));
        relationJson["rules"].push_back(
            ruleJson(finalRelationName,
                     currentArgs,
                     andJson(body)));
    }

    for (const auto& childExitEdge :
         getUniqueExitEdges(childLoop)) {
        llvm::BasicBlock* childExitSourceBlock =
            childExitEdge.first;
        llvm::BasicBlock* childExitBlock =
            childExitEdge.second;
        if (!childExitSourceBlock || !childExitBlock) {
            continue;
        }
        if (isSemanticReturnExitEdge(childLoop,
                                     childExitSourceBlock,
                                     childExitBlock)) {
            continue;
        }

        const std::string childExitSourceName =
            getBasicBlockName(childExitSourceBlock);
        const std::string childExitName =
            getBasicBlockName(childExitBlock);
        const std::string childExitId =
            makeExitEdgeId(childLoopId,
                           childExitSourceName,
                           childExitName);

        std::vector<std::string> childOutputNames =
            makeIndexedNames(
                loopId + "_" + blockPrefix + "_" +
                    childLoopId + "_out_" +
                    sanitizeRelationSuffixPart(childExitId),
                variableCount);

        std::vector<std::string> childEntry2ExitArgs =
            childInputNames;
        childEntry2ExitArgs.push_back(childExitId);
        childEntry2ExitArgs.insert(
            childEntry2ExitArgs.end(),
            childOutputNames.begin(),
            childOutputNames.end());

        std::vector<nlohmann::ordered_json> body;
        body.push_back(edgeBody);
        body.push_back(
            relationCallJson(
                makeEntry2ExitRelationName(childLoopId),
                childEntry2ExitArgs));

        if (childExitBlock ==
                loopContext.loop->getHeader() &&
            kind == CFGFinalRelationKind::Transition) {
            std::vector<std::string> nextArgs =
                getNextVariableNames(loopContext.variables);
            std::vector<nlohmann::ordered_json> transitionBody = body;
            for (size_t index = 0;
                 index < variableCount;
                 ++index) {
                transitionBody.push_back(
                    convertExpressionToJson(
                        mkBin("=",
                              atom(nextArgs[index]),
                              atom(childOutputNames[index]))));
            }
            relationJson["rules"].push_back(
                ruleJson(
                    finalRelationName,
                    concatenateNames(currentArgs, nextArgs),
                    andJson(transitionBody)));
        }
        else if (!loopContext.loop->contains(childExitBlock) &&
                 kind == CFGFinalRelationKind::ExitStep) {
            if (!requestedExitBlockName.empty() &&
                requestedExitBlockName != childExitName) {
                continue;
            }
            std::vector<std::string> outArgs =
                getOutVariableNames(loopContext.variables);
            std::vector<nlohmann::ordered_json> exitBody = body;
            for (size_t index = 0;
                 index < variableCount;
                 ++index) {
                exitBody.push_back(
                    convertExpressionToJson(
                        mkBin("=",
                              atom(outArgs[index]),
                              atom(childOutputNames[index]))));
            }
            relationJson["rules"].push_back(
                ruleJson(
                    finalRelationName,
                    concatenateNames(currentArgs, outArgs),
                    andJson(exitBody)));
        }
        else if (loopContext.loop->contains(childExitBlock) &&
                 !isInsideDirectChildLoop(loopContext.loop,
                                          childExitBlock)) {
            std::vector<std::string> destinationNames =
                makeBlockStateNames(loopId,
                                    blockPrefix,
                                    childExitBlock,
                                    loopContext);
            std::vector<nlohmann::ordered_json> continueBody = body;
            for (size_t index = 0;
                 index < variableCount;
                 ++index) {
                continueBody.push_back(
                    convertExpressionToJson(
                        mkBin("=",
                              atom(destinationNames[index]),
                              atom(childOutputNames[index]))));
            }
            relationJson["rules"].push_back(
                ruleJson(
                    makeCFGBlockRelationName(
                        loopId,
                        blockPrefix,
                        childExitBlock),
                    concatenateNames(currentArgs,
                                     destinationNames),
                    andJson(continueBody)));
        }
    }
}

nlohmann::ordered_json generateCFGLoopPrimitiveJson(LoopContext& loopContext,
                                            CFGFinalRelationKind kind,
                                            const std::string& finalRelationName,
                                            const std::vector<std::string>& finalArgs,
                                            const std::string& helperPrefix,
                                            const std::string& requestedExitBlockName = "") {
    const std::string loopId = getLoopId(loopContext.loop);
    std::vector<std::string> currentArgs = getCurrentVariableNames(loopContext.variables);
    std::vector<std::string> nextArgs = getNextVariableNames(loopContext.variables);
    std::vector<std::string> outArgs = getOutVariableNames(loopContext.variables);

    nlohmann::ordered_json relationJson;
    relationJson["name"] = finalRelationName;
    relationJson["kind"] = "least_fixedpoint";
    relationJson["args"] = finalArgs;
    relationJson["rules"] = nlohmann::ordered_json::array();
    relationJson["method"] = "cfg_to_horn_single_pass_edges";

    std::vector<llvm::BasicBlock*> blocks = collectLoopCFGBlocks(loopContext.loop);
    std::set<llvm::BasicBlock*> blockSet(blocks.begin(), blocks.end());

    auto blockRelationName = [&](llvm::BasicBlock* block) {
        return makeCFGBlockRelationName(loopId, helperPrefix, block);
    };
    auto blockNames = [&](llvm::BasicBlock* block) {
        return makeBlockStateNames(loopId, helperPrefix, block, loopContext);
    };

    std::vector<std::string> headerBlockNames = blockNames(loopContext.loop->getHeader());
    relationJson["rules"].push_back(ruleJson(blockRelationName(loopContext.loop->getHeader()),
                                               concatenateNames(currentArgs, headerBlockNames),
                                               true));

    for (llvm::BasicBlock* block : blocks) {
        if (!block) {
            continue;
        }
        std::vector<std::string> sourceNames = blockNames(block);
        nlohmann::ordered_json sourceBody = relationCallJson(blockRelationName(block), concatenateNames(currentArgs, sourceNames));
        llvm::Instruction* terminator = block->getTerminator();
        if (!terminator) {
            addUnsupported(loopContext, "block without terminator while building loop CFG relation: " + getBasicBlockName(block));
            continue;
        }
        if (isa<llvm::ReturnInst>(terminator)) {
            if (kind == CFGFinalRelationKind::ReturnStep) {
                relationJson["rules"].push_back(ruleJson(finalRelationName, currentArgs, sourceBody));
            }
            continue;
        }
        if (isa<llvm::UnreachableInst>(terminator)) {
            continue;
        }

        SymbolicState stateAfterSourceBlock = createStateFromBlockStateNames(loopContext, block, sourceNames);
        executeNonTerminatorInstructions(block, loopContext, stateAfterSourceBlock);
        for (const auto& [successorBlock, edgeCondition] : getGuardedSuccessors(block, loopContext, stateAfterSourceBlock)) {
            if (!successorBlock) {
                continue;
            }

            if (llvm::Loop* childLoop = const_cast<llvm::Loop*>(directChildLoopContainingBlock(loopContext.loop, successorBlock))) {
                addChildLoopCFGSummaryRules(loopContext,
                                            relationJson,
                                            kind,
                                            finalRelationName,
                                            requestedExitBlockName,
                                            childLoop,
                                            block,
                                            currentArgs,
                                            sourceNames,
                                            stateAfterSourceBlock,
                                            sourceBody,
                                            edgeCondition,
                                            helperPrefix);
                continue;
            }

            if (successorBlock == loopContext.loop->getHeader()) {
                if (kind == CFGFinalRelationKind::Transition) {
                    nlohmann::ordered_json body = buildBlockTransferBodyFromState(loopContext,
                                                                          block,
                                                                          successorBlock,
                                                                          stateAfterSourceBlock,
                                                                          sourceNames,
                                                                          nextArgs,
                                                                          edgeCondition,
                                                                          sourceBody);
                    relationJson["rules"].push_back(ruleJson(finalRelationName, concatenateNames(currentArgs, nextArgs), body));
                }
                continue;
            }

            if (!loopContext.loop->contains(successorBlock)) {
                const bool semanticReturnExit = isSemanticReturnExitEdge(loopContext.loop, block, successorBlock);
                if (semanticReturnExit) {
                    if (kind == CFGFinalRelationKind::ReturnStep) {
                        std::vector<nlohmann::ordered_json> body;
                        body.push_back(sourceBody);
                        body.push_back(convertExpressionToJson(edgeCondition));
                        relationJson["rules"].push_back(ruleJson(finalRelationName, currentArgs, andJson(body)));
                    }
                    continue;
                }

                if (kind == CFGFinalRelationKind::ExitStep) {
                    const std::string successorName = getBasicBlockName(successorBlock);
                    if (!requestedExitBlockName.empty() && requestedExitBlockName != successorName) {
                        continue;
                    }
                    nlohmann::ordered_json body = buildBlockTransferBodyFromState(loopContext,
                                                                          block,
                                                                          successorBlock,
                                                                          stateAfterSourceBlock,
                                                                          sourceNames,
                                                                          outArgs,
                                                                          edgeCondition,
                                                                          sourceBody);
                    relationJson["rules"].push_back(ruleJson(finalRelationName, concatenateNames(currentArgs, outArgs), body));
                }
                continue;
            }

            if (blockSet.count(successorBlock)) {
                std::vector<std::string> destinationNames = blockNames(successorBlock);
                nlohmann::ordered_json body = buildBlockTransferBodyFromState(loopContext,
                                                                      block,
                                                                      successorBlock,
                                                                      stateAfterSourceBlock,
                                                                      sourceNames,
                                                                      destinationNames,
                                                                      edgeCondition,
                                                                      sourceBody);
                relationJson["rules"].push_back(ruleJson(blockRelationName(successorBlock), concatenateNames(currentArgs, destinationNames), body));
            }
        }
    }

    return relationJson;
}


bool loopBlockHasInsideAndOutsideSuccessors(llvm::Loop* loop, llvm::BasicBlock* block) {
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
}

bool blockDominatesAllLoopLatches(LoopContext& loopContext, llvm::BasicBlock* block) {
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
}

bool isLoopGuardDecisionBlock(LoopContext& loopContext, llvm::BasicBlock* block) {
    if (!loopContext.loop || !block) {
        return false;
    }
    return loopBlockHasInsideAndOutsideSuccessors(loopContext.loop, block) &&
           blockDominatesAllLoopLatches(loopContext, block);
}

bool blockHasBackedgeToLoopHeader(LoopContext& loopContext, llvm::BasicBlock* block) {
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
}

std::set<llvm::BasicBlock*> collectLoopGuardRegionBlocks(LoopContext& loopContext) {
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
        std::sort(guardDecisionCandidates.begin(), guardDecisionCandidates.end(),
                  [](const auto& left, const auto& right) {
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

    // A loop whose header reaches no header-side guard decision before entering
    // the body is a do-while-style loop for our summary purposes.  Its entry
    // guard is true; transition/exit_step still encode the bottom condition.
    if (guardRegion.empty()) {
        guardRegion.insert(loopContext.loop->getHeader());
        return guardRegion;
    }

    // Guard extraction must include all straight-line/multi-branch computation
    // blocks between the loop header and the real guard decision blocks.  The
    // previous version included only blocks that dominated the selected decision
    // block, which incorrectly excluded diamond helpers such as:
    //   header -> then/else -> join_guard -> body/exit
    // and made the guard simplify to true.  This reverse slice keeps every
    // acyclic predecessor that can reach a guard decision without crossing a
    // loop backedge to the header.
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

            // Do not pull latch/body blocks from the previous iteration into
            // the entry guard.  Those paths are represented by transition/e2e.
            if (blockHasBackedgeToLoopHeader(loopContext, predecessorBlock)) {
                continue;
            }

            // Keep the region local to the header-side guard slice.  This is
            // conservative for the target fragment: a predecessor dominated by
            // the header and not a backedge belongs to the finite guard-prefix
            // that computes the condition before the body is entered.
            if (loopContext.dominatorTree &&
                !loopContext.dominatorTree->dominates(loopContext.loop->getHeader(), predecessorBlock)) {
                continue;
            }

            if (guardRegion.insert(predecessorBlock).second) {
                worklist.push(predecessorBlock);
            }
        }
    }

    guardRegion.insert(loopContext.loop->getHeader());
    return guardRegion;
}

void collectGuardDisjunctsFromHeaderToBody(LoopContext& loopContext,
                                           const std::set<llvm::BasicBlock*>& guardRegion,
                                           llvm::BasicBlock* currentBlock,
                                           SymbolicState currentState,
                                           std::set<const llvm::BasicBlock*> visitedBlocks,
                                           std::vector<Expression>& guardDisjuncts) {
    if (!currentBlock || !loopContext.loop) {
        return;
    }

    if (visitedBlocks.count(currentBlock)) {
        // A cycle before the body does not create a new finite header-to-body
        // guard path.  The transition/e2e relations still model loop cycles.
        return;
    }
    visitedBlocks.insert(currentBlock);

    executeNonTerminatorInstructions(currentBlock, loopContext, currentState);

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
        if (successorBlock == loopContext.loop->getHeader()) {
            continue;
        }

        bindPhiNodesForEntryEdge(loopContext, currentBlock, successorBlock, successorState);

        if (isInsideDirectChildLoop(loopContext.loop, successorBlock)) {
            guardDisjuncts.push_back(mkAnd(successorState.pathConditions));
            continue;
        }

        if (guardRegion.count(successorBlock)) {
            collectGuardDisjunctsFromHeaderToBody(loopContext,
                                                  guardRegion,
                                                  successorBlock,
                                                  std::move(successorState),
                                                  visitedBlocks,
                                                  guardDisjuncts);
            continue;
        }

        guardDisjuncts.push_back(mkAnd(successorState.pathConditions));
    }
}

Expression extractExactLoopHeaderGuard(LoopContext& loopContext) {
    if (!loopContext.loop || !loopContext.loop->getHeader()) {
        return atom("false");
    }

    std::vector<std::string> currentArgs = getCurrentVariableNames(loopContext.variables);
    SymbolicState headerState = createStateFromVariableNames(loopContext.variables, currentArgs);
    std::vector<Expression> guardDisjuncts;
    std::set<const llvm::BasicBlock*> visitedBlocks;
    std::set<llvm::BasicBlock*> guardRegion = collectLoopGuardRegionBlocks(loopContext);

    collectGuardDisjunctsFromHeaderToBody(loopContext,
                                          guardRegion,
                                          loopContext.loop->getHeader(),
                                          std::move(headerState),
                                          visitedBlocks,
                                          guardDisjuncts);

    if (guardDisjuncts.empty()) {
        addUnsupported(loopContext, "loop guard extraction produced no finite body-entry condition");
        return atom("false");
    }

    return mkOr(guardDisjuncts);
}

nlohmann::ordered_json generateCFGGuardJson(LoopContext& loopContext) {
    const std::string loopId = getLoopId(loopContext.loop);
    nlohmann::ordered_json guardJson;
    guardJson["id"] = makeRelationName(loopId, "guard");
    guardJson["formula"] =
        convertExpressionToJson(extractExactLoopHeaderGuard(loopContext));
    return guardJson;
}

llvm::Loop* findLoopById(llvm::Loop* rootLoop, const std::string& wantedLoopId) {
    if (!rootLoop) {
        return nullptr;
    }
    if (getLoopId(rootLoop) == wantedLoopId) {
        return rootLoop;
    }
    for (llvm::Loop* childLoop : rootLoop->getSubLoops()) {
        if (llvm::Loop* foundLoop = findLoopById(childLoop, wantedLoopId)) {
            return foundLoop;
        }
    }
    return nullptr;
}

bool isNondeterministicSymbolName(const std::string& symbolName) {
    if (symbolName.size() < 3 || symbolName[0] != 'n' || symbolName[1] != 'd') {
        return false;
    }
    return std::all_of(symbolName.begin() + 2, symbolName.end(), [](unsigned char character) {
        return character >= '0' && character <= '9';
    });
}

void collectNondeterministicSymbols(const Expression& expression, std::set<std::string>& symbols) {
    if (!expression.isCompound && !expression.isRelationCall && !expression.isExists) {
        if (isNondeterministicSymbolName(expression.head)) {
            symbols.insert(expression.head);
        }
        return;
    }
    for (const Expression& argument : expression.arguments) {
        collectNondeterministicSymbols(argument, symbols);
    }
}

Expression replaceAtomNames(const Expression& expression,
                            const std::map<std::string, std::string>& replacements) {
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




bool expressionContainsAtomFragment(const Expression& expression,
                                    const std::string& fragment) {
    if (!expression.isCompound && !expression.isRelationCall && !expression.isExists &&
        expression.head.find(fragment) != std::string::npos) {
        return true;
    }
    for (const Expression& argument : expression.arguments) {
        if (expressionContainsAtomFragment(argument, fragment)) {
            return true;
        }
    }
    return false;
}

ExplorationResult exploreReadablePrimitivePaths(LoopContext& loopContext) {
    SymbolicState initialLoopState;
    for (const Variable& variable : loopContext.variables) {
        initialLoopState.valueExpr[variable.slot] = atom(variable.name);
        initialLoopState.memoryExpr[variable.slot] = atom(variable.name);
    }

    ExplorationResult explorationResult;
    exploreLoopPaths(loopContext,
                     loopContext.loop->getHeader(),
                     std::move(initialLoopState),
                     {},
                     explorationResult);
    return explorationResult;
}


nlohmann::ordered_json serializeSemanticChildCalls(LoopContext& loopContext,
                                 const std::vector<ChildCall>& childCalls,
                                 const std::string& contextDescription) {
    nlohmann::ordered_json childCallsJson = nlohmann::ordered_json::array();
    std::map<std::string, std::string> priorChildOutputReplacements;
    std::set<std::string> seenNormalExitChildren;

    for (size_t childCallIndex = 0;
         childCallIndex < childCalls.size();
         ++childCallIndex) {
        const ChildCall& childCall = childCalls[childCallIndex];
        const size_t callNumber = childCallIndex + 1;

        llvm::Loop* childLoop =
            findLoopById(loopContext.loop, childCall.childId);
        std::vector<Variable> childVariables;
        if (childLoop) {
            childVariables = extractVariables(childLoop, childCall.childId);
        }
        else {
            addUnsupported(loopContext,
                           "could not resolve child loop while serializing " +
                               contextDescription + ": " + childCall.childId);
        }

        if (!childVariables.empty() &&
            childVariables.size() != loopContext.variables.size()) {
            addUnsupported(loopContext,
                           "parent/child tracked-state size mismatch while serializing " +
                               contextDescription + ": " +
                               getLoopId(loopContext.loop) + " -> " +
                               childCall.childId);
        }

        if (!childCall.isReturn &&
            !seenNormalExitChildren.insert(childCall.childId).second) {
            addUnsupported(loopContext,
                           "same child loop occurs more than once on one semantic path; "
                           "direct child output symbols would alias: " + childCall.childId);
        }

        nlohmann::ordered_json childCallJson;
        childCallJson["child_loop_id"] = childCall.childId;
        childCallJson["relation"] =
            makeRelationName(childCall.childId,
                             childCall.isReturn
                                 ? "header_to_return"
                                 : "header_to_exit");
        childCallJson["input_state"] = nlohmann::ordered_json::array();

        for (size_t variableIndex = 0;
             variableIndex < loopContext.variables.size();
             ++variableIndex) {
            const Variable& parentVariable =
                loopContext.variables[variableIndex];
            auto entryStateIt = childCall.entryState.find(parentVariable.name);
            const Expression rawEntryValue =
                entryStateIt != childCall.entryState.end()
                    ? entryStateIt->second
                    : atom(parentVariable.name);
            const Expression entryValue =
                replaceAtomNames(rawEntryValue,
                                 priorChildOutputReplacements);
            childCallJson["input_state"].push_back(
                convertExpressionToJson(entryValue));
        }

        if (!childCall.isReturn) {
            childCallJson["output_state"] = nlohmann::ordered_json::array();
            for (size_t variableIndex = 0;
                 variableIndex < loopContext.variables.size();
                 ++variableIndex) {
                const std::string childCurrentName =
                    variableIndex < childVariables.size()
                        ? childVariables[variableIndex].name
                        : childVariableNameFromIndex(childCall.childId,
                                                     variableIndex);
                const std::string childOutName =
                    makeOutVariableName(childCurrentName);
                childCallJson["output_state"].push_back(childOutName);

                priorChildOutputReplacements
                    [childValuePlaceholder(childCall.childId,
                                           callNumber,
                                           loopContext.variables[variableIndex].name)] =
                        childOutName;
                if (childCalls.size() == 1) {
                    priorChildOutputReplacements
                        ["<" + childCall.childId + ":" +
                         loopContext.variables[variableIndex].name + ">"] =
                            childOutName;
                }
            }
        }

        childCallsJson.push_back(std::move(childCallJson));
    }

    return childCallsJson;
}

nlohmann::ordered_json generateCFGTransitionJson(LoopContext& loopContext) {
    const std::string loopId = getLoopId(loopContext.loop);

    SymbolicState initialLoopState;
    for (const Variable& variable : loopContext.variables) {
        initialLoopState.valueExpr[variable.slot] = atom(variable.name);
        initialLoopState.memoryExpr[variable.slot] = atom(variable.name);
    }

    ExplorationResult explorationResult;
    exploreLoopPaths(loopContext,
                     loopContext.loop->getHeader(),
                     std::move(initialLoopState),
                     {},
                     explorationResult);

    std::vector<ChildComposition> unusedChildCompositions;
    std::vector<Transition> transitions =
        extractTransitions(explorationResult.RawTransitions,
                           loopId,
                           loopContext.variables,
                           unusedChildCompositions,
                           loopContext.unsupported,
                           "loop_back");

    nlohmann::ordered_json transitionJson;
    transitionJson["id"] = makeRelationName(loopId, "iteration_steps");
    transitionJson["path_semantics"] = "existential_disjunction";
    transitionJson["paths"] = nlohmann::ordered_json::array();
    std::set<std::string> seenSemanticPathKeys;

    for (const Transition& transition : transitions) {
        nlohmann::ordered_json pathJson;
        pathJson["condition"] =
            convertExpressionToJson(
                normalizeReadableCondition(transition.pathCondition));

        pathJson["child_calls"] =
            serializeSemanticChildCalls(loopContext,
                                        transition.childCalls,
                                        "loop_iteration_steps path");

        std::set<std::string> localSymbols;
        collectNondeterministicSymbols(transition.pathCondition,
                                       localSymbols);
        for (const auto& update : transition.updates) {
            collectNondeterministicSymbols(update.second,
                                           localSymbols);
        }
        for (const ChildCall& childCall : transition.childCalls) {
            for (const auto& entry : childCall.entryState) {
                collectNondeterministicSymbols(entry.second,
                                               localSymbols);
            }
        }
        pathJson["local_symbols"] =
            makeLocalSymbolsJson(localSymbols);

        pathJson["updates"] = nlohmann::ordered_json::object();
        for (const Variable& variable : loopContext.variables) {
            const std::string oldNextName =
                makeNextVariableName(variable.name);
            auto updateIt = transition.updates.find(oldNextName);
            const Expression value =
                updateIt == transition.updates.end()
                    ? atom(variable.name)
                    : updateIt->second;
            pathJson["updates"][variable.name] =
                convertExpressionToJson(value);
        }

        appendUniqueSemanticPath(transitionJson["paths"],
                                 pathJson,
                                 "path_id",
                                 makeRelationName(loopId, "iteration_steps"),
                                 seenSemanticPathKeys);
    }

    return transitionJson;
}

nlohmann::ordered_json generateCFGExitStepJson(LoopContext& loopContext) {
    const std::string loopId = getLoopId(loopContext.loop);

    ExplorationResult explorationResult =
        exploreReadablePrimitivePaths(loopContext);

    // Exit-edge identity is intentionally kept internal. All finite normal
    // header-to-exit paths become disjunctive semantic paths of ExitSteps(s,o).
    std::vector<ChildComposition> unusedChildCompositions;
    std::vector<Transition> exitTransitions =
        extractTransitions(explorationResult.RawTransitions,
                           loopId,
                           loopContext.variables,
                           unusedChildCompositions,
                           loopContext.unsupported,
                           "exit");

    nlohmann::ordered_json exitStepJson;
    exitStepJson["id"] = makeRelationName(loopId, "exit_steps");
    exitStepJson["path_semantics"] = "existential_disjunction";
    exitStepJson["paths"] = nlohmann::ordered_json::array();
    std::set<std::string> seenSemanticPathKeys;

    for (const Transition& exitTransition : exitTransitions) {

        nlohmann::ordered_json pathJson;
        pathJson["condition"] =
            convertExpressionToJson(
                normalizeReadableCondition(exitTransition.pathCondition));

        pathJson["child_calls"] =
            serializeSemanticChildCalls(loopContext,
                                        exitTransition.childCalls,
                                        "loop_exit_steps path");

        std::set<std::string> localSymbols;
        collectNondeterministicSymbols(exitTransition.pathCondition,
                                       localSymbols);
        for (const auto& update : exitTransition.updates) {
            collectNondeterministicSymbols(update.second,
                                           localSymbols);
        }
        for (const ChildCall& childCall : exitTransition.childCalls) {
            for (const auto& entry : childCall.entryState) {
                collectNondeterministicSymbols(entry.second,
                                               localSymbols);
            }
        }
        pathJson["local_symbols"] =
            makeLocalSymbolsJson(localSymbols);

        pathJson["updates"] = nlohmann::ordered_json::object();
        for (const Variable& variable : loopContext.variables) {
            const std::string oldOutName =
                makeOutVariableName(variable.name);
            auto updateIt = exitTransition.updates.find(oldOutName);
            const Expression value =
                updateIt == exitTransition.updates.end()
                    ? atom(variable.name)
                    : updateIt->second;
            pathJson["updates"][variable.name] =
                convertExpressionToJson(value);
        }

        appendUniqueSemanticPath(exitStepJson["paths"],
                                 pathJson,
                                 "id",
                                 makeRelationName(loopId, "exit_steps"),
                                 seenSemanticPathKeys);
    }

    return exitStepJson;
}

nlohmann::ordered_json generateEmptyLeastFixedpointJson(const std::string& relationName,
                                               const std::vector<std::string>& relationArgs,
                                               const std::string& methodName) {
    nlohmann::ordered_json relationJson;
    relationJson["name"] = relationName;
    relationJson["kind"] = "least_fixedpoint";
    relationJson["method"] = methodName;
    relationJson["args"] = relationArgs;
    relationJson["rules"] = nlohmann::ordered_json::array();
    return relationJson;
}

nlohmann::ordered_json generateCFGReturnStepJson(LoopContext& loopContext) {
    const std::string loopId = getLoopId(loopContext.loop);
    ExplorationResult explorationResult = exploreReadablePrimitivePaths(loopContext);

    nlohmann::ordered_json returnStepJson;
    returnStepJson["id"] =
        makeRelationName(loopId, "return_steps");
    returnStepJson["path_semantics"] = "existential_disjunction";
    returnStepJson["paths"] = nlohmann::ordered_json::array();
    std::set<std::string> seenSemanticPathKeys;

    for (const RawTransition& rawTransition : explorationResult.RawTransitions) {
        if (rawTransition.kind != "return") {
            continue;
        }

        const std::vector<ChildCall> childCalls =
            rawTransition.childCalls.empty() &&
                    rawTransition.hasChildComposition
                ? std::vector<ChildCall>{{rawTransition.childId,
                                          "",
                                          rawTransition.childExitBlockName,
                                          rawTransition.childExitBlockName.empty(),
                                          rawTransition.childEntryState}}
                : rawTransition.childCalls;

        std::map<std::string, std::string> childOutputReplacements;
        for (size_t childCallIndex = 0;
             childCallIndex < childCalls.size();
             ++childCallIndex) {
            const ChildCall& childCall = childCalls[childCallIndex];
            if (childCall.isReturn) {
                continue;
            }
            const size_t callNumber = childCallIndex + 1;
            for (size_t variableIndex = 0;
                 variableIndex < loopContext.variables.size();
                 ++variableIndex) {
                const std::string childOutName =
                    makeOutVariableName(
                        childVariableNameFromIndex(childCall.childId,
                                                   variableIndex));
                childOutputReplacements
                    [childValuePlaceholder(childCall.childId,
                                           callNumber,
                                           loopContext.variables[variableIndex].name)] =
                        childOutName;
                if (childCalls.size() == 1) {
                    childOutputReplacements
                        ["<" + childCall.childId + ":" +
                         loopContext.variables[variableIndex].name + ">"] =
                            childOutName;
                }
            }
        }

        std::vector<Expression> readableLiterals;
        for (const Expression& pathLiteral : rawTransition.literals) {
            bool skipLiteral = false;
            for (size_t childCallIndex = 0;
                 childCallIndex < childCalls.size();
                 ++childCallIndex) {
                const ChildCall& childCall = childCalls[childCallIndex];
                const size_t callNumber = childCallIndex + 1;
                if (exprEq(pathLiteral,
                           atom(childPcPlaceholder(childCall.childId,
                                                   callNumber))) ||
                    exprEq(pathLiteral,
                           atom(childReturnPcPlaceholder(childCall.childId,
                                                         callNumber))) ||
                    (childCalls.size() == 1 &&
                     (exprEq(pathLiteral,
                             atom("<" + childCall.childId + ":pc>")) ||
                      exprEq(pathLiteral,
                             atom("<" + childCall.childId +
                                  ":return_pc>"))))) {
                    skipLiteral = true;
                    break;
                }
            }
            if (skipLiteral) {
                continue;
            }

            Expression readableLiteral = pathLiteral;
            readableLiteral =
                replaceAtomNames(readableLiteral,
                                 childOutputReplacements);
            readableLiterals.push_back(readableLiteral);
        }
        Expression readableCondition =
            normalizeReadableCondition(mkAnd(readableLiterals));

        nlohmann::ordered_json pathJson;
        pathJson["condition"] =
            convertExpressionToJson(readableCondition);
        pathJson["child_calls"] =
            serializeSemanticChildCalls(loopContext,
                                        childCalls,
                                        "loop_return_steps path");

        std::set<std::string> localSymbols;
        collectNondeterministicSymbols(readableCondition,
                                       localSymbols);
        for (const ChildCall& childCall : childCalls) {
            for (const auto& entry : childCall.entryState) {
                collectNondeterministicSymbols(entry.second,
                                               localSymbols);
            }
        }
        pathJson["local_symbols"] =
            makeLocalSymbolsJson(localSymbols);

        appendUniqueSemanticPath(returnStepJson["paths"],
                                 pathJson,
                                 "id",
                                 makeRelationName(loopId, "return_steps"),
                                 seenSemanticPathKeys);
    }

    return returnStepJson;
}


nlohmann::ordered_json generateEntry2ExitJson(
    const std::string& loopId,
    const std::vector<Variable>& variables) {
    const std::vector<std::string> currentArgs =
        getCurrentVariableNames(variables);
    const std::vector<std::string> stepArgs =
        getStepVariableNames(variables);
    const std::vector<std::string> outArgs =
        getOutVariableNames(variables);

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
            {"next_state", stepArgs}
        }}
    };

    nlohmann::ordered_json recursiveCall = {
        {"op", "relation_call"},
        {"relation", makeRelationName(loopId, "header_to_exit")},
        {"arguments", {
            {"state", stepArgs},
            {"output_state", outArgs}
        }}
    };

    nlohmann::ordered_json headerToExitJson;
    headerToExitJson["id"] =
        makeRelationName(loopId, "header_to_exit");
    headerToExitJson["formula_semantics"] = "least_fixedpoint";
    headerToExitJson["formula"] = {
        {"op", "or"},
        {"args", nlohmann::ordered_json::array({
            exitStepCall,
            nlohmann::ordered_json{
                {"op", "exists"},
                {"variables", stepArgs},
                {"body", {
                    {"op", "and"},
                    {"args", nlohmann::ordered_json::array({iterationCall, recursiveCall})}
                }}
            }
        })}
    };
    return headerToExitJson;
}



Expression buildTransitionFormula(const std::vector<Transition>& transitions) {
    std::vector<Expression> disjuncts;
    for (const auto& transition : transitions) {
        std::vector<Expression> conjuncts;
        conjuncts.push_back(transition.pathCondition);
        for (const auto& extraConjunct : transition.extraConjuncts) {
            conjuncts.push_back(extraConjunct);
        }
        for (const auto& update : transition.updates) {
            conjuncts.push_back(mkBin("=", atom(update.first), update.second));
        }
        disjuncts.push_back(mkExistsExpression(transition.localVariables, mkAnd(conjuncts)));
    }
    return mkOr(disjuncts);
}

// Patch 3: generated semantic relations.
// These are not extracted from LLVM directly. They are derived mechanically
// from the primitive per-loop relations: entry, transition, and exit_step.
//
// reach(l_v) = entry(l_v) OR exists l_v_prev. reach(l_v_prev) AND t(l_v_prev, l_v)
nlohmann::ordered_json generateReachJson(
    const std::string& loopId,
    const std::vector<Variable>& variables) {
    const std::vector<std::string> currentArgs =
        getCurrentVariableNames(variables);
    const std::vector<std::string> previousArgs =
        getPrevVariableNames(variables);

    nlohmann::ordered_json entryCall = {
        {"op", "relation_call"},
        {"relation", makeRelationName(loopId, "entry_states")},
        {"arguments", {{"state", currentArgs}}}
    };

    nlohmann::ordered_json previousReachCall = {
        {"op", "relation_call"},
        {"relation", makeRelationName(loopId, "reachable_header_states")},
        {"arguments", {{"state", previousArgs}}}
    };

    nlohmann::ordered_json iterationCall = {
        {"op", "relation_call"},
        {"relation", makeRelationName(loopId, "iteration_steps")},
        {"arguments", {
            {"current_state", previousArgs},
            {"next_state", currentArgs}
        }}
    };

    nlohmann::ordered_json reachJson;
    reachJson["id"] =
        makeRelationName(loopId, "reachable_header_states");
    reachJson["formula_semantics"] = "least_fixedpoint";
    reachJson["formula"] = {
        {"op", "or"},
        {"args", nlohmann::ordered_json::array({
            entryCall,
            nlohmann::ordered_json{
                {"op", "exists"},
                {"variables", previousArgs},
                {"body", {
                    {"op", "and"},
                    {"args", nlohmann::ordered_json::array({previousReachCall, iterationCall})}
                }}
            }
        })}
    };
    return reachJson;
}

nlohmann::ordered_json generateExitJson(
    const std::string& loopId,
    const std::vector<Variable>& variables) {
    const std::vector<std::string> entryArgs =
        getEntryVariableNames(variables);
    const std::vector<std::string> outArgs =
        getOutVariableNames(variables);

    nlohmann::ordered_json entryCall = {
        {"op", "relation_call"},
        {"relation", makeRelationName(loopId, "entry_states")},
        {"arguments", {{"state", entryArgs}}}
    };

    nlohmann::ordered_json headerToExitCall = {
        {"op", "relation_call"},
        {"relation", makeRelationName(loopId, "header_to_exit")},
        {"arguments", {
            {"state", entryArgs},
            {"output_state", outArgs}
        }}
    };

    nlohmann::ordered_json actualExitJson;
    actualExitJson["id"] = makeRelationName(loopId, "actual_exit");
    actualExitJson["formula"] = {
        {"op", "exists"},
        {"variables", entryArgs},
        {"body", {
            {"op", "and"},
            {"args", nlohmann::ordered_json::array({entryCall, headerToExitCall})}
        }}
    };
    return actualExitJson;
}

nlohmann::ordered_json generateEntry2ReturnJson(
    const std::string& loopId,
    const std::vector<Variable>& variables) {
    const std::vector<std::string> currentArgs =
        getCurrentVariableNames(variables);
    const std::vector<std::string> stepArgs =
        getStepVariableNames(variables);

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
            {"next_state", stepArgs}
        }}
    };

    nlohmann::ordered_json recursiveCall = {
        {"op", "relation_call"},
        {"relation", makeRelationName(loopId, "header_to_return")},
        {"arguments", {{"state", stepArgs}}}
    };

    nlohmann::ordered_json headerToReturnJson;
    headerToReturnJson["id"] =
        makeRelationName(loopId, "header_to_return");
    headerToReturnJson["formula_semantics"] = "least_fixedpoint";
    headerToReturnJson["formula"] = {
        {"op", "or"},
        {"args", nlohmann::ordered_json::array({
            returnStepCall,
            nlohmann::ordered_json{
                {"op", "exists"},
                {"variables", stepArgs},
                {"body", {
                    {"op", "and"},
                    {"args", nlohmann::ordered_json::array({iterationCall, recursiveCall})}
                }}
            }
        })}
    };
    return headerToReturnJson;
}



bool loopInformationExtractor::extract(
    const std::filesystem::path& inlineBcPath,
    const std::filesystem::path& summariesDir) {
    nextLoopId = 1;
    loopIds.clear();

    llvm::SMDiagnostic error;
    llvm::LLVMContext context;
    std::unique_ptr<llvm::Module> module =
        parseIRFile(inlineBcPath.string(), error, context);

    if (!module) {
        return false;
    }

    std::map<std::string, nlohmann::ordered_json> jsonsByLoopId;

    for (llvm::Function& function : *module) {
        if (function.isDeclaration() || function.getName() != "main") {
            continue;
        }

        llvm::DominatorTree dominatorTree(function);
        llvm::LoopInfo loopInfo;
        loopInfo.analyze(dominatorTree);

        std::vector<llvm::Loop*> allLoops = collectLoopsInFunction(loopInfo);
        sortLoopsByProgramOccurrence(allLoops);

        // Freeze IDs only after loops are in program occurrence order. This
        // prevents recursive LoopInfo traversal from numbering a nested child
        // before a source-earlier sibling/top-level loop.
        for (llvm::Loop* loop : allLoops) {
            (void)getLoopId(loop);
        }

        for (llvm::Loop* loop : allLoops) {
            nlohmann::ordered_json loopJson;
            const std::string loopId = getLoopId(loop);

            loopJson["loop_id"] = loopId;
            loopJson["function"] = function.getName().str();
            loopJson["llvm_header_block"] =
                getBasicBlockName(loop->getHeader());
            loopJson["llvm_must_progress"] =
                loopHasMustProgressMetadata(loop);

            if (llvm::Loop* parent = loop->getParentLoop()) {
                loopJson["parent_loop_id"] = getLoopId(parent);
            }
            else {
                loopJson["parent_loop_id"] = nullptr;
            }

            std::vector<std::string> childLoops;
            for (llvm::Loop* child : loop->getSubLoops()) {
                childLoops.push_back(getLoopId(child));
            }
            loopJson["child_loop_ids"] = convertStringsToJson(childLoops);

            std::vector<std::string> previousSequentialLoops;
            for (llvm::Loop* previousLoop :
                 getCFGPreviousSequentialLoops(loop, allLoops)) {
                previousSequentialLoops.push_back(getLoopId(previousLoop));
            }
            loopJson["previous_sequential_loop_ids"] =
                convertStringsToJson(previousSequentialLoops);

            std::vector<std::string> nextSequentialLoops;
            for (llvm::Loop* nextLoop :
                 getCFGNextSequentialLoops(loop, allLoops)) {
                nextSequentialLoops.push_back(getLoopId(nextLoop));
            }
            loopJson["next_sequential_loop_ids"] =
                convertStringsToJson(nextSequentialLoops);

            LoopContext loopContext;
            loopContext.loop = loop;
            loopContext.function = &function;
            loopContext.dominatorTree = &dominatorTree;
            loopContext.variables = extractVariables(loop, loopId);
            for (const auto& variable : loopContext.variables) {
                loopContext.variableNames[variable.slot] = variable.name;
            }

            loopJson["variables"] =
                convertVariablesToJson(loopContext.variables);
            loopJson["loop_guard"] =
                generateCFGGuardJson(loopContext);
            loopJson["entry_states"] =
                generateCFGEntryJson(loopContext, allLoops);
            loopJson["loop_iteration_steps"] =
                generateCFGTransitionJson(loopContext);
            loopJson["loop_exit_steps"] =
                generateCFGExitStepJson(loopContext);
            loopJson["loop_return_steps"] =
                generateCFGReturnStepJson(loopContext);
            loopJson["reachable_header_states"] =
                generateReachJson(loopId, loopContext.variables);
            loopJson["header_to_exit"] =
                generateEntry2ExitJson(loopId, loopContext.variables);
            loopJson["header_to_return"] =
                generateEntry2ReturnJson(loopId, loopContext.variables);
            loopJson["actual_exit"] =
                generateExitJson(loopId, loopContext.variables);
            loopJson["unsupported"] =
                convertStringsToJson(loopContext.unsupported);

            jsonsByLoopId[loopId] = std::move(loopJson);
        }
    }

    if (jsonsByLoopId.empty()) {
        return false;
    }

    std::filesystem::create_directories(summariesDir);
    for (const auto& [loopId, loopJson] : jsonsByLoopId) {
        const std::filesystem::path summaryPath =
            summariesDir / (loopId + "_summary.json");
        std::ofstream summaryFile(summaryPath);
        if (!summaryFile) {
            return false;
        }
        summaryFile << loopJson.dump(2);
    }

    return true;
}



bool loopInformationExtractor::order(
    const std::filesystem::path& loopInformationDirectory,
    std::vector<loopInformation>& loopInformationList) {
    loopInformationList.clear();

    if (!std::filesystem::exists(loopInformationDirectory) ||
        !std::filesystem::is_directory(loopInformationDirectory)) {
        return false;
    }

    std::vector<std::filesystem::path> summaryFiles;
    for (const auto& entry :
         std::filesystem::directory_iterator(loopInformationDirectory)) {
        if (!entry.is_regular_file()) continue;
        if (entry.path().extension() != ".json") continue;
        summaryFiles.push_back(entry.path());
    }
    std::sort(summaryFiles.begin(), summaryFiles.end());

    std::map<std::string, std::vector<std::string>>
        previousSequentialLoopsById;

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

        if (payload.contains("parent_loop_id") &&
            !payload["parent_loop_id"].is_null()) {
            info.parent = payload["parent_loop_id"].get<std::string>();
        }

        if (payload.contains("child_loop_ids") &&
            payload["child_loop_ids"].is_array()) {
            for (const auto& child : payload["child_loop_ids"]) {
                info.children.push_back(child.get<std::string>());
            }
        }

        if (payload.contains("previous_sequential_loop_ids") &&
            payload["previous_sequential_loop_ids"].is_array()) {
            for (const auto& previousLoop :
                 payload["previous_sequential_loop_ids"]) {
                previousSequentialLoopsById[info.id].push_back(
                    previousLoop.get<std::string>());
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
                auto previousIt =
                    previousSequentialLoopsById.find(loop.id);
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