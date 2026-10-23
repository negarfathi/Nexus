; ModuleID = 'jama_ex6.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind uwtable
define void @jama_ex6(i32 %a, i32 %b, i32 %c, i32 %d) #0 {
jama_ex6_bb0:
  call void @llvm.dbg.value(metadata !{i32 %a}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !{i32 %b}, i64 0, metadata !14), !dbg !15
  call void @llvm.dbg.value(metadata !{i32 %c}, i64 0, metadata !16), !dbg !17
  call void @llvm.dbg.value(metadata !{i32 %d}, i64 0, metadata !18), !dbg !19
  call void @llvm.dbg.value(metadata !{i32 %a}, i64 0, metadata !20), !dbg !21
  call void @llvm.dbg.value(metadata !{i32 %c}, i64 0, metadata !22), !dbg !23
  call void @llvm.dbg.value(metadata !{i32 %"2"}, i64 0, metadata !24), !dbg !25
  call void @llvm.dbg.value(metadata !{i32 %"5"}, i64 0, metadata !24), !dbg !25
  br label %jama_ex6_bb1, !dbg !26

jama_ex6_bb1:                                     ; preds = %jama_ex6_bb7, %jama_ex6_bb0
  %i.0 = phi i32 [ %a, %jama_ex6_bb0 ], [ %"7", %jama_ex6_bb7 ]
  %"0" = icmp sle i32 %i.0, %b, !dbg !28
  br i1 %"0", label %jama_ex6_bb2, label %jama_ex6_bb8, !dbg !28

jama_ex6_bb2:                                     ; preds = %jama_ex6_bb1, %jama_ex6_bb6
  %j.0 = phi i32 [ %"6", %jama_ex6_bb6 ], [ %c, %jama_ex6_bb1 ]
  %"1" = icmp sle i32 %j.0, %d, !dbg !31
  br i1 %"1", label %jama_ex6_bb3, label %jama_ex6_bb7, !dbg !31

jama_ex6_bb3:                                     ; preds = %jama_ex6_bb2
  %"2" = sub nsw i32 %i.0, %j.0, !dbg !35
  br label %jama_ex6_bb4, !dbg !35

jama_ex6_bb4:                                     ; preds = %jama_ex6_bb5, %jama_ex6_bb3
  %k.0 = phi i32 [ %"2", %jama_ex6_bb3 ], [ %"5", %jama_ex6_bb5 ]
  %"3" = add nsw i32 %i.0, %j.0, !dbg !37
  %"4" = icmp sle i32 %k.0, %"3", !dbg !37
  br i1 %"4", label %jama_ex6_bb5, label %jama_ex6_bb6, !dbg !37

jama_ex6_bb5:                                     ; preds = %jama_ex6_bb4
  %"5" = add nsw i32 %k.0, 1, !dbg !40
  br label %jama_ex6_bb4, !dbg !40

jama_ex6_bb6:                                     ; preds = %jama_ex6_bb4
  %"6" = add nsw i32 %j.0, 1, !dbg !42
  call void @llvm.dbg.value(metadata !{i32 %"6"}, i64 0, metadata !22), !dbg !23
  br label %jama_ex6_bb2, !dbg !42

jama_ex6_bb7:                                     ; preds = %jama_ex6_bb2
  %"7" = add nsw i32 %i.0, 1, !dbg !43
  call void @llvm.dbg.value(metadata !{i32 %"7"}, i64 0, metadata !20), !dbg !21
  br label %jama_ex6_bb1, !dbg !43

jama_ex6_bb8:                                     ; preds = %jama_ex6_bb1
  ret void, !dbg !44
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

