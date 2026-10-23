; ModuleID = 'twn04.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind uwtable
define i32 @twn04(i32 %a, i32 %b, i32 %c, i32 %d, i32 %e) #0 {
twn04_bb0:
  call void @llvm.dbg.value(metadata !{i32 %a}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !{i32 %b}, i64 0, metadata !14), !dbg !15
  call void @llvm.dbg.value(metadata !{i32 %c}, i64 0, metadata !16), !dbg !17
  call void @llvm.dbg.value(metadata !{i32 %d}, i64 0, metadata !18), !dbg !19
  call void @llvm.dbg.value(metadata !{i32 %e}, i64 0, metadata !20), !dbg !21
  %"0" = icmp sgt i32 %d, 0, !dbg !22
  br i1 %"0", label %twn04_bb1, label %twn04_bb5, !dbg !22

twn04_bb1:                                        ; preds = %twn04_bb0, %twn04_bb4
  %.03 = phi i32 [ %"9", %twn04_bb4 ], [ %c, %twn04_bb0 ]
  %"1" = icmp sgt i32 %.03, 0, !dbg !24
  br i1 %"1", label %twn04_bb2, label %twn04_bb5, !dbg !24

twn04_bb2:                                        ; preds = %twn04_bb1, %twn04_bb3
  %.12 = phi i32 [ %"8", %twn04_bb3 ], [ %e, %twn04_bb1 ]
  %.1 = phi i32 [ %"7", %twn04_bb3 ], [ %d, %twn04_bb1 ]
  %"2" = mul nsw i32 %.12, %.12, !dbg !27
  %"3" = icmp slt i32 %.1, %"2", !dbg !27
  %"4" = icmp sgt i32 %.1, 0, !dbg !30
  %. = select i1 %"3", i1 %"4", i1 false, !dbg !27
  br i1 %., label %twn04_bb3, label %twn04_bb4, !dbg !32

twn04_bb3:                                        ; preds = %twn04_bb2
  %"5" = mul nsw i32 5, %.1, !dbg !34
  %"6" = mul nsw i32 %.03, %.03, !dbg !34
  %"7" = add nsw i32 %"5", %"6", !dbg !34
  %"8" = mul nsw i32 2, %.12, !dbg !36
  br label %twn04_bb2, !dbg !37

twn04_bb4:                                        ; preds = %twn04_bb2
  call void @llvm.dbg.value(metadata !{i32 %d}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !{i32 %e}, i64 0, metadata !14), !dbg !15
  %"9" = sub nsw i32 %.03, 1, !dbg !38
  call void @llvm.dbg.value(metadata !{i32 %"9"}, i64 0, metadata !16), !dbg !17
  br label %twn04_bb1, !dbg !39

twn04_bb5:                                        ; preds = %twn04_bb1, %twn04_bb0
  ret i32 0, !dbg !40
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

!0 = metadata !{i32 786449, metadata !1, i32 12, metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)", i1 false, metadata !"", i32 0, metadata !2, metadata !2, metadata !3, metadata !2, metadata !2, metadata !"", i32 1} ; [ DW_TAG_compile_unit ] [/liveness_analysis/twn04.c] [DW_LANG_C99]
!1 = metadata !{metadata !"twn04.c", metadata !"/liveness_analysis"}
!2 = metadata !{}
!3 = metadata !{metadata !4}
!4 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"twn04", metadata !"twn04", metadata !"", i32 1, metadata !6, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, i32 (i32, i32, i32, i32, i32)* @twn04, null, null, metadata !2, i32 1} ; [ DW_TAG_subprogram ] [line 1] [def] [twn04]
!5 = metadata !{i32 786473, metadata !1}          ; [ DW_TAG_file_type ] [/liveness_analysis/twn04.c]
!6 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !7, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!7 = metadata !{metadata !8, metadata !8, metadata !8, metadata !8, metadata !8, metadata !8}
!8 = metadata !{i32 786468, null, null, metadata !"int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!9 = metadata !{i32 2, metadata !"Dwarf Version", i32 4}
!10 = metadata !{i32 2, metadata !"Debug Info Version", i32 1}
!11 = metadata !{metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)"}
!12 = metadata !{i32 786689, metadata !4, metadata !"a", metadata !5, i32 16777217, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [a] [line 1]
!13 = metadata !{i32 1, i32 15, metadata !4, null}
!14 = metadata !{i32 786689, metadata !4, metadata !"b", metadata !5, i32 33554433, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [b] [line 1]
!15 = metadata !{i32 1, i32 22, metadata !4, null}
!16 = metadata !{i32 786689, metadata !4, metadata !"c", metadata !5, i32 50331649, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [c] [line 1]
!17 = metadata !{i32 1, i32 29, metadata !4, null}
!18 = metadata !{i32 786689, metadata !4, metadata !"d", metadata !5, i32 67108865, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [d] [line 1]
!19 = metadata !{i32 1, i32 36, metadata !4, null}
!20 = metadata !{i32 786689, metadata !4, metadata !"e", metadata !5, i32 83886081, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [e] [line 1]
!21 = metadata !{i32 1, i32 43, metadata !4, null}
!22 = metadata !{i32 2, i32 6, metadata !23, null}
!23 = metadata !{i32 786443, metadata !1, metadata !4, i32 2, i32 6, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/liveness_analysis/twn04.c]
!24 = metadata !{i32 5, i32 5, metadata !25, null}
!25 = metadata !{i32 786443, metadata !1, metadata !26, i32 5, i32 5, i32 1, i32 4} ; [ DW_TAG_lexical_block ] [/liveness_analysis/twn04.c]
!26 = metadata !{i32 786443, metadata !1, metadata !23, i32 2, i32 13, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/liveness_analysis/twn04.c]
!27 = metadata !{i32 6, i32 9, metadata !28, null}
!28 = metadata !{i32 786443, metadata !1, metadata !29, i32 6, i32 9, i32 1, i32 5} ; [ DW_TAG_lexical_block ] [/liveness_analysis/twn04.c]
!29 = metadata !{i32 786443, metadata !1, metadata !26, i32 5, i32 18, i32 0, i32 2} ; [ DW_TAG_lexical_block ] [/liveness_analysis/twn04.c]
!30 = metadata !{i32 6, i32 9, metadata !31, null}
!31 = metadata !{i32 786443, metadata !1, metadata !29, i32 6, i32 9, i32 2, i32 6} ; [ DW_TAG_lexical_block ] [/liveness_analysis/twn04.c]
!32 = metadata !{i32 6, i32 9, metadata !33, null}
!33 = metadata !{i32 786443, metadata !1, metadata !29, i32 6, i32 9, i32 3, i32 7} ; [ DW_TAG_lexical_block ] [/liveness_analysis/twn04.c]
!34 = metadata !{i32 7, i32 11, metadata !35, null}
!35 = metadata !{i32 786443, metadata !1, metadata !29, i32 6, i32 33, i32 0, i32 3} ; [ DW_TAG_lexical_block ] [/liveness_analysis/twn04.c]
!36 = metadata !{i32 8, i32 11, metadata !35, null} ; [ DW_TAG_imported_declaration ]
!37 = metadata !{i32 9, i32 9, metadata !35, null}
!38 = metadata !{i32 12, i32 9, metadata !29, null}
!39 = metadata !{i32 13, i32 5, metadata !29, null}
!40 = metadata !{i32 15, i32 3, metadata !4, null}

