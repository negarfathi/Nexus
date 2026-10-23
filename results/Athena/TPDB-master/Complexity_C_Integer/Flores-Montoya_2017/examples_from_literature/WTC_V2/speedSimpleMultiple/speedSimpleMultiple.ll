; ModuleID = 'speedSimpleMultiple.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind uwtable
define i32 @speedSimpleMultiple(i32 %n, i32 %m) #0 {
speedSimpleMultiple_bb0:
  call void @llvm.dbg.value(metadata !{i32 %n}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !{i32 %m}, i64 0, metadata !14), !dbg !15
  call void @llvm.dbg.value(metadata !16, i64 0, metadata !17), !dbg !18
  call void @llvm.dbg.value(metadata !16, i64 0, metadata !19), !dbg !20
  call void @llvm.dbg.value(metadata !{i32 %"2"}, i64 0, metadata !19), !dbg !20
  call void @llvm.dbg.value(metadata !{i32 %"3"}, i64 0, metadata !17), !dbg !18
  br label %speedSimpleMultiple_bb1, !dbg !21

speedSimpleMultiple_bb1:                          ; preds = %speedSimpleMultiple_bb2, %speedSimpleMultiple_bb0
  %y.0 = phi i32 [ 0, %speedSimpleMultiple_bb0 ], [ %y.1, %speedSimpleMultiple_bb2 ]
  %x.0 = phi i32 [ 0, %speedSimpleMultiple_bb0 ], [ %x.1, %speedSimpleMultiple_bb2 ]
  %"0" = icmp slt i32 %x.0, %n, !dbg !22
  br i1 %"0", label %speedSimpleMultiple_bb2, label %speedSimpleMultiple_bb3, !dbg !22

speedSimpleMultiple_bb2:                          ; preds = %speedSimpleMultiple_bb1
  %"1" = icmp slt i32 %y.0, %m, !dbg !24
  %"2" = add nsw i32 %y.0, 1, !dbg !27
  %"3" = add nsw i32 %x.0, 1, !dbg !29
  %y.1 = select i1 %"1", i32 %"2", i32 %y.0, !dbg !24
  %x.1 = select i1 %"1", i32 %x.0, i32 %"3", !dbg !24
  br label %speedSimpleMultiple_bb1, !dbg !24

speedSimpleMultiple_bb3:                          ; preds = %speedSimpleMultiple_bb1
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

!0 = metadata !{i32 786449, metadata !1, i32 12, metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)", i1 false, metadata !"", i32 0, metadata !2, metadata !2, metadata !3, metadata !2, metadata !2, metadata !"", i32 1} ; [ DW_TAG_compile_unit ] [/liveness_analysis/speedSimpleMultiple.c] [DW_LANG_C99]
!1 = metadata !{metadata !"speedSimpleMultiple.c", metadata !"/liveness_analysis"}
!2 = metadata !{}
!3 = metadata !{metadata !4}
!4 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"speedSimpleMultiple", metadata !"speedSimpleMultiple", metadata !"", i32 3, metadata !6, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, i32 (i32, i32)* @speedSimpleMultiple, null, null, metadata !2, i32 4} ; [ DW_TAG_subprogram ] [line 3] [def] [scope 4] [speedSimpleMultiple]
!5 = metadata !{i32 786473, metadata !1}          ; [ DW_TAG_file_type ] [/liveness_analysis/speedSimpleMultiple.c]
!6 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !7, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!7 = metadata !{metadata !8, metadata !8, metadata !8}
!8 = metadata !{i32 786468, null, null, metadata !"int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!9 = metadata !{i32 2, metadata !"Dwarf Version", i32 4}
!10 = metadata !{i32 2, metadata !"Debug Info Version", i32 1}
!11 = metadata !{metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)"}
!12 = metadata !{i32 786689, metadata !4, metadata !"n", metadata !5, i32 16777219, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [n] [line 3]
!13 = metadata !{i32 3, i32 29, metadata !4, null}
!14 = metadata !{i32 786689, metadata !4, metadata !"m", metadata !5, i32 33554435, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [m] [line 3]
!15 = metadata !{i32 3, i32 35, metadata !4, null}
!16 = metadata !{i32 0}
!17 = metadata !{i32 786688, metadata !4, metadata !"x", metadata !5, i32 5, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [x] [line 5]
!18 = metadata !{i32 5, i32 7, metadata !4, null}
!19 = metadata !{i32 786688, metadata !4, metadata !"y", metadata !5, i32 5, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [y] [line 5]
!20 = metadata !{i32 5, i32 9, metadata !4, null}
!21 = metadata !{i32 7, i32 3, metadata !4, null}
!22 = metadata !{i32 7, i32 3, metadata !23, null}
!23 = metadata !{i32 786443, metadata !1, metadata !4, i32 7, i32 3, i32 1, i32 2} ; [ DW_TAG_lexical_block ] [/liveness_analysis/speedSimpleMultiple.c]
!24 = metadata !{i32 9, i32 11, metadata !25, null}
!25 = metadata !{i32 786443, metadata !1, metadata !26, i32 9, i32 11, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/liveness_analysis/speedSimpleMultiple.c]
!26 = metadata !{i32 786443, metadata !1, metadata !4, i32 8, i32 5, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/liveness_analysis/speedSimpleMultiple.c]
!27 = metadata !{i32 9, i32 16, metadata !28, null}
!28 = metadata !{i32 786443, metadata !1, metadata !25, i32 9, i32 16, i32 1, i32 3} ; [ DW_TAG_lexical_block ] [/liveness_analysis/speedSimpleMultiple.c]
!29 = metadata !{i32 9, i32 27, metadata !30, null}
!30 = metadata !{i32 786443, metadata !1, metadata !25, i32 9, i32 27, i32 2, i32 4} ; [ DW_TAG_lexical_block ] [/liveness_analysis/speedSimpleMultiple.c]
!31 = metadata !{i32 11, i32 3, metadata !4, null}