!0 = metadata !{i32 786449, metadata !1, i32 12, metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)", i1 false, metadata !"", i32 0, metadata !2, metadata !2, metadata !3, metadata !2, metadata !2, metadata !"", i32 1} ; [ DW_TAG_compile_unit ] [/liveness_analysis/jama_ex6.c] [DW_LANG_C99]
!1 = metadata !{metadata !"jama_ex6.c", metadata !"/liveness_analysis"}
!2 = metadata !{}
!3 = metadata !{metadata !4}
!4 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"jama_ex6", metadata !"jama_ex6", metadata !"", i32 1, metadata !6, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (i32, i32, i32, i32)* @jama_ex6, null, null, metadata !2, i32 1} ; [ DW_TAG_subprogram ] [line 1] [def] [jama_ex6]
!5 = metadata !{i32 786473, metadata !1}          ; [ DW_TAG_file_type ] [/liveness_analysis/jama_ex6.c]
!6 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !7, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!7 = metadata !{null, metadata !8, metadata !8, metadata !8, metadata !8}
!8 = metadata !{i32 786468, null, null, metadata !"int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!9 = metadata !{i32 2, metadata !"Dwarf Version", i32 4}
!10 = metadata !{i32 2, metadata !"Debug Info Version", i32 1}
!11 = metadata !{metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)"}
!12 = metadata !{i32 786689, metadata !4, metadata !"a", metadata !5, i32 16777217, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [a] [line 1]
!13 = metadata !{i32 1, i32 19, metadata !4, null}
!14 = metadata !{i32 786689, metadata !4, metadata !"b", metadata !5, i32 33554433, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [b] [line 1]
!15 = metadata !{i32 1, i32 25, metadata !4, null}
!16 = metadata !{i32 786689, metadata !4, metadata !"c", metadata !5, i32 50331649, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [c] [line 1]
!17 = metadata !{i32 1, i32 31, metadata !4, null}
!18 = metadata !{i32 786689, metadata !4, metadata !"d", metadata !5, i32 67108865, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [d] [line 1]
!19 = metadata !{i32 1, i32 38, metadata !4, null}
!20 = metadata !{i32 786688, metadata !4, metadata !"i", metadata !5, i32 2, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [i] [line 2]
!21 = metadata !{i32 2, i32 5, metadata !4, null}
!22 = metadata !{i32 786688, metadata !4, metadata !"j", metadata !5, i32 2, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [j] [line 2]
!23 = metadata !{i32 2, i32 7, metadata !4, null}
!24 = metadata !{i32 786688, metadata !4, metadata !"k", metadata !5, i32 2, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [k] [line 2]
!25 = metadata !{i32 2, i32 9, metadata !4, null}
!26 = metadata !{i32 3, i32 6, metadata !27, null}
!27 = metadata !{i32 786443, metadata !1, metadata !4, i32 3, i32 1, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/liveness_analysis/jama_ex6.c]
!28 = metadata !{i32 3, i32 6, metadata !29, null}
!29 = metadata !{i32 786443, metadata !1, metadata !30, i32 3, i32 6, i32 2, i32 10} ; [ DW_TAG_lexical_block ] [/liveness_analysis/jama_ex6.c]
!30 = metadata !{i32 786443, metadata !1, metadata !27, i32 3, i32 6, i32 1, i32 3} ; [ DW_TAG_lexical_block ] [/liveness_analysis/jama_ex6.c]
!31 = metadata !{i32 4, i32 8, metadata !32, null}
!32 = metadata !{i32 786443, metadata !1, metadata !33, i32 4, i32 8, i32 2, i32 9} ; [ DW_TAG_lexical_block ] [/liveness_analysis/jama_ex6.c]
!33 = metadata !{i32 786443, metadata !1, metadata !34, i32 4, i32 8, i32 1, i32 4} ; [ DW_TAG_lexical_block ] [/liveness_analysis/jama_ex6.c]
!34 = metadata !{i32 786443, metadata !1, metadata !27, i32 4, i32 3, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/liveness_analysis/jama_ex6.c]
!35 = metadata !{i32 5, i32 9, metadata !36, null}
!36 = metadata !{i32 786443, metadata !1, metadata !34, i32 5, i32 5, i32 0, i32 2} ; [ DW_TAG_lexical_block ] [/liveness_analysis/jama_ex6.c]
!37 = metadata !{i32 5, i32 9, metadata !38, null}
!38 = metadata !{i32 786443, metadata !1, metadata !39, i32 5, i32 9, i32 4, i32 8} ; [ DW_TAG_lexical_block ] [/liveness_analysis/jama_ex6.c]
!39 = metadata !{i32 786443, metadata !1, metadata !36, i32 5, i32 9, i32 1, i32 5} ; [ DW_TAG_lexical_block ] [/liveness_analysis/jama_ex6.c]
!40 = metadata !{i32 5, i32 22, metadata !41, null}
!41 = metadata !{i32 786443, metadata !1, metadata !36, i32 5, i32 22, i32 3, i32 7} ; [ DW_TAG_lexical_block ] [/liveness_analysis/jama_ex6.c]
!42 = metadata !{i32 4, i32 17, metadata !34, null}
!43 = metadata !{i32 3, i32 15, metadata !27, null}
!44 = metadata !{i32 7, i32 1, metadata !4, null}

