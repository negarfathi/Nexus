; ModuleID = 'speed_pldi09_fig4_2.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind uwtable
define void @peed_pldi09_fig4_2(i32 %n, i32 %m) #0 {
peed_pldi09_fig4_2_bb0:
  call void @llvm.dbg.value(metadata !{i32 %n}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !{i32 %m}, i64 0, metadata !14), !dbg !15
  call void @llvm.dbg.value(metadata !{i32 %n}, i64 0, metadata !16), !dbg !17
  call void @llvm.dbg.value(metadata !18, i64 0, metadata !19), !dbg !20
  %"0" = icmp sle i32 %m, 0, !dbg !21
  br i1 %"0", label %peed_pldi09_fig4_2_bb4, label %peed_pldi09_fig4_2_bb1, !dbg !21

peed_pldi09_fig4_2_bb1:                           ; preds = %peed_pldi09_fig4_2_bb3, %peed_pldi09_fig4_2_bb2, %peed_pldi09_fig4_2_bb0
  %va.0 = phi i32 [ %n, %peed_pldi09_fig4_2_bb0 ], [ %"4", %peed_pldi09_fig4_2_bb3 ], [ %va.0, %peed_pldi09_fig4_2_bb2 ]
  %vb.0 = phi i32 [ 0, %peed_pldi09_fig4_2_bb0 ], [ %"3", %peed_pldi09_fig4_2_bb3 ], [ 0, %peed_pldi09_fig4_2_bb2 ]
  %"1" = icmp sgt i32 %va.0, 0, !dbg !23
  br i1 %"1", label %peed_pldi09_fig4_2_bb2, label %peed_pldi09_fig4_2_bb4, !dbg !23

peed_pldi09_fig4_2_bb2:                           ; preds = %peed_pldi09_fig4_2_bb1
  %"2" = icmp slt i32 %vb.0, %m, !dbg !25
  br i1 %"2", label %peed_pldi09_fig4_2_bb3, label %peed_pldi09_fig4_2_bb1, !dbg !25

peed_pldi09_fig4_2_bb3:                           ; preds = %peed_pldi09_fig4_2_bb2
  %"3" = add nsw i32 %vb.0, 1, !dbg !28
  %"4" = sub nsw i32 %va.0, 1, !dbg !30
  br label %peed_pldi09_fig4_2_bb1, !dbg !31

peed_pldi09_fig4_2_bb4:                           ; preds = %peed_pldi09_fig4_2_bb0, %peed_pldi09_fig4_2_bb1
  ret void, !dbg !32
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

!0 = metadata !{i32 786449, metadata !1, i32 12, metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)", i1 false, metadata !"", i32 0, metadata !2, metadata !2, metadata !3, metadata !2, metadata !2, metadata !"", i32 1} ; [ DW_TAG_compile_unit ] [/liveness_analysis/speed_pldi09_fig4_2.c] [DW_LANG_C99]
!1 = metadata !{metadata !"speed_pldi09_fig4_2.c", metadata !"/liveness_analysis"}
!2 = metadata !{}
!3 = metadata !{metadata !4}
!4 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"peed_pldi09_fig4_2", metadata !"peed_pldi09_fig4_2", metadata !"", i32 3, metadata !6, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (i32, i32)* @peed_pldi09_fig4_2, null, null, metadata !2, i32 4} ; [ DW_TAG_subprogram ] [line 3] [def] [scope 4] [peed_pldi09_fig4_2]
!5 = metadata !{i32 786473, metadata !1}          ; [ DW_TAG_file_type ] [/liveness_analysis/speed_pldi09_fig4_2.c]
!6 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !7, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!7 = metadata !{null, metadata !8, metadata !8}
!8 = metadata !{i32 786468, null, null, metadata !"int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!9 = metadata !{i32 2, metadata !"Dwarf Version", i32 4}
!10 = metadata !{i32 2, metadata !"Debug Info Version", i32 1}
!11 = metadata !{metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)"}
!12 = metadata !{i32 786689, metadata !4, metadata !"n", metadata !5, i32 16777219, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [n] [line 3]
!13 = metadata !{i32 3, i32 29, metadata !4, null}
!14 = metadata !{i32 786689, metadata !4, metadata !"m", metadata !5, i32 33554435, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [m] [line 3]
!15 = metadata !{i32 3, i32 36, metadata !4, null}
!16 = metadata !{i32 786688, metadata !4, metadata !"va", metadata !5, i32 5, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [va] [line 5]
!17 = metadata !{i32 5, i32 7, metadata !4, null}
!18 = metadata !{i32 0}
!19 = metadata !{i32 786688, metadata !4, metadata !"vb", metadata !5, i32 6, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [vb] [line 6]
!20 = metadata !{i32 6, i32 7, metadata !4, null}
!21 = metadata !{i32 9, i32 5, metadata !22, null}
!22 = metadata !{i32 786443, metadata !1, metadata !4, i32 9, i32 5, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/liveness_analysis/speed_pldi09_fig4_2.c]
!23 = metadata !{i32 11, i32 3, metadata !24, null}
!24 = metadata !{i32 786443, metadata !1, metadata !4, i32 11, i32 3, i32 1, i32 6} ; [ DW_TAG_lexical_block ] [/liveness_analysis/speed_pldi09_fig4_2.c]
!25 = metadata !{i32 12, i32 9, metadata !26, null}
!26 = metadata !{i32 786443, metadata !1, metadata !27, i32 12, i32 9, i32 0, i32 2} ; [ DW_TAG_lexical_block ] [/liveness_analysis/speed_pldi09_fig4_2.c]
!27 = metadata !{i32 786443, metadata !1, metadata !4, i32 11, i32 18, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/liveness_analysis/speed_pldi09_fig4_2.c]
!28 = metadata !{i32 13, i32 7, metadata !29, null}
!29 = metadata !{i32 786443, metadata !1, metadata !26, i32 12, i32 17, i32 0, i32 3} ; [ DW_TAG_lexical_block ] [/liveness_analysis/speed_pldi09_fig4_2.c]
!30 = metadata !{i32 14, i32 7, metadata !29, null}
!31 = metadata !{i32 15, i32 5, metadata !29, null}
!32 = metadata !{i32 20, i32 1, metadata !4, null}

