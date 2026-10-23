; ModuleID = 'speed_pldi09_fig4_5.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind uwtable
define void @peed_pldi09_fig4_5(i32 %n, i32 %m, i32 %dir) #0 {
peed_pldi09_fig4_5_bb0:
  call void @llvm.dbg.value(metadata !{i32 %n}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !{i32 %m}, i64 0, metadata !14), !dbg !15
  call void @llvm.dbg.value(metadata !{i32 %dir}, i64 0, metadata !16), !dbg !17
  %"0" = icmp sge i32 0, %m, !dbg !18
  %"1" = icmp sge i32 %m, %n, !dbg !20
  %or.cond = or i1 %"0", %"1", !dbg !18
  br i1 %or.cond, label %peed_pldi09_fig4_5_bb3, label %peed_pldi09_fig4_5_bb1, !dbg !18

peed_pldi09_fig4_5_bb1:                           ; preds = %peed_pldi09_fig4_5_bb0, %peed_pldi09_fig4_5_bb2
  %i.0 = phi i32 [ %i.1, %peed_pldi09_fig4_5_bb2 ], [ %m, %peed_pldi09_fig4_5_bb0 ]
  %"2" = icmp slt i32 0, %i.0, !dbg !22
  %"3" = icmp slt i32 %i.0, %n, !dbg !24
  %. = select i1 %"2", i1 %"3", i1 false, !dbg !22
  br i1 %., label %peed_pldi09_fig4_5_bb2, label %peed_pldi09_fig4_5_bb3, !dbg !26

peed_pldi09_fig4_5_bb2:                           ; preds = %peed_pldi09_fig4_5_bb1
  %"4" = icmp eq i32 %dir, 1, !dbg !28
  %"5" = add nsw i32 %i.0, 1, !dbg !31
  %"6" = add nsw i32 %i.0, -1, !dbg !32
  %i.1 = select i1 %"4", i32 %"5", i32 %"6", !dbg !28
  br label %peed_pldi09_fig4_5_bb1, !dbg !28

peed_pldi09_fig4_5_bb3:                           ; preds = %peed_pldi09_fig4_5_bb0, %peed_pldi09_fig4_5_bb1
  ret void, !dbg !33
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

!0 = metadata !{i32 786449, metadata !1, i32 12, metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)", i1 false, metadata !"", i32 0, metadata !2, metadata !2, metadata !3, metadata !2, metadata !2, metadata !"", i32 1} ; [ DW_TAG_compile_unit ] [/liveness_analysis/speed_pldi09_fig4_5.c] [DW_LANG_C99]
!1 = metadata !{metadata !"speed_pldi09_fig4_5.c", metadata !"/liveness_analysis"}
!2 = metadata !{}
!3 = metadata !{metadata !4}
!4 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"peed_pldi09_fig4_5", metadata !"peed_pldi09_fig4_5", metadata !"", i32 3, metadata !6, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (i32, i32, i32)* @peed_pldi09_fig4_5, null, null, metadata !2, i32 4} ; [ DW_TAG_subprogram ] [line 3] [def] [scope 4] [peed_pldi09_fig4_5]
!5 = metadata !{i32 786473, metadata !1}          ; [ DW_TAG_file_type ] [/liveness_analysis/speed_pldi09_fig4_5.c]
!6 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !7, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!7 = metadata !{null, metadata !8, metadata !8, metadata !8}
!8 = metadata !{i32 786468, null, null, metadata !"int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!9 = metadata !{i32 2, metadata !"Dwarf Version", i32 4}
!10 = metadata !{i32 2, metadata !"Debug Info Version", i32 1}
!11 = metadata !{metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)"}
!12 = metadata !{i32 786689, metadata !4, metadata !"n", metadata !5, i32 16777219, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [n] [line 3]
!13 = metadata !{i32 3, i32 29, metadata !4, null}
!14 = metadata !{i32 786689, metadata !4, metadata !"m", metadata !5, i32 33554435, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [m] [line 3]
!15 = metadata !{i32 3, i32 36, metadata !4, null}
!16 = metadata !{i32 786689, metadata !4, metadata !"dir", metadata !5, i32 50331651, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [dir] [line 3]
!17 = metadata !{i32 3, i32 43, metadata !4, null}
!18 = metadata !{i32 7, i32 7, metadata !19, null}
!19 = metadata !{i32 786443, metadata !1, metadata !4, i32 7, i32 7, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/liveness_analysis/speed_pldi09_fig4_5.c]
!20 = metadata !{i32 8, i32 7, metadata !21, null} ; [ DW_TAG_imported_declaration ]
!21 = metadata !{i32 786443, metadata !1, metadata !4, i32 8, i32 7, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/liveness_analysis/speed_pldi09_fig4_5.c]
!22 = metadata !{i32 12, i32 3, metadata !23, null}
!23 = metadata !{i32 786443, metadata !1, metadata !4, i32 12, i32 3, i32 1, i32 6} ; [ DW_TAG_lexical_block ] [/liveness_analysis/speed_pldi09_fig4_5.c]
!24 = metadata !{i32 12, i32 3, metadata !25, null}
!25 = metadata !{i32 786443, metadata !1, metadata !4, i32 12, i32 3, i32 2, i32 7} ; [ DW_TAG_lexical_block ] [/liveness_analysis/speed_pldi09_fig4_5.c]
!26 = metadata !{i32 12, i32 3, metadata !27, null}
!27 = metadata !{i32 786443, metadata !1, metadata !4, i32 12, i32 3, i32 3, i32 8} ; [ DW_TAG_lexical_block ] [/liveness_analysis/speed_pldi09_fig4_5.c]
!28 = metadata !{i32 13, i32 9, metadata !29, null}
!29 = metadata !{i32 786443, metadata !1, metadata !30, i32 13, i32 9, i32 0, i32 3} ; [ DW_TAG_lexical_block ] [/liveness_analysis/speed_pldi09_fig4_5.c]
!30 = metadata !{i32 786443, metadata !1, metadata !4, i32 12, i32 26, i32 0, i32 2} ; [ DW_TAG_lexical_block ] [/liveness_analysis/speed_pldi09_fig4_5.c]
!31 = metadata !{i32 14, i32 7, metadata !29, null}
!32 = metadata !{i32 16, i32 7, metadata !29, null}
!33 = metadata !{i32 18, i32 1, metadata !4, null}

