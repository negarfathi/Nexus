; ModuleID = 'CPU2006_analyse_other.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind uwtable
define void @analyse_other(i32 %atoms_nres, i32 %atoms_nr, i32 %bASK) #0 {
analyse_other_bb0:
  call void @llvm.dbg.value(metadata !{i32 %atoms_nres}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !{i32 %atoms_nr}, i64 0, metadata !14), !dbg !15
  call void @llvm.dbg.value(metadata !{i32 %bASK}, i64 0, metadata !16), !dbg !17
  call void @llvm.dbg.value(metadata !18, i64 0, metadata !19), !dbg !20
  call void @llvm.dbg.value(metadata !18, i64 0, metadata !21), !dbg !22
  call void @llvm.dbg.value(metadata !18, i64 0, metadata !23), !dbg !24
  call void @llvm.dbg.value(metadata !{i32 %"3"}, i64 0, metadata !23), !dbg !24
  br label %analyse_other_bb1, !dbg !25

analyse_other_bb1:                                ; preds = %analyse_other_bb3, %analyse_other_bb0
  %i.0 = phi i32 [ 0, %analyse_other_bb0 ], [ %"3", %analyse_other_bb3 ]
  %"0" = icmp slt i32 %i.0, %atoms_nres, !dbg !27
  br i1 %"0", label %analyse_other_bb2, label %analyse_other_bb4, !dbg !27

analyse_other_bb2:                                ; preds = %analyse_other_bb1
  %"1" = call i32 (...)* @random(), !dbg !30
  %"2" = icmp ne i32 %"1", 0, !dbg !30
  br i1 %"2", label %analyse_other_bb4, label %analyse_other_bb3, !dbg !30

analyse_other_bb3:                                ; preds = %analyse_other_bb2
  %"3" = add nsw i32 %i.0, 1, !dbg !32
  br label %analyse_other_bb1, !dbg !32

analyse_other_bb4:                                ; preds = %analyse_other_bb2, %analyse_other_bb1
  %"4" = icmp slt i32 %i.0, %atoms_nres, !dbg !33
  br i1 %"4", label %analyse_other_bb5, label %analyse_other_bb28, !dbg !33

analyse_other_bb5:                                ; preds = %analyse_other_bb4, %analyse_other_bb11
  %k.0 = phi i32 [ %"14", %analyse_other_bb11 ], [ 0, %analyse_other_bb4 ]
  %nrestp.0 = phi i32 [ %nrestp.2, %analyse_other_bb11 ], [ 0, %analyse_other_bb4 ]
  %"5" = icmp slt i32 %k.0, %atoms_nr, !dbg !35
  br i1 %"5", label %analyse_other_bb6, label %analyse_other_bb12, !dbg !35

analyse_other_bb6:                                ; preds = %analyse_other_bb5
  %"6" = call i32 (...)* @random(), !dbg !40
  %"7" = icmp ne i32 %"6", 0, !dbg !40
  br i1 %"7", label %analyse_other_bb7, label %analyse_other_bb11, !dbg !40

analyse_other_bb7:                                ; preds = %analyse_other_bb6, %analyse_other_bb9
  %l.0 = phi i32 [ %"11", %analyse_other_bb9 ], [ 0, %analyse_other_bb6 ]
  %"8" = icmp slt i32 %l.0, %nrestp.0, !dbg !43
  br i1 %"8", label %analyse_other_bb8, label %analyse_other_bb10, !dbg !43

analyse_other_bb8:                                ; preds = %analyse_other_bb7
  %"9" = call i32 (...)* @random(), !dbg !48
  %"10" = icmp ne i32 %"9", 0, !dbg !48
  br i1 %"10", label %analyse_other_bb10, label %analyse_other_bb9, !dbg !48

analyse_other_bb9:                                ; preds = %analyse_other_bb8
  %"11" = add nsw i32 %l.0, 1, !dbg !50
  br label %analyse_other_bb7, !dbg !50

