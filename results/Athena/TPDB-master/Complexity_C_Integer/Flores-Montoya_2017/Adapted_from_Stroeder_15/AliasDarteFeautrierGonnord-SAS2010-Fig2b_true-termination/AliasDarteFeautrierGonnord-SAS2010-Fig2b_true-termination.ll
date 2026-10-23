; ModuleID = 'AliasDarteFeautrierGonnord-SAS2010-Fig2b_true-termination.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind uwtable
define i32 @foo(i32 %x, i32 %y) #0 {
foo_bb0:
  call void @llvm.dbg.value(metadata !{i32 %x}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !{i32 %y}, i64 0, metadata !14), !dbg !15
  call void @llvm.dbg.value(metadata !{i32 %"1"}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !{i32 %"2"}, i64 0, metadata !14), !dbg !15
  call void @llvm.dbg.value(metadata !{i32 %"7"}, i64 0, metadata !14), !dbg !15
  call void @llvm.dbg.value(metadata !{i32 %"12"}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !{i32 %"13"}, i64 0, metadata !14), !dbg !15
  br label %foo_bb1, !dbg !16

foo_bb1:                                          ; preds = %foo_.critedge, %foo_bb0
  %.01 = phi i32 [ %y, %foo_bb0 ], [ %"16", %foo_.critedge ]
  %.0 = phi i32 [ %x, %foo_bb0 ], [ %"15", %foo_.critedge ]
  %"0" = icmp sge i32 %.0, 2, !dbg !17
  br i1 %"0", label %foo_bb2, label %foo_bb9, !dbg !17

foo_bb2:                                          ; preds = %foo_bb1
  %"1" = sub nsw i32 %.0, 1, !dbg !19
  %"2" = add nsw i32 %.01, %"1", !dbg !21
  br label %foo_bb3, !dbg !22

foo_bb3:                                          ; preds = %foo_.critedge4, %foo_bb2
  %.12 = phi i32 [ %"2", %foo_bb2 ], [ %"14", %foo_.critedge4 ]
  %.1 = phi i32 [ %"1", %foo_bb2 ], [ %.2, %foo_.critedge4 ]
  %"3" = add nsw i32 %.1, 1, !dbg !23
  %"4" = icmp sge i32 %.12, %"3", !dbg !23
  br i1 %"4", label %foo_bb4, label %foo_.critedge, !dbg !23

foo_bb4:                                          ; preds = %foo_bb3
  %"5" = call i32 @__VERIFIER_nondet_int(), !dbg !25
  %"6" = icmp ne i32 %"5", 0, !dbg !25
  br i1 %"6", label %foo_bb5, label %foo_.critedge, !dbg !27

foo_bb5:                                          ; preds = %foo_bb4
  %"7" = sub nsw i32 %.12, 1, !dbg !29
  br label %foo_bb6, !dbg !31

foo_bb6:                                          ; preds = %foo_bb8, %foo_bb5
  %.23 = phi i32 [ %"7", %foo_bb5 ], [ %"13", %foo_bb8 ]
  %.2 = phi i32 [ %.1, %foo_bb5 ], [ %"12", %foo_bb8 ]
  %"8" = add nsw i32 %.2, 3, !dbg !32
  %"9" = icmp sge i32 %.23, %"8", !dbg !32
  br i1 %"9", label %foo_bb7, label %foo_.critedge4, !dbg !32

foo_bb7:                                          ; preds = %foo_bb6
  %"10" = call i32 @__VERIFIER_nondet_int(), !dbg !34
  %"11" = icmp ne i32 %"10", 0, !dbg !34
  br i1 %"11", label %foo_bb8, label %foo_.critedge4, !dbg !36

foo_bb8:                                          ; preds = %foo_bb7
  %"12" = add nsw i32 %.2, 1, !dbg !38
  %"13" = sub nsw i32 %.23, 2, !dbg !40
  br label %foo_bb6, !dbg !41

foo_.critedge4:                                   ; preds = %foo_bb6, %foo_bb7
  %"14" = sub nsw i32 %.23, 1, !dbg !42
  call void @llvm.dbg.value(metadata !{i32 %"14"}, i64 0, metadata !14), !dbg !15
  br label %foo_bb3, !dbg !43

foo_.critedge:                                    ; preds = %foo_bb3, %foo_bb4
  %"15" = sub nsw i32 %.1, 1, !dbg !44
  call void @llvm.dbg.value(metadata !{i32 %"15"}, i64 0, metadata !12), !dbg !13
  %"16" = sub nsw i32 %.12, %"15", !dbg !45
  call void @llvm.dbg.value(metadata !{i32 %"16"}, i64 0, metadata !14), !dbg !15
  br label %foo_bb1, !dbg !46

foo_bb9:                                          ; preds = %foo_bb1
  ret i32 0, !dbg !47
}

; Function Attrs: nounwind readnone
declare void @llvm.dbg.declare(metadata, metadata) #1

declare i32 @__VERIFIER_nondet_int() #2

declare i32 @__kittel_nondef.0()

; Function Attrs: nounwind readnone
declare void @llvm.dbg.value(metadata, i64, metadata) #1

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone }
attributes #2 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!9, !10}
!llvm.ident = !{!11}

