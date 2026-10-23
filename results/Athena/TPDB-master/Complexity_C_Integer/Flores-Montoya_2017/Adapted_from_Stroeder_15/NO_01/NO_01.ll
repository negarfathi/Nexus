; ModuleID = 'NO_01.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind uwtable
define i32 @foo(i32 %c, i32 %i) #0 {
foo_bb0:
  call void @llvm.dbg.value(metadata !{i32 %c}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !{i32 %i}, i64 0, metadata !14), !dbg !15
  call void @llvm.dbg.value(metadata !16, i64 0, metadata !12), !dbg !13
  %"0" = icmp sle i32 864, 10, !dbg !17
  br i1 %"0", label %foo_bb1, label %foo_bb3, !dbg !17

foo_bb1:                                          ; preds = %foo_bb0, %foo_bb2
  %.0 = phi i32 [ %"2", %foo_bb2 ], [ 0, %foo_bb0 ]
  %"1" = icmp slt i32 %.0, 100, !dbg !19
  br i1 %"1", label %foo_bb2, label %foo_bb11, !dbg !19

foo_bb2:                                          ; preds = %foo_bb1
  %"2" = add nsw i32 %.0, 1, !dbg !22
  br label %foo_bb1, !dbg !24

foo_bb3:                                          ; preds = %foo_bb0
  %"3" = icmp sle i32 864, 50, !dbg !25
  br i1 %"3", label %foo_bb4, label %foo_bb6, !dbg !25

foo_bb4:                                          ; preds = %foo_bb3, %foo_bb5
  %.1 = phi i32 [ %"5", %foo_bb5 ], [ 0, %foo_bb3 ]
  %"4" = icmp slt i32 %.1, 101, !dbg !28
  br i1 %"4", label %foo_bb5, label %foo_bb6, !dbg !28

foo_bb5:                                          ; preds = %foo_bb4
  %"5" = add nsw i32 %.1, 1, !dbg !31
  br label %foo_bb4, !dbg !33

foo_bb6:                                          ; preds = %foo_bb4, %foo_bb3
  %"6" = icmp sle i32 864, 100, !dbg !34
  call void @llvm.dbg.value(metadata !36, i64 0, metadata !14), !dbg !15
  br i1 %"6", label %foo_bb7, label %foo_bb9, !dbg !34

foo_bb7:                                          ; preds = %foo_bb6, %foo_bb8
  %.2 = phi i32 [ %"8", %foo_bb8 ], [ 0, %foo_bb6 ]
  %"7" = icmp slt i32 %.2, 102, !dbg !37
  br i1 %"7", label %foo_bb8, label %foo_bb11, !dbg !37

foo_bb8:                                          ; preds = %foo_bb7
  %"8" = add nsw i32 %.2, 1, !dbg !40
  br label %foo_bb7, !dbg !42

foo_bb9:                                          ; preds = %foo_bb6, %foo_bb10
  %.3 = phi i32 [ %"10", %foo_bb10 ], [ 0, %foo_bb6 ]
  %"9" = icmp slt i32 %.3, 103, !dbg !43
  br i1 %"9", label %foo_bb10, label %foo_bb11, !dbg !43

foo_bb10:                                         ; preds = %foo_bb9
  %"10" = add nsw i32 %.3, 0, !dbg !46
  br label %foo_bb9, !dbg !48

foo_bb11:                                         ; preds = %foo_bb7, %foo_bb9, %foo_bb1
  ret i32 0, !dbg !49
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

