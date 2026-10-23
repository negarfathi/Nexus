; ModuleID = 'twn11.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind uwtable
define i32 @twn11(i32 %a, i32 %b, i32 %c) #0 {
twn11_bb0:
  call void @llvm.dbg.value(metadata !{i32 %a}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !{i32 %b}, i64 0, metadata !14), !dbg !15
  call void @llvm.dbg.value(metadata !{i32 %c}, i64 0, metadata !16), !dbg !17
  call void @llvm.dbg.value(metadata !{i32 %"17"}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !{i32 %"34"}, i64 0, metadata !14), !dbg !15
  call void @llvm.dbg.value(metadata !{i32 %"63"}, i64 0, metadata !16), !dbg !17
  br label %twn11_bb1, !dbg !18

twn11_bb1:                                        ; preds = %twn11_bb2, %twn11_bb0
  %.02 = phi i32 [ %c, %twn11_bb0 ], [ %"63", %twn11_bb2 ]
  %.01 = phi i32 [ %b, %twn11_bb0 ], [ %"34", %twn11_bb2 ]
  %.0 = phi i32 [ %a, %twn11_bb0 ], [ %"17", %twn11_bb2 ]
  %"0" = mul nsw i32 4, %.01, !dbg !19
  %"1" = mul nsw i32 %"0", %.01, !dbg !19
  %"2" = add nsw i32 %"1", %.0, !dbg !19
  %"3" = add nsw i32 %"2", %.01, !dbg !19
  %"4" = add nsw i32 %"3", %.02, !dbg !19
  %"5" = icmp sgt i32 %"4", 0, !dbg !19
  br i1 %"5", label %twn11_bb2, label %twn11_bb3, !dbg !19

twn11_bb2:                                        ; preds = %twn11_bb1
  %"6" = mul nsw i32 8, %.0, !dbg !21
  %"7" = mul nsw i32 %"6", %.01, !dbg !21
  %"8" = mul nsw i32 %"7", %.01, !dbg !21
  %"9" = add nsw i32 %.0, %"8", !dbg !21
  %"10" = mul nsw i32 16, %.01, !dbg !21
  %"11" = mul nsw i32 %"10", %.01, !dbg !21
  %"12" = mul nsw i32 %"11", %.01, !dbg !21
  %"13" = add nsw i32 %"9", %"12", !dbg !21
  %"14" = mul nsw i32 16, %.01, !dbg !21
  %"15" = mul nsw i32 %"14", %.01, !dbg !21
  %"16" = mul nsw i32 %"15", %.02, !dbg !21
  %"17" = add nsw i32 %"13", %"16", !dbg !21
  %"18" = mul nsw i32 %"17", %"17", !dbg !23
  %"19" = sub nsw i32 %.01, %"18", !dbg !23
  %"20" = mul nsw i32 4, %"17", !dbg !23
  %"21" = mul nsw i32 %"20", %.01, !dbg !23
  %"22" = sub nsw i32 %"19", %"21", !dbg !23
  %"23" = mul nsw i32 4, %"17", !dbg !23
  %"24" = mul nsw i32 %"23", %.02, !dbg !23
  %"25" = sub nsw i32 %"22", %"24", !dbg !23
  %"26" = mul nsw i32 4, %.01, !dbg !23
  %"27" = mul nsw i32 %"26", %.01, !dbg !23
  %"28" = sub nsw i32 %"25", %"27", !dbg !23
  %"29" = mul nsw i32 8, %.01, !dbg !23
  %"30" = mul nsw i32 %"29", %.02, !dbg !23
  %"31" = sub nsw i32 %"28", %"30", !dbg !23
  %"32" = mul nsw i32 4, %.02, !dbg !23
  %"33" = mul nsw i32 %"32", %.02, !dbg !23
  %"34" = sub nsw i32 %"31", %"33", !dbg !23
  %"35" = mul nsw i32 4, %"17", !dbg !24
  %"36" = mul nsw i32 %"35", %"34", !dbg !24
  %"37" = mul nsw i32 %"36", %"34", !dbg !24
  %"38" = sub nsw i32 %.02, %"37", !dbg !24
  %"39" = mul nsw i32 8, %"34", !dbg !24
  %"40" = mul nsw i32 %"39", %"34", !dbg !24
  %"41" = mul nsw i32 %"40", %"34", !dbg !24
  %"42" = sub nsw i32 %"38", %"41", !dbg !24
  %"43" = mul nsw i32 8, %"34", !dbg !24
  %"44" = mul nsw i32 %"43", %"34", !dbg !24
  %"45" = mul nsw i32 %"44", %.02, !dbg !24
  %"46" = sub nsw i32 %"42", %"45", !dbg !24
  %"47" = mul nsw i32 %"17", %"17", !dbg !24
  %"48" = add nsw i32 %"46", %"47", !dbg !24
  %"49" = mul nsw i32 4, %"17", !dbg !24
  %"50" = mul nsw i32 %"49", %"34", !dbg !24
  %"51" = add nsw i32 %"48", %"50", !dbg !24
  %"52" = mul nsw i32 4, %"17", !dbg !24
  %"53" = mul nsw i32 %"52", %.02, !dbg !24
  %"54" = add nsw i32 %"51", %"53", !dbg !24
  %"55" = mul nsw i32 4, %"34", !dbg !24
  %"56" = mul nsw i32 %"55", %"34", !dbg !24
  %"57" = add nsw i32 %"54", %"56", !dbg !24
  %"58" = mul nsw i32 8, %"34", !dbg !24
  %"59" = mul nsw i32 %"58", %.02, !dbg !24
  %"60" = add nsw i32 %"57", %"59", !dbg !24
  %"61" = mul nsw i32 4, %.02, !dbg !24
  %"62" = mul nsw i32 %"61", %.02, !dbg !24
  %"63" = add nsw i32 %"60", %"62", !dbg !24
  br label %twn11_bb1, !dbg !25

