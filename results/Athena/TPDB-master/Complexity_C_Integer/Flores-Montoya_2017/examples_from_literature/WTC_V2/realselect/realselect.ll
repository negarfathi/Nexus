; ModuleID = 'realselect.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind uwtable
define void @realselect(i32 %array_size) #0 {
realselect_bb0:
  call void @llvm.dbg.value(metadata !{i32 %array_size}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !14, i64 0, metadata !15), !dbg !16
  call void @llvm.dbg.value(metadata !{i32 %i.0}, i64 0, metadata !17), !dbg !18
  call void @llvm.dbg.value(metadata !{i32 %"2"}, i64 0, metadata !19), !dbg !20
  call void @llvm.dbg.value(metadata !{i32 %"2"}, i64 0, metadata !17), !dbg !18
  br label %realselect_bb1, !dbg !21

realselect_bb1:                                   ; preds = %realselect_bb4, %realselect_bb0
  %i.0 = phi i32 [ 0, %realselect_bb0 ], [ %"6", %realselect_bb4 ]
  %"0" = sub nsw i32 %array_size, 1, !dbg !23
  %"1" = icmp slt i32 %i.0, %"0", !dbg !23
  br i1 %"1", label %realselect_bb2, label %realselect_bb5, !dbg !23

realselect_bb2:                                   ; preds = %realselect_bb1, %realselect_bb3
  %i.0.sink = phi i32 [ %"2", %realselect_bb3 ], [ %i.0, %realselect_bb1 ]
  %"2" = add nsw i32 %i.0.sink, 1, !dbg !26
  %"3" = icmp slt i32 %"2", %array_size, !dbg !29
  br i1 %"3", label %realselect_bb3, label %realselect_bb4, !dbg !29

realselect_bb3:                                   ; preds = %realselect_bb2
  %"4" = call i32 (...)* @nondet(), !dbg !32
  %"5" = call i32 (...)* @nondet(), !dbg !35
  br label %realselect_bb2, !dbg !36

realselect_bb4:                                   ; preds = %realselect_bb2
  %"6" = add nsw i32 %i.0, 1, !dbg !37
  call void @llvm.dbg.value(metadata !{i32 %"6"}, i64 0, metadata !15), !dbg !16
  br label %realselect_bb1, !dbg !37

realselect_bb5:                                   ; preds = %realselect_bb1
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

!0 = metadata !{i32 786449, metadata !1, i32 12, metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)", i1 false, metadata !"", i32 0, metadata !2, metadata !2, metadata !3, metadata !2, metadata !2, metadata !"", i32 1} ; [ DW_TAG_compile_unit ] [/liveness_analysis/realselect.c] [DW_LANG_C99]
!1 = metadata !{metadata !"realselect.c", metadata !"/liveness_analysis"}
!2 = metadata !{}
!3 = metadata !{metadata !4}
!4 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"realselect", metadata !"realselect", metadata !"", i32 4, metadata !6, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (i32)* @realselect, null, null, metadata !2, i32 5} ; [ DW_TAG_subprogram ] [line 4] [def] [scope 5] [realselect]
!5 = metadata !{i32 786473, metadata !1}          ; [ DW_TAG_file_type ] [/liveness_analysis/realselect.c]
!6 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !7, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!7 = metadata !{null, metadata !8}
!8 = metadata !{i32 786468, null, null, metadata !"int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!9 = metadata !{i32 2, metadata !"Dwarf Version", i32 4}
!10 = metadata !{i32 2, metadata !"Debug Info Version", i32 1}
!11 = metadata !{metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)"}
!12 = metadata !{i32 786689, metadata !4, metadata !"array_size", metadata !5, i32 16777220, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [array_size] [line 4]
!13 = metadata !{i32 4, i32 21, metadata !4, null}
!14 = metadata !{i32 0}
!15 = metadata !{i32 786688, metadata !4, metadata !"i", metadata !5, i32 6, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [i] [line 6]
!16 = metadata !{i32 6, i32 7, metadata !4, null}
!17 = metadata !{i32 786688, metadata !4, metadata !"min", metadata !5, i32 7, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [min] [line 7]
!18 = metadata !{i32 7, i32 7, metadata !4, null}
!19 = metadata !{i32 786688, metadata !4, metadata !"j", metadata !5, i32 6, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [j] [line 6]
!20 = metadata !{i32 6, i32 10, metadata !4, null}
!21 = metadata !{i32 9, i32 8, metadata !22, null}
!22 = metadata !{i32 786443, metadata !1, metadata !4, i32 9, i32 3, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/liveness_analysis/realselect.c]
!23 = metadata !{i32 9, i32 8, metadata !24, null}
!24 = metadata !{i32 786443, metadata !1, metadata !25, i32 9, i32 8, i32 2, i32 8} ; [ DW_TAG_lexical_block ] [/liveness_analysis/realselect.c]
!25 = metadata !{i32 786443, metadata !1, metadata !22, i32 9, i32 8, i32 1, i32 5} ; [ DW_TAG_lexical_block ] [/liveness_analysis/realselect.c]
!26 = metadata !{i32 12, i32 10, metadata !27, null}
!27 = metadata !{i32 786443, metadata !1, metadata !28, i32 12, i32 5, i32 0, i32 2} ; [ DW_TAG_lexical_block ] [/liveness_analysis/realselect.c]
!28 = metadata !{i32 786443, metadata !1, metadata !22, i32 10, i32 3, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/liveness_analysis/realselect.c]
!29 = metadata !{i32 12, i32 10, metadata !30, null}
!30 = metadata !{i32 786443, metadata !1, metadata !31, i32 12, i32 10, i32 2, i32 7} ; [ DW_TAG_lexical_block ] [/liveness_analysis/realselect.c]
!31 = metadata !{i32 786443, metadata !1, metadata !27, i32 12, i32 10, i32 1, i32 6} ; [ DW_TAG_lexical_block ] [/liveness_analysis/realselect.c]
!32 = metadata !{i32 14, i32 11, metadata !33, null}
!33 = metadata !{i32 786443, metadata !1, metadata !34, i32 14, i32 11, i32 0, i32 4} ; [ DW_TAG_lexical_block ] [/liveness_analysis/realselect.c]
!34 = metadata !{i32 786443, metadata !1, metadata !27, i32 13, i32 5, i32 0, i32 3} ; [ DW_TAG_lexical_block ] [/liveness_analysis/realselect.c]
!35 = metadata !{i32 14, i32 22, metadata !33, null}
!36 = metadata !{i32 12, i32 35, metadata !27, null}
!37 = metadata !{i32 9, i32 33, metadata !22, null}
!38 = metadata !{i32 22, i32 1, metadata !4, null}

