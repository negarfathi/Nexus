#ifndef INLINE_ATTRIBUTE_INJECTOR_H
#define INLINE_ATTRIBUTE_INJECTOR_H

#include <filesystem>

#include "clang/Rewrite/Core/Rewriter.h"
#include "clang/Frontend/FrontendAction.h"
#include "clang/AST/RecursiveASTVisitor.h"

class InlineAttributeInjectorVisitor : public clang::RecursiveASTVisitor<InlineAttributeInjectorVisitor> {
    public:
        InlineAttributeInjectorVisitor(clang::Rewriter &rewriter) : rewriter(rewriter) {}
        bool VisitFunctionDecl(clang::FunctionDecl *FD);

    private:
        clang::Rewriter &rewriter;
};

class InlineAttributeInjectorConsumer : public clang::ASTConsumer {
    public:
        InlineAttributeInjectorConsumer(clang::Rewriter &rewriter, const std::filesystem::path &outputPath) : visitor(rewriter), rewriter(rewriter), outputPath(outputPath) {}
        void HandleTranslationUnit(clang::ASTContext &context) override;

    private:
        InlineAttributeInjectorVisitor visitor;
        clang::Rewriter &rewriter;
        std::filesystem::path outputPath;
};

class InlineAttributeInjectorAction : public clang::ASTFrontendAction {
    public:
        explicit InlineAttributeInjectorAction(const std::filesystem::path &outputPath) : outputPath(outputPath) {}
        std::unique_ptr<clang::ASTConsumer> CreateASTConsumer(clang::CompilerInstance &compiler, llvm::StringRef) override;

    private:
        clang::Rewriter rewriter;
        std::filesystem::path outputPath;
};

#endif // INLINE_ATTRIBUTE_INJECTOR_H