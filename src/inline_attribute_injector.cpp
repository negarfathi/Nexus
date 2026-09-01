#include "../include/inline_attribute_injector.h"

bool InlineAttributeInjectorVisitor::VisitFunctionDecl(clang::FunctionDecl *FD) {
    if (FD && FD->isThisDeclarationADefinition() && !FD->isMain()) {
        clang::SourceLocation beginLoc = FD->getBeginLoc();
        if (beginLoc.isValid() && !beginLoc.isMacroID() && rewriter.getSourceMgr().isInMainFile(beginLoc)) {
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
    return true;
}

void InlineAttributeInjectorConsumer::HandleTranslationUnit(clang::ASTContext &context) {
    std::error_code errorCode;
    llvm::raw_fd_ostream outputStream(outputPath.string(), errorCode, llvm::sys::fs::OF_Text);
    if (errorCode) {
        throw std::runtime_error("Failed to open output file '" + outputPath.string() + "': " + errorCode.message());
    }

    if (!visitor.TraverseDecl(context.getTranslationUnitDecl())) {
        throw std::runtime_error("Failed to traverse the translation unit.");
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
    return std::make_unique<InlineAttributeInjectorConsumer>(rewriter, outputPath);
}