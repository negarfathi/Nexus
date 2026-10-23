; ModuleID = 'non_linear09.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind uwtable
define i32 @non_linear09(i32 %x1, i32 %x2, i32 %x3, i32 %x4, i32 %x5, i32 %x6) #0 {
non_linear09_bb0:
  call void @llvm.dbg.value(metadata !{i32 %x1}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !{i32 %x2}, i64 0, metadata !14), !dbg !15
  call void @llvm.dbg.value(metadata !{i32 %x3}, i64 0, metadata !16), !dbg !17
  call void @llvm.dbg.value(metadata !{i32 %x4}, i64 0, metadata !18), !dbg !19
  call void @llvm.dbg.value(metadata !{i32 %x5}, i64 0, metadata !20), !dbg !21
  call void @llvm.dbg.value(metadata !{i32 %x6}, i64 0, metadata !22), !dbg !23
  call void @llvm.dbg.value(metadata !24, i64 0, metadata !25), !dbg !26
  call void @llvm.dbg.value(metadata !{i32 %.04}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !{i32 %.04}, i64 0, metadata !14), !dbg !15
  call void @llvm.dbg.value(metadata !27, i64 0, metadata !16), !dbg !17
  call void @llvm.dbg.value(metadata !27, i64 0, metadata !18), !dbg !19
  call void @llvm.dbg.value(metadata !{i32 %.04}, i64 0, metadata !20), !dbg !21
  call void @llvm.dbg.value(metadata !{i32 %"2"}, i64 0, metadata !22), !dbg !23
  call void @llvm.dbg.value(metadata !{i32 %"3"}, i64 0, metadata !28), !dbg !30
  call void @llvm.dbg.value(metadata !{i32 %.1}, i64 0, metadata !31), !dbg !33
  call void @llvm.dbg.value(metadata !{i32 %.01}, i64 0, metadata !34), !dbg !35
  call void @llvm.dbg.value(metadata !{i32 %"14"}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !{i32 %"17"}, i64 0, metadata !14), !dbg !15
  call void @llvm.dbg.value(metadata !{i32 %"18"}, i64 0, metadata !18), !dbg !19
  call void @llvm.dbg.value(metadata !{i32 %"21"}, i64 0, metadata !20), !dbg !21
  br label %non_linear09_bb1, !dbg !36

non_linear09_bb1:                                 ; preds = %non_linear09_bb3, %non_linear09_bb0
  %.04 = phi i32 [ %x6, %non_linear09_bb0 ], [ %"2", %non_linear09_bb3 ]
  %.0 = phi i32 [ %x1, %non_linear09_bb0 ], [ %.1, %non_linear09_bb3 ]
  %"0" = icmp slt i32 0, 1, !dbg !37
  %"1" = icmp sle i32 1, %.04, !dbg !39
  %. = select i1 %"0", i1 %"1", i1 false, !dbg !37
  br i1 %., label %non_linear09_bb2, label %non_linear09_bb5, !dbg !41

non_linear09_bb2:                                 ; preds = %non_linear09_bb1
  %"2" = sub nsw i32 %.04, 1, !dbg !43
  %"3" = call i32 @__VERIFIER_nondet_int(), !dbg !44
  br label %non_linear09_bb3, !dbg !45

non_linear09_bb3:                                 ; preds = %non_linear09_bb4, %non_linear09_bb2
  %.03 = phi i32 [ %.04, %non_linear09_bb2 ], [ %"21", %non_linear09_bb4 ]
  %.02 = phi i32 [ 2, %non_linear09_bb2 ], [ %"18", %non_linear09_bb4 ]
  %.01 = phi i32 [ %.04, %non_linear09_bb2 ], [ %"17", %non_linear09_bb4 ]
  %.1 = phi i32 [ %.04, %non_linear09_bb2 ], [ %"14", %non_linear09_bb4 ]
  %"4" = mul nsw i32 %.02, %.02, !dbg !46
  %"5" = mul nsw i32 2, 2, !dbg !46
  %"6" = mul nsw i32 %"5", 2, !dbg !46
  %"7" = mul nsw i32 %"6", 2, !dbg !46
  %"8" = mul nsw i32 %"7", 2, !dbg !46
  %"9" = sub nsw i32 %"4", %"8", !dbg !46
  %"10" = icmp slt i32 %"9", %.03, !dbg !46
  %"11" = icmp ne i32 %.02, 0, !dbg !48
  %.6 = select i1 %"10", i1 %"11", i1 false, !dbg !46
  br i1 %.6, label %non_linear09_bb4, label %non_linear09_bb1, !dbg !50

