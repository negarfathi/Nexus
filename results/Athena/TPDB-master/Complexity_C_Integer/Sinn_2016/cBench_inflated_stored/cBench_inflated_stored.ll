; ModuleID = 'cBench_inflated_stored.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind uwtable
define void @inflate_stored(i32 %n, i32 %k, i32 %limit) #0 {
inflate_stored_bb0:
  call void @llvm.dbg.value(metadata !{i32 %n}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !{i32 %k}, i64 0, metadata !14), !dbg !15
  call void @llvm.dbg.value(metadata !{i32 %limit}, i64 0, metadata !16), !dbg !17
  %"0" = sub nsw i32 %k, %n, !dbg !18
  call void @llvm.dbg.value(metadata !{i32 %"0"}, i64 0, metadata !14), !dbg !15
  call void @llvm.dbg.value(metadata !{i32 %"2"}, i64 0, metadata !14), !dbg !15
  br label %inflate_stored_bb1, !dbg !19

inflate_stored_bb1:                               ; preds = %inflate_stored_bb2, %inflate_stored_bb0
  %.01 = phi i32 [ %"0", %inflate_stored_bb0 ], [ %"2", %inflate_stored_bb2 ]
  %"1" = icmp slt i32 %.01, 16, !dbg !20
  br i1 %"1", label %inflate_stored_bb2, label %inflate_stored_bb3, !dbg !20

inflate_stored_bb2:                               ; preds = %inflate_stored_bb1
  %"2" = add nsw i32 %.01, 8, !dbg !22
  br label %inflate_stored_bb1, !dbg !24

inflate_stored_bb3:                               ; preds = %inflate_stored_bb1
  %"3" = sub nsw i32 %.01, 16, !dbg !25
  call void @llvm.dbg.value(metadata !{i32 %"3"}, i64 0, metadata !14), !dbg !15
  call void @llvm.dbg.value(metadata !{i32 %"5"}, i64 0, metadata !14), !dbg !15
  br label %inflate_stored_bb4, !dbg !26

inflate_stored_bb4:                               ; preds = %inflate_stored_bb5, %inflate_stored_bb3
  %.1 = phi i32 [ %"3", %inflate_stored_bb3 ], [ %"5", %inflate_stored_bb5 ]
  %"4" = icmp slt i32 %.1, 16, !dbg !28
  br i1 %"4", label %inflate_stored_bb5, label %inflate_stored_bb6, !dbg !28

inflate_stored_bb5:                               ; preds = %inflate_stored_bb4
  %"5" = add nsw i32 %.1, 8, !dbg !30
  br label %inflate_stored_bb4, !dbg !32

inflate_stored_bb6:                               ; preds = %inflate_stored_bb4
  %"6" = call i32 (...)* @random(), !dbg !33
  %"7" = icmp ne i32 %"6", 0, !dbg !33
  br i1 %"7", label %inflate_stored_bb12, label %inflate_stored_bb7, !dbg !33

inflate_stored_bb7:                               ; preds = %inflate_stored_bb6
  %"8" = sub nsw i32 %.1, 16, !dbg !35
  call void @llvm.dbg.value(metadata !{i32 %"8"}, i64 0, metadata !14), !dbg !15
  call void @llvm.dbg.value(metadata !{i32 %"9"}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !{i32 %"12"}, i64 0, metadata !14), !dbg !15
  br label %inflate_stored_bb8, !dbg !37

inflate_stored_bb8:                               ; preds = %inflate_stored_bb11, %inflate_stored_bb7
  %.2 = phi i32 [ %"8", %inflate_stored_bb7 ], [ %"13", %inflate_stored_bb11 ]
  %.0 = phi i32 [ %n, %inflate_stored_bb7 ], [ %"9", %inflate_stored_bb11 ]
  %"9" = add nsw i32 %.0, -1, !dbg !38
  %"10" = icmp sgt i32 %.0, 0, !dbg !38
  br i1 %"10", label %inflate_stored_bb9, label %inflate_stored_bb12, !dbg !38

inflate_stored_bb9:                               ; preds = %inflate_stored_bb8, %inflate_stored_bb10
  %.3 = phi i32 [ %"12", %inflate_stored_bb10 ], [ %.2, %inflate_stored_bb8 ]
  %"11" = icmp slt i32 %.3, %limit, !dbg !40
  br i1 %"11", label %inflate_stored_bb10, label %inflate_stored_bb11, !dbg !40

inflate_stored_bb10:                              ; preds = %inflate_stored_bb9
  %"12" = add nsw i32 %.3, 8, !dbg !44
  br label %inflate_stored_bb9, !dbg !46

inflate_stored_bb11:                              ; preds = %inflate_stored_bb9
  %"13" = sub nsw i32 %.3, 8, !dbg !47
  call void @llvm.dbg.value(metadata !{i32 %"13"}, i64 0, metadata !14), !dbg !15
  br label %inflate_stored_bb8, !dbg !49

inflate_stored_bb12:                              ; preds = %inflate_stored_bb8, %inflate_stored_bb6
  ret void, !dbg !50
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

