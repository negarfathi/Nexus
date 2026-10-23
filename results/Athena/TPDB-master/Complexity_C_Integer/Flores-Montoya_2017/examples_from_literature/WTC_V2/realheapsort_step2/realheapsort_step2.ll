; ModuleID = 'realheapsort_step2.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind uwtable
define void @realheapsort_step2(i32 %N) #0 {
realheapsort_step2_bb0:
  call void @llvm.dbg.value(metadata !{i32 %N}, i64 0, metadata !12), !dbg !13
  %"0" = icmp sgt i32 %N, 2, !dbg !14
  br i1 %"0", label %realheapsort_step2_bb1, label %realheapsort_step2_bb11, !dbg !14

realheapsort_step2_bb1:                           ; preds = %realheapsort_step2_bb0, %realheapsort_step2_bb10
  %k.0 = phi i32 [ %"25", %realheapsort_step2_bb10 ], [ 0, %realheapsort_step2_bb0 ]
  %"1" = sub nsw i32 %N, 2, !dbg !16
  %"2" = icmp sle i32 %k.0, %"1", !dbg !16
  br i1 %"2", label %realheapsort_step2_bb2, label %realheapsort_step2_bb11, !dbg !16

realheapsort_step2_bb2:                           ; preds = %realheapsort_step2_bb1
  %"3" = call i32 (...)* @nondet(), !dbg !21
  br label %realheapsort_step2_bb3, !dbg !23

realheapsort_step2_bb3:                           ; preds = %realheapsort_step2_bb9, %realheapsort_step2_bb8, %realheapsort_step2_bb2
  %j.0 = phi i32 [ 0, %realheapsort_step2_bb2 ], [ %m.0, %realheapsort_step2_bb9 ], [ %N, %realheapsort_step2_bb8 ]
  %"4" = mul nsw i32 2, %j.0, !dbg !24
  %"5" = add nsw i32 %"4", 1, !dbg !24
  %"6" = sub nsw i32 %N, 2, !dbg !24
  %"7" = sub nsw i32 %"6", %k.0, !dbg !24
  %"8" = icmp sle i32 %"5", %"7", !dbg !24
  br i1 %"8", label %realheapsort_step2_bb4, label %realheapsort_step2_bb10, !dbg !24

realheapsort_step2_bb4:                           ; preds = %realheapsort_step2_bb3
  %"9" = mul nsw i32 2, %j.0, !dbg !26
  %"10" = add nsw i32 %"9", 1, !dbg !26
  %"11" = sub nsw i32 %N, 2, !dbg !26
  %"12" = sub nsw i32 %"11", %k.0, !dbg !26
  %"13" = icmp eq i32 %"10", %"12", !dbg !26
  br i1 %"13", label %realheapsort_step2_bb6, label %realheapsort_step2_bb5, !dbg !26

realheapsort_step2_bb5:                           ; preds = %realheapsort_step2_bb4
  %"14" = call i32 (...)* @nondet(), !dbg !29
  %"15" = call i32 (...)* @nondet(), !dbg !31
  %"16" = icmp slt i32 %"14", %"15", !dbg !31
  br i1 %"16", label %realheapsort_step2_bb6, label %realheapsort_step2_bb7, !dbg !31

realheapsort_step2_bb6:                           ; preds = %realheapsort_step2_bb5, %realheapsort_step2_bb4
  %"17" = mul nsw i32 2, %j.0, !dbg !32
  %"18" = add nsw i32 %"17", 1, !dbg !32
  br label %realheapsort_step2_bb8, !dbg !32

realheapsort_step2_bb7:                           ; preds = %realheapsort_step2_bb5
  %"19" = mul nsw i32 2, %j.0, !dbg !33
  %"20" = add nsw i32 %"19", 2, !dbg !33
  br label %realheapsort_step2_bb8

realheapsort_step2_bb8:                           ; preds = %realheapsort_step2_bb7, %realheapsort_step2_bb6
  %m.0 = phi i32 [ %"18", %realheapsort_step2_bb6 ], [ %"20", %realheapsort_step2_bb7 ]
  %"21" = call i32 (...)* @nondet(), !dbg !34
  %"22" = call i32 (...)* @nondet(), !dbg !36
  %"23" = icmp sgt i32 %"21", %"22", !dbg !36
  br i1 %"23", label %realheapsort_step2_bb9, label %realheapsort_step2_bb3, !dbg !36

realheapsort_step2_bb9:                           ; preds = %realheapsort_step2_bb8
  %"24" = call i32 (...)* @nondet(), !dbg !37
  br label %realheapsort_step2_bb3, !dbg !39

realheapsort_step2_bb10:                          ; preds = %realheapsort_step2_bb3
  %"25" = add nsw i32 %k.0, 1, !dbg !40
  call void @llvm.dbg.value(metadata !{i32 %"25"}, i64 0, metadata !41), !dbg !42
  br label %realheapsort_step2_bb1, !dbg !40

realheapsort_step2_bb11:                          ; preds = %realheapsort_step2_bb1, %realheapsort_step2_bb0
  ret void, !dbg !43
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

