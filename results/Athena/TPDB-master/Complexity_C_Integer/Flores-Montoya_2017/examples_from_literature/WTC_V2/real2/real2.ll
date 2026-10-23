; ModuleID = 'real2.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind uwtable
define void @real2(i32 %len) #0 {
real2_bb0:
  call void @llvm.dbg.value(metadata !{i32 %len}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !14, i64 0, metadata !15), !dbg !16
  call void @llvm.dbg.value(metadata !17, i64 0, metadata !15), !dbg !16
  call void @llvm.dbg.value(metadata !17, i64 0, metadata !18), !dbg !19
  call void @llvm.dbg.value(metadata !{i32 %"6"}, i64 0, metadata !20), !dbg !21
  call void @llvm.dbg.value(metadata !14, i64 0, metadata !15), !dbg !16
  call void @llvm.dbg.value(metadata !{i32 %"7"}, i64 0, metadata !18), !dbg !19
  br label %real2_bb1, !dbg !22

real2_bb1:                                        ; preds = %real2_bb2, %real2_bb0
  %again.0 = phi i32 [ 1, %real2_bb0 ], [ %again.1, %real2_bb2 ]
  %"0" = icmp ne i32 %again.0, 0, !dbg !24
  br i1 %"0", label %real2_bb2, label %real2_bb6, !dbg !24

real2_bb2:                                        ; preds = %real2_bb1, %real2_bb5
  %i.0 = phi i32 [ %"7", %real2_bb5 ], [ 0, %real2_bb1 ]
  %again.1 = phi i32 [ %again.2, %real2_bb5 ], [ 0, %real2_bb1 ]
  %"1" = sub nsw i32 %len, 1, !dbg !26
  %"2" = icmp slt i32 %i.0, %"1", !dbg !26
  br i1 %"2", label %real2_bb3, label %real2_bb1, !dbg !26

real2_bb3:                                        ; preds = %real2_bb2
  %"3" = call i32 (...)* @nondet(), !dbg !30
  %"4" = call i32 (...)* @nondet(), !dbg !33
  %"5" = icmp sgt i32 %"3", %"4", !dbg !33
  br i1 %"5", label %real2_bb4, label %real2_bb5, !dbg !33

real2_bb4:                                        ; preds = %real2_bb3
  %"6" = call i32 (...)* @nondet(), !dbg !34
  br label %real2_bb5, !dbg !36

real2_bb5:                                        ; preds = %real2_bb3, %real2_bb4
  %again.2 = phi i32 [ 1, %real2_bb4 ], [ %again.1, %real2_bb3 ]
  %"7" = add nsw i32 %i.0, 1, !dbg !37
  br label %real2_bb2, !dbg !37

real2_bb6:                                        ; preds = %real2_bb1
  ret void, !dbg !38
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

!0 = metadata !{i32 786449, metadata !1, i32 12, metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)", i1 false, metadata !"", i32 0, metadata !2, metadata !2, metadata !3, metadata !2, metadata !2, metadata !"", i32 1} ; [ DW_TAG_compile_unit ] [/liveness_analysis/real2.c] [DW_LANG_C99]
!1 = metadata !{metadata !"real2.c", metadata !"/liveness_analysis"}
!2 = metadata !{}
!3 = metadata !{metadata !4}
!4 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"real2", metadata !"real2", metadata !"", i32 3, metadata !6, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (i32)* @real2, null, null, metadata !2, i32 4} ; [ DW_TAG_subprogram ] [line 3] [def] [scope 4] [real2]
!5 = metadata !{i32 786473, metadata !1}          ; [ DW_TAG_file_type ] [/liveness_analysis/real2.c]
!6 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !7, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!7 = metadata !{null, metadata !8}
!8 = metadata !{i32 786468, null, null, metadata !"int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!9 = metadata !{i32 2, metadata !"Dwarf Version", i32 4}
!10 = metadata !{i32 2, metadata !"Debug Info Version", i32 1}
!11 = metadata !{metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)"}
!12 = metadata !{i32 786689, metadata !4, metadata !"len", metadata !5, i32 16777219, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [len] [line 3]
!13 = metadata !{i32 3, i32 16, metadata !4, null}
!14 = metadata !{i32 1}
!15 = metadata !{i32 786688, metadata !4, metadata !"again", metadata !5, i32 7, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [again] [line 7]
!16 = metadata !{i32 7, i32 10, metadata !4, null}
!17 = metadata !{i32 0}
!18 = metadata !{i32 786688, metadata !4, metadata !"i", metadata !5, i32 8, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [i] [line 8]
!19 = metadata !{i32 8, i32 10, metadata !4, null} ; [ DW_TAG_imported_declaration ]
!20 = metadata !{i32 786688, metadata !4, metadata !"tmp", metadata !5, i32 6, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [tmp] [line 6]
!21 = metadata !{i32 6, i32 10, metadata !4, null}
!22 = metadata !{i32 10, i32 9, metadata !23, null}
!23 = metadata !{i32 786443, metadata !1, metadata !4, i32 10, i32 4, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/liveness_analysis/real2.c]
!24 = metadata !{i32 10, i32 9, metadata !25, null}
!25 = metadata !{i32 786443, metadata !1, metadata !23, i32 10, i32 9, i32 1, i32 5} ; [ DW_TAG_lexical_block ] [/liveness_analysis/real2.c]
!26 = metadata !{i32 11, i32 11, metadata !27, null}
!27 = metadata !{i32 786443, metadata !1, metadata !28, i32 11, i32 11, i32 2, i32 7} ; [ DW_TAG_lexical_block ] [/liveness_analysis/real2.c]
!28 = metadata !{i32 786443, metadata !1, metadata !29, i32 11, i32 11, i32 1, i32 6} ; [ DW_TAG_lexical_block ] [/liveness_analysis/real2.c]
!29 = metadata !{i32 786443, metadata !1, metadata !23, i32 11, i32 6, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/liveness_analysis/real2.c]
!30 = metadata !{i32 13, i32 14, metadata !31, null}
!31 = metadata !{i32 786443, metadata !1, metadata !32, i32 13, i32 14, i32 0, i32 3} ; [ DW_TAG_lexical_block ] [/liveness_analysis/real2.c]
!32 = metadata !{i32 786443, metadata !1, metadata !29, i32 12, i32 8, i32 0, i32 2} ; [ DW_TAG_lexical_block ] [/liveness_analysis/real2.c]
!33 = metadata !{i32 13, i32 25, metadata !31, null}
!34 = metadata !{i32 15, i32 20, metadata !35, null}
!35 = metadata !{i32 786443, metadata !1, metadata !31, i32 14, i32 12, i32 0, i32 4} ; [ DW_TAG_lexical_block ] [/liveness_analysis/real2.c]
!36 = metadata !{i32 19, i32 12, metadata !35, null}
!37 = metadata !{i32 11, i32 44, metadata !29, null}
!38 = metadata !{i32 21, i32 2, metadata !4, null}

