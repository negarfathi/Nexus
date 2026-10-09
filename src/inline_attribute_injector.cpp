#include "../include/inline_attribute_injector.h"

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