; ModuleID = 'ChawdharyCookGulwaniSagivYang-ESOP2008-aaron4_true-termination.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind uwtable
define i32 @foo(i32 %i, i32 %j, i32 %k, i32 %an, i32 %bn, i32 %tk) #0 {
foo_bb0:
  call void @llvm.dbg.value(metadata !{i32 %i}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !{i32 %j}, i64 0, metadata !14), !dbg !15
  call void @llvm.dbg.value(metadata !{i32 %k}, i64 0, metadata !16), !dbg !17
  call void @llvm.dbg.value(metadata !{i32 %an}, i64 0, metadata !18), !dbg !19
  call void @llvm.dbg.value(metadata !{i32 %bn}, i64 0, metadata !20), !dbg !21
  call void @llvm.dbg.value(metadata !{i32 %tk}, i64 0, metadata !22), !dbg !23
  call void @llvm.dbg.value(metadata !{i32 %"12"}, i64 0, metadata !14), !dbg !15
  call void @llvm.dbg.value(metadata !{i32 %.05}, i64 0, metadata !22), !dbg !23
  call void @llvm.dbg.value(metadata !{i32 %"13"}, i64 0, metadata !16), !dbg !17
  call void @llvm.dbg.value(metadata !{i32 %"14"}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !{i32 %"17"}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !{i32 %"20"}, i64 0, metadata !14), !dbg !15
  call void @llvm.dbg.value(metadata !{i32 %.05}, i64 0, metadata !22), !dbg !23
  call void @llvm.dbg.value(metadata !{i32 %"21"}, i64 0, metadata !16), !dbg !17
  br label %foo_bb1, !dbg !24

foo_bb1:                                          ; preds = %foo_bb8, %foo_bb7, %foo_bb11, %foo_bb12, %foo_bb10, %foo_bb0
  %.010 = phi i32 [ %tk, %foo_bb0 ], [ %.05, %foo_bb7 ], [ %.010, %foo_bb8 ], [ %.010, %foo_bb10 ], [ %.05, %foo_bb12 ], [ %.010, %foo_bb11 ]
  %.05 = phi i32 [ %k, %foo_bb0 ], [ %"13", %foo_bb7 ], [ %.05, %foo_bb8 ], [ %.05, %foo_bb10 ], [ %"21", %foo_bb12 ], [ %.05, %foo_bb11 ]
  %.01 = phi i32 [ %j, %foo_bb0 ], [ %"12", %foo_bb7 ], [ %.01, %foo_bb8 ], [ %.01, %foo_bb10 ], [ %"20", %foo_bb12 ], [ %.01, %foo_bb11 ]
  %.0 = phi i32 [ %i, %foo_bb0 ], [ %.0, %foo_bb7 ], [ %"14", %foo_bb8 ], [ %"17", %foo_bb10 ], [ %.0, %foo_bb12 ], [ %.0, %foo_bb11 ]
  %"0" = icmp sge i32 %an, %.0, !dbg !25
  %"1" = icmp sge i32 %bn, %.01, !dbg !27
  %or.cond = and i1 %"0", %"1", !dbg !25
  br i1 %or.cond, label %foo_bb3, label %foo_bb2, !dbg !25

foo_bb2:                                          ; preds = %foo_bb1
  %"2" = icmp sge i32 %an, %.0, !dbg !29
  %"3" = icmp sle i32 %bn, %.01, !dbg !32
  %or.cond15 = and i1 %"2", %"3", !dbg !29
  br i1 %or.cond15, label %foo_bb3, label %foo_bb4, !dbg !29

foo_bb3:                                          ; preds = %foo_bb2, %foo_bb1
  %.old = add nsw i32 %.010, 1, !dbg !34
  %.old20 = icmp sge i32 %.05, %.old, !dbg !34
  br i1 %.old20, label %foo_bb5, label %foo_.critedge, !dbg !38

foo_bb4:                                          ; preds = %foo_bb2
  %"4" = icmp sle i32 %an, %.0, !dbg !41
  %"5" = icmp sge i32 %bn, %.01, !dbg !44
  %or.cond16 = and i1 %"4", %"5", !dbg !41
  %"6" = add nsw i32 %.010, 1
  %"7" = icmp sge i32 %.05, %"6", !dbg !34
  %or.cond21 = and i1 %or.cond16, %"7", !dbg !41
  br i1 %or.cond21, label %foo_bb5, label %foo_.critedge, !dbg !41

foo_bb5:                                          ; preds = %foo_bb4, %foo_bb3
  %"8" = icmp sge i32 %an, %.0, !dbg !46
  %"9" = icmp sge i32 %bn, %.01, !dbg !49
  %or.cond17 = and i1 %"8", %"9", !dbg !46
  br i1 %or.cond17, label %foo_bb6, label %foo_bb9, !dbg !46

