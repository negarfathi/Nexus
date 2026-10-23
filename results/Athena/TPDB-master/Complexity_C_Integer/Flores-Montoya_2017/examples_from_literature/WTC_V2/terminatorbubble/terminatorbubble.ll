; ModuleID = 'terminatorbubble.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind uwtable
define i32 @terminatorbubble(i32 %size) #0 {
terminatorbubble_bb0:
  call void @llvm.dbg.value(metadata !{i32 %size}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !14, i64 0, metadata !15), !dbg !16
  call void @llvm.dbg.value(metadata !{i32 %size}, i64 0, metadata !17), !dbg !18
  %"0" = icmp sgt i32 %size, 0, !dbg !19
  br i1 %"0", label %terminatorbubble_bb1, label %terminatorbubble_bb7, !dbg !19

terminatorbubble_bb1:                             ; preds = %terminatorbubble_bb6, %terminatorbubble_bb0
  %b.0 = phi i32 [ %size, %terminatorbubble_bb0 ], [ %t.0, %terminatorbubble_bb6 ]
  %"1" = icmp slt i32 %b.0, 1, !dbg !21
  %"2" = icmp sle i32 %size, 0, !dbg !24
  %or.cond4 = or i1 %"1", %"2", !dbg !21
  br i1 %or.cond4, label %terminatorbubble_bb7, label %terminatorbubble_bb2, !dbg !21

terminatorbubble_bb2:                             ; preds = %terminatorbubble_bb1, %terminatorbubble_bb5
  %j.0 = phi i32 [ %"13", %terminatorbubble_bb5 ], [ 1, %terminatorbubble_bb1 ]
  %t.0 = phi i32 [ %j.0.t.0, %terminatorbubble_bb5 ], [ 0, %terminatorbubble_bb1 ]
  %"3" = sub nsw i32 %b.0, 1, !dbg !27
  %"4" = icmp sle i32 %j.0, %"3", !dbg !27
  br i1 %"4", label %terminatorbubble_bb3, label %terminatorbubble_bb6, !dbg !27

terminatorbubble_bb3:                             ; preds = %terminatorbubble_bb2
  %"5" = icmp slt i32 %j.0, 1, !dbg !29
  %"6" = icmp sgt i32 %j.0, %size, !dbg !32
  %or.cond = or i1 %"5", %"6", !dbg !29
  br i1 %or.cond, label %terminatorbubble_bb7, label %terminatorbubble_bb4, !dbg !29

terminatorbubble_bb4:                             ; preds = %terminatorbubble_bb3
  %"7" = add nsw i32 %j.0, 1, !dbg !34
  %"8" = icmp slt i32 %"7", 1, !dbg !34
  %"9" = add nsw i32 %j.0, 1
  %"10" = icmp sgt i32 %"9", %size, !dbg !36
  %or.cond2 = or i1 %"8", %"10", !dbg !34
  br i1 %or.cond2, label %terminatorbubble_bb7, label %terminatorbubble_bb5, !dbg !34

terminatorbubble_bb5:                             ; preds = %terminatorbubble_bb4
  %"11" = call i32 (...)* @nondet(), !dbg !38
  %"12" = icmp sgt i32 %"11", 0, !dbg !38
  %j.0.t.0 = select i1 %"12", i32 %j.0, i32 %t.0, !dbg !38
  %"13" = add nsw i32 %j.0, 1, !dbg !40
  br label %terminatorbubble_bb2, !dbg !41

terminatorbubble_bb6:                             ; preds = %terminatorbubble_bb2
  %"14" = icmp sgt i32 1, %t.0, !dbg !42
  %"15" = icmp sge i32 %t.0, %b.0, !dbg !44
  %or.cond3 = or i1 %"14", %"15", !dbg !42
  br i1 %or.cond3, label %terminatorbubble_bb7, label %terminatorbubble_bb1, !dbg !42

terminatorbubble_bb7:                             ; preds = %terminatorbubble_bb1, %terminatorbubble_bb0, %terminatorbubble_bb6, %terminatorbubble_bb4, %terminatorbubble_bb3
  ret i32 0, !dbg !46
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

