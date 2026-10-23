; ModuleID = 'random2d.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind uwtable
define i32 @random2d(i32 %N) #0 {
random2d_bb0:
  call void @llvm.dbg.value(metadata !{i32 %N}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !14, i64 0, metadata !15), !dbg !16
  call void @llvm.dbg.value(metadata !14, i64 0, metadata !17), !dbg !18
  call void @llvm.dbg.value(metadata !14, i64 0, metadata !19), !dbg !20
  call void @llvm.dbg.value(metadata !{i32 %"1"}, i64 0, metadata !19), !dbg !20
  call void @llvm.dbg.value(metadata !{i32 %"2"}, i64 0, metadata !21), !dbg !22
  call void @llvm.dbg.value(metadata !{i32 %"5"}, i64 0, metadata !15), !dbg !16
  call void @llvm.dbg.value(metadata !{i32 %"6"}, i64 0, metadata !15), !dbg !16
  call void @llvm.dbg.value(metadata !{i32 %"7"}, i64 0, metadata !17), !dbg !18
  call void @llvm.dbg.value(metadata !{i32 %"8"}, i64 0, metadata !17), !dbg !18
  br label %random2d_bb1, !dbg !23

random2d_bb1:                                     ; preds = %random2d_NewDefault, %random2d_bb2, %random2d_bb5, %random2d_bb7, %random2d_bb6, %random2d_bb4, %random2d_bb0
  %i.0 = phi i32 [ 0, %random2d_bb0 ], [ %"1", %random2d_bb4 ], [ %"1", %random2d_bb6 ], [ %"1", %random2d_NewDefault ], [ %"1", %random2d_bb7 ], [ %"1", %random2d_bb5 ], [ %"1", %random2d_bb2 ]
  %y.0 = phi i32 [ 0, %random2d_bb0 ], [ %y.0, %random2d_bb2 ], [ %y.0, %random2d_bb4 ], [ %y.0, %random2d_bb5 ], [ %"7", %random2d_bb6 ], [ %"8", %random2d_bb7 ], [ %y.0, %random2d_NewDefault ]
  %x.0 = phi i32 [ 0, %random2d_bb0 ], [ %x.0, %random2d_bb2 ], [ %"5", %random2d_bb4 ], [ %"6", %random2d_bb5 ], [ %x.0, %random2d_bb7 ], [ %x.0, %random2d_NewDefault ], [ %x.0, %random2d_bb6 ]
  %"0" = icmp slt i32 %i.0, %N, !dbg !24
  br i1 %"0", label %random2d_bb2, label %random2d_bb8, !dbg !24

random2d_bb2:                                     ; preds = %random2d_bb1
  %"1" = add nsw i32 %i.0, 1, !dbg !26
  %"2" = call i32 (...)* @nondet(), !dbg !28
  %"3" = icmp sge i32 %"2", 0, !dbg !29
  %"4" = icmp sle i32 %"2", 3, !dbg !31
  %or.cond = and i1 %"3", %"4", !dbg !29
  br i1 %or.cond, label %random2d_bb3, label %random2d_bb1, !dbg !29

random2d_bb3:                                     ; preds = %random2d_bb2
  br label %random2d_NodeBlock5

random2d_NodeBlock5:                              ; preds = %random2d_bb3
  %Pivot6 = icmp slt i32 %"2", 2
  br i1 %Pivot6, label %random2d_NodeBlock, label %random2d_NodeBlock3

random2d_NodeBlock:                               ; preds = %random2d_NodeBlock5
  %Pivot = icmp slt i32 %"2", 1
  br i1 %Pivot, label %random2d_LeafBlock, label %random2d_bb5

random2d_LeafBlock:                               ; preds = %random2d_NodeBlock
  %SwitchLeaf = icmp eq i32 %"2", 0
  br i1 %SwitchLeaf, label %random2d_bb4, label %random2d_NewDefault

random2d_bb4:                                     ; preds = %random2d_LeafBlock
  %"5" = add nsw i32 %x.0, 1, !dbg !33
  br label %random2d_bb1, !dbg !33

random2d_bb5:                                     ; preds = %random2d_NodeBlock
  %"6" = sub nsw i32 %x.0, 1, !dbg !37
  br label %random2d_bb1, !dbg !37

random2d_NodeBlock3:                              ; preds = %random2d_NodeBlock5
  %Pivot4 = icmp slt i32 %"2", 3
  br i1 %Pivot4, label %random2d_bb6, label %random2d_LeafBlock1

random2d_bb6:                                     ; preds = %random2d_NodeBlock3
  %"7" = add nsw i32 %y.0, 1, !dbg !40
  br label %random2d_bb1, !dbg !40

random2d_LeafBlock1:                              ; preds = %random2d_NodeBlock3
  %SwitchLeaf2 = icmp eq i32 %"2", 3
  br i1 %SwitchLeaf2, label %random2d_bb7, label %random2d_NewDefault

random2d_bb7:                                     ; preds = %random2d_LeafBlock1
  %"8" = sub nsw i32 %y.0, 1, !dbg !43
  br label %random2d_bb1, !dbg !43

random2d_NewDefault:                              ; preds = %random2d_LeafBlock1, %random2d_LeafBlock
  br label %random2d_bb1

random2d_bb8:                                     ; preds = %random2d_bb1
  ret i32 0, !dbg !46
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

