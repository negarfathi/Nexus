; ModuleID = 'CPU2006_XNU.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind uwtable
define void @xnu(i32 %len) #0 {
xnu_bb0:
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
  br label %xnu_bb1, !dbg !26

xnu_bb1:                                          ; preds = %xnu_bb5, %xnu_bb3, %xnu_bb0
  %i.0 = phi i32 [ 0, %xnu_bb0 ], [ %"1", %xnu_bb3 ], [ %"1", %xnu_bb5 ]
  %end.0 = phi i32 [ 0, %xnu_bb0 ], [ %..end.0, %xnu_bb5 ], [ %"1", %xnu_bb3 ]
  %beg.0 = phi i32 [ 0, %xnu_bb0 ], [ %.beg.0, %xnu_bb5 ], [ %"1", %xnu_bb3 ]
  %"0" = icmp slt i32 %i.0, %len, !dbg !27
  br i1 %"0", label %xnu_bb2, label %xnu_bb6, !dbg !27

xnu_bb2:                                          ; preds = %xnu_bb1
  %"1" = add nsw i32 %i.0, 1, !dbg !29
  %"2" = call i32 (...)* @nondet(), !dbg !30
  %"3" = icmp ne i32 %"2", 0, !dbg !30
  %.end.0 = select i1 %"3", i32 %"1", i32 %end.0, !dbg !30
  %"4" = call i32 (...)* @nondet(), !dbg !32
  %"5" = icmp ne i32 %"4", 0, !dbg !32
  br i1 %"5", label %xnu_bb3, label %xnu_bb5, !dbg !32

xnu_bb3:                                          ; preds = %xnu_bb2, %xnu_bb4
  %k.0 = phi i32 [ %"7", %xnu_bb4 ], [ %beg.0, %xnu_bb2 ]
  %"6" = icmp slt i32 %k.0, %.end.0, !dbg !33
  br i1 %"6", label %xnu_bb4, label %xnu_bb1, !dbg !33

xnu_bb4:                                          ; preds = %xnu_bb3
  %"7" = add nsw i32 %k.0, 1, !dbg !35
  br label %xnu_bb3, !dbg !35

xnu_bb5:                                          ; preds = %xnu_bb2
  %"8" = call i32 (...)* @nondet(), !dbg !36
  %"9" = icmp ne i32 %"8", 0, !dbg !36
  %..end.0 = select i1 %"9", i32 %"1", i32 %.end.0, !dbg !36
  %.beg.0 = select i1 %"9", i32 %"1", i32 %beg.0, !dbg !36
  br label %xnu_bb1

xnu_bb6:                                          ; preds = %xnu_bb1
  ret void, !dbg !38
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

!0 = metadata !{i32 786449, metadata !1, i32 12, metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)", i1 false, metadata !"", i32 0, metadata !2, metadata !2, metadata !3, metadata !2, metadata !2, metadata !"", i32 1} ; [ DW_TAG_compile_unit ] [/liveness_analysis/CPU2006_XNU.c] [DW_LANG_C99]
!1 = metadata !{metadata !"CPU2006_XNU.c", metadata !"/liveness_analysis"}
!2 = metadata !{}
!3 = metadata !{metadata !4}
!4 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"xnu", metadata !"xnu", metadata !"", i32 6, metadata !6, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (i32)* @xnu, null, null, metadata !2, i32 6} ; [ DW_TAG_subprogram ] [line 6] [def] [xnu]
!5 = metadata !{i32 786473, metadata !1}          ; [ DW_TAG_file_type ] [/liveness_analysis/CPU2006_XNU.c]
!6 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !7, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!7 = metadata !{null, metadata !8}
!8 = metadata !{i32 786468, null, null, metadata !"int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!9 = metadata !{i32 2, metadata !"Dwarf Version", i32 4}
!10 = metadata !{i32 2, metadata !"Debug Info Version", i32 1}
!11 = metadata !{metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)"}
!12 = metadata !{i32 786689, metadata !4, metadata !"len", metadata !5, i32 16777222, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [len] [line 6]
!13 = metadata !{i32 6, i32 14, metadata !4, null}
!14 = metadata !{i32 0}
!15 = metadata !{i32 786688, metadata !4, metadata !"beg", metadata !5, i32 7, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [beg] [line 7]
!16 = metadata !{i32 7, i32 9, metadata !4, null}
!17 = metadata !{i32 786688, metadata !4, metadata !"end", metadata !5, i32 8, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [end] [line 8]
!18 = metadata !{i32 8, i32 9, metadata !4, null} ; [ DW_TAG_imported_declaration ]
!19 = metadata !{i32 786688, metadata !4, metadata !"i", metadata !5, i32 9, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [i] [line 9]
!20 = metadata !{i32 9, i32 9, metadata !4, null}
!21 = metadata !{i32 786688, metadata !22, metadata !"k", metadata !5, i32 15, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [k] [line 15]
!22 = metadata !{i32 786443, metadata !1, metadata !23, i32 14, i32 23, i32 0, i32 3} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_XNU.c]
!23 = metadata !{i32 786443, metadata !1, metadata !24, i32 14, i32 13, i32 0, i32 2} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_XNU.c]
!24 = metadata !{i32 786443, metadata !1, metadata !4, i32 10, i32 21, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_XNU.c]
!25 = metadata !{i32 15, i32 17, metadata !22, null}
!26 = metadata !{i32 10, i32 5, metadata !4, null}
!27 = metadata !{i32 10, i32 5, metadata !28, null}
!28 = metadata !{i32 786443, metadata !1, metadata !4, i32 10, i32 5, i32 1, i32 6} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_XNU.c]
!29 = metadata !{i32 11, i32 9, metadata !24, null}
!30 = metadata !{i32 12, i32 13, metadata !31, null}
!31 = metadata !{i32 786443, metadata !1, metadata !24, i32 12, i32 13, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_XNU.c]
!32 = metadata !{i32 14, i32 13, metadata !23, null}
!33 = metadata !{i32 16, i32 13, metadata !34, null}
!34 = metadata !{i32 786443, metadata !1, metadata !22, i32 16, i32 13, i32 1, i32 7} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_XNU.c]
!35 = metadata !{i32 17, i32 17, metadata !22, null}
!36 = metadata !{i32 20, i32 20, metadata !37, null}
!37 = metadata !{i32 786443, metadata !1, metadata !23, i32 20, i32 20, i32 0, i32 4} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_XNU.c]
!38 = metadata !{i32 25, i32 1, metadata !4, null}

