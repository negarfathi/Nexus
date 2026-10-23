; ModuleID = 'counterex1b.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind uwtable
define void @counterex1b(i32 %n, i32 %x, i32 %y) #0 {
counterex1b_bb0:
  call void @llvm.dbg.value(metadata !{i32 %n}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !{i32 %x}, i64 0, metadata !14), !dbg !15
  call void @llvm.dbg.value(metadata !{i32 %y}, i64 0, metadata !16), !dbg !17
  call void @llvm.dbg.value(metadata !{i32 %"4"}, i64 0, metadata !16), !dbg !17
  br label %counterex1b_.critedge2, !dbg !18

counterex1b_.critedge2:                           ; preds = %counterex1b_bb5, %counterex1b_bb4, %counterex1b_bb0
  %.01 = phi i32 [ %y, %counterex1b_bb0 ], [ %.2, %counterex1b_bb4 ], [ %.2, %counterex1b_bb5 ]
  %.0 = phi i32 [ %x, %counterex1b_bb0 ], [ %"5", %counterex1b_bb4 ], [ %"5", %counterex1b_bb5 ]
  %"0" = icmp sge i32 %.0, 0, !dbg !19
  br i1 %"0", label %counterex1b_bb1, label %counterex1b_bb7, !dbg !19

counterex1b_bb1:                                  ; preds = %counterex1b_.critedge2, %counterex1b_bb3
  %.1 = phi i32 [ %"4", %counterex1b_bb3 ], [ %.01, %counterex1b_.critedge2 ]
  %"1" = icmp sge i32 %.1, 0, !dbg !21
  br i1 %"1", label %counterex1b_bb2, label %counterex1b_.critedge, !dbg !21

counterex1b_bb2:                                  ; preds = %counterex1b_bb1
  %"2" = call i32 (...)* @nondet(), !dbg !25
  %"3" = icmp sgt i32 %"2", 0, !dbg !25
  br i1 %"3", label %counterex1b_bb3, label %counterex1b_.critedge, !dbg !27

counterex1b_bb3:                                  ; preds = %counterex1b_bb2
  %"4" = add nsw i32 %.1, -1, !dbg !29
  br label %counterex1b_bb1, !dbg !29

counterex1b_.critedge:                            ; preds = %counterex1b_bb1, %counterex1b_bb2
  %"5" = add nsw i32 %.0, -1, !dbg !31
  call void @llvm.dbg.value(metadata !{i32 %"5"}, i64 0, metadata !14), !dbg !15
  call void @llvm.dbg.value(metadata !{i32 %"9"}, i64 0, metadata !16), !dbg !17
  br label %counterex1b_bb4, !dbg !32

counterex1b_bb4:                                  ; preds = %counterex1b_bb6, %counterex1b_.critedge
  %.2 = phi i32 [ %.1, %counterex1b_.critedge ], [ %"9", %counterex1b_bb6 ]
  %"6" = icmp sle i32 %.2, %n, !dbg !33
  br i1 %"6", label %counterex1b_bb5, label %counterex1b_.critedge2, !dbg !33

counterex1b_bb5:                                  ; preds = %counterex1b_bb4
  %"7" = call i32 (...)* @nondet(), !dbg !36
  %"8" = icmp sgt i32 %"7", 0, !dbg !36
  br i1 %"8", label %counterex1b_bb6, label %counterex1b_.critedge2, !dbg !38

counterex1b_bb6:                                  ; preds = %counterex1b_bb5
  %"9" = add nsw i32 %.2, 1, !dbg !40
  br label %counterex1b_bb4, !dbg !40

counterex1b_bb7:                                  ; preds = %counterex1b_.critedge2
  ret void, !dbg !42
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

