; ModuleID = 'TwoFloatInterv.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind uwtable
define i32 @foo(i32 %i) #0 {
foo_bb0:
  call void @llvm.dbg.value(metadata !{i32 %i}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !{i32 %"3"}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !{i32 %"5"}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !{i32 %"8"}, i64 0, metadata !12), !dbg !13
  br label %foo_bb1, !dbg !14

foo_bb1:                                          ; preds = %foo_bb2, %foo_bb0
  %.0 = phi i32 [ %i, %foo_bb0 ], [ %.3, %foo_bb2 ]
  %"0" = icmp sgt i32 %.0, 0, !dbg !15
  %"1" = icmp slt i32 %.0, 50, !dbg !17
  %. = select i1 %"0", i1 %"1", i1 false, !dbg !15
  br i1 %., label %foo_bb2, label %foo_bb3, !dbg !19

foo_bb2:                                          ; preds = %foo_bb1
  %"2" = icmp slt i32 %.0, 20, !dbg !21
  %"3" = sub nsw i32 %.0, 1, !dbg !24
  %..0 = select i1 %"2", i32 %"3", i32 %.0, !dbg !21
  %"4" = icmp sgt i32 %..0, 10, !dbg !26
  %"5" = add nsw i32 %..0, 1, !dbg !28
  %.2 = select i1 %"4", i32 %"5", i32 %..0, !dbg !26
  %"6" = icmp sle i32 30, %.2, !dbg !30
  %"7" = icmp sle i32 %.2, 40, !dbg !32
  %or.cond = and i1 %"6", %"7", !dbg !30
  %"8" = sub nsw i32 %.2, 1, !dbg !34
  %.3 = select i1 %or.cond, i32 %"8", i32 %.2, !dbg !30
  br label %foo_bb1, !dbg !30

foo_bb3:                                          ; preds = %foo_bb1
  ret i32 0, !dbg !36
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

!0 = metadata !{i32 786449, metadata !1, i32 12, metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)", i1 false, metadata !"", i32 0, metadata !2, metadata !2, metadata !3, metadata !2, metadata !2, metadata !"", i32 1} ; [ DW_TAG_compile_unit ] [/liveness_analysis/TwoFloatInterv.c] [DW_LANG_C99]
!1 = metadata !{metadata !"TwoFloatInterv.c", metadata !"/liveness_analysis"}
!2 = metadata !{}
!3 = metadata !{metadata !4}
!4 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"foo", metadata !"foo", metadata !"", i32 3, metadata !6, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, i32 (i32)* @foo, null, null, metadata !2, i32 3} ; [ DW_TAG_subprogram ] [line 3] [def] [foo]
!5 = metadata !{i32 786473, metadata !1}          ; [ DW_TAG_file_type ] [/liveness_analysis/TwoFloatInterv.c]
!6 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !7, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!7 = metadata !{metadata !8, metadata !8}
!8 = metadata !{i32 786468, null, null, metadata !"int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!9 = metadata !{i32 2, metadata !"Dwarf Version", i32 4}
!10 = metadata !{i32 2, metadata !"Debug Info Version", i32 1}
!11 = metadata !{metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)"}
!12 = metadata !{i32 786689, metadata !4, metadata !"i", metadata !5, i32 16777219, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [i] [line 3]
!13 = metadata !{i32 3, i32 13, metadata !4, null}
!14 = metadata !{i32 4, i32 1, metadata !4, null}
!15 = metadata !{i32 4, i32 1, metadata !16, null}
!16 = metadata !{i32 786443, metadata !1, metadata !4, i32 4, i32 1, i32 1, i32 7} ; [ DW_TAG_lexical_block ] [/liveness_analysis/TwoFloatInterv.c]
!17 = metadata !{i32 4, i32 1, metadata !18, null}
!18 = metadata !{i32 786443, metadata !1, metadata !4, i32 4, i32 1, i32 2, i32 8} ; [ DW_TAG_lexical_block ] [/liveness_analysis/TwoFloatInterv.c]
!19 = metadata !{i32 4, i32 1, metadata !20, null}
!20 = metadata !{i32 786443, metadata !1, metadata !4, i32 4, i32 1, i32 3, i32 9} ; [ DW_TAG_lexical_block ] [/liveness_analysis/TwoFloatInterv.c]
!21 = metadata !{i32 5, i32 13, metadata !22, null}
!22 = metadata !{i32 786443, metadata !1, metadata !23, i32 5, i32 13, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/liveness_analysis/TwoFloatInterv.c]
!23 = metadata !{i32 786443, metadata !1, metadata !4, i32 4, i32 25, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/liveness_analysis/TwoFloatInterv.c]
!24 = metadata !{i32 6, i32 13, metadata !25, null}
!25 = metadata !{i32 786443, metadata !1, metadata !22, i32 5, i32 21, i32 0, i32 2} ; [ DW_TAG_lexical_block ] [/liveness_analysis/TwoFloatInterv.c]
!26 = metadata !{i32 8, i32 13, metadata !27, null} ; [ DW_TAG_imported_declaration ]
!27 = metadata !{i32 786443, metadata !1, metadata !23, i32 8, i32 13, i32 0, i32 3} ; [ DW_TAG_lexical_block ] [/liveness_analysis/TwoFloatInterv.c]
!28 = metadata !{i32 9, i32 13, metadata !29, null}
!29 = metadata !{i32 786443, metadata !1, metadata !27, i32 8, i32 21, i32 0, i32 4} ; [ DW_TAG_lexical_block ] [/liveness_analysis/TwoFloatInterv.c]
!30 = metadata !{i32 11, i32 13, metadata !31, null}
!31 = metadata !{i32 786443, metadata !1, metadata !23, i32 11, i32 13, i32 0, i32 5} ; [ DW_TAG_lexical_block ] [/liveness_analysis/TwoFloatInterv.c]
!32 = metadata !{i32 11, i32 13, metadata !33, null}
!33 = metadata !{i32 786443, metadata !1, metadata !31, i32 11, i32 13, i32 1, i32 10} ; [ DW_TAG_lexical_block ] [/liveness_analysis/TwoFloatInterv.c]
!34 = metadata !{i32 12, i32 13, metadata !35, null}
!35 = metadata !{i32 786443, metadata !1, metadata !31, i32 11, i32 33, i32 0, i32 6} ; [ DW_TAG_lexical_block ] [/liveness_analysis/TwoFloatInterv.c]
!36 = metadata !{i32 16, i32 1, metadata !4, null}

