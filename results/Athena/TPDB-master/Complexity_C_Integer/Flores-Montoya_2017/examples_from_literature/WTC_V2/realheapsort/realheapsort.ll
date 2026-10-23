; ModuleID = 'realheapsort.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind uwtable
define void @realheapsort(i32 %N) #0 {
realheapsort_bb0:
  call void @llvm.dbg.value(metadata !{i32 %N}, i64 0, metadata !12), !dbg !13
  %"0" = icmp sgt i32 %N, 2, !dbg !14
  br i1 %"0", label %realheapsort_bb1, label %realheapsort_bb15, !dbg !14

realheapsort_bb1:                                 ; preds = %realheapsort_bb0, %realheapsort_.critedge
  %k.0 = phi i32 [ %"11", %realheapsort_.critedge ], [ 1, %realheapsort_bb0 ]
  %"1" = sub nsw i32 %N, 1, !dbg !16
  %"2" = icmp sle i32 %k.0, %"1", !dbg !16
  br i1 %"2", label %realheapsort_bb2, label %realheapsort_bb5, !dbg !16

realheapsort_bb2:                                 ; preds = %realheapsort_bb1, %realheapsort_bb4
  %j.0 = phi i32 [ %"10", %realheapsort_bb4 ], [ %k.0, %realheapsort_bb1 ]
  %"3" = icmp sgt i32 %j.0, 0, !dbg !21
  br i1 %"3", label %realheapsort_bb3, label %realheapsort_.critedge, !dbg !21

realheapsort_bb3:                                 ; preds = %realheapsort_bb2
  %"4" = call i32 (...)* @nondet(), !dbg !24
  %"5" = call i32 (...)* @nondet(), !dbg !26
  %"6" = icmp sgt i32 %"4", %"5", !dbg !26
  br i1 %"6", label %realheapsort_bb4, label %realheapsort_.critedge, !dbg !27

realheapsort_bb4:                                 ; preds = %realheapsort_bb3
  %"7" = call i32 (...)* @nondet(), !dbg !29
  %"8" = add nsw i32 %j.0, 1, !dbg !31
  %"9" = sdiv i32 %"8", 2, !dbg !31
  %"10" = sub nsw i32 %"9", 1, !dbg !31
  br label %realheapsort_bb2, !dbg !32

realheapsort_.critedge:                           ; preds = %realheapsort_bb3, %realheapsort_bb2
  %"11" = add nsw i32 %k.0, 1, !dbg !33
  call void @llvm.dbg.value(metadata !{i32 %"11"}, i64 0, metadata !34), !dbg !35
  br label %realheapsort_bb1, !dbg !33

realheapsort_bb5:                                 ; preds = %realheapsort_bb1, %realheapsort_bb14
  %k.1 = phi i32 [ %"36", %realheapsort_bb14 ], [ 0, %realheapsort_bb1 ]
  %"12" = sub nsw i32 %N, 2, !dbg !36
  %"13" = icmp sle i32 %k.1, %"12", !dbg !36
  br i1 %"13", label %realheapsort_bb6, label %realheapsort_bb15, !dbg !36

realheapsort_bb6:                                 ; preds = %realheapsort_bb5
  %"14" = call i32 (...)* @nondet(), !dbg !40
  br label %realheapsort_bb7, !dbg !42

realheapsort_bb7:                                 ; preds = %realheapsort_bb13, %realheapsort_bb12, %realheapsort_bb6
  %j.1 = phi i32 [ 0, %realheapsort_bb6 ], [ %m.0, %realheapsort_bb13 ], [ %N, %realheapsort_bb12 ]
  %"15" = mul nsw i32 2, %j.1, !dbg !43
  %"16" = add nsw i32 %"15", 1, !dbg !43
  %"17" = sub nsw i32 %N, 2, !dbg !43
  %"18" = sub nsw i32 %"17", %k.1, !dbg !43
  %"19" = icmp sle i32 %"16", %"18", !dbg !43
  br i1 %"19", label %realheapsort_bb8, label %realheapsort_bb14, !dbg !43

realheapsort_bb8:                                 ; preds = %realheapsort_bb7
  %"20" = mul nsw i32 2, %j.1, !dbg !45
  %"21" = add nsw i32 %"20", 1, !dbg !45
  %"22" = sub nsw i32 %N, 2, !dbg !45
  %"23" = sub nsw i32 %"22", %k.1, !dbg !45
  %"24" = icmp eq i32 %"21", %"23", !dbg !45
  br i1 %"24", label %realheapsort_bb10, label %realheapsort_bb9, !dbg !45

