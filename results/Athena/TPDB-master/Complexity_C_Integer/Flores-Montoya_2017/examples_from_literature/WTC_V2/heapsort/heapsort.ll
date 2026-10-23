; ModuleID = 'heapsort.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind uwtable
define i32 @heapsort(i32 %size) #0 {
heapsort_bb0:
  call void @llvm.dbg.value(metadata !{i32 %size}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !14, i64 0, metadata !15), !dbg !16
  call void @llvm.dbg.value(metadata !{i32 %"2"}, i64 0, metadata !17), !dbg !18
  call void @llvm.dbg.value(metadata !{i32 %"4"}, i64 0, metadata !19), !dbg !20
  call void @llvm.dbg.value(metadata !{i32 %"2"}, i64 0, metadata !21), !dbg !22
  call void @llvm.dbg.value(metadata !{i32 %i.0}, i64 0, metadata !21), !dbg !22
  call void @llvm.dbg.value(metadata !{i32 %"4"}, i64 0, metadata !21), !dbg !22
  call void @llvm.dbg.value(metadata !{i32 %max.3}, i64 0, metadata !15), !dbg !16
  call void @llvm.dbg.value(metadata !{i32 %i.0}, i64 0, metadata !21), !dbg !22
  br label %heapsort_bb1, !dbg !23

heapsort_bb1:                                     ; preds = %heapsort_bb10, %heapsort_bb0
  %i.0 = phi i32 [ 1, %heapsort_bb0 ], [ %max.3, %heapsort_bb10 ]
  %"0" = icmp sgt i32 %size, 0, !dbg !24
  %"1" = icmp sge i32 %i.0, 1, !dbg !26
  %. = select i1 %"0", i1 %"1", i1 false, !dbg !24
  br i1 %., label %heapsort_bb2, label %heapsort_bb11, !dbg !28

heapsort_bb2:                                     ; preds = %heapsort_bb1
  %"2" = mul nsw i32 2, %i.0, !dbg !30
  %"3" = mul nsw i32 2, %i.0, !dbg !32
  %"4" = add nsw i32 %"3", 1, !dbg !32
  %"5" = icmp sle i32 %"2", %size, !dbg !33
  br i1 %"5", label %heapsort_bb3, label %heapsort_bb5, !dbg !33

heapsort_bb3:                                     ; preds = %heapsort_bb2
  %"6" = icmp slt i32 %"2", 1, !dbg !35
  %"7" = icmp sgt i32 %"2", %size, !dbg !38
  %or.cond = or i1 %"6", %"7", !dbg !35
  br i1 %or.cond, label %heapsort_bb11, label %heapsort_bb4, !dbg !35

heapsort_bb4:                                     ; preds = %heapsort_bb3
  %"8" = call i32 (...)* @nondet(), !dbg !40
  %"9" = icmp sgt i32 %"8", 0, !dbg !40
  %.i.0 = select i1 %"9", i32 %"2", i32 %i.0, !dbg !42
  br label %heapsort_bb5, !dbg !44

heapsort_bb5:                                     ; preds = %heapsort_bb2, %heapsort_bb4
  %max.1 = phi i32 [ %.i.0, %heapsort_bb4 ], [ %i.0, %heapsort_bb2 ]
  %"10" = icmp sle i32 %"4", %size, !dbg !45
  br i1 %"10", label %heapsort_bb6, label %heapsort_bb8, !dbg !45

heapsort_bb6:                                     ; preds = %heapsort_bb5
  %"11" = icmp slt i32 %"4", 1, !dbg !47
  %"12" = icmp sgt i32 %"4", %size, !dbg !50
  %or.cond1 = or i1 %"11", %"12", !dbg !47
  br i1 %or.cond1, label %heapsort_bb11, label %heapsort_bb7, !dbg !47

heapsort_bb7:                                     ; preds = %heapsort_bb6
  %"13" = call i32 (...)* @nondet(), !dbg !52
  %"14" = icmp sgt i32 %"13", 0, !dbg !52
  %.max.1 = select i1 %"14", i32 %"4", i32 %max.1, !dbg !52
  br label %heapsort_bb8, !dbg !54

heapsort_bb8:                                     ; preds = %heapsort_bb7, %heapsort_bb5
  %max.3 = phi i32 [ %.max.1, %heapsort_bb7 ], [ %max.1, %heapsort_bb5 ]
  %"15" = icmp ne i32 %i.0, %max.3, !dbg !55
  br i1 %"15", label %heapsort_bb9, label %heapsort_bb11, !dbg !55

