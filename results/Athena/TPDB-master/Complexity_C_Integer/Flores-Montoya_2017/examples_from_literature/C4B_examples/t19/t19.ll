; ModuleID = 't19.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind uwtable
define void @t19(i32 %i, i32 %k) #0 {
t19_bb0:
  call void @llvm.dbg.value(metadata !{i32 %i}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !{i32 %k}, i64 0, metadata !14), !dbg !15
  call void @llvm.dbg.value(metadata !{i32 %"1"}, i64 0, metadata !12), !dbg !13
  br label %t19_bb1, !dbg !16

t19_bb1:                                          ; preds = %t19_bb2, %t19_bb0
  %.0 = phi i32 [ %i, %t19_bb0 ], [ %"1", %t19_bb2 ]
  %"0" = icmp sgt i32 %.0, 100, !dbg !17
  br i1 %"0", label %t19_bb2, label %t19_bb3, !dbg !17

t19_bb2:                                          ; preds = %t19_bb1
  %"1" = add nsw i32 %.0, -1, !dbg !19
  br label %t19_bb1, !dbg !19

t19_bb3:                                          ; preds = %t19_bb1
  %"2" = add nsw i32 %.0, %k, !dbg !20
  %"3" = add nsw i32 %"2", 50, !dbg !20
  call void @llvm.dbg.value(metadata !{i32 %"3"}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !{i32 %"5"}, i64 0, metadata !12), !dbg !13
  br label %t19_bb4, !dbg !21

t19_bb4:                                          ; preds = %t19_bb5, %t19_bb3
  %.1 = phi i32 [ %"3", %t19_bb3 ], [ %"5", %t19_bb5 ]
  %"4" = icmp sge i32 %.1, 0, !dbg !22
  br i1 %"4", label %t19_bb5, label %t19_bb6, !dbg !22

t19_bb5:                                          ; preds = %t19_bb4
  %"5" = add nsw i32 %.1, -1, !dbg !24
  br label %t19_bb4, !dbg !24

t19_bb6:                                          ; preds = %t19_bb4
  ret void, !dbg !25
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

!0 = metadata !{i32 786449, metadata !1, i32 12, metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)", i1 false, metadata !"", i32 0, metadata !2, metadata !2, metadata !3, metadata !2, metadata !2, metadata !"", i32 1} ; [ DW_TAG_compile_unit ] [/liveness_analysis/t19.c] [DW_LANG_C99]
!1 = metadata !{metadata !"t19.c", metadata !"/liveness_analysis"}
!2 = metadata !{}
!3 = metadata !{metadata !4}
!4 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"t19", metadata !"t19", metadata !"", i32 1, metadata !6, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (i32, i32)* @t19, null, null, metadata !2, i32 2} ; [ DW_TAG_subprogram ] [line 1] [def] [scope 2] [t19]
!5 = metadata !{i32 786473, metadata !1}          ; [ DW_TAG_file_type ] [/liveness_analysis/t19.c]
!6 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !7, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!7 = metadata !{null, metadata !8, metadata !8}
!8 = metadata !{i32 786468, null, null, metadata !"int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!9 = metadata !{i32 2, metadata !"Dwarf Version", i32 4}
!10 = metadata !{i32 2, metadata !"Debug Info Version", i32 1}
!11 = metadata !{metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)"}
!12 = metadata !{i32 786689, metadata !4, metadata !"i", metadata !5, i32 16777217, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [i] [line 1]
!13 = metadata !{i32 1, i32 14, metadata !4, null}
!14 = metadata !{i32 786689, metadata !4, metadata !"k", metadata !5, i32 33554433, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [k] [line 1]
!15 = metadata !{i32 1, i32 21, metadata !4, null}
!16 = metadata !{i32 3, i32 3, metadata !4, null}
!17 = metadata !{i32 3, i32 3, metadata !18, null}
!18 = metadata !{i32 786443, metadata !1, metadata !4, i32 3, i32 3, i32 1, i32 0} ; [ DW_TAG_lexical_block ] [/liveness_analysis/t19.c]
!19 = metadata !{i32 4, i32 5, metadata !4, null}
!20 = metadata !{i32 5, i32 3, metadata !4, null}
!21 = metadata !{i32 6, i32 3, metadata !4, null}
!22 = metadata !{i32 6, i32 3, metadata !23, null}
!23 = metadata !{i32 786443, metadata !1, metadata !4, i32 6, i32 3, i32 1, i32 1} ; [ DW_TAG_lexical_block ] [/liveness_analysis/t19.c]
!24 = metadata !{i32 7, i32 5, metadata !4, null}
!25 = metadata !{i32 8, i32 1, metadata !4, null} ; [ DW_TAG_imported_declaration ]