!0 = metadata !{i32 786449, metadata !1, i32 12, metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)", i1 false, metadata !"", i32 0, metadata !2, metadata !2, metadata !3, metadata !2, metadata !2, metadata !"", i32 1} ; [ DW_TAG_compile_unit ] [/liveness_analysis/random2d.c] [DW_LANG_C99]
!1 = metadata !{metadata !"random2d.c", metadata !"/liveness_analysis"}
!2 = metadata !{}
!3 = metadata !{metadata !4}
!4 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"random2d", metadata !"random2d", metadata !"", i32 3, metadata !6, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, i32 (i32)* @random2d, null, null, metadata !2, i32 3} ; [ DW_TAG_subprogram ] [line 3] [def] [random2d]
!5 = metadata !{i32 786473, metadata !1}          ; [ DW_TAG_file_type ] [/liveness_analysis/random2d.c]
!6 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !7, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!7 = metadata !{metadata !8, metadata !8}
!8 = metadata !{i32 786468, null, null, metadata !"int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!9 = metadata !{i32 2, metadata !"Dwarf Version", i32 4}
!10 = metadata !{i32 2, metadata !"Debug Info Version", i32 1}
!11 = metadata !{metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)"}
!12 = metadata !{i32 786689, metadata !4, metadata !"N", metadata !5, i32 16777219, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [N] [line 3]
!13 = metadata !{i32 3, i32 18, metadata !4, null}
!14 = metadata !{i32 0}
!15 = metadata !{i32 786688, metadata !4, metadata !"x", metadata !5, i32 4, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [x] [line 4]
!16 = metadata !{i32 4, i32 7, metadata !4, null}
!17 = metadata !{i32 786688, metadata !4, metadata !"y", metadata !5, i32 5, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [y] [line 5]
!18 = metadata !{i32 5, i32 7, metadata !4, null}
!19 = metadata !{i32 786688, metadata !4, metadata !"i", metadata !5, i32 6, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [i] [line 6]
!20 = metadata !{i32 6, i32 7, metadata !4, null}
!21 = metadata !{i32 786688, metadata !4, metadata !"r", metadata !5, i32 7, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [r] [line 7]
!22 = metadata !{i32 7, i32 7, metadata !4, null}
!23 = metadata !{i32 13, i32 3, metadata !4, null}
!24 = metadata !{i32 13, i32 3, metadata !25, null}
!25 = metadata !{i32 786443, metadata !1, metadata !4, i32 13, i32 3, i32 1, i32 7} ; [ DW_TAG_lexical_block ] [/liveness_analysis/random2d.c]
!26 = metadata !{i32 14, i32 5, metadata !27, null}
!27 = metadata !{i32 786443, metadata !1, metadata !4, i32 13, i32 15, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/liveness_analysis/random2d.c]
!28 = metadata !{i32 15, i32 7, metadata !27, null}
!29 = metadata !{i32 16, i32 9, metadata !30, null}
!30 = metadata !{i32 786443, metadata !1, metadata !27, i32 16, i32 9, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/liveness_analysis/random2d.c]
!31 = metadata !{i32 16, i32 9, metadata !32, null}
!32 = metadata !{i32 786443, metadata !1, metadata !30, i32 16, i32 9, i32 1, i32 8} ; [ DW_TAG_lexical_block ] [/liveness_analysis/random2d.c]
!33 = metadata !{i32 17, i32 16, metadata !34, null}
!34 = metadata !{i32 786443, metadata !1, metadata !35, i32 17, i32 16, i32 1, i32 9} ; [ DW_TAG_lexical_block ] [/liveness_analysis/random2d.c]
!35 = metadata !{i32 786443, metadata !1, metadata !36, i32 17, i32 10, i32 0, i32 3} ; [ DW_TAG_lexical_block ] [/liveness_analysis/random2d.c]
!36 = metadata !{i32 786443, metadata !1, metadata !30, i32 16, i32 23, i32 0, i32 2} ; [ DW_TAG_lexical_block ] [/liveness_analysis/random2d.c]
!37 = metadata !{i32 18, i32 16, metadata !38, null}
!38 = metadata !{i32 786443, metadata !1, metadata !39, i32 18, i32 16, i32 1, i32 10} ; [ DW_TAG_lexical_block ] [/liveness_analysis/random2d.c]
!39 = metadata !{i32 786443, metadata !1, metadata !35, i32 18, i32 10, i32 0, i32 4} ; [ DW_TAG_lexical_block ] [/liveness_analysis/random2d.c]
!40 = metadata !{i32 19, i32 16, metadata !41, null}
!41 = metadata !{i32 786443, metadata !1, metadata !42, i32 19, i32 16, i32 1, i32 11} ; [ DW_TAG_lexical_block ] [/liveness_analysis/random2d.c]
!42 = metadata !{i32 786443, metadata !1, metadata !39, i32 19, i32 10, i32 0, i32 5} ; [ DW_TAG_lexical_block ] [/liveness_analysis/random2d.c]
!43 = metadata !{i32 20, i32 16, metadata !44, null}
!44 = metadata !{i32 786443, metadata !1, metadata !45, i32 20, i32 16, i32 1, i32 12} ; [ DW_TAG_lexical_block ] [/liveness_analysis/random2d.c]
!45 = metadata !{i32 786443, metadata !1, metadata !42, i32 20, i32 10, i32 0, i32 6} ; [ DW_TAG_lexical_block ] [/liveness_analysis/random2d.c]
!46 = metadata !{i32 23, i32 3, metadata !4, null}

