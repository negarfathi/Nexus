#include "../include/loop_summary_extractor.h"

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
};

struct ChildCall {
    std::string childId;
    std::map<std::string, Expression> entryState;
    std::map<std::string, Expression> exitState;
};

struct Transition {
    std::string branchId;
    std::string kind;
    std::vector<std::string> basicBlocks;
    Expression pathCondition;
    std::map<std::string, Expression> updates;
    bool hasChildCalls = false;
    std::string childId;
};

struct LoopBundle {
    std::vector<Variable> variables;
    Expression entryConstraint;
    Expression guard;
    std::vector<ChildCall> childCalls;
    std::vector<Transition> transitions;
    std::vector<std::string> unsupported;
};



struct LoopContext {
    llvm::Loop* loop = nullptr;
    llvm::Function* function = nullptr;
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
    bool hasChildCall = false;
    std::string childId;
    std::map<std::string, Expression> childEntryState;
};

struct RawTransition {
    std::string kind;
    std::vector<Expression> literals;
    std::vector<std::string> basicBlocks;
    Expression pathCondition;
    std::map<std::string, Expression> updates;
    bool hasChildCall = false;
    std::string childId;
    std::map<std::string, Expression> childEntryState;
};

struct ExplorationResult {
    std::vector<RawTransition> RawTransitions;
};



