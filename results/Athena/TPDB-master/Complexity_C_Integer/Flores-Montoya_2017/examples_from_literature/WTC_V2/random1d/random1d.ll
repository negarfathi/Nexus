; ModuleID = 'random1d.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind uwtable
define void @random1d(i32 %max) #0 {
random1d_bb0:
  call void @llvm.dbg.value(metadata !{i32 %max}, i64 0, metadata !12), !dbg !13
  %"0" = icmp sgt i32 %max, 0, !dbg !14
  br i1 %"0", label %random1d_bb1, label %random1d_bb3, !dbg !14

random1d_bb1:                                     ; preds = %random1d_bb0, %random1d_bb2
  %x.0 = phi i32 [ %"6", %random1d_bb2 ], [ 1, %random1d_bb0 ]
  %a.0 = phi i32 [ %a.1, %random1d_bb2 ], [ 0, %random1d_bb0 ]
  %"1" = icmp sle i32 %x.0, %max, !dbg !16
  br i1 %"1", label %random1d_bb2, label %random1d_bb3, !dbg !16

random1d_bb2:                                     ; preds = %random1d_bb1
  %"2" = call i32 (...)* @nondet(), !dbg !19
  %"3" = icmp sgt i32 %"2", 0, !dbg !19
  %"4" = add nsw i32 %a.0, 1, !dbg !22
  %"5" = sub nsw i32 %a.0, 1, !dbg !24
  %a.1 = select i1 %"3", i32 %"4", i32 %"5", !dbg !19
  %"6" = add nsw i32 %x.0, 1, !dbg !26
  br label %random1d_bb1, !dbg !27

random1d_bb3:                                     ; preds = %random1d_bb1, %random1d_bb0
  ret void, !dbg !28
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

!0 = metadata !{i32 786449, metadata !1, i32 12, metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)", i1 false, metadata !"", i32 0, metadata !2, metadata !2, metadata !3, metadata !2, metadata !2, metadata !"", i32 1} ; [ DW_TAG_compile_unit ] [/liveness_analysis/random1d.c] [DW_LANG_C99]
!1 = metadata !{metadata !"random1d.c", metadata !"/liveness_analysis"}
!2 = metadata !{}
!3 = metadata !{metadata !4}
!4 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"random1d", metadata !"random1d", metadata !"", i32 3, metadata !6, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (i32)* @random1d, null, null, metadata !2, i32 3} ; [ DW_TAG_subprogram ] [line 3] [def] [random1d]
!5 = metadata !{i32 786473, metadata !1}          ; [ DW_TAG_file_type ] [/liveness_analysis/random1d.c]
!6 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !7, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!7 = metadata !{null, metadata !8}
!8 = metadata !{i32 786468, null, null, metadata !"int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!9 = metadata !{i32 2, metadata !"Dwarf Version", i32 4}
!10 = metadata !{i32 2, metadata !"Debug Info Version", i32 1}
!11 = metadata !{metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)"}
!12 = metadata !{i32 786689, metadata !4, metadata !"max", metadata !5, i32 16777219, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [max] [line 3]
!13 = metadata !{i32 3, i32 19, metadata !4, null}
!14 = metadata !{i32 5, i32 7, metadata !15, null}
!15 = metadata !{i32 786443, metadata !1, metadata !4, i32 5, i32 7, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/liveness_analysis/random1d.c]
!16 = metadata !{i32 8, i32 3, metadata !17, null} ; [ DW_TAG_imported_declaration ]
!17 = metadata !{i32 786443, metadata !1, metadata !18, i32 8, i32 3, i32 1, i32 4} ; [ DW_TAG_lexical_block ] [/liveness_analysis/random1d.c]
!18 = metadata !{i32 786443, metadata !1, metadata !15, i32 5, i32 14, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/liveness_analysis/random1d.c]
!19 = metadata !{i32 9, i32 9, metadata !20, null}
!20 = metadata !{i32 786443, metadata !1, metadata !21, i32 9, i32 9, i32 0, i32 3} ; [ DW_TAG_lexical_block ] [/liveness_analysis/random1d.c]
!21 = metadata !{i32 786443, metadata !1, metadata !18, i32 8, i32 18, i32 0, i32 2} ; [ DW_TAG_lexical_block ] [/liveness_analysis/random1d.c]
!22 = metadata !{i32 9, i32 21, metadata !23, null}
!23 = metadata !{i32 786443, metadata !1, metadata !20, i32 9, i32 21, i32 1, i32 5} ; [ DW_TAG_lexical_block ] [/liveness_analysis/random1d.c]
!24 = metadata !{i32 9, i32 33, metadata !25, null}
!25 = metadata !{i32 786443, metadata !1, metadata !20, i32 9, i32 33, i32 2, i32 6} ; [ DW_TAG_lexical_block ] [/liveness_analysis/random1d.c]
!26 = metadata !{i32 10, i32 5, metadata !21, null}
!27 = metadata !{i32 11, i32 3, metadata !21, null}
!28 = metadata !{i32 14, i32 1, metadata !4, null}