realheapsort_bb9:                                 ; preds = %realheapsort_bb8
  %"25" = call i32 (...)* @nondet(), !dbg !48
  %"26" = call i32 (...)* @nondet(), !dbg !50
  %"27" = icmp slt i32 %"25", %"26", !dbg !50
  br i1 %"27", label %realheapsort_bb10, label %realheapsort_bb11, !dbg !50

realheapsort_bb10:                                ; preds = %realheapsort_bb9, %realheapsort_bb8
  %"28" = mul nsw i32 2, %j.1, !dbg !51
  %"29" = add nsw i32 %"28", 1, !dbg !51
  br label %realheapsort_bb12, !dbg !51

realheapsort_bb11:                                ; preds = %realheapsort_bb9
  %"30" = mul nsw i32 2, %j.1, !dbg !52
  %"31" = add nsw i32 %"30", 2, !dbg !52
  br label %realheapsort_bb12

realheapsort_bb12:                                ; preds = %realheapsort_bb11, %realheapsort_bb10
  %m.0 = phi i32 [ %"29", %realheapsort_bb10 ], [ %"31", %realheapsort_bb11 ]
  %"32" = call i32 (...)* @nondet(), !dbg !53
  %"33" = call i32 (...)* @nondet(), !dbg !55
  %"34" = icmp sgt i32 %"32", %"33", !dbg !55
  br i1 %"34", label %realheapsort_bb13, label %realheapsort_bb7, !dbg !55

realheapsort_bb13:                                ; preds = %realheapsort_bb12
  %"35" = call i32 (...)* @nondet(), !dbg !56
  br label %realheapsort_bb7, !dbg !58

realheapsort_bb14:                                ; preds = %realheapsort_bb7
  %"36" = add nsw i32 %k.1, 1, !dbg !59
  call void @llvm.dbg.value(metadata !{i32 %"36"}, i64 0, metadata !34), !dbg !35
  br label %realheapsort_bb5, !dbg !59

realheapsort_bb15:                                ; preds = %realheapsort_bb5, %realheapsort_bb0
  ret void, !dbg !60
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

