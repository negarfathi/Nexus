; ModuleID = 'Loopus2015_ex2.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind uwtable
define void @Loopus2015_ex2(i32 %n, i32 %m1, i32 %m2) #0 {
Loopus2015_ex2_bb0:
  call void @llvm.dbg.value(metadata !{i32 %n}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !{i32 %m1}, i64 0, metadata !14), !dbg !15
  call void @llvm.dbg.value(metadata !{i32 %m2}, i64 0, metadata !16), !dbg !17
  %"0" = icmp slt i32 %n, 0, !dbg !18
  %"1" = icmp slt i32 %m1, 0, !dbg !20
  %or.cond = or i1 %"0", %"1", !dbg !18
  %"2" = icmp slt i32 %m2, 0, !dbg !22
  %or.cond1 = or i1 %or.cond, %"2", !dbg !18
  br i1 %or.cond1, label %Loopus2015_ex2_bb6, label %Loopus2015_ex2_bb1, !dbg !18

Loopus2015_ex2_bb1:                               ; preds = %Loopus2015_ex2_bb0
  call void @llvm.dbg.value(metadata !{i32 %n}, i64 0, metadata !24), !dbg !25
  %"3" = call i32 (...)* @nondet(), !dbg !26
  %"4" = icmp sgt i32 %"3", 0, !dbg !26
  %m1.m2 = select i1 %"4", i32 %m1, i32 %m2, !dbg !28
  call void @llvm.dbg.value(metadata !{i32 %"6"}, i64 0, metadata !24), !dbg !25
  call void @llvm.dbg.value(metadata !{i32 %"7"}, i64 0, metadata !29), !dbg !30
  br label %Loopus2015_ex2_bb2, !dbg !31

Loopus2015_ex2_bb2:                               ; preds = %Loopus2015_ex2_bb3, %Loopus2015_ex2_bb1
  %x.1 = phi i32 [ %m1.m2, %Loopus2015_ex2_bb1 ], [ %"7", %Loopus2015_ex2_bb3 ]
  %y.0 = phi i32 [ %n, %Loopus2015_ex2_bb1 ], [ %"6", %Loopus2015_ex2_bb3 ]
  %"5" = icmp sgt i32 %y.0, 0, !dbg !32
  br i1 %"5", label %Loopus2015_ex2_bb3, label %Loopus2015_ex2_bb4, !dbg !32

Loopus2015_ex2_bb3:                               ; preds = %Loopus2015_ex2_bb2
  %"6" = add nsw i32 %y.0, -1, !dbg !34
  %"7" = add nsw i32 %x.1, 2, !dbg !36
  br label %Loopus2015_ex2_bb2, !dbg !37

Loopus2015_ex2_bb4:                               ; preds = %Loopus2015_ex2_bb2, %Loopus2015_ex2_bb5
  %z.0 = phi i32 [ %"9", %Loopus2015_ex2_bb5 ], [ %x.1, %Loopus2015_ex2_bb2 ]
  %"8" = icmp sgt i32 %z.0, 0, !dbg !38
  br i1 %"8", label %Loopus2015_ex2_bb5, label %Loopus2015_ex2_bb6, !dbg !38

Loopus2015_ex2_bb5:                               ; preds = %Loopus2015_ex2_bb4
  %"9" = add nsw i32 %z.0, -1, !dbg !40
  br label %Loopus2015_ex2_bb4, !dbg !40

Loopus2015_ex2_bb6:                               ; preds = %Loopus2015_ex2_bb0, %Loopus2015_ex2_bb4
  ret void, !dbg !41
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

