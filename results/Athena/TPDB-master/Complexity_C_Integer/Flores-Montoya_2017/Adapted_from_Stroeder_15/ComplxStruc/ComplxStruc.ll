; ModuleID = 'ComplxStruc.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind uwtable
define i32 @foo(i32 %i, i32 %j) #0 {
foo_bb0:
  call void @llvm.dbg.value(metadata !{i32 %i}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !{i32 %j}, i64 0, metadata !14), !dbg !15
  call void @llvm.dbg.value(metadata !{i32 %i}, i64 0, metadata !14), !dbg !15
  call void @llvm.dbg.value(metadata !{i32 %"2"}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !{i32 %"4"}, i64 0, metadata !14), !dbg !15
  call void @llvm.dbg.value(metadata !{i32 %"7"}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !{i32 %"8"}, i64 0, metadata !14), !dbg !15
  call void @llvm.dbg.value(metadata !{i32 %"9"}, i64 0, metadata !14), !dbg !15
  call void @llvm.dbg.value(metadata !{i32 %"12"}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !{i32 %"14"}, i64 0, metadata !14), !dbg !15
  call void @llvm.dbg.value(metadata !{i32 %"15"}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !{i32 %"16"}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !{i32 %"19"}, i64 0, metadata !14), !dbg !15
  call void @llvm.dbg.value(metadata !{i32 %"20"}, i64 0, metadata !14), !dbg !15
  br label %foo_bb1, !dbg !16

foo_bb1:                                          ; preds = %foo_bb4, %foo_bb5, %foo_bb8, %foo_bb7, %foo_bb0
  %.01 = phi i32 [ %i, %foo_bb0 ], [ %"9", %foo_bb5 ], [ %.12, %foo_bb4 ], [ %.34, %foo_bb7 ], [ %.45, %foo_bb8 ]
  %.0 = phi i32 [ %i, %foo_bb0 ], [ %"2", %foo_bb5 ], [ %.1, %foo_bb4 ], [ %.3, %foo_bb7 ], [ %"16", %foo_bb8 ]
  %"0" = icmp sgt i32 %.0, 0, !dbg !17
  br i1 %"0", label %foo_bb2, label %foo_bb9, !dbg !17

foo_bb2:                                          ; preds = %foo_bb1
  %"1" = icmp sge i32 %.0, %.01, !dbg !19
  br i1 %"1", label %foo_bb3, label %foo_bb6, !dbg !19

foo_bb3:                                          ; preds = %foo_bb2
  %"2" = add nsw i32 %.0, 1, !dbg !22
  %"3" = icmp slt i32 %.01, 5, !dbg !24
  br i1 %"3", label %foo_bb4, label %foo_bb5, !dbg !24

foo_bb4:                                          ; preds = %foo_bb3
  %"4" = add nsw i32 %.01, 1, !dbg !26
  %"5" = sub nsw i32 %"2", %"4", !dbg !28
  %"6" = icmp sgt i32 %"5", 2, !dbg !28
  %"7" = add nsw i32 %"2", 1, !dbg !30
  %"8" = add nsw i32 %"4", 1, !dbg !32
  %.12 = select i1 %"6", i32 %"4", i32 %"8", !dbg !28
  %.1 = select i1 %"6", i32 %"7", i32 %"2", !dbg !28
  br label %foo_bb1, !dbg !28

foo_bb5:                                          ; preds = %foo_bb3
  %"9" = sub nsw i32 %.01, 1, !dbg !34
  br label %foo_bb1

foo_bb6:                                          ; preds = %foo_bb2
  %"10" = icmp sgt i32 %.0, 0, !dbg !36
  %"11" = icmp slt i32 %.01, 0, !dbg !39
  %or.cond = and i1 %"10", %"11", !dbg !36
  br i1 %or.cond, label %foo_bb7, label %foo_bb8, !dbg !36

foo_bb7:                                          ; preds = %foo_bb6
  %"12" = sub nsw i32 %.0, 1, !dbg !41
  %"13" = icmp slt i32 %.01, -1, !dbg !43
  %"14" = add nsw i32 %.01, 1, !dbg !45
  %"15" = add nsw i32 %"12", 1, !dbg !47
  %.34 = select i1 %"13", i32 %"14", i32 %.01, !dbg !43
  %.3 = select i1 %"13", i32 %"12", i32 %"15", !dbg !43
  br label %foo_bb1, !dbg !43

