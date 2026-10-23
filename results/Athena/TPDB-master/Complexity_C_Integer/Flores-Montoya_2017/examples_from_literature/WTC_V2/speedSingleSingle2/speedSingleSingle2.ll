; ModuleID = 'speedSingleSingle2.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind uwtable
define i32 @speedSingleSingle2(i32 %n, i32 %m) #0 {
speedSingleSingle2_bb0:
  call void @llvm.dbg.value(metadata !{i32 %n}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !{i32 %m}, i64 0, metadata !14), !dbg !15
  %"0" = icmp slt i32 %n, 0, !dbg !16
  %"1" = icmp slt i32 %m, 0, !dbg !18
  %or.cond = or i1 %"0", %"1", !dbg !16
  br i1 %or.cond, label %speedSingleSingle2_bb6, label %speedSingleSingle2_bb1, !dbg !16

speedSingleSingle2_bb1:                           ; preds = %speedSingleSingle2_bb3, %speedSingleSingle2_bb5, %speedSingleSingle2_bb0
  %y.0 = phi i32 [ 0, %speedSingleSingle2_bb0 ], [ %"6", %speedSingleSingle2_bb3 ], [ %"9", %speedSingleSingle2_bb5 ]
  %x.0 = phi i32 [ 0, %speedSingleSingle2_bb0 ], [ %"5", %speedSingleSingle2_bb3 ], [ %"8", %speedSingleSingle2_bb5 ]
  %"2" = call i32 (...)* @nondet(), !dbg !20
  %"3" = icmp sgt i32 %"2", 0, !dbg !20
  br i1 %"3", label %speedSingleSingle2_bb2, label %speedSingleSingle2_bb6, !dbg !20

speedSingleSingle2_bb2:                           ; preds = %speedSingleSingle2_bb1
  %"4" = icmp slt i32 %x.0, %n, !dbg !22
  br i1 %"4", label %speedSingleSingle2_bb3, label %speedSingleSingle2_bb4, !dbg !22

speedSingleSingle2_bb3:                           ; preds = %speedSingleSingle2_bb2
  %"5" = add nsw i32 %x.0, 1, !dbg !25
  %"6" = add nsw i32 %y.0, 1, !dbg !28
  br label %speedSingleSingle2_bb1, !dbg !29

speedSingleSingle2_bb4:                           ; preds = %speedSingleSingle2_bb2
  %"7" = icmp slt i32 %y.0, %m, !dbg !30
  br i1 %"7", label %speedSingleSingle2_bb5, label %speedSingleSingle2_bb6, !dbg !30

speedSingleSingle2_bb5:                           ; preds = %speedSingleSingle2_bb4
  %"8" = add nsw i32 %x.0, 1, !dbg !32
  %"9" = add nsw i32 %y.0, 1, !dbg !35
  br label %speedSingleSingle2_bb1

speedSingleSingle2_bb6:                           ; preds = %speedSingleSingle2_bb1, %speedSingleSingle2_bb4, %speedSingleSingle2_bb0
  ret i32 0, !dbg !36
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

!0 = metadata !{i32 786449, metadata !1, i32 12, metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)", i1 false, metadata !"", i32 0, metadata !2, metadata !2, metadata !3, metadata !2, metadata !2, metadata !"", i32 1} ; [ DW_TAG_compile_unit ] [/liveness_analysis/speedSingleSingle2.c] [DW_LANG_C99]
!1 = metadata !{metadata !"speedSingleSingle2.c", metadata !"/liveness_analysis"}
!2 = metadata !{}
!3 = metadata !{metadata !4}
!4 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"speedSingleSingle2", metadata !"speedSingleSingle2", metadata !"", i32 3, metadata !6, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, i32 (i32, i32)* @speedSingleSingle2, null, null, metadata !2, i32 4} ; [ DW_TAG_subprogram ] [line 3] [def] [scope 4] [speedSingleSingle2]
!5 = metadata !{i32 786473, metadata !1}          ; [ DW_TAG_file_type ] [/liveness_analysis/speedSingleSingle2.c]
!6 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !7, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!7 = metadata !{metadata !8, metadata !8, metadata !8}
!8 = metadata !{i32 786468, null, null, metadata !"int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!9 = metadata !{i32 2, metadata !"Dwarf Version", i32 4}
!10 = metadata !{i32 2, metadata !"Debug Info Version", i32 1}
!11 = metadata !{metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)"}
!12 = metadata !{i32 786689, metadata !4, metadata !"n", metadata !5, i32 16777219, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [n] [line 3]
!13 = metadata !{i32 3, i32 28, metadata !4, null}
!14 = metadata !{i32 786689, metadata !4, metadata !"m", metadata !5, i32 33554435, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [m] [line 3]
!15 = metadata !{i32 3, i32 34, metadata !4, null}
!16 = metadata !{i32 6, i32 6, metadata !17, null}
!17 = metadata !{i32 786443, metadata !1, metadata !4, i32 6, i32 6, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/liveness_analysis/speedSingleSingle2.c]
!18 = metadata !{i32 6, i32 6, metadata !19, null}
!19 = metadata !{i32 786443, metadata !1, metadata !17, i32 6, i32 6, i32 2, i32 7} ; [ DW_TAG_lexical_block ] [/liveness_analysis/speedSingleSingle2.c]
!20 = metadata !{i32 8, i32 10, metadata !21, null} ; [ DW_TAG_imported_declaration ]
!21 = metadata !{i32 786443, metadata !1, metadata !4, i32 8, i32 10, i32 1, i32 9} ; [ DW_TAG_lexical_block ] [/liveness_analysis/speedSingleSingle2.c]
!22 = metadata !{i32 10, i32 11, metadata !23, null}
!23 = metadata !{i32 786443, metadata !1, metadata !24, i32 10, i32 11, i32 0, i32 2} ; [ DW_TAG_lexical_block ] [/liveness_analysis/speedSingleSingle2.c]
!24 = metadata !{i32 786443, metadata !1, metadata !4, i32 9, i32 5, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/liveness_analysis/speedSingleSingle2.c]
!25 = metadata !{i32 10, i32 17, metadata !26, null}
!26 = metadata !{i32 786443, metadata !1, metadata !27, i32 10, i32 17, i32 1, i32 10} ; [ DW_TAG_lexical_block ] [/liveness_analysis/speedSingleSingle2.c]
!27 = metadata !{i32 786443, metadata !1, metadata !23, i32 10, i32 16, i32 0, i32 3} ; [ DW_TAG_lexical_block ] [/liveness_analysis/speedSingleSingle2.c]
!28 = metadata !{i32 10, i32 21, metadata !27, null}
!29 = metadata !{i32 10, i32 25, metadata !27, null}
!30 = metadata !{i32 11, i32 16, metadata !31, null}
!31 = metadata !{i32 786443, metadata !1, metadata !23, i32 11, i32 16, i32 0, i32 4} ; [ DW_TAG_lexical_block ] [/liveness_analysis/speedSingleSingle2.c]
!32 = metadata !{i32 11, i32 22, metadata !33, null}
!33 = metadata !{i32 786443, metadata !1, metadata !34, i32 11, i32 22, i32 1, i32 11} ; [ DW_TAG_lexical_block ] [/liveness_analysis/speedSingleSingle2.c]
!34 = metadata !{i32 786443, metadata !1, metadata !31, i32 11, i32 21, i32 0, i32 5} ; [ DW_TAG_lexical_block ] [/liveness_analysis/speedSingleSingle2.c]
!35 = metadata !{i32 11, i32 26, metadata !34, null}
!36 = metadata !{i32 15, i32 1, metadata !4, null}

