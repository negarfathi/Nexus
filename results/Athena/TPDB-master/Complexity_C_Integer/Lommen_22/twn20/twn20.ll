; ModuleID = 'twn20.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind uwtable
define i32 @twn20(i32 %a, i32 %b, i32 %c) #0 {
twn20_bb0:
  call void @llvm.dbg.value(metadata !{i32 %a}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !{i32 %b}, i64 0, metadata !14), !dbg !15
  call void @llvm.dbg.value(metadata !{i32 %c}, i64 0, metadata !16), !dbg !17
  %"0" = icmp sgt i32 %c, 0, !dbg !18
  br i1 %"0", label %twn20_bb1, label %twn20_bb3, !dbg !18

twn20_bb1:                                        ; preds = %twn20_bb0, %twn20_bb2
  %.01 = phi i32 [ %"14", %twn20_bb2 ], [ %b, %twn20_bb0 ]
  %.0 = phi i32 [ %"9", %twn20_bb2 ], [ %a, %twn20_bb0 ]
  %"1" = mul nsw i32 %.0, %.0, !dbg !20
  %"2" = mul nsw i32 %c, %c, !dbg !20
  %"3" = mul nsw i32 %"2", %c, !dbg !20
  %"4" = mul nsw i32 %"3", %c, !dbg !20
  %"5" = mul nsw i32 %"4", %c, !dbg !20
  %"6" = add nsw i32 %"1", %"5", !dbg !20
  %"7" = icmp slt i32 %"6", %.01, !dbg !20
  %"8" = icmp ne i32 %.0, 0, !dbg !23
  %. = select i1 %"7", i1 %"8", i1 false, !dbg !20
  br i1 %., label %twn20_bb2, label %twn20_bb3, !dbg !25

twn20_bb2:                                        ; preds = %twn20_bb1
  %"9" = mul nsw i32 4, %.0, !dbg !27
  %"10" = mul nsw i32 9, %.01, !dbg !29
  %"11" = mul nsw i32 8, %c, !dbg !29
  %"12" = mul nsw i32 %"11", %c, !dbg !29
  %"13" = mul nsw i32 %"12", %c, !dbg !29
  %"14" = sub nsw i32 %"10", %"13", !dbg !29
  br label %twn20_bb1, !dbg !30

twn20_bb3:                                        ; preds = %twn20_bb1, %twn20_bb0
  ret i32 0, !dbg !31
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

!0 = metadata !{i32 786449, metadata !1, i32 12, metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)", i1 false, metadata !"", i32 0, metadata !2, metadata !2, metadata !3, metadata !2, metadata !2, metadata !"", i32 1} ; [ DW_TAG_compile_unit ] [/liveness_analysis/twn20.c] [DW_LANG_C99]
!1 = metadata !{metadata !"twn20.c", metadata !"/liveness_analysis"}
!2 = metadata !{}
!3 = metadata !{metadata !4}
!4 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"twn20", metadata !"twn20", metadata !"", i32 1, metadata !6, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, i32 (i32, i32, i32)* @twn20, null, null, metadata !2, i32 1} ; [ DW_TAG_subprogram ] [line 1] [def] [twn20]
!5 = metadata !{i32 786473, metadata !1}          ; [ DW_TAG_file_type ] [/liveness_analysis/twn20.c]
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
!18 = metadata !{i32 2, i32 6, metadata !19, null}
!19 = metadata !{i32 786443, metadata !1, metadata !4, i32 2, i32 6, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/liveness_analysis/twn20.c]
!20 = metadata !{i32 3, i32 5, metadata !21, null}
!21 = metadata !{i32 786443, metadata !1, metadata !22, i32 3, i32 5, i32 1, i32 3} ; [ DW_TAG_lexical_block ] [/liveness_analysis/twn20.c]
!22 = metadata !{i32 786443, metadata !1, metadata !19, i32 2, i32 13, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/liveness_analysis/twn20.c]
!23 = metadata !{i32 3, i32 5, metadata !24, null}
!24 = metadata !{i32 786443, metadata !1, metadata !22, i32 3, i32 5, i32 2, i32 4} ; [ DW_TAG_lexical_block ] [/liveness_analysis/twn20.c]
!25 = metadata !{i32 3, i32 5, metadata !26, null}
!26 = metadata !{i32 786443, metadata !1, metadata !22, i32 3, i32 5, i32 3, i32 5} ; [ DW_TAG_lexical_block ] [/liveness_analysis/twn20.c]
!27 = metadata !{i32 4, i32 7, metadata !28, null}
!28 = metadata !{i32 786443, metadata !1, metadata !22, i32 3, i32 42, i32 0, i32 2} ; [ DW_TAG_lexical_block ] [/liveness_analysis/twn20.c]
!29 = metadata !{i32 5, i32 7, metadata !28, null}
!30 = metadata !{i32 7, i32 5, metadata !28, null}
!31 = metadata !{i32 9, i32 3, metadata !4, null}

