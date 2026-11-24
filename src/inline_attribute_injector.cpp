#include "../include/inline_attribute_injector.h"
// >>> NEXUS CHANGE BEGIN [2.4 - tokenize return statement terminators]
#include "clang/Lex/Lexer.h"
// <<< NEXUS CHANGE END [2.4 - tokenize return statement terminators]

namespace {

class FunctionGraphCollector : public clang::RecursiveASTVisitor<FunctionGraphCollector> {
public:
    explicit FunctionGraphCollector(clang::SourceManager &sourceManager) : sourceManager(sourceManager) {}

    bool TraverseFunctionDecl(clang::FunctionDecl *FD) {
        if (FD == nullptr) {
            return true;
        }
        const clang::FunctionDecl *previousFunction = currentFunction;
        if (FD->isThisDeclarationADefinition() && isDefinitionInMainFile(FD)) {
            currentFunction = FD->getCanonicalDecl();
            functions.insert(currentFunction);
        }
        const bool result = clang::RecursiveASTVisitor<FunctionGraphCollector>::TraverseFunctionDecl(FD);
        currentFunction = previousFunction;
        return result;
    }

    bool VisitCallExpr(clang::CallExpr *callExpr) {
        if (callExpr == nullptr || currentFunction == nullptr) {
            return true;
        }
        const clang::FunctionDecl *callee = callExpr->getDirectCallee();
        if (callee != nullptr) {
            calls[currentFunction].insert(callee->getCanonicalDecl());
        }
        return true;
    }

    const std::set<const clang::FunctionDecl *> & getFunctions() const {
        return functions;
    }

    const std::map<const clang::FunctionDecl *, std::set<const clang::FunctionDecl *>> & getCalls() const {
        return calls;
    }

private:
    bool isDefinitionInMainFile(const clang::FunctionDecl *FD) const {
        const clang::SourceLocation beginLoc = FD->getBeginLoc();
        return beginLoc.isValid() && !beginLoc.isMacroID() && sourceManager.isInMainFile(beginLoc);
    }

    clang::SourceManager &sourceManager;
    const clang::FunctionDecl *currentFunction = nullptr;
    std::set<const clang::FunctionDecl *> functions;
    std::map<const clang::FunctionDecl *,std::set<const clang::FunctionDecl *>> calls;
};


std::set<const clang::FunctionDecl *> findEntryFunctions(const FunctionGraphCollector &collector) {
    const auto &functions = collector.getFunctions();
    const auto &calls = collector.getCalls();
    std::set<const clang::FunctionDecl *> entryFunctions;
    for (const clang::FunctionDecl *function : functions) {
        if (function->isMain()) {
            entryFunctions.insert(function);
            return entryFunctions;
        }
    }
    std::map<const clang::FunctionDecl *, unsigned> incomingCalls;
    for (const clang::FunctionDecl *function : functions) {
        incomingCalls[function] = 0;
    }
    for (const auto &[caller, callees] : calls) {
        for (const clang::FunctionDecl *callee : callees) {
            if (callee == caller) {
                continue;
            }
            auto it = incomingCalls.find(callee);
            if (it != incomingCalls.end()) {
                ++it->second;
            }
        }
    }
    for (const auto &[function, count] : incomingCalls) {
        if (count == 0) {
            entryFunctions.insert(function);
        }
    }
    if (!functions.empty() && entryFunctions.empty()) {
        throw std::runtime_error("Unable to determine an entry function: no call-graph root exists (possible mutual recursion).");
    }
    return entryFunctions;
}

}

