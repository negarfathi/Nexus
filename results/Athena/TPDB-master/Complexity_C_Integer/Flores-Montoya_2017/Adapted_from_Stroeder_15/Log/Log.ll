; ModuleID = 'Log.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind uwtable
define i32 @foo(i32 %x, i32 %xtmp, i32 %res, i32 %restmp) #0 {
foo_bb0:
  call void @llvm.dbg.value(metadata !{i32 %x}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !{i32 %xtmp}, i64 0, metadata !14), !dbg !15
  call void @llvm.dbg.value(metadata !{i32 %res}, i64 0, metadata !16), !dbg !17
  call void @llvm.dbg.value(metadata !{i32 %restmp}, i64 0, metadata !18), !dbg !19
  call void @llvm.dbg.value(metadata !20, i64 0, metadata !16), !dbg !17
  call void @llvm.dbg.value(metadata !{i32 %.0}, i64 0, metadata !14), !dbg !15
  call void @llvm.dbg.value(metadata !20, i64 0, metadata !18), !dbg !19
  call void @llvm.dbg.value(metadata !{i32 %"2"}, i64 0, metadata !14), !dbg !15
  call void @llvm.dbg.value(metadata !{i32 %"3"}, i64 0, metadata !18), !dbg !19
  br label %foo_bb1, !dbg !21

foo_bb1:                                          ; preds = %foo_bb4, %foo_bb0
  %.02 = phi i32 [ 0, %foo_bb0 ], [ %"4", %foo_bb4 ]
  %.0 = phi i32 [ %x, %foo_bb0 ], [ %.01, %foo_bb4 ]
  %"0" = icmp sgt i32 %.0, 1, !dbg !22
  br i1 %"0", label %foo_bb2, label %foo_bb5, !dbg !22

foo_bb2:                                          ; preds = %foo_bb1, %foo_bb3
  %.03 = phi i32 [ %"3", %foo_bb3 ], [ 0, %foo_bb1 ]
  %.01 = phi i32 [ %"2", %foo_bb3 ], [ %.0, %foo_bb1 ]
  %"1" = icmp sgt i32 %.01, 1, !dbg !24
  br i1 %"1", label %foo_bb3, label %foo_bb4, !dbg !24

foo_bb3:                                          ; preds = %foo_bb2
  %"2" = sub nsw i32 %.01, 2, !dbg !27
  %"3" = add nsw i32 %.03, 1, !dbg !29
  br label %foo_bb2, !dbg !30

foo_bb4:                                          ; preds = %foo_bb2
  call void @llvm.dbg.value(metadata !{i32 %.01}, i64 0, metadata !12), !dbg !13
  %"4" = add nsw i32 %.02, 1, !dbg !31
  call void @llvm.dbg.value(metadata !{i32 %"4"}, i64 0, metadata !16), !dbg !17
  br label %foo_bb1, !dbg !32

foo_bb5:                                          ; preds = %foo_bb1
  ret i32 0, !dbg !33
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

!0 = metadata !{i32 786449, metadata !1, i32 12, metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)", i1 false, metadata !"", i32 0, metadata !2, metadata !2, metadata !3, metadata !2, metadata !2, metadata !"", i32 1} ; [ DW_TAG_compile_unit ] [/liveness_analysis/Log.c] [DW_LANG_C99]
!1 = metadata !{metadata !"Log.c", metadata !"/liveness_analysis"}
!2 = metadata !{}
!3 = metadata !{metadata !4}
!4 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"foo", metadata !"foo", metadata !"", i32 3, metadata !6, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, i32 (i32, i32, i32, i32)* @foo, null, null, metadata !2, i32 3} ; [ DW_TAG_subprogram ] [line 3] [def] [foo]
!5 = metadata !{i32 786473, metadata !1}          ; [ DW_TAG_file_type ] [/liveness_analysis/Log.c]
!6 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !7, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!7 = metadata !{metadata !8, metadata !8, metadata !8, metadata !8, metadata !8}
!8 = metadata !{i32 786468, null, null, metadata !"int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!9 = metadata !{i32 2, metadata !"Dwarf Version", i32 4}
!10 = metadata !{i32 2, metadata !"Debug Info Version", i32 1}
!11 = metadata !{metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)"}
!12 = metadata !{i32 786689, metadata !4, metadata !"x", metadata !5, i32 16777219, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [x] [line 3]
!13 = metadata !{i32 3, i32 13, metadata !4, null}
!14 = metadata !{i32 786689, metadata !4, metadata !"xtmp", metadata !5, i32 33554435, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [xtmp] [line 3]
!15 = metadata !{i32 3, i32 19, metadata !4, null}
!16 = metadata !{i32 786689, metadata !4, metadata !"res", metadata !5, i32 50331651, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [res] [line 3]
!17 = metadata !{i32 3, i32 28, metadata !4, null}
!18 = metadata !{i32 786689, metadata !4, metadata !"restmp", metadata !5, i32 67108867, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [restmp] [line 3]
!19 = metadata !{i32 3, i32 36, metadata !4, null}
!20 = metadata !{i32 0}
!21 = metadata !{i32 5, i32 1, metadata !4, null}
!22 = metadata !{i32 5, i32 1, metadata !23, null}
!23 = metadata !{i32 786443, metadata !1, metadata !4, i32 5, i32 1, i32 1, i32 2} ; [ DW_TAG_lexical_block ] [/liveness_analysis/Log.c]
!24 = metadata !{i32 9, i32 9, metadata !25, null}
!25 = metadata !{i32 786443, metadata !1, metadata !26, i32 9, i32 9, i32 1, i32 3} ; [ DW_TAG_lexical_block ] [/liveness_analysis/Log.c]
!26 = metadata !{i32 786443, metadata !1, metadata !4, i32 5, i32 15, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/liveness_analysis/Log.c]
!27 = metadata !{i32 10, i32 13, metadata !28, null}
!28 = metadata !{i32 786443, metadata !1, metadata !26, i32 9, i32 26, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/liveness_analysis/Log.c]
!29 = metadata !{i32 11, i32 13, metadata !28, null}
!30 = metadata !{i32 12, i32 9, metadata !28, null}
!31 = metadata !{i32 15, i32 9, metadata !26, null}
!32 = metadata !{i32 17, i32 5, metadata !26, null}
!33 = metadata !{i32 18, i32 1, metadata !4, null}