foo_bb6:                                          ; preds = %foo_bb5
  %"10" = call i32 @__VERIFIER_nondet_int(), !dbg !51
  %"11" = icmp ne i32 %"10", 0, !dbg !51
  br i1 %"11", label %foo_bb7, label %foo_bb8, !dbg !51

foo_bb7:                                          ; preds = %foo_bb6
  %"12" = add nsw i32 %.01, %.05, !dbg !54
  %"13" = call i32 @__VERIFIER_nondet_int(), !dbg !56
  br label %foo_bb1, !dbg !57

foo_bb8:                                          ; preds = %foo_bb6
  %"14" = add nsw i32 %.0, 1, !dbg !58
  br label %foo_bb1

foo_bb9:                                          ; preds = %foo_bb5
  %"15" = icmp sge i32 %an, %.0, !dbg !60
  %"16" = icmp sle i32 %bn, %.01, !dbg !63
  %or.cond18 = and i1 %"15", %"16", !dbg !60
  br i1 %or.cond18, label %foo_bb10, label %foo_bb11, !dbg !60

foo_bb10:                                         ; preds = %foo_bb9
  %"17" = add nsw i32 %.0, 1, !dbg !65
  br label %foo_bb1, !dbg !67

foo_bb11:                                         ; preds = %foo_bb9
  %"18" = icmp sle i32 %an, %.0, !dbg !68
  %"19" = icmp sge i32 %bn, %.01, !dbg !71
  %or.cond19 = and i1 %"18", %"19", !dbg !68
  br i1 %or.cond19, label %foo_bb12, label %foo_bb1, !dbg !68

foo_bb12:                                         ; preds = %foo_bb11
  %"20" = add nsw i32 %.01, %.05, !dbg !73
  %"21" = call i32 @__VERIFIER_nondet_int(), !dbg !75
  br label %foo_bb1, !dbg !76

foo_.critedge:                                    ; preds = %foo_bb4, %foo_bb3
  ret i32 0, !dbg !77
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

