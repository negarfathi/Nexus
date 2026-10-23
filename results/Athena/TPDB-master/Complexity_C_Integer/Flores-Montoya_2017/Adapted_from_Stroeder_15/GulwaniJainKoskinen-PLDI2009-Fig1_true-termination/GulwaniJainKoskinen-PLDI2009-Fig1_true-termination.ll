; ModuleID = 'GulwaniJainKoskinen-PLDI2009-Fig1_true-termination.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind uwtable
define i32 @foo(i32 %id, i32 %maxId, i32 %tmp) #0 {
foo_bb0:
  call void @llvm.dbg.value(metadata !{i32 %id}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !{i32 %maxId}, i64 0, metadata !14), !dbg !15
  call void @llvm.dbg.value(metadata !{i32 %tmp}, i64 0, metadata !16), !dbg !17
  %"0" = icmp sle i32 0, %id, !dbg !18
  %"1" = icmp slt i32 %id, %maxId, !dbg !20
  %or.cond = and i1 %"0", %"1", !dbg !18
  br i1 %or.cond, label %foo_bb1, label %foo_.critedge, !dbg !18

foo_bb1:                                          ; preds = %foo_bb0
  %"2" = add nsw i32 %id, 1, !dbg !22
  call void @llvm.dbg.value(metadata !{i32 %"2"}, i64 0, metadata !16), !dbg !17
  call void @llvm.dbg.value(metadata !{i32 %"7"}, i64 0, metadata !16), !dbg !17
  call void @llvm.dbg.value(metadata !24, i64 0, metadata !16), !dbg !17
  br label %foo_bb2, !dbg !25

foo_bb2:                                          ; preds = %foo_bb4, %foo_bb1
  %.0 = phi i32 [ %"2", %foo_bb1 ], [ %.1, %foo_bb4 ]
  %"3" = icmp ne i32 %.0, %id, !dbg !26
  br i1 %"3", label %foo_bb3, label %foo_.critedge, !dbg !26

foo_bb3:                                          ; preds = %foo_bb2
  %"4" = call i32 @__VERIFIER_nondet_int(), !dbg !28
  %"5" = icmp ne i32 %"4", 0, !dbg !28
  br i1 %"5", label %foo_bb4, label %foo_.critedge, !dbg !30

foo_bb4:                                          ; preds = %foo_bb3
  %"6" = icmp sle i32 %.0, %maxId, !dbg !32
  %"7" = add nsw i32 %.0, 1, !dbg !35
  %.1 = select i1 %"6", i32 %"7", i32 0, !dbg !32
  br label %foo_bb2, !dbg !32

foo_.critedge:                                    ; preds = %foo_bb3, %foo_bb2, %foo_bb0
  ret i32 0, !dbg !37
}

; Function Attrs: nounwind readnone
declare void @llvm.dbg.declare(metadata, metadata) #1

declare i32 @__VERIFIER_nondet_int() #2

declare i32 @__kittel_nondef.0()

; Function Attrs: nounwind readnone
declare void @llvm.dbg.value(metadata, i64, metadata) #1

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone }
attributes #2 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!9, !10}
!llvm.ident = !{!11}

