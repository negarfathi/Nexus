; ModuleID = 'non_linear12.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind uwtable
define i32 @non_linear12(i32 %x1, i32 %x2, i32 %x3, i32 %x4) #0 {
non_linear12_bb0:
  call void @llvm.dbg.value(metadata !{i32 %x1}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !{i32 %x2}, i64 0, metadata !14), !dbg !15
  call void @llvm.dbg.value(metadata !{i32 %x3}, i64 0, metadata !16), !dbg !17
  call void @llvm.dbg.value(metadata !{i32 %x4}, i64 0, metadata !18), !dbg !19
  call void @llvm.dbg.value(metadata !{i32 %.0}, i64 0, metadata !20), !dbg !24
  call void @llvm.dbg.value(metadata !{i32 %.01}, i64 0, metadata !25), !dbg !26
  call void @llvm.dbg.value(metadata !{i32 %"6"}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !{i32 %"9"}, i64 0, metadata !14), !dbg !15
  call void @llvm.dbg.value(metadata !{i32 %"10"}, i64 0, metadata !18), !dbg !19
  call void @llvm.dbg.value(metadata !{i32 %.0}, i64 0, metadata !27), !dbg !29
  call void @llvm.dbg.value(metadata !{i32 %.01}, i64 0, metadata !30), !dbg !31
  call void @llvm.dbg.value(metadata !{i32 %"6"}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !{i32 %"9"}, i64 0, metadata !14), !dbg !15
  call void @llvm.dbg.value(metadata !{i32 %"10"}, i64 0, metadata !18), !dbg !19
  br label %non_linear12_bb1, !dbg !32

non_linear12_bb1:                                 ; preds = %non_linear12_bb2, %non_linear12_bb0
  %.03 = phi i32 [ %x4, %non_linear12_bb0 ], [ %"10", %non_linear12_bb2 ]
  %.01 = phi i32 [ %x2, %non_linear12_bb0 ], [ %"9", %non_linear12_bb2 ]
  %.0 = phi i32 [ %x1, %non_linear12_bb0 ], [ %"6", %non_linear12_bb2 ]
  %"0" = icmp sgt i32 %.03, 0, !dbg !33
  br i1 %"0", label %non_linear12_bb2, label %non_linear12_bb3, !dbg !33

non_linear12_bb2:                                 ; preds = %non_linear12_bb1
  %"1" = call i32 @__VERIFIER_nondet_int(), !dbg !35
  %"2" = mul nsw i32 3, %.0, !dbg !36
  %"3" = mul nsw i32 2, %.01, !dbg !36
  %"4" = add nsw i32 %"2", %"3", !dbg !36
  %"5" = mul nsw i32 %x3, %x3, !dbg !36
  %"6" = add nsw i32 %"4", %"5", !dbg !36
  %"7" = mul nsw i32 -5, %.0, !dbg !37
  %"8" = mul nsw i32 3, %.01, !dbg !37
  %"9" = sub nsw i32 %"7", %"8", !dbg !37
  %"10" = sub nsw i32 %.03, 1, !dbg !38
  br label %non_linear12_bb1, !dbg !39

non_linear12_bb3:                                 ; preds = %non_linear12_bb1, %non_linear12_bb4
  %.2 = phi i32 [ %"12", %non_linear12_bb4 ], [ %.0, %non_linear12_bb1 ]
  %"11" = icmp sgt i32 %.2, 0, !dbg !40
  br i1 %"11", label %non_linear12_bb4, label %non_linear12_bb5, !dbg !40

non_linear12_bb4:                                 ; preds = %non_linear12_bb3
  %"12" = sub nsw i32 %.2, 1, !dbg !42
  br label %non_linear12_bb3, !dbg !44

non_linear12_bb5:                                 ; preds = %non_linear12_bb3
  ret i32 0, !dbg !45
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

