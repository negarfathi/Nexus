; ModuleID = 'nestedLoop.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind uwtable
define void @nestedLoop(i32 %n, i32 %m, i32 %N) #0 {
nestedLoop_bb0:
  call void @llvm.dbg.value(metadata !{i32 %n}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !{i32 %m}, i64 0, metadata !14), !dbg !15
  call void @llvm.dbg.value(metadata !{i32 %N}, i64 0, metadata !16), !dbg !17
  %"0" = icmp sle i32 0, %n, !dbg !18
  %"1" = icmp sle i32 0, %m, !dbg !20
  %or.cond = and i1 %"0", %"1", !dbg !18
  %"2" = icmp sle i32 0, %N, !dbg !22
  %or.cond1 = and i1 %or.cond, %"2", !dbg !18
  br i1 %or.cond1, label %nestedLoop_bb1, label %nestedLoop_bb7, !dbg !18

nestedLoop_bb1:                                   ; preds = %nestedLoop_bb0, %nestedLoop_bb6
  %i.0 = phi i32 [ %"14", %nestedLoop_bb6 ], [ 0, %nestedLoop_bb0 ]
  %"3" = call i32 (...)* @nondet(), !dbg !24
  %"4" = icmp sgt i32 %"3", 0, !dbg !24
  %"5" = icmp slt i32 %i.0, %n, !dbg !27
  %. = select i1 %"4", i1 %"5", i1 false, !dbg !24
  br i1 %., label %nestedLoop_bb2, label %nestedLoop_bb7, !dbg !29

nestedLoop_bb2:                                   ; preds = %nestedLoop_bb4, %nestedLoop_bb1
  %j.0 = phi i32 [ 0, %nestedLoop_bb1 ], [ %"9", %nestedLoop_bb4 ]
  %i.1 = phi i32 [ %i.0, %nestedLoop_bb1 ], [ %k.0, %nestedLoop_bb4 ]
  %"6" = call i32 (...)* @nondet(), !dbg !31
  %"7" = icmp sgt i32 %"6", 0, !dbg !31
  %"8" = icmp slt i32 %j.0, %m, !dbg !34
  %.2 = select i1 %"7", i1 %"8", i1 false, !dbg !31
  br i1 %.2, label %nestedLoop_bb3, label %nestedLoop_bb6, !dbg !36

nestedLoop_bb3:                                   ; preds = %nestedLoop_bb2
  %"9" = add nsw i32 %j.0, 1, !dbg !38
  br label %nestedLoop_bb4, !dbg !40

nestedLoop_bb4:                                   ; preds = %nestedLoop_bb5, %nestedLoop_bb3
  %k.0 = phi i32 [ %i.1, %nestedLoop_bb3 ], [ %"13", %nestedLoop_bb5 ]
  %"10" = call i32 (...)* @nondet(), !dbg !41
  %"11" = icmp sgt i32 %"10", 0, !dbg !41
  %"12" = icmp slt i32 %k.0, %N, !dbg !43
  %.3 = select i1 %"11", i1 %"12", i1 false, !dbg !41
  br i1 %.3, label %nestedLoop_bb5, label %nestedLoop_bb2, !dbg !45

nestedLoop_bb5:                                   ; preds = %nestedLoop_bb4
  %"13" = add nsw i32 %k.0, 1, !dbg !47
  br label %nestedLoop_bb4, !dbg !47

nestedLoop_bb6:                                   ; preds = %nestedLoop_bb2
  %"14" = add nsw i32 %i.1, 1, !dbg !48
  call void @llvm.dbg.value(metadata !{i32 %"14"}, i64 0, metadata !49), !dbg !50
  br label %nestedLoop_bb1, !dbg !51

nestedLoop_bb7:                                   ; preds = %nestedLoop_bb1, %nestedLoop_bb0
  ret void, !dbg !52
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