struct ChildPlaceholderCase {
    std::string childId;
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



Expression atom(const std::string& atomText) {
    Expression expression;
    expression.isCompound = false;
    expression.head = atomText;
    return expression;
}

std::string exprKey(const Expression& expression) {
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
    if (leftExpression.head != rightExpression.head) {
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
    std::string id = "L" + std::to_string(nextLoopId++);
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
                    addUnsupported(loopContext, "bitwise integer and is not supported in Int semantics");
                    result = atom("<unsupported>");
                }
                break;
            case llvm::Instruction::Or:
                if (binaryInstruction->getType() && binaryInstruction->getType()->isIntegerTy(1)) {
                    result = mkBin("or", leftOperand, rightOperand);
                }
                else {
                    addUnsupported(loopContext, "bitwise integer or is not supported in Int semantics");
                    result = atom("<unsupported>");
                }
                break;
            case llvm::Instruction::Xor:
                if (binaryInstruction->getType() && binaryInstruction->getType()->isIntegerTy(1)) {
                    result = mkOr({mkAnd({leftOperand, mkNot(rightOperand)}), mkAnd({mkNot(leftOperand), rightOperand})});
                }
                else {
                    addUnsupported(loopContext, "bitwise integer xor is not supported in Int semantics");
                    result = atom("<unsupported>");
                }
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
        if (calledFunction && calledFunction->getName().starts_with("__VERIFIER_nondet_") && callInstruction->getType()->isIntegerTy()) {
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
    if (symbolicState.hasChildCall) {
        rawTransition.hasChildCall = true;
        rawTransition.childId = symbolicState.childId;
        rawTransition.childEntryState = symbolicState.childEntryState;
    }
    if (transitionKind != "exit") {
        for (const auto& variable : loopContext.variables) {
            std::string nextVariableName = variable.name + "'";
            auto currentSymbolicValue = symbolicState.memoryExpr.find(variable.slot);
            rawTransition.updates[nextVariableName] = (currentSymbolicValue != symbolicState.memoryExpr.end()) ? currentSymbolicValue->second : atom(variable.name);
        }
    }
    explorationResult.RawTransitions.push_back(std::move(rawTransition));
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
                recordRawTransition("exit", completedPath, successorState, loopContext, explorationResult);
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
                if (successorState.hasChildCall) {
                    addUnsupported(loopContext, "multiple child-loop calls in one summarized transition are not supported");
                    continue;
                }
                std::map<std::string, Expression> childEntryState;
                for (const auto& variable : loopContext.variables) {
                    auto variableValueIt = successorState.memoryExpr.find(variable.slot);
                    childEntryState[variable.name] = (variableValueIt != successorState.memoryExpr.end()) ? variableValueIt->second : atom(variable.name);
                }
                std::string childLoopId = getLoopId(childLoop);
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
                llvm::SmallVector<llvm::BasicBlock*, 8> childExitBlocks;
                childLoop->getExitBlocks(childExitBlocks);
                std::set<llvm::BasicBlock*> seenExitBlocks;
                for (llvm::BasicBlock* exitBlock : childExitBlocks) {
                    if (!seenExitBlocks.insert(exitBlock).second) {
                        continue;
                    }
                    ChildPlaceholderCase childExitCase;
                    childExitCase.childId = childLoopId;
                    childExitCase.exitBlock = exitBlock;
                    childExitCase.modifiedSlots = childModifiedSlots;
                    childExitCase.entryState = childEntryState;
                    childExitCases.push_back(std::move(childExitCase));
                }
                if (childExitCases.empty()) {
                    addUnsupported(loopContext, "child loop has no exit targets for composition: " + getLoopId(childLoop));
                    continue;
                }
                for (const auto& childExitCase : childExitCases) {
                    SymbolicState afterChildState = successorState;
                    afterChildState.hasChildCall = true;
                    afterChildState.childId = childExitCase.childId;
                    afterChildState.childEntryState = childExitCase.entryState;
                    if (!addPathConstraint(afterChildState, atom("<" + childExitCase.childId + ":pc>"))) {
                        continue;
                    }
                    for (const auto& variable : loopContext.variables) {
                        if (childExitCase.modifiedSlots.count(variable.slot)) {
                            afterChildState.memoryExpr[variable.slot] = atom("<" + childExitCase.childId + ":" + variable.name + ">");
                        }
                    }
                    afterChildState.pathBlocks.push_back("<child_call:" + childExitCase.childId + ">");
                    if (!childExitCase.exitBlock) {
                        addUnsupported(loopContext, "child placeholder without exit block: " + childExitCase.childId);
                        continue;
                    }
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
                recordRawTransition("exit", completedPath, caseState, loopContext, explorationResult);
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
                if (caseState.hasChildCall) {
                    addUnsupported(loopContext, "multiple child-loop calls in one summarized transition are not supported");
                    continue;
                }
                std::map<std::string, Expression> childEntryState;
                for (const auto& variable : loopContext.variables) {
                    auto variableValueIt = caseState.memoryExpr.find(variable.slot);
                    childEntryState[variable.name] = (variableValueIt != caseState.memoryExpr.end()) ? variableValueIt->second : atom(variable.name);
                }
                std::string childLoopId = getLoopId(childLoop);
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
                llvm::SmallVector<llvm::BasicBlock*, 8> childExitBlocks;
                childLoop->getExitBlocks(childExitBlocks);
                std::set<llvm::BasicBlock*> seenExitBlocks;
                for (llvm::BasicBlock* exitBlock : childExitBlocks) {
                    if (!seenExitBlocks.insert(exitBlock).second) {
                        continue;
                    }
                    ChildPlaceholderCase childExitCase;
                    childExitCase.childId = childLoopId;
                    childExitCase.exitBlock = exitBlock;
                    childExitCase.modifiedSlots = childModifiedSlots;
                    childExitCase.entryState = childEntryState;
                    childExitCases.push_back(std::move(childExitCase));
                }
                if (childExitCases.empty()) {
                    addUnsupported(loopContext, "child loop has no exit targets for composition: " + getLoopId(childLoop));
                    continue;
                }
                for (const auto& childExitCase : childExitCases) {
                    SymbolicState afterChildState = caseState;
                    afterChildState.hasChildCall = true;
                    afterChildState.childId = childExitCase.childId;
                    afterChildState.childEntryState = childExitCase.entryState;
                    if (!addPathConstraint(afterChildState, atom("<" + childExitCase.childId + ":pc>"))) {
                        continue;
                    }
                    for (const auto& variable : loopContext.variables) {
                        if (childExitCase.modifiedSlots.count(variable.slot)) {
                            afterChildState.memoryExpr[variable.slot] = atom("<" + childExitCase.childId + ":" + variable.name + ">");
                        }
                    }
                    afterChildState.pathBlocks.push_back("<child_call:" + childExitCase.childId + ">");
                    if (!childExitCase.exitBlock) {
                        addUnsupported(loopContext, "child placeholder without exit block: " + childExitCase.childId);
                        continue;
                    }
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
            recordRawTransition("exit", completedPath, defaultState, loopContext, explorationResult);
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
            if (defaultState.hasChildCall) {
                addUnsupported(loopContext, "multiple child-loop calls in one summarized transition are not supported");
                return;
            }
            std::map<std::string, Expression> childEntryState;
            for (const auto& variable : loopContext.variables) {
                auto variableValueIt = defaultState.memoryExpr.find(variable.slot);
                childEntryState[variable.name] = (variableValueIt != defaultState.memoryExpr.end()) ? variableValueIt->second : atom(variable.name);
            }
            std::string childLoopId = getLoopId(childLoop);
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
            llvm::SmallVector<llvm::BasicBlock*, 8> childExitBlocks;
            childLoop->getExitBlocks(childExitBlocks);
            std::set<llvm::BasicBlock*> seenExitBlocks;
            for (llvm::BasicBlock* exitBlock : childExitBlocks) {
                if (!seenExitBlocks.insert(exitBlock).second) {
                    continue;
                }
                ChildPlaceholderCase childExitCase;
                childExitCase.childId = childLoopId;
                childExitCase.exitBlock = exitBlock;
                childExitCase.modifiedSlots = childModifiedSlots;
                childExitCase.entryState = childEntryState;
                childExitCases.push_back(std::move(childExitCase));
            }
            if (childExitCases.empty()) {
                addUnsupported(loopContext, "child loop has no exit targets for composition: " + getLoopId(childLoop));
                return;
            }
            for (const auto& childExitCase : childExitCases) {
                SymbolicState afterChildState = defaultState;
                afterChildState.hasChildCall = true;
                afterChildState.childId = childExitCase.childId;
                afterChildState.childEntryState = childExitCase.entryState;
                if (!addPathConstraint(afterChildState, atom("<" + childExitCase.childId + ":pc>"))) {
                    continue;
                }
                for (const auto& variable : loopContext.variables) {
                    if (childExitCase.modifiedSlots.count(variable.slot)) {
                        afterChildState.memoryExpr[variable.slot] = atom("<" + childExitCase.childId + ":" + variable.name + ">");
                    }
                }
                afterChildState.pathBlocks.push_back("<child_call:" + childExitCase.childId + ">");
                if (!childExitCase.exitBlock) {
                    addUnsupported(loopContext, "child placeholder without exit block: " + childExitCase.childId);
                    continue;
                }
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



std::vector<Variable> extractVariables(llvm::Loop* loop) {
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
        trackedVariable.name = "v" + std::to_string(nextVariableIndex++);
        trackedVariable.llvmName = convertLLVMValueToString(stackAllocation);
        trackedVariable.type = "Int";
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
        trackedVariable.name = "v" + std::to_string(nextVariableIndex++);
        trackedVariable.llvmName = convertLLVMValueToString(&globalVariable);
        trackedVariable.type = "Int";
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

void exploreEntryPaths(LoopContext& loopContext, llvm::BasicBlock* currentBlock, SymbolicState stateAtCurrentBlock, std::set<const llvm::BasicBlock*> visitedEntryBlocks, std::vector<Expression>& entryPathClauses) {
    llvm::BasicBlock* loopHeaderBlock = loopContext.loop->getHeader();
    if (!currentBlock) {
        addUnsupported(loopContext, "null block while extracting entry_constraint");
        return;
    }
    if (currentBlock == loopHeaderBlock) {
        std::vector<Expression> entryPathClause = stateAtCurrentBlock.pathConditions;
        for (const auto& trackedVariable : loopContext.variables) {
            auto memoryExpressionIt = stateAtCurrentBlock.memoryExpr.find(trackedVariable.slot);
            if (memoryExpressionIt == stateAtCurrentBlock.memoryExpr.end()) {
                continue;
            }
            if (exprEq(memoryExpressionIt->second, atom(trackedVariable.name))) {
                continue;
            }
            entryPathClause.push_back(mkBin("=", atom(trackedVariable.name), memoryExpressionIt->second));
        }
        entryPathClauses.push_back(mkAnd(entryPathClause));
        return;
    }
    if (loopContext.loop->contains(currentBlock)) {
        addUnsupported(loopContext, "entered target loop before reaching its header while extracting entry_constraint: " + getBasicBlockName(currentBlock));
        return;
    }
    if (visitedEntryBlocks.count(currentBlock)) {
        addUnsupported(loopContext, "cycle before loop header while extracting entry_constraint: " + getBasicBlockName(currentBlock));
        return;
    }
    visitedEntryBlocks.insert(currentBlock);
    executeNonTerminatorInstructions(currentBlock, loopContext, stateAtCurrentBlock);
    llvm::Instruction* terminator = currentBlock->getTerminator();
    if (!terminator) {
        addUnsupported(loopContext, "block without terminator while extracting entry_constraint: " + getBasicBlockName(currentBlock));
        return;
    }
    if (isa<llvm::ReturnInst>(terminator) || isa<llvm::UnreachableInst>(terminator)) {
        return;
    }
    if (auto* branchInstruction = dyn_cast<llvm::BranchInst>(terminator)) {
        if (!branchInstruction->isConditional()) {
            llvm::BasicBlock* successorBlock = branchInstruction->getSuccessor(0);
            SymbolicState stateAtSuccessor = stateAtCurrentBlock;
            bindPhiNodesForEntryEdge(loopContext, currentBlock, successorBlock, stateAtSuccessor);
            exploreEntryPaths(loopContext, successorBlock, stateAtSuccessor, visitedEntryBlocks, entryPathClauses);
            return;
        }
        Expression branchCondition = evalValue(branchInstruction->getCondition(), loopContext, stateAtCurrentBlock);
        llvm::BasicBlock* trueSuccessorBlock = branchInstruction->getSuccessor(0);
        SymbolicState trueBranchState = stateAtCurrentBlock;
        if (addPathConstraint(trueBranchState, branchCondition)) {
            bindPhiNodesForEntryEdge(loopContext, currentBlock, trueSuccessorBlock, trueBranchState);
            exploreEntryPaths(loopContext, trueSuccessorBlock, trueBranchState, visitedEntryBlocks, entryPathClauses);
        }
        llvm::BasicBlock* falseSuccessorBlock = branchInstruction->getSuccessor(1);
        SymbolicState falseBranchState = stateAtCurrentBlock;
        if (addPathConstraint(falseBranchState, mkNot(branchCondition))) {
            bindPhiNodesForEntryEdge(loopContext, currentBlock, falseSuccessorBlock, falseBranchState);
            exploreEntryPaths(loopContext, falseSuccessorBlock, falseBranchState, visitedEntryBlocks, entryPathClauses);
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
            exploreEntryPaths(loopContext, caseSuccessorBlock, caseState, visitedEntryBlocks, entryPathClauses);
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
        exploreEntryPaths(loopContext, defaultSuccessorBlock, defaultCaseState, visitedEntryBlocks, entryPathClauses);
        return;
    }
    addUnsupported(loopContext, "unsupported terminator before loop header while extracting entry_constraint: " + getBasicBlockName(currentBlock));
}

Expression extractEntryConstraint(LoopContext& loopContext) {
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
    std::vector<Expression> entryPathClauses;
    exploreEntryPaths(loopContext, &loopContext.function->getEntryBlock(), stateAtFunctionEntry, {}, entryPathClauses);
    if (entryPathClauses.empty()) {
        addUnsupported(loopContext, "entry_constraint is false because no acyclic entry path to the loop header was summarized");
        return atom("false");
    }
    return mkOr(entryPathClauses);
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
    const std::string childPlaceholderPrefix = "<L";
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



std::vector<Transition> extractTransitions(const std::vector<RawTransition>& rawTransitions, const std::string& parentLoopId, const std::vector<Variable>& variables, std::vector<ChildCall>& childCalls, std::vector<std::string>& unsupportedMessages) {
    (void)parentLoopId;
    std::map<std::string, ChildCall> childCallMap;
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
        if (!expression.isCompound) {
            if (expression.head == oldAtomName) {
                return atom(newAtomName);
            }
            return expression;
        }
        Expression rewrittenExpression;
        rewrittenExpression.isCompound = true;
        rewrittenExpression.head = expression.head;
        for (const auto& argument : expression.arguments) {
            rewrittenExpression.arguments.push_back(replaceAtomRecursive(replaceAtomRecursive, argument, oldAtomName, newAtomName));
        }
        return rewrittenExpression;
    };
    for (const auto& rawTransition : rawTransitions) {
        if (rawTransition.kind != "loop_back") {
            continue;
        }
        if (rawTransition.hasChildCall) {
            ChildCall& childCall = childCallMap[rawTransition.childId];
            if (childCall.childId.empty()) {
                childCall.childId = rawTransition.childId;
                childCall.entryState = rawTransition.childEntryState;
                for (const auto& variable : variables) {
                    childCall.exitState[variable.name] = atom(rawTransition.childId + "_" + variable.name);
                }
            }
        }
        Transition normalizedTransition;
        normalizedTransition.kind = "loop_back";
        normalizedTransition.basicBlocks = rawTransition.basicBlocks;
        if (rawTransition.hasChildCall) {
            normalizedTransition.hasChildCalls = true;
            normalizedTransition.childId = rawTransition.childId;
        }
        std::vector<Expression> rewrittenPathLiterals;
        for (const auto& pathLiteral : rawTransition.literals) {
            if (rawTransition.hasChildCall && exprEq(pathLiteral, atom("<" + rawTransition.childId + ":pc>"))) {
                continue;
            }
            Expression rewrittenLiteral = pathLiteral;
            if (rawTransition.hasChildCall) {
                for (const auto& variable : variables) {
                    const std::string childVariablePlaceholder = "<" + rawTransition.childId + ":" + variable.name + ">";
                    const std::string childExitVariableName = rawTransition.childId + "_" + variable.name;
                    rewrittenLiteral = replaceAtomInExpression(replaceAtomInExpression, rewrittenLiteral, childVariablePlaceholder, childExitVariableName);
                }
            }
            if (expressionContainsText(expressionContainsText, rewrittenLiteral, "<" + rawTransition.childId + ":phi:")) {
                addUnsupported(unsupportedMessages, "child-exit PHI placeholders are not yet structured in JSON: " + exprKey(rewrittenLiteral));
            }
            rewrittenPathLiterals.push_back(rewrittenLiteral);
        }
        normalizedTransition.pathCondition = mkAnd(rewrittenPathLiterals);
        for (const auto& update : rawTransition.updates) {
            Expression rewrittenRightHandSide = update.second;
            if (rawTransition.hasChildCall) {
                for (const auto& variable : variables) {
                    const std::string childVariablePlaceholder = "<" + rawTransition.childId + ":" + variable.name + ">";
                    const std::string childExitVariableName = rawTransition.childId + "_" + variable.name;
                    rewrittenRightHandSide = replaceAtomInExpression(replaceAtomInExpression, rewrittenRightHandSide, childVariablePlaceholder, childExitVariableName);
                }
            }
            if (expressionContainsText(expressionContainsText, rewrittenRightHandSide, "<" + rawTransition.childId + ":phi:")) {
                addUnsupported(unsupportedMessages, "child-exit PHI placeholders are not yet structured in JSON: " + exprKey(rewrittenRightHandSide));
            }
            normalizedTransition.updates[update.first] = rewrittenRightHandSide;
        }
        normalizedTransitions.push_back(std::move(normalizedTransition));
    }
    for (auto& childCallEntry : childCallMap) {
        childCalls.push_back(childCallEntry.second);
    }
    std::vector<Transition> mergedTransitions;
    std::map<std::string, size_t> mergeKeyToTransitionIndex;
    BranchAllocator branchAllocator;
    for (const auto& normalizedTransition : normalizedTransitions) {
        std::string mergeKey;
        mergeKey += normalizedTransition.hasChildCalls ? normalizedTransition.childId : "";
        mergeKey += "|";
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



LoopBundle getLoopBundle(llvm::Function& loopFunction, llvm::Loop* targetLoop) {
    LoopBundle loopBundle;
    LoopContext loopContext;

    loopContext.loop = targetLoop;
    loopContext.function = &loopFunction;
    loopContext.variables = extractVariables(targetLoop);
    for (const auto& variable : loopContext.variables) {
        loopContext.variableNames[variable.slot] = variable.name;
    }

    loopBundle.variables = loopContext.variables;
    if (loopContext.variables.empty()) {
        loopBundle.entryConstraint = atom("false");
        loopBundle.guard = atom("false");
        loopBundle.unsupported = loopContext.unsupported;
        return loopBundle;
    }

    loopBundle.entryConstraint = extractEntryConstraint(loopContext);

    SymbolicState initialLoopState;
    for (const auto& variable : loopContext.variables) {
        initialLoopState.valueExpr[variable.slot] = atom(variable.name);
        initialLoopState.memoryExpr[variable.slot] = atom(variable.name);
    }

    ExplorationResult explorationResult;
    exploreLoopPaths(loopContext, targetLoop->getHeader(), initialLoopState, {}, explorationResult);

    loopBundle.guard = extractGuard(explorationResult.RawTransitions);
    loopBundle.transitions = extractTransitions(explorationResult.RawTransitions, getLoopId(targetLoop), loopContext.variables, loopBundle.childCalls, loopContext.unsupported);
    loopBundle.unsupported = loopContext.unsupported;

    return loopBundle;
}



nlohmann::json convertExpressionToJson(const Expression& E) {
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
    nlohmann::json compoundExpressionJson;
    compoundExpressionJson["op"] = E.head;
    compoundExpressionJson["args"] = nlohmann::json::array();
    for (const auto& argument : E.arguments) {
        compoundExpressionJson["args"].push_back(convertExpressionToJson(argument));
    }
    return compoundExpressionJson;
}

nlohmann::json convertStringsToJson(const std::vector<std::string>& S) {
    nlohmann::json stringsJson = nlohmann::json::array();
    for (const auto& string : S) {
        stringsJson.push_back(string);
    }
    return stringsJson;
}

nlohmann::json convertVariablesToJson(const std::vector<Variable>& V) {
    nlohmann::json variablesJson = nlohmann::json::array();
    for (const auto& variable : V) {
        variablesJson.push_back({
            {"name", variable.name},
            {"llvm_slot", variable.llvmName},
            {"type", variable.type}
        });
    }
    return variablesJson;
}

nlohmann::json convertChildCallsToJson(const std::vector<ChildCall>& CC) {
    nlohmann::json childCallsJson = nlohmann::json::array();
    for (const auto& childCall : CC) {
        nlohmann::json entryStateJson = nlohmann::json::object();
        for (const auto& entryState : childCall.entryState) {
            entryStateJson[entryState.first] = convertExpressionToJson(entryState.second);
        }
        nlohmann::json exitStateJson = nlohmann::json::object();
        for (const auto& exitState : childCall.exitState) {
            exitStateJson[exitState.first] = convertExpressionToJson(exitState.second);
        }
        childCallsJson.push_back({
            {"child_id", childCall.childId},
            {"entry_state", entryStateJson},
            {"exit_state", exitStateJson}
        });
    }
    return childCallsJson;
}

nlohmann::json convertTransitionsToJson(const std::vector<Transition>& T) {
    nlohmann::json transitionJson = nlohmann::json::array();
    for (const auto& transition : T) {
        nlohmann::json updatesJson = nlohmann::json::object();
        for (const auto& update : transition.updates) {
            updatesJson[update.first] = convertExpressionToJson(update.second);
        }
        transitionJson.push_back({
            {"branch_id", transition.branchId},
            {"kind", transition.kind},
            {"basic_blocks", convertStringsToJson(transition.basicBlocks)},
            {"path_condition", convertExpressionToJson(transition.pathCondition)},
            {"updates", updatesJson}
        });
    }
    return transitionJson;
}



bool LoopSummaryExtractor::extract(const std::filesystem::path& inlineBcPath, const std::filesystem::path& summariesDir) {
    nextLoopId = 1;
    loopIds.clear();

    llvm::SMDiagnostic error;
    llvm::LLVMContext context;
    std::unique_ptr<llvm::Module> module = parseIRFile(inlineBcPath.string(), error, context);

    if (!module) {
        return false;
    }

    auto assignLoopIds = [&](auto&& self, llvm::Loop* loop) -> void {
        (void)getLoopId(loop);
        for (llvm::Loop* subLoop : loop->getSubLoops()) {
            self(self, subLoop);
        }
    };

    for (llvm::Function& function : *module) {
        if (function.isDeclaration()) {
            continue;
        }

        llvm::DominatorTree dominatorTree(function);

        llvm::LoopInfo loopInfo;
        loopInfo.analyze(dominatorTree);

        for (llvm::Loop* loop : loopInfo) {
            assignLoopIds(assignLoopIds, loop);
        }
    }

    std::map<std::string, nlohmann::json> jsonsByLoopId;
    std::map<std::string, std::vector<std::string>> childLoopsByLoopId;

    for (llvm::Function& function : *module) {
        if (function.isDeclaration()) {
            continue;
        }

        llvm::DominatorTree dominatorTree(function);

        llvm::LoopInfo loopInfo;
        loopInfo.analyze(dominatorTree);

        std::vector<llvm::Loop*> currentLoop;

        for (llvm::Loop* loop : loopInfo) {
            currentLoop.push_back(loop);
        }

        while (!currentLoop.empty()) {
            llvm::Loop* loop = currentLoop.back();

            currentLoop.pop_back();

            for (llvm::Loop* subLoop : loop->getSubLoops()) {
                currentLoop.push_back(subLoop);
            }

            nlohmann::json loopJson;

            std::string loopId = getLoopId(loop);
            loopJson["loop_id"] = loopId;

            loopJson["function"] = function.getName().str();

            llvm::BasicBlock* basicBlock = loop->getHeader();
            loopJson["header_basic_block"] = getBasicBlockName(basicBlock);

            if (llvm::Loop* parent = loop->getParentLoop()) {
                loopJson["parent_loop"] = getLoopId(parent);
            }
            else {
                loopJson["parent_loop"] = nullptr;
            }

            std::vector<std::string> childLoops;
            for (llvm::Loop* child : loop->getSubLoops()) {
                childLoops.push_back(getLoopId(child));
            }
            loopJson["child_loops"] = convertStringsToJson(childLoops);

            LoopBundle loopBundle = getLoopBundle(function, loop);
            loopJson["variables"] = convertVariablesToJson(loopBundle.variables);
            loopJson["entry_constraint"] = convertExpressionToJson(loopBundle.entryConstraint);
            loopJson["guard"] = convertExpressionToJson(loopBundle.guard);
            loopJson["child_calls"] = convertChildCallsToJson(loopBundle.childCalls);
            loopJson["transitions"] = convertTransitionsToJson(loopBundle.transitions);
            loopJson["unsupported"] = convertStringsToJson(loopBundle.unsupported);

            jsonsByLoopId[loopId] = std::move(loopJson);
            childLoopsByLoopId[loopId] = std::move(childLoops);
        }
    }

    if (jsonsByLoopId.empty()) {
        return false;
    }

    for (const auto& [targetLoopId, _] : jsonsByLoopId) {
        nlohmann::json targetLoopJson;
        std::vector<std::string> loops;

        targetLoopJson["target_loop_id"] = targetLoopId;
        targetLoopJson["loops"] = nlohmann::json::array();

        loops.push_back(targetLoopId);

        while (!loops.empty()) {
            std::string currentLoop = loops.back();

            loops.pop_back();

            auto childLoops = childLoopsByLoopId.find(currentLoop);
            if (childLoops != childLoopsByLoopId.end()) {
                for (auto childLoop = childLoops->second.rbegin(); childLoop != childLoops->second.rend(); ++childLoop) {
                    loops.push_back(*childLoop);
                }
            }

            auto loop = jsonsByLoopId.find(currentLoop);
            if (loop == jsonsByLoopId.end()) {
                return false;
            }

            targetLoopJson["loops"].push_back(loop->second);
        }

        std::filesystem::path summaryPath = summariesDir / (targetLoopId + "_summary.json");
        std::ofstream summaryFile(summaryPath);
        if (!summaryFile) {
            return false;
        }

        summaryFile << targetLoopJson.dump(2);
    }

    return true;
}



bool LoopSummaryExtractor::order(const std::filesystem::path& summariesDir, std::vector<LoopSummary>& loopSummaries) {
    loopSummaries.clear();

    if (!std::filesystem::exists(summariesDir) || !std::filesystem::is_directory(summariesDir)) {
        return false;
    }

    std::vector<std::filesystem::path> summaryFiles;
    for (const auto& entry : std::filesystem::directory_iterator(summariesDir)) {
        if (!entry.is_regular_file()) continue;
        if (entry.path().extension() != ".json") continue;
        summaryFiles.push_back(entry.path());
    }
    std::sort(summaryFiles.begin(), summaryFiles.end());

    for (const auto& path : summaryFiles) {
        std::ifstream input(path);
        if (!input) {
            return false;
        }

        nlohmann::json payload;
        input >> payload;

        if (!payload.is_object()) continue;
        if (!payload.contains("target_loop_id")) continue;
        if (!payload.contains("loops") || !payload["loops"].is_array()) continue;

        std::string targetLoopId = payload["target_loop_id"].get<std::string>();
        nlohmann::json targetLoopJson;
        bool found = false;

        for (const auto& loopJson : payload["loops"]) {
            if (!loopJson.is_object()) continue;
            if (!loopJson.contains("loop_id")) continue;
            if (loopJson["loop_id"].get<std::string>() == targetLoopId) {
                targetLoopJson = loopJson;
                found = true;
                break;
            }
        }

        if (!found) {
            return false;
        }

        LoopSummary info;
        info.id = targetLoopJson.at("loop_id").get<std::string>();
        if (targetLoopJson.contains("parent_loop") && !targetLoopJson["parent_loop"].is_null()) {
            info.parent = targetLoopJson["parent_loop"].get<std::string>();
        }
        if (targetLoopJson.contains("child_loops") && targetLoopJson["child_loops"].is_array()) {
            for (const auto& child : targetLoopJson["child_loops"]) {
                info.children.push_back(child.get<std::string>());
            }
        }
        info.path = path;
        loopSummaries.push_back(std::move(info));
    }

    if (loopSummaries.empty()) {
        return false;
    }

    std::vector<LoopSummary> orderedLoops;
    std::set<std::string> processed;

    while (orderedLoops.size() < loopSummaries.size()) {
        bool progress = false;
        for (const auto& loop : loopSummaries) {
            if (processed.count(loop.id)) continue;

            bool allChildrenProcessed = true;
            for (const auto& childId : loop.children) {
                if (!processed.count(childId)) {
                    allChildrenProcessed = false;
                    break;
                }
            }

            if (allChildrenProcessed) {
                orderedLoops.push_back(loop);
                processed.insert(loop.id);
                progress = true;
            }
        }

        if (!progress) {
            return false;
        }
    }

    loopSummaries = std::move(orderedLoops);
    return true;
}