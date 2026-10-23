; ModuleID = 'ex_paper1.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind uwtable
define void @ex_paper1(i32 %x, i32 %y, i32 %z) #0 {
ex_paper1_bb0:
  call void @llvm.dbg.value(metadata !{i32 %x}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !{i32 %y}, i64 0, metadata !14), !dbg !15
  call void @llvm.dbg.value(metadata !{i32 %z}, i64 0, metadata !16), !dbg !17
  %"0" = icmp sle i32 %x, 0, !dbg !18
  %"1" = icmp sle i32 %y, 0, !dbg !20
  %or.cond = or i1 %"0", %"1", !dbg !18
  br i1 %or.cond, label %ex_paper1_bb9, label %ex_paper1_bb1, !dbg !18

ex_paper1_bb1:                                    ; preds = %ex_paper1_bb0, %ex_paper1_bb3
  %.01 = phi i32 [ %.1, %ex_paper1_bb3 ], [ %y, %ex_paper1_bb0 ]
  %.0 = phi i32 [ %"3", %ex_paper1_bb3 ], [ %x, %ex_paper1_bb0 ]
  %"2" = icmp sgt i32 %.0, 0, !dbg !22
  br i1 %"2", label %ex_paper1_bb2, label %ex_paper1_bb5, !dbg !22

ex_paper1_bb2:                                    ; preds = %ex_paper1_bb1
  %"3" = add nsw i32 %.0, -1, !dbg !24
  %"4" = add nsw i32 %.01, 1, !dbg !26
  br label %ex_paper1_bb3, !dbg !27

ex_paper1_bb3:                                    ; preds = %ex_paper1_bb4, %ex_paper1_bb2
  %.1 = phi i32 [ %"4", %ex_paper1_bb2 ], [ %"8", %ex_paper1_bb4 ]
  %"5" = call i32 (...)* @nondet(), !dbg !28
  %"6" = icmp ne i32 %"5", 0, !dbg !28
  %"7" = icmp sgt i32 %.1, 0, !dbg !30
  %. = select i1 %"6", i1 %"7", i1 false, !dbg !28
  br i1 %., label %ex_paper1_bb4, label %ex_paper1_bb1, !dbg !32

ex_paper1_bb4:                                    ; preds = %ex_paper1_bb3
  %"8" = add nsw i32 %.1, -1, !dbg !34
  call void @tick(i32 2), !dbg !36
  br label %ex_paper1_bb3, !dbg !37

ex_paper1_bb5:                                    ; preds = %ex_paper1_bb7, %ex_paper1_bb1
  %.2 = phi i32 [ %.01, %ex_paper1_bb1 ], [ %"10", %ex_paper1_bb7 ]
  %"9" = icmp sgt i32 %.2, 0, !dbg !38
  br i1 %"9", label %ex_paper1_bb6, label %ex_paper1_bb9, !dbg !38

ex_paper1_bb6:                                    ; preds = %ex_paper1_bb5
  %"10" = add nsw i32 %.2, -1, !dbg !40
  br label %ex_paper1_bb7, !dbg !42

ex_paper1_bb7:                                    ; preds = %ex_paper1_bb8, %ex_paper1_bb6
  %i.0 = phi i32 [ 0, %ex_paper1_bb6 ], [ %"12", %ex_paper1_bb8 ]
  %"11" = icmp slt i32 %i.0, %z, !dbg !44
  br i1 %"11", label %ex_paper1_bb8, label %ex_paper1_bb5, !dbg !44

ex_paper1_bb8:                                    ; preds = %ex_paper1_bb7
  call void @tick(i32 1), !dbg !47
  %"12" = add nsw i32 %i.0, 1, !dbg !48
  br label %ex_paper1_bb7, !dbg !48

ex_paper1_bb9:                                    ; preds = %ex_paper1_bb0, %ex_paper1_bb5
  ret void, !dbg !49
}

; Function Attrs: nounwind readnone
declare void @llvm.dbg.declare(metadata, metadata) #1

declare i32 @nondet(...) #2

declare void @tick(i32) #2

declare i32 @__kittel_nondef.0()

; Function Attrs: nounwind readnone
declare void @llvm.dbg.value(metadata, i64, metadata) #1

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone }
attributes #2 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!9, !10}
!llvm.ident = !{!11}

