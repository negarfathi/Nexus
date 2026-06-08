#ifndef INLINE_ATTRIBUTE_INJECTOR_H
#define INLINE_ATTRIBUTE_INJECTOR_H

#include <filesystem>

#include "clang/Rewrite/Core/Rewriter.h"
#include "clang/Frontend/FrontendAction.h"
#include "clang/AST/RecursiveASTVisitor.h"

class InlineAttributeInjectorVisitor : public clang::RecursiveASTVisitor<InlineAttributeInjectorVisitor> {
    public:
        InlineAttributeInjectorVisitor(clang::ASTContext *context, clang::Rewriter &rewriter) : context(context), rewriter(rewriter) {}
        bool VisitFunctionDecl(clang::FunctionDecl *FD);

    private:
        clang::ASTContext *context;
        clang::Rewriter &rewriter;
};

class InlineAttributeInjectorConsumer : public clang::ASTConsumer {
    public:
        InlineAttributeInjectorConsumer(clang::ASTContext *context, clang::Rewriter &rewriter, const std::filesystem::path &outputPath) : visitor(context, rewriter), rewriter(rewriter), outputPath(outputPath) {}
        void HandleTranslationUnit(clang::ASTContext &context) override;

    private:
        InlineAttributeInjectorVisitor visitor;
        clang::Rewriter &rewriter;
        std::filesystem::path outputPath;
};

class InlineAttributeInjectorAction : public clang::ASTFrontendAction {
    public:
        explicit InlineAttributeInjectorAction(const std::filesystem::path &outputPath) : outputPath(outputPath) {}
        std::unique_ptr<clang::ASTConsumer> CreateASTConsumer(clang::CompilerInstance &compiler, llvm::StringRef inputFile) override;

    private:
        clang::Rewriter rewriter;
        std::filesystem::path outputPath;
};

#endif // INLINE_ATTRIBUTE_INJECTOR_H