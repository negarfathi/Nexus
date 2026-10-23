; ModuleID = 'cBench_s_SFD_process.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind uwtable
define void @s_SFD_process(i32 %p, i32 %rlimit, i32 %match) #0 {
s_SFD_process_bb0:
  call void @llvm.dbg.value(metadata !{i32 %p}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !{i32 %rlimit}, i64 0, metadata !14), !dbg !15
  call void @llvm.dbg.value(metadata !{i32 %match}, i64 0, metadata !16), !dbg !17
  call void @llvm.dbg.value(metadata !{i32 %"1"}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !{i32 %"4"}, i64 0, metadata !16), !dbg !17
  call void @llvm.dbg.value(metadata !18, i64 0, metadata !16), !dbg !17
  call void @llvm.dbg.value(metadata !{i32 %"9"}, i64 0, metadata !16), !dbg !17
  br label %s_SFD_process_bb1, !dbg !19

s_SFD_process_bb1:                                ; preds = %s_SFD_process_bb4, %s_SFD_process_bb7, %s_SFD_process_bb3, %s_SFD_process_bb0
  %.01 = phi i32 [ %match, %s_SFD_process_bb0 ], [ %., %s_SFD_process_bb3 ], [ %.3, %s_SFD_process_bb7 ], [ %.01, %s_SFD_process_bb4 ]
  %.0 = phi i32 [ %p, %s_SFD_process_bb0 ], [ %"1", %s_SFD_process_bb3 ], [ %"12", %s_SFD_process_bb7 ], [ %"1", %s_SFD_process_bb4 ]
  %"0" = icmp slt i32 %.0, %rlimit, !dbg !20
  br i1 %"0", label %s_SFD_process_bb2, label %s_SFD_process_bb8, !dbg !20

s_SFD_process_bb2:                                ; preds = %s_SFD_process_bb1
  %"1" = add nsw i32 %.0, 1, !dbg !22
  %"2" = call i32 (...)* @nondet(), !dbg !24
  %"3" = icmp ne i32 %"2", 0, !dbg !24
  br i1 %"3", label %s_SFD_process_bb3, label %s_SFD_process_bb4, !dbg !24

s_SFD_process_bb3:                                ; preds = %s_SFD_process_bb2
  %"4" = add nsw i32 %.01, 1, !dbg !26
  %"5" = call i32 (...)* @nondet(), !dbg !28
  %"6" = icmp ne i32 %"5", 0, !dbg !28
  %. = select i1 %"6", i32 0, i32 %"4", !dbg !28
  br label %s_SFD_process_bb1, !dbg !30

s_SFD_process_bb4:                                ; preds = %s_SFD_process_bb2
  %"7" = icmp sgt i32 %.01, 0, !dbg !31
  br i1 %"7", label %s_SFD_process_bb5, label %s_SFD_process_bb1, !dbg !31

s_SFD_process_bb5:                                ; preds = %s_SFD_process_bb6, %s_SFD_process_bb4
  %.2 = phi i32 [ %.01, %s_SFD_process_bb4 ], [ %"9", %s_SFD_process_bb6 ]
  %"8" = icmp sgt i32 %.2, 0, !dbg !33
  br i1 %"8", label %s_SFD_process_bb6, label %s_SFD_process_bb7, !dbg !33

s_SFD_process_bb6:                                ; preds = %s_SFD_process_bb5
  %"9" = add nsw i32 %.2, -1, !dbg !36
  %"10" = call i32 (...)* @nondet(), !dbg !38
  %"11" = icmp ne i32 %"10", 0, !dbg !38
  br i1 %"11", label %s_SFD_process_bb7, label %s_SFD_process_bb5, !dbg !38

s_SFD_process_bb7:                                ; preds = %s_SFD_process_bb6, %s_SFD_process_bb5
  %.3 = phi i32 [ %.2, %s_SFD_process_bb5 ], [ %"9", %s_SFD_process_bb6 ]
  %"12" = add nsw i32 %"1", -1, !dbg !40
  call void @llvm.dbg.value(metadata !{i32 %"12"}, i64 0, metadata !12), !dbg !13
  br label %s_SFD_process_bb1, !dbg !41

s_SFD_process_bb8:                                ; preds = %s_SFD_process_bb1
  ret void, !dbg !42
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

