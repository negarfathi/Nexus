; ModuleID = 'twn14.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind uwtable
define i32 @twn14(i32 %a, i32 %b, i32 %c, i32 %d, i32 %e) #0 {
twn14_bb0:
  call void @llvm.dbg.value(metadata !{i32 %a}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !{i32 %b}, i64 0, metadata !14), !dbg !15
  call void @llvm.dbg.value(metadata !{i32 %c}, i64 0, metadata !16), !dbg !17
  call void @llvm.dbg.value(metadata !{i32 %d}, i64 0, metadata !18), !dbg !19
  call void @llvm.dbg.value(metadata !{i32 %e}, i64 0, metadata !20), !dbg !21
  call void @llvm.dbg.value(metadata !{i32 %.0}, i64 0, metadata !14), !dbg !15
  call void @llvm.dbg.value(metadata !{i32 %e}, i64 0, metadata !16), !dbg !17
  call void @llvm.dbg.value(metadata !{i32 %"10"}, i64 0, metadata !14), !dbg !15
  call void @llvm.dbg.value(metadata !{i32 %"14"}, i64 0, metadata !16), !dbg !17
  call void @llvm.dbg.value(metadata !{i32 %"15"}, i64 0, metadata !12), !dbg !13
  br label %twn14_bb1, !dbg !22

twn14_bb1:                                        ; preds = %twn14_.critedge, %twn14_bb0
  %.0 = phi i32 [ %a, %twn14_bb0 ], [ %"15", %twn14_.critedge ]
  %"0" = icmp sgt i32 %.0, 0, !dbg !23
  br i1 %"0", label %twn14_bb2, label %twn14_bb6, !dbg !23

twn14_bb2:                                        ; preds = %twn14_bb1
  %"1" = icmp sgt i32 %d, 0, !dbg !25
  br i1 %"1", label %twn14_bb3, label %twn14_.critedge, !dbg !25

twn14_bb3:                                        ; preds = %twn14_bb2, %twn14_bb5
  %.02 = phi i32 [ %"14", %twn14_bb5 ], [ %e, %twn14_bb2 ]
  %.01 = phi i32 [ %"10", %twn14_bb5 ], [ %.0, %twn14_bb2 ]
  %"2" = icmp ne i32 %.01, 0, !dbg !28
  br i1 %"2", label %twn14_bb4, label %twn14_.critedge, !dbg !28

twn14_bb4:                                        ; preds = %twn14_bb3
  %"3" = mul nsw i32 %.01, %.01, !dbg !31
  %"4" = mul nsw i32 %d, %d, !dbg !31
  %"5" = mul nsw i32 %"4", %d, !dbg !31
  %"6" = mul nsw i32 %"5", %d, !dbg !31
  %"7" = mul nsw i32 %"6", %d, !dbg !31
  %"8" = add nsw i32 %"3", %"7", !dbg !31
  %"9" = icmp slt i32 %"8", %.02, !dbg !31
  br i1 %"9", label %twn14_bb5, label %twn14_.critedge, !dbg !33

twn14_bb5:                                        ; preds = %twn14_bb4
  %"10" = mul nsw i32 -2, %.01, !dbg !35
  %"11" = mul nsw i32 3, %.02, !dbg !37
  %"12" = mul nsw i32 %d, %d, !dbg !37
  %"13" = mul nsw i32 %"12", %d, !dbg !37
  %"14" = sub nsw i32 %"11", %"13", !dbg !37
  br label %twn14_bb3, !dbg !38

twn14_.critedge:                                  ; preds = %twn14_bb4, %twn14_bb3, %twn14_bb2
  %"15" = sub nsw i32 %.0, 1, !dbg !39
  br label %twn14_bb1, !dbg !40

twn14_bb6:                                        ; preds = %twn14_bb1
  ret i32 0, !dbg !41
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

!0 = metadata !{i32 786449, metadata !1, i32 12, metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)", i1 false, metadata !"", i32 0, metadata !2, metadata !2, metadata !3, metadata !2, metadata !2, metadata !"", i32 1} ; [ DW_TAG_compile_unit ] [/liveness_analysis/twn14.c] [DW_LANG_C99]
!1 = metadata !{metadata !"twn14.c", metadata !"/liveness_analysis"}
!2 = metadata !{}
!3 = metadata !{metadata !4}
!4 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"twn14", metadata !"twn14", metadata !"", i32 1, metadata !6, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, i32 (i32, i32, i32, i32, i32)* @twn14, null, null, metadata !2, i32 1} ; [ DW_TAG_subprogram ] [line 1] [def] [twn14]
!5 = metadata !{i32 786473, metadata !1}          ; [ DW_TAG_file_type ] [/liveness_analysis/twn14.c]
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
!22 = metadata !{i32 2, i32 3, metadata !4, null}
!23 = metadata !{i32 2, i32 3, metadata !24, null}
!24 = metadata !{i32 786443, metadata !1, metadata !4, i32 2, i32 3, i32 1, i32 4} ; [ DW_TAG_lexical_block ] [/liveness_analysis/twn14.c]
!25 = metadata !{i32 5, i32 8, metadata !26, null}
!26 = metadata !{i32 786443, metadata !1, metadata !27, i32 5, i32 8, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/liveness_analysis/twn14.c]
!27 = metadata !{i32 786443, metadata !1, metadata !4, i32 2, i32 16, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/liveness_analysis/twn14.c]
!28 = metadata !{i32 6, i32 7, metadata !29, null}
!29 = metadata !{i32 786443, metadata !1, metadata !30, i32 6, i32 7, i32 1, i32 5} ; [ DW_TAG_lexical_block ] [/liveness_analysis/twn14.c]
!30 = metadata !{i32 786443, metadata !1, metadata !26, i32 5, i32 15, i32 0, i32 2} ; [ DW_TAG_lexical_block ] [/liveness_analysis/twn14.c]
!31 = metadata !{i32 6, i32 7, metadata !32, null}
!32 = metadata !{i32 786443, metadata !1, metadata !30, i32 6, i32 7, i32 2, i32 6} ; [ DW_TAG_lexical_block ] [/liveness_analysis/twn14.c]
!33 = metadata !{i32 6, i32 7, metadata !34, null}
!34 = metadata !{i32 786443, metadata !1, metadata !30, i32 6, i32 7, i32 3, i32 7} ; [ DW_TAG_lexical_block ] [/liveness_analysis/twn14.c]
!35 = metadata !{i32 7, i32 9, metadata !36, null}
!36 = metadata !{i32 786443, metadata !1, metadata !30, i32 6, i32 45, i32 0, i32 3} ; [ DW_TAG_lexical_block ] [/liveness_analysis/twn14.c]
!37 = metadata !{i32 8, i32 9, metadata !36, null} ; [ DW_TAG_imported_declaration ]
!38 = metadata !{i32 9, i32 7, metadata !36, null}
!39 = metadata !{i32 11, i32 5, metadata !27, null}
!40 = metadata !{i32 12, i32 3, metadata !27, null}
!41 = metadata !{i32 13, i32 3, metadata !4, null}

