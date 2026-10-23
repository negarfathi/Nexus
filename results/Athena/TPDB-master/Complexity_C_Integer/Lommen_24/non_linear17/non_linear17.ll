; ModuleID = 'non_linear17.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind uwtable
define void @f(i32 %x1, i32 %x2, i32 %x3, i32 %x4, i32 %y1, i32 %y2, i32 %f) #0 {
f_bb0:
  call void @llvm.dbg.value(metadata !{i32 %x1}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !{i32 %x2}, i64 0, metadata !14), !dbg !15
  call void @llvm.dbg.value(metadata !{i32 %x3}, i64 0, metadata !16), !dbg !17
  call void @llvm.dbg.value(metadata !{i32 %x4}, i64 0, metadata !18), !dbg !19
  call void @llvm.dbg.value(metadata !{i32 %y1}, i64 0, metadata !20), !dbg !21
  call void @llvm.dbg.value(metadata !{i32 %y2}, i64 0, metadata !22), !dbg !23
  call void @llvm.dbg.value(metadata !{i32 %f}, i64 0, metadata !24), !dbg !25
  %"0" = call i32 @__VERIFIER_nondet_int(), !dbg !26
  call void @llvm.dbg.value(metadata !{i32 %"0"}, i64 0, metadata !27), !dbg !28
  %"1" = call i32 @__VERIFIER_nondet_int(), !dbg !29
  call void @llvm.dbg.value(metadata !{i32 %"1"}, i64 0, metadata !30), !dbg !31
  call void @llvm.dbg.value(metadata !{i32 %"0"}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !{i32 %"1"}, i64 0, metadata !24), !dbg !25
  call void @llvm.dbg.value(metadata !{i32 %"5"}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !{i32 %"6"}, i64 0, metadata !30), !dbg !31
  call void @llvm.dbg.value(metadata !{i32 %"6"}, i64 0, metadata !24), !dbg !25
  call void @llvm.dbg.value(metadata !{i32 %"9"}, i64 0, metadata !14), !dbg !15
  call void @llvm.dbg.value(metadata !{i32 %"10"}, i64 0, metadata !30), !dbg !31
  call void @llvm.dbg.value(metadata !{i32 %"10"}, i64 0, metadata !24), !dbg !25
  br label %f_bb1, !dbg !32

f_bb1:                                            ; preds = %f_bb2, %f_bb4, %f_bb0
  %.03 = phi i32 [ %"1", %f_bb0 ], [ %"6", %f_bb2 ], [ %"10", %f_bb4 ]
  %.01 = phi i32 [ %x2, %f_bb0 ], [ %.01, %f_bb2 ], [ %"9", %f_bb4 ]
  %.0 = phi i32 [ %"0", %f_bb0 ], [ %"5", %f_bb2 ], [ %.0, %f_bb4 ]
  %"2" = icmp sle i32 1, %.0, !dbg !33
  %"3" = icmp sle i32 %.0, 3, !dbg !36
  %or.cond = and i1 %"2", %"3", !dbg !33
  %"4" = icmp eq i32 %.03, 0, !dbg !38
  %or.cond8 = and i1 %or.cond, %"4", !dbg !33
  br i1 %or.cond8, label %f_bb2, label %f_bb3, !dbg !33

f_bb2:                                            ; preds = %f_bb1
  %"5" = add nsw i32 %.0, 1, !dbg !40
  %"6" = call i32 @__VERIFIER_nondet_int(), !dbg !42
  br label %f_bb1, !dbg !43

f_bb3:                                            ; preds = %f_bb1
  %"7" = icmp sgt i32 %.01, 1, !dbg !44
  %"8" = icmp eq i32 %.03, 1, !dbg !46
  %or.cond9 = and i1 %"7", %"8", !dbg !44
  br i1 %or.cond9, label %f_bb4, label %f_bb5, !dbg !44

f_bb4:                                            ; preds = %f_bb3
  %"9" = sub nsw i32 %.01, 1, !dbg !48
  %"10" = call i32 @__VERIFIER_nondet_int(), !dbg !50
  br label %f_bb1