!0 = metadata !{i32 786449, metadata !1, i32 12, metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)", i1 false, metadata !"", i32 0, metadata !2, metadata !2, metadata !3, metadata !2, metadata !2, metadata !"", i32 1} ; [ DW_TAG_compile_unit ] [/liveness_analysis/ex_paper1.c] [DW_LANG_C99]
!1 = metadata !{metadata !"ex_paper1.c", metadata !"/liveness_analysis"}
!2 = metadata !{}
!3 = metadata !{metadata !4}
!4 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"ex_paper1", metadata !"ex_paper1", metadata !"", i32 5, metadata !6, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (i32, i32, i32)* @ex_paper1, null, null, metadata !2, i32 5} ; [ DW_TAG_subprogram ] [line 5] [def] [ex_paper1]
!5 = metadata !{i32 786473, metadata !1}          ; [ DW_TAG_file_type ] [/liveness_analysis/ex_paper1.c]
!6 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !7, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!7 = metadata !{null, metadata !8, metadata !8, metadata !8}
!8 = metadata !{i32 786468, null, null, metadata !"int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!9 = metadata !{i32 2, metadata !"Dwarf Version", i32 4}
!10 = metadata !{i32 2, metadata !"Debug Info Version", i32 1}
!11 = metadata !{metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)"}
!12 = metadata !{i32 786689, metadata !4, metadata !"x", metadata !5, i32 16777221, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [x] [line 5]
!13 = metadata !{i32 5, i32 20, metadata !4, null}
!14 = metadata !{i32 786689, metadata !4, metadata !"y", metadata !5, i32 33554437, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [y] [line 5]
!15 = metadata !{i32 5, i32 26, metadata !4, null}
!16 = metadata !{i32 786689, metadata !4, metadata !"z", metadata !5, i32 50331653, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [z] [line 5]
!17 = metadata !{i32 5, i32 32, metadata !4, null}
!18 = metadata !{i32 6, i32 4, metadata !19, null}
!19 = metadata !{i32 786443, metadata !1, metadata !4, i32 6, i32 4, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/liveness_analysis/ex_paper1.c]
!20 = metadata !{i32 7, i32 4, metadata !21, null}
!21 = metadata !{i32 786443, metadata !1, metadata !4, i32 7, i32 4, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/liveness_analysis/ex_paper1.c]
!22 = metadata !{i32 8, i32 2, metadata !23, null} ; [ DW_TAG_imported_declaration ]
!23 = metadata !{i32 786443, metadata !1, metadata !4, i32 8, i32 2, i32 1, i32 8} ; [ DW_TAG_lexical_block ] [/liveness_analysis/ex_paper1.c]
!24 = metadata !{i32 9, i32 4, metadata !25, null}
!25 = metadata !{i32 786443, metadata !1, metadata !4, i32 8, i32 13, i32 0, i32 2} ; [ DW_TAG_lexical_block ] [/liveness_analysis/ex_paper1.c]
!26 = metadata !{i32 10, i32 4, metadata !25, null}
!27 = metadata !{i32 11, i32 2, metadata !25, null}
!28 = metadata !{i32 11, i32 8, metadata !29, null}
!29 = metadata !{i32 786443, metadata !1, metadata !25, i32 11, i32 8, i32 1, i32 9} ; [ DW_TAG_lexical_block ] [/liveness_analysis/ex_paper1.c]
!30 = metadata !{i32 11, i32 8, metadata !31, null}
!31 = metadata !{i32 786443, metadata !1, metadata !25, i32 11, i32 8, i32 2, i32 10} ; [ DW_TAG_lexical_block ] [/liveness_analysis/ex_paper1.c]
!32 = metadata !{i32 11, i32 8, metadata !33, null}
!33 = metadata !{i32 786443, metadata !1, metadata !25, i32 11, i32 8, i32 3, i32 11} ; [ DW_TAG_lexical_block ] [/liveness_analysis/ex_paper1.c]
!34 = metadata !{i32 12, i32 6, metadata !35, null}
!35 = metadata !{i32 786443, metadata !1, metadata !25, i32 11, i32 24, i32 0, i32 3} ; [ DW_TAG_lexical_block ] [/liveness_analysis/ex_paper1.c]
!36 = metadata !{i32 13, i32 6, metadata !35, null}
!37 = metadata !{i32 14, i32 4, metadata !35, null}
!38 = metadata !{i32 16, i32 3, metadata !39, null}
!39 = metadata !{i32 786443, metadata !1, metadata !4, i32 16, i32 3, i32 1, i32 12} ; [ DW_TAG_lexical_block ] [/liveness_analysis/ex_paper1.c]
!40 = metadata !{i32 17, i32 5, metadata !41, null}
!41 = metadata !{i32 786443, metadata !1, metadata !4, i32 16, i32 13, i32 0, i32 4} ; [ DW_TAG_lexical_block ] [/liveness_analysis/ex_paper1.c]
!42 = metadata !{i32 18, i32 9, metadata !43, null}
!43 = metadata !{i32 786443, metadata !1, metadata !41, i32 18, i32 5, i32 0, i32 5} ; [ DW_TAG_lexical_block ] [/liveness_analysis/ex_paper1.c]
!44 = metadata !{i32 18, i32 9, metadata !45, null}
!45 = metadata !{i32 786443, metadata !1, metadata !46, i32 18, i32 9, i32 2, i32 14} ; [ DW_TAG_lexical_block ] [/liveness_analysis/ex_paper1.c]
!46 = metadata !{i32 786443, metadata !1, metadata !43, i32 18, i32 9, i32 1, i32 13} ; [ DW_TAG_lexical_block ] [/liveness_analysis/ex_paper1.c]
!47 = metadata !{i32 19, i32 8, metadata !43, null}
!48 = metadata !{i32 18, i32 21, metadata !43, null}
!49 = metadata !{i32 22, i32 1, metadata !4, null}