// >>> NEXUS CHANGE BEGIN [2.4 - mark real entry-function return statements]
// Clang -O0 is free to route both a normal while exit and a C `return;`
// to the same IR ret block.  A source-only, state-preserving marker retained
// in LLVM IR distinguishes the *actual* return statement's outgoing edge.
// Wrapping the statement is essential for unbraced `if (cond) return;`.
bool InlineAttributeInjectorVisitor::TraverseFunctionDecl(clang::FunctionDecl *FD) {
    const bool wasEntry = traversingEntryFunction;
    // >>> NEXUS CHANGE BEGIN [2.4.1 - reset loop nesting per entry function]
    const unsigned previousLoopDepth = sourceLoopDepth;
    sourceLoopDepth = 0;
    // >>> NEXUS CHANGE BEGIN [2.4.4 - distinct IDs for source loops in each entry]
    const auto previousSourceIds = sourceLoopIds;
    const unsigned previousNextId = nextSourceLoopId;
    sourceLoopIds.clear();
    nextSourceLoopId = 0;
    // <<< NEXUS CHANGE END [2.4.4 - distinct IDs for source loops in each entry]
    // <<< NEXUS CHANGE END [2.4.1 - reset loop nesting per entry function]
    traversingEntryFunction = FD && FD->isThisDeclarationADefinition() &&
        entryFunctions.count(FD->getCanonicalDecl()) != 0;
    const bool success = clang::RecursiveASTVisitor<InlineAttributeInjectorVisitor>::TraverseFunctionDecl(FD);
    traversingEntryFunction = wasEntry;
    // >>> NEXUS CHANGE BEGIN [2.4.1 - restore enclosing traversal state]
    sourceLoopDepth = previousLoopDepth;
    // >>> NEXUS CHANGE BEGIN [2.4.4 - restore AST visitor context]
    sourceLoopIds = previousSourceIds;
    nextSourceLoopId = previousNextId;
    // <<< NEXUS CHANGE END [2.4.4 - restore AST visitor context]
    // <<< NEXUS CHANGE END [2.4.1 - restore enclosing traversal state]
    return success;
}

// >>> NEXUS CHANGE BEGIN [2.4.4 - identify source loop scopes in LLVM]
// LoopInfo need not reproduce lexical C nesting: when an inner loop is on a
// branch that only returns, LLVM can report it as a *sibling* of its C parent.
// A state-preserving marker inside each source loop body lets us correlate
// LLVM natural loops with the C AST; lexical depth alone is insufficient.
bool InlineAttributeInjectorVisitor::markSourceLoopBody(
    const clang::Stmt *body, unsigned loopId, unsigned parentId) {
    if (!traversingEntryFunction || !body) return true;
    clang::SourceManager &sm = rewriter.getSourceMgr();
    const clang::SourceLocation begin = body->getBeginLoc();
    const clang::SourceLocation end = body->getEndLoc();
    if (begin.isInvalid() || end.isInvalid() || begin.isMacroID() || end.isMacroID()) {
        return true; // Unsupported macro syntax cannot be rewritten; unmatched return scopes are audited.
    }
    if (!sm.isInMainFile(begin)) return true;
    const std::string marker = " __asm__ __volatile__(\"# NEXUS_SOURCE_LOOP_ID_" +
        std::to_string(loopId) + "_PARENT_" + std::to_string(parentId) +
        "\" ::: \"memory\"); ";
    if (const auto *compound = llvm::dyn_cast<clang::CompoundStmt>(body)) {
        return !rewriter.InsertTextBefore(compound->getLBracLoc().getLocWithOffset(1), marker);
    }
    // An unbraced body must remain a single statement. Lexer handles an
    // expression-statement's trailing semicolon, which is outside its AST range.
    clang::SourceLocation afterBody = clang::Lexer::findLocationAfterToken(
        end, clang::tok::semi, sm, rewriter.getLangOpts(), false);
    if (afterBody.isInvalid()) {
        afterBody = clang::Lexer::getLocForEndOfToken(end, 0, sm, rewriter.getLangOpts());
    }
    if (afterBody.isInvalid() || afterBody.isMacroID()) return false;
    if (rewriter.InsertTextBefore(begin, "{" + marker)) return false;
    return !rewriter.InsertTextBefore(afterBody, " }");
}

