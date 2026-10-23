; ModuleID = 'cBench_hc_compute.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind uwtable
define void @hc_compute(i32 %num_values) #0 {
hc_compute_bb0:
  call void @llvm.dbg.value(metadata !{i32 %num_values}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !{i32 %num_values}, i64 0, metadata !14), !dbg !16
  call void @llvm.dbg.value(metadata !{i32 %i.0}, i64 0, metadata !17), !dbg !19
  call void @llvm.dbg.value(metadata !{i32 %"1"}, i64 0, metadata !17), !dbg !19
  br label %hc_compute_bb1, !dbg !20

hc_compute_bb1:                                   ; preds = %hc_compute_bb4, %hc_compute_bb0
  %i.0 = phi i32 [ %num_values, %hc_compute_bb0 ], [ %"1", %hc_compute_bb4 ]
  %"0" = icmp sgt i32 %i.0, 0, !dbg !21
  br i1 %"0", label %hc_compute_bb2, label %hc_compute_bb8, !dbg !21

hc_compute_bb2:                                   ; preds = %hc_compute_bb1, %hc_compute_bb3
  %i.0.sink = phi i32 [ %"1", %hc_compute_bb3 ], [ %i.0, %hc_compute_bb1 ]
  %"1" = add nsw i32 %i.0.sink, -1, !dbg !23
  %"2" = icmp sgt i32 %"1", 0, !dbg !24
  br i1 %"2", label %hc_compute_bb3, label %hc_compute_.critedge, !dbg !24

hc_compute_bb3:                                   ; preds = %hc_compute_bb2
  %"3" = call i32 (...)* @random(), !dbg !26
  %"4" = icmp ne i32 %"3", 0, !dbg !26
  br i1 %"4", label %hc_compute_bb2, label %hc_compute_.critedge, !dbg !28

hc_compute_.critedge:                             ; preds = %hc_compute_bb2, %hc_compute_bb3
  %"5" = sub nsw i32 %i.0, %"1", !dbg !30
  call void @llvm.dbg.value(metadata !{i32 %"5"}, i64 0, metadata !32), !dbg !33
  call void @llvm.dbg.value(metadata !{i32 %x.0}, i64 0, metadata !34), !dbg !36
  call void @llvm.dbg.value(metadata !{i32 %"10"}, i64 0, metadata !34), !dbg !36
  br label %hc_compute_bb4, !dbg !30

hc_compute_bb4:                                   ; preds = %hc_compute_.critedge1, %hc_compute_.critedge
  %x.0 = phi i32 [ %"5", %hc_compute_.critedge ], [ %"11", %hc_compute_.critedge1 ]
  %"6" = icmp sgt i32 %x.0, 0, !dbg !37
  br i1 %"6", label %hc_compute_bb5, label %hc_compute_bb1, !dbg !37

hc_compute_bb5:                                   ; preds = %hc_compute_bb4, %hc_compute_bb7
  %y.0 = phi i32 [ %"10", %hc_compute_bb7 ], [ %x.0, %hc_compute_bb4 ]
  %"7" = icmp sgt i32 %y.0, 0, !dbg !40
  br i1 %"7", label %hc_compute_bb6, label %hc_compute_.critedge1, !dbg !40

hc_compute_bb6:                                   ; preds = %hc_compute_bb5
  %"8" = call i32 (...)* @random(), !dbg !43
  %"9" = icmp ne i32 %"8", 0, !dbg !43
  br i1 %"9", label %hc_compute_bb7, label %hc_compute_.critedge1, !dbg !45

hc_compute_bb7:                                   ; preds = %hc_compute_bb6
  %"10" = add nsw i32 %y.0, -1, !dbg !47
  br label %hc_compute_bb5, !dbg !47

hc_compute_.critedge1:                            ; preds = %hc_compute_bb6, %hc_compute_bb5
  %"11" = add nsw i32 %x.0, -1, !dbg !49
  call void @llvm.dbg.value(metadata !{i32 %"11"}, i64 0, metadata !32), !dbg !33
  br label %hc_compute_bb4, !dbg !49

hc_compute_bb8:                                   ; preds = %hc_compute_bb1
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

