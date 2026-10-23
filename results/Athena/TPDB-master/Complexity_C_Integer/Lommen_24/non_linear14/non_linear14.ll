; ModuleID = 'non_linear14.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind uwtable
define void @non_linear14(i32 %x1, i32 %x2, i32 %x3, i32 %x4, i32 %y1, i32 %y2) #0 {
non_linear14_bb0:
  call void @llvm.dbg.value(metadata !{i32 %x1}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !{i32 %x2}, i64 0, metadata !14), !dbg !15
  call void @llvm.dbg.value(metadata !{i32 %x3}, i64 0, metadata !16), !dbg !17
  call void @llvm.dbg.value(metadata !{i32 %x4}, i64 0, metadata !18), !dbg !19
  call void @llvm.dbg.value(metadata !{i32 %y1}, i64 0, metadata !20), !dbg !21
  call void @llvm.dbg.value(metadata !{i32 %y2}, i64 0, metadata !22), !dbg !23
  %"0" = call i32 @__VERIFIER_nondet_int(), !dbg !24
  call void @llvm.dbg.value(metadata !{i32 %"0"}, i64 0, metadata !25), !dbg !26
  %"1" = call i32 @__VERIFIER_nondet_int(), !dbg !27
  call void @llvm.dbg.value(metadata !{i32 %"1"}, i64 0, metadata !28), !dbg !29
  call void @llvm.dbg.value(metadata !{i32 %"0"}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !{i32 %"5"}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !{i32 %"6"}, i64 0, metadata !28), !dbg !29
  call void @llvm.dbg.value(metadata !{i32 %"9"}, i64 0, metadata !14), !dbg !15
  call void @llvm.dbg.value(metadata !{i32 %"10"}, i64 0, metadata !28), !dbg !29
  br label %non_linear14_bb1, !dbg !30

non_linear14_bb1:                                 ; preds = %non_linear14_bb2, %non_linear14_bb4, %non_linear14_bb0
  %v.0 = phi i32 [ %"1", %non_linear14_bb0 ], [ %"6", %non_linear14_bb2 ], [ %"10", %non_linear14_bb4 ]
  %.01 = phi i32 [ %x2, %non_linear14_bb0 ], [ %.01, %non_linear14_bb2 ], [ %"9", %non_linear14_bb4 ]
  %.0 = phi i32 [ %"0", %non_linear14_bb0 ], [ %"5", %non_linear14_bb2 ], [ %.0, %non_linear14_bb4 ]
  %"2" = icmp sle i32 1, %.0, !dbg !31
  %"3" = icmp sle i32 %.0, 3, !dbg !34
  %or.cond = and i1 %"2", %"3", !dbg !31
  %"4" = icmp eq i32 %v.0, 0, !dbg !36
  %or.cond6 = and i1 %or.cond, %"4", !dbg !31
  br i1 %or.cond6, label %non_linear14_bb2, label %non_linear14_bb3, !dbg !31

non_linear14_bb2:                                 ; preds = %non_linear14_bb1
  %"5" = add nsw i32 %.0, 1, !dbg !38
  %"6" = call i32 @__VERIFIER_nondet_int(), !dbg !40
  br label %non_linear14_bb1, !dbg !41

non_linear14_bb3:                                 ; preds = %non_linear14_bb1
  %"7" = icmp sgt i32 %.01, 1, !dbg !42
  %"8" = icmp eq i32 %v.0, 1, !dbg !44
  %or.cond7 = and i1 %"7", %"8", !dbg !42
  br i1 %or.cond7, label %non_linear14_bb4, label %non_linear14_bb5, !dbg !42

non_linear14_bb4:                                 ; preds = %non_linear14_bb3
  %"9" = sub nsw i32 %.01, 1, !dbg !46
  %"10" = call i32 @__VERIFIER_nondet_int(), !dbg !48
  br label %non_linear14_bb1

