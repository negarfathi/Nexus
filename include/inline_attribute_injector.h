#ifndef INLINE_ATTRIBUTE_INJECTOR_H
#define INLINE_ATTRIBUTE_INJECTOR_H

#include <filesystem>

#include "clang/Rewrite/Core/Rewriter.h"
#include "clang/Frontend/FrontendAction.h"
#include "clang/AST/RecursiveASTVisitor.h"
#include "clang/Frontend/CompilerInstance.h"

class InlineAttributeInjectorVisitor : public clang::RecursiveASTVisitor<InlineAttributeInjectorVisitor> {
public:
    InlineAttributeInjectorVisitor(clang::Rewriter &rewriter, const std::set<const clang::FunctionDecl *> &entryFunctions) : rewriter(rewriter), entryFunctions(entryFunctions) {}
    bool VisitFunctionDecl(clang::FunctionDecl *FD);

private:
    clang::Rewriter &rewriter;
    const std::set<const clang::FunctionDecl *> &entryFunctions;
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