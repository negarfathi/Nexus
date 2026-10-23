; ModuleID = 'counterex1a.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind uwtable
define i32 @counterex1a(i32 %n, i32 %b, i32 %x, i32 %y) #0 {
counterex1a_bb0:
  call void @llvm.dbg.value(metadata !{i32 %n}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !{i32 %b}, i64 0, metadata !14), !dbg !15
  call void @llvm.dbg.value(metadata !{i32 %x}, i64 0, metadata !16), !dbg !17
  call void @llvm.dbg.value(metadata !{i32 %y}, i64 0, metadata !18), !dbg !19
  call void @llvm.dbg.value(metadata !{i32 %"4"}, i64 0, metadata !18), !dbg !19
  call void @llvm.dbg.value(metadata !20, i64 0, metadata !14), !dbg !15
  call void @llvm.dbg.value(metadata !{i32 %"7"}, i64 0, metadata !18), !dbg !19
  call void @llvm.dbg.value(metadata !{i32 %"10"}, i64 0, metadata !16), !dbg !17
  call void @llvm.dbg.value(metadata !21, i64 0, metadata !14), !dbg !15
  br label %counterex1a_bb1, !dbg !22

counterex1a_bb1:                                  ; preds = %counterex1a_bb3, %counterex1a_bb4, %counterex1a_bb0
  %.04 = phi i32 [ %y, %counterex1a_bb0 ], [ %"4", %counterex1a_bb3 ], [ %"7", %counterex1a_bb4 ]
  %.01 = phi i32 [ %x, %counterex1a_bb0 ], [ %.01, %counterex1a_bb3 ], [ %..01, %counterex1a_bb4 ]
  %.0 = phi i32 [ %b, %counterex1a_bb0 ], [ %..0, %counterex1a_bb3 ], [ %..06, %counterex1a_bb4 ]
  %"0" = icmp sge i32 %.01, 0, !dbg !23
  %"1" = icmp sle i32 0, %.04, !dbg !25
  %or.cond = and i1 %"0", %"1", !dbg !23
  %"2" = icmp sle i32 %.04, %n, !dbg !27
  %or.cond7 = and i1 %or.cond, %"2", !dbg !23
  br i1 %or.cond7, label %counterex1a_bb2, label %counterex1a_.critedge, !dbg !23

counterex1a_bb2:                                  ; preds = %counterex1a_bb1
  %"3" = icmp eq i32 %.0, 0, !dbg !29
  br i1 %"3", label %counterex1a_bb3, label %counterex1a_bb4, !dbg !29

counterex1a_bb3:                                  ; preds = %counterex1a_bb2
  %"4" = add nsw i32 %.04, 1, !dbg !32
  %"5" = call i32 (...)* @nondet(), !dbg !34
  %"6" = icmp sgt i32 %"5", 0, !dbg !34
  %..0 = select i1 %"6", i32 1, i32 %.0, !dbg !34
  br label %counterex1a_bb1, !dbg !36

counterex1a_bb4:                                  ; preds = %counterex1a_bb2
  %"7" = add nsw i32 %.04, -1, !dbg !37
  %"8" = call i32 (...)* @nondet(), !dbg !39
  %"9" = icmp sgt i32 %"8", 0, !dbg !39
  %"10" = add nsw i32 %.01, -1, !dbg !41
  %..01 = select i1 %"9", i32 %"10", i32 %.01, !dbg !39
  %..06 = select i1 %"9", i32 0, i32 %.0, !dbg !39
  br label %counterex1a_bb1

counterex1a_.critedge:                            ; preds = %counterex1a_bb1
  ret i32 0, !dbg !44
}

; Function Attrs: nounwind readnone
declare void @llvm.dbg.declare(metadata, metadata) #1

declare i32 @nondet(...) #2

declare i32 @__kittel_nondef.0()

; Function Attrs: nounwind readnone
declare void @llvm.dbg.value(metadata, i64, metadata) #1

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone }
attributes #2 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!9, !10}
!llvm.ident = !{!11}