non_linear14_bb5:                                 ; preds = %non_linear14_bb3, %non_linear14_bb6
  %.05 = phi i32 [ %"33", %non_linear14_bb6 ], [ %y2, %non_linear14_bb3 ]
  %.04 = phi i32 [ %"25", %non_linear14_bb6 ], [ %y1, %non_linear14_bb3 ]
  %.03 = phi i32 [ %"21", %non_linear14_bb6 ], [ %x4, %non_linear14_bb3 ]
  %"11" = mul nsw i32 %.03, %.03, !dbg !49
  %"12" = mul nsw i32 %x3, %x3, !dbg !49
  %"13" = mul nsw i32 %"12", %x3, !dbg !49
  %"14" = mul nsw i32 %"13", %x3, !dbg !49
  %"15" = mul nsw i32 %"14", %x3, !dbg !49
  %"16" = sub nsw i32 %"11", %"15", !dbg !49
  %"17" = mul nsw i32 2, %.04, !dbg !49
  %"18" = sub nsw i32 %"17", %.05, !dbg !49
  %"19" = icmp slt i32 %"16", %"18", !dbg !49
  %"20" = icmp ne i32 %.03, 0, !dbg !52
  %. = select i1 %"19", i1 %"20", i1 false, !dbg !49
  br i1 %., label %non_linear14_bb6, label %non_linear14_bb7, !dbg !54

non_linear14_bb6:                                 ; preds = %non_linear14_bb5
  %"21" = mul nsw i32 -2, %.03, !dbg !56
  %"22" = mul nsw i32 %.04, %.04, !dbg !58
  %"23" = add nsw i32 %.04, %"22", !dbg !58
  %"24" = mul nsw i32 %x3, %x3, !dbg !58
  %"25" = add nsw i32 %"23", %"24", !dbg !58
  %"26" = mul nsw i32 -4, %.04, !dbg !59
  %"27" = mul nsw i32 2, %.04, !dbg !59
  %"28" = mul nsw i32 %"27", %.04, !dbg !59
  %"29" = add nsw i32 %"26", %"28", !dbg !59
  %"30" = mul nsw i32 3, %.05, !dbg !59
  %"31" = add nsw i32 %"29", %"30", !dbg !59
  %"32" = mul nsw i32 %x3, %x3, !dbg !59
  %"33" = add nsw i32 %"31", %"32", !dbg !59
  br label %non_linear14_bb5, !dbg !60

non_linear14_bb7:                                 ; preds = %non_linear14_bb5
  ret void, !dbg !61
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