foo_bb8:                                          ; preds = %foo_bb6
  %"16" = add nsw i32 %.0, 1, !dbg !49
  %"17" = mul nsw i32 %.01, 2, !dbg !51
  %"18" = icmp sgt i32 %"17", %"16", !dbg !51
  %"19" = sub nsw i32 %.01, 1, !dbg !53
  %"20" = add nsw i32 %.01, 1, !dbg !55
  %.45 = select i1 %"18", i32 %"19", i32 %"20", !dbg !51
  br label %foo_bb1, !dbg !51

foo_bb9:                                          ; preds = %foo_bb1
  ret i32 0, !dbg !57
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

!0 = metadata !{i32 786449, metadata !1, i32 12, metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)", i1 false, metadata !"", i32 0, metadata !2, metadata !2, metadata !3, metadata !2, metadata !2, metadata !"", i32 1} ; [ DW_TAG_compile_unit ] [/liveness_analysis/ComplxStruc.c] [DW_LANG_C99]
!1 = metadata !{metadata !"ComplxStruc.c", metadata !"/liveness_analysis"}
!2 = metadata !{}
!3 = metadata !{metadata !4}
!4 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"foo", metadata !"foo", metadata !"", i32 3, metadata !6, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, i32 (i32, i32)* @foo, null, null, metadata !2, i32 3} ; [ DW_TAG_subprogram ] [line 3] [def] [foo]
!5 = metadata !{i32 786473, metadata !1}          ; [ DW_TAG_file_type ] [/liveness_analysis/ComplxStruc.c]
!6 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !7, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!7 = metadata !{metadata !8, metadata !8, metadata !8}
!8 = metadata !{i32 786468, null, null, metadata !"int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!9 = metadata !{i32 2, metadata !"Dwarf Version", i32 4}
!10 = metadata !{i32 2, metadata !"Debug Info Version", i32 1}
!11 = metadata !{metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)"}
!12 = metadata !{i32 786689, metadata !4, metadata !"i", metadata !5, i32 16777219, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [i] [line 3]
!13 = metadata !{i32 3, i32 13, metadata !4, null}
!14 = metadata !{i32 786689, metadata !4, metadata !"j", metadata !5, i32 33554435, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [j] [line 3]
!15 = metadata !{i32 3, i32 19, metadata !4, null}
!16 = metadata !{i32 5, i32 1, metadata !4, null}
!17 = metadata !{i32 5, i32 1, metadata !18, null}
!18 = metadata !{i32 786443, metadata !1, metadata !4, i32 5, i32 1, i32 1, i32 19} ; [ DW_TAG_lexical_block ] [/liveness_analysis/ComplxStruc.c]
!19 = metadata !{i32 6, i32 13, metadata !20, null}
!20 = metadata !{i32 786443, metadata !1, metadata !21, i32 6, i32 13, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/liveness_analysis/ComplxStruc.c]
!21 = metadata !{i32 786443, metadata !1, metadata !4, i32 5, i32 15, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/liveness_analysis/ComplxStruc.c]
!22 = metadata !{i32 7, i32 13, metadata !23, null}
!23 = metadata !{i32 786443, metadata !1, metadata !20, i32 6, i32 21, i32 0, i32 2} ; [ DW_TAG_lexical_block ] [/liveness_analysis/ComplxStruc.c]
!24 = metadata !{i32 8, i32 17, metadata !25, null} ; [ DW_TAG_imported_declaration ]
!25 = metadata !{i32 786443, metadata !1, metadata !23, i32 8, i32 17, i32 0, i32 3} ; [ DW_TAG_lexical_block ] [/liveness_analysis/ComplxStruc.c]
!26 = metadata !{i32 9, i32 17, metadata !27, null}
!27 = metadata !{i32 786443, metadata !1, metadata !25, i32 8, i32 24, i32 0, i32 4} ; [ DW_TAG_lexical_block ] [/liveness_analysis/ComplxStruc.c]
!28 = metadata !{i32 10, i32 21, metadata !29, null}
!29 = metadata !{i32 786443, metadata !1, metadata !27, i32 10, i32 21, i32 0, i32 5} ; [ DW_TAG_lexical_block ] [/liveness_analysis/ComplxStruc.c]
!30 = metadata !{i32 11, i32 21, metadata !31, null}
!31 = metadata !{i32 786443, metadata !1, metadata !29, i32 10, i32 28, i32 0, i32 6} ; [ DW_TAG_lexical_block ] [/liveness_analysis/ComplxStruc.c]
!32 = metadata !{i32 13, i32 21, metadata !33, null}
!33 = metadata !{i32 786443, metadata !1, metadata !29, i32 12, i32 24, i32 0, i32 7} ; [ DW_TAG_lexical_block ] [/liveness_analysis/ComplxStruc.c]
!34 = metadata !{i32 16, i32 17, metadata !35, null}
!35 = metadata !{i32 786443, metadata !1, metadata !25, i32 15, i32 20, i32 0, i32 8} ; [ DW_TAG_lexical_block ] [/liveness_analysis/ComplxStruc.c]
!36 = metadata !{i32 19, i32 17, metadata !37, null}
!37 = metadata !{i32 786443, metadata !1, metadata !38, i32 19, i32 17, i32 0, i32 10} ; [ DW_TAG_lexical_block ] [/liveness_analysis/ComplxStruc.c]
!38 = metadata !{i32 786443, metadata !1, metadata !20, i32 18, i32 16, i32 0, i32 9} ; [ DW_TAG_lexical_block ] [/liveness_analysis/ComplxStruc.c]
!39 = metadata !{i32 19, i32 17, metadata !40, null}
!40 = metadata !{i32 786443, metadata !1, metadata !37, i32 19, i32 17, i32 1, i32 20} ; [ DW_TAG_lexical_block ] [/liveness_analysis/ComplxStruc.c]
!41 = metadata !{i32 20, i32 17, metadata !42, null}
!42 = metadata !{i32 786443, metadata !1, metadata !37, i32 19, i32 33, i32 0, i32 11} ; [ DW_TAG_lexical_block ] [/liveness_analysis/ComplxStruc.c]
!43 = metadata !{i32 21, i32 21, metadata !44, null}
!44 = metadata !{i32 786443, metadata !1, metadata !42, i32 21, i32 21, i32 0, i32 12} ; [ DW_TAG_lexical_block ] [/liveness_analysis/ComplxStruc.c]
!45 = metadata !{i32 22, i32 21, metadata !46, null}
!46 = metadata !{i32 786443, metadata !1, metadata !44, i32 21, i32 29, i32 0, i32 13} ; [ DW_TAG_lexical_block ] [/liveness_analysis/ComplxStruc.c]
!47 = metadata !{i32 24, i32 21, metadata !48, null}
!48 = metadata !{i32 786443, metadata !1, metadata !44, i32 23, i32 24, i32 0, i32 14} ; [ DW_TAG_lexical_block ] [/liveness_analysis/ComplxStruc.c]
!49 = metadata !{i32 27, i32 17, metadata !50, null}
!50 = metadata !{i32 786443, metadata !1, metadata !37, i32 26, i32 20, i32 0, i32 15} ; [ DW_TAG_lexical_block ] [/liveness_analysis/ComplxStruc.c]
!51 = metadata !{i32 28, i32 21, metadata !52, null}
!52 = metadata !{i32 786443, metadata !1, metadata !50, i32 28, i32 21, i32 0, i32 16} ; [ DW_TAG_lexical_block ] [/liveness_analysis/ComplxStruc.c]
!53 = metadata !{i32 29, i32 21, metadata !54, null}
!54 = metadata !{i32 786443, metadata !1, metadata !52, i32 28, i32 30, i32 0, i32 17} ; [ DW_TAG_lexical_block ] [/liveness_analysis/ComplxStruc.c]
!55 = metadata !{i32 31, i32 21, metadata !56, null}
!56 = metadata !{i32 786443, metadata !1, metadata !52, i32 30, i32 24, i32 0, i32 18} ; [ DW_TAG_lexical_block ] [/liveness_analysis/ComplxStruc.c]
!57 = metadata !{i32 37, i32 1, metadata !4, null}

