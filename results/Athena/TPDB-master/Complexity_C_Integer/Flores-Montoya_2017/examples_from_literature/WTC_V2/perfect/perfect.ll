; ModuleID = 'perfect.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind uwtable
define i32 @perfect(i32 %x) #0 {
perfect_bb0:
  call void @llvm.dbg.value(metadata !{i32 %x}, i64 0, metadata !12), !dbg !13
  %"0" = icmp sle i32 %x, 1, !dbg !14
  br i1 %"0", label %perfect_bb6, label %perfect_bb1, !dbg !14

perfect_bb1:                                      ; preds = %perfect_bb0, %perfect_bb4
  %y1.0.sink = phi i32 [ %"1", %perfect_bb4 ], [ %x, %perfect_bb0 ]
  %y3.0 = phi i32 [ %.y3.0, %perfect_bb4 ], [ %x, %perfect_bb0 ]
  %"1" = sub nsw i32 %y1.0.sink, 1, !dbg !16
  %"2" = icmp sgt i32 %"1", 0, !dbg !18
  br i1 %"2", label %perfect_bb2, label %perfect_bb5, !dbg !18

perfect_bb2:                                      ; preds = %perfect_bb1, %perfect_bb3
  %y2.1 = phi i32 [ %"4", %perfect_bb3 ], [ %x, %perfect_bb1 ]
  %"3" = icmp sge i32 %y2.1, %"1", !dbg !21
  br i1 %"3", label %perfect_bb3, label %perfect_bb4, !dbg !21

perfect_bb3:                                      ; preds = %perfect_bb2
  %"4" = sub nsw i32 %y2.1, %"1", !dbg !25
  br label %perfect_bb2, !dbg !25

perfect_bb4:                                      ; preds = %perfect_bb2
  %"5" = icmp eq i32 %y2.1, 0, !dbg !27
  %"6" = sub nsw i32 %y3.0, %"1", !dbg !29
  call void @llvm.dbg.value(metadata !{i32 %"6"}, i64 0, metadata !30), !dbg !31
  %.y3.0 = select i1 %"5", i32 %"6", i32 %y3.0, !dbg !27
  call void @llvm.dbg.value(metadata !{i32 %x}, i64 0, metadata !32), !dbg !33
  call void @llvm.dbg.value(metadata !{i32 %"1"}, i64 0, metadata !34), !dbg !35
  br label %perfect_bb1, !dbg !16

perfect_bb5:                                      ; preds = %perfect_bb1
  %"7" = icmp eq i32 %y3.0, 0, !dbg !36
  %"8" = zext i1 %"7" to i32, !dbg !36
  br label %perfect_bb6, !dbg !36

perfect_bb6:                                      ; preds = %perfect_bb0, %perfect_bb5
  %.0 = phi i32 [ %"8", %perfect_bb5 ], [ 0, %perfect_bb0 ]
  ret i32 %.0, !dbg !37
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

!0 = metadata !{i32 786449, metadata !1, i32 12, metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)", i1 false, metadata !"", i32 0, metadata !2, metadata !2, metadata !3, metadata !2, metadata !2, metadata !"", i32 1} ; [ DW_TAG_compile_unit ] [/liveness_analysis/perfect.c] [DW_LANG_C99]
!1 = metadata !{metadata !"perfect.c", metadata !"/liveness_analysis"}
!2 = metadata !{}
!3 = metadata !{metadata !4}
!4 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"perfect", metadata !"perfect", metadata !"", i32 1, metadata !6, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, i32 (i32)* @perfect, null, null, metadata !2, i32 1} ; [ DW_TAG_subprogram ] [line 1] [def] [perfect]
!5 = metadata !{i32 786473, metadata !1}          ; [ DW_TAG_file_type ] [/liveness_analysis/perfect.c]
!6 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !7, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!7 = metadata !{metadata !8, metadata !8}
!8 = metadata !{i32 786468, null, null, metadata !"int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!9 = metadata !{i32 2, metadata !"Dwarf Version", i32 4}
!10 = metadata !{i32 2, metadata !"Debug Info Version", i32 1}
!11 = metadata !{metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)"}
!12 = metadata !{i32 786689, metadata !4, metadata !"x", metadata !5, i32 16777217, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [x] [line 1]
!13 = metadata !{i32 1, i32 17, metadata !4, null}
!14 = metadata !{i32 4, i32 6, metadata !15, null}
!15 = metadata !{i32 786443, metadata !1, metadata !4, i32 4, i32 6, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/liveness_analysis/perfect.c]
!16 = metadata !{i32 10, i32 22, metadata !17, null}
!17 = metadata !{i32 786443, metadata !1, metadata !4, i32 10, i32 3, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/liveness_analysis/perfect.c]
!18 = metadata !{i32 10, i32 7, metadata !19, null}
!19 = metadata !{i32 786443, metadata !1, metadata !20, i32 10, i32 7, i32 2, i32 9} ; [ DW_TAG_lexical_block ] [/liveness_analysis/perfect.c]
!20 = metadata !{i32 786443, metadata !1, metadata !17, i32 10, i32 7, i32 1, i32 5} ; [ DW_TAG_lexical_block ] [/liveness_analysis/perfect.c]
!21 = metadata !{i32 11, i32 5, metadata !22, null}
!22 = metadata !{i32 786443, metadata !1, metadata !23, i32 11, i32 5, i32 3, i32 8} ; [ DW_TAG_lexical_block ] [/liveness_analysis/perfect.c]
!23 = metadata !{i32 786443, metadata !1, metadata !24, i32 11, i32 5, i32 1, i32 6} ; [ DW_TAG_lexical_block ] [/liveness_analysis/perfect.c]
!24 = metadata !{i32 786443, metadata !1, metadata !17, i32 10, i32 30, i32 0, i32 2} ; [ DW_TAG_lexical_block ] [/liveness_analysis/perfect.c]
!25 = metadata !{i32 11, i32 21, metadata !26, null}
!26 = metadata !{i32 786443, metadata !1, metadata !24, i32 11, i32 21, i32 2, i32 7} ; [ DW_TAG_lexical_block ] [/liveness_analysis/perfect.c]
!27 = metadata !{i32 12, i32 8, metadata !28, null}
!28 = metadata !{i32 786443, metadata !1, metadata !24, i32 12, i32 8, i32 0, i32 3} ; [ DW_TAG_lexical_block ] [/liveness_analysis/perfect.c]
!29 = metadata !{i32 13, i32 7, metadata !28, null}
!30 = metadata !{i32 786688, metadata !4, metadata !"y3", metadata !5, i32 2, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [y3] [line 2]
!31 = metadata !{i32 2, i32 15, metadata !4, null}
!32 = metadata !{i32 786688, metadata !4, metadata !"y2", metadata !5, i32 2, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [y2] [line 2]
!33 = metadata !{i32 2, i32 11, metadata !4, null}
!34 = metadata !{i32 786688, metadata !4, metadata !"y1", metadata !5, i32 2, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [y1] [line 2]
!35 = metadata !{i32 2, i32 7, metadata !4, null}
!36 = metadata !{i32 17, i32 3, metadata !4, null}
!37 = metadata !{i32 18, i32 1, metadata !4, null}

