; ModuleID = 'Loopus2015_big.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind uwtable
define void @Loopus2015_big(i32 %len) #0 {
Loopus2015_big_bb0:
  call void @llvm.dbg.value(metadata !{i32 %len}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !14, i64 0, metadata !15), !dbg !16
  call void @llvm.dbg.value(metadata !14, i64 0, metadata !17), !dbg !18
  call void @llvm.dbg.value(metadata !14, i64 0, metadata !19), !dbg !20
  call void @llvm.dbg.value(metadata !{i32 %"1"}, i64 0, metadata !19), !dbg !20
  call void @llvm.dbg.value(metadata !{i32 %"1"}, i64 0, metadata !17), !dbg !18
  call void @llvm.dbg.value(metadata !{i32 %beg.0}, i64 0, metadata !21), !dbg !25
  call void @llvm.dbg.value(metadata !{i32 %"7"}, i64 0, metadata !21), !dbg !25
  call void @llvm.dbg.value(metadata !{i32 %"1"}, i64 0, metadata !17), !dbg !18
  call void @llvm.dbg.value(metadata !{i32 %"1"}, i64 0, metadata !15), !dbg !16
  br label %Loopus2015_big_bb1, !dbg !26

Loopus2015_big_bb1:                               ; preds = %Loopus2015_big_bb5, %Loopus2015_big_bb3, %Loopus2015_big_bb0
  %i.0 = phi i32 [ 0, %Loopus2015_big_bb0 ], [ %"1", %Loopus2015_big_bb3 ], [ %"1", %Loopus2015_big_bb5 ]
  %end.0 = phi i32 [ 0, %Loopus2015_big_bb0 ], [ %..end.0, %Loopus2015_big_bb5 ], [ %"1", %Loopus2015_big_bb3 ]
  %beg.0 = phi i32 [ 0, %Loopus2015_big_bb0 ], [ %.beg.0, %Loopus2015_big_bb5 ], [ %"1", %Loopus2015_big_bb3 ]
  %"0" = icmp slt i32 %i.0, %len, !dbg !27
  br i1 %"0", label %Loopus2015_big_bb2, label %Loopus2015_big_bb6, !dbg !27

Loopus2015_big_bb2:                               ; preds = %Loopus2015_big_bb1
  %"1" = add nsw i32 %i.0, 1, !dbg !29
  %"2" = call i32 (...)* @nondet(), !dbg !30
  %"3" = icmp ne i32 %"2", 0, !dbg !30
  %.end.0 = select i1 %"3", i32 %"1", i32 %end.0, !dbg !30
  %"4" = call i32 (...)* @nondet(), !dbg !32
  %"5" = icmp ne i32 %"4", 0, !dbg !32
  br i1 %"5", label %Loopus2015_big_bb3, label %Loopus2015_big_bb5, !dbg !32

Loopus2015_big_bb3:                               ; preds = %Loopus2015_big_bb2, %Loopus2015_big_bb4
  %k.0 = phi i32 [ %"7", %Loopus2015_big_bb4 ], [ %beg.0, %Loopus2015_big_bb2 ]
  %"6" = icmp slt i32 %k.0, %.end.0, !dbg !33
  br i1 %"6", label %Loopus2015_big_bb4, label %Loopus2015_big_bb1, !dbg !33

Loopus2015_big_bb4:                               ; preds = %Loopus2015_big_bb3
  %"7" = add nsw i32 %k.0, 1, !dbg !35
  br label %Loopus2015_big_bb3, !dbg !37

Loopus2015_big_bb5:                               ; preds = %Loopus2015_big_bb2
  %"8" = call i32 (...)* @nondet(), !dbg !38
  %"9" = icmp ne i32 %"8", 0, !dbg !38
  %..end.0 = select i1 %"9", i32 %"1", i32 %.end.0, !dbg !38
  %.beg.0 = select i1 %"9", i32 %"1", i32 %beg.0, !dbg !38
  br label %Loopus2015_big_bb1

Loopus2015_big_bb6:                               ; preds = %Loopus2015_big_bb1
  ret void, !dbg !40
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

