; ModuleID = 'size03.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind uwtable
define i32 @size03(i32 %a, i32 %b, i32 %c, i32 %d) #0 {
size03_bb0:
  call void @llvm.dbg.value(metadata !{i32 %a}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !{i32 %b}, i64 0, metadata !14), !dbg !15
  call void @llvm.dbg.value(metadata !{i32 %c}, i64 0, metadata !16), !dbg !17
  call void @llvm.dbg.value(metadata !{i32 %d}, i64 0, metadata !18), !dbg !19
  call void @llvm.dbg.value(metadata !{i32 %"1"}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !{i32 %.01}, i64 0, metadata !20), !dbg !22
  call void @llvm.dbg.value(metadata !{i32 %.02}, i64 0, metadata !23), !dbg !24
  call void @llvm.dbg.value(metadata !{i32 %"4"}, i64 0, metadata !14), !dbg !15
  call void @llvm.dbg.value(metadata !{i32 %"7"}, i64 0, metadata !16), !dbg !17
  call void @llvm.dbg.value(metadata !{i32 %"9"}, i64 0, metadata !18), !dbg !19
  br label %size03_bb1, !dbg !25

size03_bb1:                                       ; preds = %size03_bb2, %size03_bb0
  %.03 = phi i32 [ %d, %size03_bb0 ], [ %"9", %size03_bb2 ]
  %.02 = phi i32 [ %c, %size03_bb0 ], [ %"7", %size03_bb2 ]
  %.01 = phi i32 [ %b, %size03_bb0 ], [ %"4", %size03_bb2 ]
  %.0 = phi i32 [ %a, %size03_bb0 ], [ %"1", %size03_bb2 ]
  %"0" = icmp sgt i32 %.0, 0, !dbg !26
  br i1 %"0", label %size03_bb2, label %size03_bb3, !dbg !26

size03_bb2:                                       ; preds = %size03_bb1
  %"1" = sub nsw i32 %.0, 1, !dbg !28
  %"2" = mul nsw i32 3, %.01, !dbg !29
  %"3" = mul nsw i32 2, %.02, !dbg !29
  %"4" = add nsw i32 %"2", %"3", !dbg !29
  %"5" = mul nsw i32 -5, %.01, !dbg !30
  %"6" = mul nsw i32 3, %.02, !dbg !30
  %"7" = sub nsw i32 %"5", %"6", !dbg !30
  %"8" = mul nsw i32 %"1", %"1", !dbg !31
  %"9" = add nsw i32 %"8", %.03, !dbg !31
  br label %size03_bb1, !dbg !32

size03_bb3:                                       ; preds = %size03_bb1, %size03_bb4
  %.1 = phi i32 [ %"11", %size03_bb4 ], [ %.03, %size03_bb1 ]
  %"10" = icmp sgt i32 %.1, 0, !dbg !33
  br i1 %"10", label %size03_bb4, label %size03_bb5, !dbg !33

size03_bb4:                                       ; preds = %size03_bb3
  %"11" = sub nsw i32 %.1, 1, !dbg !35
  br label %size03_bb3, !dbg !37

size03_bb5:                                       ; preds = %size03_bb3
  ret i32 0, !dbg !38
}

; Function Attrs: nounwind readnone
declare void @llvm.dbg.declare(metadata, metadata) #1

declare i32 @__kittel_nondef.0()

; Function Attrs: nounwind readnone
declare void @llvm.dbg.value(metadata, i64, metadata) #1

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!9, !10}
!llvm.ident = !{!11}

!0 = metadata !{i32 786449, metadata !1, i32 12, metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)", i1 false, metadata !"", i32 0, metadata !2, metadata !2, metadata !3, metadata !2, metadata !2, metadata !"", i32 1} ; [ DW_TAG_compile_unit ] [/liveness_analysis/size03.c] [DW_LANG_C99]
!1 = metadata !{metadata !"size03.c", metadata !"/liveness_analysis"}
!2 = metadata !{}
!3 = metadata !{metadata !4}
!4 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"size03", metadata !"size03", metadata !"", i32 1, metadata !6, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, i32 (i32, i32, i32, i32)* @size03, null, null, metadata !2, i32 1} ; [ DW_TAG_subprogram ] [line 1] [def] [size03]
!5 = metadata !{i32 786473, metadata !1}          ; [ DW_TAG_file_type ] [/liveness_analysis/size03.c]
!6 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !7, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!7 = metadata !{metadata !8, metadata !8, metadata !8, metadata !8, metadata !8}
!8 = metadata !{i32 786468, null, null, metadata !"int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!9 = metadata !{i32 2, metadata !"Dwarf Version", i32 4}
!10 = metadata !{i32 2, metadata !"Debug Info Version", i32 1}
!11 = metadata !{metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)"}
!12 = metadata !{i32 786689, metadata !4, metadata !"a", metadata !5, i32 16777217, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [a] [line 1]
!13 = metadata !{i32 1, i32 16, metadata !4, null}
!14 = metadata !{i32 786689, metadata !4, metadata !"b", metadata !5, i32 33554433, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [b] [line 1]
!15 = metadata !{i32 1, i32 23, metadata !4, null}
!16 = metadata !{i32 786689, metadata !4, metadata !"c", metadata !5, i32 50331649, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [c] [line 1]
!17 = metadata !{i32 1, i32 30, metadata !4, null}
!18 = metadata !{i32 786689, metadata !4, metadata !"d", metadata !5, i32 67108865, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [d] [line 1]
!19 = metadata !{i32 1, i32 37, metadata !4, null}
!20 = metadata !{i32 786688, metadata !21, metadata !"b_", metadata !5, i32 4, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [b_] [line 4]
!21 = metadata !{i32 786443, metadata !1, metadata !4, i32 2, i32 16, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/liveness_analysis/size03.c]
!22 = metadata !{i32 4, i32 9, metadata !21, null}
!23 = metadata !{i32 786688, metadata !21, metadata !"c_", metadata !5, i32 5, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [c_] [line 5]
!24 = metadata !{i32 5, i32 9, metadata !21, null}
!25 = metadata !{i32 2, i32 3, metadata !4, null}
!26 = metadata !{i32 2, i32 3, metadata !27, null}
!27 = metadata !{i32 786443, metadata !1, metadata !4, i32 2, i32 3, i32 1, i32 2} ; [ DW_TAG_lexical_block ] [/liveness_analysis/size03.c]
!28 = metadata !{i32 3, i32 5, metadata !21, null}
!29 = metadata !{i32 6, i32 5, metadata !21, null}
!30 = metadata !{i32 7, i32 5, metadata !21, null}
!31 = metadata !{i32 8, i32 5, metadata !21, null} ; [ DW_TAG_imported_declaration ]
!32 = metadata !{i32 9, i32 3, metadata !21, null}
!33 = metadata !{i32 10, i32 3, metadata !34, null}
!34 = metadata !{i32 786443, metadata !1, metadata !4, i32 10, i32 3, i32 1, i32 3} ; [ DW_TAG_lexical_block ] [/liveness_analysis/size03.c]
!35 = metadata !{i32 11, i32 5, metadata !36, null}
!36 = metadata !{i32 786443, metadata !1, metadata !4, i32 10, i32 16, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/liveness_analysis/size03.c]
!37 = metadata !{i32 12, i32 3, metadata !36, null}
!38 = metadata !{i32 13, i32 3, metadata !4, null}

