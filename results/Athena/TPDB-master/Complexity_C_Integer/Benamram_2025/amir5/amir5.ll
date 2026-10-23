; ModuleID = 'amir5.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind uwtable
define void @amir5(i32 %x4, i32 %x1, i32 %x2, i32 %x5) #0 {
amir5_bb0:
  call void @llvm.dbg.value(metadata !{i32 %x4}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !{i32 %x1}, i64 0, metadata !14), !dbg !15
  call void @llvm.dbg.value(metadata !{i32 %x2}, i64 0, metadata !16), !dbg !17
  call void @llvm.dbg.value(metadata !{i32 %x5}, i64 0, metadata !18), !dbg !19
  call void @llvm.dbg.value(metadata !20, i64 0, metadata !21), !dbg !22
  call void @llvm.dbg.value(metadata !{i32 %"0"}, i64 0, metadata !18), !dbg !19
  call void @llvm.dbg.value(metadata !20, i64 0, metadata !23), !dbg !24
  call void @llvm.dbg.value(metadata !{i32 %"3"}, i64 0, metadata !16), !dbg !17
  call void @llvm.dbg.value(metadata !{i32 %"3"}, i64 0, metadata !21), !dbg !22
  call void @llvm.dbg.value(metadata !{i32 %"4"}, i64 0, metadata !23), !dbg !24
  br label %amir5_bb1, !dbg !25

amir5_bb1:                                        ; preds = %amir5_bb2, %amir5_bb0
  %x3.0 = phi i32 [ 0, %amir5_bb0 ], [ %x3.1, %amir5_bb2 ]
  %.03 = phi i32 [ %x5, %amir5_bb0 ], [ %"0", %amir5_bb2 ]
  %.01 = phi i32 [ %x2, %amir5_bb0 ], [ %x1, %amir5_bb2 ]
  %.0 = phi i32 [ %x4, %amir5_bb0 ], [ %x3.1, %amir5_bb2 ]
  %"0" = add nsw i32 %.03, -1, !dbg !26
  %"1" = icmp sgt i32 %.03, 0, !dbg !26
  br i1 %"1", label %amir5_bb2, label %amir5_bb4, !dbg !26

amir5_bb2:                                        ; preds = %amir5_bb1, %amir5_bb3
  %x3.1 = phi i32 [ %"3", %amir5_bb3 ], [ %x3.0, %amir5_bb1 ]
  %i.0 = phi i32 [ %"4", %amir5_bb3 ], [ 0, %amir5_bb1 ]
  %.12 = phi i32 [ %"3", %amir5_bb3 ], [ %.01, %amir5_bb1 ]
  %"2" = icmp slt i32 %i.0, %.0, !dbg !28
  br i1 %"2", label %amir5_bb3, label %amir5_bb1, !dbg !28

amir5_bb3:                                        ; preds = %amir5_bb2
  %"3" = add nsw i32 %x1, %.12, !dbg !33
  %"4" = add nsw i32 %i.0, 1, !dbg !35
  br label %amir5_bb2, !dbg !35

amir5_bb4:                                        ; preds = %amir5_bb1, %amir5_bb5
  %.1 = phi i32 [ %"6", %amir5_bb5 ], [ %.0, %amir5_bb1 ]
  %"5" = icmp sgt i32 %.1, 0, !dbg !36
  br i1 %"5", label %amir5_bb5, label %amir5_bb6, !dbg !36

amir5_bb5:                                        ; preds = %amir5_bb4
  %"6" = add nsw i32 %.1, -1, !dbg !38
  br label %amir5_bb4, !dbg !40

amir5_bb6:                                        ; preds = %amir5_bb4
  ret void, !dbg !41
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