analyse_other_bb10:                               ; preds = %analyse_other_bb8, %analyse_other_bb7
  %"12" = icmp eq i32 %l.0, %nrestp.0, !dbg !51
  %"13" = add nsw i32 %nrestp.0, 1, !dbg !53
  call void @llvm.dbg.value(metadata !{i32 %"13"}, i64 0, metadata !21), !dbg !22
  %.nrestp.0 = select i1 %"12", i32 %"13", i32 %nrestp.0, !dbg !51
  br label %analyse_other_bb11, !dbg !55

analyse_other_bb11:                               ; preds = %analyse_other_bb6, %analyse_other_bb10
  %nrestp.2 = phi i32 [ %.nrestp.0, %analyse_other_bb10 ], [ %nrestp.0, %analyse_other_bb6 ]
  %"14" = add nsw i32 %k.0, 1, !dbg !56
  br label %analyse_other_bb5, !dbg !56

analyse_other_bb12:                               ; preds = %analyse_other_bb5, %analyse_other_bb27
  %i.1 = phi i32 [ %"40", %analyse_other_bb27 ], [ 0, %analyse_other_bb5 ]
  %"15" = icmp slt i32 %i.1, %nrestp.0, !dbg !57
  br i1 %"15", label %analyse_other_bb13, label %analyse_other_bb28, !dbg !57

analyse_other_bb13:                               ; preds = %analyse_other_bb12, %analyse_other_bb14
  %naid.0 = phi i32 [ %.naid.0, %analyse_other_bb14 ], [ 0, %analyse_other_bb12 ]
  %j.0 = phi i32 [ %"20", %analyse_other_bb14 ], [ 0, %analyse_other_bb12 ]
  %"16" = icmp slt i32 %j.0, %atoms_nr, !dbg !61
  br i1 %"16", label %analyse_other_bb14, label %analyse_other_bb15, !dbg !61

analyse_other_bb14:                               ; preds = %analyse_other_bb13
  %"17" = call i32 (...)* @random(), !dbg !66
  %"18" = icmp ne i32 %"17", 0, !dbg !66
  %"19" = add nsw i32 %naid.0, 1, !dbg !69
  %.naid.0 = select i1 %"18", i32 %"19", i32 %naid.0, !dbg !66
  %"20" = add nsw i32 %j.0, 1, !dbg !70
  br label %analyse_other_bb13, !dbg !70

analyse_other_bb15:                               ; preds = %analyse_other_bb13
  %"21" = icmp ne i32 %bASK, 0, !dbg !71
  br i1 %"21", label %analyse_other_bb16, label %analyse_other_bb27, !dbg !71

analyse_other_bb16:                               ; preds = %analyse_other_bb15
  %"22" = call i32 (...)* @random(), !dbg !73
  %"23" = icmp ne i32 %"22", 0, !dbg !73
  br i1 %"23", label %analyse_other_bb17, label %analyse_other_bb27, !dbg !73

analyse_other_bb17:                               ; preds = %analyse_other_bb16, %analyse_other_bb21
  %natp.0 = phi i32 [ %.natp.0, %analyse_other_bb21 ], [ 0, %analyse_other_bb16 ]
  %k.1 = phi i32 [ %"31", %analyse_other_bb21 ], [ 0, %analyse_other_bb16 ]
  %"24" = icmp slt i32 %k.1, %naid.0, !dbg !76
  br i1 %"24", label %analyse_other_bb18, label %analyse_other_bb22, !dbg !76

analyse_other_bb18:                               ; preds = %analyse_other_bb17, %analyse_other_bb20
  %l.1 = phi i32 [ %"28", %analyse_other_bb20 ], [ 0, %analyse_other_bb17 ]
  %"25" = icmp slt i32 %l.1, %natp.0, !dbg !81
  br i1 %"25", label %analyse_other_bb19, label %analyse_other_bb21, !dbg !81

analyse_other_bb19:                               ; preds = %analyse_other_bb18
  %"26" = call i32 (...)* @random(), !dbg !86
  %"27" = icmp ne i32 %"26", 0, !dbg !86
  br i1 %"27", label %analyse_other_bb21, label %analyse_other_bb20, !dbg !86

analyse_other_bb20:                               ; preds = %analyse_other_bb19
  %"28" = add nsw i32 %l.1, 1, !dbg !88
  br label %analyse_other_bb18, !dbg !88