!0 = metadata !{i32 786449, metadata !1, i32 12, metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)", i1 false, metadata !"", i32 0, metadata !2, metadata !2, metadata !3, metadata !2, metadata !2, metadata !"", i32 1} ; [ DW_TAG_compile_unit ] [/liveness_analysis/realheapsort_step2.c] [DW_LANG_C99]
!1 = metadata !{metadata !"realheapsort_step2.c", metadata !"/liveness_analysis"}
!2 = metadata !{}
!3 = metadata !{metadata !4}
!4 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"realheapsort_step2", metadata !"realheapsort_step2", metadata !"", i32 7, metadata !6, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (i32)* @realheapsort_step2, null, null, metadata !2, i32 8} ; [ DW_TAG_subprogram ] [line 7] [def] [scope 8] [realheapsort_step2]
!5 = metadata !{i32 786473, metadata !1}          ; [ DW_TAG_file_type ] [/liveness_analysis/realheapsort_step2.c]
!6 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !7, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!7 = metadata !{null, metadata !8}
!8 = metadata !{i32 786468, null, null, metadata !"int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!9 = metadata !{i32 2, metadata !"Dwarf Version", i32 4}
!10 = metadata !{i32 2, metadata !"Debug Info Version", i32 1}
!11 = metadata !{metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)"}
!12 = metadata !{i32 786689, metadata !4, metadata !"N", metadata !5, i32 16777223, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [N] [line 7]
!13 = metadata !{i32 7, i32 29, metadata !4, null}
!14 = metadata !{i32 12, i32 6, metadata !15, null}
!15 = metadata !{i32 786443, metadata !1, metadata !4, i32 12, i32 6, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/liveness_analysis/realheapsort_step2.c]
!16 = metadata !{i32 15, i32 10, metadata !17, null}
!17 = metadata !{i32 786443, metadata !1, metadata !18, i32 15, i32 10, i32 2, i32 11} ; [ DW_TAG_lexical_block ] [/liveness_analysis/realheapsort_step2.c]
!18 = metadata !{i32 786443, metadata !1, metadata !19, i32 15, i32 10, i32 1, i32 8} ; [ DW_TAG_lexical_block ] [/liveness_analysis/realheapsort_step2.c]
!19 = metadata !{i32 786443, metadata !1, metadata !20, i32 15, i32 5, i32 0, i32 2} ; [ DW_TAG_lexical_block ] [/liveness_analysis/realheapsort_step2.c]
!20 = metadata !{i32 786443, metadata !1, metadata !15, i32 12, i32 12, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/liveness_analysis/realheapsort_step2.c]
!21 = metadata !{i32 18, i32 15, metadata !22, null}
!22 = metadata !{i32 786443, metadata !1, metadata !19, i32 16, i32 7, i32 0, i32 3} ; [ DW_TAG_lexical_block ] [/liveness_analysis/realheapsort_step2.c]
!23 = metadata !{i32 21, i32 9, metadata !22, null}
!24 = metadata !{i32 21, i32 9, metadata !25, null}
!25 = metadata !{i32 786443, metadata !1, metadata !22, i32 21, i32 9, i32 1, i32 9} ; [ DW_TAG_lexical_block ] [/liveness_analysis/realheapsort_step2.c]
!26 = metadata !{i32 23, i32 10, metadata !27, null}
!27 = metadata !{i32 786443, metadata !1, metadata !28, i32 23, i32 10, i32 0, i32 5} ; [ DW_TAG_lexical_block ] [/liveness_analysis/realheapsort_step2.c]
!28 = metadata !{i32 786443, metadata !1, metadata !22, i32 22, i32 4, i32 0, i32 4} ; [ DW_TAG_lexical_block ] [/liveness_analysis/realheapsort_step2.c]
!29 = metadata !{i32 23, i32 29, metadata !30, null}
!30 = metadata !{i32 786443, metadata !1, metadata !27, i32 23, i32 29, i32 1, i32 10} ; [ DW_TAG_lexical_block ] [/liveness_analysis/realheapsort_step2.c]
!31 = metadata !{i32 23, i32 38, metadata !27, null}
!32 = metadata !{i32 24, i32 8, metadata !27, null}
!33 = metadata !{i32 26, i32 8, metadata !27, null}
!34 = metadata !{i32 27, i32 17, metadata !35, null}
!35 = metadata !{i32 786443, metadata !1, metadata !28, i32 27, i32 17, i32 0, i32 6} ; [ DW_TAG_lexical_block ] [/liveness_analysis/realheapsort_step2.c]
!36 = metadata !{i32 27, i32 26, metadata !35, null}
!37 = metadata !{i32 29, i32 15, metadata !38, null}
!38 = metadata !{i32 786443, metadata !1, metadata !35, i32 28, i32 8, i32 0, i32 7} ; [ DW_TAG_lexical_block ] [/liveness_analysis/realheapsort_step2.c]
!39 = metadata !{i32 33, i32 8, metadata !38, null}
!40 = metadata !{i32 15, i32 21, metadata !19, null}
!41 = metadata !{i32 786688, metadata !4, metadata !"k", metadata !5, i32 11, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [k] [line 11]
!42 = metadata !{i32 11, i32 7, metadata !4, null}
!43 = metadata !{i32 40, i32 1, metadata !4, null}

