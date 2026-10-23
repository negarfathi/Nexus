; ModuleID = 'wcet1.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind uwtable
define i32 @wcet1(i32 %n) #0 {
wcet1_bb0:
  call void @llvm.dbg.value(metadata !{i32 %n}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !14, i64 0, metadata !15), !dbg !16
  call void @llvm.dbg.value(metadata !{i32 %n}, i64 0, metadata !17), !dbg !18
  %"0" = icmp sge i32 %n, 1, !dbg !19
  br i1 %"0", label %wcet1_bb1, label %wcet1_bb5, !dbg !19

wcet1_bb1:                                        ; preds = %wcet1_bb0, %wcet1_bb4
  %j.0 = phi i32 [ %j.3, %wcet1_bb4 ], [ 0, %wcet1_bb0 ]
  %i.0 = phi i32 [ %"7", %wcet1_bb4 ], [ %n, %wcet1_bb0 ]
  %"1" = call i32 (...)* @nondet(), !dbg !21
  %"2" = icmp sgt i32 %"1", 0, !dbg !21
  br i1 %"2", label %wcet1_bb2, label %wcet1_bb3, !dbg !21

wcet1_bb2:                                        ; preds = %wcet1_bb1
  %"3" = add nsw i32 %j.0, 1, !dbg !24
  %"4" = icmp sge i32 %"3", %n, !dbg !26
  %. = select i1 %"4", i32 0, i32 %"3", !dbg !26
  br label %wcet1_bb4, !dbg !28

wcet1_bb3:                                        ; preds = %wcet1_bb1
  %"5" = add nsw i32 %j.0, -1, !dbg !29
  %"6" = icmp sle i32 %"5", 0, !dbg !31
  %.1 = select i1 %"6", i32 0, i32 %"5", !dbg !31
  br label %wcet1_bb4

wcet1_bb4:                                        ; preds = %wcet1_bb3, %wcet1_bb2
  %j.3 = phi i32 [ %., %wcet1_bb2 ], [ %.1, %wcet1_bb3 ]
  %"7" = add nsw i32 %i.0, -1, !dbg !33
  %"8" = icmp sgt i32 %"7", 0, !dbg !34
  br i1 %"8", label %wcet1_bb1, label %wcet1_bb5, !dbg !34

wcet1_bb5:                                        ; preds = %wcet1_bb4, %wcet1_bb0
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

!0 = metadata !{i32 786449, metadata !1, i32 12, metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)", i1 false, metadata !"", i32 0, metadata !2, metadata !2, metadata !3, metadata !2, metadata !2, metadata !"", i32 1} ; [ DW_TAG_compile_unit ] [/liveness_analysis/wcet1.c] [DW_LANG_C99]
!1 = metadata !{metadata !"wcet1.c", metadata !"/liveness_analysis"}
!2 = metadata !{}
!3 = metadata !{metadata !4}
!4 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"wcet1", metadata !"wcet1", metadata !"", i32 3, metadata !6, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, i32 (i32)* @wcet1, null, null, metadata !2, i32 3} ; [ DW_TAG_subprogram ] [line 3] [def] [wcet1]
!5 = metadata !{i32 786473, metadata !1}          ; [ DW_TAG_file_type ] [/liveness_analysis/wcet1.c]
!6 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !7, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!7 = metadata !{metadata !8, metadata !8}
!8 = metadata !{i32 786468, null, null, metadata !"int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!9 = metadata !{i32 2, metadata !"Dwarf Version", i32 4}
!10 = metadata !{i32 2, metadata !"Debug Info Version", i32 1}
!11 = metadata !{metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)"}
!12 = metadata !{i32 786689, metadata !4, metadata !"n", metadata !5, i32 16777219, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [n] [line 3]
!13 = metadata !{i32 3, i32 16, metadata !4, null}
!14 = metadata !{i32 0}
!15 = metadata !{i32 786688, metadata !4, metadata !"j", metadata !5, i32 4, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [j] [line 4]
!16 = metadata !{i32 4, i32 9, metadata !4, null}
!17 = metadata !{i32 786688, metadata !4, metadata !"i", metadata !5, i32 4, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [i] [line 4]
!18 = metadata !{i32 4, i32 7, metadata !4, null}
!19 = metadata !{i32 8, i32 7, metadata !20, null} ; [ DW_TAG_imported_declaration ]
!20 = metadata !{i32 786443, metadata !1, metadata !4, i32 8, i32 7, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/liveness_analysis/wcet1.c]
!21 = metadata !{i32 10, i32 11, metadata !22, null}
!22 = metadata !{i32 786443, metadata !1, metadata !23, i32 10, i32 11, i32 0, i32 2} ; [ DW_TAG_lexical_block ] [/liveness_analysis/wcet1.c]
!23 = metadata !{i32 786443, metadata !1, metadata !20, i32 9, i32 8, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/liveness_analysis/wcet1.c]
!24 = metadata !{i32 11, i32 4, metadata !25, null}
!25 = metadata !{i32 786443, metadata !1, metadata !22, i32 10, i32 22, i32 0, i32 3} ; [ DW_TAG_lexical_block ] [/liveness_analysis/wcet1.c]
!26 = metadata !{i32 12, i32 7, metadata !27, null}
!27 = metadata !{i32 786443, metadata !1, metadata !25, i32 12, i32 7, i32 0, i32 4} ; [ DW_TAG_lexical_block ] [/liveness_analysis/wcet1.c]
!28 = metadata !{i32 13, i32 2, metadata !25, null}
!29 = metadata !{i32 15, i32 2, metadata !30, null}
!30 = metadata !{i32 786443, metadata !1, metadata !22, i32 14, i32 12, i32 0, i32 5} ; [ DW_TAG_lexical_block ] [/liveness_analysis/wcet1.c]
!31 = metadata !{i32 16, i32 5, metadata !32, null}
!32 = metadata !{i32 786443, metadata !1, metadata !30, i32 16, i32 5, i32 0, i32 6} ; [ DW_TAG_lexical_block ] [/liveness_analysis/wcet1.c]
!33 = metadata !{i32 19, i32 7, metadata !23, null}
!34 = metadata !{i32 20, i32 5, metadata !35, null}
!35 = metadata !{i32 786443, metadata !1, metadata !23, i32 20, i32 5, i32 1, i32 9} ; [ DW_TAG_lexical_block ] [/liveness_analysis/wcet1.c]
!36 = metadata !{i32 23, i32 3, metadata !4, null}