analyse_other_bb21:                               ; preds = %analyse_other_bb19, %analyse_other_bb18
  %"29" = icmp eq i32 %l.1, %natp.0, !dbg !89
  %"30" = add nsw i32 %natp.0, 1, !dbg !91
  call void @llvm.dbg.value(metadata !{i32 %"30"}, i64 0, metadata !93), !dbg !94
  %.natp.0 = select i1 %"29", i32 %"30", i32 %natp.0, !dbg !89
  %"31" = add nsw i32 %k.1, 1, !dbg !95
  call void @llvm.dbg.value(metadata !{i32 %"31"}, i64 0, metadata !96), !dbg !97
  br label %analyse_other_bb17, !dbg !95

analyse_other_bb22:                               ; preds = %analyse_other_bb17
  %"32" = icmp sgt i32 %natp.0, 1, !dbg !98
  br i1 %"32", label %analyse_other_bb23, label %analyse_other_bb27, !dbg !98

analyse_other_bb23:                               ; preds = %analyse_other_bb22, %analyse_other_bb26
  %l.2 = phi i32 [ %"39", %analyse_other_bb26 ], [ 0, %analyse_other_bb22 ]
  %"33" = icmp slt i32 %l.2, %natp.0, !dbg !100
  br i1 %"33", label %analyse_other_bb24, label %analyse_other_bb27, !dbg !100

analyse_other_bb24:                               ; preds = %analyse_other_bb23, %analyse_other_bb25
  %naaid.0 = phi i32 [ %.naaid.0, %analyse_other_bb25 ], [ 0, %analyse_other_bb23 ]
  %k.2 = phi i32 [ %"38", %analyse_other_bb25 ], [ 0, %analyse_other_bb23 ]
  %"34" = icmp slt i32 %k.2, %naid.0, !dbg !105
  br i1 %"34", label %analyse_other_bb25, label %analyse_other_bb26, !dbg !105

analyse_other_bb25:                               ; preds = %analyse_other_bb24
  %"35" = call i32 (...)* @random(), !dbg !110
  %"36" = icmp ne i32 %"35", 0, !dbg !110
  %"37" = add nsw i32 %naaid.0, 1, !dbg !113
  %.naaid.0 = select i1 %"36", i32 %"37", i32 %naaid.0, !dbg !110
  %"38" = add nsw i32 %k.2, 1, !dbg !114
  br label %analyse_other_bb24, !dbg !114

analyse_other_bb26:                               ; preds = %analyse_other_bb24
  %"39" = add nsw i32 %l.2, 1, !dbg !115
  call void @llvm.dbg.value(metadata !{i32 %"39"}, i64 0, metadata !116), !dbg !117
  br label %analyse_other_bb23, !dbg !115

analyse_other_bb27:                               ; preds = %analyse_other_bb15, %analyse_other_bb22, %analyse_other_bb23, %analyse_other_bb16
  %"40" = add nsw i32 %i.1, 1, !dbg !118
  call void @llvm.dbg.value(metadata !{i32 %"40"}, i64 0, metadata !23), !dbg !24
  br label %analyse_other_bb12, !dbg !118

analyse_other_bb28:                               ; preds = %analyse_other_bb12, %analyse_other_bb4
  ret void, !dbg !119
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

