; ModuleID = 'aaron3.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind uwtable
define i32 @aaron3(i32 %x, i32 %y, i32 %z, i32 %tx) #0 {
aaron3_bb0:
  call void @llvm.dbg.value(metadata !{i32 %x}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !{i32 %y}, i64 0, metadata !14), !dbg !15
  call void @llvm.dbg.value(metadata !{i32 %z}, i64 0, metadata !16), !dbg !17
  call void @llvm.dbg.value(metadata !{i32 %tx}, i64 0, metadata !18), !dbg !19
  call void @llvm.dbg.value(metadata !{i32 %"3"}, i64 0, metadata !16), !dbg !17
  call void @llvm.dbg.value(metadata !{i32 %.01}, i64 0, metadata !18), !dbg !19
  call void @llvm.dbg.value(metadata !{i32 %"4"}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !{i32 %"7"}, i64 0, metadata !14), !dbg !15
  br label %aaron3_bb1, !dbg !20

aaron3_bb1:                                       ; preds = %aaron3_bb4, %aaron3_bb3, %aaron3_bb0
  %.04 = phi i32 [ %z, %aaron3_bb0 ], [ %.04, %aaron3_bb4 ], [ %"3", %aaron3_bb3 ]
  %.02 = phi i32 [ %y, %aaron3_bb0 ], [ %"7", %aaron3_bb4 ], [ %.02, %aaron3_bb3 ]
  %.01 = phi i32 [ %x, %aaron3_bb0 ], [ %.01, %aaron3_bb4 ], [ %"4", %aaron3_bb3 ]
  %"0" = icmp sge i32 %.01, %.02, !dbg !21
  br i1 %"0", label %aaron3_bb2, label %aaron3_bb5, !dbg !21

aaron3_bb2:                                       ; preds = %aaron3_bb1
  %"1" = call i32 (...)* @nondet(), !dbg !23
  %"2" = icmp sgt i32 %"1", 0, !dbg !23
  br i1 %"2", label %aaron3_bb3, label %aaron3_bb4, !dbg !23

aaron3_bb3:                                       ; preds = %aaron3_bb2
  %"3" = sub nsw i32 %.04, 1, !dbg !26
  %"4" = call i32 (...)* @nondet(), !dbg !28
  %"5" = add nsw i32 %.01, %"3", !dbg !29
  %"6" = icmp sgt i32 %"4", %"5", !dbg !29
  br i1 %"6", label %aaron3_bb5, label %aaron3_bb1, !dbg !29

aaron3_bb4:                                       ; preds = %aaron3_bb2
  %"7" = add nsw i32 %.02, 1, !dbg !31
  br label %aaron3_bb1

aaron3_bb5:                                       ; preds = %aaron3_bb1, %aaron3_bb3
  ret i32 0, !dbg !33
}

; Function Attrs: nounwind readnone
declare void @llvm.dbg.declare(metadata, metadata) #1

declare i32 @nondet(...) #2

declare i32 @__kittel_nondef.0()

; Function Attrs: nounwind readnone
declare void @llvm.dbg.value(metadata, i64, metadata) #1

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone }
attributes #2 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!9, !10}
!llvm.ident = !{!11}

!0 = metadata !{i32 786449, metadata !1, i32 12, metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)", i1 false, metadata !"", i32 0, metadata !2, metadata !2, metadata !3, metadata !2, metadata !2, metadata !"", i32 1} ; [ DW_TAG_compile_unit ] [/liveness_analysis/aaron3.c] [DW_LANG_C99]
!1 = metadata !{metadata !"aaron3.c", metadata !"/liveness_analysis"}
!2 = metadata !{}
!3 = metadata !{metadata !4}
!4 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"aaron3", metadata !"aaron3", metadata !"", i32 3, metadata !6, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, i32 (i32, i32, i32, i32)* @aaron3, null, null, metadata !2, i32 3} ; [ DW_TAG_subprogram ] [line 3] [def] [aaron3]
!5 = metadata !{i32 786473, metadata !1}          ; [ DW_TAG_file_type ] [/liveness_analysis/aaron3.c]
!6 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !7, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!7 = metadata !{metadata !8, metadata !8, metadata !8, metadata !8, metadata !8}
!8 = metadata !{i32 786468, null, null, metadata !"int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!9 = metadata !{i32 2, metadata !"Dwarf Version", i32 4}
!10 = metadata !{i32 2, metadata !"Debug Info Version", i32 1}
!11 = metadata !{metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)"}
!12 = metadata !{i32 786689, metadata !4, metadata !"x", metadata !5, i32 16777219, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [x] [line 3]
!13 = metadata !{i32 3, i32 16, metadata !4, null}
!14 = metadata !{i32 786689, metadata !4, metadata !"y", metadata !5, i32 33554435, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [y] [line 3]
!15 = metadata !{i32 3, i32 22, metadata !4, null}
!16 = metadata !{i32 786689, metadata !4, metadata !"z", metadata !5, i32 50331651, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [z] [line 3]
!17 = metadata !{i32 3, i32 28, metadata !4, null}
!18 = metadata !{i32 786689, metadata !4, metadata !"tx", metadata !5, i32 67108867, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [tx] [line 3]
!19 = metadata !{i32 3, i32 34, metadata !4, null}
!20 = metadata !{i32 4, i32 3, metadata !4, null}
!21 = metadata !{i32 4, i32 3, metadata !22, null}
!22 = metadata !{i32 786443, metadata !1, metadata !4, i32 4, i32 3, i32 1, i32 5} ; [ DW_TAG_lexical_block ] [/liveness_analysis/aaron3.c]
!23 = metadata !{i32 5, i32 9, metadata !24, null}
!24 = metadata !{i32 786443, metadata !1, metadata !25, i32 5, i32 9, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/liveness_analysis/aaron3.c]
!25 = metadata !{i32 786443, metadata !1, metadata !4, i32 4, i32 16, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/liveness_analysis/aaron3.c]
!26 = metadata !{i32 6, i32 7, metadata !27, null}
!27 = metadata !{i32 786443, metadata !1, metadata !24, i32 5, i32 21, i32 0, i32 2} ; [ DW_TAG_lexical_block ] [/liveness_analysis/aaron3.c]
!28 = metadata !{i32 8, i32 9, metadata !27, null} ; [ DW_TAG_imported_declaration ]
!29 = metadata !{i32 9, i32 11, metadata !30, null}
!30 = metadata !{i32 786443, metadata !1, metadata !27, i32 9, i32 11, i32 0, i32 3} ; [ DW_TAG_lexical_block ] [/liveness_analysis/aaron3.c]
!31 = metadata !{i32 11, i32 7, metadata !32, null}
!32 = metadata !{i32 786443, metadata !1, metadata !24, i32 10, i32 12, i32 0, i32 4} ; [ DW_TAG_lexical_block ] [/liveness_analysis/aaron3.c]
!33 = metadata !{i32 16, i32 1, metadata !4, null}

