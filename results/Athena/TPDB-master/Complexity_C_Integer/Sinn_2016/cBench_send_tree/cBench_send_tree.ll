; ModuleID = 'cBench_send_tree.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind uwtable
define void @send_tree(i32 %max_code, i32 %max_count, i32 %min_count) #0 {
send_tree_bb0:
  call void @llvm.dbg.value(metadata !{i32 %max_code}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !{i32 %max_count}, i64 0, metadata !14), !dbg !15
  call void @llvm.dbg.value(metadata !{i32 %min_count}, i64 0, metadata !16), !dbg !17
  call void @llvm.dbg.value(metadata !18, i64 0, metadata !19), !dbg !20
  call void @llvm.dbg.value(metadata !18, i64 0, metadata !21), !dbg !22
  call void @llvm.dbg.value(metadata !{i32 %"1"}, i64 0, metadata !19), !dbg !20
  call void @llvm.dbg.value(metadata !{i32 %"11"}, i64 0, metadata !21), !dbg !22
  call void @llvm.dbg.value(metadata !{i32 %"6"}, i64 0, metadata !19), !dbg !20
  call void @llvm.dbg.value(metadata !18, i64 0, metadata !19), !dbg !20
  br label %send_tree_bb1, !dbg !23

send_tree_bb1:                                    ; preds = %send_tree_bb8, %send_tree_bb0
  %count.0 = phi i32 [ 0, %send_tree_bb0 ], [ %count.2, %send_tree_bb8 ]
  %n.0 = phi i32 [ 0, %send_tree_bb0 ], [ %"11", %send_tree_bb8 ]
  %"0" = icmp sle i32 %n.0, %max_code, !dbg !25
  br i1 %"0", label %send_tree_bb2, label %send_tree_bb9, !dbg !25

send_tree_bb2:                                    ; preds = %send_tree_bb1
  %"1" = add nsw i32 %count.0, 1, !dbg !28
  %"2" = icmp slt i32 %"1", %max_count, !dbg !28
  br i1 %"2", label %send_tree_bb3, label %send_tree_bb4, !dbg !28

send_tree_bb3:                                    ; preds = %send_tree_bb2
  %"3" = call i32 (...)* @random(), !dbg !31
  %"4" = icmp ne i32 %"3", 0, !dbg !31
  br i1 %"4", label %send_tree_bb8, label %send_tree_bb4, !dbg !31

send_tree_bb4:                                    ; preds = %send_tree_bb3, %send_tree_bb2
  %"5" = icmp slt i32 %"1", %min_count, !dbg !33
  br i1 %"5", label %send_tree_bb5, label %send_tree_bb6, !dbg !33

send_tree_bb5:                                    ; preds = %send_tree_bb5, %send_tree_bb4
  %count.1 = phi i32 [ %"6", %send_tree_bb5 ], [ %"1", %send_tree_bb4 ]
  %"6" = add nsw i32 %count.1, -1, !dbg !36
  %"7" = icmp sgt i32 %"6", 0, !dbg !36
  br i1 %"7", label %send_tree_bb5, label %send_tree_bb8, !dbg !36

send_tree_bb6:                                    ; preds = %send_tree_bb4
  %"8" = call i32 (...)* @random(), !dbg !40
  %"9" = icmp ne i32 %"8", 0, !dbg !40
  br i1 %"9", label %send_tree_bb7, label %send_tree_bb8, !dbg !40

send_tree_bb7:                                    ; preds = %send_tree_bb6
  %"10" = call i32 (...)* @random(), !dbg !42
  br label %send_tree_bb8, !dbg !45

send_tree_bb8:                                    ; preds = %send_tree_bb3, %send_tree_bb6, %send_tree_bb7, %send_tree_bb5
  %count.2 = phi i32 [ %"1", %send_tree_bb3 ], [ 0, %send_tree_bb6 ], [ 0, %send_tree_bb7 ], [ 0, %send_tree_bb5 ]
  %"11" = add nsw i32 %n.0, 1, !dbg !46
  br label %send_tree_bb1, !dbg !46

send_tree_bb9:                                    ; preds = %send_tree_bb1
  ret void, !dbg !47
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

