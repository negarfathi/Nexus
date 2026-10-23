; ModuleID = 'non_linear11.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind uwtable
define i32 @non_linear11(i32 %x1, i32 %x2, i32 %x3) #0 {
non_linear11_bb0:
  call void @llvm.dbg.value(metadata !{i32 %x1}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !{i32 %x2}, i64 0, metadata !14), !dbg !15
  call void @llvm.dbg.value(metadata !{i32 %x3}, i64 0, metadata !16), !dbg !17
  call void @llvm.dbg.value(metadata !{i32 %"3"}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !{i32 %"5"}, i64 0, metadata !16), !dbg !17
  call void @llvm.dbg.value(metadata !{i32 %"3"}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !{i32 %"6"}, i64 0, metadata !16), !dbg !17
  br label %non_linear11_bb1, !dbg !18

non_linear11_bb1:                                 ; preds = %non_linear11_bb2, %non_linear11_bb0
  %.01 = phi i32 [ %x3, %non_linear11_bb0 ], [ %.12, %non_linear11_bb2 ]
  %.0 = phi i32 [ %x1, %non_linear11_bb0 ], [ %"3", %non_linear11_bb2 ]
  %"0" = icmp sgt i32 %.0, 0, !dbg !19
  br i1 %"0", label %non_linear11_bb2, label %non_linear11_bb3, !dbg !19

non_linear11_bb2:                                 ; preds = %non_linear11_bb1
  %"1" = call i32 @__VERIFIER_nondet_int(), !dbg !21
  %"2" = icmp ne i32 %"1", 0, !dbg !21
  %"3" = sub nsw i32 %.0, 1, !dbg !24
  %"4" = mul nsw i32 %x2, %x2, !dbg !26
  %"5" = add nsw i32 %.01, %"4", !dbg !26
  %"6" = add nsw i32 %"5", 1, !dbg !27
  %.12 = select i1 %"2", i32 %"5", i32 %"6", !dbg !21
  br label %non_linear11_bb1, !dbg !21

non_linear11_bb3:                                 ; preds = %non_linear11_bb1, %non_linear11_bb4
  %.2 = phi i32 [ %"8", %non_linear11_bb4 ], [ %.01, %non_linear11_bb1 ]
  %"7" = icmp sgt i32 %.2, 0, !dbg !29
  br i1 %"7", label %non_linear11_bb4, label %non_linear11_bb5, !dbg !29

non_linear11_bb4:                                 ; preds = %non_linear11_bb3
  %"8" = sub nsw i32 %.2, 1, !dbg !31
  br label %non_linear11_bb3, !dbg !33

non_linear11_bb5:                                 ; preds = %non_linear11_bb3
  ret i32 0, !dbg !34
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

!0 = metadata !{i32 786449, metadata !1, i32 12, metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)", i1 false, metadata !"", i32 0, metadata !2, metadata !2, metadata !3, metadata !2, metadata !2, metadata !"", i32 1} ; [ DW_TAG_compile_unit ] [/liveness_analysis/non_linear11.c] [DW_LANG_C99]
!1 = metadata !{metadata !"non_linear11.c", metadata !"/liveness_analysis"}
!2 = metadata !{}
!3 = metadata !{metadata !4}
!4 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"non_linear11", metadata !"non_linear11", metadata !"", i32 3, metadata !6, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, i32 (i32, i32, i32)* @non_linear11, null, null, metadata !2, i32 3} ; [ DW_TAG_subprogram ] [line 3] [def] [non_linear11]
!5 = metadata !{i32 786473, metadata !1}          ; [ DW_TAG_file_type ] [/liveness_analysis/non_linear11.c]
!6 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !7, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!7 = metadata !{metadata !8, metadata !8, metadata !8, metadata !8}
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
!18 = metadata !{i32 4, i32 3, metadata !4, null}
!19 = metadata !{i32 4, i32 3, metadata !20, null}
!20 = metadata !{i32 786443, metadata !1, metadata !4, i32 4, i32 3, i32 1, i32 5} ; [ DW_TAG_lexical_block ] [/liveness_analysis/non_linear11.c]
!21 = metadata !{i32 5, i32 8, metadata !22, null}
!22 = metadata !{i32 786443, metadata !1, metadata !23, i32 5, i32 8, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/liveness_analysis/non_linear11.c]
!23 = metadata !{i32 786443, metadata !1, metadata !4, i32 4, i32 17, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/liveness_analysis/non_linear11.c]
!24 = metadata !{i32 6, i32 9, metadata !25, null}
!25 = metadata !{i32 786443, metadata !1, metadata !22, i32 5, i32 33, i32 0, i32 2} ; [ DW_TAG_lexical_block ] [/liveness_analysis/non_linear11.c]
!26 = metadata !{i32 7, i32 9, metadata !25, null}
!27 = metadata !{i32 10, i32 9, metadata !28, null}
!28 = metadata !{i32 786443, metadata !1, metadata !22, i32 8, i32 12, i32 0, i32 3} ; [ DW_TAG_lexical_block ] [/liveness_analysis/non_linear11.c]
!29 = metadata !{i32 13, i32 3, metadata !30, null}
!30 = metadata !{i32 786443, metadata !1, metadata !4, i32 13, i32 3, i32 1, i32 6} ; [ DW_TAG_lexical_block ] [/liveness_analysis/non_linear11.c]
!31 = metadata !{i32 14, i32 5, metadata !32, null}
!32 = metadata !{i32 786443, metadata !1, metadata !4, i32 13, i32 17, i32 0, i32 4} ; [ DW_TAG_lexical_block ] [/liveness_analysis/non_linear11.c]
!33 = metadata !{i32 15, i32 3, metadata !32, null}
!34 = metadata !{i32 16, i32 3, metadata !4, null}

