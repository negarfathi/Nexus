; ModuleID = 'cBench_subsetdump.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind uwtable
define void @subsetdump(i32 %limit) #0 {
subsetdump_bb0:
  call void @llvm.dbg.value(metadata !{i32 %limit}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !14, i64 0, metadata !15), !dbg !16
  call void @llvm.dbg.value(metadata !{i32 %cnum.0}, i64 0, metadata !17), !dbg !18
  call void @llvm.dbg.value(metadata !{i32 %"6"}, i64 0, metadata !15), !dbg !16
  call void @llvm.dbg.value(metadata !{i32 %"11"}, i64 0, metadata !15), !dbg !16
  br label %subsetdump_bb1, !dbg !19

subsetdump_bb1:                                   ; preds = %subsetdump_bb9, %subsetdump_bb0
  %cnum.0 = phi i32 [ 0, %subsetdump_bb0 ], [ %"11", %subsetdump_bb9 ]
  %"0" = icmp slt i32 %cnum.0, %limit, !dbg !21
  br i1 %"0", label %subsetdump_bb2, label %subsetdump_bb10, !dbg !21

subsetdump_bb2:                                   ; preds = %subsetdump_bb1
  %"1" = call i32 (...)* @random(), !dbg !24
  %"2" = icmp ne i32 %"1", 0, !dbg !24
  br i1 %"2", label %subsetdump_bb3, label %subsetdump_bb9, !dbg !24

subsetdump_bb3:                                   ; preds = %subsetdump_bb2, %subsetdump_bb5
  %cnum.1 = phi i32 [ %"6", %subsetdump_bb5 ], [ %cnum.0, %subsetdump_bb2 ]
  %"3" = icmp slt i32 %cnum.1, %limit, !dbg !27
  br i1 %"3", label %subsetdump_bb4, label %subsetdump_bb6, !dbg !27

subsetdump_bb4:                                   ; preds = %subsetdump_bb3
  %"4" = call i32 (...)* @random(), !dbg !32
  %"5" = icmp ne i32 %"4", 0, !dbg !32
  br i1 %"5", label %subsetdump_bb6, label %subsetdump_bb5, !dbg !32

subsetdump_bb5:                                   ; preds = %subsetdump_bb4
  %"6" = add nsw i32 %cnum.1, 1, !dbg !35
  br label %subsetdump_bb3, !dbg !35

subsetdump_bb6:                                   ; preds = %subsetdump_bb4, %subsetdump_bb3
  %"7" = call i32 (...)* @random(), !dbg !36
  %"8" = icmp ne i32 %"7", 0, !dbg !36
  br i1 %"8", label %subsetdump_bb7, label %subsetdump_bb9, !dbg !36

subsetdump_bb7:                                   ; preds = %subsetdump_bb6, %subsetdump_bb8
  %rangestart.0 = phi i32 [ %"10", %subsetdump_bb8 ], [ %cnum.0, %subsetdump_bb6 ]
  %"9" = icmp slt i32 %rangestart.0, %cnum.1, !dbg !38
  br i1 %"9", label %subsetdump_bb8, label %subsetdump_bb9, !dbg !38

subsetdump_bb8:                                   ; preds = %subsetdump_bb7
  %"10" = add nsw i32 %rangestart.0, 1, !dbg !41
  br label %subsetdump_bb7, !dbg !41

subsetdump_bb9:                                   ; preds = %subsetdump_bb2, %subsetdump_bb7, %subsetdump_bb6
  %cnum.2 = phi i32 [ %cnum.0, %subsetdump_bb2 ], [ %cnum.1, %subsetdump_bb7 ], [ %cnum.1, %subsetdump_bb6 ]
  %"11" = add nsw i32 %cnum.2, 1, !dbg !42
  br label %subsetdump_bb1, !dbg !42

subsetdump_bb10:                                  ; preds = %subsetdump_bb1
  ret void, !dbg !43
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