!0 = metadata !{i32 786449, metadata !1, i32 12, metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)", i1 false, metadata !"", i32 0, metadata !2, metadata !2, metadata !3, metadata !2, metadata !2, metadata !"", i32 1} ; [ DW_TAG_compile_unit ] [/liveness_analysis/CPU2006_analyse_other.c] [DW_LANG_C99]
!1 = metadata !{metadata !"CPU2006_analyse_other.c", metadata !"/liveness_analysis"}
!2 = metadata !{}
!3 = metadata !{metadata !4}
!4 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"analyse_other", metadata !"analyse_other", metadata !"", i32 6, metadata !6, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (i32, i32, i32)* @analyse_other, null, null, metadata !2, i32 7} ; [ DW_TAG_subprogram ] [line 6] [def] [scope 7] [analyse_other]
!5 = metadata !{i32 786473, metadata !1}          ; [ DW_TAG_file_type ] [/liveness_analysis/CPU2006_analyse_other.c]
!6 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !7, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!7 = metadata !{null, metadata !8, metadata !8, metadata !8}
!8 = metadata !{i32 786468, null, null, metadata !"int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!9 = metadata !{i32 2, metadata !"Dwarf Version", i32 4}
!10 = metadata !{i32 2, metadata !"Debug Info Version", i32 1}
!11 = metadata !{metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)"}
!12 = metadata !{i32 786689, metadata !4, metadata !"atoms_nres", metadata !5, i32 16777222, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [atoms_nres] [line 6]
!13 = metadata !{i32 6, i32 24, metadata !4, null}
!14 = metadata !{i32 786689, metadata !4, metadata !"atoms_nr", metadata !5, i32 33554438, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [atoms_nr] [line 6]
!15 = metadata !{i32 6, i32 40, metadata !4, null}
!16 = metadata !{i32 786689, metadata !4, metadata !"bASK", metadata !5, i32 50331654, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [bASK] [line 6]
!17 = metadata !{i32 6, i32 54, metadata !4, null}
!18 = metadata !{i32 0}
!19 = metadata !{i32 786688, metadata !4, metadata !"restp", metadata !5, i32 8, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [restp] [line 8]
!20 = metadata !{i32 8, i32 7, metadata !4, null} ; [ DW_TAG_imported_declaration ]
!21 = metadata !{i32 786688, metadata !4, metadata !"nrestp", metadata !5, i32 9, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [nrestp] [line 9]
!22 = metadata !{i32 9, i32 38, metadata !4, null}
!23 = metadata !{i32 786688, metadata !4, metadata !"i", metadata !5, i32 9, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [i] [line 9]
!24 = metadata !{i32 9, i32 8, metadata !4, null}
!25 = metadata !{i32 12, i32 7, metadata !26, null}
!26 = metadata !{i32 786443, metadata !1, metadata !4, i32 12, i32 3, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_analyse_other.c]
!27 = metadata !{i32 12, i32 7, metadata !28, null}
!28 = metadata !{i32 786443, metadata !1, metadata !29, i32 12, i32 7, i32 2, i32 36} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_analyse_other.c]
!29 = metadata !{i32 786443, metadata !1, metadata !26, i32 12, i32 7, i32 1, i32 34} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_analyse_other.c]
!30 = metadata !{i32 13, i32 9, metadata !31, null}
!31 = metadata !{i32 786443, metadata !1, metadata !26, i32 13, i32 9, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_analyse_other.c]
!32 = metadata !{i32 12, i32 28, metadata !26, null}
!33 = metadata !{i32 15, i32 7, metadata !34, null}
!34 = metadata !{i32 786443, metadata !1, metadata !4, i32 15, i32 7, i32 0, i32 2} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_analyse_other.c]
!35 = metadata !{i32 17, i32 9, metadata !36, null}
!36 = metadata !{i32 786443, metadata !1, metadata !37, i32 17, i32 9, i32 2, i32 41} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_analyse_other.c]
!37 = metadata !{i32 786443, metadata !1, metadata !38, i32 17, i32 9, i32 1, i32 37} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_analyse_other.c]
!38 = metadata !{i32 786443, metadata !1, metadata !39, i32 17, i32 5, i32 0, i32 4} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_analyse_other.c]
!39 = metadata !{i32 786443, metadata !1, metadata !34, i32 15, i32 23, i32 0, i32 3} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_analyse_other.c]
!40 = metadata !{i32 18, i32 11, metadata !41, null}
!41 = metadata !{i32 786443, metadata !1, metadata !42, i32 18, i32 11, i32 0, i32 6} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_analyse_other.c]
!42 = metadata !{i32 786443, metadata !1, metadata !38, i32 17, i32 33, i32 0, i32 5} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_analyse_other.c]
!43 = metadata !{i32 19, i32 6, metadata !44, null}
!44 = metadata !{i32 786443, metadata !1, metadata !45, i32 19, i32 6, i32 2, i32 40} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_analyse_other.c]
!45 = metadata !{i32 786443, metadata !1, metadata !46, i32 19, i32 6, i32 1, i32 38} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_analyse_other.c]
!46 = metadata !{i32 786443, metadata !1, metadata !47, i32 19, i32 2, i32 0, i32 8} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_analyse_other.c]
!47 = metadata !{i32 786443, metadata !1, metadata !41, i32 18, i32 21, i32 0, i32 7} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_analyse_other.c]
!48 = metadata !{i32 20, i32 8, metadata !49, null}
!49 = metadata !{i32 786443, metadata !1, metadata !46, i32 20, i32 8, i32 0, i32 9} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_analyse_other.c]
!50 = metadata !{i32 19, i32 23, metadata !46, null}
!51 = metadata !{i32 22, i32 6, metadata !52, null}
!52 = metadata !{i32 786443, metadata !1, metadata !47, i32 22, i32 6, i32 0, i32 10} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_analyse_other.c]
!53 = metadata !{i32 23, i32 4, metadata !54, null}
!54 = metadata !{i32 786443, metadata !1, metadata !52, i32 22, i32 17, i32 0, i32 11} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_analyse_other.c]
!55 = metadata !{i32 25, i32 7, metadata !47, null}
!56 = metadata !{i32 17, i32 28, metadata !38, null}
!57 = metadata !{i32 28, i32 9, metadata !58, null}
!58 = metadata !{i32 786443, metadata !1, metadata !59, i32 28, i32 9, i32 2, i32 54} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_analyse_other.c]
!59 = metadata !{i32 786443, metadata !1, metadata !60, i32 28, i32 9, i32 1, i32 42} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_analyse_other.c]
!60 = metadata !{i32 786443, metadata !1, metadata !39, i32 28, i32 5, i32 0, i32 12} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_analyse_other.c]
!61 = metadata !{i32 30, i32 11, metadata !62, null}
!62 = metadata !{i32 786443, metadata !1, metadata !63, i32 30, i32 11, i32 2, i32 44} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_analyse_other.c]
!63 = metadata !{i32 786443, metadata !1, metadata !64, i32 30, i32 11, i32 1, i32 43} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_analyse_other.c]
!64 = metadata !{i32 786443, metadata !1, metadata !65, i32 30, i32 7, i32 0, i32 14} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_analyse_other.c]
!65 = metadata !{i32 786443, metadata !1, metadata !60, i32 28, i32 31, i32 0, i32 13} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_analyse_other.c]
!66 = metadata !{i32 31, i32 6, metadata !67, null}
!67 = metadata !{i32 786443, metadata !1, metadata !68, i32 31, i32 6, i32 0, i32 16} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_analyse_other.c]
!68 = metadata !{i32 786443, metadata !1, metadata !64, i32 30, i32 35, i32 0, i32 15} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_analyse_other.c]
!69 = metadata !{i32 32, i32 4, metadata !67, null}
!70 = metadata !{i32 30, i32 30, metadata !64, null}
!71 = metadata !{i32 34, i32 11, metadata !72, null}
!72 = metadata !{i32 786443, metadata !1, metadata !65, i32 34, i32 11, i32 0, i32 17} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_analyse_other.c]
!73 = metadata !{i32 35, i32 6, metadata !74, null}
!74 = metadata !{i32 786443, metadata !1, metadata !75, i32 35, i32 6, i32 0, i32 19} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_analyse_other.c]
!75 = metadata !{i32 786443, metadata !1, metadata !72, i32 34, i32 17, i32 0, i32 18} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_analyse_other.c]
!76 = metadata !{i32 37, i32 8, metadata !77, null}
!77 = metadata !{i32 786443, metadata !1, metadata !78, i32 37, i32 8, i32 2, i32 49} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_analyse_other.c]
!78 = metadata !{i32 786443, metadata !1, metadata !79, i32 37, i32 8, i32 1, i32 45} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_analyse_other.c]
!79 = metadata !{i32 786443, metadata !1, metadata !80, i32 37, i32 4, i32 0, i32 21} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_analyse_other.c]
!80 = metadata !{i32 786443, metadata !1, metadata !74, i32 35, i32 16, i32 0, i32 20} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_analyse_other.c]
!81 = metadata !{i32 38, i32 10, metadata !82, null}
!82 = metadata !{i32 786443, metadata !1, metadata !83, i32 38, i32 10, i32 2, i32 48} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_analyse_other.c]
!83 = metadata !{i32 786443, metadata !1, metadata !84, i32 38, i32 10, i32 1, i32 46} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_analyse_other.c]
!84 = metadata !{i32 786443, metadata !1, metadata !85, i32 38, i32 6, i32 0, i32 23} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_analyse_other.c]
!85 = metadata !{i32 786443, metadata !1, metadata !79, i32 37, i32 28, i32 0, i32 22} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_analyse_other.c]
!86 = metadata !{i32 39, i32 12, metadata !87, null}
!87 = metadata !{i32 786443, metadata !1, metadata !84, i32 39, i32 12, i32 0, i32 24} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_analyse_other.c]
!88 = metadata !{i32 38, i32 25, metadata !84, null}
!89 = metadata !{i32 41, i32 10, metadata !90, null}
!90 = metadata !{i32 786443, metadata !1, metadata !85, i32 41, i32 10, i32 0, i32 25} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_analyse_other.c]
!91 = metadata !{i32 42, i32 8, metadata !92, null}
!92 = metadata !{i32 786443, metadata !1, metadata !90, i32 41, i32 21, i32 0, i32 26} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_analyse_other.c]
!93 = metadata !{i32 786688, metadata !4, metadata !"natp", metadata !5, i32 9, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [natp] [line 9]
!94 = metadata !{i32 9, i32 33, metadata !4, null}
!95 = metadata !{i32 37, i32 23, metadata !79, null}
!96 = metadata !{i32 786688, metadata !4, metadata !"k", metadata !5, i32 9, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [k] [line 9]
!97 = metadata !{i32 9, i32 12, metadata !4, null}
!98 = metadata !{i32 45, i32 8, metadata !99, null}
!99 = metadata !{i32 786443, metadata !1, metadata !80, i32 45, i32 8, i32 0, i32 27} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_analyse_other.c]
!100 = metadata !{i32 46, i32 10, metadata !101, null}
!101 = metadata !{i32 786443, metadata !1, metadata !102, i32 46, i32 10, i32 2, i32 53} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_analyse_other.c]
!102 = metadata !{i32 786443, metadata !1, metadata !103, i32 46, i32 10, i32 1, i32 50} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_analyse_other.c]
!103 = metadata !{i32 786443, metadata !1, metadata !104, i32 46, i32 6, i32 0, i32 29} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_analyse_other.c]
!104 = metadata !{i32 786443, metadata !1, metadata !99, i32 45, i32 18, i32 0, i32 28} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_analyse_other.c]
!105 = metadata !{i32 48, i32 12, metadata !106, null}
!106 = metadata !{i32 786443, metadata !1, metadata !107, i32 48, i32 12, i32 2, i32 52} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_analyse_other.c]
!107 = metadata !{i32 786443, metadata !1, metadata !108, i32 48, i32 12, i32 1, i32 51} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_analyse_other.c]
!108 = metadata !{i32 786443, metadata !1, metadata !109, i32 48, i32 8, i32 0, i32 31} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_analyse_other.c]
!109 = metadata !{i32 786443, metadata !1, metadata !103, i32 46, i32 30, i32 0, i32 30} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_analyse_other.c]
!110 = metadata !{i32 49, i32 7, metadata !111, null}
!111 = metadata !{i32 786443, metadata !1, metadata !112, i32 49, i32 7, i32 0, i32 33} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_analyse_other.c]
!112 = metadata !{i32 786443, metadata !1, metadata !108, i32 48, i32 32, i32 0, i32 32} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_analyse_other.c]
!113 = metadata !{i32 50, i32 5, metadata !111, null}
!114 = metadata !{i32 48, i32 27, metadata !108, null}
!115 = metadata !{i32 46, i32 25, metadata !103, null}
!116 = metadata !{i32 786688, metadata !4, metadata !"l", metadata !5, i32 9, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [l] [line 9]
!117 = metadata !{i32 9, i32 14, metadata !4, null}
!118 = metadata !{i32 28, i32 26, metadata !60, null}
!119 = metadata !{i32 58, i32 1, metadata !4, null} ; [ DW_TAG_imported_module ]

