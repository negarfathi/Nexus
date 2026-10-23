; ModuleID = 'non_linear19.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind uwtable
define i32 @non_linear19(i32 %x1, i32 %x2, i32 %x3) #0 {
non_linear19_bb0:
  call void @llvm.dbg.value(metadata !{i32 %x1}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !{i32 %x2}, i64 0, metadata !14), !dbg !15
  call void @llvm.dbg.value(metadata !{i32 %x3}, i64 0, metadata !16), !dbg !17
  call void @llvm.dbg.value(metadata !{i32 %"2"}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !{i32 %"3"}, i64 0, metadata !14), !dbg !15
  call void @llvm.dbg.value(metadata !{i32 %"4"}, i64 0, metadata !16), !dbg !17
  br label %non_linear19_bb1, !dbg !18

non_linear19_bb1:                                 ; preds = %non_linear19_bb2, %non_linear19_bb0
  %.02 = phi i32 [ %x3, %non_linear19_bb0 ], [ %"4", %non_linear19_bb2 ]
  %.01 = phi i32 [ %x2, %non_linear19_bb0 ], [ %"3", %non_linear19_bb2 ]
  %.0 = phi i32 [ %x1, %non_linear19_bb0 ], [ %"2", %non_linear19_bb2 ]
  %"0" = icmp slt i32 %.01, %.0, !dbg !19
  %"1" = icmp sgt i32 %.01, 0, !dbg !21
  %. = select i1 %"0", i1 %"1", i1 false, !dbg !19
  br i1 %., label %non_linear19_bb2, label %non_linear19_bb3, !dbg !23

non_linear19_bb2:                                 ; preds = %non_linear19_bb1
  %"2" = mul nsw i32 2, %.0, !dbg !25
  %"3" = mul nsw i32 3, %.01, !dbg !27
  %"4" = mul nsw i32 %.02, %.02, !dbg !28
  br label %non_linear19_bb1, !dbg !29

non_linear19_bb3:                                 ; preds = %non_linear19_bb1, %non_linear19_bb4
  %.1 = phi i32 [ %"6", %non_linear19_bb4 ], [ %.02, %non_linear19_bb1 ]
  %"5" = icmp slt i32 0, %.1, !dbg !30
  br i1 %"5", label %non_linear19_bb4, label %non_linear19_bb5, !dbg !30

non_linear19_bb4:                                 ; preds = %non_linear19_bb3
  %"6" = sub nsw i32 %.1, 1, !dbg !32
  br label %non_linear19_bb3, !dbg !34

non_linear19_bb5:                                 ; preds = %non_linear19_bb3
  ret i32 0, !dbg !35
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

!0 = metadata !{i32 786449, metadata !1, i32 12, metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)", i1 false, metadata !"", i32 0, metadata !2, metadata !2, metadata !3, metadata !2, metadata !2, metadata !"", i32 1} ; [ DW_TAG_compile_unit ] [/liveness_analysis/non_linear19.c] [DW_LANG_C99]
!1 = metadata !{metadata !"non_linear19.c", metadata !"/liveness_analysis"}
!2 = metadata !{}
!3 = metadata !{metadata !4}
!4 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"non_linear19", metadata !"non_linear19", metadata !"", i32 1, metadata !6, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, i32 (i32, i32, i32)* @non_linear19, null, null, metadata !2, i32 1} ; [ DW_TAG_subprogram ] [line 1] [def] [non_linear19]
!5 = metadata !{i32 786473, metadata !1}          ; [ DW_TAG_file_type ] [/liveness_analysis/non_linear19.c]
!6 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !7, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!7 = metadata !{metadata !8, metadata !8, metadata !8, metadata !8}
!8 = metadata !{i32 786468, null, null, metadata !"int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!9 = metadata !{i32 2, metadata !"Dwarf Version", i32 4}
!10 = metadata !{i32 2, metadata !"Debug Info Version", i32 1}
!11 = metadata !{metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)"}
!12 = metadata !{i32 786689, metadata !4, metadata !"x1", metadata !5, i32 16777217, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [x1] [line 1]
!13 = metadata !{i32 1, i32 22, metadata !4, null}
!14 = metadata !{i32 786689, metadata !4, metadata !"x2", metadata !5, i32 33554433, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [x2] [line 1]
!15 = metadata !{i32 1, i32 30, metadata !4, null}
!16 = metadata !{i32 786689, metadata !4, metadata !"x3", metadata !5, i32 50331649, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [x3] [line 1]
!17 = metadata !{i32 1, i32 38, metadata !4, null}
!18 = metadata !{i32 2, i32 3, metadata !4, null}
!19 = metadata !{i32 2, i32 3, metadata !20, null}
!20 = metadata !{i32 786443, metadata !1, metadata !4, i32 2, i32 3, i32 1, i32 2} ; [ DW_TAG_lexical_block ] [/liveness_analysis/non_linear19.c]
!21 = metadata !{i32 2, i32 3, metadata !22, null}
!22 = metadata !{i32 786443, metadata !1, metadata !4, i32 2, i32 3, i32 2, i32 3} ; [ DW_TAG_lexical_block ] [/liveness_analysis/non_linear19.c]
!23 = metadata !{i32 2, i32 3, metadata !24, null}
!24 = metadata !{i32 786443, metadata !1, metadata !4, i32 2, i32 3, i32 3, i32 4} ; [ DW_TAG_lexical_block ] [/liveness_analysis/non_linear19.c]
!25 = metadata !{i32 3, i32 5, metadata !26, null}
!26 = metadata !{i32 786443, metadata !1, metadata !4, i32 2, i32 28, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/liveness_analysis/non_linear19.c]
!27 = metadata !{i32 4, i32 5, metadata !26, null}
!28 = metadata !{i32 5, i32 5, metadata !26, null}
!29 = metadata !{i32 6, i32 3, metadata !26, null}
!30 = metadata !{i32 7, i32 3, metadata !31, null}
!31 = metadata !{i32 786443, metadata !1, metadata !4, i32 7, i32 3, i32 1, i32 5} ; [ DW_TAG_lexical_block ] [/liveness_analysis/non_linear19.c]
!32 = metadata !{i32 8, i32 5, metadata !33, null} ; [ DW_TAG_imported_declaration ]
!33 = metadata !{i32 786443, metadata !1, metadata !4, i32 7, i32 17, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/liveness_analysis/non_linear19.c]
!34 = metadata !{i32 9, i32 3, metadata !33, null}
!35 = metadata !{i32 10, i32 3, metadata !4, null}