f_bb5:                                            ; preds = %f_bb3, %f_bb6
  %.06 = phi i32 [ %"14", %f_bb6 ], [ %y2, %f_bb3 ]
  %.05 = phi i32 [ %"13", %f_bb6 ], [ %y1, %f_bb3 ]
  %"11" = icmp slt i32 %.06, %.05, !dbg !51
  %"12" = icmp sgt i32 %.06, 0, !dbg !53
  %. = select i1 %"11", i1 %"12", i1 false, !dbg !51
  br i1 %., label %f_bb6, label %f_bb7, !dbg !55

f_bb6:                                            ; preds = %f_bb5
  %"13" = mul nsw i32 2, %.05, !dbg !57
  %"14" = mul nsw i32 3, %.06, !dbg !59
  br label %f_bb5, !dbg !60

f_bb7:                                            ; preds = %f_bb5, %f_bb8
  %.17 = phi i32 [ %"16", %f_bb8 ], [ %.06, %f_bb5 ]
  %"15" = icmp sgt i32 %.17, 0, !dbg !61
  br i1 %"15", label %f_bb8, label %f_bb9, !dbg !61

f_bb8:                                            ; preds = %f_bb7
  %"16" = sub nsw i32 %.17, 1, !dbg !63
  br label %f_bb7, !dbg !65

f_bb9:                                            ; preds = %f_bb7
  ret void, !dbg !66
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

