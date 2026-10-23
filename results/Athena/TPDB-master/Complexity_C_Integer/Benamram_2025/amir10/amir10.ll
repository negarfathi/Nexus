; ModuleID = 'amir10.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind uwtable
define void @amir10(i32 %x3, i32 %x7) #0 {
amir10_bb0:
  call void @llvm.dbg.value(metadata !{i32 %x3}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !{i32 %x7}, i64 0, metadata !14), !dbg !15
  call void @llvm.dbg.value(metadata !16, i64 0, metadata !17), !dbg !18
  call void @llvm.dbg.value(metadata !16, i64 0, metadata !19), !dbg !20
  call void @llvm.dbg.value(metadata !16, i64 0, metadata !21), !dbg !22
  call void @llvm.dbg.value(metadata !16, i64 0, metadata !23), !dbg !24
  call void @llvm.dbg.value(metadata !{i32 %"0"}, i64 0, metadata !14), !dbg !15
  call void @llvm.dbg.value(metadata !16, i64 0, metadata !25), !dbg !26
  call void @llvm.dbg.value(metadata !16, i64 0, metadata !25), !dbg !26
  call void @llvm.dbg.value(metadata !{i32 %x1.2}, i64 0, metadata !17), !dbg !18
  call void @llvm.dbg.value(metadata !{i32 %"4"}, i64 0, metadata !19), !dbg !20
  call void @llvm.dbg.value(metadata !{i32 %x1.2}, i64 0, metadata !21), !dbg !22
  call void @llvm.dbg.value(metadata !{i32 %"5"}, i64 0, metadata !25), !dbg !26
  br label %amir10_bb1, !dbg !27

amir10_bb1:                                       ; preds = %amir10_bb2, %amir10_bb0
  %x5.0 = phi i32 [ 0, %amir10_bb0 ], [ %x5.1, %amir10_bb2 ]
  %x2.0 = phi i32 [ 0, %amir10_bb0 ], [ %x2.1, %amir10_bb2 ]
  %x1.0 = phi i32 [ 0, %amir10_bb0 ], [ %x1.1, %amir10_bb2 ]
  %.01 = phi i32 [ %x7, %amir10_bb0 ], [ %"0", %amir10_bb2 ]
  %.0 = phi i32 [ %x3, %amir10_bb0 ], [ %x5.1, %amir10_bb2 ]
  %"0" = add nsw i32 %.01, -1, !dbg !28
  %"1" = icmp sgt i32 %.01, 0, !dbg !28
  br i1 %"1", label %amir10_bb2, label %amir10_bb6, !dbg !28

amir10_bb2:                                       ; preds = %amir10_bb1, %amir10_bb5
  %x5.1 = phi i32 [ %"6", %amir10_bb5 ], [ %x5.0, %amir10_bb1 ]
  %x2.1 = phi i32 [ %x2.2, %amir10_bb5 ], [ %x2.0, %amir10_bb1 ]
  %x1.1 = phi i32 [ %x1.2, %amir10_bb5 ], [ %x1.0, %amir10_bb1 ]
  %i.0 = phi i32 [ %"7", %amir10_bb5 ], [ 0, %amir10_bb1 ]
  %.1 = phi i32 [ %x1.2, %amir10_bb5 ], [ %.0, %amir10_bb1 ]
  %"2" = icmp slt i32 %i.0, %"0", !dbg !30
  br i1 %"2", label %amir10_bb3, label %amir10_bb1, !dbg !30

amir10_bb3:                                       ; preds = %amir10_bb2, %amir10_bb4
  %x2.2 = phi i32 [ %x1.2, %amir10_bb4 ], [ %x2.1, %amir10_bb2 ]
  %x1.2 = phi i32 [ %"4", %amir10_bb4 ], [ %x1.1, %amir10_bb2 ]
  %i.1 = phi i32 [ %"5", %amir10_bb4 ], [ 0, %amir10_bb2 ]
  %"3" = icmp slt i32 %i.1, %.1, !dbg !35
  br i1 %"3", label %amir10_bb4, label %amir10_bb5, !dbg !35

amir10_bb4:                                       ; preds = %amir10_bb3
  %"4" = add nsw i32 %x2.2, 1, !dbg !40
  %"5" = add nsw i32 %i.1, 1, !dbg !42
  br label %amir10_bb3, !dbg !42

amir10_bb5:                                       ; preds = %amir10_bb3
  %"6" = add nsw i32 %x5.1, %x1.2, !dbg !43
  call void @llvm.dbg.value(metadata !{i32 %"6"}, i64 0, metadata !23), !dbg !24
  call void @llvm.dbg.value(metadata !{i32 %x1.2}, i64 0, metadata !12), !dbg !13
  %"7" = add nsw i32 %i.1, 1, !dbg !44
  call void @llvm.dbg.value(metadata !{i32 %"7"}, i64 0, metadata !25), !dbg !26
  br label %amir10_bb2, !dbg !44

amir10_bb6:                                       ; preds = %amir10_bb1, %amir10_bb7
  %.2 = phi i32 [ %"9", %amir10_bb7 ], [ %.0, %amir10_bb1 ]
  %"8" = icmp sgt i32 %.2, 0, !dbg !45
  br i1 %"8", label %amir10_bb7, label %amir10_bb8, !dbg !45

amir10_bb7:                                       ; preds = %amir10_bb6
  %"9" = add nsw i32 %.2, -1, !dbg !47
  br label %amir10_bb6, !dbg !49

amir10_bb8:                                       ; preds = %amir10_bb6
  ret void, !dbg !50
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

