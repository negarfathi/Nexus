; ModuleID = 'size10.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind uwtable
define i32 @size10(i32 %a, i32 %b, i32 %c, i32 %d, i32 %e) #0 {
size10_bb0:
  call void @llvm.dbg.value(metadata !{i32 %a}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !{i32 %b}, i64 0, metadata !14), !dbg !15
  call void @llvm.dbg.value(metadata !{i32 %c}, i64 0, metadata !16), !dbg !17
  call void @llvm.dbg.value(metadata !{i32 %d}, i64 0, metadata !18), !dbg !19
  call void @llvm.dbg.value(metadata !{i32 %e}, i64 0, metadata !20), !dbg !21
  %"0" = icmp sgt i32 %a, 0, !dbg !22
  %"1" = icmp sgt i32 %e, 0, !dbg !24
  %or.cond = and i1 %"0", %"1", !dbg !22
  br i1 %or.cond, label %size10_bb1, label %size10_bb7, !dbg !22

size10_bb1:                                       ; preds = %size10_bb0, %size10_bb6
  %.08 = phi i32 [ %"19", %size10_bb6 ], [ %e, %size10_bb0 ]
  %.05 = phi i32 [ %.08, %size10_bb6 ], [ %d, %size10_bb0 ]
  %.03 = phi i32 [ %"18", %size10_bb6 ], [ %c, %size10_bb0 ]
  %.01 = phi i32 [ %"17", %size10_bb6 ], [ %b, %size10_bb0 ]
  %.0 = phi i32 [ %.08, %size10_bb6 ], [ %a, %size10_bb0 ]
  %"2" = icmp sgt i32 %.08, 0, !dbg !26
  br i1 %"2", label %size10_bb2, label %size10_bb7, !dbg !26

size10_bb2:                                       ; preds = %size10_bb1, %size10_bb3
  %.16 = phi i32 [ %"12", %size10_bb3 ], [ %.05, %size10_bb1 ]
  %.14 = phi i32 [ %"10", %size10_bb3 ], [ %.03, %size10_bb1 ]
  %.12 = phi i32 [ %"7", %size10_bb3 ], [ %.01, %size10_bb1 ]
  %.1 = phi i32 [ %"4", %size10_bb3 ], [ %.0, %size10_bb1 ]
  %"3" = icmp sgt i32 %.1, 0, !dbg !29
  br i1 %"3", label %size10_bb3, label %size10_bb4, !dbg !29

size10_bb3:                                       ; preds = %size10_bb2
  %"4" = sub nsw i32 %.1, 1, !dbg !32
  %"5" = mul nsw i32 3, %.12, !dbg !34
  %"6" = mul nsw i32 2, %.14, !dbg !34
  %"7" = add nsw i32 %"5", %"6", !dbg !34
  %"8" = mul nsw i32 -5, %.12, !dbg !35
  %"9" = mul nsw i32 3, %.14, !dbg !35
  %"10" = sub nsw i32 %"8", %"9", !dbg !35
  %"11" = mul nsw i32 %"4", %"4", !dbg !36
  %"12" = add nsw i32 %"11", %.16, !dbg !36
  br label %size10_bb2, !dbg !37

size10_bb4:                                       ; preds = %size10_bb2, %size10_bb5
  %.27 = phi i32 [ %"16", %size10_bb5 ], [ %.16, %size10_bb2 ]
  %.2 = phi i32 [ %"15", %size10_bb5 ], [ %.12, %size10_bb2 ]
  %"13" = add nsw i32 %.2, %.27, !dbg !38
  %"14" = icmp sgt i32 %"13", 0, !dbg !38
  br i1 %"14", label %size10_bb5, label %size10_bb6, !dbg !38

size10_bb5:                                       ; preds = %size10_bb4
  %"15" = sub nsw i32 %.2, 1, !dbg !40
  %"16" = sub nsw i32 %.27, 1, !dbg !42
  br label %size10_bb4, !dbg !43

size10_bb6:                                       ; preds = %size10_bb4
  call void @llvm.dbg.value(metadata !{i32 %.08}, i64 0, metadata !12), !dbg !13
  %"17" = mul nsw i32 2, %.08, !dbg !44
  call void @llvm.dbg.value(metadata !{i32 %"17"}, i64 0, metadata !14), !dbg !15
  %"18" = mul nsw i32 3, %.08, !dbg !45
  call void @llvm.dbg.value(metadata !{i32 %"18"}, i64 0, metadata !16), !dbg !17
  call void @llvm.dbg.value(metadata !{i32 %.08}, i64 0, metadata !18), !dbg !19
  %"19" = sub nsw i32 %.08, 1, !dbg !46
  call void @llvm.dbg.value(metadata !{i32 %"19"}, i64 0, metadata !20), !dbg !21
  br label %size10_bb1, !dbg !47