!0 = metadata !{i32 786449, metadata !1, i32 12, metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)", i1 false, metadata !"", i32 0, metadata !2, metadata !2, metadata !3, metadata !2, metadata !2, metadata !"", i32 1} ; [ DW_TAG_compile_unit ] [/liveness_analysis/counterex1b.c] [DW_LANG_C99]
!1 = metadata !{metadata !"counterex1b.c", metadata !"/liveness_analysis"}
!2 = metadata !{}
!3 = metadata !{metadata !4}
!4 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"counterex1b", metadata !"counterex1b", metadata !"", i32 3, metadata !6, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (i32, i32, i32)* @counterex1b, null, null, metadata !2, i32 4} ; [ DW_TAG_subprogram ] [line 3] [def] [scope 4] [counterex1b]
!5 = metadata !{i32 786473, metadata !1}          ; [ DW_TAG_file_type ] [/liveness_analysis/counterex1b.c]
!6 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !7, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!7 = metadata !{null, metadata !8, metadata !8, metadata !8}
!8 = metadata !{i32 786468, null, null, metadata !"int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!9 = metadata !{i32 2, metadata !"Dwarf Version", i32 4}
!10 = metadata !{i32 2, metadata !"Debug Info Version", i32 1}
!11 = metadata !{metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)"}
!12 = metadata !{i32 786689, metadata !4, metadata !"n", metadata !5, i32 16777219, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [n] [line 3]
!13 = metadata !{i32 3, i32 22, metadata !4, null}
!14 = metadata !{i32 786689, metadata !4, metadata !"x", metadata !5, i32 33554435, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [x] [line 3]
!15 = metadata !{i32 3, i32 28, metadata !4, null}
!16 = metadata !{i32 786689, metadata !4, metadata !"y", metadata !5, i32 50331651, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [y] [line 3]
!17 = metadata !{i32 3, i32 34, metadata !4, null}
!18 = metadata !{i32 6, i32 3, metadata !4, null}
!19 = metadata !{i32 6, i32 3, metadata !20, null}
!20 = metadata !{i32 786443, metadata !1, metadata !4, i32 6, i32 3, i32 1, i32 1} ; [ DW_TAG_lexical_block ] [/liveness_analysis/counterex1b.c]
!21 = metadata !{i32 7, i32 5, metadata !22, null}
!22 = metadata !{i32 786443, metadata !1, metadata !23, i32 7, i32 5, i32 5, i32 6} ; [ DW_TAG_lexical_block ] [/liveness_analysis/counterex1b.c]
!23 = metadata !{i32 786443, metadata !1, metadata !24, i32 7, i32 5, i32 1, i32 2} ; [ DW_TAG_lexical_block ] [/liveness_analysis/counterex1b.c]
!24 = metadata !{i32 786443, metadata !1, metadata !4, i32 6, i32 14, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/liveness_analysis/counterex1b.c]
!25 = metadata !{i32 7, i32 19, metadata !26, null}
!26 = metadata !{i32 786443, metadata !1, metadata !24, i32 7, i32 19, i32 2, i32 3} ; [ DW_TAG_lexical_block ] [/liveness_analysis/counterex1b.c]
!27 = metadata !{i32 7, i32 19, metadata !28, null}
!28 = metadata !{i32 786443, metadata !1, metadata !24, i32 7, i32 19, i32 3, i32 4} ; [ DW_TAG_lexical_block ] [/liveness_analysis/counterex1b.c]
!29 = metadata !{i32 7, i32 31, metadata !30, null}
!30 = metadata !{i32 786443, metadata !1, metadata !24, i32 7, i32 31, i32 4, i32 5} ; [ DW_TAG_lexical_block ] [/liveness_analysis/counterex1b.c]
!31 = metadata !{i32 8, i32 5, metadata !24, null} ; [ DW_TAG_imported_declaration ]
!32 = metadata !{i32 9, i32 5, metadata !24, null}
!33 = metadata !{i32 9, i32 5, metadata !34, null}
!34 = metadata !{i32 786443, metadata !1, metadata !35, i32 9, i32 5, i32 5, i32 11} ; [ DW_TAG_lexical_block ] [/liveness_analysis/counterex1b.c]
!35 = metadata !{i32 786443, metadata !1, metadata !24, i32 9, i32 5, i32 1, i32 7} ; [ DW_TAG_lexical_block ] [/liveness_analysis/counterex1b.c]
!36 = metadata !{i32 9, i32 19, metadata !37, null}
!37 = metadata !{i32 786443, metadata !1, metadata !24, i32 9, i32 19, i32 2, i32 8} ; [ DW_TAG_lexical_block ] [/liveness_analysis/counterex1b.c]
!38 = metadata !{i32 9, i32 19, metadata !39, null}
!39 = metadata !{i32 786443, metadata !1, metadata !24, i32 9, i32 19, i32 3, i32 9} ; [ DW_TAG_lexical_block ] [/liveness_analysis/counterex1b.c]
!40 = metadata !{i32 9, i32 31, metadata !41, null}
!41 = metadata !{i32 786443, metadata !1, metadata !24, i32 9, i32 31, i32 4, i32 10} ; [ DW_TAG_lexical_block ] [/liveness_analysis/counterex1b.c]
!42 = metadata !{i32 11, i32 1, metadata !4, null}