!0 = metadata !{i32 786449, metadata !1, i32 12, metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)", i1 false, metadata !"", i32 0, metadata !2, metadata !2, metadata !3, metadata !2, metadata !2, metadata !"", i32 1} ; [ DW_TAG_compile_unit ] [/liveness_analysis/amir5.c] [DW_LANG_C99]
!1 = metadata !{metadata !"amir5.c", metadata !"/liveness_analysis"}
!2 = metadata !{}
!3 = metadata !{metadata !4}
!4 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"amir5", metadata !"amir5", metadata !"", i32 6, metadata !6, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (i32, i32, i32, i32)* @amir5, null, null, metadata !2, i32 7} ; [ DW_TAG_subprogram ] [line 6] [def] [scope 7] [amir5]
!5 = metadata !{i32 786473, metadata !1}          ; [ DW_TAG_file_type ] [/liveness_analysis/amir5.c]
!6 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !7, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!7 = metadata !{null, metadata !8, metadata !8, metadata !8, metadata !8}
!8 = metadata !{i32 786468, null, null, metadata !"int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!9 = metadata !{i32 2, metadata !"Dwarf Version", i32 4}
!10 = metadata !{i32 2, metadata !"Debug Info Version", i32 1}
!11 = metadata !{metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)"}
!12 = metadata !{i32 786689, metadata !4, metadata !"x4", metadata !5, i32 16777222, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [x4] [line 6]
!13 = metadata !{i32 6, i32 16, metadata !4, null}
!14 = metadata !{i32 786689, metadata !4, metadata !"x1", metadata !5, i32 33554438, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [x1] [line 6]
!15 = metadata !{i32 6, i32 24, metadata !4, null}
!16 = metadata !{i32 786689, metadata !4, metadata !"x2", metadata !5, i32 50331654, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [x2] [line 6]
!17 = metadata !{i32 6, i32 32, metadata !4, null}
!18 = metadata !{i32 786689, metadata !4, metadata !"x5", metadata !5, i32 67108870, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [x5] [line 6]
!19 = metadata !{i32 6, i32 40, metadata !4, null}
!20 = metadata !{i32 0}
!21 = metadata !{i32 786688, metadata !4, metadata !"x3", metadata !5, i32 9, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [x3] [line 9]
!22 = metadata !{i32 9, i32 9, metadata !4, null}
!23 = metadata !{i32 786688, metadata !4, metadata !"i", metadata !5, i32 8, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [i] [line 8]
!24 = metadata !{i32 8, i32 9, metadata !4, null} ; [ DW_TAG_imported_declaration ]
!25 = metadata !{i32 10, i32 5, metadata !4, null}
!26 = metadata !{i32 10, i32 5, metadata !27, null}
!27 = metadata !{i32 786443, metadata !1, metadata !4, i32 10, i32 5, i32 1, i32 4} ; [ DW_TAG_lexical_block ] [/liveness_analysis/amir5.c]
!28 = metadata !{i32 11, i32 14, metadata !29, null}
!29 = metadata !{i32 786443, metadata !1, metadata !30, i32 11, i32 14, i32 2, i32 6} ; [ DW_TAG_lexical_block ] [/liveness_analysis/amir5.c]
!30 = metadata !{i32 786443, metadata !1, metadata !31, i32 11, i32 14, i32 1, i32 5} ; [ DW_TAG_lexical_block ] [/liveness_analysis/amir5.c]
!31 = metadata !{i32 786443, metadata !1, metadata !32, i32 11, i32 9, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/liveness_analysis/amir5.c]
!32 = metadata !{i32 786443, metadata !1, metadata !4, i32 10, i32 22, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/liveness_analysis/amir5.c]
!33 = metadata !{i32 12, i32 13, metadata !34, null}
!34 = metadata !{i32 786443, metadata !1, metadata !31, i32 11, i32 30, i32 0, i32 2} ; [ DW_TAG_lexical_block ] [/liveness_analysis/amir5.c]
!35 = metadata !{i32 11, i32 25, metadata !31, null}
!36 = metadata !{i32 18, i32 5, metadata !37, null}
!37 = metadata !{i32 786443, metadata !1, metadata !4, i32 18, i32 5, i32 1, i32 7} ; [ DW_TAG_lexical_block ] [/liveness_analysis/amir5.c]
!38 = metadata !{i32 19, i32 9, metadata !39, null}
!39 = metadata !{i32 786443, metadata !1, metadata !4, i32 18, i32 20, i32 0, i32 3} ; [ DW_TAG_lexical_block ] [/liveness_analysis/amir5.c]
!40 = metadata !{i32 20, i32 5, metadata !39, null}
!41 = metadata !{i32 21, i32 1, metadata !4, null}

