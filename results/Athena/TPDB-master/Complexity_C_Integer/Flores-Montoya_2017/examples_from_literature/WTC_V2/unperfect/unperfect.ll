; ModuleID = 'unperfect.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind uwtable
define i32 @unperfect(i32 %x) #0 {
unperfect_bb0:
  call void @llvm.dbg.value(metadata !{i32 %x}, i64 0, metadata !12), !dbg !13
  %"0" = icmp sle i32 %x, 0, !dbg !14
  br i1 %"0", label %unperfect_bb3, label %unperfect_bb1, !dbg !14

unperfect_bb1:                                    ; preds = %unperfect_bb0, %unperfect_bb6
  %y3.0 = phi i32 [ %.y3.0, %unperfect_bb6 ], [ %x, %unperfect_bb0 ]
  %y1.0 = phi i32 [ %"1", %unperfect_bb6 ], [ %x, %unperfect_bb0 ]
  %"1" = sub nsw i32 %y1.0, 1, !dbg !16
  %"2" = icmp eq i32 %"1", 0, !dbg !19
  br i1 %"2", label %unperfect_bb2, label %unperfect_bb4, !dbg !19

unperfect_bb2:                                    ; preds = %unperfect_bb1
  %"3" = icmp eq i32 %y3.0, 0, !dbg !21
  %"4" = zext i1 %"3" to i32, !dbg !21
  br label %unperfect_bb3, !dbg !21

unperfect_bb3:                                    ; preds = %unperfect_bb0, %unperfect_bb2
  %.0 = phi i32 [ %"4", %unperfect_bb2 ], [ 0, %unperfect_bb0 ]
  ret i32 %.0, !dbg !22

unperfect_bb4:                                    ; preds = %unperfect_bb1, %unperfect_bb5
  %y2.1 = phi i32 [ %"6", %unperfect_bb5 ], [ %x, %unperfect_bb1 ]
  %"5" = icmp sge i32 %y2.1, %"1", !dbg !23
  br i1 %"5", label %unperfect_bb5, label %unperfect_bb6, !dbg !23

unperfect_bb5:                                    ; preds = %unperfect_bb4
  %"6" = sub nsw i32 %y2.1, %"1", !dbg !26
  br label %unperfect_bb4, !dbg !26

unperfect_bb6:                                    ; preds = %unperfect_bb4
  %"7" = icmp eq i32 %y2.1, 0, !dbg !28
  %"8" = sub nsw i32 %y3.0, %"1", !dbg !30
  call void @llvm.dbg.value(metadata !{i32 %"8"}, i64 0, metadata !31), !dbg !32
  %.y3.0 = select i1 %"7", i32 %"8", i32 %y3.0, !dbg !28
  call void @llvm.dbg.value(metadata !{i32 %x}, i64 0, metadata !33), !dbg !34
  br label %unperfect_bb1, !dbg !35
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

!0 = metadata !{i32 786449, metadata !1, i32 12, metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)", i1 false, metadata !"", i32 0, metadata !2, metadata !2, metadata !3, metadata !2, metadata !2, metadata !"", i32 1} ; [ DW_TAG_compile_unit ] [/liveness_analysis/unperfect.c] [DW_LANG_C99]
!1 = metadata !{metadata !"unperfect.c", metadata !"/liveness_analysis"}
!2 = metadata !{}
!3 = metadata !{metadata !4}
!4 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"unperfect", metadata !"unperfect", metadata !"", i32 2, metadata !6, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, i32 (i32)* @unperfect, null, null, metadata !2, i32 2} ; [ DW_TAG_subprogram ] [line 2] [def] [unperfect]
!5 = metadata !{i32 786473, metadata !1}          ; [ DW_TAG_file_type ] [/liveness_analysis/unperfect.c]
!6 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !7, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!7 = metadata !{metadata !8, metadata !8}
!8 = metadata !{i32 786468, null, null, metadata !"int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!9 = metadata !{i32 2, metadata !"Dwarf Version", i32 4}
!10 = metadata !{i32 2, metadata !"Debug Info Version", i32 1}
!11 = metadata !{metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)"}
!12 = metadata !{i32 786689, metadata !4, metadata !"x", metadata !5, i32 16777218, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [x] [line 2]
!13 = metadata !{i32 2, i32 19, metadata !4, null}
!14 = metadata !{i32 5, i32 6, metadata !15, null}
!15 = metadata !{i32 786443, metadata !1, metadata !4, i32 5, i32 6, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/liveness_analysis/unperfect.c]
!16 = metadata !{i32 10, i32 5, metadata !17, null}
!17 = metadata !{i32 786443, metadata !1, metadata !18, i32 9, i32 10, i32 0, i32 2} ; [ DW_TAG_lexical_block ] [/liveness_analysis/unperfect.c]
!18 = metadata !{i32 786443, metadata !1, metadata !4, i32 9, i32 3, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/liveness_analysis/unperfect.c]
!19 = metadata !{i32 11, i32 8, metadata !20, null}
!20 = metadata !{i32 786443, metadata !1, metadata !17, i32 11, i32 8, i32 0, i32 3} ; [ DW_TAG_lexical_block ] [/liveness_analysis/unperfect.c]
!21 = metadata !{i32 18, i32 3, metadata !4, null}
!22 = metadata !{i32 19, i32 1, metadata !4, null}
!23 = metadata !{i32 12, i32 5, metadata !24, null}
!24 = metadata !{i32 786443, metadata !1, metadata !25, i32 12, i32 5, i32 3, i32 9} ; [ DW_TAG_lexical_block ] [/liveness_analysis/unperfect.c]
!25 = metadata !{i32 786443, metadata !1, metadata !17, i32 12, i32 5, i32 1, i32 7} ; [ DW_TAG_lexical_block ] [/liveness_analysis/unperfect.c]
!26 = metadata !{i32 12, i32 21, metadata !27, null}
!27 = metadata !{i32 786443, metadata !1, metadata !17, i32 12, i32 21, i32 2, i32 8} ; [ DW_TAG_lexical_block ] [/liveness_analysis/unperfect.c]
!28 = metadata !{i32 13, i32 8, metadata !29, null}
!29 = metadata !{i32 786443, metadata !1, metadata !17, i32 13, i32 8, i32 0, i32 4} ; [ DW_TAG_lexical_block ] [/liveness_analysis/unperfect.c]
!30 = metadata !{i32 14, i32 7, metadata !29, null}
!31 = metadata !{i32 786688, metadata !4, metadata !"y3", metadata !5, i32 3, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [y3] [line 3]
!32 = metadata !{i32 3, i32 15, metadata !4, null}
!33 = metadata !{i32 786688, metadata !4, metadata !"y2", metadata !5, i32 3, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [y2] [line 3]
!34 = metadata !{i32 3, i32 11, metadata !4, null}
!35 = metadata !{i32 16, i32 3, metadata !17, null}