!0 = metadata !{i32 786449, metadata !1, i32 12, metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)", i1 false, metadata !"", i32 0, metadata !2, metadata !2, metadata !3, metadata !2, metadata !2, metadata !"", i32 1} ; [ DW_TAG_compile_unit ] [/liveness_analysis/Loopus2015_big.c] [DW_LANG_C99]
!1 = metadata !{metadata !"Loopus2015_big.c", metadata !"/liveness_analysis"}
!2 = metadata !{}
!3 = metadata !{metadata !4}
!4 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"Loopus2015_big", metadata !"Loopus2015_big", metadata !"", i32 4, metadata !6, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (i32)* @Loopus2015_big, null, null, metadata !2, i32 4} ; [ DW_TAG_subprogram ] [line 4] [def] [Loopus2015_big]
!5 = metadata !{i32 786473, metadata !1}          ; [ DW_TAG_file_type ] [/liveness_analysis/Loopus2015_big.c]
!6 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !7, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!7 = metadata !{null, metadata !8}
!8 = metadata !{i32 786468, null, null, metadata !"int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!9 = metadata !{i32 2, metadata !"Dwarf Version", i32 4}
!10 = metadata !{i32 2, metadata !"Debug Info Version", i32 1}
!11 = metadata !{metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)"}
!12 = metadata !{i32 786689, metadata !4, metadata !"len", metadata !5, i32 16777220, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [len] [line 4]
!13 = metadata !{i32 4, i32 25, metadata !4, null}
!14 = metadata !{i32 0}
!15 = metadata !{i32 786688, metadata !4, metadata !"beg", metadata !5, i32 5, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [beg] [line 5]
!16 = metadata !{i32 5, i32 5, metadata !4, null}
!17 = metadata !{i32 786688, metadata !4, metadata !"end", metadata !5, i32 5, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [end] [line 5]
!18 = metadata !{i32 5, i32 11, metadata !4, null}
!19 = metadata !{i32 786688, metadata !4, metadata !"i", metadata !5, i32 5, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [i] [line 5]
!20 = metadata !{i32 5, i32 17, metadata !4, null}
!21 = metadata !{i32 786688, metadata !22, metadata !"k", metadata !5, i32 11, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [k] [line 11]
!22 = metadata !{i32 786443, metadata !1, metadata !23, i32 10, i32 16, i32 0, i32 3} ; [ DW_TAG_lexical_block ] [/liveness_analysis/Loopus2015_big.c]
!23 = metadata !{i32 786443, metadata !1, metadata !24, i32 10, i32 6, i32 0, i32 2} ; [ DW_TAG_lexical_block ] [/liveness_analysis/Loopus2015_big.c]
!24 = metadata !{i32 786443, metadata !1, metadata !4, i32 6, i32 17, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/liveness_analysis/Loopus2015_big.c]
!25 = metadata !{i32 11, i32 7, metadata !22, null}
!26 = metadata !{i32 6, i32 2, metadata !4, null}
!27 = metadata !{i32 6, i32 2, metadata !28, null}
!28 = metadata !{i32 786443, metadata !1, metadata !4, i32 6, i32 2, i32 1, i32 7} ; [ DW_TAG_lexical_block ] [/liveness_analysis/Loopus2015_big.c]
!29 = metadata !{i32 7, i32 2, metadata !24, null}
!30 = metadata !{i32 8, i32 6, metadata !31, null} ; [ DW_TAG_imported_declaration ]
!31 = metadata !{i32 786443, metadata !1, metadata !24, i32 8, i32 6, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/liveness_analysis/Loopus2015_big.c]
!32 = metadata !{i32 10, i32 6, metadata !23, null}
!33 = metadata !{i32 12, i32 3, metadata !34, null}
!34 = metadata !{i32 786443, metadata !1, metadata !22, i32 12, i32 3, i32 1, i32 8} ; [ DW_TAG_lexical_block ] [/liveness_analysis/Loopus2015_big.c]
!35 = metadata !{i32 13, i32 4, metadata !36, null}
!36 = metadata !{i32 786443, metadata !1, metadata !22, i32 12, i32 18, i32 0, i32 4} ; [ DW_TAG_lexical_block ] [/liveness_analysis/Loopus2015_big.c]
!37 = metadata !{i32 14, i32 9, metadata !36, null}
!38 = metadata !{i32 17, i32 12, metadata !39, null}
!39 = metadata !{i32 786443, metadata !1, metadata !23, i32 17, i32 12, i32 0, i32 5} ; [ DW_TAG_lexical_block ] [/liveness_analysis/Loopus2015_big.c]
!40 = metadata !{i32 22, i32 1, metadata !4, null}

