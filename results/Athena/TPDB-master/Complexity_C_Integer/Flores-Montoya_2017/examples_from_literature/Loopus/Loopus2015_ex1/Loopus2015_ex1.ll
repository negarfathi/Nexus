; ModuleID = 'Loopus2015_ex1.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind uwtable
define void @Loopus2015_ex1(i32 %n) #0 {
Loopus2015_ex1_bb0:
  call void @llvm.dbg.value(metadata !{i32 %n}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !{i32 %n}, i64 0, metadata !14), !dbg !15
  call void @llvm.dbg.value(metadata !16, i64 0, metadata !17), !dbg !18
  call void @llvm.dbg.value(metadata !{i32 %"1"}, i64 0, metadata !14), !dbg !15
  call void @llvm.dbg.value(metadata !{i32 %"2"}, i64 0, metadata !17), !dbg !18
  call void @llvm.dbg.value(metadata !{i32 %"2"}, i64 0, metadata !19), !dbg !23
  call void @llvm.dbg.value(metadata !{i32 %"6"}, i64 0, metadata !19), !dbg !23
  br label %Loopus2015_ex1_bb1, !dbg !24

Loopus2015_ex1_bb1:                               ; preds = %Loopus2015_ex1_bb2, %Loopus2015_ex1_bb3, %Loopus2015_ex1_bb0
  %r.0 = phi i32 [ 0, %Loopus2015_ex1_bb0 ], [ %"2", %Loopus2015_ex1_bb2 ], [ 0, %Loopus2015_ex1_bb3 ]
  %x.0 = phi i32 [ %n, %Loopus2015_ex1_bb0 ], [ %"1", %Loopus2015_ex1_bb3 ], [ %"1", %Loopus2015_ex1_bb2 ]
  %"0" = icmp sgt i32 %x.0, 0, !dbg !25
  br i1 %"0", label %Loopus2015_ex1_bb2, label %Loopus2015_ex1_bb5, !dbg !25

Loopus2015_ex1_bb2:                               ; preds = %Loopus2015_ex1_bb1
  %"1" = sub nsw i32 %x.0, 1, !dbg !27
  %"2" = add nsw i32 %r.0, 1, !dbg !28
  %"3" = call i32 (...)* @nondet(), !dbg !29
  %"4" = icmp sgt i32 %"3", 0, !dbg !29
  br i1 %"4", label %Loopus2015_ex1_bb3, label %Loopus2015_ex1_bb1, !dbg !29

Loopus2015_ex1_bb3:                               ; preds = %Loopus2015_ex1_bb2, %Loopus2015_ex1_bb4
  %p.0 = phi i32 [ %"6", %Loopus2015_ex1_bb4 ], [ %"2", %Loopus2015_ex1_bb2 ]
  %"5" = icmp sgt i32 %p.0, 0, !dbg !30
  br i1 %"5", label %Loopus2015_ex1_bb4, label %Loopus2015_ex1_bb1, !dbg !30

Loopus2015_ex1_bb4:                               ; preds = %Loopus2015_ex1_bb3
  %"6" = add nsw i32 %p.0, -1, !dbg !32
  br label %Loopus2015_ex1_bb3, !dbg !32

Loopus2015_ex1_bb5:                               ; preds = %Loopus2015_ex1_bb1
  ret void, !dbg !33
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

!0 = metadata !{i32 786449, metadata !1, i32 12, metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)", i1 false, metadata !"", i32 0, metadata !2, metadata !2, metadata !3, metadata !2, metadata !2, metadata !"", i32 1} ; [ DW_TAG_compile_unit ] [/liveness_analysis/Loopus2015_ex1.c] [DW_LANG_C99]
!1 = metadata !{metadata !"Loopus2015_ex1.c", metadata !"/liveness_analysis"}
!2 = metadata !{}
!3 = metadata !{metadata !4}
!4 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"Loopus2015_ex1", metadata !"Loopus2015_ex1", metadata !"", i32 5, metadata !6, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (i32)* @Loopus2015_ex1, null, null, metadata !2, i32 5} ; [ DW_TAG_subprogram ] [line 5] [def] [Loopus2015_ex1]
!5 = metadata !{i32 786473, metadata !1}          ; [ DW_TAG_file_type ] [/liveness_analysis/Loopus2015_ex1.c]
!6 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !7, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!7 = metadata !{null, metadata !8}
!8 = metadata !{i32 786468, null, null, metadata !"int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!9 = metadata !{i32 2, metadata !"Dwarf Version", i32 4}
!10 = metadata !{i32 2, metadata !"Debug Info Version", i32 1}
!11 = metadata !{metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)"}
!12 = metadata !{i32 786689, metadata !4, metadata !"n", metadata !5, i32 16777221, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [n] [line 5]
!13 = metadata !{i32 5, i32 25, metadata !4, null}
!14 = metadata !{i32 786688, metadata !4, metadata !"x", metadata !5, i32 6, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [x] [line 6]
!15 = metadata !{i32 6, i32 6, metadata !4, null}
!16 = metadata !{i32 0}
!17 = metadata !{i32 786688, metadata !4, metadata !"r", metadata !5, i32 7, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [r] [line 7]
!18 = metadata !{i32 7, i32 6, metadata !4, null}
!19 = metadata !{i32 786688, metadata !20, metadata !"p", metadata !5, i32 12, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [p] [line 12]
!20 = metadata !{i32 786443, metadata !1, metadata !21, i32 11, i32 18, i32 0, i32 2} ; [ DW_TAG_lexical_block ] [/liveness_analysis/Loopus2015_ex1.c]
!21 = metadata !{i32 786443, metadata !1, metadata !22, i32 11, i32 6, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/liveness_analysis/Loopus2015_ex1.c]
!22 = metadata !{i32 786443, metadata !1, metadata !4, i32 8, i32 15, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/liveness_analysis/Loopus2015_ex1.c]
!23 = metadata !{i32 12, i32 8, metadata !20, null}
!24 = metadata !{i32 8, i32 2, metadata !4, null} ; [ DW_TAG_imported_declaration ]
!25 = metadata !{i32 8, i32 2, metadata !26, null} ; [ DW_TAG_imported_declaration ]
!26 = metadata !{i32 786443, metadata !1, metadata !4, i32 8, i32 2, i32 1, i32 3} ; [ DW_TAG_lexical_block ] [/liveness_analysis/Loopus2015_ex1.c]
!27 = metadata !{i32 9, i32 3, metadata !22, null}
!28 = metadata !{i32 10, i32 3, metadata !22, null}
!29 = metadata !{i32 11, i32 6, metadata !21, null}
!30 = metadata !{i32 13, i32 4, metadata !31, null}
!31 = metadata !{i32 786443, metadata !1, metadata !20, i32 13, i32 4, i32 1, i32 4} ; [ DW_TAG_lexical_block ] [/liveness_analysis/Loopus2015_ex1.c]
!32 = metadata !{i32 14, i32 6, metadata !20, null}
!33 = metadata !{i32 18, i32 1, metadata !4, null}