!0 = metadata !{i32 786449, metadata !1, i32 12, metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)", i1 false, metadata !"", i32 0, metadata !2, metadata !2, metadata !3, metadata !2, metadata !2, metadata !"", i32 1} ; [ DW_TAG_compile_unit ] [/liveness_analysis/non_linear12.c] [DW_LANG_C99]
!1 = metadata !{metadata !"non_linear12.c", metadata !"/liveness_analysis"}
!2 = metadata !{}
!3 = metadata !{metadata !4}
!4 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"non_linear12", metadata !"non_linear12", metadata !"", i32 3, metadata !6, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, i32 (i32, i32, i32, i32)* @non_linear12, null, null, metadata !2, i32 3} ; [ DW_TAG_subprogram ] [line 3] [def] [non_linear12]
!5 = metadata !{i32 786473, metadata !1}          ; [ DW_TAG_file_type ] [/liveness_analysis/non_linear12.c]
!6 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !7, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!7 = metadata !{metadata !8, metadata !8, metadata !8, metadata !8, metadata !8}
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
!20 = metadata !{i32 786688, metadata !21, metadata !"x1_", metadata !5, i32 6, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [x1_] [line 6]
!21 = metadata !{i32 786443, metadata !1, metadata !22, i32 5, i32 33, i32 0, i32 2} ; [ DW_TAG_lexical_block ] [/liveness_analysis/non_linear12.c]
!22 = metadata !{i32 786443, metadata !1, metadata !23, i32 5, i32 8, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/liveness_analysis/non_linear12.c]
!23 = metadata !{i32 786443, metadata !1, metadata !4, i32 4, i32 17, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/liveness_analysis/non_linear12.c]
!24 = metadata !{i32 6, i32 13, metadata !21, null}
!25 = metadata !{i32 786688, metadata !21, metadata !"x2_", metadata !5, i32 7, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [x2_] [line 7]
!26 = metadata !{i32 7, i32 13, metadata !21, null}
!27 = metadata !{i32 786688, metadata !28, metadata !"x1_", metadata !5, i32 12, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [x1_] [line 12]
!28 = metadata !{i32 786443, metadata !1, metadata !22, i32 11, i32 12, i32 0, i32 3} ; [ DW_TAG_lexical_block ] [/liveness_analysis/non_linear12.c]
!29 = metadata !{i32 12, i32 13, metadata !28, null}
!30 = metadata !{i32 786688, metadata !28, metadata !"x2_", metadata !5, i32 13, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [x2_] [line 13]
!31 = metadata !{i32 13, i32 13, metadata !28, null}
!32 = metadata !{i32 4, i32 3, metadata !4, null}
!33 = metadata !{i32 4, i32 3, metadata !34, null}
!34 = metadata !{i32 786443, metadata !1, metadata !4, i32 4, i32 3, i32 1, i32 5} ; [ DW_TAG_lexical_block ] [/liveness_analysis/non_linear12.c]
!35 = metadata !{i32 5, i32 8, metadata !22, null}
!36 = metadata !{i32 8, i32 9, metadata !21, null} ; [ DW_TAG_imported_declaration ]
!37 = metadata !{i32 9, i32 9, metadata !21, null}
!38 = metadata !{i32 10, i32 9, metadata !21, null}
!39 = metadata !{i32 18, i32 3, metadata !23, null}
!40 = metadata !{i32 20, i32 3, metadata !41, null}
!41 = metadata !{i32 786443, metadata !1, metadata !4, i32 20, i32 3, i32 1, i32 6} ; [ DW_TAG_lexical_block ] [/liveness_analysis/non_linear12.c]
!42 = metadata !{i32 21, i32 5, metadata !43, null}
!43 = metadata !{i32 786443, metadata !1, metadata !4, i32 20, i32 17, i32 0, i32 4} ; [ DW_TAG_lexical_block ] [/liveness_analysis/non_linear12.c]
!44 = metadata !{i32 22, i32 3, metadata !43, null}
!45 = metadata !{i32 23, i32 3, metadata !4, null}