!0 = metadata !{i32 786449, metadata !1, i32 12, metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)", i1 false, metadata !"", i32 0, metadata !2, metadata !2, metadata !3, metadata !2, metadata !2, metadata !"", i32 1} ; [ DW_TAG_compile_unit ] [/liveness_analysis/cBench_send_tree.c] [DW_LANG_C99]
!1 = metadata !{metadata !"cBench_send_tree.c", metadata !"/liveness_analysis"}
!2 = metadata !{}
!3 = metadata !{metadata !4}
!4 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"send_tree", metadata !"send_tree", metadata !"", i32 6, metadata !6, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (i32, i32, i32)* @send_tree, null, null, metadata !2, i32 7} ; [ DW_TAG_subprogram ] [line 6] [def] [scope 7] [send_tree]
!5 = metadata !{i32 786473, metadata !1}          ; [ DW_TAG_file_type ] [/liveness_analysis/cBench_send_tree.c]
!6 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !7, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!7 = metadata !{null, metadata !8, metadata !8, metadata !8}
!8 = metadata !{i32 786468, null, null, metadata !"int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!9 = metadata !{i32 2, metadata !"Dwarf Version", i32 4}
!10 = metadata !{i32 2, metadata !"Debug Info Version", i32 1}
!11 = metadata !{metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)"}
!12 = metadata !{i32 786689, metadata !4, metadata !"max_code", metadata !5, i32 16777222, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [max_code] [line 6]
!13 = metadata !{i32 6, i32 20, metadata !4, null}
!14 = metadata !{i32 786689, metadata !4, metadata !"max_count", metadata !5, i32 33554438, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [max_count] [line 6]
!15 = metadata !{i32 6, i32 34, metadata !4, null}
!16 = metadata !{i32 786689, metadata !4, metadata !"min_count", metadata !5, i32 50331654, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [min_count] [line 6]
!17 = metadata !{i32 6, i32 49, metadata !4, null}
!18 = metadata !{i32 0}
!19 = metadata !{i32 786688, metadata !4, metadata !"count", metadata !5, i32 9, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [count] [line 9]
!20 = metadata !{i32 9, i32 9, metadata !4, null}
!21 = metadata !{i32 786688, metadata !4, metadata !"n", metadata !5, i32 8, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [n] [line 8]
!22 = metadata !{i32 8, i32 9, metadata !4, null} ; [ DW_TAG_imported_declaration ]
!23 = metadata !{i32 10, i32 10, metadata !24, null}
!24 = metadata !{i32 786443, metadata !1, metadata !4, i32 10, i32 5, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_send_tree.c]
!25 = metadata !{i32 10, i32 10, metadata !26, null}
!26 = metadata !{i32 786443, metadata !1, metadata !27, i32 10, i32 10, i32 2, i32 16} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_send_tree.c]
!27 = metadata !{i32 786443, metadata !1, metadata !24, i32 10, i32 10, i32 1, i32 12} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_send_tree.c]
!28 = metadata !{i32 11, i32 6, metadata !29, null}
!29 = metadata !{i32 786443, metadata !1, metadata !30, i32 11, i32 6, i32 0, i32 2} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_send_tree.c]
!30 = metadata !{i32 786443, metadata !1, metadata !24, i32 10, i32 37, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_send_tree.c]
!31 = metadata !{i32 11, i32 29, metadata !32, null}
!32 = metadata !{i32 786443, metadata !1, metadata !29, i32 11, i32 29, i32 1, i32 13} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_send_tree.c]
!33 = metadata !{i32 14, i32 8, metadata !34, null}
!34 = metadata !{i32 786443, metadata !1, metadata !35, i32 14, i32 8, i32 0, i32 5} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_send_tree.c]
!35 = metadata !{i32 786443, metadata !1, metadata !29, i32 13, i32 9, i32 0, i32 4} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_send_tree.c]
!36 = metadata !{i32 16, i32 6, metadata !37, null}
!37 = metadata !{i32 786443, metadata !1, metadata !38, i32 16, i32 6, i32 1, i32 14} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_send_tree.c]
!38 = metadata !{i32 786443, metadata !1, metadata !39, i32 15, i32 9, i32 0, i32 7} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_send_tree.c]
!39 = metadata !{i32 786443, metadata !1, metadata !34, i32 14, i32 27, i32 0, i32 6} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_send_tree.c]
!40 = metadata !{i32 17, i32 15, metadata !41, null}
!41 = metadata !{i32 786443, metadata !1, metadata !34, i32 17, i32 15, i32 0, i32 8} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_send_tree.c]
!42 = metadata !{i32 18, i32 10, metadata !43, null}
!43 = metadata !{i32 786443, metadata !1, metadata !44, i32 18, i32 10, i32 0, i32 10} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_send_tree.c]
!44 = metadata !{i32 786443, metadata !1, metadata !41, i32 17, i32 25, i32 0, i32 9} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_send_tree.c]
!45 = metadata !{i32 21, i32 4, metadata !44, null}
!46 = metadata !{i32 10, i32 32, metadata !24, null}
!47 = metadata !{i32 25, i32 1, metadata !4, null}

