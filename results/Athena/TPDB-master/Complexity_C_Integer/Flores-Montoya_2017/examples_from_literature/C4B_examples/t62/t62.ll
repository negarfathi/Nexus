; ModuleID = 't62.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind uwtable
define void @t62(i32 %l, i32 %h) #0 {
t62_bb0:
  call void @llvm.dbg.value(metadata !{i32 %l}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !{i32 %h}, i64 0, metadata !14), !dbg !15
  %"0" = icmp sge i32 %l, %h, !dbg !16
  br i1 %"0", label %t62_bb5, label %t62_bb1, !dbg !16

t62_bb1:                                          ; preds = %t62_.critedge3, %t62_bb0
  %.01 = phi i32 [ %h, %t62_bb0 ], [ %"5", %t62_.critedge3 ]
  %.0 = phi i32 [ %l, %t62_bb0 ], [ %"1", %t62_.critedge3 ]
  br label %t62_bb2, !dbg !18

t62_bb2:                                          ; preds = %t62_bb3, %t62_bb1
  %.1 = phi i32 [ %.0, %t62_bb1 ], [ %"1", %t62_bb3 ]
  %"1" = add nsw i32 %.1, 1, !dbg !21
  %"2" = icmp slt i32 %"1", %.01, !dbg !25
  br i1 %"2", label %t62_bb3, label %t62_.critedge, !dbg !25

t62_bb3:                                          ; preds = %t62_bb2
  %"3" = call i32 (...)* @nondet(), !dbg !27
  %"4" = icmp sgt i32 %"3", 0, !dbg !27
  br i1 %"4", label %t62_bb2, label %t62_.critedge, !dbg !29

t62_.critedge:                                    ; preds = %t62_bb2, %t62_bb3, %t62_bb4
  %.12 = phi i32 [ %"5", %t62_bb4 ], [ %.01, %t62_bb3 ], [ %.01, %t62_bb2 ]
  %"5" = add nsw i32 %.12, -1, !dbg !31
  %"6" = icmp slt i32 %"1", %"5", !dbg !35
  br i1 %"6", label %t62_bb4, label %t62_.critedge3, !dbg !35

t62_bb4:                                          ; preds = %t62_.critedge
  %"7" = call i32 (...)* @nondet(), !dbg !37
  %"8" = icmp sgt i32 %"7", 0, !dbg !37
  br i1 %"8", label %t62_.critedge, label %t62_.critedge3, !dbg !39

t62_.critedge3:                                   ; preds = %t62_.critedge, %t62_bb4
  %"9" = icmp sge i32 %"1", %"5", !dbg !41
  br i1 %"9", label %t62_bb5, label %t62_bb1, !dbg !41

t62_bb5:                                          ; preds = %t62_.critedge3, %t62_bb0
  ret void, !dbg !43
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

