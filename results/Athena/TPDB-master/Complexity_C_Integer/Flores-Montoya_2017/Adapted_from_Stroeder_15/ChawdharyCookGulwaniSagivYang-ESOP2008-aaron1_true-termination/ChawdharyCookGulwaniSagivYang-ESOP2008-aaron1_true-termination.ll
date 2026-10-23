; ModuleID = 'ChawdharyCookGulwaniSagivYang-ESOP2008-aaron1_true-termination.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind uwtable
define i32 @foo(i32 %i, i32 %j, i32 %an, i32 %bn) #0 {
foo_bb0:
  call void @llvm.dbg.value(metadata !{i32 %i}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !{i32 %j}, i64 0, metadata !14), !dbg !15
  call void @llvm.dbg.value(metadata !{i32 %an}, i64 0, metadata !16), !dbg !17
  call void @llvm.dbg.value(metadata !{i32 %bn}, i64 0, metadata !18), !dbg !19
  call void @llvm.dbg.value(metadata !{i32 %"10"}, i64 0, metadata !14), !dbg !15
  call void @llvm.dbg.value(metadata !{i32 %"11"}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !{i32 %"14"}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !{i32 %"17"}, i64 0, metadata !14), !dbg !15
  br label %foo_bb1, !dbg !20

foo_bb1:                                          ; preds = %foo_bb4, %foo_bb7, %foo_bb6, %foo_bb0
  %.01 = phi i32 [ %j, %foo_bb0 ], [ %.12, %foo_bb4 ], [ %.01, %foo_bb6 ], [ %.23, %foo_bb7 ]
  %.0 = phi i32 [ %i, %foo_bb0 ], [ %.1, %foo_bb4 ], [ %"14", %foo_bb6 ], [ %.0, %foo_bb7 ]
  %"0" = icmp sge i32 %an, %.0, !dbg !21
  %"1" = icmp sge i32 %bn, %.01, !dbg !23
  %or.cond = and i1 %"0", %"1", !dbg !21
  br i1 %or.cond, label %foo_.critedge, label %foo_bb2, !dbg !21

foo_bb2:                                          ; preds = %foo_bb1
  %"2" = icmp sge i32 %an, %.0, !dbg !25
  %"3" = icmp sle i32 %bn, %.01, !dbg !28
  %or.cond5 = and i1 %"2", %"3", !dbg !25
  br i1 %or.cond5, label %foo_.critedge, label %foo_bb3, !dbg !25

foo_bb3:                                          ; preds = %foo_bb2
  %"4" = icmp sle i32 %an, %.0, !dbg !30
  %"5" = icmp sge i32 %bn, %.01, !dbg !33
  %. = select i1 %"4", i1 %"5", i1 false, !dbg !30
  br i1 %., label %foo_.critedge, label %foo_bb8, !dbg !35

foo_.critedge:                                    ; preds = %foo_bb2, %foo_bb1, %foo_bb3
  %"6" = icmp sge i32 %an, %.0, !dbg !39
  %"7" = icmp sge i32 %bn, %.01, !dbg !42
  %or.cond7 = and i1 %"6", %"7", !dbg !39
  br i1 %or.cond7, label %foo_bb4, label %foo_bb5, !dbg !39

foo_bb4:                                          ; preds = %foo_.critedge
  %"8" = call i32 @__VERIFIER_nondet_int(), !dbg !44
  %"9" = icmp ne i32 %"8", 0, !dbg !44
  %"10" = add nsw i32 %.01, 1, !dbg !47
  %"11" = add nsw i32 %.0, 1, !dbg !49
  %.12 = select i1 %"9", i32 %"10", i32 %.01, !dbg !44
  %.1 = select i1 %"9", i32 %.0, i32 %"11", !dbg !44
  br label %foo_bb1, !dbg !44

foo_bb5:                                          ; preds = %foo_.critedge
  %"12" = icmp sge i32 %an, %.0, !dbg !51
  %"13" = icmp sle i32 %bn, %.01, !dbg !54
  %or.cond8 = and i1 %"12", %"13", !dbg !51
  br i1 %or.cond8, label %foo_bb6, label %foo_bb7, !dbg !51

