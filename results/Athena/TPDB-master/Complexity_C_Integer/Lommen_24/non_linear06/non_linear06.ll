; ModuleID = 'non_linear06.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind uwtable
define i32 @non_linear06(i32 %x1, i32 %x2, i32 %x3, i32 %x4, i32 %y1, i32 %y2) #0 {
non_linear06_bb0:
  call void @llvm.dbg.value(metadata !{i32 %x1}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !{i32 %x2}, i64 0, metadata !14), !dbg !15
  call void @llvm.dbg.value(metadata !{i32 %x3}, i64 0, metadata !16), !dbg !17
  call void @llvm.dbg.value(metadata !{i32 %x4}, i64 0, metadata !18), !dbg !19
  call void @llvm.dbg.value(metadata !{i32 %y1}, i64 0, metadata !20), !dbg !21
  call void @llvm.dbg.value(metadata !{i32 %y2}, i64 0, metadata !22), !dbg !23
  call void @llvm.dbg.value(metadata !{i32 %.0}, i64 0, metadata !24), !dbg !26
  call void @llvm.dbg.value(metadata !{i32 %.01}, i64 0, metadata !27), !dbg !28
  call void @llvm.dbg.value(metadata !{i32 %"12"}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !{i32 %"15"}, i64 0, metadata !14), !dbg !15
  call void @llvm.dbg.value(metadata !{i32 %"16"}, i64 0, metadata !18), !dbg !19
  call void @llvm.dbg.value(metadata !{i32 %.03}, i64 0, metadata !29), !dbg !30
  call void @llvm.dbg.value(metadata !{i32 %.04}, i64 0, metadata !31), !dbg !32
  call void @llvm.dbg.value(metadata !{i32 %"20"}, i64 0, metadata !20), !dbg !21
  call void @llvm.dbg.value(metadata !{i32 %"28"}, i64 0, metadata !22), !dbg !23
  br label %non_linear06_bb1, !dbg !33

non_linear06_bb1:                                 ; preds = %non_linear06_bb2, %non_linear06_bb0
  %.04 = phi i32 [ %y2, %non_linear06_bb0 ], [ %"28", %non_linear06_bb2 ]
  %.03 = phi i32 [ %y1, %non_linear06_bb0 ], [ %"20", %non_linear06_bb2 ]
  %.02 = phi i32 [ %x4, %non_linear06_bb0 ], [ %"16", %non_linear06_bb2 ]
  %.01 = phi i32 [ %x2, %non_linear06_bb0 ], [ %"15", %non_linear06_bb2 ]
  %.0 = phi i32 [ %x1, %non_linear06_bb0 ], [ %"12", %non_linear06_bb2 ]
  %"0" = mul nsw i32 %.02, %.02, !dbg !34
  %"1" = mul nsw i32 %x3, %x3, !dbg !34
  %"2" = mul nsw i32 %"1", %x3, !dbg !34
  %"3" = mul nsw i32 %"2", %x3, !dbg !34
  %"4" = mul nsw i32 %"3", %x3, !dbg !34
  %"5" = sub nsw i32 %"0", %"4", !dbg !34
  %"6" = mul nsw i32 2, %.03, !dbg !34
  %"7" = sub nsw i32 %"6", %.04, !dbg !34
  %"8" = icmp slt i32 %"5", %"7", !dbg !34
  %"9" = icmp ne i32 %.02, 0, !dbg !36
  %. = select i1 %"8", i1 %"9", i1 false, !dbg !34
  br i1 %., label %non_linear06_bb2, label %non_linear06_bb3, !dbg !38

non_linear06_bb2:                                 ; preds = %non_linear06_bb1
  %"10" = mul nsw i32 3, %.0, !dbg !40
  %"11" = mul nsw i32 2, %.01, !dbg !40
  %"12" = add nsw i32 %"10", %"11", !dbg !40
  %"13" = mul nsw i32 -5, %.0, !dbg !41
  %"14" = mul nsw i32 3, %.01, !dbg !41
  %"15" = sub nsw i32 %"13", %"14", !dbg !41
  %"16" = mul nsw i32 -2, %.02, !dbg !42
  %"17" = mul nsw i32 %.03, %.03, !dbg !43
  %"18" = add nsw i32 %.03, %"17", !dbg !43
  %"19" = mul nsw i32 %x3, %x3, !dbg !43
  %"20" = add nsw i32 %"18", %"19", !dbg !43
  %"21" = mul nsw i32 -4, %.03, !dbg !44
  %"22" = mul nsw i32 2, %.03, !dbg !44
  %"23" = mul nsw i32 %"22", %.03, !dbg !44
  %"24" = add nsw i32 %"21", %"23", !dbg !44
  %"25" = mul nsw i32 3, %.04, !dbg !44
  %"26" = add nsw i32 %"24", %"25", !dbg !44
  %"27" = mul nsw i32 %x3, %x3, !dbg !44
  %"28" = add nsw i32 %"26", %"27", !dbg !44
  br label %non_linear06_bb1, !dbg !45

