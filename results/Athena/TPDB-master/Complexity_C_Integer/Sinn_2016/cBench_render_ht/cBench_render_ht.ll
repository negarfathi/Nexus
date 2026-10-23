; ModuleID = 'cBench_render_ht.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind uwtable
define void @render_ht(i32 %level, i32 %old_level) #0 {
render_ht_bb0:
  call void @llvm.dbg.value(metadata !{i32 %level}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !{i32 %old_level}, i64 0, metadata !14), !dbg !15
  call void @llvm.dbg.value(metadata !{i32 %"2"}, i64 0, metadata !14), !dbg !15
  call void @llvm.dbg.value(metadata !{i32 %"3"}, i64 0, metadata !14), !dbg !15
  br label %render_ht_bb1, !dbg !16

render_ht_bb1:                                    ; preds = %render_ht_bb3, %render_ht_bb0
  %.0 = phi i32 [ %old_level, %render_ht_bb0 ], [ %.1, %render_ht_bb3 ]
  %"0" = sub nsw i32 %level, %.0, !dbg !17
  br label %render_ht_LeafBlock

render_ht_LeafBlock:                              ; preds = %render_ht_bb1
  %.off = add i32 %"0", 7
  %SwitchLeaf = icmp ule i32 %.off, 14
  br i1 %SwitchLeaf, label %render_ht_bb2, label %render_ht_NewDefault

render_ht_bb2:                                    ; preds = %render_ht_LeafBlock
  ret void, !dbg !18

render_ht_NewDefault:                             ; preds = %render_ht_LeafBlock
  br label %render_ht_bb3

render_ht_bb3:                                    ; preds = %render_ht_NewDefault
  %"1" = icmp sgt i32 %level, %.0, !dbg !19
  %"2" = add nsw i32 %.0, 4, !dbg !22
  %"3" = sub nsw i32 %.0, 4, !dbg !24
  %.1 = select i1 %"1", i32 %"2", i32 %"3", !dbg !19
  br label %render_ht_bb1, !dbg !19
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

!0 = metadata !{i32 786449, metadata !1, i32 12, metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)", i1 false, metadata !"", i32 0, metadata !2, metadata !2, metadata !3, metadata !2, metadata !2, metadata !"", i32 1} ; [ DW_TAG_compile_unit ] [/liveness_analysis/cBench_render_ht.c] [DW_LANG_C99]
!1 = metadata !{metadata !"cBench_render_ht.c", metadata !"/liveness_analysis"}
!2 = metadata !{}
!3 = metadata !{metadata !4}
!4 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"render_ht", metadata !"render_ht", metadata !"", i32 7, metadata !6, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (i32, i32)* @render_ht, null, null, metadata !2, i32 8} ; [ DW_TAG_subprogram ] [line 7] [def] [scope 8] [render_ht]
!5 = metadata !{i32 786473, metadata !1}          ; [ DW_TAG_file_type ] [/liveness_analysis/cBench_render_ht.c]
!6 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !7, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!7 = metadata !{null, metadata !8, metadata !8}
!8 = metadata !{i32 786468, null, null, metadata !"int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!9 = metadata !{i32 2, metadata !"Dwarf Version", i32 4}
!10 = metadata !{i32 2, metadata !"Debug Info Version", i32 1}
!11 = metadata !{metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)"}
!12 = metadata !{i32 786689, metadata !4, metadata !"level", metadata !5, i32 16777223, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [level] [line 7]
!13 = metadata !{i32 7, i32 15, metadata !4, null}
!14 = metadata !{i32 786689, metadata !4, metadata !"old_level", metadata !5, i32 33554439, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [old_level] [line 7]
!15 = metadata !{i32 7, i32 26, metadata !4, null}
!16 = metadata !{i32 8, i32 1, metadata !4, null} ; [ DW_TAG_imported_declaration ]
!17 = metadata !{i32 11, i32 5, metadata !4, null}
!18 = metadata !{i32 40, i32 2, metadata !4, null}
!19 = metadata !{i32 14, i32 8, metadata !20, null}
!20 = metadata !{i32 786443, metadata !1, metadata !21, i32 14, i32 8, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_render_ht.c]
!21 = metadata !{i32 786443, metadata !1, metadata !4, i32 12, i32 2, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_render_ht.c]
!22 = metadata !{i32 16, i32 4, metadata !23, null}
!23 = metadata !{i32 786443, metadata !1, metadata !20, i32 15, i32 3, i32 0, i32 2} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_render_ht.c]
!24 = metadata !{i32 20, i32 4, metadata !25, null}
!25 = metadata !{i32 786443, metadata !1, metadata !20, i32 19, i32 3, i32 0, i32 3} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_render_ht.c]

