; ModuleID = 'GCD3.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind uwtable
define i32 @foo(i32 %x, i32 %y, i32 %tmp, i32 %xtmp) #0 {
foo_bb0:
  call void @llvm.dbg.value(metadata !{i32 %x}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !{i32 %y}, i64 0, metadata !14), !dbg !15
  call void @llvm.dbg.value(metadata !{i32 %tmp}, i64 0, metadata !16), !dbg !17
  call void @llvm.dbg.value(metadata !{i32 %xtmp}, i64 0, metadata !18), !dbg !19
  call void @llvm.dbg.value(metadata !{i32 %.01}, i64 0, metadata !16), !dbg !17
  call void @llvm.dbg.value(metadata !{i32 %.0}, i64 0, metadata !18), !dbg !19
  call void @llvm.dbg.value(metadata !{i32 %.01}, i64 0, metadata !14), !dbg !15
  call void @llvm.dbg.value(metadata !{i32 %"7"}, i64 0, metadata !18), !dbg !19
  call void @llvm.dbg.value(metadata !{i32 %.01}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !{i32 %"9"}, i64 0, metadata !18), !dbg !19
  call void @llvm.dbg.value(metadata !{i32 %"4"}, i64 0, metadata !18), !dbg !19
  br label %foo_bb1, !dbg !20

foo_bb1:                                          ; preds = %foo_bb5, %foo_bb7, %foo_bb0
  %.01 = phi i32 [ %y, %foo_bb0 ], [ %.24, %foo_bb5 ], [ %.3, %foo_bb7 ]
  %.0 = phi i32 [ %x, %foo_bb0 ], [ %.01, %foo_bb7 ], [ %.01, %foo_bb5 ]
  %"0" = icmp sgt i32 %.01, 0, !dbg !21
  %"1" = icmp sgt i32 %.0, 0, !dbg !23
  %. = select i1 %"0", i1 %"1", i1 false, !dbg !21
  br i1 %., label %foo_bb2, label %foo_bb9, !dbg !25

foo_bb2:                                          ; preds = %foo_bb1
  %"2" = icmp eq i32 %.01, 0, !dbg !27
  br i1 %"2", label %foo_bb4, label %foo_bb3, !dbg !27

foo_bb3:                                          ; preds = %foo_bb2
  %"3" = icmp slt i32 %.01, 0, !dbg !30
  %"4" = sub nsw i32 0, %.0, !dbg !33
  %..0 = select i1 %"3", i32 %"4", i32 %.0, !dbg !30
  br label %foo_bb4

foo_bb4:                                          ; preds = %foo_bb2, %foo_bb3
  %.13 = phi i32 [ %..0, %foo_bb3 ], [ %.0, %foo_bb2 ]
  %"5" = icmp sgt i32 %.13, 0, !dbg !35
  br i1 %"5", label %foo_bb5, label %foo_bb7, !dbg !35

foo_bb5:                                          ; preds = %foo_bb4, %foo_bb6
  %.24 = phi i32 [ %"7", %foo_bb6 ], [ %.13, %foo_bb4 ]
  %"6" = icmp sge i32 %.24, %.01, !dbg !37
  br i1 %"6", label %foo_bb6, label %foo_bb1, !dbg !37

foo_bb6:                                          ; preds = %foo_bb5
  %"7" = sub nsw i32 %.24, %.01, !dbg !40
  br label %foo_bb5, !dbg !42

foo_bb7:                                          ; preds = %foo_bb4, %foo_bb8
  %.3 = phi i32 [ %"9", %foo_bb8 ], [ %.13, %foo_bb4 ]
  %"8" = icmp slt i32 %.3, 0, !dbg !43
  br i1 %"8", label %foo_bb8, label %foo_bb1, !dbg !43

foo_bb8:                                          ; preds = %foo_bb7
  %"9" = sub nsw i32 %.3, %.01, !dbg !46
  br label %foo_bb7, !dbg !48

foo_bb9:                                          ; preds = %foo_bb1
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