!0 = metadata !{i32 786449, metadata !1, i32 12, metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)", i1 false, metadata !"", i32 0, metadata !2, metadata !2, metadata !3, metadata !2, metadata !2, metadata !"", i32 1} ; [ DW_TAG_compile_unit ] [/liveness_analysis/amir10.c] [DW_LANG_C99]
!1 = metadata !{metadata !"amir10.c", metadata !"/liveness_analysis"}
!2 = metadata !{}
!3 = metadata !{metadata !4}
!4 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"amir10", metadata !"amir10", metadata !"", i32 7, metadata !6, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (i32, i32)* @amir10, null, null, metadata !2, i32 8} ; [ DW_TAG_subprogram ] [line 7] [def] [scope 8] [amir10]
!5 = metadata !{i32 786473, metadata !1}          ; [ DW_TAG_file_type ] [/liveness_analysis/amir10.c]
!6 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !7, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!7 = metadata !{null, metadata !8, metadata !8}
!8 = metadata !{i32 786468, null, null, metadata !"int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!9 = metadata !{i32 2, metadata !"Dwarf Version", i32 4}
!10 = metadata !{i32 2, metadata !"Debug Info Version", i32 1}
!11 = metadata !{metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)"}
!12 = metadata !{i32 786689, metadata !4, metadata !"x3", metadata !5, i32 16777223, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [x3] [line 7]
!13 = metadata !{i32 7, i32 17, metadata !4, null}
!14 = metadata !{i32 786689, metadata !4, metadata !"x7", metadata !5, i32 33554439, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [x7] [line 7]
!15 = metadata !{i32 7, i32 25, metadata !4, null}
!16 = metadata !{i32 0}
!17 = metadata !{i32 786688, metadata !4, metadata !"x4", metadata !5, i32 10, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [x4] [line 10]
!18 = metadata !{i32 10, i32 9, metadata !4, null}
!19 = metadata !{i32 786688, metadata !4, metadata !"x1", metadata !5, i32 11, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [x1] [line 11]
!20 = metadata !{i32 11, i32 9, metadata !4, null}
!21 = metadata !{i32 786688, metadata !4, metadata !"x2", metadata !5, i32 12, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [x2] [line 12]
!22 = metadata !{i32 12, i32 9, metadata !4, null}
!23 = metadata !{i32 786688, metadata !4, metadata !"x5", metadata !5, i32 13, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [x5] [line 13]
!24 = metadata !{i32 13, i32 9, metadata !4, null}
!25 = metadata !{i32 786688, metadata !4, metadata !"i", metadata !5, i32 9, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [i] [line 9]
!26 = metadata !{i32 9, i32 9, metadata !4, null}
!27 = metadata !{i32 14, i32 5, metadata !4, null}
!28 = metadata !{i32 14, i32 5, metadata !29, null}
!29 = metadata !{i32 786443, metadata !1, metadata !4, i32 14, i32 5, i32 1, i32 6} ; [ DW_TAG_lexical_block ] [/liveness_analysis/amir10.c]
!30 = metadata !{i32 15, i32 14, metadata !31, null}
!31 = metadata !{i32 786443, metadata !1, metadata !32, i32 15, i32 14, i32 2, i32 10} ; [ DW_TAG_lexical_block ] [/liveness_analysis/amir10.c]
!32 = metadata !{i32 786443, metadata !1, metadata !33, i32 15, i32 14, i32 1, i32 7} ; [ DW_TAG_lexical_block ] [/liveness_analysis/amir10.c]
!33 = metadata !{i32 786443, metadata !1, metadata !34, i32 15, i32 9, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/liveness_analysis/amir10.c]
!34 = metadata !{i32 786443, metadata !1, metadata !4, i32 14, i32 22, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/liveness_analysis/amir10.c]
!35 = metadata !{i32 16, i32 18, metadata !36, null}
!36 = metadata !{i32 786443, metadata !1, metadata !37, i32 16, i32 18, i32 2, i32 9} ; [ DW_TAG_lexical_block ] [/liveness_analysis/amir10.c]
!37 = metadata !{i32 786443, metadata !1, metadata !38, i32 16, i32 18, i32 1, i32 8} ; [ DW_TAG_lexical_block ] [/liveness_analysis/amir10.c]
!38 = metadata !{i32 786443, metadata !1, metadata !39, i32 16, i32 13, i32 0, i32 3} ; [ DW_TAG_lexical_block ] [/liveness_analysis/amir10.c]
!39 = metadata !{i32 786443, metadata !1, metadata !33, i32 15, i32 30, i32 0, i32 2} ; [ DW_TAG_lexical_block ] [/liveness_analysis/amir10.c]
!40 = metadata !{i32 18, i32 17, metadata !41, null}
!41 = metadata !{i32 786443, metadata !1, metadata !38, i32 16, i32 34, i32 0, i32 4} ; [ DW_TAG_lexical_block ] [/liveness_analysis/amir10.c]
!42 = metadata !{i32 16, i32 29, metadata !38, null}
!43 = metadata !{i32 21, i32 13, metadata !39, null}
!44 = metadata !{i32 15, i32 25, metadata !33, null}
!45 = metadata !{i32 26, i32 5, metadata !46, null}
!46 = metadata !{i32 786443, metadata !1, metadata !4, i32 26, i32 5, i32 1, i32 11} ; [ DW_TAG_lexical_block ] [/liveness_analysis/amir10.c]
!47 = metadata !{i32 27, i32 9, metadata !48, null}
!48 = metadata !{i32 786443, metadata !1, metadata !4, i32 26, i32 20, i32 0, i32 5} ; [ DW_TAG_lexical_block ] [/liveness_analysis/amir10.c]
!49 = metadata !{i32 28, i32 5, metadata !48, null}
!50 = metadata !{i32 29, i32 1, metadata !4, null}

