; ModuleID = 'CPU2006_asctoeg.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind uwtable
define void @asctoeg(i32 %s) #0 {
asctoeg_bb0:
  call void @llvm.dbg.value(metadata !{i32 %s}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !{i32 %s}, i64 0, metadata !14), !dbg !15
  call void @llvm.dbg.value(metadata !16, i64 0, metadata !17), !dbg !19
  call void @llvm.dbg.value(metadata !{i32 %"4"}, i64 0, metadata !17), !dbg !19
  br label %asctoeg_bb1, !dbg !20

asctoeg_bb1:                                      ; preds = %asctoeg_.critedge1, %asctoeg_bb0
  %k.0 = phi i32 [ %s, %asctoeg_bb0 ], [ %"9", %asctoeg_.critedge1 ]
  %"0" = icmp sgt i32 %k.0, 0, !dbg !21
  br i1 %"0", label %asctoeg_bb2, label %asctoeg_bb6, !dbg !21

asctoeg_bb2:                                      ; preds = %asctoeg_bb1, %asctoeg_bb4
  %sp.0 = phi i32 [ %"4", %asctoeg_bb4 ], [ 0, %asctoeg_bb1 ]
  %"1" = icmp slt i32 %sp.0, %s, !dbg !23
  br i1 %"1", label %asctoeg_bb3, label %asctoeg_.critedge, !dbg !23

asctoeg_bb3:                                      ; preds = %asctoeg_bb2
  %"2" = call i32 (...)* @random(), !dbg !25
  %"3" = icmp ne i32 %"2", 0, !dbg !25
  br i1 %"3", label %asctoeg_bb4, label %asctoeg_.critedge, !dbg !27

asctoeg_bb4:                                      ; preds = %asctoeg_bb3
  %"4" = add nsw i32 %sp.0, 1, !dbg !29
  br label %asctoeg_bb2, !dbg !29

asctoeg_.critedge:                                ; preds = %asctoeg_bb3, %asctoeg_bb2, %asctoeg_bb5
  %sp.0.sink = phi i32 [ %"5", %asctoeg_bb5 ], [ %sp.0, %asctoeg_bb2 ], [ %sp.0, %asctoeg_bb3 ]
  %"5" = add nsw i32 %sp.0.sink, -1, !dbg !30
  %"6" = icmp sgt i32 %"5", 0, !dbg !31
  br i1 %"6", label %asctoeg_bb5, label %asctoeg_.critedge1, !dbg !31

asctoeg_bb5:                                      ; preds = %asctoeg_.critedge
  %"7" = call i32 (...)* @random(), !dbg !33
  %"8" = icmp ne i32 %"7", 0, !dbg !33
  br i1 %"8", label %asctoeg_.critedge, label %asctoeg_.critedge1, !dbg !35

asctoeg_.critedge1:                               ; preds = %asctoeg_.critedge, %asctoeg_bb5
  %"9" = add nsw i32 %k.0, -1, !dbg !37
  call void @llvm.dbg.value(metadata !{i32 %"9"}, i64 0, metadata !14), !dbg !15
  br label %asctoeg_bb1, !dbg !38

asctoeg_bb6:                                      ; preds = %asctoeg_bb1
  ret void, !dbg !39
}

; Function Attrs: nounwind readnone
declare void @llvm.dbg.declare(metadata, metadata) #1

declare i32 @random(...) #2

declare i32 @__kittel_nondef.0()

; Function Attrs: nounwind readnone
declare void @llvm.dbg.value(metadata, i64, metadata) #1

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone }
attributes #2 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!9, !10}
!llvm.ident = !{!11}

!0 = metadata !{i32 786449, metadata !1, i32 12, metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)", i1 false, metadata !"", i32 0, metadata !2, metadata !2, metadata !3, metadata !2, metadata !2, metadata !"", i32 1} ; [ DW_TAG_compile_unit ] [/liveness_analysis/CPU2006_asctoeg.c] [DW_LANG_C99]
!1 = metadata !{metadata !"CPU2006_asctoeg.c", metadata !"/liveness_analysis"}
!2 = metadata !{}
!3 = metadata !{metadata !4}
!4 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"asctoeg", metadata !"asctoeg", metadata !"", i32 6, metadata !6, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (i32)* @asctoeg, null, null, metadata !2, i32 6} ; [ DW_TAG_subprogram ] [line 6] [def] [asctoeg]
!5 = metadata !{i32 786473, metadata !1}          ; [ DW_TAG_file_type ] [/liveness_analysis/CPU2006_asctoeg.c]
!6 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !7, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!7 = metadata !{null, metadata !8}
!8 = metadata !{i32 786468, null, null, metadata !"int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!9 = metadata !{i32 2, metadata !"Dwarf Version", i32 4}
!10 = metadata !{i32 2, metadata !"Debug Info Version", i32 1}
!11 = metadata !{metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)"}
!12 = metadata !{i32 786689, metadata !4, metadata !"s", metadata !5, i32 16777222, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [s] [line 6]
!13 = metadata !{i32 6, i32 18, metadata !4, null}
!14 = metadata !{i32 786688, metadata !4, metadata !"k", metadata !5, i32 7, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [k] [line 7]
!15 = metadata !{i32 7, i32 7, metadata !4, null}
!16 = metadata !{i32 0}
!17 = metadata !{i32 786688, metadata !18, metadata !"sp", metadata !5, i32 9, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [sp] [line 9]
!18 = metadata !{i32 786443, metadata !1, metadata !4, i32 8, i32 16, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_asctoeg.c]
!19 = metadata !{i32 9, i32 8, metadata !18, null}
!20 = metadata !{i32 8, i32 3, metadata !4, null} ; [ DW_TAG_imported_declaration ]
!21 = metadata !{i32 8, i32 3, metadata !22, null} ; [ DW_TAG_imported_declaration ]
!22 = metadata !{i32 786443, metadata !1, metadata !4, i32 8, i32 3, i32 1, i32 1} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_asctoeg.c]
!23 = metadata !{i32 10, i32 4, metadata !24, null}
!24 = metadata !{i32 786443, metadata !1, metadata !18, i32 10, i32 4, i32 1, i32 2} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_asctoeg.c]
!25 = metadata !{i32 10, i32 21, metadata !26, null}
!26 = metadata !{i32 786443, metadata !1, metadata !18, i32 10, i32 21, i32 2, i32 3} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_asctoeg.c]
!27 = metadata !{i32 10, i32 21, metadata !28, null}
!28 = metadata !{i32 786443, metadata !1, metadata !18, i32 10, i32 21, i32 3, i32 4} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_asctoeg.c]
!29 = metadata !{i32 11, i32 6, metadata !18, null}
!30 = metadata !{i32 12, i32 4, metadata !18, null}
!31 = metadata !{i32 13, i32 4, metadata !32, null}
!32 = metadata !{i32 786443, metadata !1, metadata !18, i32 13, i32 4, i32 1, i32 5} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_asctoeg.c]
!33 = metadata !{i32 13, i32 21, metadata !34, null}
!34 = metadata !{i32 786443, metadata !1, metadata !18, i32 13, i32 21, i32 2, i32 6} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_asctoeg.c]
!35 = metadata !{i32 13, i32 21, metadata !36, null}
!36 = metadata !{i32 786443, metadata !1, metadata !18, i32 13, i32 21, i32 3, i32 7} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_asctoeg.c]
!37 = metadata !{i32 15, i32 5, metadata !18, null}
!38 = metadata !{i32 16, i32 3, metadata !18, null}
!39 = metadata !{i32 17, i32 1, metadata !4, null}

