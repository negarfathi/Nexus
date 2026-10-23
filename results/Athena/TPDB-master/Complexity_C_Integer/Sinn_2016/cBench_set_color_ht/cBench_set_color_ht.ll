; ModuleID = 'cBench_set_color_ht.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind uwtable
define void @set_color_ht_extracted(i32 %h, i32 %w) #0 {
set_color_ht_extracted_bb0:
  call void @llvm.dbg.value(metadata !{i32 %h}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !{i32 %w}, i64 0, metadata !14), !dbg !15
  call void @llvm.dbg.value(metadata !{i32 %h}, i64 0, metadata !16), !dbg !18
  call void @llvm.dbg.value(metadata !{i32 %"0"}, i64 0, metadata !16), !dbg !18
  call void @llvm.dbg.value(metadata !{i32 %w}, i64 0, metadata !19), !dbg !22
  call void @llvm.dbg.value(metadata !{i32 %x.0.}, i64 0, metadata !23), !dbg !25
  call void @llvm.dbg.value(metadata !{i32 %"3"}, i64 0, metadata !19), !dbg !22
  call void @llvm.dbg.value(metadata !{i32 %x.0.}, i64 0, metadata !26), !dbg !28
  call void @llvm.dbg.value(metadata !{i32 %"4"}, i64 0, metadata !26), !dbg !28
  br label %set_color_ht_extracted_bb1, !dbg !29

set_color_ht_extracted_bb1:                       ; preds = %set_color_ht_extracted_bb5, %set_color_ht_extracted_bb0
  %y.0 = phi i32 [ %h, %set_color_ht_extracted_bb0 ], [ %"0", %set_color_ht_extracted_bb5 ]
  %"0" = add nsw i32 %y.0, -1, !dbg !30
  br label %set_color_ht_extracted_bb2, !dbg !31

set_color_ht_extracted_bb2:                       ; preds = %set_color_ht_extracted_bb4, %set_color_ht_extracted_bb1
  %x.0 = phi i32 [ %w, %set_color_ht_extracted_bb1 ], [ %"3", %set_color_ht_extracted_bb4 ]
  %"1" = icmp sgt i32 %x.0, 0, !dbg !32
  br i1 %"1", label %set_color_ht_extracted_bb3, label %set_color_ht_extracted_bb5, !dbg !32

set_color_ht_extracted_bb3:                       ; preds = %set_color_ht_extracted_bb2
  %"2" = icmp slt i32 %x.0, 8, !dbg !34
  %x.0. = select i1 %"2", i32 %x.0, i32 8, !dbg !35
  %"3" = sub nsw i32 %x.0, %x.0., !dbg !37
  br label %set_color_ht_extracted_bb4, !dbg !38

set_color_ht_extracted_bb4:                       ; preds = %set_color_ht_extracted_bb4, %set_color_ht_extracted_bb3
  %i.0 = phi i32 [ %x.0., %set_color_ht_extracted_bb3 ], [ %"4", %set_color_ht_extracted_bb4 ]
  %"4" = add nsw i32 %i.0, -1, !dbg !39
  %"5" = icmp sge i32 %"4", 0, !dbg !39
  br i1 %"5", label %set_color_ht_extracted_bb4, label %set_color_ht_extracted_bb2, !dbg !39

set_color_ht_extracted_bb5:                       ; preds = %set_color_ht_extracted_bb2
  %"6" = icmp sle i32 %"0", 0, !dbg !42
  br i1 %"6", label %set_color_ht_extracted_bb6, label %set_color_ht_extracted_bb1, !dbg !42

set_color_ht_extracted_bb6:                       ; preds = %set_color_ht_extracted_bb5
  ret void, !dbg !44
}

; Function Attrs: nounwind readnone
declare void @llvm.dbg.declare(metadata, metadata) #1

declare i32 @__kittel_nondef.0()

; Function Attrs: nounwind readnone
declare void @llvm.dbg.value(metadata, i64, metadata) #1

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!9, !10}
!llvm.ident = !{!11}