!0 = metadata !{i32 786449, metadata !1, i32 12, metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)", i1 false, metadata !"", i32 0, metadata !2, metadata !2, metadata !3, metadata !2, metadata !2, metadata !"", i32 1} ; [ DW_TAG_compile_unit ] [/liveness_analysis/non_linear14.c] [DW_LANG_C99]
!1 = metadata !{metadata !"non_linear14.c", metadata !"/liveness_analysis"}
!2 = metadata !{}
!3 = metadata !{metadata !4}
!4 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"non_linear14", metadata !"non_linear14", metadata !"", i32 3, metadata !6, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (i32, i32, i32, i32, i32, i32)* @non_linear14, null, null, metadata !2, i32 3} ; [ DW_TAG_subprogram ] [line 3] [def] [non_linear14]
!5 = metadata !{i32 786473, metadata !1}          ; [ DW_TAG_file_type ] [/liveness_analysis/non_linear14.c]
!6 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !7, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!7 = metadata !{null, metadata !8, metadata !8, metadata !8, metadata !8, metadata !8, metadata !8}
!8 = metadata !{i32 786468, null, null, metadata !"int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!9 = metadata !{i32 2, metadata !"Dwarf Version", i32 4}
!10 = metadata !{i32 2, metadata !"Debug Info Version", i32 1}
!11 = metadata !{metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)"}
!12 = metadata !{i32 786689, metadata !4, metadata !"x1", metadata !5, i32 16777219, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [x1] [line 3]
!13 = metadata !{i32 3, i32 23, metadata !4, null}
!14 = metadata !{i32 786689, metadata !4, metadata !"x2", metadata !5, i32 33554435, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [x2] [line 3]
!15 = metadata !{i32 3, i32 31, metadata !4, null}
!16 = metadata !{i32 786689, metadata !4, metadata !"x3", metadata !5, i32 50331651, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [x3] [line 3]
!17 = metadata !{i32 3, i32 39, metadata !4, null}
!18 = metadata !{i32 786689, metadata !4, metadata !"x4", metadata !5, i32 67108867, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [x4] [line 3]
!19 = metadata !{i32 3, i32 47, metadata !4, null}
!20 = metadata !{i32 786689, metadata !4, metadata !"y1", metadata !5, i32 83886083, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [y1] [line 3]
!21 = metadata !{i32 3, i32 55, metadata !4, null}
!22 = metadata !{i32 786689, metadata !4, metadata !"y2", metadata !5, i32 100663299, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [y2] [line 3]
!23 = metadata !{i32 3, i32 63, metadata !4, null}
!24 = metadata !{i32 4, i32 11, metadata !4, null}
!25 = metadata !{i32 786688, metadata !4, metadata !"u", metadata !5, i32 4, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [u] [line 4]
!26 = metadata !{i32 4, i32 7, metadata !4, null}
!27 = metadata !{i32 5, i32 11, metadata !4, null}
!28 = metadata !{i32 786688, metadata !4, metadata !"v", metadata !5, i32 5, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [v] [line 5]
!29 = metadata !{i32 5, i32 7, metadata !4, null}
!30 = metadata !{i32 8, i32 3, metadata !4, null} ; [ DW_TAG_imported_declaration ]
!31 = metadata !{i32 9, i32 9, metadata !32, null}
!32 = metadata !{i32 786443, metadata !1, metadata !33, i32 9, i32 9, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/liveness_analysis/non_linear14.c]
!33 = metadata !{i32 786443, metadata !1, metadata !4, i32 8, i32 13, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/liveness_analysis/non_linear14.c]
!34 = metadata !{i32 9, i32 9, metadata !35, null}
!35 = metadata !{i32 786443, metadata !1, metadata !32, i32 9, i32 9, i32 1, i32 7} ; [ DW_TAG_lexical_block ] [/liveness_analysis/non_linear14.c]
!36 = metadata !{i32 9, i32 9, metadata !37, null}
!37 = metadata !{i32 786443, metadata !1, metadata !32, i32 9, i32 9, i32 2, i32 8} ; [ DW_TAG_lexical_block ] [/liveness_analysis/non_linear14.c]
!38 = metadata !{i32 10, i32 7, metadata !39, null}
!39 = metadata !{i32 786443, metadata !1, metadata !32, i32 9, i32 39, i32 0, i32 2} ; [ DW_TAG_lexical_block ] [/liveness_analysis/non_linear14.c]
!40 = metadata !{i32 11, i32 11, metadata !39, null}
!41 = metadata !{i32 12, i32 5, metadata !39, null}
!42 = metadata !{i32 12, i32 16, metadata !43, null}
!43 = metadata !{i32 786443, metadata !1, metadata !32, i32 12, i32 16, i32 0, i32 3} ; [ DW_TAG_lexical_block ] [/liveness_analysis/non_linear14.c]
!44 = metadata !{i32 12, i32 16, metadata !45, null}
!45 = metadata !{i32 786443, metadata !1, metadata !43, i32 12, i32 16, i32 1, i32 9} ; [ DW_TAG_lexical_block ] [/liveness_analysis/non_linear14.c]
!46 = metadata !{i32 13, i32 7, metadata !47, null}
!47 = metadata !{i32 786443, metadata !1, metadata !43, i32 12, i32 34, i32 0, i32 4} ; [ DW_TAG_lexical_block ] [/liveness_analysis/non_linear14.c]
!48 = metadata !{i32 14, i32 11, metadata !47, null}
!49 = metadata !{i32 16, i32 7, metadata !50, null}
!50 = metadata !{i32 786443, metadata !1, metadata !51, i32 16, i32 7, i32 1, i32 10} ; [ DW_TAG_lexical_block ] [/liveness_analysis/non_linear14.c]
!51 = metadata !{i32 786443, metadata !1, metadata !43, i32 15, i32 12, i32 0, i32 5} ; [ DW_TAG_lexical_block ] [/liveness_analysis/non_linear14.c]
!52 = metadata !{i32 16, i32 7, metadata !53, null}
!53 = metadata !{i32 786443, metadata !1, metadata !51, i32 16, i32 7, i32 2, i32 11} ; [ DW_TAG_lexical_block ] [/liveness_analysis/non_linear14.c]
!54 = metadata !{i32 16, i32 7, metadata !55, null}
!55 = metadata !{i32 786443, metadata !1, metadata !51, i32 16, i32 7, i32 3, i32 12} ; [ DW_TAG_lexical_block ] [/liveness_analysis/non_linear14.c]
!56 = metadata !{i32 17, i32 9, metadata !57, null}
!57 = metadata !{i32 786443, metadata !1, metadata !51, i32 16, i32 60, i32 0, i32 6} ; [ DW_TAG_lexical_block ] [/liveness_analysis/non_linear14.c]
!58 = metadata !{i32 20, i32 9, metadata !57, null}
!59 = metadata !{i32 21, i32 9, metadata !57, null}
!60 = metadata !{i32 22, i32 7, metadata !57, null}
!61 = metadata !{i32 26, i32 1, metadata !4, null}