!0 = metadata !{i32 786449, metadata !1, i32 12, metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)", i1 false, metadata !"", i32 0, metadata !2, metadata !2, metadata !3, metadata !2, metadata !2, metadata !"", i32 1} ; [ DW_TAG_compile_unit ] [/liveness_analysis/Loopus2015_ex2.c] [DW_LANG_C99]
!1 = metadata !{metadata !"Loopus2015_ex2.c", metadata !"/liveness_analysis"}
!2 = metadata !{}
!3 = metadata !{metadata !4}
!4 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"Loopus2015_ex2", metadata !"Loopus2015_ex2", metadata !"", i32 4, metadata !6, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (i32, i32, i32)* @Loopus2015_ex2, null, null, metadata !2, i32 4} ; [ DW_TAG_subprogram ] [line 4] [def] [Loopus2015_ex2]
!5 = metadata !{i32 786473, metadata !1}          ; [ DW_TAG_file_type ] [/liveness_analysis/Loopus2015_ex2.c]
!6 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !7, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!7 = metadata !{null, metadata !8, metadata !8, metadata !8}
!8 = metadata !{i32 786468, null, null, metadata !"int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!9 = metadata !{i32 2, metadata !"Dwarf Version", i32 4}
!10 = metadata !{i32 2, metadata !"Debug Info Version", i32 1}
!11 = metadata !{metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)"}
!12 = metadata !{i32 786689, metadata !4, metadata !"n", metadata !5, i32 16777220, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [n] [line 4]
!13 = metadata !{i32 4, i32 25, metadata !4, null}
!14 = metadata !{i32 786689, metadata !4, metadata !"m1", metadata !5, i32 33554436, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [m1] [line 4]
!15 = metadata !{i32 4, i32 32, metadata !4, null}
!16 = metadata !{i32 786689, metadata !4, metadata !"m2", metadata !5, i32 50331652, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [m2] [line 4]
!17 = metadata !{i32 4, i32 39, metadata !4, null}
!18 = metadata !{i32 5, i32 5, metadata !19, null}
!19 = metadata !{i32 786443, metadata !1, metadata !4, i32 5, i32 5, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/liveness_analysis/Loopus2015_ex2.c]
!20 = metadata !{i32 6, i32 5, metadata !21, null}
!21 = metadata !{i32 786443, metadata !1, metadata !4, i32 6, i32 5, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/liveness_analysis/Loopus2015_ex2.c]
!22 = metadata !{i32 7, i32 5, metadata !23, null}
!23 = metadata !{i32 786443, metadata !1, metadata !4, i32 7, i32 5, i32 0, i32 2} ; [ DW_TAG_lexical_block ] [/liveness_analysis/Loopus2015_ex2.c]
!24 = metadata !{i32 786688, metadata !4, metadata !"y", metadata !5, i32 8, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [y] [line 8]
!25 = metadata !{i32 8, i32 6, metadata !4, null} ; [ DW_TAG_imported_declaration ]
!26 = metadata !{i32 10, i32 5, metadata !27, null}
!27 = metadata !{i32 786443, metadata !1, metadata !4, i32 10, i32 5, i32 0, i32 3} ; [ DW_TAG_lexical_block ] [/liveness_analysis/Loopus2015_ex2.c]
!28 = metadata !{i32 11, i32 5, metadata !27, null}
!29 = metadata !{i32 786688, metadata !4, metadata !"x", metadata !5, i32 9, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [x] [line 9]
!30 = metadata !{i32 9, i32 6, metadata !4, null}
!31 = metadata !{i32 14, i32 2, metadata !4, null}
!32 = metadata !{i32 14, i32 2, metadata !33, null}
!33 = metadata !{i32 786443, metadata !1, metadata !4, i32 14, i32 2, i32 1, i32 8} ; [ DW_TAG_lexical_block ] [/liveness_analysis/Loopus2015_ex2.c]
!34 = metadata !{i32 15, i32 4, metadata !35, null}
!35 = metadata !{i32 786443, metadata !1, metadata !4, i32 14, i32 15, i32 0, i32 4} ; [ DW_TAG_lexical_block ] [/liveness_analysis/Loopus2015_ex2.c]
!36 = metadata !{i32 16, i32 4, metadata !35, null}
!37 = metadata !{i32 17, i32 3, metadata !35, null}
!38 = metadata !{i32 19, i32 3, metadata !39, null}
!39 = metadata !{i32 786443, metadata !1, metadata !4, i32 19, i32 3, i32 1, i32 9} ; [ DW_TAG_lexical_block ] [/liveness_analysis/Loopus2015_ex2.c]
!40 = metadata !{i32 20, i32 4, metadata !4, null}
!41 = metadata !{i32 21, i32 1, metadata !4, null}

