#include "../include/result_recorder.h"

bool ResultRecorder::record(const ProgramResult& programResult, const std::vector<LoopResult>& loopResults, const std::string& llmModel, const std::filesystem::path& resultsPath) {
    try {
        OpenXLSX::XLDocument document;
        const bool newWorkbook = !std::filesystem::exists(resultsPath);
        if (newWorkbook) {
            document.create(resultsPath.string(), OpenXLSX::XLForceOverwrite);
        }
        else {
            document.open(resultsPath.string());
        }
        bool newWorksheet = false;
        if (newWorkbook) {
            auto worksheet = document.workbook().worksheet("Sheet1");
            worksheet.setName(llmModel);
            newWorksheet = true;
        }
        else if (!document.workbook().worksheetExists(llmModel)) {
            document.workbook().addWorksheet(llmModel);
            newWorksheet = true;
        }
        auto worksheet = document.workbook().worksheet(llmModel);
        if (newWorksheet) {
            std::vector<std::string> headers = {
                // Program
                "Program_Path",
                "Program_TotalLoops",
                "Program_AnalyzedLoops",
                "Program_GT",

                "Program_FirstVerdict",
                "Program_FirstSemanticCheckPassed",
                "Program_FirstAnalysisTime",

                "Program_FinalVerdict",

                "Program_LoopInformationExtractionTime",

                // Program Checks
                "Program_SyntacticCheckTime",
                "Program_SemanticCheckTime",

                // Program Initial Synthesis
                "Program_InitialSynthesisCalls",
                "Program_InitialSynthesisInputTokens",
                "Program_InitialSynthesisOutputTokens",
                "Program_InitialSynthesisCost",
                "Program_InitialSynthesisTime",

                // Program Syntactic Refinement
                "Program_SyntacticRefinementCalls",
                "Program_SyntacticRefinementInputTokens",
                "Program_SyntacticRefinementOutputTokens",
                "Program_SyntacticRefinementCost",
                "Program_SyntacticRefinementTime",

                // Program Semantic Refinement
                "Program_SemanticRefinementCalls",
                "Program_SemanticRefinementInputTokens",
                "Program_SemanticRefinementOutputTokens",
                "Program_SemanticRefinementCost",
                "Program_SemanticRefinementTime",

                // Program Final
                "Program_FinalAnalysisTime",

                // Loop
                "Loop_ID",
                "Loop_GT",

                "Loop_FirstVerdict",
                "Loop_FirstSemanticCheckPassed",
                "Loop_FirstAnalysisTime",

                "Loop_FinalVerdict",

                "Loop_LoopInformationExtractionTime",

                // Loop Checks
                "Loop_SyntacticCheckTime",
                "Loop_SemanticCheckTime",

                // Loop Initial Synthesis
                "Loop_InitialSynthesisCalls",
                "Loop_InitialSynthesisInputTokens",
                "Loop_InitialSynthesisOutputTokens",
                "Loop_InitialSynthesisCost",
                "Loop_InitialSynthesisTime",

                // Loop Syntactic Refinement
                "Loop_SyntacticRefinementCalls",
                "Loop_SyntacticRefinementInputTokens",
                "Loop_SyntacticRefinementOutputTokens",
                "Loop_SyntacticRefinementCost",
                "Loop_SyntacticRefinementTime",

                // Loop Semantic Refinement
                "Loop_SemanticRefinementCalls",
                "Loop_SemanticRefinementInputTokens",
                "Loop_SemanticRefinementOutputTokens",
                "Loop_SemanticRefinementCost",
                "Loop_SemanticRefinementTime",

                // Loop Final
                "Loop_FinalAnalysisTime"
            };
            for (std::size_t column = 0; column < headers.size(); ++column) {
                worksheet.cell(1, static_cast<std::uint16_t>(column + 1)).value() = headers[column];
            }
        }
        constexpr std::uint32_t numberOfColumns = 52;
        const std::uint32_t requiredRows = std::max<std::uint32_t>(1, static_cast<std::uint32_t>(loopResults.size()));
        const std::uint32_t lastRow = std::max<std::uint32_t>(worksheet.rowCount(), 1);
        std::uint32_t programStartRow = 0;
        std::uint32_t nextProgramStartRow = 0;
        for (std::uint32_t row = 2; row <= lastRow; ++row) {
            const OpenXLSX::XLCellValue programCell = worksheet.cell(row, 1).value();
            if (programCell.type() != OpenXLSX::XLValueType::String) {
                continue;
            }
            const std::string existingProgram = programCell.get<std::string>();
            if (existingProgram == programResult.programPath) {
                programStartRow = row;
                break;
            }
        }
        std::uint32_t existingBlockRows = 0;
        if (programStartRow != 0) {
            for (std::uint32_t row = programStartRow + 1; row <= lastRow; ++row) {
                const OpenXLSX::XLCellValue programCell = worksheet.cell(row, 1).value();
                if (programCell.type() != OpenXLSX::XLValueType::String) {
                    continue;
                }
                const std::string programPath = programCell.get<std::string>();
                if (!programPath.empty()) {
                    nextProgramStartRow = row;
                    break;
                }
            }
            if (nextProgramStartRow != 0) {
                existingBlockRows = nextProgramStartRow - programStartRow;
            }
            else {
                existingBlockRows = lastRow - programStartRow + 1;
            }
        }
        if (programStartRow == 0) {
            programStartRow = std::max<std::uint32_t>(2, lastRow + 1);
        }
        else if (requiredRows > existingBlockRows && nextProgramStartRow != 0) {
            for (std::uint32_t row = programStartRow; row < programStartRow + existingBlockRows; ++row) {
                for (std::uint32_t column = 1; column <= numberOfColumns; ++column) {
                    worksheet.cell(row, column).value() = "";
                }
            }
            programStartRow = lastRow + 1;
            existingBlockRows = 0;
        }
        if (existingBlockRows > 0) {
            for (std::uint32_t row = programStartRow; row < programStartRow + existingBlockRows; ++row) {
                for (std::uint32_t column = 1; column <= numberOfColumns; ++column) {
                    worksheet.cell(row, column).value() = "";
                }
            }
        }
        const std::uint32_t row = programStartRow;
        worksheet.cell(row, 1).value() = programResult.programPath;
        worksheet.cell(row, 2).value() = programResult.totalLoops;
        worksheet.cell(row, 3).value() = programResult.analyzedLoops;
        worksheet.cell(row, 4).value() = programResult.groundTruth;
        worksheet.cell(row, 5).value() = programResult.firstVerdict;
        worksheet.cell(row, 6).value() = programResult.firstSemanticCheckPassed;
        worksheet.cell(row, 7).value() = programResult.firstAnalysisTime;
        worksheet.cell(row, 8).value() = programResult.finalVerdict;
        worksheet.cell(row, 9).value() = programResult.loopInformationExtractionTime;
        worksheet.cell(row, 10).value() = programResult.syntacticCheckTime;
        worksheet.cell(row, 11).value() = programResult.semanticCheckTime;
        worksheet.cell(row, 12).value() = programResult.initialSynthesisCalls;
        worksheet.cell(row, 13).value() = static_cast<std::int64_t>(programResult.initialSynthesisInputTokens);
        worksheet.cell(row, 14).value() = static_cast<std::int64_t>(programResult.initialSynthesisOutputTokens);
        worksheet.cell(row, 15).value() = programResult.initialSynthesisCost;
        worksheet.cell(row, 16).value() = programResult.initialSynthesisTime;
        worksheet.cell(row, 17).value() = programResult.syntacticRefinementCalls;
        worksheet.cell(row, 18).value() = static_cast<std::int64_t>(programResult.syntacticRefinementInputTokens);
        worksheet.cell(row, 19).value() = static_cast<std::int64_t>(programResult.syntacticRefinementOutputTokens);
        worksheet.cell(row, 20).value() = programResult.syntacticRefinementCost;
        worksheet.cell(row, 21).value() = programResult.syntacticRefinementTime;
        worksheet.cell(row, 22).value() = programResult.semanticRefinementCalls;
        worksheet.cell(row, 23).value() = static_cast<std::int64_t>(programResult.semanticRefinementInputTokens);
        worksheet.cell(row, 24).value() = static_cast<std::int64_t>(programResult.semanticRefinementOutputTokens);
        worksheet.cell(row, 25).value() = programResult.semanticRefinementCost;
        worksheet.cell(row, 26).value() = programResult.semanticRefinementTime;
        worksheet.cell(row, 27).value() = programResult.finalAnalysisTime;
        for (std::size_t loopIndex = 0; loopIndex < loopResults.size(); ++loopIndex) {
            const LoopResult& loopResult = loopResults[loopIndex];
            const std::uint32_t loopRow = programStartRow + static_cast<std::uint32_t>(loopIndex);
            worksheet.cell(loopRow, 28).value() = loopResult.loopId;
            worksheet.cell(loopRow, 29).value() = loopResult.groundTruth;
            worksheet.cell(loopRow, 30).value() = loopResult.firstVerdict;
            worksheet.cell(loopRow, 31).value() = loopResult.firstSemanticCheckPassed;
            worksheet.cell(loopRow, 32).value() = loopResult.firstAnalysisTime;
            worksheet.cell(loopRow, 33).value() = loopResult.finalVerdict;
            worksheet.cell(loopRow, 34).value() = loopResult.loopInformationExtractionTime;
            worksheet.cell(loopRow, 35).value() = loopResult.syntacticCheckTime;
            worksheet.cell(loopRow, 36).value() = loopResult.semanticCheckTime;
            worksheet.cell(loopRow, 37).value() = loopResult.initialSynthesisCalls;
            worksheet.cell(loopRow, 38).value() = static_cast<std::int64_t>(loopResult.initialSynthesisInputTokens);
            worksheet.cell(loopRow, 39).value() = static_cast<std::int64_t>(loopResult.initialSynthesisOutputTokens);
            worksheet.cell(loopRow, 40).value() = loopResult.initialSynthesisCost;
            worksheet.cell(loopRow, 41).value() = loopResult.initialSynthesisTime;
            worksheet.cell(loopRow, 42).value() = loopResult.syntacticRefinementCalls;
            worksheet.cell(loopRow, 43).value() = static_cast<std::int64_t>(loopResult.syntacticRefinementInputTokens);
            worksheet.cell(loopRow, 44).value() = static_cast<std::int64_t>(loopResult.syntacticRefinementOutputTokens);
            worksheet.cell(loopRow, 45).value() = loopResult.syntacticRefinementCost;
            worksheet.cell(loopRow, 46).value() = loopResult.syntacticRefinementTime;
            worksheet.cell(loopRow, 47).value() = loopResult.semanticRefinementCalls;
            worksheet.cell(loopRow, 48).value() = static_cast<std::int64_t>(loopResult.semanticRefinementInputTokens);
            worksheet.cell(loopRow, 49).value() = static_cast<std::int64_t>(loopResult.semanticRefinementOutputTokens);
            worksheet.cell(loopRow, 50).value() = loopResult.semanticRefinementCost;
            worksheet.cell(loopRow, 51).value() = loopResult.semanticRefinementTime;
            worksheet.cell(loopRow, 52).value() = loopResult.finalAnalysisTime;
        }
        document.save();
        document.close();
        return true;
    }
    catch (const std::exception& ex) {
        std::cerr << "ResultRecorder::record error: " << ex.what() << '\n';
        return false;
    }
}