!0 = metadata !{i32 786449, metadata !1, i32 12, metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)", i1 false, metadata !"", i32 0, metadata !2, metadata !2, metadata !3, metadata !2, metadata !2, metadata !"", i32 1} ; [ DW_TAG_compile_unit ] [/liveness_analysis/NO_01.c] [DW_LANG_C99]
!1 = metadata !{metadata !"NO_01.c", metadata !"/liveness_analysis"}
!2 = metadata !{}
!3 = metadata !{metadata !4}
!4 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"foo", metadata !"foo", metadata !"", i32 3, metadata !6, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, i32 (i32, i32)* @foo, null, null, metadata !2, i32 3} ; [ DW_TAG_subprogram ] [line 3] [def] [foo]
!5 = metadata !{i32 786473, metadata !1}          ; [ DW_TAG_file_type ] [/liveness_analysis/NO_01.c]
!6 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !7, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!7 = metadata !{metadata !8, metadata !8, metadata !8}
!8 = metadata !{i32 786468, null, null, metadata !"int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!9 = metadata !{i32 2, metadata !"Dwarf Version", i32 4}
!10 = metadata !{i32 2, metadata !"Debug Info Version", i32 1}
!11 = metadata !{metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)"}
!12 = metadata !{i32 786689, metadata !4, metadata !"c", metadata !5, i32 16777219, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [c] [line 3]
!13 = metadata !{i32 3, i32 13, metadata !4, null}
!14 = metadata !{i32 786689, metadata !4, metadata !"i", metadata !5, i32 33554435, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [i] [line 3]
!15 = metadata !{i32 3, i32 19, metadata !4, null}
!16 = metadata !{i32 864}
!17 = metadata !{i32 5, i32 5, metadata !18, null}
!18 = metadata !{i32 786443, metadata !1, metadata !4, i32 5, i32 5, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/liveness_analysis/NO_01.c]
!19 = metadata !{i32 7, i32 9, metadata !20, null}
!20 = metadata !{i32 786443, metadata !1, metadata !21, i32 7, i32 9, i32 1, i32 12} ; [ DW_TAG_lexical_block ] [/liveness_analysis/NO_01.c]
!21 = metadata !{i32 786443, metadata !1, metadata !18, i32 5, i32 14, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/liveness_analysis/NO_01.c]
!22 = metadata !{i32 8, i32 13, metadata !23, null} ; [ DW_TAG_imported_declaration ]
!23 = metadata !{i32 786443, metadata !1, metadata !21, i32 7, i32 25, i32 0, i32 2} ; [ DW_TAG_lexical_block ] [/liveness_analysis/NO_01.c]
!24 = metadata !{i32 9, i32 9, metadata !23, null}
!25 = metadata !{i32 12, i32 13, metadata !26, null}
!26 = metadata !{i32 786443, metadata !1, metadata !27, i32 12, i32 13, i32 0, i32 4} ; [ DW_TAG_lexical_block ] [/liveness_analysis/NO_01.c]
!27 = metadata !{i32 786443, metadata !1, metadata !18, i32 11, i32 10, i32 0, i32 3} ; [ DW_TAG_lexical_block ] [/liveness_analysis/NO_01.c]
!28 = metadata !{i32 14, i32 13, metadata !29, null}
!29 = metadata !{i32 786443, metadata !1, metadata !30, i32 14, i32 13, i32 1, i32 13} ; [ DW_TAG_lexical_block ] [/liveness_analysis/NO_01.c]
!30 = metadata !{i32 786443, metadata !1, metadata !26, i32 12, i32 22, i32 0, i32 5} ; [ DW_TAG_lexical_block ] [/liveness_analysis/NO_01.c]
!31 = metadata !{i32 15, i32 17, metadata !32, null}
!32 = metadata !{i32 786443, metadata !1, metadata !30, i32 14, i32 29, i32 0, i32 6} ; [ DW_TAG_lexical_block ] [/liveness_analysis/NO_01.c]
!33 = metadata !{i32 16, i32 13, metadata !32, null}
!34 = metadata !{i32 18, i32 13, metadata !35, null}
!35 = metadata !{i32 786443, metadata !1, metadata !27, i32 18, i32 13, i32 0, i32 7} ; [ DW_TAG_lexical_block ] [/liveness_analysis/NO_01.c]
!36 = metadata !{i32 0}
!37 = metadata !{i32 20, i32 13, metadata !38, null}
!38 = metadata !{i32 786443, metadata !1, metadata !39, i32 20, i32 13, i32 1, i32 14} ; [ DW_TAG_lexical_block ] [/liveness_analysis/NO_01.c]
!39 = metadata !{i32 786443, metadata !1, metadata !35, i32 18, i32 23, i32 0, i32 8} ; [ DW_TAG_lexical_block ] [/liveness_analysis/NO_01.c]
!40 = metadata !{i32 21, i32 17, metadata !41, null}
!41 = metadata !{i32 786443, metadata !1, metadata !39, i32 20, i32 29, i32 0, i32 9} ; [ DW_TAG_lexical_block ] [/liveness_analysis/NO_01.c]
!42 = metadata !{i32 22, i32 13, metadata !41, null}
!43 = metadata !{i32 26, i32 13, metadata !44, null}
!44 = metadata !{i32 786443, metadata !1, metadata !45, i32 26, i32 13, i32 1, i32 15} ; [ DW_TAG_lexical_block ] [/liveness_analysis/NO_01.c]
!45 = metadata !{i32 786443, metadata !1, metadata !35, i32 24, i32 14, i32 0, i32 10} ; [ DW_TAG_lexical_block ] [/liveness_analysis/NO_01.c]
!46 = metadata !{i32 27, i32 17, metadata !47, null}
!47 = metadata !{i32 786443, metadata !1, metadata !45, i32 26, i32 29, i32 0, i32 11} ; [ DW_TAG_lexical_block ] [/liveness_analysis/NO_01.c]
!48 = metadata !{i32 28, i32 13, metadata !47, null}
!49 = metadata !{i32 31, i32 1, metadata !4, null}