!0 = metadata !{i32 786449, metadata !1, i32 12, metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)", i1 false, metadata !"", i32 0, metadata !2, metadata !2, metadata !3, metadata !2, metadata !2, metadata !"", i32 1} ; [ DW_TAG_compile_unit ] [/liveness_analysis/cBench_subsetdump.c] [DW_LANG_C99]
!1 = metadata !{metadata !"cBench_subsetdump.c", metadata !"/liveness_analysis"}
!2 = metadata !{}
!3 = metadata !{metadata !4}
!4 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"subsetdump", metadata !"subsetdump", metadata !"", i32 6, metadata !6, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (i32)* @subsetdump, null, null, metadata !2, i32 7} ; [ DW_TAG_subprogram ] [line 6] [def] [scope 7] [subsetdump]
!5 = metadata !{i32 786473, metadata !1}          ; [ DW_TAG_file_type ] [/liveness_analysis/cBench_subsetdump.c]
!6 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !7, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!7 = metadata !{null, metadata !8}
!8 = metadata !{i32 786468, null, null, metadata !"int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!9 = metadata !{i32 2, metadata !"Dwarf Version", i32 4}
!10 = metadata !{i32 2, metadata !"Debug Info Version", i32 1}
!11 = metadata !{metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)"}
!12 = metadata !{i32 786689, metadata !4, metadata !"limit", metadata !5, i32 16777222, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [limit] [line 6]
!13 = metadata !{i32 6, i32 21, metadata !4, null}
!14 = metadata !{i32 0}
!15 = metadata !{i32 786688, metadata !4, metadata !"cnum", metadata !5, i32 8, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [cnum] [line 8]
!16 = metadata !{i32 8, i32 9, metadata !4, null} ; [ DW_TAG_imported_declaration ]
!17 = metadata !{i32 786688, metadata !4, metadata !"rangestart", metadata !5, i32 9, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [rangestart] [line 9]
!18 = metadata !{i32 9, i32 9, metadata !4, null}
!19 = metadata !{i32 10, i32 10, metadata !20, null}
!20 = metadata !{i32 786443, metadata !1, metadata !4, i32 10, i32 5, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_subsetdump.c]
!21 = metadata !{i32 10, i32 10, metadata !22, null}
!22 = metadata !{i32 786443, metadata !1, metadata !23, i32 10, i32 10, i32 2, i32 13} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_subsetdump.c]
!23 = metadata !{i32 786443, metadata !1, metadata !20, i32 10, i32 10, i32 1, i32 9} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_subsetdump.c]
!24 = metadata !{i32 11, i32 6, metadata !25, null}
!25 = metadata !{i32 786443, metadata !1, metadata !26, i32 11, i32 6, i32 0, i32 2} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_subsetdump.c]
!26 = metadata !{i32 786443, metadata !1, metadata !20, i32 10, i32 42, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_subsetdump.c]
!27 = metadata !{i32 12, i32 11, metadata !28, null}
!28 = metadata !{i32 786443, metadata !1, metadata !29, i32 12, i32 11, i32 2, i32 11} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_subsetdump.c]
!29 = metadata !{i32 786443, metadata !1, metadata !30, i32 12, i32 11, i32 1, i32 10} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_subsetdump.c]
!30 = metadata !{i32 786443, metadata !1, metadata !31, i32 12, i32 6, i32 0, i32 4} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_subsetdump.c]
!31 = metadata !{i32 786443, metadata !1, metadata !25, i32 11, i32 16, i32 0, i32 3} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_subsetdump.c]
!32 = metadata !{i32 13, i32 7, metadata !33, null}
!33 = metadata !{i32 786443, metadata !1, metadata !34, i32 13, i32 7, i32 0, i32 6} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_subsetdump.c]
!34 = metadata !{i32 786443, metadata !1, metadata !30, i32 12, i32 52, i32 0, i32 5} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_subsetdump.c]
!35 = metadata !{i32 12, i32 44, metadata !30, null}
!36 = metadata !{i32 16, i32 10, metadata !37, null}
!37 = metadata !{i32 786443, metadata !1, metadata !31, i32 16, i32 10, i32 0, i32 7} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_subsetdump.c]
!38 = metadata !{i32 17, i32 3, metadata !39, null}
!39 = metadata !{i32 786443, metadata !1, metadata !40, i32 17, i32 3, i32 1, i32 12} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_subsetdump.c]
!40 = metadata !{i32 786443, metadata !1, metadata !37, i32 16, i32 20, i32 0, i32 8} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_subsetdump.c]
!41 = metadata !{i32 18, i32 7, metadata !40, null}
!42 = metadata !{i32 10, i32 34, metadata !20, null}
!43 = metadata !{i32 22, i32 1, metadata !4, null}