non_linear09_bb4:                                 ; preds = %non_linear09_bb3
  %"12" = mul nsw i32 3, %.1, !dbg !52
  %"13" = mul nsw i32 2, %.01, !dbg !52
  %"14" = add nsw i32 %"12", %"13", !dbg !52
  %"15" = mul nsw i32 -5, %.1, !dbg !53
  %"16" = mul nsw i32 3, %.01, !dbg !53
  %"17" = sub nsw i32 %"15", %"16", !dbg !53
  %"18" = mul nsw i32 -2, %.02, !dbg !54
  %"19" = mul nsw i32 3, %.03, !dbg !55
  %"20" = mul nsw i32 2, 2, !dbg !55
  %"21" = add nsw i32 %"19", %"20", !dbg !55
  br label %non_linear09_bb3, !dbg !56

non_linear09_bb5:                                 ; preds = %non_linear09_bb1, %non_linear09_bb6
  %.15 = phi i32 [ %"23", %non_linear09_bb6 ], [ %.0, %non_linear09_bb1 ]
  %"22" = icmp sgt i32 %.15, 0, !dbg !57
  br i1 %"22", label %non_linear09_bb6, label %non_linear09_bb7, !dbg !57

non_linear09_bb6:                                 ; preds = %non_linear09_bb5
  %"23" = sub nsw i32 %.15, 1, !dbg !59
  br label %non_linear09_bb5, !dbg !61

non_linear09_bb7:                                 ; preds = %non_linear09_bb5
  ret i32 0, !dbg !62
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