!0 = metadata !{i32 786449, metadata !1, i32 12, metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)", i1 false, metadata !"", i32 0, metadata !2, metadata !2, metadata !3, metadata !2, metadata !2, metadata !"", i32 1} ; [ DW_TAG_compile_unit ] [/liveness_analysis/terminatorbubble.c] [DW_LANG_C99]
!1 = metadata !{metadata !"terminatorbubble.c", metadata !"/liveness_analysis"}
!2 = metadata !{}
!3 = metadata !{metadata !4}
!4 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"terminatorbubble", metadata !"terminatorbubble", metadata !"", i32 4, metadata !6, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, i32 (i32)* @terminatorbubble, null, null, metadata !2, i32 4} ; [ DW_TAG_subprogram ] [line 4] [def] [terminatorbubble]
!5 = metadata !{i32 786473, metadata !1}          ; [ DW_TAG_file_type ] [/liveness_analysis/terminatorbubble.c]
!6 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !7, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!7 = metadata !{metadata !8, metadata !8}
!8 = metadata !{i32 786468, null, null, metadata !"int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!9 = metadata !{i32 2, metadata !"Dwarf Version", i32 4}
!10 = metadata !{i32 2, metadata !"Debug Info Version", i32 1}
!11 = metadata !{metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)"}
!12 = metadata !{i32 786689, metadata !4, metadata !"size", metadata !5, i32 16777220, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [size] [line 4]
!13 = metadata !{i32 4, i32 26, metadata !4, null}
!14 = metadata !{i32 0}
!15 = metadata !{i32 786688, metadata !4, metadata !"error", metadata !5, i32 5, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [error] [line 5]
!16 = metadata !{i32 5, i32 7, metadata !4, null}
!17 = metadata !{i32 786688, metadata !4, metadata !"b", metadata !5, i32 6, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [b] [line 6]
!18 = metadata !{i32 6, i32 7, metadata !4, null}
!19 = metadata !{i32 11, i32 7, metadata !20, null}
!20 = metadata !{i32 786443, metadata !1, metadata !4, i32 11, i32 7, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/liveness_analysis/terminatorbubble.c]
!21 = metadata !{i32 12, i32 3, metadata !22, null}
!22 = metadata !{i32 786443, metadata !1, metadata !23, i32 12, i32 3, i32 1, i32 12} ; [ DW_TAG_lexical_block ] [/liveness_analysis/terminatorbubble.c]
!23 = metadata !{i32 786443, metadata !1, metadata !20, i32 11, i32 15, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/liveness_analysis/terminatorbubble.c]
!24 = metadata !{i32 13, i32 9, metadata !25, null}
!25 = metadata !{i32 786443, metadata !1, metadata !26, i32 13, i32 9, i32 0, i32 3} ; [ DW_TAG_lexical_block ] [/liveness_analysis/terminatorbubble.c]
!26 = metadata !{i32 786443, metadata !1, metadata !23, i32 12, i32 16, i32 0, i32 2} ; [ DW_TAG_lexical_block ] [/liveness_analysis/terminatorbubble.c]
!27 = metadata !{i32 16, i32 5, metadata !28, null}
!28 = metadata !{i32 786443, metadata !1, metadata !26, i32 16, i32 5, i32 1, i32 14} ; [ DW_TAG_lexical_block ] [/liveness_analysis/terminatorbubble.c]
!29 = metadata !{i32 17, i32 11, metadata !30, null}
!30 = metadata !{i32 786443, metadata !1, metadata !31, i32 17, i32 11, i32 0, i32 5} ; [ DW_TAG_lexical_block ] [/liveness_analysis/terminatorbubble.c]
!31 = metadata !{i32 786443, metadata !1, metadata !26, i32 16, i32 20, i32 0, i32 4} ; [ DW_TAG_lexical_block ] [/liveness_analysis/terminatorbubble.c]
!32 = metadata !{i32 17, i32 11, metadata !33, null}
!33 = metadata !{i32 786443, metadata !1, metadata !30, i32 17, i32 11, i32 2, i32 16} ; [ DW_TAG_lexical_block ] [/liveness_analysis/terminatorbubble.c]
!34 = metadata !{i32 18, i32 11, metadata !35, null}
!35 = metadata !{i32 786443, metadata !1, metadata !31, i32 18, i32 11, i32 0, i32 7} ; [ DW_TAG_lexical_block ] [/liveness_analysis/terminatorbubble.c]
!36 = metadata !{i32 18, i32 11, metadata !37, null}
!37 = metadata !{i32 786443, metadata !1, metadata !35, i32 18, i32 11, i32 2, i32 19} ; [ DW_TAG_lexical_block ] [/liveness_analysis/terminatorbubble.c]
!38 = metadata !{i32 19, i32 11, metadata !39, null}
!39 = metadata !{i32 786443, metadata !1, metadata !31, i32 19, i32 11, i32 0, i32 9} ; [ DW_TAG_lexical_block ] [/liveness_analysis/terminatorbubble.c]
!40 = metadata !{i32 20, i32 7, metadata !31, null}
!41 = metadata !{i32 21, i32 5, metadata !31, null}
!42 = metadata !{i32 22, i32 9, metadata !43, null}
!43 = metadata !{i32 786443, metadata !1, metadata !26, i32 22, i32 9, i32 0, i32 11} ; [ DW_TAG_lexical_block ] [/liveness_analysis/terminatorbubble.c]
!44 = metadata !{i32 22, i32 9, metadata !45, null}
!45 = metadata !{i32 786443, metadata !1, metadata !43, i32 22, i32 9, i32 2, i32 23} ; [ DW_TAG_lexical_block ] [/liveness_analysis/terminatorbubble.c]
!46 = metadata !{i32 27, i32 1, metadata !4, null}