!0 = metadata !{i32 786449, metadata !1, i32 12, metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)", i1 false, metadata !"", i32 0, metadata !2, metadata !2, metadata !3, metadata !2, metadata !2, metadata !"", i32 1} ; [ DW_TAG_compile_unit ] [/liveness_analysis/GCD3.c] [DW_LANG_C99]
!1 = metadata !{metadata !"GCD3.c", metadata !"/liveness_analysis"}
!2 = metadata !{}
!3 = metadata !{metadata !4}
!4 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"foo", metadata !"foo", metadata !"", i32 3, metadata !6, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, i32 (i32, i32, i32, i32)* @foo, null, null, metadata !2, i32 3} ; [ DW_TAG_subprogram ] [line 3] [def] [foo]
!5 = metadata !{i32 786473, metadata !1}          ; [ DW_TAG_file_type ] [/liveness_analysis/GCD3.c]
!6 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !7, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!7 = metadata !{metadata !8, metadata !8, metadata !8, metadata !8, metadata !8}
!8 = metadata !{i32 786468, null, null, metadata !"int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!9 = metadata !{i32 2, metadata !"Dwarf Version", i32 4}
!10 = metadata !{i32 2, metadata !"Debug Info Version", i32 1}
!11 = metadata !{metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)"}
!12 = metadata !{i32 786689, metadata !4, metadata !"x", metadata !5, i32 16777219, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [x] [line 3]
!13 = metadata !{i32 3, i32 13, metadata !4, null}
!14 = metadata !{i32 786689, metadata !4, metadata !"y", metadata !5, i32 33554435, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [y] [line 3]
!15 = metadata !{i32 3, i32 19, metadata !4, null}
!16 = metadata !{i32 786689, metadata !4, metadata !"tmp", metadata !5, i32 50331651, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [tmp] [line 3]
!17 = metadata !{i32 3, i32 25, metadata !4, null}
!18 = metadata !{i32 786689, metadata !4, metadata !"xtmp", metadata !5, i32 67108867, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [xtmp] [line 3]
!19 = metadata !{i32 3, i32 33, metadata !4, null}
!20 = metadata !{i32 4, i32 1, metadata !4, null}
!21 = metadata !{i32 4, i32 1, metadata !22, null}
!22 = metadata !{i32 786443, metadata !1, metadata !4, i32 4, i32 1, i32 1, i32 11} ; [ DW_TAG_lexical_block ] [/liveness_analysis/GCD3.c]
!23 = metadata !{i32 4, i32 1, metadata !24, null}
!24 = metadata !{i32 786443, metadata !1, metadata !4, i32 4, i32 1, i32 2, i32 12} ; [ DW_TAG_lexical_block ] [/liveness_analysis/GCD3.c]
!25 = metadata !{i32 4, i32 1, metadata !26, null}
!26 = metadata !{i32 786443, metadata !1, metadata !4, i32 4, i32 1, i32 3, i32 13} ; [ DW_TAG_lexical_block ] [/liveness_analysis/GCD3.c]
!27 = metadata !{i32 8, i32 12, metadata !28, null} ; [ DW_TAG_imported_declaration ]
!28 = metadata !{i32 786443, metadata !1, metadata !29, i32 8, i32 12, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/liveness_analysis/GCD3.c]
!29 = metadata !{i32 786443, metadata !1, metadata !4, i32 4, i32 23, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/liveness_analysis/GCD3.c]
!30 = metadata !{i32 12, i32 16, metadata !31, null}
!31 = metadata !{i32 786443, metadata !1, metadata !32, i32 12, i32 16, i32 0, i32 4} ; [ DW_TAG_lexical_block ] [/liveness_analysis/GCD3.c]
!32 = metadata !{i32 786443, metadata !1, metadata !28, i32 11, i32 14, i32 0, i32 3} ; [ DW_TAG_lexical_block ] [/liveness_analysis/GCD3.c]
!33 = metadata !{i32 13, i32 17, metadata !34, null}
!34 = metadata !{i32 786443, metadata !1, metadata !31, i32 12, i32 23, i32 0, i32 5} ; [ DW_TAG_lexical_block ] [/liveness_analysis/GCD3.c]
!35 = metadata !{i32 16, i32 12, metadata !36, null}
!36 = metadata !{i32 786443, metadata !1, metadata !29, i32 16, i32 12, i32 0, i32 6} ; [ DW_TAG_lexical_block ] [/liveness_analysis/GCD3.c]
!37 = metadata !{i32 17, i32 13, metadata !38, null}
!38 = metadata !{i32 786443, metadata !1, metadata !39, i32 17, i32 13, i32 1, i32 14} ; [ DW_TAG_lexical_block ] [/liveness_analysis/GCD3.c]
!39 = metadata !{i32 786443, metadata !1, metadata !36, i32 16, i32 22, i32 0, i32 7} ; [ DW_TAG_lexical_block ] [/liveness_analysis/GCD3.c]
!40 = metadata !{i32 18, i32 17, metadata !41, null}
!41 = metadata !{i32 786443, metadata !1, metadata !39, i32 17, i32 28, i32 0, i32 8} ; [ DW_TAG_lexical_block ] [/liveness_analysis/GCD3.c]
!42 = metadata !{i32 19, i32 13, metadata !41, null}
!43 = metadata !{i32 22, i32 13, metadata !44, null}
!44 = metadata !{i32 786443, metadata !1, metadata !45, i32 22, i32 13, i32 1, i32 15} ; [ DW_TAG_lexical_block ] [/liveness_analysis/GCD3.c]
!45 = metadata !{i32 786443, metadata !1, metadata !36, i32 21, i32 16, i32 0, i32 9} ; [ DW_TAG_lexical_block ] [/liveness_analysis/GCD3.c]
!46 = metadata !{i32 23, i32 17, metadata !47, null}
!47 = metadata !{i32 786443, metadata !1, metadata !45, i32 22, i32 29, i32 0, i32 10} ; [ DW_TAG_lexical_block ] [/liveness_analysis/GCD3.c]
!48 = metadata !{i32 24, i32 13, metadata !47, null}
!49 = metadata !{i32 30, i32 1, metadata !4, null}