!0 = metadata !{i32 786449, metadata !1, i32 12, metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)", i1 false, metadata !"", i32 0, metadata !2, metadata !2, metadata !3, metadata !2, metadata !2, metadata !"", i32 1} ; [ DW_TAG_compile_unit ] [/liveness_analysis/non_linear09.c] [DW_LANG_C99]
!1 = metadata !{metadata !"non_linear09.c", metadata !"/liveness_analysis"}
!2 = metadata !{}
!3 = metadata !{metadata !4}
!4 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"non_linear09", metadata !"non_linear09", metadata !"", i32 3, metadata !6, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, i32 (i32, i32, i32, i32, i32, i32)* @non_linear09, null, null, metadata !2, i32 3} ; [ DW_TAG_subprogram ] [line 3] [def] [non_linear09]
!5 = metadata !{i32 786473, metadata !1}          ; [ DW_TAG_file_type ] [/liveness_analysis/non_linear09.c]
!6 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !7, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!7 = metadata !{metadata !8, metadata !8, metadata !8, metadata !8, metadata !8, metadata !8, metadata !8}
!8 = metadata !{i32 786468, null, null, metadata !"int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!9 = metadata !{i32 2, metadata !"Dwarf Version", i32 4}
!10 = metadata !{i32 2, metadata !"Debug Info Version", i32 1}
!11 = metadata !{metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)"}
!12 = metadata !{i32 786689, metadata !4, metadata !"x1", metadata !5, i32 16777219, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [x1] [line 3]
!13 = metadata !{i32 3, i32 22, metadata !4, null}
!14 = metadata !{i32 786689, metadata !4, metadata !"x2", metadata !5, i32 33554435, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [x2] [line 3]
!15 = metadata !{i32 3, i32 30, metadata !4, null}
!16 = metadata !{i32 786689, metadata !4, metadata !"x3", metadata !5, i32 50331651, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [x3] [line 3]
!17 = metadata !{i32 3, i32 38, metadata !4, null}
!18 = metadata !{i32 786689, metadata !4, metadata !"x4", metadata !5, i32 67108867, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [x4] [line 3]
!19 = metadata !{i32 3, i32 46, metadata !4, null}
!20 = metadata !{i32 786689, metadata !4, metadata !"x5", metadata !5, i32 83886083, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [x5] [line 3]
!21 = metadata !{i32 3, i32 54, metadata !4, null}
!22 = metadata !{i32 786689, metadata !4, metadata !"x6", metadata !5, i32 100663299, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [x6] [line 3]
!23 = metadata !{i32 3, i32 62, metadata !4, null}
!24 = metadata !{i32 1}
!25 = metadata !{i32 786688, metadata !4, metadata !"y", metadata !5, i32 4, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [y] [line 4]
!26 = metadata !{i32 4, i32 7, metadata !4, null}
!27 = metadata !{i32 2}
!28 = metadata !{i32 786688, metadata !29, metadata !"y", metadata !5, i32 13, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [y] [line 13]
!29 = metadata !{i32 786443, metadata !1, metadata !4, i32 6, i32 27, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/liveness_analysis/non_linear09.c]
!30 = metadata !{i32 13, i32 9, metadata !29, null}
!31 = metadata !{i32 786688, metadata !32, metadata !"x1_", metadata !5, i32 15, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [x1_] [line 15]
!32 = metadata !{i32 786443, metadata !1, metadata !29, i32 14, i32 51, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/liveness_analysis/non_linear09.c]
!33 = metadata !{i32 15, i32 11, metadata !32, null}
!34 = metadata !{i32 786688, metadata !32, metadata !"x2_", metadata !5, i32 16, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [x2_] [line 16]
!35 = metadata !{i32 16, i32 11, metadata !32, null}
!36 = metadata !{i32 6, i32 3, metadata !4, null}
!37 = metadata !{i32 6, i32 3, metadata !38, null}
!38 = metadata !{i32 786443, metadata !1, metadata !4, i32 6, i32 3, i32 1, i32 3} ; [ DW_TAG_lexical_block ] [/liveness_analysis/non_linear09.c]
!39 = metadata !{i32 6, i32 3, metadata !40, null}
!40 = metadata !{i32 786443, metadata !1, metadata !4, i32 6, i32 3, i32 2, i32 4} ; [ DW_TAG_lexical_block ] [/liveness_analysis/non_linear09.c]
!41 = metadata !{i32 6, i32 3, metadata !42, null}
!42 = metadata !{i32 786443, metadata !1, metadata !4, i32 6, i32 3, i32 3, i32 5} ; [ DW_TAG_lexical_block ] [/liveness_analysis/non_linear09.c]
!43 = metadata !{i32 12, i32 5, metadata !29, null}
!44 = metadata !{i32 13, i32 13, metadata !29, null}
!45 = metadata !{i32 14, i32 5, metadata !29, null}
!46 = metadata !{i32 14, i32 5, metadata !47, null}
!47 = metadata !{i32 786443, metadata !1, metadata !29, i32 14, i32 5, i32 1, i32 6} ; [ DW_TAG_lexical_block ] [/liveness_analysis/non_linear09.c]
!48 = metadata !{i32 14, i32 5, metadata !49, null}
!49 = metadata !{i32 786443, metadata !1, metadata !29, i32 14, i32 5, i32 2, i32 7} ; [ DW_TAG_lexical_block ] [/liveness_analysis/non_linear09.c]
!50 = metadata !{i32 14, i32 5, metadata !51, null}
!51 = metadata !{i32 786443, metadata !1, metadata !29, i32 14, i32 5, i32 3, i32 8} ; [ DW_TAG_lexical_block ] [/liveness_analysis/non_linear09.c]
!52 = metadata !{i32 17, i32 7, metadata !32, null}
!53 = metadata !{i32 18, i32 7, metadata !32, null}
!54 = metadata !{i32 19, i32 7, metadata !32, null}
!55 = metadata !{i32 20, i32 7, metadata !32, null}
!56 = metadata !{i32 21, i32 5, metadata !32, null}
!57 = metadata !{i32 24, i32 3, metadata !58, null}
!58 = metadata !{i32 786443, metadata !1, metadata !4, i32 24, i32 3, i32 1, i32 9} ; [ DW_TAG_lexical_block ] [/liveness_analysis/non_linear09.c]
!59 = metadata !{i32 25, i32 5, metadata !60, null}
!60 = metadata !{i32 786443, metadata !1, metadata !4, i32 24, i32 17, i32 0, i32 2} ; [ DW_TAG_lexical_block ] [/liveness_analysis/non_linear09.c]
!61 = metadata !{i32 26, i32 3, metadata !60, null}
!62 = metadata !{i32 27, i32 3, metadata !4, null}