!0 = metadata !{i32 786449, metadata !1, i32 12, metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)", i1 false, metadata !"", i32 0, metadata !2, metadata !2, metadata !3, metadata !2, metadata !2, metadata !"", i32 1} ; [ DW_TAG_compile_unit ] [/liveness_analysis/ChawdharyCookGulwaniSagivYang-ESOP2008-aaron4_true-termination.c] [DW_LANG_C99]
!1 = metadata !{metadata !"ChawdharyCookGulwaniSagivYang-ESOP2008-aaron4_true-termination.c", metadata !"/liveness_analysis"}
!2 = metadata !{}
!3 = metadata !{metadata !4}
!4 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"foo", metadata !"foo", metadata !"", i32 3, metadata !6, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, i32 (i32, i32, i32, i32, i32, i32)* @foo, null, null, metadata !2, i32 3} ; [ DW_TAG_subprogram ] [line 3] [def] [foo]
!5 = metadata !{i32 786473, metadata !1}          ; [ DW_TAG_file_type ] [/liveness_analysis/ChawdharyCookGulwaniSagivYang-ESOP2008-aaron4_true-termination.c]
!6 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !7, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!7 = metadata !{metadata !8, metadata !8, metadata !8, metadata !8, metadata !8, metadata !8, metadata !8}
!8 = metadata !{i32 786468, null, null, metadata !"int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!9 = metadata !{i32 2, metadata !"Dwarf Version", i32 4}
!10 = metadata !{i32 2, metadata !"Debug Info Version", i32 1}
!11 = metadata !{metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)"}
!12 = metadata !{i32 786689, metadata !4, metadata !"i", metadata !5, i32 16777219, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [i] [line 3]
!13 = metadata !{i32 3, i32 13, metadata !4, null}
!14 = metadata !{i32 786689, metadata !4, metadata !"j", metadata !5, i32 33554435, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [j] [line 3]
!15 = metadata !{i32 3, i32 19, metadata !4, null}
!16 = metadata !{i32 786689, metadata !4, metadata !"k", metadata !5, i32 50331651, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [k] [line 3]
!17 = metadata !{i32 3, i32 25, metadata !4, null}
!18 = metadata !{i32 786689, metadata !4, metadata !"an", metadata !5, i32 67108867, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [an] [line 3]
!19 = metadata !{i32 3, i32 31, metadata !4, null}
!20 = metadata !{i32 786689, metadata !4, metadata !"bn", metadata !5, i32 83886083, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [bn] [line 3]
!21 = metadata !{i32 3, i32 38, metadata !4, null}
!22 = metadata !{i32 786689, metadata !4, metadata !"tk", metadata !5, i32 100663299, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [tk] [line 3]
!23 = metadata !{i32 3, i32 45, metadata !4, null}
!24 = metadata !{i32 4, i32 1, metadata !4, null}
!25 = metadata !{i32 4, i32 1, metadata !26, null}
!26 = metadata !{i32 786443, metadata !1, metadata !4, i32 4, i32 1, i32 1, i32 12} ; [ DW_TAG_lexical_block ] [/liveness_analysis/ChawdharyCookGulwaniSagivYang-ESOP2008-aaron4_true-termination.c]
!27 = metadata !{i32 4, i32 1, metadata !28, null}
!28 = metadata !{i32 786443, metadata !1, metadata !4, i32 4, i32 1, i32 2, i32 13} ; [ DW_TAG_lexical_block ] [/liveness_analysis/ChawdharyCookGulwaniSagivYang-ESOP2008-aaron4_true-termination.c]
!29 = metadata !{i32 4, i32 1, metadata !30, null}
!30 = metadata !{i32 786443, metadata !1, metadata !31, i32 4, i32 1, i32 5, i32 16} ; [ DW_TAG_lexical_block ] [/liveness_analysis/ChawdharyCookGulwaniSagivYang-ESOP2008-aaron4_true-termination.c]
!31 = metadata !{i32 786443, metadata !1, metadata !4, i32 4, i32 1, i32 3, i32 14} ; [ DW_TAG_lexical_block ] [/liveness_analysis/ChawdharyCookGulwaniSagivYang-ESOP2008-aaron4_true-termination.c]
!32 = metadata !{i32 4, i32 1, metadata !33, null}
!33 = metadata !{i32 786443, metadata !1, metadata !4, i32 4, i32 1, i32 6, i32 17} ; [ DW_TAG_lexical_block ] [/liveness_analysis/ChawdharyCookGulwaniSagivYang-ESOP2008-aaron4_true-termination.c]
!34 = metadata !{i32 4, i32 1, metadata !35, null}
!35 = metadata !{i32 786443, metadata !1, metadata !36, i32 4, i32 1, i32 12, i32 23} ; [ DW_TAG_lexical_block ] [/liveness_analysis/ChawdharyCookGulwaniSagivYang-ESOP2008-aaron4_true-termination.c]
!36 = metadata !{i32 786443, metadata !1, metadata !37, i32 4, i32 1, i32 8, i32 19} ; [ DW_TAG_lexical_block ] [/liveness_analysis/ChawdharyCookGulwaniSagivYang-ESOP2008-aaron4_true-termination.c]
!37 = metadata !{i32 786443, metadata !1, metadata !4, i32 4, i32 1, i32 4, i32 15} ; [ DW_TAG_lexical_block ] [/liveness_analysis/ChawdharyCookGulwaniSagivYang-ESOP2008-aaron4_true-termination.c]
!38 = metadata !{i32 4, i32 1, metadata !39, null}
!39 = metadata !{i32 786443, metadata !1, metadata !40, i32 4, i32 1, i32 13, i32 24} ; [ DW_TAG_lexical_block ] [/liveness_analysis/ChawdharyCookGulwaniSagivYang-ESOP2008-aaron4_true-termination.c]
!40 = metadata !{i32 786443, metadata !1, metadata !4, i32 4, i32 1, i32 11, i32 22} ; [ DW_TAG_lexical_block ] [/liveness_analysis/ChawdharyCookGulwaniSagivYang-ESOP2008-aaron4_true-termination.c]
!41 = metadata !{i32 4, i32 1, metadata !42, null}
!42 = metadata !{i32 786443, metadata !1, metadata !43, i32 4, i32 1, i32 9, i32 20} ; [ DW_TAG_lexical_block ] [/liveness_analysis/ChawdharyCookGulwaniSagivYang-ESOP2008-aaron4_true-termination.c]
!43 = metadata !{i32 786443, metadata !1, metadata !4, i32 4, i32 1, i32 7, i32 18} ; [ DW_TAG_lexical_block ] [/liveness_analysis/ChawdharyCookGulwaniSagivYang-ESOP2008-aaron4_true-termination.c]
!44 = metadata !{i32 4, i32 1, metadata !45, null}
!45 = metadata !{i32 786443, metadata !1, metadata !4, i32 4, i32 1, i32 10, i32 21} ; [ DW_TAG_lexical_block ] [/liveness_analysis/ChawdharyCookGulwaniSagivYang-ESOP2008-aaron4_true-termination.c]
!46 = metadata !{i32 5, i32 7, metadata !47, null}
!47 = metadata !{i32 786443, metadata !1, metadata !48, i32 5, i32 7, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/liveness_analysis/ChawdharyCookGulwaniSagivYang-ESOP2008-aaron4_true-termination.c]
!48 = metadata !{i32 786443, metadata !1, metadata !4, i32 4, i32 95, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/liveness_analysis/ChawdharyCookGulwaniSagivYang-ESOP2008-aaron4_true-termination.c]
!49 = metadata !{i32 5, i32 7, metadata !50, null}
!50 = metadata !{i32 786443, metadata !1, metadata !47, i32 5, i32 7, i32 1, i32 25} ; [ DW_TAG_lexical_block ] [/liveness_analysis/ChawdharyCookGulwaniSagivYang-ESOP2008-aaron4_true-termination.c]
!51 = metadata !{i32 6, i32 8, metadata !52, null}
!52 = metadata !{i32 786443, metadata !1, metadata !53, i32 6, i32 8, i32 0, i32 3} ; [ DW_TAG_lexical_block ] [/liveness_analysis/ChawdharyCookGulwaniSagivYang-ESOP2008-aaron4_true-termination.c]
!53 = metadata !{i32 786443, metadata !1, metadata !47, i32 5, i32 27, i32 0, i32 2} ; [ DW_TAG_lexical_block ] [/liveness_analysis/ChawdharyCookGulwaniSagivYang-ESOP2008-aaron4_true-termination.c]
!54 = metadata !{i32 7, i32 5, metadata !55, null}
!55 = metadata !{i32 786443, metadata !1, metadata !52, i32 6, i32 38, i32 0, i32 4} ; [ DW_TAG_lexical_block ] [/liveness_analysis/ChawdharyCookGulwaniSagivYang-ESOP2008-aaron4_true-termination.c]
!56 = metadata !{i32 9, i32 9, metadata !55, null}
!57 = metadata !{i32 10, i32 4, metadata !55, null}
!58 = metadata !{i32 11, i32 5, metadata !59, null}
!59 = metadata !{i32 786443, metadata !1, metadata !52, i32 10, i32 11, i32 0, i32 5} ; [ DW_TAG_lexical_block ] [/liveness_analysis/ChawdharyCookGulwaniSagivYang-ESOP2008-aaron4_true-termination.c]
!60 = metadata !{i32 13, i32 15, metadata !61, null}
!61 = metadata !{i32 786443, metadata !1, metadata !62, i32 13, i32 15, i32 0, i32 7} ; [ DW_TAG_lexical_block ] [/liveness_analysis/ChawdharyCookGulwaniSagivYang-ESOP2008-aaron4_true-termination.c]
!62 = metadata !{i32 786443, metadata !1, metadata !47, i32 13, i32 10, i32 0, i32 6} ; [ DW_TAG_lexical_block ] [/liveness_analysis/ChawdharyCookGulwaniSagivYang-ESOP2008-aaron4_true-termination.c]
!63 = metadata !{i32 13, i32 15, metadata !64, null}
!64 = metadata !{i32 786443, metadata !1, metadata !61, i32 13, i32 15, i32 1, i32 26} ; [ DW_TAG_lexical_block ] [/liveness_analysis/ChawdharyCookGulwaniSagivYang-ESOP2008-aaron4_true-termination.c]
!65 = metadata !{i32 14, i32 4, metadata !66, null}
!66 = metadata !{i32 786443, metadata !1, metadata !61, i32 13, i32 35, i32 0, i32 8} ; [ DW_TAG_lexical_block ] [/liveness_analysis/ChawdharyCookGulwaniSagivYang-ESOP2008-aaron4_true-termination.c]
!67 = metadata !{i32 15, i32 3, metadata !66, null}
!68 = metadata !{i32 15, i32 15, metadata !69, null}
!69 = metadata !{i32 786443, metadata !1, metadata !70, i32 15, i32 15, i32 0, i32 10} ; [ DW_TAG_lexical_block ] [/liveness_analysis/ChawdharyCookGulwaniSagivYang-ESOP2008-aaron4_true-termination.c]
!70 = metadata !{i32 786443, metadata !1, metadata !61, i32 15, i32 10, i32 0, i32 9} ; [ DW_TAG_lexical_block ] [/liveness_analysis/ChawdharyCookGulwaniSagivYang-ESOP2008-aaron4_true-termination.c]
!71 = metadata !{i32 15, i32 15, metadata !72, null}
!72 = metadata !{i32 786443, metadata !1, metadata !69, i32 15, i32 15, i32 1, i32 27} ; [ DW_TAG_lexical_block ] [/liveness_analysis/ChawdharyCookGulwaniSagivYang-ESOP2008-aaron4_true-termination.c]
!73 = metadata !{i32 16, i32 4, metadata !74, null}
!74 = metadata !{i32 786443, metadata !1, metadata !69, i32 15, i32 35, i32 0, i32 11} ; [ DW_TAG_lexical_block ] [/liveness_analysis/ChawdharyCookGulwaniSagivYang-ESOP2008-aaron4_true-termination.c]
!75 = metadata !{i32 18, i32 8, metadata !74, null}
!76 = metadata !{i32 19, i32 3, metadata !74, null}
!77 = metadata !{i32 21, i32 1, metadata !4, null}