!0 = metadata !{i32 786449, metadata !1, i32 12, metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)", i1 false, metadata !"", i32 0, metadata !2, metadata !2, metadata !3, metadata !2, metadata !2, metadata !"", i32 1} ; [ DW_TAG_compile_unit ] [/liveness_analysis/t62.c] [DW_LANG_C99]
!1 = metadata !{metadata !"t62.c", metadata !"/liveness_analysis"}
!2 = metadata !{}
!3 = metadata !{metadata !4}
!4 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"t62", metadata !"t62", metadata !"", i32 5, metadata !6, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (i32, i32)* @t62, null, null, metadata !2, i32 5} ; [ DW_TAG_subprogram ] [line 5] [def] [t62]
!5 = metadata !{i32 786473, metadata !1}          ; [ DW_TAG_file_type ] [/liveness_analysis/t62.c]
!6 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !7, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!7 = metadata !{null, metadata !8, metadata !8}
!8 = metadata !{i32 786468, null, null, metadata !"int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!9 = metadata !{i32 2, metadata !"Dwarf Version", i32 4}
!10 = metadata !{i32 2, metadata !"Debug Info Version", i32 1}
!11 = metadata !{metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)"}
!12 = metadata !{i32 786689, metadata !4, metadata !"l", metadata !5, i32 16777221, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [l] [line 5]
!13 = metadata !{i32 5, i32 14, metadata !4, null}
!14 = metadata !{i32 786689, metadata !4, metadata !"h", metadata !5, i32 33554437, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [h] [line 5]
!15 = metadata !{i32 5, i32 21, metadata !4, null}
!16 = metadata !{i32 6, i32 7, metadata !17, null}
!17 = metadata !{i32 786443, metadata !1, metadata !4, i32 6, i32 7, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/liveness_analysis/t62.c]
!18 = metadata !{i32 8, i32 5, metadata !19, null} ; [ DW_TAG_imported_declaration ]
!19 = metadata !{i32 786443, metadata !1, metadata !20, i32 7, i32 12, i32 0, i32 2} ; [ DW_TAG_lexical_block ] [/liveness_analysis/t62.c]
!20 = metadata !{i32 786443, metadata !1, metadata !4, i32 7, i32 3, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/liveness_analysis/t62.c]
!21 = metadata !{i32 8, i32 10, metadata !22, null} ; [ DW_TAG_imported_declaration ]
!22 = metadata !{i32 786443, metadata !1, metadata !23, i32 8, i32 10, i32 5, i32 11} ; [ DW_TAG_lexical_block ] [/liveness_analysis/t62.c]
!23 = metadata !{i32 786443, metadata !1, metadata !24, i32 8, i32 10, i32 1, i32 7} ; [ DW_TAG_lexical_block ] [/liveness_analysis/t62.c]
!24 = metadata !{i32 786443, metadata !1, metadata !19, i32 8, i32 8, i32 0, i32 3} ; [ DW_TAG_lexical_block ] [/liveness_analysis/t62.c]
!25 = metadata !{i32 8, i32 15, metadata !26, null} ; [ DW_TAG_imported_declaration ]
!26 = metadata !{i32 786443, metadata !1, metadata !24, i32 8, i32 15, i32 2, i32 8} ; [ DW_TAG_lexical_block ] [/liveness_analysis/t62.c]
!27 = metadata !{i32 8, i32 31, metadata !28, null} ; [ DW_TAG_imported_declaration ]
!28 = metadata !{i32 786443, metadata !1, metadata !19, i32 8, i32 31, i32 3, i32 9} ; [ DW_TAG_lexical_block ] [/liveness_analysis/t62.c]
!29 = metadata !{i32 8, i32 31, metadata !30, null} ; [ DW_TAG_imported_declaration ]
!30 = metadata !{i32 786443, metadata !1, metadata !19, i32 8, i32 31, i32 4, i32 10} ; [ DW_TAG_lexical_block ] [/liveness_analysis/t62.c]
!31 = metadata !{i32 9, i32 10, metadata !32, null}
!32 = metadata !{i32 786443, metadata !1, metadata !33, i32 9, i32 10, i32 5, i32 16} ; [ DW_TAG_lexical_block ] [/liveness_analysis/t62.c]
!33 = metadata !{i32 786443, metadata !1, metadata !34, i32 9, i32 10, i32 1, i32 12} ; [ DW_TAG_lexical_block ] [/liveness_analysis/t62.c]
!34 = metadata !{i32 786443, metadata !1, metadata !19, i32 9, i32 8, i32 0, i32 4} ; [ DW_TAG_lexical_block ] [/liveness_analysis/t62.c]
!35 = metadata !{i32 9, i32 15, metadata !36, null}
!36 = metadata !{i32 786443, metadata !1, metadata !34, i32 9, i32 15, i32 2, i32 13} ; [ DW_TAG_lexical_block ] [/liveness_analysis/t62.c]
!37 = metadata !{i32 9, i32 31, metadata !38, null}
!38 = metadata !{i32 786443, metadata !1, metadata !19, i32 9, i32 31, i32 3, i32 14} ; [ DW_TAG_lexical_block ] [/liveness_analysis/t62.c]
!39 = metadata !{i32 9, i32 31, metadata !40, null}
!40 = metadata !{i32 786443, metadata !1, metadata !19, i32 9, i32 31, i32 4, i32 15} ; [ DW_TAG_lexical_block ] [/liveness_analysis/t62.c]
!41 = metadata !{i32 10, i32 9, metadata !42, null}
!42 = metadata !{i32 786443, metadata !1, metadata !19, i32 10, i32 9, i32 0, i32 5} ; [ DW_TAG_lexical_block ] [/liveness_analysis/t62.c]
!43 = metadata !{i32 12, i32 1, metadata !4, null}