bool InlineAttributeInjectorVisitor::TraverseWhileStmt(clang::WhileStmt *statement) {
    const unsigned id = traversingEntryFunction ? ++nextSourceLoopId : 0;
    const unsigned parent = sourceLoopIds.empty() ? 0 : sourceLoopIds.back();
    if (id && !markSourceLoopBody(statement->getBody(), id, parent)) return false;
    if (id) sourceLoopIds.push_back(id);
    ++sourceLoopDepth;
    const bool result = clang::RecursiveASTVisitor<InlineAttributeInjectorVisitor>::TraverseWhileStmt(statement);
    --sourceLoopDepth;
    if (id) sourceLoopIds.pop_back();
    return result;
}
bool InlineAttributeInjectorVisitor::TraverseForStmt(clang::ForStmt *statement) {
    const unsigned id = traversingEntryFunction ? ++nextSourceLoopId : 0;
    const unsigned parent = sourceLoopIds.empty() ? 0 : sourceLoopIds.back();
    if (id && !markSourceLoopBody(statement->getBody(), id, parent)) return false;
    if (id) sourceLoopIds.push_back(id);
    ++sourceLoopDepth;
    const bool result = clang::RecursiveASTVisitor<InlineAttributeInjectorVisitor>::TraverseForStmt(statement);
    --sourceLoopDepth;
    if (id) sourceLoopIds.pop_back();
    return result;
}
bool InlineAttributeInjectorVisitor::TraverseDoStmt(clang::DoStmt *statement) {
    const unsigned id = traversingEntryFunction ? ++nextSourceLoopId : 0;
    const unsigned parent = sourceLoopIds.empty() ? 0 : sourceLoopIds.back();
    if (id && !markSourceLoopBody(statement->getBody(), id, parent)) return false;
    if (id) sourceLoopIds.push_back(id);
    ++sourceLoopDepth;
    const bool result = clang::RecursiveASTVisitor<InlineAttributeInjectorVisitor>::TraverseDoStmt(statement);
    --sourceLoopDepth;
    if (id) sourceLoopIds.pop_back();
    return result;
}
// <<< NEXUS CHANGE END [2.4.4 - identify source loop scopes in LLVM]

bool InlineAttributeInjectorVisitor::VisitReturnStmt(clang::ReturnStmt *RS) {
    if (!traversingEntryFunction || !RS) return true;
    clang::SourceManager& sourceManager = rewriter.getSourceMgr();
    const clang::SourceLocation begin = RS->getBeginLoc();
    const clang::SourceLocation end = RS->getEndLoc();
    // Do not silently lose return provenance inside an uneditable macro.
    if (begin.isInvalid() || end.isInvalid() || begin.isMacroID() || end.isMacroID()) {
        return false;
    }
    if (!sourceManager.isInMainFile(begin)) return true;
    const clang::SourceLocation afterSemicolon = clang::Lexer::findLocationAfterToken(
        end, clang::tok::semi, sourceManager, rewriter.getLangOpts(), false);
    if (afterSemicolon.isInvalid() || afterSemicolon.isMacroID()) return false;
    // >>> NEXUS CHANGE BEGIN [2.4.1 - encode source-level return depth]
    // The marker carries *lexical* loop depth: a source return following a
    // loop is depth 0 and must remain a normal loop EXIT, not a return step.
    // >>> NEXUS CHANGE BEGIN [2.4.4 - encode exact lexical ancestors]
    std::string sourceIds;
    for (unsigned id : sourceLoopIds) sourceIds += "_" + std::to_string(id);
    if (sourceIds.empty()) sourceIds = "_NONE";
    const std::string marker = "{ __asm__ __volatile__(\"# NEXUS_SOURCE_RETURN_DEPTH_" +
        std::to_string(sourceLoopDepth) + "_IDS" + sourceIds + "\" ::: \"memory\"); ";
    // <<< NEXUS CHANGE END [2.4.4 - encode exact lexical ancestors]
    if (rewriter.InsertTextBefore(begin, marker)) {
        return false;
    }
    // <<< NEXUS CHANGE END [2.4.1 - encode source-level return depth]
    if (rewriter.InsertTextBefore(afterSemicolon, " }")) return false;
    return true;
}
// <<< NEXUS CHANGE END [2.4 - mark real entry-function return statements]