!0 = metadata !{i32 786449, metadata !1, i32 12, metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)", i1 false, metadata !"", i32 0, metadata !2, metadata !2, metadata !3, metadata !2, metadata !2, metadata !"", i32 1} ; [ DW_TAG_compile_unit ] [/liveness_analysis/nestedLoop.c] [DW_LANG_C99]
!1 = metadata !{metadata !"nestedLoop.c", metadata !"/liveness_analysis"}
!2 = metadata !{}
!3 = metadata !{metadata !4}
!4 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"nestedLoop", metadata !"nestedLoop", metadata !"", i32 3, metadata !6, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (i32, i32, i32)* @nestedLoop, null, null, metadata !2, i32 3} ; [ DW_TAG_subprogram ] [line 3] [def] [nestedLoop]
!5 = metadata !{i32 786473, metadata !1}          ; [ DW_TAG_file_type ] [/liveness_analysis/nestedLoop.c]
!6 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !7, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!7 = metadata !{null, metadata !8, metadata !8, metadata !8}
!8 = metadata !{i32 786468, null, null, metadata !"int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!9 = metadata !{i32 2, metadata !"Dwarf Version", i32 4}
!10 = metadata !{i32 2, metadata !"Debug Info Version", i32 1}
!11 = metadata !{metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)"}
!12 = metadata !{i32 786689, metadata !4, metadata !"n", metadata !5, i32 16777219, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [n] [line 3]
!13 = metadata !{i32 3, i32 21, metadata !4, null}
!14 = metadata !{i32 786689, metadata !4, metadata !"m", metadata !5, i32 33554435, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [m] [line 3]
!15 = metadata !{i32 3, i32 28, metadata !4, null}
!16 = metadata !{i32 786689, metadata !4, metadata !"N", metadata !5, i32 50331651, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [N] [line 3]
!17 = metadata !{i32 3, i32 35, metadata !4, null}
!18 = metadata !{i32 5, i32 6, metadata !19, null}
!19 = metadata !{i32 786443, metadata !1, metadata !4, i32 5, i32 6, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/liveness_analysis/nestedLoop.c]
!20 = metadata !{i32 5, i32 6, metadata !21, null}
!21 = metadata !{i32 786443, metadata !1, metadata !19, i32 5, i32 6, i32 1, i32 4} ; [ DW_TAG_lexical_block ] [/liveness_analysis/nestedLoop.c]
!22 = metadata !{i32 5, i32 6, metadata !23, null}
!23 = metadata !{i32 786443, metadata !1, metadata !19, i32 5, i32 6, i32 2, i32 5} ; [ DW_TAG_lexical_block ] [/liveness_analysis/nestedLoop.c]
!24 = metadata !{i32 7, i32 11, metadata !25, null}
!25 = metadata !{i32 786443, metadata !1, metadata !26, i32 7, i32 11, i32 1, i32 6} ; [ DW_TAG_lexical_block ] [/liveness_analysis/nestedLoop.c]
!26 = metadata !{i32 786443, metadata !1, metadata !19, i32 5, i32 27, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/liveness_analysis/nestedLoop.c]
!27 = metadata !{i32 7, i32 11, metadata !28, null}
!28 = metadata !{i32 786443, metadata !1, metadata !26, i32 7, i32 11, i32 2, i32 7} ; [ DW_TAG_lexical_block ] [/liveness_analysis/nestedLoop.c]
!29 = metadata !{i32 7, i32 11, metadata !30, null}
!30 = metadata !{i32 786443, metadata !1, metadata !26, i32 7, i32 11, i32 3, i32 8} ; [ DW_TAG_lexical_block ] [/liveness_analysis/nestedLoop.c]
!31 = metadata !{i32 9, i32 13, metadata !32, null}
!32 = metadata !{i32 786443, metadata !1, metadata !33, i32 9, i32 13, i32 1, i32 9} ; [ DW_TAG_lexical_block ] [/liveness_analysis/nestedLoop.c]
!33 = metadata !{i32 786443, metadata !1, metadata !26, i32 7, i32 29, i32 0, i32 2} ; [ DW_TAG_lexical_block ] [/liveness_analysis/nestedLoop.c]
!34 = metadata !{i32 9, i32 13, metadata !35, null}
!35 = metadata !{i32 786443, metadata !1, metadata !33, i32 9, i32 13, i32 2, i32 10} ; [ DW_TAG_lexical_block ] [/liveness_analysis/nestedLoop.c]
!36 = metadata !{i32 9, i32 13, metadata !37, null}
!37 = metadata !{i32 786443, metadata !1, metadata !33, i32 9, i32 13, i32 3, i32 11} ; [ DW_TAG_lexical_block ] [/liveness_analysis/nestedLoop.c]
!38 = metadata !{i32 10, i32 9, metadata !39, null}
!39 = metadata !{i32 786443, metadata !1, metadata !33, i32 9, i32 32, i32 0, i32 3} ; [ DW_TAG_lexical_block ] [/liveness_analysis/nestedLoop.c]
!40 = metadata !{i32 12, i32 9, metadata !39, null}
!41 = metadata !{i32 12, i32 15, metadata !42, null}
!42 = metadata !{i32 786443, metadata !1, metadata !39, i32 12, i32 15, i32 1, i32 12} ; [ DW_TAG_lexical_block ] [/liveness_analysis/nestedLoop.c]
!43 = metadata !{i32 12, i32 15, metadata !44, null}
!44 = metadata !{i32 786443, metadata !1, metadata !39, i32 12, i32 15, i32 2, i32 13} ; [ DW_TAG_lexical_block ] [/liveness_analysis/nestedLoop.c]
!45 = metadata !{i32 12, i32 15, metadata !46, null}
!46 = metadata !{i32 786443, metadata !1, metadata !39, i32 12, i32 15, i32 3, i32 14} ; [ DW_TAG_lexical_block ] [/liveness_analysis/nestedLoop.c]
!47 = metadata !{i32 13, i32 11, metadata !39, null}
!48 = metadata !{i32 16, i32 7, metadata !33, null}
!49 = metadata !{i32 786688, metadata !4, metadata !"i", metadata !5, i32 4, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [i] [line 4]
!50 = metadata !{i32 4, i32 7, metadata !4, null}
!51 = metadata !{i32 17, i32 5, metadata !33, null}
!52 = metadata !{i32 19, i32 1, metadata !4, null}