!0 = metadata !{i32 786449, metadata !1, i32 12, metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)", i1 false, metadata !"", i32 0, metadata !2, metadata !2, metadata !3, metadata !2, metadata !2, metadata !"", i32 1} ; [ DW_TAG_compile_unit ] [/liveness_analysis/non_linear17.c] [DW_LANG_C99]
!1 = metadata !{metadata !"non_linear17.c", metadata !"/liveness_analysis"}
!2 = metadata !{}
!3 = metadata !{metadata !4}
!4 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"f", metadata !"f", metadata !"", i32 3, metadata !6, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (i32, i32, i32, i32, i32, i32, i32)* @f, null, null, metadata !2, i32 3} ; [ DW_TAG_subprogram ] [line 3] [def] [f]
!5 = metadata !{i32 786473, metadata !1}          ; [ DW_TAG_file_type ] [/liveness_analysis/non_linear17.c]
!6 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !7, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!7 = metadata !{null, metadata !8, metadata !8, metadata !8, metadata !8, metadata !8, metadata !8, metadata !8}
!8 = metadata !{i32 786468, null, null, metadata !"int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!9 = metadata !{i32 2, metadata !"Dwarf Version", i32 4}
!10 = metadata !{i32 2, metadata !"Debug Info Version", i32 1}
!11 = metadata !{metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)"}
!12 = metadata !{i32 786689, metadata !4, metadata !"x1", metadata !5, i32 16777219, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [x1] [line 3]
!13 = metadata !{i32 3, i32 12, metadata !4, null}
!14 = metadata !{i32 786689, metadata !4, metadata !"x2", metadata !5, i32 33554435, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [x2] [line 3]
!15 = metadata !{i32 3, i32 20, metadata !4, null}
!16 = metadata !{i32 786689, metadata !4, metadata !"x3", metadata !5, i32 50331651, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [x3] [line 3]
!17 = metadata !{i32 3, i32 28, metadata !4, null}
!18 = metadata !{i32 786689, metadata !4, metadata !"x4", metadata !5, i32 67108867, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [x4] [line 3]
!19 = metadata !{i32 3, i32 36, metadata !4, null}
!20 = metadata !{i32 786689, metadata !4, metadata !"y1", metadata !5, i32 83886083, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [y1] [line 3]
!21 = metadata !{i32 3, i32 44, metadata !4, null}
!22 = metadata !{i32 786689, metadata !4, metadata !"y2", metadata !5, i32 100663299, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [y2] [line 3]
!23 = metadata !{i32 3, i32 52, metadata !4, null}
!24 = metadata !{i32 786689, metadata !4, metadata !"f", metadata !5, i32 117440515, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [f] [line 3]
!25 = metadata !{i32 3, i32 60, metadata !4, null}
!26 = metadata !{i32 4, i32 11, metadata !4, null}
!27 = metadata !{i32 786688, metadata !4, metadata !"u", metadata !5, i32 4, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [u] [line 4]
!28 = metadata !{i32 4, i32 7, metadata !4, null}
!29 = metadata !{i32 5, i32 11, metadata !4, null}
!30 = metadata !{i32 786688, metadata !4, metadata !"v", metadata !5, i32 5, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [v] [line 5]
!31 = metadata !{i32 5, i32 7, metadata !4, null}
!32 = metadata !{i32 10, i32 3, metadata !4, null}
!33 = metadata !{i32 11, i32 9, metadata !34, null}
!34 = metadata !{i32 786443, metadata !1, metadata !35, i32 11, i32 9, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/liveness_analysis/non_linear17.c]
!35 = metadata !{i32 786443, metadata !1, metadata !4, i32 10, i32 13, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/liveness_analysis/non_linear17.c]
!36 = metadata !{i32 11, i32 9, metadata !37, null}
!37 = metadata !{i32 786443, metadata !1, metadata !34, i32 11, i32 9, i32 1, i32 8} ; [ DW_TAG_lexical_block ] [/liveness_analysis/non_linear17.c]
!38 = metadata !{i32 11, i32 9, metadata !39, null}
!39 = metadata !{i32 786443, metadata !1, metadata !34, i32 11, i32 9, i32 2, i32 9} ; [ DW_TAG_lexical_block ] [/liveness_analysis/non_linear17.c]
!40 = metadata !{i32 12, i32 7, metadata !41, null}
!41 = metadata !{i32 786443, metadata !1, metadata !34, i32 11, i32 39, i32 0, i32 2} ; [ DW_TAG_lexical_block ] [/liveness_analysis/non_linear17.c]
!42 = metadata !{i32 13, i32 11, metadata !41, null}
!43 = metadata !{i32 15, i32 5, metadata !41, null}
!44 = metadata !{i32 15, i32 16, metadata !45, null}
!45 = metadata !{i32 786443, metadata !1, metadata !34, i32 15, i32 16, i32 0, i32 3} ; [ DW_TAG_lexical_block ] [/liveness_analysis/non_linear17.c]
!46 = metadata !{i32 15, i32 16, metadata !47, null}
!47 = metadata !{i32 786443, metadata !1, metadata !45, i32 15, i32 16, i32 1, i32 10} ; [ DW_TAG_lexical_block ] [/liveness_analysis/non_linear17.c]
!48 = metadata !{i32 16, i32 7, metadata !49, null}
!49 = metadata !{i32 786443, metadata !1, metadata !45, i32 15, i32 34, i32 0, i32 4} ; [ DW_TAG_lexical_block ] [/liveness_analysis/non_linear17.c]
!50 = metadata !{i32 17, i32 11, metadata !49, null}
!51 = metadata !{i32 24, i32 3, metadata !52, null}
!52 = metadata !{i32 786443, metadata !1, metadata !4, i32 24, i32 3, i32 1, i32 11} ; [ DW_TAG_lexical_block ] [/liveness_analysis/non_linear17.c]
!53 = metadata !{i32 24, i32 3, metadata !54, null}
!54 = metadata !{i32 786443, metadata !1, metadata !4, i32 24, i32 3, i32 2, i32 12} ; [ DW_TAG_lexical_block ] [/liveness_analysis/non_linear17.c]
!55 = metadata !{i32 24, i32 3, metadata !56, null}
!56 = metadata !{i32 786443, metadata !1, metadata !4, i32 24, i32 3, i32 3, i32 13} ; [ DW_TAG_lexical_block ] [/liveness_analysis/non_linear17.c]
!57 = metadata !{i32 25, i32 5, metadata !58, null}
!58 = metadata !{i32 786443, metadata !1, metadata !4, i32 24, i32 28, i32 0, i32 6} ; [ DW_TAG_lexical_block ] [/liveness_analysis/non_linear17.c]
!59 = metadata !{i32 26, i32 5, metadata !58, null}
!60 = metadata !{i32 27, i32 3, metadata !58, null}
!61 = metadata !{i32 29, i32 3, metadata !62, null}
!62 = metadata !{i32 786443, metadata !1, metadata !4, i32 29, i32 3, i32 1, i32 14} ; [ DW_TAG_lexical_block ] [/liveness_analysis/non_linear17.c]
!63 = metadata !{i32 30, i32 5, metadata !64, null}
!64 = metadata !{i32 786443, metadata !1, metadata !4, i32 29, i32 17, i32 0, i32 7} ; [ DW_TAG_lexical_block ] [/liveness_analysis/non_linear17.c]
!65 = metadata !{i32 31, i32 3, metadata !64, null}
!66 = metadata !{i32 32, i32 1, metadata !4, null}

