; ModuleID = 'size15.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind uwtable
define void @size15(i32 %x, i32 %y, i32 %f, i32 %a, i32 %b, i32 %c) #0 {
size15_bb0:
  call void @llvm.dbg.value(metadata !{i32 %x}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !{i32 %y}, i64 0, metadata !14), !dbg !15
  call void @llvm.dbg.value(metadata !{i32 %f}, i64 0, metadata !16), !dbg !17
  call void @llvm.dbg.value(metadata !{i32 %a}, i64 0, metadata !18), !dbg !19
  call void @llvm.dbg.value(metadata !{i32 %b}, i64 0, metadata !20), !dbg !21
  call void @llvm.dbg.value(metadata !{i32 %c}, i64 0, metadata !22), !dbg !23
  %"0" = call i32 @__VERIFIER_nondet_int(), !dbg !24
  call void @llvm.dbg.value(metadata !{i32 %"0"}, i64 0, metadata !25), !dbg !26
  %"1" = call i32 @__VERIFIER_nondet_int(), !dbg !27
  call void @llvm.dbg.value(metadata !{i32 %"1"}, i64 0, metadata !28), !dbg !29
  call void @llvm.dbg.value(metadata !{i32 %"0"}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !{i32 %"1"}, i64 0, metadata !16), !dbg !17
  call void @llvm.dbg.value(metadata !{i32 %"5"}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !{i32 %"6"}, i64 0, metadata !28), !dbg !29
  call void @llvm.dbg.value(metadata !{i32 %"6"}, i64 0, metadata !16), !dbg !17
  call void @llvm.dbg.value(metadata !{i32 %"9"}, i64 0, metadata !14), !dbg !15
  call void @llvm.dbg.value(metadata !{i32 %"10"}, i64 0, metadata !28), !dbg !29
  call void @llvm.dbg.value(metadata !{i32 %"10"}, i64 0, metadata !16), !dbg !17
  br label %size15_bb1, !dbg !30

size15_bb1:                                       ; preds = %size15_bb2, %size15_bb4, %size15_bb0
  %.03 = phi i32 [ %"1", %size15_bb0 ], [ %"6", %size15_bb2 ], [ %"10", %size15_bb4 ]
  %.01 = phi i32 [ %y, %size15_bb0 ], [ %.01, %size15_bb2 ], [ %"9", %size15_bb4 ]
  %.0 = phi i32 [ %"0", %size15_bb0 ], [ %"5", %size15_bb2 ], [ %.0, %size15_bb4 ]
  %"2" = icmp sle i32 1, %.0, !dbg !31
  %"3" = icmp sle i32 %.0, 3, !dbg !34
  %or.cond = and i1 %"2", %"3", !dbg !31
  %"4" = icmp eq i32 %.03, 0, !dbg !36
  %or.cond9 = and i1 %or.cond, %"4", !dbg !31
  br i1 %or.cond9, label %size15_bb2, label %size15_bb3, !dbg !31

size15_bb2:                                       ; preds = %size15_bb1
  %"5" = add nsw i32 %.0, 1, !dbg !38
  %"6" = call i32 @__VERIFIER_nondet_int(), !dbg !40
  br label %size15_bb1, !dbg !41

size15_bb3:                                       ; preds = %size15_bb1
  %"7" = icmp sgt i32 %.01, 1, !dbg !42
  %"8" = icmp eq i32 %.03, 1, !dbg !44
  %or.cond10 = and i1 %"7", %"8", !dbg !42
  br i1 %or.cond10, label %size15_bb4, label %size15_bb5, !dbg !42

size15_bb4:                                       ; preds = %size15_bb3
  %"9" = sub nsw i32 %.01, 1, !dbg !46
  %"10" = call i32 @__VERIFIER_nondet_int(), !dbg !48
  br label %size15_bb1

size15_bb5:                                       ; preds = %size15_bb3, %size15_bb6
  %.08 = phi i32 [ %"18", %size15_bb6 ], [ %c, %size15_bb3 ]
  %.06 = phi i32 [ %"17", %size15_bb6 ], [ %b, %size15_bb3 ]
  %.05 = phi i32 [ %"15", %size15_bb6 ], [ %a, %size15_bb3 ]
  %"11" = icmp slt i32 %.05, %.06, !dbg !49
  %"12" = icmp ne i32 %.08, 0, !dbg !52
  %. = select i1 %"11", i1 %"12", i1 false, !dbg !49
  br i1 %., label %size15_bb6, label %size15_bb7, !dbg !54