non_linear06_bb3:                                 ; preds = %non_linear06_bb1
  ret i32 0, !dbg !46
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

!0 = metadata !{i32 786449, metadata !1, i32 12, metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)", i1 false, metadata !"", i32 0, metadata !2, metadata !2, metadata !3, metadata !2, metadata !2, metadata !"", i32 1} ; [ DW_TAG_compile_unit ] [/liveness_analysis/non_linear06.c] [DW_LANG_C99]
!1 = metadata !{metadata !"non_linear06.c", metadata !"/liveness_analysis"}
!2 = metadata !{}
!3 = metadata !{metadata !4}
!4 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"non_linear06", metadata !"non_linear06", metadata !"", i32 1, metadata !6, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, i32 (i32, i32, i32, i32, i32, i32)* @non_linear06, null, null, metadata !2, i32 1} ; [ DW_TAG_subprogram ] [line 1] [def] [non_linear06]
!5 = metadata !{i32 786473, metadata !1}          ; [ DW_TAG_file_type ] [/liveness_analysis/non_linear06.c]
!6 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !7, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!7 = metadata !{metadata !8, metadata !8, metadata !8, metadata !8, metadata !8, metadata !8, metadata !8}
!8 = metadata !{i32 786468, null, null, metadata !"int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!9 = metadata !{i32 2, metadata !"Dwarf Version", i32 4}
!10 = metadata !{i32 2, metadata !"Debug Info Version", i32 1}
!11 = metadata !{metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)"}
!12 = metadata !{i32 786689, metadata !4, metadata !"x1", metadata !5, i32 16777217, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [x1] [line 1]
!13 = metadata !{i32 1, i32 22, metadata !4, null}
!14 = metadata !{i32 786689, metadata !4, metadata !"x2", metadata !5, i32 33554433, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [x2] [line 1]
!15 = metadata !{i32 1, i32 30, metadata !4, null}
!16 = metadata !{i32 786689, metadata !4, metadata !"x3", metadata !5, i32 50331649, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [x3] [line 1]
!17 = metadata !{i32 1, i32 38, metadata !4, null}
!18 = metadata !{i32 786689, metadata !4, metadata !"x4", metadata !5, i32 67108865, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [x4] [line 1]
!19 = metadata !{i32 1, i32 46, metadata !4, null}
!20 = metadata !{i32 786689, metadata !4, metadata !"y1", metadata !5, i32 83886081, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [y1] [line 1]
!21 = metadata !{i32 1, i32 54, metadata !4, null}
!22 = metadata !{i32 786689, metadata !4, metadata !"y2", metadata !5, i32 100663297, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [y2] [line 1]
!23 = metadata !{i32 1, i32 62, metadata !4, null}
!24 = metadata !{i32 786688, metadata !25, metadata !"x1_", metadata !5, i32 3, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [x1_] [line 3]
!25 = metadata !{i32 786443, metadata !1, metadata !4, i32 2, i32 56, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/liveness_analysis/non_linear06.c]
!26 = metadata !{i32 3, i32 9, metadata !25, null}
!27 = metadata !{i32 786688, metadata !25, metadata !"x2_", metadata !5, i32 4, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [x2_] [line 4]
!28 = metadata !{i32 4, i32 9, metadata !25, null}
!29 = metadata !{i32 786688, metadata !25, metadata !"y1_", metadata !5, i32 8, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [y1_] [line 8]
!30 = metadata !{i32 8, i32 9, metadata !25, null} ; [ DW_TAG_imported_declaration ]
!31 = metadata !{i32 786688, metadata !25, metadata !"y2_", metadata !5, i32 9, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [y2_] [line 9]
!32 = metadata !{i32 9, i32 9, metadata !25, null}
!33 = metadata !{i32 2, i32 3, metadata !4, null}
!34 = metadata !{i32 2, i32 3, metadata !35, null}
!35 = metadata !{i32 786443, metadata !1, metadata !4, i32 2, i32 3, i32 1, i32 1} ; [ DW_TAG_lexical_block ] [/liveness_analysis/non_linear06.c]
!36 = metadata !{i32 2, i32 3, metadata !37, null}
!37 = metadata !{i32 786443, metadata !1, metadata !4, i32 2, i32 3, i32 2, i32 2} ; [ DW_TAG_lexical_block ] [/liveness_analysis/non_linear06.c]
!38 = metadata !{i32 2, i32 3, metadata !39, null}
!39 = metadata !{i32 786443, metadata !1, metadata !4, i32 2, i32 3, i32 3, i32 3} ; [ DW_TAG_lexical_block ] [/liveness_analysis/non_linear06.c]
!40 = metadata !{i32 5, i32 5, metadata !25, null}
!41 = metadata !{i32 6, i32 5, metadata !25, null}
!42 = metadata !{i32 7, i32 5, metadata !25, null}
!43 = metadata !{i32 10, i32 5, metadata !25, null}
!44 = metadata !{i32 11, i32 5, metadata !25, null}
!45 = metadata !{i32 12, i32 3, metadata !25, null}
!46 = metadata !{i32 13, i32 3, metadata !4, null}

