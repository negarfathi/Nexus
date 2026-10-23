; ModuleID = 'Toulouse-MultiBranchesToLoop_true-termination.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind uwtable
define i32 @foo(i32 %x, i32 %y, i32 %z) #0 {
foo_bb0:
  call void @llvm.dbg.value(metadata !{i32 %x}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !{i32 %y}, i64 0, metadata !14), !dbg !15
  call void @llvm.dbg.value(metadata !{i32 %z}, i64 0, metadata !16), !dbg !17
  %"0" = call i32 @__VERIFIER_nondet_int(), !dbg !18
  %"1" = icmp ne i32 %"0", 0, !dbg !18
  %. = select i1 %"1", i32 1, i32 -1, !dbg !20
  %"2" = icmp sgt i32 %., 0, !dbg !22
  %"3" = add nsw i32 %., 1, !dbg !24
  call void @llvm.dbg.value(metadata !{i32 %"3"}, i64 0, metadata !12), !dbg !13
  %"4" = sub nsw i32 %., 1, !dbg !26
  call void @llvm.dbg.value(metadata !{i32 %"4"}, i64 0, metadata !12), !dbg !13
  %.1 = select i1 %"2", i32 %"3", i32 %"4", !dbg !22
  %"5" = icmp sgt i32 %.1, 0, !dbg !28
  %"6" = add nsw i32 %.1, 1, !dbg !30
  call void @llvm.dbg.value(metadata !{i32 %"6"}, i64 0, metadata !12), !dbg !13
  %"7" = sub nsw i32 %.1, 1, !dbg !32
  call void @llvm.dbg.value(metadata !{i32 %"7"}, i64 0, metadata !12), !dbg !13
  %.2 = select i1 %"5", i32 %"6", i32 %"7", !dbg !28
  %"8" = icmp sgt i32 %.2, 0, !dbg !34
  %"9" = add nsw i32 %.2, 1, !dbg !36
  call void @llvm.dbg.value(metadata !{i32 %"9"}, i64 0, metadata !12), !dbg !13
  %"10" = sub nsw i32 %.2, 1, !dbg !38
  call void @llvm.dbg.value(metadata !{i32 %"10"}, i64 0, metadata !12), !dbg !13
  %.3 = select i1 %"8", i32 %"9", i32 %"10", !dbg !34
  %"11" = icmp sgt i32 %.3, 0, !dbg !40
  %"12" = add nsw i32 %.3, 1, !dbg !42
  call void @llvm.dbg.value(metadata !{i32 %"12"}, i64 0, metadata !12), !dbg !13
  %"13" = sub nsw i32 %.3, 1, !dbg !44
  call void @llvm.dbg.value(metadata !{i32 %"13"}, i64 0, metadata !12), !dbg !13
  %.4 = select i1 %"11", i32 %"12", i32 %"13", !dbg !40
  %"14" = icmp sgt i32 %.4, 0, !dbg !46
  %"15" = add nsw i32 %.4, 1, !dbg !48
  call void @llvm.dbg.value(metadata !{i32 %"15"}, i64 0, metadata !12), !dbg !13
  %"16" = sub nsw i32 %.4, 1, !dbg !50
  call void @llvm.dbg.value(metadata !{i32 %"16"}, i64 0, metadata !12), !dbg !13
  %.5 = select i1 %"14", i32 %"15", i32 %"16", !dbg !46
  %"17" = icmp sgt i32 %.5, 0, !dbg !52
  %"18" = add nsw i32 %.5, 1, !dbg !54
  call void @llvm.dbg.value(metadata !{i32 %"18"}, i64 0, metadata !12), !dbg !13
  %"19" = sub nsw i32 %.5, 1, !dbg !56
  call void @llvm.dbg.value(metadata !{i32 %"19"}, i64 0, metadata !12), !dbg !13
  %.6 = select i1 %"17", i32 %"18", i32 %"19", !dbg !52
  %"20" = icmp sgt i32 %.6, 0, !dbg !58
  %"21" = add nsw i32 %.6, 1, !dbg !60
  call void @llvm.dbg.value(metadata !{i32 %"21"}, i64 0, metadata !12), !dbg !13
  %"22" = sub nsw i32 %.6, 1, !dbg !62
  call void @llvm.dbg.value(metadata !{i32 %"22"}, i64 0, metadata !12), !dbg !13
  %.7 = select i1 %"20", i32 %"21", i32 %"22", !dbg !58
  %"23" = icmp sgt i32 %.7, 0, !dbg !64
  %"24" = add nsw i32 %.7, 1, !dbg !66
  call void @llvm.dbg.value(metadata !{i32 %"24"}, i64 0, metadata !12), !dbg !13
  %"25" = sub nsw i32 %.7, 1, !dbg !68
  call void @llvm.dbg.value(metadata !{i32 %"25"}, i64 0, metadata !12), !dbg !13
  %.8 = select i1 %"23", i32 %"24", i32 %"25", !dbg !64
  br label %foo_bb1, !dbg !64