twn11_bb3:                                        ; preds = %twn11_bb1
  ret i32 0, !dbg !26
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

!0 = metadata !{i32 786449, metadata !1, i32 12, metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)", i1 false, metadata !"", i32 0, metadata !2, metadata !2, metadata !3, metadata !2, metadata !2, metadata !"", i32 1} ; [ DW_TAG_compile_unit ] [/liveness_analysis/twn11.c] [DW_LANG_C99]
!1 = metadata !{metadata !"twn11.c", metadata !"/liveness_analysis"}
!2 = metadata !{}
!3 = metadata !{metadata !4}
!4 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"twn11", metadata !"twn11", metadata !"", i32 1, metadata !6, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, i32 (i32, i32, i32)* @twn11, null, null, metadata !2, i32 1} ; [ DW_TAG_subprogram ] [line 1] [def] [twn11]
!5 = metadata !{i32 786473, metadata !1}          ; [ DW_TAG_file_type ] [/liveness_analysis/twn11.c]
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
!18 = metadata !{i32 2, i32 5, metadata !4, null}
!19 = metadata !{i32 2, i32 5, metadata !20, null}
!20 = metadata !{i32 786443, metadata !1, metadata !4, i32 2, i32 5, i32 1, i32 1} ; [ DW_TAG_lexical_block ] [/liveness_analysis/twn11.c]
!21 = metadata !{i32 3, i32 9, metadata !22, null}
!22 = metadata !{i32 786443, metadata !1, metadata !4, i32 2, i32 28, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/liveness_analysis/twn11.c]
!23 = metadata !{i32 4, i32 9, metadata !22, null}
!24 = metadata !{i32 5, i32 9, metadata !22, null}
!25 = metadata !{i32 6, i32 5, metadata !22, null}
!26 = metadata !{i32 7, i32 5, metadata !4, null}

