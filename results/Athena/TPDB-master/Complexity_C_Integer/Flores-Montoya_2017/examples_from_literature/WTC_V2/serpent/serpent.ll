; ModuleID = 'serpent.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind uwtable
define void @serpent(i32 %n) #0 {
serpent_bb0:
  call void @llvm.dbg.value(metadata !{i32 %n}, i64 0, metadata !12), !dbg !13
  %"0" = icmp sle i32 %n, 0, !dbg !14
  br i1 %"0", label %serpent_bb7, label %serpent_.critedge1, !dbg !14

serpent_.critedge1:                               ; preds = %serpent_bb5, %serpent_bb4, %serpent_bb0
  %y.0 = phi i32 [ %n, %serpent_bb0 ], [ %y.2, %serpent_bb4 ], [ %y.2, %serpent_bb5 ]
  %x.0 = phi i32 [ %n, %serpent_bb0 ], [ %"6", %serpent_bb4 ], [ %"6", %serpent_bb5 ]
  %"1" = icmp sge i32 %x.0, 0, !dbg !16
  br i1 %"1", label %serpent_bb1, label %serpent_bb7, !dbg !16

serpent_bb1:                                      ; preds = %serpent_.critedge1, %serpent_bb3
  %y.1 = phi i32 [ %"5", %serpent_bb3 ], [ %y.0, %serpent_.critedge1 ]
  %"2" = icmp sge i32 %y.1, 0, !dbg !18
  br i1 %"2", label %serpent_bb2, label %serpent_.critedge, !dbg !18

serpent_bb2:                                      ; preds = %serpent_bb1
  %"3" = call i32 (...)* @nondet(), !dbg !21
  %"4" = icmp sgt i32 %"3", 0, !dbg !21
  br i1 %"4", label %serpent_bb3, label %serpent_.critedge, !dbg !23

serpent_bb3:                                      ; preds = %serpent_bb2
  %"5" = add nsw i32 %y.1, -1, !dbg !25
  br label %serpent_bb1, !dbg !27

serpent_.critedge:                                ; preds = %serpent_bb1, %serpent_bb2
  %"6" = add nsw i32 %x.0, -1, !dbg !28
  call void @llvm.dbg.value(metadata !{i32 %"6"}, i64 0, metadata !29), !dbg !30
  call void @llvm.dbg.value(metadata !{i32 %"10"}, i64 0, metadata !31), !dbg !32
  br label %serpent_bb4, !dbg !33

serpent_bb4:                                      ; preds = %serpent_bb6, %serpent_.critedge
  %y.2 = phi i32 [ %y.1, %serpent_.critedge ], [ %"10", %serpent_bb6 ]
  %"7" = icmp sle i32 %y.2, %n, !dbg !34
  br i1 %"7", label %serpent_bb5, label %serpent_.critedge1, !dbg !34

serpent_bb5:                                      ; preds = %serpent_bb4
  %"8" = call i32 (...)* @nondet(), !dbg !36
  %"9" = icmp sgt i32 %"8", 0, !dbg !36
  br i1 %"9", label %serpent_bb6, label %serpent_.critedge1, !dbg !38

serpent_bb6:                                      ; preds = %serpent_bb5
  %"10" = add nsw i32 %y.2, 1, !dbg !40
  br label %serpent_bb4, !dbg !42

serpent_bb7:                                      ; preds = %serpent_bb0, %serpent_.critedge1
  ret void, !dbg !43
}

; Function Attrs: nounwind readnone
declare void @llvm.dbg.declare(metadata, metadata) #1

declare i32 @nondet(...) #2

declare i32 @__kittel_nondef.0()

; Function Attrs: nounwind readnone
declare void @llvm.dbg.value(metadata, i64, metadata) #1

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone }
attributes #2 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!9, !10}
!llvm.ident = !{!11}

