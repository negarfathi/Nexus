#ifndef INLINE_ATTRIBUTE_INJECTOR_H
#define INLINE_ATTRIBUTE_INJECTOR_H

#include <filesystem>
// >>> NEXUS CHANGE BEGIN [2.4.4 - lexical scope stack container]
#include <vector>
// <<< NEXUS CHANGE END [2.4.4 - lexical scope stack container]

#include "clang/Rewrite/Core/Rewriter.h"
#include "clang/Frontend/FrontendAction.h"
#include "clang/AST/RecursiveASTVisitor.h"
#include "clang/Frontend/CompilerInstance.h"

class InlineAttributeInjectorVisitor : public clang::RecursiveASTVisitor<InlineAttributeInjectorVisitor> {
public:
    InlineAttributeInjectorVisitor(clang::Rewriter &rewriter, const std::set<const clang::FunctionDecl *> &entryFunctions) : rewriter(rewriter), entryFunctions(entryFunctions) {}
    bool VisitFunctionDecl(clang::FunctionDecl *FD);
    // >>> NEXUS CHANGE BEGIN [2.4 - preserve source-level return provenance]
    bool TraverseFunctionDecl(clang::FunctionDecl *FD);
    // >>> NEXUS CHANGE BEGIN [2.4.1 - track lexical nesting of source loops]
    bool TraverseWhileStmt(clang::WhileStmt *statement);
    bool TraverseForStmt(clang::ForStmt *statement);
    bool TraverseDoStmt(clang::DoStmt *statement);
    // <<< NEXUS CHANGE END [2.4.1 - track lexical nesting of source loops]
    bool VisitReturnStmt(clang::ReturnStmt *RS);
    // <<< NEXUS CHANGE END [2.4 - preserve source-level return provenance]

private:
    clang::Rewriter &rewriter;
    const std::set<const clang::FunctionDecl *> &entryFunctions;
    // >>> NEXUS CHANGE BEGIN [2.4 - identify entry function returns only]
    bool traversingEntryFunction = false;
    // >>> NEXUS CHANGE BEGIN [2.4.1 - source loop depth for return provenance]
    unsigned sourceLoopDepth = 0;
    // >>> NEXUS CHANGE BEGIN [2.4.4 - preserve source loop identity]
    unsigned nextSourceLoopId = 0;
    std::vector<unsigned> sourceLoopIds;
    bool markSourceLoopBody(const clang::Stmt *body, unsigned loopId, unsigned parentId);
    // <<< NEXUS CHANGE END [2.4.4 - preserve source loop identity]
    // <<< NEXUS CHANGE END [2.4.1 - source loop depth for return provenance]
    // <<< NEXUS CHANGE END [2.4 - identify entry function returns only]
};

class InlineAttributeInjectorConsumer : public clang::ASTConsumer {
public:
    InlineAttributeInjectorConsumer(clang::Rewriter &rewriter, const std::filesystem::path &outputPath, std::set<std::string> &entryFunctionNames) : rewriter(rewriter), outputPath(outputPath), entryFunctionNames(entryFunctionNames) {}
    void HandleTranslationUnit(clang::ASTContext &context) override;

private:
    clang::Rewriter &rewriter;
    std::filesystem::path outputPath;
    std::set<std::string> &entryFunctionNames;
};

class InlineAttributeInjectorAction : public clang::ASTFrontendAction {
public:
    InlineAttributeInjectorAction(const std::filesystem::path &outputPath, std::set<std::string> &entryFunctionNames) : outputPath(outputPath), entryFunctionNames(entryFunctionNames) {}
    std::unique_ptr<clang::ASTConsumer> CreateASTConsumer(clang::CompilerInstance &compiler, llvm::StringRef) override;

private:
    clang::Rewriter rewriter;
    std::filesystem::path outputPath;
    std::set<std::string> &entryFunctionNames;
};

#endif // INLINE_ATTRIBUTE_INJECTOR_H