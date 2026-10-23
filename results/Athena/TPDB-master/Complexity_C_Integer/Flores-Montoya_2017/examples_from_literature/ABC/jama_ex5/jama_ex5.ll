; ModuleID = 'jama_ex5.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind uwtable
define void @jama_ex5(i32 %n) #0 {
jama_ex5_bb0:
  call void @llvm.dbg.value(metadata !{i32 %n}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !14, i64 0, metadata !15), !dbg !16
  call void @llvm.dbg.value(metadata !14, i64 0, metadata !17), !dbg !18
  call void @llvm.dbg.value(metadata !{i32 %"2"}, i64 0, metadata !17), !dbg !18
  br label %jama_ex5_bb1, !dbg !19

jama_ex5_bb1:                                     ; preds = %jama_ex5_bb4, %jama_ex5_bb0
  %i.0 = phi i32 [ 0, %jama_ex5_bb0 ], [ %"3", %jama_ex5_bb4 ]
  %"0" = icmp sle i32 %i.0, %n, !dbg !21
  br i1 %"0", label %jama_ex5_bb2, label %jama_ex5_bb5, !dbg !21

jama_ex5_bb2:                                     ; preds = %jama_ex5_bb1, %jama_ex5_bb3
  %j.0 = phi i32 [ %"2", %jama_ex5_bb3 ], [ 0, %jama_ex5_bb1 ]
  %"1" = icmp sle i32 %j.0, %n, !dbg !24
  br i1 %"1", label %jama_ex5_bb3, label %jama_ex5_bb4, !dbg !24

jama_ex5_bb3:                                     ; preds = %jama_ex5_bb2
  %"2" = add nsw i32 %j.0, 2, !dbg !28
  br label %jama_ex5_bb2, !dbg !28

jama_ex5_bb4:                                     ; preds = %jama_ex5_bb2
  %"3" = add nsw i32 %i.0, 2, !dbg !30
  call void @llvm.dbg.value(metadata !{i32 %"3"}, i64 0, metadata !15), !dbg !16
  br label %jama_ex5_bb1, !dbg !30

jama_ex5_bb5:                                     ; preds = %jama_ex5_bb1
  ret void, !dbg !31
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

!0 = metadata !{i32 786449, metadata !1, i32 12, metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)", i1 false, metadata !"", i32 0, metadata !2, metadata !2, metadata !3, metadata !2, metadata !2, metadata !"", i32 1} ; [ DW_TAG_compile_unit ] [/liveness_analysis/jama_ex5.c] [DW_LANG_C99]
!1 = metadata !{metadata !"jama_ex5.c", metadata !"/liveness_analysis"}
!2 = metadata !{}
!3 = metadata !{metadata !4}
!4 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"jama_ex5", metadata !"jama_ex5", metadata !"", i32 1, metadata !6, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (i32)* @jama_ex5, null, null, metadata !2, i32 1} ; [ DW_TAG_subprogram ] [line 1] [def] [jama_ex5]
!5 = metadata !{i32 786473, metadata !1}          ; [ DW_TAG_file_type ] [/liveness_analysis/jama_ex5.c]
!6 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !7, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!7 = metadata !{null, metadata !8}
!8 = metadata !{i32 786468, null, null, metadata !"int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!9 = metadata !{i32 2, metadata !"Dwarf Version", i32 4}
!10 = metadata !{i32 2, metadata !"Debug Info Version", i32 1}
!11 = metadata !{metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)"}
!12 = metadata !{i32 786689, metadata !4, metadata !"n", metadata !5, i32 16777217, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [n] [line 1]
!13 = metadata !{i32 1, i32 19, metadata !4, null}
!14 = metadata !{i32 0}
!15 = metadata !{i32 786688, metadata !4, metadata !"i", metadata !5, i32 2, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [i] [line 2]
!16 = metadata !{i32 2, i32 5, metadata !4, null}
!17 = metadata !{i32 786688, metadata !4, metadata !"j", metadata !5, i32 2, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [j] [line 2]
!18 = metadata !{i32 2, i32 7, metadata !4, null}
!19 = metadata !{i32 3, i32 5, metadata !20, null}
!20 = metadata !{i32 786443, metadata !1, metadata !4, i32 3, i32 1, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/liveness_analysis/jama_ex5.c]
!21 = metadata !{i32 3, i32 5, metadata !22, null}
!22 = metadata !{i32 786443, metadata !1, metadata !23, i32 3, i32 5, i32 2, i32 7} ; [ DW_TAG_lexical_block ] [/liveness_analysis/jama_ex5.c]
!23 = metadata !{i32 786443, metadata !1, metadata !20, i32 3, i32 5, i32 1, i32 2} ; [ DW_TAG_lexical_block ] [/liveness_analysis/jama_ex5.c]
!24 = metadata !{i32 4, i32 7, metadata !25, null}
!25 = metadata !{i32 786443, metadata !1, metadata !26, i32 4, i32 7, i32 4, i32 6} ; [ DW_TAG_lexical_block ] [/liveness_analysis/jama_ex5.c]
!26 = metadata !{i32 786443, metadata !1, metadata !27, i32 4, i32 7, i32 1, i32 3} ; [ DW_TAG_lexical_block ] [/liveness_analysis/jama_ex5.c]
!27 = metadata !{i32 786443, metadata !1, metadata !20, i32 4, i32 3, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/liveness_analysis/jama_ex5.c]
!28 = metadata !{i32 4, i32 16, metadata !29, null}
!29 = metadata !{i32 786443, metadata !1, metadata !27, i32 4, i32 16, i32 3, i32 5} ; [ DW_TAG_lexical_block ] [/liveness_analysis/jama_ex5.c]
!30 = metadata !{i32 3, i32 14, metadata !20, null}
!31 = metadata !{i32 6, i32 1, metadata !4, null}