!0 = metadata !{i32 786449, metadata !1, i32 12, metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)", i1 false, metadata !"", i32 0, metadata !2, metadata !2, metadata !3, metadata !2, metadata !2, metadata !"", i32 1} ; [ DW_TAG_compile_unit ] [/liveness_analysis/cBench_inflated_stored.c] [DW_LANG_C99]
!1 = metadata !{metadata !"cBench_inflated_stored.c", metadata !"/liveness_analysis"}
!2 = metadata !{}
!3 = metadata !{metadata !4}
!4 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"inflate_stored", metadata !"inflate_stored", metadata !"", i32 7, metadata !6, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (i32, i32, i32)* @inflate_stored, null, null, metadata !2, i32 8} ; [ DW_TAG_subprogram ] [line 7] [def] [scope 8] [inflate_stored]
!5 = metadata !{i32 786473, metadata !1}          ; [ DW_TAG_file_type ] [/liveness_analysis/cBench_inflated_stored.c]
!6 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !7, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!7 = metadata !{null, metadata !8, metadata !8, metadata !8}
!8 = metadata !{i32 786468, null, null, metadata !"int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!9 = metadata !{i32 2, metadata !"Dwarf Version", i32 4}
!10 = metadata !{i32 2, metadata !"Debug Info Version", i32 1}
!11 = metadata !{metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)"}
!12 = metadata !{i32 786689, metadata !4, metadata !"n", metadata !5, i32 16777223, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [n] [line 7]
!13 = metadata !{i32 7, i32 25, metadata !4, null}
!14 = metadata !{i32 786689, metadata !4, metadata !"k", metadata !5, i32 33554439, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [k] [line 7]
!15 = metadata !{i32 7, i32 32, metadata !4, null}
!16 = metadata !{i32 786689, metadata !4, metadata !"limit", metadata !5, i32 50331655, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [limit] [line 7]
!17 = metadata !{i32 7, i32 39, metadata !4, null}
!18 = metadata !{i32 18, i32 2, metadata !4, null}
!19 = metadata !{i32 20, i32 2, metadata !4, null}
!20 = metadata !{i32 20, i32 2, metadata !21, null}
!21 = metadata !{i32 786443, metadata !1, metadata !4, i32 20, i32 2, i32 1, i32 9} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_inflated_stored.c]
!22 = metadata !{i32 24, i32 6, metadata !23, null}
!23 = metadata !{i32 786443, metadata !1, metadata !4, i32 20, i32 19, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_inflated_stored.c]
!24 = metadata !{i32 25, i32 2, metadata !23, null}
!25 = metadata !{i32 29, i32 2, metadata !4, null}
!26 = metadata !{i32 32, i32 2, metadata !27, null}
!27 = metadata !{i32 786443, metadata !1, metadata !4, i32 31, i32 5, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_inflated_stored.c]
!28 = metadata !{i32 32, i32 2, metadata !29, null}
!29 = metadata !{i32 786443, metadata !1, metadata !27, i32 32, i32 2, i32 1, i32 10} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_inflated_stored.c]
!30 = metadata !{i32 36, i32 6, metadata !31, null}
!31 = metadata !{i32 786443, metadata !1, metadata !27, i32 32, i32 19, i32 0, i32 2} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_inflated_stored.c]
!32 = metadata !{i32 37, i32 2, metadata !31, null}
!33 = metadata !{i32 39, i32 9, metadata !34, null}
!34 = metadata !{i32 786443, metadata !1, metadata !4, i32 39, i32 9, i32 0, i32 3} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_inflated_stored.c]
!35 = metadata !{i32 43, i32 7, metadata !36, null}
!36 = metadata !{i32 786443, metadata !1, metadata !4, i32 41, i32 5, i32 0, i32 4} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_inflated_stored.c]
!37 = metadata !{i32 45, i32 2, metadata !4, null}
!38 = metadata !{i32 45, i32 2, metadata !39, null}
!39 = metadata !{i32 786443, metadata !1, metadata !4, i32 45, i32 2, i32 1, i32 11} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_inflated_stored.c]
!40 = metadata !{i32 46, i32 3, metadata !41, null}
!41 = metadata !{i32 786443, metadata !1, metadata !42, i32 46, i32 3, i32 1, i32 12} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_inflated_stored.c]
!42 = metadata !{i32 786443, metadata !1, metadata !43, i32 45, i32 20, i32 0, i32 6} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_inflated_stored.c]
!43 = metadata !{i32 786443, metadata !1, metadata !4, i32 45, i32 18, i32 0, i32 5} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_inflated_stored.c]
!44 = metadata !{i32 50, i32 7, metadata !45, null}
!45 = metadata !{i32 786443, metadata !1, metadata !42, i32 46, i32 21, i32 0, i32 7} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_inflated_stored.c]
!46 = metadata !{i32 51, i32 3, metadata !45, null}
!47 = metadata !{i32 60, i32 3, metadata !48, null}
!48 = metadata !{i32 786443, metadata !1, metadata !43, i32 58, i32 6, i32 0, i32 8} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_inflated_stored.c]
!49 = metadata !{i32 62, i32 2, metadata !43, null}
!50 = metadata !{i32 67, i32 1, metadata !4, null}

