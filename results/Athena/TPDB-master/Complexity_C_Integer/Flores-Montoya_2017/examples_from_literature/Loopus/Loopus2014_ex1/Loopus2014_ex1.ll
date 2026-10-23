; ModuleID = 'Loopus2014_ex1.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind uwtable
define void @Loopus2014_ex1(i32 %n) #0 {
Loopus2014_ex1_bb0:
  call void @llvm.dbg.value(metadata !{i32 %n}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !{i32 %n}, i64 0, metadata !14), !dbg !15
  call void @llvm.dbg.value(metadata !16, i64 0, metadata !17), !dbg !18
  call void @llvm.dbg.value(metadata !{i32 %"1"}, i64 0, metadata !14), !dbg !15
  call void @llvm.dbg.value(metadata !{i32 %"2"}, i64 0, metadata !17), !dbg !18
  call void @llvm.dbg.value(metadata !{i32 %"4"}, i64 0, metadata !17), !dbg !18
  call void @llvm.dbg.value(metadata !{i32 %"5"}, i64 0, metadata !19), !dbg !23
  call void @llvm.dbg.value(metadata !{i32 %"10"}, i64 0, metadata !14), !dbg !15
  call void @llvm.dbg.value(metadata !{i32 %"11"}, i64 0, metadata !17), !dbg !18
  call void @llvm.dbg.value(metadata !{i32 %"12"}, i64 0, metadata !19), !dbg !23
  br label %Loopus2014_ex1_bb1, !dbg !24

Loopus2014_ex1_bb1:                               ; preds = %Loopus2014_ex1_bb3, %Loopus2014_ex1_bb0
  %b.0 = phi i32 [ 0, %Loopus2014_ex1_bb0 ], [ %b.1, %Loopus2014_ex1_bb3 ]
  %a.0 = phi i32 [ %n, %Loopus2014_ex1_bb0 ], [ %a.1, %Loopus2014_ex1_bb3 ]
  %"0" = icmp sgt i32 %a.0, 0, !dbg !25
  br i1 %"0", label %Loopus2014_ex1_bb2, label %Loopus2014_ex1_bb10, !dbg !25

Loopus2014_ex1_bb2:                               ; preds = %Loopus2014_ex1_bb1
  %"1" = add nsw i32 %a.0, -1, !dbg !27
  %"2" = add nsw i32 %b.0, 1, !dbg !28
  br label %Loopus2014_ex1_bb3, !dbg !29

Loopus2014_ex1_bb3:                               ; preds = %Loopus2014_ex1_bb5, %Loopus2014_ex1_bb2
  %b.1 = phi i32 [ %"2", %Loopus2014_ex1_bb2 ], [ %b.2, %Loopus2014_ex1_bb5 ]
  %a.1 = phi i32 [ %"1", %Loopus2014_ex1_bb2 ], [ %a.2, %Loopus2014_ex1_bb5 ]
  %"3" = icmp sgt i32 %b.1, 0, !dbg !30
  br i1 %"3", label %Loopus2014_ex1_bb4, label %Loopus2014_ex1_bb1, !dbg !30

Loopus2014_ex1_bb4:                               ; preds = %Loopus2014_ex1_bb3
  %"4" = add nsw i32 %b.1, -1, !dbg !32
  %"5" = sub nsw i32 %n, 1, !dbg !33
  br label %Loopus2014_ex1_bb5, !dbg !33

Loopus2014_ex1_bb5:                               ; preds = %Loopus2014_ex1_bb9, %Loopus2014_ex1_bb4
  %i.0 = phi i32 [ %"5", %Loopus2014_ex1_bb4 ], [ %"12", %Loopus2014_ex1_bb9 ]
  %b.2 = phi i32 [ %"4", %Loopus2014_ex1_bb4 ], [ %b.3, %Loopus2014_ex1_bb9 ]
  %a.2 = phi i32 [ %a.1, %Loopus2014_ex1_bb4 ], [ %a.3, %Loopus2014_ex1_bb9 ]
  %"6" = icmp sgt i32 %i.0, 0, !dbg !34
  br i1 %"6", label %Loopus2014_ex1_bb6, label %Loopus2014_ex1_bb3, !dbg !34

Loopus2014_ex1_bb6:                               ; preds = %Loopus2014_ex1_bb5
  %"7" = icmp sgt i32 %a.2, 0, !dbg !37
  br i1 %"7", label %Loopus2014_ex1_bb7, label %Loopus2014_ex1_bb9, !dbg !37

Loopus2014_ex1_bb7:                               ; preds = %Loopus2014_ex1_bb6
  %"8" = call i32 (...)* @nondet(), !dbg !39
  %"9" = icmp sgt i32 %"8", 0, !dbg !39
  br i1 %"9", label %Loopus2014_ex1_bb8, label %Loopus2014_ex1_bb9, !dbg !39

Loopus2014_ex1_bb8:                               ; preds = %Loopus2014_ex1_bb7
  %"10" = add nsw i32 %a.2, -1, !dbg !41
  %"11" = add nsw i32 %b.2, 1, !dbg !43
  br label %Loopus2014_ex1_bb9, !dbg !44

Loopus2014_ex1_bb9:                               ; preds = %Loopus2014_ex1_bb6, %Loopus2014_ex1_bb7, %Loopus2014_ex1_bb8
  %b.3 = phi i32 [ %"11", %Loopus2014_ex1_bb8 ], [ %b.2, %Loopus2014_ex1_bb7 ], [ %b.2, %Loopus2014_ex1_bb6 ]
  %a.3 = phi i32 [ %"10", %Loopus2014_ex1_bb8 ], [ %a.2, %Loopus2014_ex1_bb7 ], [ %a.2, %Loopus2014_ex1_bb6 ]
  %"12" = add nsw i32 %i.0, -1, !dbg !45
  br label %Loopus2014_ex1_bb5, !dbg !45