!0 = metadata !{i32 786449, metadata !1, i32 12, metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)", i1 false, metadata !"", i32 0, metadata !2, metadata !2, metadata !3, metadata !2, metadata !2, metadata !"", i32 1} ; [ DW_TAG_compile_unit ] [/liveness_analysis/serpent.c] [DW_LANG_C99]
!1 = metadata !{metadata !"serpent.c", metadata !"/liveness_analysis"}
!2 = metadata !{}
!3 = metadata !{metadata !4}
!4 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"serpent", metadata !"serpent", metadata !"", i32 3, metadata !6, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (i32)* @serpent, null, null, metadata !2, i32 3} ; [ DW_TAG_subprogram ] [line 3] [def] [serpent]
!5 = metadata !{i32 786473, metadata !1}          ; [ DW_TAG_file_type ] [/liveness_analysis/serpent.c]
!6 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !7, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!7 = metadata !{null, metadata !8}
!8 = metadata !{i32 786468, null, null, metadata !"int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!9 = metadata !{i32 2, metadata !"Dwarf Version", i32 4}
!10 = metadata !{i32 2, metadata !"Debug Info Version", i32 1}
!11 = metadata !{metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)"}
!12 = metadata !{i32 786689, metadata !4, metadata !"n", metadata !5, i32 16777219, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [n] [line 3]
!13 = metadata !{i32 3, i32 18, metadata !4, null}
!14 = metadata !{i32 5, i32 6, metadata !15, null}
!15 = metadata !{i32 786443, metadata !1, metadata !4, i32 5, i32 6, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/liveness_analysis/serpent.c]
!16 = metadata !{i32 7, i32 3, metadata !17, null}
!17 = metadata !{i32 786443, metadata !1, metadata !4, i32 7, i32 3, i32 1, i32 5} ; [ DW_TAG_lexical_block ] [/liveness_analysis/serpent.c]
!18 = metadata !{i32 8, i32 5, metadata !19, null} ; [ DW_TAG_imported_declaration ]
!19 = metadata !{i32 786443, metadata !1, metadata !20, i32 8, i32 5, i32 1, i32 7} ; [ DW_TAG_lexical_block ] [/liveness_analysis/serpent.c]
!20 = metadata !{i32 786443, metadata !1, metadata !4, i32 7, i32 16, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/liveness_analysis/serpent.c]
!21 = metadata !{i32 8, i32 19, metadata !22, null} ; [ DW_TAG_imported_declaration ]
!22 = metadata !{i32 786443, metadata !1, metadata !20, i32 8, i32 19, i32 2, i32 8} ; [ DW_TAG_lexical_block ] [/liveness_analysis/serpent.c]
!23 = metadata !{i32 8, i32 19, metadata !24, null} ; [ DW_TAG_imported_declaration ]
!24 = metadata !{i32 786443, metadata !1, metadata !20, i32 8, i32 19, i32 3, i32 9} ; [ DW_TAG_lexical_block ] [/liveness_analysis/serpent.c]
!25 = metadata !{i32 9, i32 7, metadata !26, null}
!26 = metadata !{i32 786443, metadata !1, metadata !20, i32 8, i32 30, i32 0, i32 2} ; [ DW_TAG_lexical_block ] [/liveness_analysis/serpent.c]
!27 = metadata !{i32 10, i32 5, metadata !26, null}
!28 = metadata !{i32 11, i32 5, metadata !20, null}
!29 = metadata !{i32 786688, metadata !4, metadata !"x", metadata !5, i32 4, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [x] [line 4]
!30 = metadata !{i32 4, i32 7, metadata !4, null}
!31 = metadata !{i32 786688, metadata !4, metadata !"y", metadata !5, i32 4, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [y] [line 4]
!32 = metadata !{i32 4, i32 10, metadata !4, null}
!33 = metadata !{i32 12, i32 5, metadata !20, null}
!34 = metadata !{i32 12, i32 5, metadata !35, null}
!35 = metadata !{i32 786443, metadata !1, metadata !20, i32 12, i32 5, i32 1, i32 10} ; [ DW_TAG_lexical_block ] [/liveness_analysis/serpent.c]
!36 = metadata !{i32 12, i32 19, metadata !37, null}
!37 = metadata !{i32 786443, metadata !1, metadata !20, i32 12, i32 19, i32 2, i32 11} ; [ DW_TAG_lexical_block ] [/liveness_analysis/serpent.c]
!38 = metadata !{i32 12, i32 19, metadata !39, null}
!39 = metadata !{i32 786443, metadata !1, metadata !20, i32 12, i32 19, i32 3, i32 12} ; [ DW_TAG_lexical_block ] [/liveness_analysis/serpent.c]
!40 = metadata !{i32 13, i32 7, metadata !41, null}
!41 = metadata !{i32 786443, metadata !1, metadata !20, i32 12, i32 30, i32 0, i32 3} ; [ DW_TAG_lexical_block ] [/liveness_analysis/serpent.c]
!42 = metadata !{i32 14, i32 5, metadata !41, null}
!43 = metadata !{i32 16, i32 1, metadata !4, null}

