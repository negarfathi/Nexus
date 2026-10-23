; ModuleID = 't11.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind uwtable
define void @t11(i32 %x, i32 %y, i32 %n, i32 %m) #0 {
t11_bb0:
  call void @llvm.dbg.value(metadata !{i32 %x}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !{i32 %y}, i64 0, metadata !14), !dbg !15
  call void @llvm.dbg.value(metadata !{i32 %n}, i64 0, metadata !16), !dbg !17
  call void @llvm.dbg.value(metadata !{i32 %m}, i64 0, metadata !18), !dbg !19
  call void @llvm.dbg.value(metadata !{i32 %"2"}, i64 0, metadata !14), !dbg !15
  call void @llvm.dbg.value(metadata !{i32 %"3"}, i64 0, metadata !12), !dbg !13
  br label %t11_bb1, !dbg !20

t11_bb1:                                          ; preds = %t11_bb2, %t11_bb0
  %.01 = phi i32 [ %y, %t11_bb0 ], [ %.12, %t11_bb2 ]
  %.0 = phi i32 [ %x, %t11_bb0 ], [ %.1, %t11_bb2 ]
  %"0" = icmp sgt i32 %n, %.0, !dbg !21
  br i1 %"0", label %t11_bb2, label %t11_bb3, !dbg !21

t11_bb2:                                          ; preds = %t11_bb1
  %"1" = icmp sgt i32 %m, %.01, !dbg !23
  %"2" = add nsw i32 %.01, 1, !dbg !26
  %"3" = add nsw i32 %.0, 1, !dbg !27
  %.12 = select i1 %"1", i32 %"2", i32 %.01, !dbg !23
  %.1 = select i1 %"1", i32 %.0, i32 %"3", !dbg !23
  br label %t11_bb1, !dbg !23

t11_bb3:                                          ; preds = %t11_bb1
  ret void, !dbg !28
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

!0 = metadata !{i32 786449, metadata !1, i32 12, metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)", i1 false, metadata !"", i32 0, metadata !2, metadata !2, metadata !3, metadata !2, metadata !2, metadata !"", i32 1} ; [ DW_TAG_compile_unit ] [/liveness_analysis/t11.c] [DW_LANG_C99]
!1 = metadata !{metadata !"t11.c", metadata !"/liveness_analysis"}
!2 = metadata !{}
!3 = metadata !{metadata !4}
!4 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"t11", metadata !"t11", metadata !"", i32 1, metadata !6, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (i32, i32, i32, i32)* @t11, null, null, metadata !2, i32 2} ; [ DW_TAG_subprogram ] [line 1] [def] [scope 2] [t11]
!5 = metadata !{i32 786473, metadata !1}          ; [ DW_TAG_file_type ] [/liveness_analysis/t11.c]
!6 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !7, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!7 = metadata !{null, metadata !8, metadata !8, metadata !8, metadata !8}
!8 = metadata !{i32 786468, null, null, metadata !"int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!9 = metadata !{i32 2, metadata !"Dwarf Version", i32 4}
!10 = metadata !{i32 2, metadata !"Debug Info Version", i32 1}
!11 = metadata !{metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)"}
!12 = metadata !{i32 786689, metadata !4, metadata !"x", metadata !5, i32 16777217, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [x] [line 1]
!13 = metadata !{i32 1, i32 14, metadata !4, null}
!14 = metadata !{i32 786689, metadata !4, metadata !"y", metadata !5, i32 33554433, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [y] [line 1]
!15 = metadata !{i32 1, i32 21, metadata !4, null}
!16 = metadata !{i32 786689, metadata !4, metadata !"n", metadata !5, i32 50331649, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [n] [line 1]
!17 = metadata !{i32 1, i32 28, metadata !4, null}
!18 = metadata !{i32 786689, metadata !4, metadata !"m", metadata !5, i32 67108865, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [m] [line 1]
!19 = metadata !{i32 1, i32 35, metadata !4, null}
!20 = metadata !{i32 3, i32 3, metadata !4, null}
!21 = metadata !{i32 3, i32 3, metadata !22, null}
!22 = metadata !{i32 786443, metadata !1, metadata !4, i32 3, i32 3, i32 1, i32 2} ; [ DW_TAG_lexical_block ] [/liveness_analysis/t11.c]
!23 = metadata !{i32 4, i32 9, metadata !24, null}
!24 = metadata !{i32 786443, metadata !1, metadata !25, i32 4, i32 9, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/liveness_analysis/t11.c]
!25 = metadata !{i32 786443, metadata !1, metadata !4, i32 3, i32 15, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/liveness_analysis/t11.c]
!26 = metadata !{i32 5, i32 7, metadata !24, null}
!27 = metadata !{i32 7, i32 7, metadata !24, null}
!28 = metadata !{i32 9, i32 1, metadata !4, null}

