; ModuleID = 'twn02.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind uwtable
define i32 @twn02(i32 %a, i32 %b, i32 %c) #0 {
twn02_bb0:
  call void @llvm.dbg.value(metadata !{i32 %a}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !{i32 %b}, i64 0, metadata !14), !dbg !15
  call void @llvm.dbg.value(metadata !{i32 %c}, i64 0, metadata !16), !dbg !17
  call void @llvm.dbg.value(metadata !{i32 %"5"}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !{i32 %"6"}, i64 0, metadata !14), !dbg !15
  br label %twn02_bb1, !dbg !18

twn02_bb1:                                        ; preds = %twn02_bb2, %twn02_bb0
  %.01 = phi i32 [ %b, %twn02_bb0 ], [ %"6", %twn02_bb2 ]
  %.0 = phi i32 [ %a, %twn02_bb0 ], [ %"5", %twn02_bb2 ]
  %"0" = mul nsw i32 %.01, %.01, !dbg !19
  %"1" = icmp slt i32 %.0, %"0", !dbg !19
  %"2" = icmp sgt i32 %.0, 0, !dbg !21
  %. = select i1 %"1", i1 %"2", i1 false, !dbg !19
  br i1 %., label %twn02_bb2, label %twn02_bb3, !dbg !23

twn02_bb2:                                        ; preds = %twn02_bb1
  %"3" = mul nsw i32 5, %.0, !dbg !25
  %"4" = mul nsw i32 %c, %c, !dbg !25
  %"5" = add nsw i32 %"3", %"4", !dbg !25
  %"6" = mul nsw i32 2, %.01, !dbg !27
  br label %twn02_bb1, !dbg !28

twn02_bb3:                                        ; preds = %twn02_bb1
  ret i32 0, !dbg !29
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

!0 = metadata !{i32 786449, metadata !1, i32 12, metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)", i1 false, metadata !"", i32 0, metadata !2, metadata !2, metadata !3, metadata !2, metadata !2, metadata !"", i32 1} ; [ DW_TAG_compile_unit ] [/liveness_analysis/twn02.c] [DW_LANG_C99]
!1 = metadata !{metadata !"twn02.c", metadata !"/liveness_analysis"}
!2 = metadata !{}
!3 = metadata !{metadata !4}
!4 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"twn02", metadata !"twn02", metadata !"", i32 1, metadata !6, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, i32 (i32, i32, i32)* @twn02, null, null, metadata !2, i32 1} ; [ DW_TAG_subprogram ] [line 1] [def] [twn02]
!5 = metadata !{i32 786473, metadata !1}          ; [ DW_TAG_file_type ] [/liveness_analysis/twn02.c]
!6 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !7, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!7 = metadata !{metadata !8, metadata !8, metadata !8, metadata !8}
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
!18 = metadata !{i32 2, i32 3, metadata !4, null}
!19 = metadata !{i32 2, i32 3, metadata !20, null}
!20 = metadata !{i32 786443, metadata !1, metadata !4, i32 2, i32 3, i32 1, i32 1} ; [ DW_TAG_lexical_block ] [/liveness_analysis/twn02.c]
!21 = metadata !{i32 2, i32 3, metadata !22, null}
!22 = metadata !{i32 786443, metadata !1, metadata !4, i32 2, i32 3, i32 2, i32 2} ; [ DW_TAG_lexical_block ] [/liveness_analysis/twn02.c]
!23 = metadata !{i32 2, i32 3, metadata !24, null}
!24 = metadata !{i32 786443, metadata !1, metadata !4, i32 2, i32 3, i32 3, i32 3} ; [ DW_TAG_lexical_block ] [/liveness_analysis/twn02.c]
!25 = metadata !{i32 3, i32 5, metadata !26, null}
!26 = metadata !{i32 786443, metadata !1, metadata !4, i32 2, i32 27, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/liveness_analysis/twn02.c]
!27 = metadata !{i32 4, i32 5, metadata !26, null}
!28 = metadata !{i32 5, i32 3, metadata !26, null}
!29 = metadata !{i32 6, i32 3, metadata !4, null}