bool InlineAttributeInjectorVisitor::VisitFunctionDecl(clang::FunctionDecl *FD) {
    if (FD && FD->isThisDeclarationADefinition()) {
        const clang::FunctionDecl *canonicalFD = FD->getCanonicalDecl();
        if (entryFunctions.find(canonicalFD) == entryFunctions.end()) {
            const clang::SourceLocation beginLoc = FD->getBeginLoc();
            if (beginLoc.isValid() && !beginLoc.isMacroID() || rewriter.getSourceMgr().isInMainFile(beginLoc)) {
                std::string textToInsert;
                if (!FD->hasAttr<clang::AlwaysInlineAttr>()) {
                    textToInsert += "__attribute__((always_inline)) ";
                }
                if (!FD->isInlineSpecified()) {
                    textToInsert += "inline ";
                }
                if (!textToInsert.empty()) {
                    if (rewriter.InsertTextBefore(beginLoc, textToInsert)) {
                        return false;
                    }
                }
            }
        }
    }
    return true;
}

void InlineAttributeInjectorConsumer:: HandleTranslationUnit(clang::ASTContext &context) {
    clang::TranslationUnitDecl *translationUnit = context.getTranslationUnitDecl();

    //PASS 1:
    FunctionGraphCollector collector(rewriter.getSourceMgr());
    if (!collector.TraverseDecl(translationUnit)) {
        throw std::runtime_error("Failed to analyze the translation-unit call graph.");
    }
    const std::set<const clang::FunctionDecl *> entryFunctions = findEntryFunctions(collector);
    entryFunctionNames.clear();
    for (const clang::FunctionDecl *FD : entryFunctions) {
        entryFunctionNames.insert(FD->getNameAsString());
    }

    //PASS 2:
    InlineAttributeInjectorVisitor visitor(rewriter, entryFunctions);
    if (!visitor.TraverseDecl(translationUnit)) {
        throw std::runtime_error("Failed to inject always_inline attributes.");
    }

    //Write transformed C source.
    std::error_code errorCode;
    llvm::raw_fd_ostream outputStream(outputPath.string(), errorCode, llvm::sys::fs::OF_Text);
    if (errorCode) {
        throw std::runtime_error("Failed to open output file '" + outputPath.string() + "': " + errorCode.message());
    }

    clang::SourceManager &sourceManager = rewriter.getSourceMgr();

    clang::FileID mainFileID = sourceManager.getMainFileID();

    const auto *rewriteBuffer = rewriter.getRewriteBufferFor(mainFileID);
    if (rewriteBuffer != nullptr) {
        rewriteBuffer->write(outputStream);
    }
    else {
        bool invalid = false;
        llvm::StringRef originalCode = sourceManager.getBufferData(mainFileID, &invalid);
        if (invalid) {
            throw std::runtime_error("Failed to read the main source file.");
        }
        outputStream << originalCode;
    }
    outputStream.close();
    if (outputStream.has_error()) {
        throw std::runtime_error("Failed to write output file: " + outputPath.string());
    }
}

std::unique_ptr<clang::ASTConsumer> InlineAttributeInjectorAction::CreateASTConsumer(clang::CompilerInstance &compiler, llvm::StringRef) {
    rewriter.setSourceMgr(compiler.getSourceManager(), compiler.getLangOpts());
    return std::make_unique<InlineAttributeInjectorConsumer>(rewriter, outputPath, entryFunctionNames);
}