Loopus2014_ex1_bb10:                              ; preds = %Loopus2014_ex1_bb1
  ret void, !dbg !46
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

!0 = metadata !{i32 786449, metadata !1, i32 12, metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)", i1 false, metadata !"", i32 0, metadata !2, metadata !2, metadata !3, metadata !2, metadata !2, metadata !"", i32 1} ; [ DW_TAG_compile_unit ] [/liveness_analysis/Loopus2014_ex1.c] [DW_LANG_C99]
!1 = metadata !{metadata !"Loopus2014_ex1.c", metadata !"/liveness_analysis"}
!2 = metadata !{}
!3 = metadata !{metadata !4}
!4 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"Loopus2014_ex1", metadata !"Loopus2014_ex1", metadata !"", i32 4, metadata !6, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (i32)* @Loopus2014_ex1, null, null, metadata !2, i32 4} ; [ DW_TAG_subprogram ] [line 4] [def] [Loopus2014_ex1]
!5 = metadata !{i32 786473, metadata !1}          ; [ DW_TAG_file_type ] [/liveness_analysis/Loopus2014_ex1.c]
!6 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !7, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!7 = metadata !{null, metadata !8}
!8 = metadata !{i32 786468, null, null, metadata !"int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!9 = metadata !{i32 2, metadata !"Dwarf Version", i32 4}
!10 = metadata !{i32 2, metadata !"Debug Info Version", i32 1}
!11 = metadata !{metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)"}
!12 = metadata !{i32 786689, metadata !4, metadata !"n", metadata !5, i32 16777220, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [n] [line 4]
!13 = metadata !{i32 4, i32 25, metadata !4, null}
!14 = metadata !{i32 786688, metadata !4, metadata !"a", metadata !5, i32 5, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [a] [line 5]
!15 = metadata !{i32 5, i32 5, metadata !4, null}
!16 = metadata !{i32 0}
!17 = metadata !{i32 786688, metadata !4, metadata !"b", metadata !5, i32 5, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [b] [line 5]
!18 = metadata !{i32 5, i32 12, metadata !4, null}
!19 = metadata !{i32 786688, metadata !20, metadata !"i", metadata !5, i32 10, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [i] [line 10]
!20 = metadata !{i32 786443, metadata !1, metadata !21, i32 10, i32 3, i32 0, i32 2} ; [ DW_TAG_lexical_block ] [/liveness_analysis/Loopus2014_ex1.c]
!21 = metadata !{i32 786443, metadata !1, metadata !22, i32 8, i32 15, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/liveness_analysis/Loopus2014_ex1.c]
!22 = metadata !{i32 786443, metadata !1, metadata !4, i32 6, i32 14, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/liveness_analysis/Loopus2014_ex1.c]
!23 = metadata !{i32 10, i32 12, metadata !20, null}
!24 = metadata !{i32 6, i32 1, metadata !4, null}
!25 = metadata !{i32 6, i32 1, metadata !26, null}
!26 = metadata !{i32 786443, metadata !1, metadata !4, i32 6, i32 1, i32 1, i32 5} ; [ DW_TAG_lexical_block ] [/liveness_analysis/Loopus2014_ex1.c]
!27 = metadata !{i32 7, i32 2, metadata !22, null}
!28 = metadata !{i32 7, i32 7, metadata !22, null}
!29 = metadata !{i32 8, i32 2, metadata !22, null} ; [ DW_TAG_imported_declaration ]
!30 = metadata !{i32 8, i32 2, metadata !31, null} ; [ DW_TAG_imported_declaration ]
!31 = metadata !{i32 786443, metadata !1, metadata !22, i32 8, i32 2, i32 1, i32 6} ; [ DW_TAG_lexical_block ] [/liveness_analysis/Loopus2014_ex1.c]
!32 = metadata !{i32 9, i32 3, metadata !21, null}
!33 = metadata !{i32 10, i32 8, metadata !20, null}
!34 = metadata !{i32 10, i32 8, metadata !35, null}
!35 = metadata !{i32 786443, metadata !1, metadata !36, i32 10, i32 8, i32 2, i32 11} ; [ DW_TAG_lexical_block ] [/liveness_analysis/Loopus2014_ex1.c]
!36 = metadata !{i32 786443, metadata !1, metadata !20, i32 10, i32 8, i32 1, i32 7} ; [ DW_TAG_lexical_block ] [/liveness_analysis/Loopus2014_ex1.c]
!37 = metadata !{i32 11, i32 8, metadata !38, null}
!38 = metadata !{i32 786443, metadata !1, metadata !20, i32 11, i32 8, i32 0, i32 3} ; [ DW_TAG_lexical_block ] [/liveness_analysis/Loopus2014_ex1.c]
!39 = metadata !{i32 11, i32 17, metadata !40, null}
!40 = metadata !{i32 786443, metadata !1, metadata !38, i32 11, i32 17, i32 1, i32 8} ; [ DW_TAG_lexical_block ] [/liveness_analysis/Loopus2014_ex1.c]
!41 = metadata !{i32 12, i32 5, metadata !42, null}
!42 = metadata !{i32 786443, metadata !1, metadata !38, i32 11, i32 28, i32 0, i32 4} ; [ DW_TAG_lexical_block ] [/liveness_analysis/Loopus2014_ex1.c]
!43 = metadata !{i32 12, i32 10, metadata !42, null}
!44 = metadata !{i32 13, i32 4, metadata !42, null}
!45 = metadata !{i32 10, i32 28, metadata !20, null}
!46 = metadata !{i32 16, i32 1, metadata !4, null}