heapsort_bb9:                                     ; preds = %heapsort_bb8
  %"16" = icmp slt i32 %i.0, 1, !dbg !57
  %"17" = icmp sgt i32 %i.0, %size, !dbg !60
  %or.cond2 = or i1 %"16", %"17", !dbg !57
  br i1 %or.cond2, label %heapsort_bb11, label %heapsort_bb10, !dbg !57

heapsort_bb10:                                    ; preds = %heapsort_bb9
  %"18" = icmp slt i32 %max.3, 1, !dbg !62
  %"19" = icmp sgt i32 %max.3, %size, !dbg !64
  %or.cond3 = or i1 %"18", %"19", !dbg !62
  br i1 %or.cond3, label %heapsort_bb11, label %heapsort_bb1, !dbg !62

heapsort_bb11:                                    ; preds = %heapsort_bb1, %heapsort_bb8, %heapsort_bb10, %heapsort_bb9, %heapsort_bb6, %heapsort_bb3
  ret i32 0, !dbg !66
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

!0 = metadata !{i32 786449, metadata !1, i32 12, metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)", i1 false, metadata !"", i32 0, metadata !2, metadata !2, metadata !3, metadata !2, metadata !2, metadata !"", i32 1} ; [ DW_TAG_compile_unit ] [/liveness_analysis/heapsort.c] [DW_LANG_C99]
!1 = metadata !{metadata !"heapsort.c", metadata !"/liveness_analysis"}
!2 = metadata !{}
!3 = metadata !{metadata !4}
!4 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"heapsort", metadata !"heapsort", metadata !"", i32 3, metadata !6, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, i32 (i32)* @heapsort, null, null, metadata !2, i32 3} ; [ DW_TAG_subprogram ] [line 3] [def] [heapsort]
!5 = metadata !{i32 786473, metadata !1}          ; [ DW_TAG_file_type ] [/liveness_analysis/heapsort.c]
!6 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !7, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!7 = metadata !{metadata !8, metadata !8}
!8 = metadata !{i32 786468, null, null, metadata !"int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!9 = metadata !{i32 2, metadata !"Dwarf Version", i32 4}
!10 = metadata !{i32 2, metadata !"Debug Info Version", i32 1}
!11 = metadata !{metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)"}
!12 = metadata !{i32 786689, metadata !4, metadata !"size", metadata !5, i32 16777219, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [size] [line 3]
!13 = metadata !{i32 3, i32 18, metadata !4, null}
!14 = metadata !{i32 1}
!15 = metadata !{i32 786688, metadata !4, metadata !"i", metadata !5, i32 4, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [i] [line 4]
!16 = metadata !{i32 4, i32 7, metadata !4, null}
!17 = metadata !{i32 786688, metadata !4, metadata !"l", metadata !5, i32 5, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [l] [line 5]
!18 = metadata !{i32 5, i32 7, metadata !4, null}
!19 = metadata !{i32 786688, metadata !4, metadata !"r", metadata !5, i32 5, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [r] [line 5]
!20 = metadata !{i32 5, i32 9, metadata !4, null}
!21 = metadata !{i32 786688, metadata !4, metadata !"max", metadata !5, i32 5, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [max] [line 5]
!22 = metadata !{i32 5, i32 11, metadata !4, null}
!23 = metadata !{i32 6, i32 3, metadata !4, null}
!24 = metadata !{i32 6, i32 3, metadata !25, null}
!25 = metadata !{i32 786443, metadata !1, metadata !4, i32 6, i32 3, i32 1, i32 13} ; [ DW_TAG_lexical_block ] [/liveness_analysis/heapsort.c]
!26 = metadata !{i32 6, i32 3, metadata !27, null}
!27 = metadata !{i32 786443, metadata !1, metadata !4, i32 6, i32 3, i32 2, i32 14} ; [ DW_TAG_lexical_block ] [/liveness_analysis/heapsort.c]
!28 = metadata !{i32 6, i32 3, metadata !29, null}
!29 = metadata !{i32 786443, metadata !1, metadata !4, i32 6, i32 3, i32 3, i32 15} ; [ DW_TAG_lexical_block ] [/liveness_analysis/heapsort.c]
!30 = metadata !{i32 7, i32 5, metadata !31, null}
!31 = metadata !{i32 786443, metadata !1, metadata !4, i32 6, i32 27, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/liveness_analysis/heapsort.c]
!32 = metadata !{i32 8, i32 5, metadata !31, null} ; [ DW_TAG_imported_declaration ]
!33 = metadata !{i32 10, i32 9, metadata !34, null}
!34 = metadata !{i32 786443, metadata !1, metadata !31, i32 10, i32 9, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/liveness_analysis/heapsort.c]
!35 = metadata !{i32 12, i32 11, metadata !36, null}
!36 = metadata !{i32 786443, metadata !1, metadata !37, i32 12, i32 11, i32 0, i32 3} ; [ DW_TAG_lexical_block ] [/liveness_analysis/heapsort.c]
!37 = metadata !{i32 786443, metadata !1, metadata !34, i32 11, i32 5, i32 0, i32 2} ; [ DW_TAG_lexical_block ] [/liveness_analysis/heapsort.c]
!38 = metadata !{i32 12, i32 11, metadata !39, null}
!39 = metadata !{i32 786443, metadata !1, metadata !36, i32 12, i32 11, i32 2, i32 17} ; [ DW_TAG_lexical_block ] [/liveness_analysis/heapsort.c]
!40 = metadata !{i32 13, i32 11, metadata !41, null}
!41 = metadata !{i32 786443, metadata !1, metadata !37, i32 13, i32 11, i32 0, i32 4} ; [ DW_TAG_lexical_block ] [/liveness_analysis/heapsort.c]
!42 = metadata !{i32 13, i32 23, metadata !43, null}
!43 = metadata !{i32 786443, metadata !1, metadata !41, i32 13, i32 23, i32 1, i32 19} ; [ DW_TAG_lexical_block ] [/liveness_analysis/heapsort.c]
!44 = metadata !{i32 14, i32 5, metadata !37, null}
!45 = metadata !{i32 17, i32 9, metadata !46, null}
!46 = metadata !{i32 786443, metadata !1, metadata !31, i32 17, i32 9, i32 0, i32 5} ; [ DW_TAG_lexical_block ] [/liveness_analysis/heapsort.c]
!47 = metadata !{i32 19, i32 11, metadata !48, null}
!48 = metadata !{i32 786443, metadata !1, metadata !49, i32 19, i32 11, i32 0, i32 7} ; [ DW_TAG_lexical_block ] [/liveness_analysis/heapsort.c]
!49 = metadata !{i32 786443, metadata !1, metadata !46, i32 18, i32 5, i32 0, i32 6} ; [ DW_TAG_lexical_block ] [/liveness_analysis/heapsort.c]
!50 = metadata !{i32 19, i32 11, metadata !51, null}
!51 = metadata !{i32 786443, metadata !1, metadata !48, i32 19, i32 11, i32 2, i32 22} ; [ DW_TAG_lexical_block ] [/liveness_analysis/heapsort.c]
!52 = metadata !{i32 20, i32 11, metadata !53, null}
!53 = metadata !{i32 786443, metadata !1, metadata !49, i32 20, i32 11, i32 0, i32 8} ; [ DW_TAG_lexical_block ] [/liveness_analysis/heapsort.c]
!54 = metadata !{i32 21, i32 5, metadata !49, null}
!55 = metadata !{i32 23, i32 9, metadata !56, null}
!56 = metadata !{i32 786443, metadata !1, metadata !31, i32 23, i32 9, i32 0, i32 9} ; [ DW_TAG_lexical_block ] [/liveness_analysis/heapsort.c]
!57 = metadata !{i32 25, i32 11, metadata !58, null}
!58 = metadata !{i32 786443, metadata !1, metadata !59, i32 25, i32 11, i32 0, i32 11} ; [ DW_TAG_lexical_block ] [/liveness_analysis/heapsort.c]
!59 = metadata !{i32 786443, metadata !1, metadata !56, i32 24, i32 5, i32 0, i32 10} ; [ DW_TAG_lexical_block ] [/liveness_analysis/heapsort.c]
!60 = metadata !{i32 25, i32 11, metadata !61, null}
!61 = metadata !{i32 786443, metadata !1, metadata !58, i32 25, i32 11, i32 2, i32 26} ; [ DW_TAG_lexical_block ] [/liveness_analysis/heapsort.c]
!62 = metadata !{i32 26, i32 11, metadata !63, null}
!63 = metadata !{i32 786443, metadata !1, metadata !59, i32 26, i32 11, i32 0, i32 12} ; [ DW_TAG_lexical_block ] [/liveness_analysis/heapsort.c]
!64 = metadata !{i32 26, i32 11, metadata !65, null}
!65 = metadata !{i32 786443, metadata !1, metadata !63, i32 26, i32 11, i32 2, i32 29} ; [ DW_TAG_lexical_block ] [/liveness_analysis/heapsort.c]
!66 = metadata !{i32 33, i32 1, metadata !4, null}

