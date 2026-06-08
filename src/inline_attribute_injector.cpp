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
                rewriter.InsertTextBefore(beginLoc, textToInsert);
            }
        }
    }
    return true;
}

void InlineAttributeInjectorConsumer::HandleTranslationUnit(clang::ASTContext &context) {
    std::error_code errorCode;
    llvm::raw_fd_ostream outputStream(outputPath.string(), errorCode, llvm::sys::fs::OF_Text);
    if (errorCode) {
        llvm::errs() << "Failed to open output file: " << outputPath.string() << "\n";
        return;
    }

    visitor.TraverseDecl(context.getTranslationUnitDecl());

    clang::SourceManager &sourceManager = rewriter.getSourceMgr();

    clang::FileID mainFileID = sourceManager.getMainFileID();

    const auto *rewriteBuffer = rewriter.getRewriteBufferFor(mainFileID);
    if (rewriteBuffer != nullptr) {
        rewriteBuffer->write(outputStream);
        outputStream.close();
        return;
    }

    bool invalid = false;
    llvm::StringRef originalCode = sourceManager.getBufferData(mainFileID, &invalid);
    if (!invalid) {
        outputStream << originalCode;
    }
    outputStream.close();
}

std::unique_ptr<clang::ASTConsumer> InlineAttributeInjectorAction::CreateASTConsumer(clang::CompilerInstance &compiler, llvm::StringRef inputFile) {
    rewriter.setSourceMgr(compiler.getSourceManager(), compiler.getLangOpts());
    return std::make_unique<InlineAttributeInjectorConsumer>(&compiler.getASTContext(), rewriter, outputPath);
}