size15_bb6:                                       ; preds = %size15_bb5
  %"13" = mul nsw i32 %.08, %.08, !dbg !56
  %"14" = mul nsw i32 %"13", %.08, !dbg !56
  %"15" = add nsw i32 %.05, %"14", !dbg !56
  %"16" = mul nsw i32 %.08, %.08, !dbg !58
  %"17" = add nsw i32 %.06, %"16", !dbg !58
  %"18" = add nsw i32 %.08, 1, !dbg !59
  br label %size15_bb5, !dbg !60

size15_bb7:                                       ; preds = %size15_bb5, %size15_bb8
  %.17 = phi i32 [ %"20", %size15_bb8 ], [ %.06, %size15_bb5 ]
  %"19" = icmp sgt i32 %.17, 0, !dbg !61
  br i1 %"19", label %size15_bb8, label %size15_bb9, !dbg !61

size15_bb8:                                       ; preds = %size15_bb7
  %"20" = sub nsw i32 %.17, 1, !dbg !63
  br label %size15_bb7, !dbg !65

size15_bb9:                                       ; preds = %size15_bb7
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

!0 = metadata !{i32 786449, metadata !1, i32 12, metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)", i1 false, metadata !"", i32 0, metadata !2, metadata !2, metadata !3, metadata !2, metadata !2, metadata !"", i32 1} ; [ DW_TAG_compile_unit ] [/liveness_analysis/size15.c] [DW_LANG_C99]
!1 = metadata !{metadata !"size15.c", metadata !"/liveness_analysis"}
!2 = metadata !{}
!3 = metadata !{metadata !4}
!4 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"size15", metadata !"size15", metadata !"", i32 3, metadata !6, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (i32, i32, i32, i32, i32, i32)* @size15, null, null, metadata !2, i32 3} ; [ DW_TAG_subprogram ] [line 3] [def] [size15]
!5 = metadata !{i32 786473, metadata !1}          ; [ DW_TAG_file_type ] [/liveness_analysis/size15.c]
!6 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !7, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!7 = metadata !{null, metadata !8, metadata !8, metadata !8, metadata !8, metadata !8, metadata !8}
!8 = metadata !{i32 786468, null, null, metadata !"int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!9 = metadata !{i32 2, metadata !"Dwarf Version", i32 4}
!10 = metadata !{i32 2, metadata !"Debug Info Version", i32 1}
!11 = metadata !{metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)"}
!12 = metadata !{i32 786689, metadata !4, metadata !"x", metadata !5, i32 16777219, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [x] [line 3]
!13 = metadata !{i32 3, i32 17, metadata !4, null}
!14 = metadata !{i32 786689, metadata !4, metadata !"y", metadata !5, i32 33554435, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [y] [line 3]
!15 = metadata !{i32 3, i32 24, metadata !4, null}
!16 = metadata !{i32 786689, metadata !4, metadata !"f", metadata !5, i32 50331651, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [f] [line 3]
!17 = metadata !{i32 3, i32 31, metadata !4, null}
!18 = metadata !{i32 786689, metadata !4, metadata !"a", metadata !5, i32 67108867, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [a] [line 3]
!19 = metadata !{i32 3, i32 38, metadata !4, null}
!20 = metadata !{i32 786689, metadata !4, metadata !"b", metadata !5, i32 83886083, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [b] [line 3]
!21 = metadata !{i32 3, i32 45, metadata !4, null}
!22 = metadata !{i32 786689, metadata !4, metadata !"c", metadata !5, i32 100663299, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [c] [line 3]
!23 = metadata !{i32 3, i32 52, metadata !4, null}
!24 = metadata !{i32 4, i32 11, metadata !4, null}
!25 = metadata !{i32 786688, metadata !4, metadata !"u", metadata !5, i32 4, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [u] [line 4]
!26 = metadata !{i32 4, i32 7, metadata !4, null}
!27 = metadata !{i32 5, i32 11, metadata !4, null}
!28 = metadata !{i32 786688, metadata !4, metadata !"v", metadata !5, i32 5, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [v] [line 5]
!29 = metadata !{i32 5, i32 7, metadata !4, null}
!30 = metadata !{i32 9, i32 3, metadata !4, null}
!31 = metadata !{i32 10, i32 9, metadata !32, null}
!32 = metadata !{i32 786443, metadata !1, metadata !33, i32 10, i32 9, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/liveness_analysis/size15.c]
!33 = metadata !{i32 786443, metadata !1, metadata !4, i32 9, i32 13, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/liveness_analysis/size15.c]
!34 = metadata !{i32 10, i32 9, metadata !35, null}
!35 = metadata !{i32 786443, metadata !1, metadata !32, i32 10, i32 9, i32 1, i32 8} ; [ DW_TAG_lexical_block ] [/liveness_analysis/size15.c]
!36 = metadata !{i32 10, i32 9, metadata !37, null}
!37 = metadata !{i32 786443, metadata !1, metadata !32, i32 10, i32 9, i32 2, i32 9} ; [ DW_TAG_lexical_block ] [/liveness_analysis/size15.c]
!38 = metadata !{i32 11, i32 7, metadata !39, null}
!39 = metadata !{i32 786443, metadata !1, metadata !32, i32 10, i32 37, i32 0, i32 2} ; [ DW_TAG_lexical_block ] [/liveness_analysis/size15.c]
!40 = metadata !{i32 12, i32 11, metadata !39, null}
!41 = metadata !{i32 14, i32 5, metadata !39, null}
!42 = metadata !{i32 14, i32 16, metadata !43, null}
!43 = metadata !{i32 786443, metadata !1, metadata !32, i32 14, i32 16, i32 0, i32 3} ; [ DW_TAG_lexical_block ] [/liveness_analysis/size15.c]
!44 = metadata !{i32 14, i32 16, metadata !45, null}
!45 = metadata !{i32 786443, metadata !1, metadata !43, i32 14, i32 16, i32 1, i32 10} ; [ DW_TAG_lexical_block ] [/liveness_analysis/size15.c]
!46 = metadata !{i32 15, i32 7, metadata !47, null}
!47 = metadata !{i32 786443, metadata !1, metadata !43, i32 14, i32 33, i32 0, i32 4} ; [ DW_TAG_lexical_block ] [/liveness_analysis/size15.c]
!48 = metadata !{i32 16, i32 11, metadata !47, null}
!49 = metadata !{i32 19, i32 7, metadata !50, null}
!50 = metadata !{i32 786443, metadata !1, metadata !51, i32 19, i32 7, i32 1, i32 11} ; [ DW_TAG_lexical_block ] [/liveness_analysis/size15.c]
!51 = metadata !{i32 786443, metadata !1, metadata !43, i32 18, i32 12, i32 0, i32 5} ; [ DW_TAG_lexical_block ] [/liveness_analysis/size15.c]
!52 = metadata !{i32 19, i32 7, metadata !53, null}
!53 = metadata !{i32 786443, metadata !1, metadata !51, i32 19, i32 7, i32 2, i32 12} ; [ DW_TAG_lexical_block ] [/liveness_analysis/size15.c]
!54 = metadata !{i32 19, i32 7, metadata !55, null}
!55 = metadata !{i32 786443, metadata !1, metadata !51, i32 19, i32 7, i32 3, i32 13} ; [ DW_TAG_lexical_block ] [/liveness_analysis/size15.c]
!56 = metadata !{i32 20, i32 9, metadata !57, null}
!57 = metadata !{i32 786443, metadata !1, metadata !51, i32 19, i32 30, i32 0, i32 6} ; [ DW_TAG_lexical_block ] [/liveness_analysis/size15.c]
!58 = metadata !{i32 21, i32 9, metadata !57, null}
!59 = metadata !{i32 22, i32 9, metadata !57, null}
!60 = metadata !{i32 23, i32 7, metadata !57, null}
!61 = metadata !{i32 27, i32 3, metadata !62, null}
!62 = metadata !{i32 786443, metadata !1, metadata !4, i32 27, i32 3, i32 1, i32 14} ; [ DW_TAG_lexical_block ] [/liveness_analysis/size15.c]
!63 = metadata !{i32 28, i32 5, metadata !64, null}
!64 = metadata !{i32 786443, metadata !1, metadata !4, i32 27, i32 16, i32 0, i32 7} ; [ DW_TAG_lexical_block ] [/liveness_analysis/size15.c]
!65 = metadata !{i32 29, i32 3, metadata !64, null}
!66 = metadata !{i32 30, i32 1, metadata !4, null}