!0 = metadata !{i32 786449, metadata !1, i32 12, metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)", i1 false, metadata !"", i32 0, metadata !2, metadata !2, metadata !3, metadata !2, metadata !2, metadata !"", i32 1} ; [ DW_TAG_compile_unit ] [/liveness_analysis/cBench_set_color_ht.c] [DW_LANG_C99]
!1 = metadata !{metadata !"cBench_set_color_ht.c", metadata !"/liveness_analysis"}
!2 = metadata !{}
!3 = metadata !{metadata !4}
!4 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"set_color_ht_extracted", metadata !"set_color_ht_extracted", metadata !"", i32 4, metadata !6, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (i32, i32)* @set_color_ht_extracted, null, null, metadata !2, i32 4} ; [ DW_TAG_subprogram ] [line 4] [def] [set_color_ht_extracted]
!5 = metadata !{i32 786473, metadata !1}          ; [ DW_TAG_file_type ] [/liveness_analysis/cBench_set_color_ht.c]
!6 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !7, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!7 = metadata !{null, metadata !8, metadata !8}
!8 = metadata !{i32 786468, null, null, metadata !"int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!9 = metadata !{i32 2, metadata !"Dwarf Version", i32 4}
!10 = metadata !{i32 2, metadata !"Debug Info Version", i32 1}
!11 = metadata !{metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)"}
!12 = metadata !{i32 786689, metadata !4, metadata !"h", metadata !5, i32 16777220, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [h] [line 4]
!13 = metadata !{i32 4, i32 33, metadata !4, null}
!14 = metadata !{i32 786689, metadata !4, metadata !"w", metadata !5, i32 33554436, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [w] [line 4]
!15 = metadata !{i32 4, i32 40, metadata !4, null}
!16 = metadata !{i32 786688, metadata !17, metadata !"y", metadata !5, i32 5, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [y] [line 5]
!17 = metadata !{i32 786443, metadata !1, metadata !4, i32 5, i32 5, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_set_color_ht.c]
!18 = metadata !{i32 5, i32 14, metadata !17, null}
!19 = metadata !{i32 786688, metadata !20, metadata !"x", metadata !5, i32 7, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [x] [line 7]
!20 = metadata !{i32 786443, metadata !1, metadata !21, i32 7, i32 2, i32 0, i32 2} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_set_color_ht.c]
!21 = metadata !{i32 786443, metadata !1, metadata !17, i32 5, i32 24, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_set_color_ht.c]
!22 = metadata !{i32 7, i32 11, metadata !20, null}
!23 = metadata !{i32 786688, metadata !24, metadata !"nx", metadata !5, i32 8, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [nx] [line 8]
!24 = metadata !{i32 786443, metadata !1, metadata !20, i32 7, i32 26, i32 0, i32 3} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_set_color_ht.c]
!25 = metadata !{i32 8, i32 7, metadata !24, null} ; [ DW_TAG_imported_declaration ]
!26 = metadata !{i32 786688, metadata !27, metadata !"i", metadata !5, i32 10, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [i] [line 10]
!27 = metadata !{i32 786443, metadata !1, metadata !24, i32 10, i32 3, i32 0, i32 4} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_set_color_ht.c]
!28 = metadata !{i32 10, i32 12, metadata !27, null}
!29 = metadata !{i32 5, i32 10, metadata !17, null}
!30 = metadata !{i32 6, i32 2, metadata !21, null}
!31 = metadata !{i32 7, i32 7, metadata !20, null}
!32 = metadata !{i32 7, i32 7, metadata !33, null}
!33 = metadata !{i32 786443, metadata !1, metadata !20, i32 7, i32 7, i32 1, i32 6} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_set_color_ht.c]
!34 = metadata !{i32 8, i32 3, metadata !24, null} ; [ DW_TAG_imported_declaration ]
!35 = metadata !{i32 8, i32 3, metadata !36, null} ; [ DW_TAG_imported_declaration ]
!36 = metadata !{i32 786443, metadata !1, metadata !24, i32 8, i32 3, i32 1, i32 7} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_set_color_ht.c]
!37 = metadata !{i32 9, i32 3, metadata !24, null}
!38 = metadata !{i32 10, i32 8, metadata !27, null}
!39 = metadata !{i32 10, i32 8, metadata !40, null}
!40 = metadata !{i32 786443, metadata !1, metadata !41, i32 10, i32 8, i32 3, i32 13} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_set_color_ht.c]
!41 = metadata !{i32 786443, metadata !1, metadata !27, i32 10, i32 8, i32 1, i32 11} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_set_color_ht.c]
!42 = metadata !{i32 12, i32 6, metadata !43, null}
!43 = metadata !{i32 786443, metadata !1, metadata !21, i32 12, i32 6, i32 0, i32 5} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_set_color_ht.c]
!44 = metadata !{i32 15, i32 1, metadata !4, null}