!0 = metadata !{i32 786449, metadata !1, i32 12, metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)", i1 false, metadata !"", i32 0, metadata !2, metadata !2, metadata !3, metadata !2, metadata !2, metadata !"", i32 1} ; [ DW_TAG_compile_unit ] [/liveness_analysis/AliasDarteFeautrierGonnord-SAS2010-Fig2b_true-termination.c] [DW_LANG_C99]
!1 = metadata !{metadata !"AliasDarteFeautrierGonnord-SAS2010-Fig2b_true-termination.c", metadata !"/liveness_analysis"}
!2 = metadata !{}
!3 = metadata !{metadata !4}
!4 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"foo", metadata !"foo", metadata !"", i32 3, metadata !6, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, i32 (i32, i32)* @foo, null, null, metadata !2, i32 3} ; [ DW_TAG_subprogram ] [line 3] [def] [foo]
!5 = metadata !{i32 786473, metadata !1}          ; [ DW_TAG_file_type ] [/liveness_analysis/AliasDarteFeautrierGonnord-SAS2010-Fig2b_true-termination.c]
!6 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !7, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!7 = metadata !{metadata !8, metadata !8, metadata !8}
!8 = metadata !{i32 786468, null, null, metadata !"int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!9 = metadata !{i32 2, metadata !"Dwarf Version", i32 4}
!10 = metadata !{i32 2, metadata !"Debug Info Version", i32 1}
!11 = metadata !{metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)"}
!12 = metadata !{i32 786689, metadata !4, metadata !"x", metadata !5, i32 16777219, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [x] [line 3]
!13 = metadata !{i32 3, i32 13, metadata !4, null}
!14 = metadata !{i32 786689, metadata !4, metadata !"y", metadata !5, i32 33554435, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [y] [line 3]
!15 = metadata !{i32 3, i32 19, metadata !4, null}
!16 = metadata !{i32 4, i32 1, metadata !4, null}
!17 = metadata !{i32 4, i32 1, metadata !18, null}
!18 = metadata !{i32 786443, metadata !1, metadata !4, i32 4, i32 1, i32 1, i32 3} ; [ DW_TAG_lexical_block ] [/liveness_analysis/AliasDarteFeautrierGonnord-SAS2010-Fig2b_true-termination.c]
!19 = metadata !{i32 5, i32 3, metadata !20, null}
!20 = metadata !{i32 786443, metadata !1, metadata !4, i32 4, i32 16, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/liveness_analysis/AliasDarteFeautrierGonnord-SAS2010-Fig2b_true-termination.c]
!21 = metadata !{i32 6, i32 9, metadata !20, null}
!22 = metadata !{i32 7, i32 3, metadata !20, null}
!23 = metadata !{i32 7, i32 3, metadata !24, null}
!24 = metadata !{i32 786443, metadata !1, metadata !20, i32 7, i32 3, i32 1, i32 4} ; [ DW_TAG_lexical_block ] [/liveness_analysis/AliasDarteFeautrierGonnord-SAS2010-Fig2b_true-termination.c]
!25 = metadata !{i32 7, i32 24, metadata !26, null}
!26 = metadata !{i32 786443, metadata !1, metadata !20, i32 7, i32 24, i32 2, i32 5} ; [ DW_TAG_lexical_block ] [/liveness_analysis/AliasDarteFeautrierGonnord-SAS2010-Fig2b_true-termination.c]
!27 = metadata !{i32 7, i32 24, metadata !28, null}
!28 = metadata !{i32 786443, metadata !1, metadata !20, i32 7, i32 24, i32 3, i32 6} ; [ DW_TAG_lexical_block ] [/liveness_analysis/AliasDarteFeautrierGonnord-SAS2010-Fig2b_true-termination.c]
!29 = metadata !{i32 8, i32 4, metadata !30, null} ; [ DW_TAG_imported_declaration ]
!30 = metadata !{i32 786443, metadata !1, metadata !20, i32 7, i32 54, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/liveness_analysis/AliasDarteFeautrierGonnord-SAS2010-Fig2b_true-termination.c]
!31 = metadata !{i32 9, i32 4, metadata !30, null}
!32 = metadata !{i32 9, i32 4, metadata !33, null}
!33 = metadata !{i32 786443, metadata !1, metadata !30, i32 9, i32 4, i32 1, i32 7} ; [ DW_TAG_lexical_block ] [/liveness_analysis/AliasDarteFeautrierGonnord-SAS2010-Fig2b_true-termination.c]
!34 = metadata !{i32 9, i32 25, metadata !35, null}
!35 = metadata !{i32 786443, metadata !1, metadata !30, i32 9, i32 25, i32 2, i32 8} ; [ DW_TAG_lexical_block ] [/liveness_analysis/AliasDarteFeautrierGonnord-SAS2010-Fig2b_true-termination.c]
!36 = metadata !{i32 9, i32 25, metadata !37, null}
!37 = metadata !{i32 786443, metadata !1, metadata !30, i32 9, i32 25, i32 3, i32 9} ; [ DW_TAG_lexical_block ] [/liveness_analysis/AliasDarteFeautrierGonnord-SAS2010-Fig2b_true-termination.c]
!38 = metadata !{i32 10, i32 5, metadata !39, null}
!39 = metadata !{i32 786443, metadata !1, metadata !30, i32 9, i32 55, i32 0, i32 2} ; [ DW_TAG_lexical_block ] [/liveness_analysis/AliasDarteFeautrierGonnord-SAS2010-Fig2b_true-termination.c]
!40 = metadata !{i32 11, i32 17, metadata !39, null}
!41 = metadata !{i32 12, i32 4, metadata !39, null}
!42 = metadata !{i32 13, i32 4, metadata !30, null}
!43 = metadata !{i32 14, i32 3, metadata !30, null}
!44 = metadata !{i32 15, i32 3, metadata !20, null}
!45 = metadata !{i32 16, i32 9, metadata !20, null}
!46 = metadata !{i32 17, i32 2, metadata !20, null}
!47 = metadata !{i32 18, i32 1, metadata !4, null}