!0 = metadata !{i32 786449, metadata !1, i32 12, metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)", i1 false, metadata !"", i32 0, metadata !2, metadata !2, metadata !3, metadata !2, metadata !2, metadata !"", i32 1} ; [ DW_TAG_compile_unit ] [/liveness_analysis/GulwaniJainKoskinen-PLDI2009-Fig1_true-termination.c] [DW_LANG_C99]
!1 = metadata !{metadata !"GulwaniJainKoskinen-PLDI2009-Fig1_true-termination.c", metadata !"/liveness_analysis"}
!2 = metadata !{}
!3 = metadata !{metadata !4}
!4 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"foo", metadata !"foo", metadata !"", i32 3, metadata !6, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, i32 (i32, i32, i32)* @foo, null, null, metadata !2, i32 3} ; [ DW_TAG_subprogram ] [line 3] [def] [foo]
!5 = metadata !{i32 786473, metadata !1}          ; [ DW_TAG_file_type ] [/liveness_analysis/GulwaniJainKoskinen-PLDI2009-Fig1_true-termination.c]
!6 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !7, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!7 = metadata !{metadata !8, metadata !8, metadata !8, metadata !8}
!8 = metadata !{i32 786468, null, null, metadata !"int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!9 = metadata !{i32 2, metadata !"Dwarf Version", i32 4}
!10 = metadata !{i32 2, metadata !"Debug Info Version", i32 1}
!11 = metadata !{metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)"}
!12 = metadata !{i32 786689, metadata !4, metadata !"id", metadata !5, i32 16777219, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [id] [line 3]
!13 = metadata !{i32 3, i32 13, metadata !4, null}
!14 = metadata !{i32 786689, metadata !4, metadata !"maxId", metadata !5, i32 33554435, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [maxId] [line 3]
!15 = metadata !{i32 3, i32 20, metadata !4, null}
!16 = metadata !{i32 786689, metadata !4, metadata !"tmp", metadata !5, i32 50331651, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [tmp] [line 3]
!17 = metadata !{i32 3, i32 30, metadata !4, null}
!18 = metadata !{i32 4, i32 4, metadata !19, null}
!19 = metadata !{i32 786443, metadata !1, metadata !4, i32 4, i32 4, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/liveness_analysis/GulwaniJainKoskinen-PLDI2009-Fig1_true-termination.c]
!20 = metadata !{i32 4, i32 4, metadata !21, null}
!21 = metadata !{i32 786443, metadata !1, metadata !19, i32 4, i32 4, i32 1, i32 6} ; [ DW_TAG_lexical_block ] [/liveness_analysis/GulwaniJainKoskinen-PLDI2009-Fig1_true-termination.c]
!22 = metadata !{i32 5, i32 9, metadata !23, null}
!23 = metadata !{i32 786443, metadata !1, metadata !19, i32 4, i32 27, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/liveness_analysis/GulwaniJainKoskinen-PLDI2009-Fig1_true-termination.c]
!24 = metadata !{i32 0}
!25 = metadata !{i32 6, i32 9, metadata !23, null}
!26 = metadata !{i32 6, i32 9, metadata !27, null}
!27 = metadata !{i32 786443, metadata !1, metadata !23, i32 6, i32 9, i32 1, i32 7} ; [ DW_TAG_lexical_block ] [/liveness_analysis/GulwaniJainKoskinen-PLDI2009-Fig1_true-termination.c]
!28 = metadata !{i32 6, i32 26, metadata !29, null}
!29 = metadata !{i32 786443, metadata !1, metadata !23, i32 6, i32 26, i32 2, i32 8} ; [ DW_TAG_lexical_block ] [/liveness_analysis/GulwaniJainKoskinen-PLDI2009-Fig1_true-termination.c]
!30 = metadata !{i32 6, i32 26, metadata !31, null}
!31 = metadata !{i32 786443, metadata !1, metadata !23, i32 6, i32 26, i32 3, i32 9} ; [ DW_TAG_lexical_block ] [/liveness_analysis/GulwaniJainKoskinen-PLDI2009-Fig1_true-termination.c]
!32 = metadata !{i32 7, i32 17, metadata !33, null}
!33 = metadata !{i32 786443, metadata !1, metadata !34, i32 7, i32 17, i32 0, i32 3} ; [ DW_TAG_lexical_block ] [/liveness_analysis/GulwaniJainKoskinen-PLDI2009-Fig1_true-termination.c]
!34 = metadata !{i32 786443, metadata !1, metadata !23, i32 6, i32 56, i32 0, i32 2} ; [ DW_TAG_lexical_block ] [/liveness_analysis/GulwaniJainKoskinen-PLDI2009-Fig1_true-termination.c]
!35 = metadata !{i32 8, i32 17, metadata !36, null} ; [ DW_TAG_imported_declaration ]
!36 = metadata !{i32 786443, metadata !1, metadata !33, i32 7, i32 31, i32 0, i32 4} ; [ DW_TAG_lexical_block ] [/liveness_analysis/GulwaniJainKoskinen-PLDI2009-Fig1_true-termination.c]
!37 = metadata !{i32 14, i32 1, metadata !4, null}