foo_bb6:                                          ; preds = %foo_bb5
  %"14" = add nsw i32 %.0, 1, !dbg !56
  br label %foo_bb1, !dbg !58

foo_bb7:                                          ; preds = %foo_bb5
  %"15" = icmp sle i32 %an, %.0, !dbg !59
  %"16" = icmp sge i32 %bn, %.01, !dbg !62
  %or.cond9 = and i1 %"15", %"16", !dbg !59
  %"17" = add nsw i32 %.01, 1, !dbg !64
  %.23 = select i1 %or.cond9, i32 %"17", i32 %.01, !dbg !59
  br label %foo_bb1, !dbg !59

foo_bb8:                                          ; preds = %foo_bb3
  ret i32 0, !dbg !66
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

!0 = metadata !{i32 786449, metadata !1, i32 12, metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)", i1 false, metadata !"", i32 0, metadata !2, metadata !2, metadata !3, metadata !2, metadata !2, metadata !"", i32 1} ; [ DW_TAG_compile_unit ] [/liveness_analysis/ChawdharyCookGulwaniSagivYang-ESOP2008-aaron1_true-termination.c] [DW_LANG_C99]
!1 = metadata !{metadata !"ChawdharyCookGulwaniSagivYang-ESOP2008-aaron1_true-termination.c", metadata !"/liveness_analysis"}
!2 = metadata !{}
!3 = metadata !{metadata !4}
!4 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"foo", metadata !"foo", metadata !"", i32 3, metadata !6, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, i32 (i32, i32, i32, i32)* @foo, null, null, metadata !2, i32 3} ; [ DW_TAG_subprogram ] [line 3] [def] [foo]
!5 = metadata !{i32 786473, metadata !1}          ; [ DW_TAG_file_type ] [/liveness_analysis/ChawdharyCookGulwaniSagivYang-ESOP2008-aaron1_true-termination.c]
!6 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !7, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!7 = metadata !{metadata !8, metadata !8, metadata !8, metadata !8, metadata !8}
!8 = metadata !{i32 786468, null, null, metadata !"int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!9 = metadata !{i32 2, metadata !"Dwarf Version", i32 4}
!10 = metadata !{i32 2, metadata !"Debug Info Version", i32 1}
!11 = metadata !{metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)"}
!12 = metadata !{i32 786689, metadata !4, metadata !"i", metadata !5, i32 16777219, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [i] [line 3]
!13 = metadata !{i32 3, i32 13, metadata !4, null}
!14 = metadata !{i32 786689, metadata !4, metadata !"j", metadata !5, i32 33554435, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [j] [line 3]
!15 = metadata !{i32 3, i32 19, metadata !4, null}
!16 = metadata !{i32 786689, metadata !4, metadata !"an", metadata !5, i32 50331651, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [an] [line 3]
!17 = metadata !{i32 3, i32 25, metadata !4, null}
!18 = metadata !{i32 786689, metadata !4, metadata !"bn", metadata !5, i32 67108867, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [bn] [line 3]
!19 = metadata !{i32 3, i32 32, metadata !4, null}
!20 = metadata !{i32 4, i32 1, metadata !4, null}
!21 = metadata !{i32 4, i32 1, metadata !22, null}
!22 = metadata !{i32 786443, metadata !1, metadata !4, i32 4, i32 1, i32 1, i32 12} ; [ DW_TAG_lexical_block ] [/liveness_analysis/ChawdharyCookGulwaniSagivYang-ESOP2008-aaron1_true-termination.c]
!23 = metadata !{i32 4, i32 1, metadata !24, null}
!24 = metadata !{i32 786443, metadata !1, metadata !4, i32 4, i32 1, i32 2, i32 13} ; [ DW_TAG_lexical_block ] [/liveness_analysis/ChawdharyCookGulwaniSagivYang-ESOP2008-aaron1_true-termination.c]
!25 = metadata !{i32 4, i32 1, metadata !26, null}
!26 = metadata !{i32 786443, metadata !1, metadata !27, i32 4, i32 1, i32 5, i32 16} ; [ DW_TAG_lexical_block ] [/liveness_analysis/ChawdharyCookGulwaniSagivYang-ESOP2008-aaron1_true-termination.c]
!27 = metadata !{i32 786443, metadata !1, metadata !4, i32 4, i32 1, i32 3, i32 14} ; [ DW_TAG_lexical_block ] [/liveness_analysis/ChawdharyCookGulwaniSagivYang-ESOP2008-aaron1_true-termination.c]
!28 = metadata !{i32 4, i32 1, metadata !29, null}
!29 = metadata !{i32 786443, metadata !1, metadata !4, i32 4, i32 1, i32 6, i32 17} ; [ DW_TAG_lexical_block ] [/liveness_analysis/ChawdharyCookGulwaniSagivYang-ESOP2008-aaron1_true-termination.c]
!30 = metadata !{i32 4, i32 1, metadata !31, null}
!31 = metadata !{i32 786443, metadata !1, metadata !32, i32 4, i32 1, i32 9, i32 20} ; [ DW_TAG_lexical_block ] [/liveness_analysis/ChawdharyCookGulwaniSagivYang-ESOP2008-aaron1_true-termination.c]
!32 = metadata !{i32 786443, metadata !1, metadata !4, i32 4, i32 1, i32 7, i32 18} ; [ DW_TAG_lexical_block ] [/liveness_analysis/ChawdharyCookGulwaniSagivYang-ESOP2008-aaron1_true-termination.c]
!33 = metadata !{i32 4, i32 1, metadata !34, null}
!34 = metadata !{i32 786443, metadata !1, metadata !4, i32 4, i32 1, i32 10, i32 21} ; [ DW_TAG_lexical_block ] [/liveness_analysis/ChawdharyCookGulwaniSagivYang-ESOP2008-aaron1_true-termination.c]
!35 = metadata !{i32 4, i32 1, metadata !36, null}
!36 = metadata !{i32 786443, metadata !1, metadata !37, i32 4, i32 1, i32 12, i32 23} ; [ DW_TAG_lexical_block ] [/liveness_analysis/ChawdharyCookGulwaniSagivYang-ESOP2008-aaron1_true-termination.c]
!37 = metadata !{i32 786443, metadata !1, metadata !38, i32 4, i32 1, i32 8, i32 19} ; [ DW_TAG_lexical_block ] [/liveness_analysis/ChawdharyCookGulwaniSagivYang-ESOP2008-aaron1_true-termination.c]
!38 = metadata !{i32 786443, metadata !1, metadata !4, i32 4, i32 1, i32 4, i32 15} ; [ DW_TAG_lexical_block ] [/liveness_analysis/ChawdharyCookGulwaniSagivYang-ESOP2008-aaron1_true-termination.c]
!39 = metadata !{i32 5, i32 7, metadata !40, null}
!40 = metadata !{i32 786443, metadata !1, metadata !41, i32 5, i32 7, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/liveness_analysis/ChawdharyCookGulwaniSagivYang-ESOP2008-aaron1_true-termination.c]
!41 = metadata !{i32 786443, metadata !1, metadata !4, i32 4, i32 78, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/liveness_analysis/ChawdharyCookGulwaniSagivYang-ESOP2008-aaron1_true-termination.c]
!42 = metadata !{i32 5, i32 7, metadata !43, null}
!43 = metadata !{i32 786443, metadata !1, metadata !40, i32 5, i32 7, i32 1, i32 24} ; [ DW_TAG_lexical_block ] [/liveness_analysis/ChawdharyCookGulwaniSagivYang-ESOP2008-aaron1_true-termination.c]
!44 = metadata !{i32 6, i32 8, metadata !45, null}
!45 = metadata !{i32 786443, metadata !1, metadata !46, i32 6, i32 8, i32 0, i32 3} ; [ DW_TAG_lexical_block ] [/liveness_analysis/ChawdharyCookGulwaniSagivYang-ESOP2008-aaron1_true-termination.c]
!46 = metadata !{i32 786443, metadata !1, metadata !40, i32 5, i32 27, i32 0, i32 2} ; [ DW_TAG_lexical_block ] [/liveness_analysis/ChawdharyCookGulwaniSagivYang-ESOP2008-aaron1_true-termination.c]
!47 = metadata !{i32 7, i32 5, metadata !48, null}
!48 = metadata !{i32 786443, metadata !1, metadata !45, i32 6, i32 38, i32 0, i32 4} ; [ DW_TAG_lexical_block ] [/liveness_analysis/ChawdharyCookGulwaniSagivYang-ESOP2008-aaron1_true-termination.c]
!49 = metadata !{i32 9, i32 5, metadata !50, null}
!50 = metadata !{i32 786443, metadata !1, metadata !45, i32 8, i32 11, i32 0, i32 5} ; [ DW_TAG_lexical_block ] [/liveness_analysis/ChawdharyCookGulwaniSagivYang-ESOP2008-aaron1_true-termination.c]
!51 = metadata !{i32 11, i32 15, metadata !52, null}
!52 = metadata !{i32 786443, metadata !1, metadata !53, i32 11, i32 15, i32 0, i32 7} ; [ DW_TAG_lexical_block ] [/liveness_analysis/ChawdharyCookGulwaniSagivYang-ESOP2008-aaron1_true-termination.c]
!53 = metadata !{i32 786443, metadata !1, metadata !40, i32 11, i32 10, i32 0, i32 6} ; [ DW_TAG_lexical_block ] [/liveness_analysis/ChawdharyCookGulwaniSagivYang-ESOP2008-aaron1_true-termination.c]
!54 = metadata !{i32 11, i32 15, metadata !55, null}
!55 = metadata !{i32 786443, metadata !1, metadata !52, i32 11, i32 15, i32 1, i32 25} ; [ DW_TAG_lexical_block ] [/liveness_analysis/ChawdharyCookGulwaniSagivYang-ESOP2008-aaron1_true-termination.c]
!56 = metadata !{i32 12, i32 4, metadata !57, null}
!57 = metadata !{i32 786443, metadata !1, metadata !52, i32 11, i32 35, i32 0, i32 8} ; [ DW_TAG_lexical_block ] [/liveness_analysis/ChawdharyCookGulwaniSagivYang-ESOP2008-aaron1_true-termination.c]
!58 = metadata !{i32 13, i32 3, metadata !57, null}
!59 = metadata !{i32 13, i32 15, metadata !60, null}
!60 = metadata !{i32 786443, metadata !1, metadata !61, i32 13, i32 15, i32 0, i32 10} ; [ DW_TAG_lexical_block ] [/liveness_analysis/ChawdharyCookGulwaniSagivYang-ESOP2008-aaron1_true-termination.c]
!61 = metadata !{i32 786443, metadata !1, metadata !52, i32 13, i32 10, i32 0, i32 9} ; [ DW_TAG_lexical_block ] [/liveness_analysis/ChawdharyCookGulwaniSagivYang-ESOP2008-aaron1_true-termination.c]
!62 = metadata !{i32 13, i32 15, metadata !63, null}
!63 = metadata !{i32 786443, metadata !1, metadata !60, i32 13, i32 15, i32 1, i32 26} ; [ DW_TAG_lexical_block ] [/liveness_analysis/ChawdharyCookGulwaniSagivYang-ESOP2008-aaron1_true-termination.c]
!64 = metadata !{i32 14, i32 4, metadata !65, null}
!65 = metadata !{i32 786443, metadata !1, metadata !60, i32 13, i32 35, i32 0, i32 11} ; [ DW_TAG_lexical_block ] [/liveness_analysis/ChawdharyCookGulwaniSagivYang-ESOP2008-aaron1_true-termination.c]
!66 = metadata !{i32 17, i32 1, metadata !4, null}

