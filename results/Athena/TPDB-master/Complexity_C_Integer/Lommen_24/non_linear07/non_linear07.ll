; ModuleID = 'non_linear07.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind uwtable
define i32 @non_linear07(i32 %y1, i32 %y2, i32 %x2, i32 %x3) #0 {
non_linear07_bb0:
  call void @llvm.dbg.value(metadata !{i32 %y1}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !{i32 %y2}, i64 0, metadata !14), !dbg !15
  call void @llvm.dbg.value(metadata !{i32 %x2}, i64 0, metadata !16), !dbg !17
  call void @llvm.dbg.value(metadata !{i32 %x3}, i64 0, metadata !18), !dbg !19
  call void @llvm.dbg.value(metadata !{i32 %.0}, i64 0, metadata !20), !dbg !22
  call void @llvm.dbg.value(metadata !{i32 %.01}, i64 0, metadata !23), !dbg !24
  call void @llvm.dbg.value(metadata !{i32 %"8"}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !{i32 %"11"}, i64 0, metadata !14), !dbg !15
  call void @llvm.dbg.value(metadata !{i32 %"12"}, i64 0, metadata !16), !dbg !17
  call void @llvm.dbg.value(metadata !{i32 %"13"}, i64 0, metadata !18), !dbg !19
  br label %non_linear07_bb1, !dbg !25

non_linear07_bb1:                                 ; preds = %non_linear07_bb2, %non_linear07_bb0
  %.03 = phi i32 [ %x3, %non_linear07_bb0 ], [ %"13", %non_linear07_bb2 ]
  %.02 = phi i32 [ %x2, %non_linear07_bb0 ], [ %"12", %non_linear07_bb2 ]
  %.01 = phi i32 [ %y2, %non_linear07_bb0 ], [ %"11", %non_linear07_bb2 ]
  %.0 = phi i32 [ %y1, %non_linear07_bb0 ], [ %"8", %non_linear07_bb2 ]
  %"0" = mul nsw i32 2, %.01, !dbg !26
  %"1" = add nsw i32 %.0, %"0", !dbg !26
  %"2" = icmp slt i32 %.03, %"1", !dbg !26
  %"3" = icmp slt i32 %.03, %.02, !dbg !28
  %or.cond = or i1 %"2", %"3", !dbg !26
  %"4" = icmp sgt i32 %.03, 0, !dbg !30
  %or.cond4 = and i1 %or.cond, %"4", !dbg !26
  br i1 %or.cond4, label %non_linear07_bb2, label %non_linear07_.critedge, !dbg !26

non_linear07_bb2:                                 ; preds = %non_linear07_bb1
  %"5" = mul nsw i32 2, %.0, !dbg !33
  %"6" = mul nsw i32 %"5", %.0, !dbg !33
  %"7" = mul nsw i32 2, %.0, !dbg !33
  %"8" = add nsw i32 %"6", %"7", !dbg !33
  %"9" = mul nsw i32 2, %.01, !dbg !34
  %"10" = mul nsw i32 %.0, %.0, !dbg !34
  %"11" = sub nsw i32 %"9", %"10", !dbg !34
  %"12" = mul nsw i32 3, %.02, !dbg !35
  %"13" = mul nsw i32 4, %.03, !dbg !36
  br label %non_linear07_bb1, !dbg !37

non_linear07_.critedge:                           ; preds = %non_linear07_bb1
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

!0 = metadata !{i32 786449, metadata !1, i32 12, metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)", i1 false, metadata !"", i32 0, metadata !2, metadata !2, metadata !3, metadata !2, metadata !2, metadata !"", i32 1} ; [ DW_TAG_compile_unit ] [/liveness_analysis/non_linear07.c] [DW_LANG_C99]
!1 = metadata !{metadata !"non_linear07.c", metadata !"/liveness_analysis"}
!2 = metadata !{}
!3 = metadata !{metadata !4}
!4 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"non_linear07", metadata !"non_linear07", metadata !"", i32 1, metadata !6, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, i32 (i32, i32, i32, i32)* @non_linear07, null, null, metadata !2, i32 1} ; [ DW_TAG_subprogram ] [line 1] [def] [non_linear07]
!5 = metadata !{i32 786473, metadata !1}          ; [ DW_TAG_file_type ] [/liveness_analysis/non_linear07.c]
!6 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !7, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!7 = metadata !{metadata !8, metadata !8, metadata !8, metadata !8, metadata !8}
!8 = metadata !{i32 786468, null, null, metadata !"int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!9 = metadata !{i32 2, metadata !"Dwarf Version", i32 4}
!10 = metadata !{i32 2, metadata !"Debug Info Version", i32 1}
!11 = metadata !{metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)"}
!12 = metadata !{i32 786689, metadata !4, metadata !"y1", metadata !5, i32 16777217, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [y1] [line 1]
!13 = metadata !{i32 1, i32 22, metadata !4, null}
!14 = metadata !{i32 786689, metadata !4, metadata !"y2", metadata !5, i32 33554433, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [y2] [line 1]
!15 = metadata !{i32 1, i32 30, metadata !4, null}
!16 = metadata !{i32 786689, metadata !4, metadata !"x2", metadata !5, i32 50331649, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [x2] [line 1]
!17 = metadata !{i32 1, i32 38, metadata !4, null}
!18 = metadata !{i32 786689, metadata !4, metadata !"x3", metadata !5, i32 67108865, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [x3] [line 1]
!19 = metadata !{i32 1, i32 46, metadata !4, null}
!20 = metadata !{i32 786688, metadata !21, metadata !"y1_", metadata !5, i32 3, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [y1_] [line 3]
!21 = metadata !{i32 786443, metadata !1, metadata !4, i32 2, i32 48, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/liveness_analysis/non_linear07.c]
!22 = metadata !{i32 3, i32 9, metadata !21, null}
!23 = metadata !{i32 786688, metadata !21, metadata !"y2_", metadata !5, i32 4, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [y2_] [line 4]
!24 = metadata !{i32 4, i32 9, metadata !21, null}
!25 = metadata !{i32 2, i32 3, metadata !4, null}
!26 = metadata !{i32 2, i32 3, metadata !27, null}
!27 = metadata !{i32 786443, metadata !1, metadata !4, i32 2, i32 3, i32 1, i32 1} ; [ DW_TAG_lexical_block ] [/liveness_analysis/non_linear07.c]
!28 = metadata !{i32 2, i32 3, metadata !29, null}
!29 = metadata !{i32 786443, metadata !1, metadata !4, i32 2, i32 3, i32 3, i32 3} ; [ DW_TAG_lexical_block ] [/liveness_analysis/non_linear07.c]
!30 = metadata !{i32 2, i32 3, metadata !31, null}
!31 = metadata !{i32 786443, metadata !1, metadata !32, i32 2, i32 3, i32 4, i32 4} ; [ DW_TAG_lexical_block ] [/liveness_analysis/non_linear07.c]
!32 = metadata !{i32 786443, metadata !1, metadata !4, i32 2, i32 3, i32 2, i32 2} ; [ DW_TAG_lexical_block ] [/liveness_analysis/non_linear07.c]
!33 = metadata !{i32 5, i32 5, metadata !21, null}
!34 = metadata !{i32 6, i32 5, metadata !21, null}
!35 = metadata !{i32 7, i32 5, metadata !21, null}
!36 = metadata !{i32 8, i32 5, metadata !21, null} ; [ DW_TAG_imported_declaration ]
!37 = metadata !{i32 9, i32 3, metadata !21, null}
!38 = metadata !{i32 10, i32 3, metadata !4, null}

