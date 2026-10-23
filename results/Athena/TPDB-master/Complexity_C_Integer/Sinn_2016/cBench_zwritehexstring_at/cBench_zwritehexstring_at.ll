; ModuleID = 'cBench_zwritehexstring_at.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind uwtable
define void @zwritehexstring_at_extracted(i32 %len) #0 {
zwritehexstring_at_extracted_bb0:
  call void @llvm.dbg.value(metadata !{i32 %len}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !{i32 %.0.}, i64 0, metadata !14), !dbg !16
  call void @llvm.dbg.value(metadata !{i32 %.0.}, i64 0, metadata !17), !dbg !18
  call void @llvm.dbg.value(metadata !{i32 %"2"}, i64 0, metadata !17), !dbg !18
  br label %zwritehexstring_at_extracted_bb1, !dbg !19

zwritehexstring_at_extracted_bb1:                 ; preds = %zwritehexstring_at_extracted_bb4, %zwritehexstring_at_extracted_bb0
  %.0 = phi i32 [ %len, %zwritehexstring_at_extracted_bb0 ], [ %"4", %zwritehexstring_at_extracted_bb4 ]
  %"0" = icmp sgt i32 %.0, 0, !dbg !20
  br i1 %"0", label %zwritehexstring_at_extracted_bb2, label %zwritehexstring_at_extracted_bb5, !dbg !20

zwritehexstring_at_extracted_bb2:                 ; preds = %zwritehexstring_at_extracted_bb1
  %"1" = icmp slt i32 %.0, 64, !dbg !22
  %.0. = select i1 %"1", i32 %.0, i32 64, !dbg !23
  br label %zwritehexstring_at_extracted_bb3, !dbg !25

zwritehexstring_at_extracted_bb3:                 ; preds = %zwritehexstring_at_extracted_bb2, %zwritehexstring_at_extracted_bb3
  %count.0 = phi i32 [ %.0., %zwritehexstring_at_extracted_bb2 ], [ %"2", %zwritehexstring_at_extracted_bb3 ]
  %"2" = add nsw i32 %count.0, -1, !dbg !26
  %"3" = icmp sgt i32 %"2", 0, !dbg !26
  br i1 %"3", label %zwritehexstring_at_extracted_bb3, label %zwritehexstring_at_extracted_bb4, !dbg !26

zwritehexstring_at_extracted_bb4:                 ; preds = %zwritehexstring_at_extracted_bb3
  %"4" = sub nsw i32 %.0, %.0., !dbg !29
  call void @llvm.dbg.value(metadata !{i32 %"4"}, i64 0, metadata !12), !dbg !13
  br label %zwritehexstring_at_extracted_bb1, !dbg !30

zwritehexstring_at_extracted_bb5:                 ; preds = %zwritehexstring_at_extracted_bb1
  ret void, !dbg !31
}

; Function Attrs: nounwind readnone
declare void @llvm.dbg.declare(metadata, metadata) #1

declare i32 @__kittel_nondef.0()

; Function Attrs: nounwind readnone
declare void @llvm.dbg.value(metadata, i64, metadata) #1

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!9, !10}
!llvm.ident = !{!11}

!0 = metadata !{i32 786449, metadata !1, i32 12, metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)", i1 false, metadata !"", i32 0, metadata !2, metadata !2, metadata !3, metadata !2, metadata !2, metadata !"", i32 1} ; [ DW_TAG_compile_unit ] [/liveness_analysis/cBench_zwritehexstring_at.c] [DW_LANG_C99]
!1 = metadata !{metadata !"cBench_zwritehexstring_at.c", metadata !"/liveness_analysis"}
!2 = metadata !{}
!3 = metadata !{metadata !4}
!4 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"zwritehexstring_at_extracted", metadata !"zwritehexstring_at_extracted", metadata !"", i32 5, metadata !6, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (i32)* @zwritehexstring_at_extracted, null, null, metadata !2, i32 5} ; [ DW_TAG_subprogram ] [line 5] [def] [zwritehexstring_at_extracted]
!5 = metadata !{i32 786473, metadata !1}          ; [ DW_TAG_file_type ] [/liveness_analysis/cBench_zwritehexstring_at.c]
!6 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !7, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!7 = metadata !{null, metadata !8}
!8 = metadata !{i32 786468, null, null, metadata !"int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!9 = metadata !{i32 2, metadata !"Dwarf Version", i32 4}
!10 = metadata !{i32 2, metadata !"Debug Info Version", i32 1}
!11 = metadata !{metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)"}
!12 = metadata !{i32 786689, metadata !4, metadata !"len", metadata !5, i32 16777221, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [len] [line 5]
!13 = metadata !{i32 5, i32 39, metadata !4, null}
!14 = metadata !{i32 786688, metadata !15, metadata !"len1", metadata !5, i32 7, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [len1] [line 7]
!15 = metadata !{i32 786443, metadata !1, metadata !4, i32 6, i32 21, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_zwritehexstring_at.c]
!16 = metadata !{i32 7, i32 6, metadata !15, null}
!17 = metadata !{i32 786688, metadata !15, metadata !"count", metadata !5, i32 8, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [count] [line 8]
!18 = metadata !{i32 8, i32 6, metadata !15, null} ; [ DW_TAG_imported_declaration ]
!19 = metadata !{i32 6, i32 5, metadata !4, null}
!20 = metadata !{i32 6, i32 5, metadata !21, null}
!21 = metadata !{i32 786443, metadata !1, metadata !4, i32 6, i32 5, i32 1, i32 2} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_zwritehexstring_at.c]
!22 = metadata !{i32 7, i32 2, metadata !15, null}
!23 = metadata !{i32 7, i32 2, metadata !24, null}
!24 = metadata !{i32 786443, metadata !1, metadata !15, i32 7, i32 2, i32 1, i32 3} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_zwritehexstring_at.c]
!25 = metadata !{i32 9, i32 2, metadata !15, null}
!26 = metadata !{i32 10, i32 2, metadata !27, null}
!27 = metadata !{i32 786443, metadata !1, metadata !28, i32 10, i32 2, i32 1, i32 7} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_zwritehexstring_at.c]
!28 = metadata !{i32 786443, metadata !1, metadata !15, i32 9, i32 5, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_zwritehexstring_at.c]
!29 = metadata !{i32 11, i32 2, metadata !15, null}
!30 = metadata !{i32 12, i32 5, metadata !15, null}
!31 = metadata !{i32 13, i32 1, metadata !4, null}