size10_bb7:                                       ; preds = %size10_bb1, %size10_bb0
  ret i32 0, !dbg !48
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

!0 = metadata !{i32 786449, metadata !1, i32 12, metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)", i1 false, metadata !"", i32 0, metadata !2, metadata !2, metadata !3, metadata !2, metadata !2, metadata !"", i32 1} ; [ DW_TAG_compile_unit ] [/liveness_analysis/size10.c] [DW_LANG_C99]
!1 = metadata !{metadata !"size10.c", metadata !"/liveness_analysis"}
!2 = metadata !{}
!3 = metadata !{metadata !4}
!4 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"size10", metadata !"size10", metadata !"", i32 1, metadata !6, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, i32 (i32, i32, i32, i32, i32)* @size10, null, null, metadata !2, i32 1} ; [ DW_TAG_subprogram ] [line 1] [def] [size10]
!5 = metadata !{i32 786473, metadata !1}          ; [ DW_TAG_file_type ] [/liveness_analysis/size10.c]
!6 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !7, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!7 = metadata !{metadata !8, metadata !8, metadata !8, metadata !8, metadata !8, metadata !8}
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
!20 = metadata !{i32 786689, metadata !4, metadata !"e", metadata !5, i32 83886081, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [e] [line 1]
!21 = metadata !{i32 1, i32 44, metadata !4, null}
!22 = metadata !{i32 2, i32 6, metadata !23, null}
!23 = metadata !{i32 786443, metadata !1, metadata !4, i32 2, i32 6, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/liveness_analysis/size10.c]
!24 = metadata !{i32 2, i32 6, metadata !25, null}
!25 = metadata !{i32 786443, metadata !1, metadata !23, i32 2, i32 6, i32 1, i32 5} ; [ DW_TAG_lexical_block ] [/liveness_analysis/size10.c]
!26 = metadata !{i32 3, i32 5, metadata !27, null}
!27 = metadata !{i32 786443, metadata !1, metadata !28, i32 3, i32 5, i32 1, i32 6} ; [ DW_TAG_lexical_block ] [/liveness_analysis/size10.c]
!28 = metadata !{i32 786443, metadata !1, metadata !23, i32 2, i32 22, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/liveness_analysis/size10.c]
!29 = metadata !{i32 4, i32 7, metadata !30, null}
!30 = metadata !{i32 786443, metadata !1, metadata !31, i32 4, i32 7, i32 1, i32 7} ; [ DW_TAG_lexical_block ] [/liveness_analysis/size10.c]
!31 = metadata !{i32 786443, metadata !1, metadata !28, i32 3, i32 18, i32 0, i32 2} ; [ DW_TAG_lexical_block ] [/liveness_analysis/size10.c]
!32 = metadata !{i32 5, i32 9, metadata !33, null}
!33 = metadata !{i32 786443, metadata !1, metadata !31, i32 4, i32 20, i32 0, i32 3} ; [ DW_TAG_lexical_block ] [/liveness_analysis/size10.c]
!34 = metadata !{i32 8, i32 9, metadata !33, null} ; [ DW_TAG_imported_declaration ]
!35 = metadata !{i32 9, i32 9, metadata !33, null}
!36 = metadata !{i32 10, i32 9, metadata !33, null}
!37 = metadata !{i32 11, i32 7, metadata !33, null}
!38 = metadata !{i32 12, i32 7, metadata !39, null}
!39 = metadata !{i32 786443, metadata !1, metadata !31, i32 12, i32 7, i32 1, i32 8} ; [ DW_TAG_lexical_block ] [/liveness_analysis/size10.c]
!40 = metadata !{i32 13, i32 9, metadata !41, null}
!41 = metadata !{i32 786443, metadata !1, metadata !31, i32 12, i32 24, i32 0, i32 4} ; [ DW_TAG_lexical_block ] [/liveness_analysis/size10.c]
!42 = metadata !{i32 14, i32 9, metadata !41, null}
!43 = metadata !{i32 15, i32 7, metadata !41, null}
!44 = metadata !{i32 17, i32 7, metadata !31, null}
!45 = metadata !{i32 18, i32 7, metadata !31, null}
!46 = metadata !{i32 20, i32 7, metadata !31, null}
!47 = metadata !{i32 21, i32 5, metadata !31, null}
!48 = metadata !{i32 23, i32 3, metadata !4, null}