!0 = metadata !{i32 786449, metadata !1, i32 12, metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)", i1 false, metadata !"", i32 0, metadata !2, metadata !2, metadata !3, metadata !2, metadata !2, metadata !"", i32 1} ; [ DW_TAG_compile_unit ] [/liveness_analysis/realheapsort.c] [DW_LANG_C99]
!1 = metadata !{metadata !"realheapsort.c", metadata !"/liveness_analysis"}
!2 = metadata !{}
!3 = metadata !{metadata !4}
!4 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"realheapsort", metadata !"realheapsort", metadata !"", i32 3, metadata !6, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (i32)* @realheapsort, null, null, metadata !2, i32 4} ; [ DW_TAG_subprogram ] [line 3] [def] [scope 4] [realheapsort]
!5 = metadata !{i32 786473, metadata !1}          ; [ DW_TAG_file_type ] [/liveness_analysis/realheapsort.c]
!6 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !7, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!7 = metadata !{null, metadata !8}
!8 = metadata !{i32 786468, null, null, metadata !"int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!9 = metadata !{i32 2, metadata !"Dwarf Version", i32 4}
!10 = metadata !{i32 2, metadata !"Debug Info Version", i32 1}
!11 = metadata !{metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)"}
!12 = metadata !{i32 786689, metadata !4, metadata !"N", metadata !5, i32 16777219, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [N] [line 3]
!13 = metadata !{i32 3, i32 23, metadata !4, null}
!14 = metadata !{i32 8, i32 6, metadata !15, null} ; [ DW_TAG_imported_declaration ]
!15 = metadata !{i32 786443, metadata !1, metadata !4, i32 8, i32 6, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/liveness_analysis/realheapsort.c]
!16 = metadata !{i32 10, i32 10, metadata !17, null}
!17 = metadata !{i32 786443, metadata !1, metadata !18, i32 10, i32 10, i32 2, i32 15} ; [ DW_TAG_lexical_block ] [/liveness_analysis/realheapsort.c]
!18 = metadata !{i32 786443, metadata !1, metadata !19, i32 10, i32 10, i32 1, i32 11} ; [ DW_TAG_lexical_block ] [/liveness_analysis/realheapsort.c]
!19 = metadata !{i32 786443, metadata !1, metadata !20, i32 10, i32 5, i32 0, i32 2} ; [ DW_TAG_lexical_block ] [/liveness_analysis/realheapsort.c]
!20 = metadata !{i32 786443, metadata !1, metadata !15, i32 8, i32 12, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/liveness_analysis/realheapsort.c]
!21 = metadata !{i32 14, i32 9, metadata !22, null}
!22 = metadata !{i32 786443, metadata !1, metadata !23, i32 14, i32 9, i32 1, i32 12} ; [ DW_TAG_lexical_block ] [/liveness_analysis/realheapsort.c]
!23 = metadata !{i32 786443, metadata !1, metadata !19, i32 11, i32 7, i32 0, i32 3} ; [ DW_TAG_lexical_block ] [/liveness_analysis/realheapsort.c]
!24 = metadata !{i32 14, i32 26, metadata !25, null}
!25 = metadata !{i32 786443, metadata !1, metadata !23, i32 14, i32 26, i32 2, i32 13} ; [ DW_TAG_lexical_block ] [/liveness_analysis/realheapsort.c]
!26 = metadata !{i32 14, i32 35, metadata !23, null}
!27 = metadata !{i32 14, i32 35, metadata !28, null}
!28 = metadata !{i32 786443, metadata !1, metadata !23, i32 14, i32 35, i32 3, i32 14} ; [ DW_TAG_lexical_block ] [/liveness_analysis/realheapsort.c]
!29 = metadata !{i32 17, i32 20, metadata !30, null}
!30 = metadata !{i32 786443, metadata !1, metadata !23, i32 15, i32 4, i32 0, i32 4} ; [ DW_TAG_lexical_block ] [/liveness_analysis/realheapsort.c]
!31 = metadata !{i32 20, i32 6, metadata !30, null}
!32 = metadata !{i32 21, i32 4, metadata !30, null}
!33 = metadata !{i32 10, i32 21, metadata !19, null}
!34 = metadata !{i32 786688, metadata !4, metadata !"k", metadata !5, i32 7, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [k] [line 7]
!35 = metadata !{i32 7, i32 7, metadata !4, null}
!36 = metadata !{i32 26, i32 10, metadata !37, null}
!37 = metadata !{i32 786443, metadata !1, metadata !38, i32 26, i32 10, i32 2, i32 19} ; [ DW_TAG_lexical_block ] [/liveness_analysis/realheapsort.c]
!38 = metadata !{i32 786443, metadata !1, metadata !39, i32 26, i32 10, i32 1, i32 16} ; [ DW_TAG_lexical_block ] [/liveness_analysis/realheapsort.c]
!39 = metadata !{i32 786443, metadata !1, metadata !20, i32 26, i32 5, i32 0, i32 5} ; [ DW_TAG_lexical_block ] [/liveness_analysis/realheapsort.c]
!40 = metadata !{i32 29, i32 16, metadata !41, null}
!41 = metadata !{i32 786443, metadata !1, metadata !39, i32 27, i32 7, i32 0, i32 6} ; [ DW_TAG_lexical_block ] [/liveness_analysis/realheapsort.c]
!42 = metadata !{i32 32, i32 9, metadata !41, null}
!43 = metadata !{i32 32, i32 9, metadata !44, null}
!44 = metadata !{i32 786443, metadata !1, metadata !41, i32 32, i32 9, i32 1, i32 17} ; [ DW_TAG_lexical_block ] [/liveness_analysis/realheapsort.c]
!45 = metadata !{i32 34, i32 10, metadata !46, null}
!46 = metadata !{i32 786443, metadata !1, metadata !47, i32 34, i32 10, i32 0, i32 8} ; [ DW_TAG_lexical_block ] [/liveness_analysis/realheapsort.c]
!47 = metadata !{i32 786443, metadata !1, metadata !41, i32 33, i32 4, i32 0, i32 7} ; [ DW_TAG_lexical_block ] [/liveness_analysis/realheapsort.c]
!48 = metadata !{i32 34, i32 29, metadata !49, null}
!49 = metadata !{i32 786443, metadata !1, metadata !46, i32 34, i32 29, i32 1, i32 18} ; [ DW_TAG_lexical_block ] [/liveness_analysis/realheapsort.c]
!50 = metadata !{i32 34, i32 38, metadata !46, null}
!51 = metadata !{i32 35, i32 8, metadata !46, null}
!52 = metadata !{i32 37, i32 8, metadata !46, null}
!53 = metadata !{i32 38, i32 17, metadata !54, null}
!54 = metadata !{i32 786443, metadata !1, metadata !47, i32 38, i32 17, i32 0, i32 9} ; [ DW_TAG_lexical_block ] [/liveness_analysis/realheapsort.c]
!55 = metadata !{i32 38, i32 26, metadata !54, null}
!56 = metadata !{i32 40, i32 15, metadata !57, null}
!57 = metadata !{i32 786443, metadata !1, metadata !54, i32 39, i32 8, i32 0, i32 10} ; [ DW_TAG_lexical_block ] [/liveness_analysis/realheapsort.c]
!58 = metadata !{i32 44, i32 8, metadata !57, null}
!59 = metadata !{i32 26, i32 21, metadata !39, null}
!60 = metadata !{i32 51, i32 1, metadata !4, null}