foo_bb1:                                          ; preds = %foo_bb0, %foo_bb2
  %.02 = phi i32 [ %"29", %foo_bb2 ], [ %z, %foo_bb0 ]
  %.01 = phi i32 [ %"28", %foo_bb2 ], [ %y, %foo_bb0 ]
  %"26" = icmp slt i32 %.01, 100, !dbg !70
  %"27" = icmp slt i32 %.02, 100, !dbg !72
  %.9 = select i1 %"26", i1 %"27", i1 false, !dbg !70
  br i1 %.9, label %foo_bb2, label %foo_bb3, !dbg !74

foo_bb2:                                          ; preds = %foo_bb1
  %"28" = add nsw i32 %.01, %.8, !dbg !76
  %"29" = sub nsw i32 %.02, %.8, !dbg !78
  br label %foo_bb1, !dbg !79

foo_bb3:                                          ; preds = %foo_bb1
  ret i32 0, !dbg !80
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

!0 = metadata !{i32 786449, metadata !1, i32 12, metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)", i1 false, metadata !"", i32 0, metadata !2, metadata !2, metadata !3, metadata !2, metadata !2, metadata !"", i32 1} ; [ DW_TAG_compile_unit ] [/liveness_analysis/Toulouse-MultiBranchesToLoop_true-termination.c] [DW_LANG_C99]
!1 = metadata !{metadata !"Toulouse-MultiBranchesToLoop_true-termination.c", metadata !"/liveness_analysis"}
!2 = metadata !{}
!3 = metadata !{metadata !4}
!4 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"foo", metadata !"foo", metadata !"", i32 3, metadata !6, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, i32 (i32, i32, i32)* @foo, null, null, metadata !2, i32 3} ; [ DW_TAG_subprogram ] [line 3] [def] [foo]
!5 = metadata !{i32 786473, metadata !1}          ; [ DW_TAG_file_type ] [/liveness_analysis/Toulouse-MultiBranchesToLoop_true-termination.c]
!6 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !7, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!7 = metadata !{metadata !8, metadata !8, metadata !8, metadata !8}
!8 = metadata !{i32 786468, null, null, metadata !"int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!9 = metadata !{i32 2, metadata !"Dwarf Version", i32 4}
!10 = metadata !{i32 2, metadata !"Debug Info Version", i32 1}
!11 = metadata !{metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)"}
!12 = metadata !{i32 786689, metadata !4, metadata !"x", metadata !5, i32 16777219, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [x] [line 3]
!13 = metadata !{i32 3, i32 13, metadata !4, null}
!14 = metadata !{i32 786689, metadata !4, metadata !"y", metadata !5, i32 33554435, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [y] [line 3]
!15 = metadata !{i32 3, i32 19, metadata !4, null}
!16 = metadata !{i32 786689, metadata !4, metadata !"z", metadata !5, i32 50331651, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [z] [line 3]
!17 = metadata !{i32 3, i32 25, metadata !4, null}
!18 = metadata !{i32 4, i32 5, metadata !19, null}
!19 = metadata !{i32 786443, metadata !1, metadata !4, i32 4, i32 5, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/liveness_analysis/Toulouse-MultiBranchesToLoop_true-termination.c]
!20 = metadata !{i32 6, i32 5, metadata !21, null}
!21 = metadata !{i32 786443, metadata !1, metadata !19, i32 4, i32 35, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/liveness_analysis/Toulouse-MultiBranchesToLoop_true-termination.c]
!22 = metadata !{i32 9, i32 5, metadata !23, null}
!23 = metadata !{i32 786443, metadata !1, metadata !4, i32 9, i32 5, i32 0, i32 3} ; [ DW_TAG_lexical_block ] [/liveness_analysis/Toulouse-MultiBranchesToLoop_true-termination.c]
!24 = metadata !{i32 10, i32 9, metadata !25, null}
!25 = metadata !{i32 786443, metadata !1, metadata !23, i32 9, i32 12, i32 0, i32 4} ; [ DW_TAG_lexical_block ] [/liveness_analysis/Toulouse-MultiBranchesToLoop_true-termination.c]
!26 = metadata !{i32 12, i32 9, metadata !27, null}
!27 = metadata !{i32 786443, metadata !1, metadata !23, i32 11, i32 12, i32 0, i32 5} ; [ DW_TAG_lexical_block ] [/liveness_analysis/Toulouse-MultiBranchesToLoop_true-termination.c]
!28 = metadata !{i32 14, i32 5, metadata !29, null}
!29 = metadata !{i32 786443, metadata !1, metadata !4, i32 14, i32 5, i32 0, i32 6} ; [ DW_TAG_lexical_block ] [/liveness_analysis/Toulouse-MultiBranchesToLoop_true-termination.c]
!30 = metadata !{i32 15, i32 9, metadata !31, null}
!31 = metadata !{i32 786443, metadata !1, metadata !29, i32 14, i32 12, i32 0, i32 7} ; [ DW_TAG_lexical_block ] [/liveness_analysis/Toulouse-MultiBranchesToLoop_true-termination.c]
!32 = metadata !{i32 17, i32 9, metadata !33, null}
!33 = metadata !{i32 786443, metadata !1, metadata !29, i32 16, i32 12, i32 0, i32 8} ; [ DW_TAG_lexical_block ] [/liveness_analysis/Toulouse-MultiBranchesToLoop_true-termination.c]
!34 = metadata !{i32 19, i32 5, metadata !35, null}
!35 = metadata !{i32 786443, metadata !1, metadata !4, i32 19, i32 5, i32 0, i32 9} ; [ DW_TAG_lexical_block ] [/liveness_analysis/Toulouse-MultiBranchesToLoop_true-termination.c]
!36 = metadata !{i32 20, i32 9, metadata !37, null}
!37 = metadata !{i32 786443, metadata !1, metadata !35, i32 19, i32 12, i32 0, i32 10} ; [ DW_TAG_lexical_block ] [/liveness_analysis/Toulouse-MultiBranchesToLoop_true-termination.c]
!38 = metadata !{i32 22, i32 9, metadata !39, null}
!39 = metadata !{i32 786443, metadata !1, metadata !35, i32 21, i32 12, i32 0, i32 11} ; [ DW_TAG_lexical_block ] [/liveness_analysis/Toulouse-MultiBranchesToLoop_true-termination.c]
!40 = metadata !{i32 24, i32 5, metadata !41, null}
!41 = metadata !{i32 786443, metadata !1, metadata !4, i32 24, i32 5, i32 0, i32 12} ; [ DW_TAG_lexical_block ] [/liveness_analysis/Toulouse-MultiBranchesToLoop_true-termination.c]
!42 = metadata !{i32 25, i32 9, metadata !43, null}
!43 = metadata !{i32 786443, metadata !1, metadata !41, i32 24, i32 12, i32 0, i32 13} ; [ DW_TAG_lexical_block ] [/liveness_analysis/Toulouse-MultiBranchesToLoop_true-termination.c]
!44 = metadata !{i32 27, i32 9, metadata !45, null}
!45 = metadata !{i32 786443, metadata !1, metadata !41, i32 26, i32 12, i32 0, i32 14} ; [ DW_TAG_lexical_block ] [/liveness_analysis/Toulouse-MultiBranchesToLoop_true-termination.c]
!46 = metadata !{i32 29, i32 5, metadata !47, null}
!47 = metadata !{i32 786443, metadata !1, metadata !4, i32 29, i32 5, i32 0, i32 15} ; [ DW_TAG_lexical_block ] [/liveness_analysis/Toulouse-MultiBranchesToLoop_true-termination.c]
!48 = metadata !{i32 30, i32 9, metadata !49, null}
!49 = metadata !{i32 786443, metadata !1, metadata !47, i32 29, i32 12, i32 0, i32 16} ; [ DW_TAG_lexical_block ] [/liveness_analysis/Toulouse-MultiBranchesToLoop_true-termination.c]
!50 = metadata !{i32 32, i32 9, metadata !51, null}
!51 = metadata !{i32 786443, metadata !1, metadata !47, i32 31, i32 12, i32 0, i32 17} ; [ DW_TAG_lexical_block ] [/liveness_analysis/Toulouse-MultiBranchesToLoop_true-termination.c]
!52 = metadata !{i32 34, i32 5, metadata !53, null}
!53 = metadata !{i32 786443, metadata !1, metadata !4, i32 34, i32 5, i32 0, i32 18} ; [ DW_TAG_lexical_block ] [/liveness_analysis/Toulouse-MultiBranchesToLoop_true-termination.c]
!54 = metadata !{i32 35, i32 9, metadata !55, null}
!55 = metadata !{i32 786443, metadata !1, metadata !53, i32 34, i32 12, i32 0, i32 19} ; [ DW_TAG_lexical_block ] [/liveness_analysis/Toulouse-MultiBranchesToLoop_true-termination.c]
!56 = metadata !{i32 37, i32 9, metadata !57, null}
!57 = metadata !{i32 786443, metadata !1, metadata !53, i32 36, i32 12, i32 0, i32 20} ; [ DW_TAG_lexical_block ] [/liveness_analysis/Toulouse-MultiBranchesToLoop_true-termination.c]
!58 = metadata !{i32 39, i32 5, metadata !59, null}
!59 = metadata !{i32 786443, metadata !1, metadata !4, i32 39, i32 5, i32 0, i32 21} ; [ DW_TAG_lexical_block ] [/liveness_analysis/Toulouse-MultiBranchesToLoop_true-termination.c]
!60 = metadata !{i32 40, i32 9, metadata !61, null}
!61 = metadata !{i32 786443, metadata !1, metadata !59, i32 39, i32 12, i32 0, i32 22} ; [ DW_TAG_lexical_block ] [/liveness_analysis/Toulouse-MultiBranchesToLoop_true-termination.c]
!62 = metadata !{i32 42, i32 9, metadata !63, null}
!63 = metadata !{i32 786443, metadata !1, metadata !59, i32 41, i32 12, i32 0, i32 23} ; [ DW_TAG_lexical_block ] [/liveness_analysis/Toulouse-MultiBranchesToLoop_true-termination.c]
!64 = metadata !{i32 44, i32 5, metadata !65, null}
!65 = metadata !{i32 786443, metadata !1, metadata !4, i32 44, i32 5, i32 0, i32 24} ; [ DW_TAG_lexical_block ] [/liveness_analysis/Toulouse-MultiBranchesToLoop_true-termination.c]
!66 = metadata !{i32 45, i32 9, metadata !67, null}
!67 = metadata !{i32 786443, metadata !1, metadata !65, i32 44, i32 12, i32 0, i32 25} ; [ DW_TAG_lexical_block ] [/liveness_analysis/Toulouse-MultiBranchesToLoop_true-termination.c]
!68 = metadata !{i32 47, i32 9, metadata !69, null}
!69 = metadata !{i32 786443, metadata !1, metadata !65, i32 46, i32 12, i32 0, i32 26} ; [ DW_TAG_lexical_block ] [/liveness_analysis/Toulouse-MultiBranchesToLoop_true-termination.c]
!70 = metadata !{i32 49, i32 1, metadata !71, null}
!71 = metadata !{i32 786443, metadata !1, metadata !4, i32 49, i32 1, i32 1, i32 28} ; [ DW_TAG_lexical_block ] [/liveness_analysis/Toulouse-MultiBranchesToLoop_true-termination.c]
!72 = metadata !{i32 49, i32 1, metadata !73, null}
!73 = metadata !{i32 786443, metadata !1, metadata !4, i32 49, i32 1, i32 2, i32 29} ; [ DW_TAG_lexical_block ] [/liveness_analysis/Toulouse-MultiBranchesToLoop_true-termination.c]
!74 = metadata !{i32 49, i32 1, metadata !75, null}
!75 = metadata !{i32 786443, metadata !1, metadata !4, i32 49, i32 1, i32 3, i32 30} ; [ DW_TAG_lexical_block ] [/liveness_analysis/Toulouse-MultiBranchesToLoop_true-termination.c]
!76 = metadata !{i32 50, i32 9, metadata !77, null}
!77 = metadata !{i32 786443, metadata !1, metadata !4, i32 49, i32 24, i32 0, i32 27} ; [ DW_TAG_lexical_block ] [/liveness_analysis/Toulouse-MultiBranchesToLoop_true-termination.c]
!78 = metadata !{i32 51, i32 9, metadata !77, null}
!79 = metadata !{i32 52, i32 5, metadata !77, null}
!80 = metadata !{i32 53, i32 1, metadata !4, null}

