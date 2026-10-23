; ModuleID = 'PodelskiRybalchenko-VMCAI2004-Ex1_true-termination.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind uwtable
define i32 @foo(i32 %i, i32 %j, i32 %nondetNat, i32 %nondetPos) #0 {
foo_bb0:
  call void @llvm.dbg.value(metadata !{i32 %i}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !{i32 %j}, i64 0, metadata !14), !dbg !15
  call void @llvm.dbg.value(metadata !{i32 %nondetNat}, i64 0, metadata !16), !dbg !17
  call void @llvm.dbg.value(metadata !{i32 %nondetPos}, i64 0, metadata !18), !dbg !19
  call void @llvm.dbg.value(metadata !{i32 %"2"}, i64 0, metadata !16), !dbg !17
  call void @llvm.dbg.value(metadata !{i32 %"4"}, i64 0, metadata !16), !dbg !17
  call void @llvm.dbg.value(metadata !{i32 %"5"}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !{i32 %"6"}, i64 0, metadata !18), !dbg !19
  call void @llvm.dbg.value(metadata !{i32 %"8"}, i64 0, metadata !18), !dbg !19
  call void @llvm.dbg.value(metadata !{i32 %"9"}, i64 0, metadata !18), !dbg !19
  call void @llvm.dbg.value(metadata !{i32 %"10"}, i64 0, metadata !14), !dbg !15
  br label %foo_bb1, !dbg !20

foo_bb1:                                          ; preds = %foo_bb2, %foo_bb0
  %.01 = phi i32 [ %j, %foo_bb0 ], [ %"10", %foo_bb2 ]
  %.0 = phi i32 [ %i, %foo_bb0 ], [ %"5", %foo_bb2 ]
  %"0" = sub nsw i32 %.0, %.01, !dbg !21
  %"1" = icmp sge i32 %"0", 1, !dbg !21
  br i1 %"1", label %foo_bb2, label %foo_bb3, !dbg !21

foo_bb2:                                          ; preds = %foo_bb1
  %"2" = call i32 @__VERIFIER_nondet_int(), !dbg !23
  %"3" = icmp slt i32 %"2", 0, !dbg !25
  %"4" = sub nsw i32 0, %"2", !dbg !27
  %. = select i1 %"3", i32 %"4", i32 %"2", !dbg !25
  %"5" = sub nsw i32 %.0, %., !dbg !29
  %"6" = call i32 @__VERIFIER_nondet_int(), !dbg !30
  %"7" = icmp slt i32 %"6", 0, !dbg !31
  %"8" = sub nsw i32 0, %"6", !dbg !33
  %.03 = select i1 %"7", i32 %"8", i32 %"6", !dbg !31
  %"9" = add nsw i32 %.03, 1, !dbg !35
  %"10" = add nsw i32 %.01, %"9", !dbg !36
  br label %foo_bb1, !dbg !37

foo_bb3:                                          ; preds = %foo_bb1
  ret i32 0, !dbg !38
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

!0 = metadata !{i32 786449, metadata !1, i32 12, metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)", i1 false, metadata !"", i32 0, metadata !2, metadata !2, metadata !3, metadata !2, metadata !2, metadata !"", i32 1} ; [ DW_TAG_compile_unit ] [/liveness_analysis/PodelskiRybalchenko-VMCAI2004-Ex1_true-termination.c] [DW_LANG_C99]
!1 = metadata !{metadata !"PodelskiRybalchenko-VMCAI2004-Ex1_true-termination.c", metadata !"/liveness_analysis"}
!2 = metadata !{}
!3 = metadata !{metadata !4}
!4 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"foo", metadata !"foo", metadata !"", i32 3, metadata !6, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, i32 (i32, i32, i32, i32)* @foo, null, null, metadata !2, i32 3} ; [ DW_TAG_subprogram ] [line 3] [def] [foo]
!5 = metadata !{i32 786473, metadata !1}          ; [ DW_TAG_file_type ] [/liveness_analysis/PodelskiRybalchenko-VMCAI2004-Ex1_true-termination.c]
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
!16 = metadata !{i32 786689, metadata !4, metadata !"nondetNat", metadata !5, i32 50331651, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [nondetNat] [line 3]
!17 = metadata !{i32 3, i32 25, metadata !4, null}
!18 = metadata !{i32 786689, metadata !4, metadata !"nondetPos", metadata !5, i32 67108867, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [nondetPos] [line 3]
!19 = metadata !{i32 3, i32 39, metadata !4, null}
!20 = metadata !{i32 4, i32 1, metadata !4, null}
!21 = metadata !{i32 4, i32 1, metadata !22, null}
!22 = metadata !{i32 786443, metadata !1, metadata !4, i32 4, i32 1, i32 1, i32 5} ; [ DW_TAG_lexical_block ] [/liveness_analysis/PodelskiRybalchenko-VMCAI2004-Ex1_true-termination.c]
!23 = metadata !{i32 5, i32 21, metadata !24, null}
!24 = metadata !{i32 786443, metadata !1, metadata !4, i32 4, i32 20, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/liveness_analysis/PodelskiRybalchenko-VMCAI2004-Ex1_true-termination.c]
!25 = metadata !{i32 6, i32 13, metadata !26, null}
!26 = metadata !{i32 786443, metadata !1, metadata !24, i32 6, i32 13, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/liveness_analysis/PodelskiRybalchenko-VMCAI2004-Ex1_true-termination.c]
!27 = metadata !{i32 7, i32 13, metadata !28, null}
!28 = metadata !{i32 786443, metadata !1, metadata !26, i32 6, i32 28, i32 0, i32 2} ; [ DW_TAG_lexical_block ] [/liveness_analysis/PodelskiRybalchenko-VMCAI2004-Ex1_true-termination.c]
!29 = metadata !{i32 9, i32 3, metadata !24, null}
!30 = metadata !{i32 10, i32 15, metadata !24, null}
!31 = metadata !{i32 11, i32 13, metadata !32, null}
!32 = metadata !{i32 786443, metadata !1, metadata !24, i32 11, i32 13, i32 0, i32 3} ; [ DW_TAG_lexical_block ] [/liveness_analysis/PodelskiRybalchenko-VMCAI2004-Ex1_true-termination.c]
!33 = metadata !{i32 12, i32 13, metadata !34, null}
!34 = metadata !{i32 786443, metadata !1, metadata !32, i32 11, i32 28, i32 0, i32 4} ; [ DW_TAG_lexical_block ] [/liveness_analysis/PodelskiRybalchenko-VMCAI2004-Ex1_true-termination.c]
!35 = metadata !{i32 14, i32 9, metadata !24, null}
!36 = metadata !{i32 15, i32 3, metadata !24, null}
!37 = metadata !{i32 16, i32 2, metadata !24, null}
!38 = metadata !{i32 17, i32 1, metadata !4, null}

