#include "../include/experiment_recorder.h"

bool ExperimentRecorder::record(const std::filesystem::path& experimentResultsPath, const ExperimentResult& experimentResult) {
    try {
        OpenXLSX::XLDocument document;

        const bool newWorkbook = !std::filesystem::exists(experimentResultsPath);

        if (newWorkbook) {
            document.create(experimentResultsPath.string(), OpenXLSX::XLForceOverwrite);
        }
        else {
            document.open(experimentResultsPath.string());
        }

        auto worksheet = document.workbook().worksheet("Sheet1");

        if (newWorkbook) {
            worksheet.cell(1, 1).value() = "Program";
            worksheet.cell(1, 2).value() = "Ground Truth";
            worksheet.cell(1, 3).value() = "Total Loops";
            worksheet.cell(1, 4).value() = "Analyzed Loops";
            worksheet.cell(1, 5).value() = "Initial Verdict";
            worksheet.cell(1, 6).value() = "Final Verdict";
            worksheet.cell(1, 7).value() = "Initial Analysis Time (ms)";
            worksheet.cell(1, 8).value() = "Total Analysis Time (ms)";
            worksheet.cell(1, 9).value() = "Initial Synthesis Calls";
            worksheet.cell(1, 10).value() = "Initial Synthesis Time (ms)";
            worksheet.cell(1, 11).value() = "Initial Synthesis Input Tokens";
            worksheet.cell(1, 12).value() = "Initial Synthesis Output Tokens";
            worksheet.cell(1, 13).value() = "Initial Synthesis Cost (USD)";
            worksheet.cell(1, 14).value() = "Grammar Refinement Calls";
            worksheet.cell(1, 15).value() = "Grammar Refinement Time (ms)";
            worksheet.cell(1, 16).value() = "Grammar Refinement Input Tokens";
            worksheet.cell(1, 17).value() = "Grammar Refinement Output Tokens";
            worksheet.cell(1, 18).value() = "Grammar Refinement Cost (USD)";
            worksheet.cell(1, 19).value() = "Analysis Refinement Calls";
            worksheet.cell(1, 20).value() = "Analysis Refinement Time (ms)";
            worksheet.cell(1, 21).value() = "Analysis Refinement Input Tokens";
            worksheet.cell(1, 22).value() = "Analysis Refinement Output Tokens";
            worksheet.cell(1, 23).value() = "Analysis Refinement Cost (USD)";
        }

        std::uint32_t targetRow = 0;
        std::uint32_t firstEmptyRow = 0;
        const std::uint32_t lastRow = std::max<std::uint32_t>(worksheet.rowCount(), 1);

        for (std::uint32_t row = 2; row <= lastRow; ++row) {
            const OpenXLSX::XLCellValue programCell = worksheet.cell(row, 1).value();
            if (programCell.type() == OpenXLSX::XLValueType::Empty) {
                if (firstEmptyRow == 0) {
                    firstEmptyRow = row;
                }
                continue;
            }
            if (programCell.type() != OpenXLSX::XLValueType::String) {
                continue;
            }
            const std::string existingProgram = programCell.get<std::string>();
            if (existingProgram.empty()) {
                if (firstEmptyRow == 0) {
                    firstEmptyRow = row;
                }
                continue;
            }
            if (existingProgram == experimentResult.program) {
                targetRow = row;
                break;
            }
        }
        if (targetRow == 0) {
            if (firstEmptyRow != 0) {
                targetRow = firstEmptyRow;
            }
            else {
                targetRow = lastRow + 1;
            }
        }

        worksheet.cell(targetRow, 1).value() = experimentResult.program;
        worksheet.cell(targetRow, 3).value() = experimentResult.totalLoops;
        worksheet.cell(targetRow, 4).value() = experimentResult.analyzedLoops;
        worksheet.cell(targetRow, 5).value() = experimentResult.initialVerdict;
        worksheet.cell(targetRow, 6).value() = experimentResult.finalVerdict;
        worksheet.cell(targetRow, 7).value() = experimentResult.initialAnalysisTime;
        worksheet.cell(targetRow, 8).value() = experimentResult.totalAnalysisTime;
        worksheet.cell(targetRow, 9).value() = experimentResult.initialSynthesisCalls;
        worksheet.cell(targetRow, 10).value() = experimentResult.initialSynthesisTime;
        worksheet.cell(targetRow, 11).value() = static_cast<std::int64_t>(experimentResult.initialSynthesisInputTokens);
        worksheet.cell(targetRow, 12).value() = static_cast<std::int64_t>(experimentResult.initialSynthesisOutputTokens);
        worksheet.cell(targetRow, 13).value() = experimentResult.initialSynthesisCost;
        worksheet.cell(targetRow, 14).value() = experimentResult.grammarRefinementCalls;
        worksheet.cell(targetRow, 15).value() = experimentResult.grammarRefinementTime;
        worksheet.cell(targetRow, 16).value() = static_cast<std::int64_t>(experimentResult.grammarRefinementInputTokens);
        worksheet.cell(targetRow, 17).value() = static_cast<std::int64_t>(experimentResult.grammarRefinementOutputTokens);
        worksheet.cell(targetRow, 18).value() = experimentResult.grammarRefinementCost;
        worksheet.cell(targetRow, 19).value() = experimentResult.analysisRefinementCalls;
        worksheet.cell(targetRow, 20).value() = experimentResult.analysisRefinementTime;
        worksheet.cell(targetRow, 21).value() = static_cast<std::int64_t>(experimentResult.analysisRefinementInputTokens);
        worksheet.cell(targetRow, 22).value() = static_cast<std::int64_t>(experimentResult.analysisRefinementOutputTokens);
        worksheet.cell(targetRow, 23).value() = experimentResult.analysisRefinementCost;

        document.save();
        document.close();

        return true;
    }
    catch (const std::exception& ex) {
        std::cerr << "ExperimentRecorder::record error: " << ex.what() << '\n';
        return false;
    }
}