!0 = metadata !{i32 786449, metadata !1, i32 12, metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)", i1 false, metadata !"", i32 0, metadata !2, metadata !2, metadata !3, metadata !2, metadata !2, metadata !"", i32 1} ; [ DW_TAG_compile_unit ] [/liveness_analysis/cBench_hc_compute.c] [DW_LANG_C99]
!1 = metadata !{metadata !"cBench_hc_compute.c", metadata !"/liveness_analysis"}
!2 = metadata !{}
!3 = metadata !{metadata !4}
!4 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"hc_compute", metadata !"hc_compute", metadata !"", i32 5, metadata !6, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (i32)* @hc_compute, null, null, metadata !2, i32 5} ; [ DW_TAG_subprogram ] [line 5] [def] [hc_compute]
!5 = metadata !{i32 786473, metadata !1}          ; [ DW_TAG_file_type ] [/liveness_analysis/cBench_hc_compute.c]
!6 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !7, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!7 = metadata !{null, metadata !8}
!8 = metadata !{i32 786468, null, null, metadata !"int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!9 = metadata !{i32 2, metadata !"Dwarf Version", i32 4}
!10 = metadata !{i32 2, metadata !"Debug Info Version", i32 1}
!11 = metadata !{metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)"}
!12 = metadata !{i32 786689, metadata !4, metadata !"num_values", metadata !5, i32 16777221, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [num_values] [line 5]
!13 = metadata !{i32 5, i32 21, metadata !4, null}
!14 = metadata !{i32 786688, metadata !15, metadata !"i", metadata !5, i32 6, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [i] [line 6]
!15 = metadata !{i32 786443, metadata !1, metadata !4, i32 6, i32 5, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_hc_compute.c]
!16 = metadata !{i32 6, i32 14, metadata !15, null}
!17 = metadata !{i32 786688, metadata !18, metadata !"j", metadata !5, i32 7, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [j] [line 7]
!18 = metadata !{i32 786443, metadata !1, metadata !15, i32 6, i32 38, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_hc_compute.c]
!19 = metadata !{i32 7, i32 6, metadata !18, null}
!20 = metadata !{i32 6, i32 10, metadata !15, null}
!21 = metadata !{i32 6, i32 10, metadata !22, null}
!22 = metadata !{i32 786443, metadata !1, metadata !15, i32 6, i32 10, i32 1, i32 4} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_hc_compute.c]
!23 = metadata !{i32 8, i32 2, metadata !18, null} ; [ DW_TAG_imported_declaration ]
!24 = metadata !{i32 9, i32 2, metadata !25, null}
!25 = metadata !{i32 786443, metadata !1, metadata !18, i32 9, i32 2, i32 1, i32 5} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_hc_compute.c]
!26 = metadata !{i32 9, i32 18, metadata !27, null}
!27 = metadata !{i32 786443, metadata !1, metadata !18, i32 9, i32 18, i32 2, i32 6} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_hc_compute.c]
!28 = metadata !{i32 9, i32 18, metadata !29, null}
!29 = metadata !{i32 786443, metadata !1, metadata !18, i32 9, i32 18, i32 3, i32 7} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_hc_compute.c]
!30 = metadata !{i32 12, i32 6, metadata !31, null}
!31 = metadata !{i32 786443, metadata !1, metadata !18, i32 12, i32 2, i32 0, i32 2} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_hc_compute.c]
!32 = metadata !{i32 786688, metadata !31, metadata !"x", metadata !5, i32 12, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [x] [line 12]
!33 = metadata !{i32 12, i32 10, metadata !31, null}
!34 = metadata !{i32 786688, metadata !35, metadata !"y", metadata !5, i32 13, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [y] [line 13]
!35 = metadata !{i32 786443, metadata !1, metadata !31, i32 13, i32 3, i32 0, i32 3} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_hc_compute.c]
!36 = metadata !{i32 13, i32 11, metadata !35, null}
!37 = metadata !{i32 12, i32 6, metadata !38, null}
!38 = metadata !{i32 786443, metadata !1, metadata !39, i32 12, i32 6, i32 2, i32 16} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_hc_compute.c]
!39 = metadata !{i32 786443, metadata !1, metadata !31, i32 12, i32 6, i32 1, i32 8} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_hc_compute.c]
!40 = metadata !{i32 13, i32 7, metadata !41, null}
!41 = metadata !{i32 786443, metadata !1, metadata !42, i32 13, i32 7, i32 7, i32 15} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_hc_compute.c]
!42 = metadata !{i32 786443, metadata !1, metadata !35, i32 13, i32 7, i32 1, i32 9} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_hc_compute.c]
!43 = metadata !{i32 13, i32 27, metadata !44, null}
!44 = metadata !{i32 786443, metadata !1, metadata !35, i32 13, i32 27, i32 2, i32 10} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_hc_compute.c]
!45 = metadata !{i32 13, i32 27, metadata !46, null}
!46 = metadata !{i32 786443, metadata !1, metadata !35, i32 13, i32 27, i32 3, i32 11} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_hc_compute.c]
!47 = metadata !{i32 13, i32 37, metadata !48, null}
!48 = metadata !{i32 786443, metadata !1, metadata !35, i32 13, i32 37, i32 6, i32 14} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_hc_compute.c]
!49 = metadata !{i32 12, i32 28, metadata !31, null}
!50 = metadata !{i32 16, i32 1, metadata !4, null}

