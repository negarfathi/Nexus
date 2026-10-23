; ModuleID = 't07.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind uwtable
define void @t07(i32 %x, i32 %y) #0 {
t07_bb0:
  call void @llvm.dbg.value(metadata !{i32 %x}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !{i32 %y}, i64 0, metadata !14), !dbg !15
  call void @llvm.dbg.value(metadata !{i32 %"1"}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !{i32 %"2"}, i64 0, metadata !14), !dbg !15
  br label %t07_bb1, !dbg !16

t07_bb1:                                          ; preds = %t07_bb2, %t07_bb0
  %.01 = phi i32 [ %y, %t07_bb0 ], [ %"2", %t07_bb2 ]
  %.0 = phi i32 [ %x, %t07_bb0 ], [ %"1", %t07_bb2 ]
  %"0" = icmp sgt i32 %.0, 0, !dbg !17
  br i1 %"0", label %t07_bb2, label %t07_bb3, !dbg !17

t07_bb2:                                          ; preds = %t07_bb1
  %"1" = sub nsw i32 %.0, 1, !dbg !19
  %"2" = add nsw i32 %.01, 2, !dbg !21
  br label %t07_bb1, !dbg !22

t07_bb3:                                          ; preds = %t07_bb1, %t07_bb4
  %.1 = phi i32 [ %"4", %t07_bb4 ], [ %.01, %t07_bb1 ]
  %"3" = icmp sgt i32 %.1, 0, !dbg !23
  br i1 %"3", label %t07_bb4, label %t07_bb5, !dbg !23

t07_bb4:                                          ; preds = %t07_bb3
  %"4" = sub nsw i32 %.1, 1, !dbg !25
  br label %t07_bb3, !dbg !27

t07_bb5:                                          ; preds = %t07_bb3, %t07_bb6
  %.2 = phi i32 [ %"6", %t07_bb6 ], [ %.1, %t07_bb3 ]
  %"5" = icmp sgt i32 %.2, 0, !dbg !28
  br i1 %"5", label %t07_bb6, label %t07_bb7, !dbg !28

t07_bb6:                                          ; preds = %t07_bb5
  %"6" = sub nsw i32 %.2, 1, !dbg !30
  br label %t07_bb5, !dbg !32

t07_bb7:                                          ; preds = %t07_bb5
  ret void, !dbg !33
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

!0 = metadata !{i32 786449, metadata !1, i32 12, metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)", i1 false, metadata !"", i32 0, metadata !2, metadata !2, metadata !3, metadata !2, metadata !2, metadata !"", i32 1} ; [ DW_TAG_compile_unit ] [/liveness_analysis/t07.c] [DW_LANG_C99]
!1 = metadata !{metadata !"t07.c", metadata !"/liveness_analysis"}
!2 = metadata !{}
!3 = metadata !{metadata !4}
!4 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"t07", metadata !"t07", metadata !"", i32 3, metadata !6, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (i32, i32)* @t07, null, null, metadata !2, i32 4} ; [ DW_TAG_subprogram ] [line 3] [def] [scope 4] [t07]
!5 = metadata !{i32 786473, metadata !1}          ; [ DW_TAG_file_type ] [/liveness_analysis/t07.c]
!6 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !7, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!7 = metadata !{null, metadata !8, metadata !8}
!8 = metadata !{i32 786468, null, null, metadata !"int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!9 = metadata !{i32 2, metadata !"Dwarf Version", i32 4}
!10 = metadata !{i32 2, metadata !"Debug Info Version", i32 1}
!11 = metadata !{metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)"}
!12 = metadata !{i32 786689, metadata !4, metadata !"x", metadata !5, i32 16777219, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [x] [line 3]
!13 = metadata !{i32 3, i32 14, metadata !4, null}
!14 = metadata !{i32 786689, metadata !4, metadata !"y", metadata !5, i32 33554435, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [y] [line 3]
!15 = metadata !{i32 3, i32 21, metadata !4, null}
!16 = metadata !{i32 5, i32 3, metadata !4, null}
!17 = metadata !{i32 5, i32 3, metadata !18, null}
!18 = metadata !{i32 786443, metadata !1, metadata !4, i32 5, i32 3, i32 1, i32 3} ; [ DW_TAG_lexical_block ] [/liveness_analysis/t07.c]
!19 = metadata !{i32 6, i32 5, metadata !20, null}
!20 = metadata !{i32 786443, metadata !1, metadata !4, i32 5, i32 15, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/liveness_analysis/t07.c]
!21 = metadata !{i32 7, i32 5, metadata !20, null}
!22 = metadata !{i32 8, i32 3, metadata !20, null} ; [ DW_TAG_imported_declaration ]
!23 = metadata !{i32 9, i32 3, metadata !24, null}
!24 = metadata !{i32 786443, metadata !1, metadata !4, i32 9, i32 3, i32 1, i32 4} ; [ DW_TAG_lexical_block ] [/liveness_analysis/t07.c]
!25 = metadata !{i32 10, i32 5, metadata !26, null}
!26 = metadata !{i32 786443, metadata !1, metadata !4, i32 9, i32 15, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/liveness_analysis/t07.c]
!27 = metadata !{i32 11, i32 3, metadata !26, null}
!28 = metadata !{i32 12, i32 3, metadata !29, null}
!29 = metadata !{i32 786443, metadata !1, metadata !4, i32 12, i32 3, i32 1, i32 5} ; [ DW_TAG_lexical_block ] [/liveness_analysis/t07.c]
!30 = metadata !{i32 13, i32 5, metadata !31, null}
!31 = metadata !{i32 786443, metadata !1, metadata !4, i32 12, i32 15, i32 0, i32 2} ; [ DW_TAG_lexical_block ] [/liveness_analysis/t07.c]
!32 = metadata !{i32 14, i32 3, metadata !31, null}
!33 = metadata !{i32 15, i32 1, metadata !4, null}