!0 = metadata !{i32 786449, metadata !1, i32 12, metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)", i1 false, metadata !"", i32 0, metadata !2, metadata !2, metadata !3, metadata !2, metadata !2, metadata !"", i32 1} ; [ DW_TAG_compile_unit ] [/liveness_analysis/counterex1a.c] [DW_LANG_C99]
!1 = metadata !{metadata !"counterex1a.c", metadata !"/liveness_analysis"}
!2 = metadata !{}
!3 = metadata !{metadata !4}
!4 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"counterex1a", metadata !"counterex1a", metadata !"", i32 3, metadata !6, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, i32 (i32, i32, i32, i32)* @counterex1a, null, null, metadata !2, i32 4} ; [ DW_TAG_subprogram ] [line 3] [def] [scope 4] [counterex1a]
!5 = metadata !{i32 786473, metadata !1}          ; [ DW_TAG_file_type ] [/liveness_analysis/counterex1a.c]
!6 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !7, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!7 = metadata !{metadata !8, metadata !8, metadata !8, metadata !8, metadata !8}
!8 = metadata !{i32 786468, null, null, metadata !"int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!9 = metadata !{i32 2, metadata !"Dwarf Version", i32 4}
!10 = metadata !{i32 2, metadata !"Debug Info Version", i32 1}
!11 = metadata !{metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)"}
!12 = metadata !{i32 786689, metadata !4, metadata !"n", metadata !5, i32 16777219, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [n] [line 3]
!13 = metadata !{i32 3, i32 21, metadata !4, null}
!14 = metadata !{i32 786689, metadata !4, metadata !"b", metadata !5, i32 33554435, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [b] [line 3]
!15 = metadata !{i32 3, i32 27, metadata !4, null}
!16 = metadata !{i32 786689, metadata !4, metadata !"x", metadata !5, i32 50331651, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [x] [line 3]
!17 = metadata !{i32 3, i32 33, metadata !4, null}
!18 = metadata !{i32 786689, metadata !4, metadata !"y", metadata !5, i32 67108867, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [y] [line 3]
!19 = metadata !{i32 3, i32 39, metadata !4, null}
!20 = metadata !{i32 1}
!21 = metadata !{i32 0}
!22 = metadata !{i32 6, i32 3, metadata !4, null}
!23 = metadata !{i32 6, i32 3, metadata !24, null}
!24 = metadata !{i32 786443, metadata !1, metadata !4, i32 6, i32 3, i32 1, i32 7} ; [ DW_TAG_lexical_block ] [/liveness_analysis/counterex1a.c]
!25 = metadata !{i32 6, i32 3, metadata !26, null}
!26 = metadata !{i32 786443, metadata !1, metadata !4, i32 6, i32 3, i32 2, i32 8} ; [ DW_TAG_lexical_block ] [/liveness_analysis/counterex1a.c]
!27 = metadata !{i32 6, i32 3, metadata !28, null}
!28 = metadata !{i32 786443, metadata !1, metadata !4, i32 6, i32 3, i32 4, i32 10} ; [ DW_TAG_lexical_block ] [/liveness_analysis/counterex1a.c]
!29 = metadata !{i32 7, i32 9, metadata !30, null}
!30 = metadata !{i32 786443, metadata !1, metadata !31, i32 7, i32 9, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/liveness_analysis/counterex1a.c]
!31 = metadata !{i32 786443, metadata !1, metadata !4, i32 6, i32 32, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/liveness_analysis/counterex1a.c]
!32 = metadata !{i32 8, i32 7, metadata !33, null} ; [ DW_TAG_imported_declaration ]
!33 = metadata !{i32 786443, metadata !1, metadata !30, i32 7, i32 15, i32 0, i32 2} ; [ DW_TAG_lexical_block ] [/liveness_analysis/counterex1a.c]
!34 = metadata !{i32 9, i32 11, metadata !35, null}
!35 = metadata !{i32 786443, metadata !1, metadata !33, i32 9, i32 11, i32 0, i32 3} ; [ DW_TAG_lexical_block ] [/liveness_analysis/counterex1a.c]
!36 = metadata !{i32 10, i32 5, metadata !33, null}
!37 = metadata !{i32 12, i32 7, metadata !38, null}
!38 = metadata !{i32 786443, metadata !1, metadata !30, i32 11, i32 10, i32 0, i32 4} ; [ DW_TAG_lexical_block ] [/liveness_analysis/counterex1a.c]
!39 = metadata !{i32 13, i32 11, metadata !40, null}
!40 = metadata !{i32 786443, metadata !1, metadata !38, i32 13, i32 11, i32 0, i32 5} ; [ DW_TAG_lexical_block ] [/liveness_analysis/counterex1a.c]
!41 = metadata !{i32 13, i32 24, metadata !42, null}
!42 = metadata !{i32 786443, metadata !1, metadata !43, i32 13, i32 24, i32 1, i32 13} ; [ DW_TAG_lexical_block ] [/liveness_analysis/counterex1a.c]
!43 = metadata !{i32 786443, metadata !1, metadata !40, i32 13, i32 23, i32 0, i32 6} ; [ DW_TAG_lexical_block ] [/liveness_analysis/counterex1a.c]
!44 = metadata !{i32 16, i32 3, metadata !4, null}