!0 = metadata !{i32 786449, metadata !1, i32 12, metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)", i1 false, metadata !"", i32 0, metadata !2, metadata !2, metadata !3, metadata !2, metadata !2, metadata !"", i32 1} ; [ DW_TAG_compile_unit ] [/liveness_analysis/cBench_s_SFD_process.c] [DW_LANG_C99]
!1 = metadata !{metadata !"cBench_s_SFD_process.c", metadata !"/liveness_analysis"}
!2 = metadata !{}
!3 = metadata !{metadata !4}
!4 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"s_SFD_process", metadata !"s_SFD_process", metadata !"", i32 6, metadata !6, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (i32, i32, i32)* @s_SFD_process, null, null, metadata !2, i32 6} ; [ DW_TAG_subprogram ] [line 6] [def] [s_SFD_process]
!5 = metadata !{i32 786473, metadata !1}          ; [ DW_TAG_file_type ] [/liveness_analysis/cBench_s_SFD_process.c]
!6 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !7, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!7 = metadata !{null, metadata !8, metadata !8, metadata !8}
!8 = metadata !{i32 786468, null, null, metadata !"int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!9 = metadata !{i32 2, metadata !"Dwarf Version", i32 4}
!10 = metadata !{i32 2, metadata !"Debug Info Version", i32 1}
!11 = metadata !{metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)"}
!12 = metadata !{i32 786689, metadata !4, metadata !"p", metadata !5, i32 16777222, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [p] [line 6]
!13 = metadata !{i32 6, i32 24, metadata !4, null}
!14 = metadata !{i32 786689, metadata !4, metadata !"rlimit", metadata !5, i32 33554438, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [rlimit] [line 6]
!15 = metadata !{i32 6, i32 31, metadata !4, null}
!16 = metadata !{i32 786689, metadata !4, metadata !"match", metadata !5, i32 50331654, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [match] [line 6]
!17 = metadata !{i32 6, i32 43, metadata !4, null}
!18 = metadata !{i32 0}
!19 = metadata !{i32 7, i32 2, metadata !4, null}
!20 = metadata !{i32 7, i32 2, metadata !21, null}
!21 = metadata !{i32 786443, metadata !1, metadata !4, i32 7, i32 2, i32 1, i32 9} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_s_SFD_process.c]
!22 = metadata !{i32 8, i32 3, metadata !23, null} ; [ DW_TAG_imported_declaration ]
!23 = metadata !{i32 786443, metadata !1, metadata !4, i32 7, i32 21, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_s_SFD_process.c]
!24 = metadata !{i32 9, i32 7, metadata !25, null}
!25 = metadata !{i32 786443, metadata !1, metadata !23, i32 9, i32 7, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_s_SFD_process.c]
!26 = metadata !{i32 10, i32 4, metadata !27, null}
!27 = metadata !{i32 786443, metadata !1, metadata !25, i32 9, i32 17, i32 0, i32 2} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_s_SFD_process.c]
!28 = metadata !{i32 11, i32 8, metadata !29, null}
!29 = metadata !{i32 786443, metadata !1, metadata !27, i32 11, i32 8, i32 0, i32 3} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_s_SFD_process.c]
!30 = metadata !{i32 14, i32 4, metadata !27, null}
!31 = metadata !{i32 19, i32 7, metadata !32, null}
!32 = metadata !{i32 786443, metadata !1, metadata !23, i32 19, i32 7, i32 0, i32 5} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_s_SFD_process.c]
!33 = metadata !{i32 20, i32 4, metadata !34, null}
!34 = metadata !{i32 786443, metadata !1, metadata !35, i32 20, i32 4, i32 1, i32 10} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_s_SFD_process.c]
!35 = metadata !{i32 786443, metadata !1, metadata !32, i32 19, i32 18, i32 0, i32 6} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_s_SFD_process.c]
!36 = metadata !{i32 21, i32 5, metadata !37, null}
!37 = metadata !{i32 786443, metadata !1, metadata !35, i32 20, i32 22, i32 0, i32 7} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_s_SFD_process.c]
!38 = metadata !{i32 22, i32 10, metadata !39, null}
!39 = metadata !{i32 786443, metadata !1, metadata !37, i32 22, i32 10, i32 0, i32 8} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_s_SFD_process.c]
!40 = metadata !{i32 25, i32 4, metadata !35, null}
!41 = metadata !{i32 26, i32 3, metadata !35, null}
!42 = metadata !{i32 28, i32 1, metadata !4, null}

