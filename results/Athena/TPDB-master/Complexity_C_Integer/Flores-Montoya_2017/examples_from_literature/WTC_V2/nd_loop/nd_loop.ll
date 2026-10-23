; ModuleID = 'nd_loop.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind uwtable
define i32 @nd_loop() #0 {
nd_loop_bb0:
  call void @llvm.dbg.value(metadata !12, i64 0, metadata !13), !dbg !14
  call void @llvm.dbg.value(metadata !{i32 %x.0}, i64 0, metadata !15), !dbg !16
  call void @llvm.dbg.value(metadata !{i32 %"0"}, i64 0, metadata !13), !dbg !14
  br label %nd_loop_bb1, !dbg !17

nd_loop_bb1:                                      ; preds = %nd_loop_bb1, %nd_loop_bb0
  %x.0 = phi i32 [ 0, %nd_loop_bb0 ], [ %"0", %nd_loop_bb1 ]
  %"0" = call i32 (...)* @nondet(), !dbg !18
  %"1" = sub nsw i32 %"0", %x.0, !dbg !20
  %"2" = icmp sgt i32 %"1", 2, !dbg !20
  %"3" = sub nsw i32 %"0", %x.0
  %"4" = icmp slt i32 %"3", 1, !dbg !22
  %or.cond = or i1 %"2", %"4", !dbg !20
  %or.cond.not = xor i1 %or.cond, true, !dbg !20
  %"5" = icmp slt i32 %"0", 10, !dbg !24
  %or.cond2 = and i1 %or.cond.not, %"5", !dbg !20
  br i1 %or.cond2, label %nd_loop_bb1, label %nd_loop_bb2, !dbg !20

nd_loop_bb2:                                      ; preds = %nd_loop_bb1
  ret i32 0, !dbg !26
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

!0 = metadata !{i32 786449, metadata !1, i32 12, metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)", i1 false, metadata !"", i32 0, metadata !2, metadata !2, metadata !3, metadata !2, metadata !2, metadata !"", i32 1} ; [ DW_TAG_compile_unit ] [/liveness_analysis/nd_loop.c] [DW_LANG_C99]
!1 = metadata !{metadata !"nd_loop.c", metadata !"/liveness_analysis"}
!2 = metadata !{}
!3 = metadata !{metadata !4}
!4 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"nd_loop", metadata !"nd_loop", metadata !"", i32 5, metadata !6, i1 false, i1 true, i32 0, i32 0, null, i32 0, i1 false, i32 ()* @nd_loop, null, null, metadata !2, i32 5} ; [ DW_TAG_subprogram ] [line 5] [def] [nd_loop]
!5 = metadata !{i32 786473, metadata !1}          ; [ DW_TAG_file_type ] [/liveness_analysis/nd_loop.c]
!6 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !7, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!7 = metadata !{metadata !8}
!8 = metadata !{i32 786468, null, null, metadata !"int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!9 = metadata !{i32 2, metadata !"Dwarf Version", i32 4}
!10 = metadata !{i32 2, metadata !"Debug Info Version", i32 1}
!11 = metadata !{metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)"}
!12 = metadata !{i32 0}
!13 = metadata !{i32 786688, metadata !4, metadata !"x", metadata !5, i32 6, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [x] [line 6]
!14 = metadata !{i32 6, i32 7, metadata !4, null}
!15 = metadata !{i32 786688, metadata !4, metadata !"y", metadata !5, i32 6, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [y] [line 6]
!16 = metadata !{i32 6, i32 9, metadata !4, null}
!17 = metadata !{i32 10, i32 3, metadata !4, null}
!18 = metadata !{i32 12, i32 7, metadata !19, null}
!19 = metadata !{i32 786443, metadata !1, metadata !4, i32 10, i32 6, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/liveness_analysis/nd_loop.c]
!20 = metadata !{i32 14, i32 9, metadata !21, null}
!21 = metadata !{i32 786443, metadata !1, metadata !19, i32 14, i32 9, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/liveness_analysis/nd_loop.c]
!22 = metadata !{i32 14, i32 9, metadata !23, null}
!23 = metadata !{i32 786443, metadata !1, metadata !21, i32 14, i32 9, i32 2, i32 3} ; [ DW_TAG_lexical_block ] [/liveness_analysis/nd_loop.c]
!24 = metadata !{i32 15, i32 3, metadata !25, null}
!25 = metadata !{i32 786443, metadata !1, metadata !19, i32 15, i32 3, i32 1, i32 5} ; [ DW_TAG_lexical_block ] [/liveness_analysis/nd_loop.c]
!26 = metadata !{i32 18, i32 3, metadata !4, null}

