; ModuleID = 'amir3.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind uwtable
define void @amir3(i32 %x5, i32 %x1, i32 %x2) #0 {
amir3_bb0:
  call void @llvm.dbg.value(metadata !{i32 %x5}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !{i32 %x1}, i64 0, metadata !14), !dbg !15
  call void @llvm.dbg.value(metadata !{i32 %x2}, i64 0, metadata !16), !dbg !17
  call void @llvm.dbg.value(metadata !18, i64 0, metadata !19), !dbg !20
  call void @llvm.dbg.value(metadata !18, i64 0, metadata !21), !dbg !22
  call void @llvm.dbg.value(metadata !{i32 %"0"}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !{i32 %"4"}, i64 0, metadata !19), !dbg !20
  call void @llvm.dbg.value(metadata !{i32 %x2}, i64 0, metadata !21), !dbg !22
  call void @llvm.dbg.value(metadata !{i32 %"5"}, i64 0, metadata !14), !dbg !15
  call void @llvm.dbg.value(metadata !{i32 %x2}, i64 0, metadata !19), !dbg !20
  call void @llvm.dbg.value(metadata !{i32 %"4"}, i64 0, metadata !21), !dbg !22
  br label %amir3_bb1, !dbg !23

amir3_bb1:                                        ; preds = %amir3_bb2, %amir3_bb0
  %.01 = phi i32 [ %x1, %amir3_bb0 ], [ %"5", %amir3_bb2 ]
  %.0 = phi i32 [ %x5, %amir3_bb0 ], [ %"0", %amir3_bb2 ]
  %"0" = add nsw i32 %.0, -1, !dbg !24
  %"1" = icmp sgt i32 %.0, 0, !dbg !24
  br i1 %"1", label %amir3_bb2, label %amir3_bb3, !dbg !24

amir3_bb2:                                        ; preds = %amir3_bb1
  %"2" = call i32 (...)* @nondet(), !dbg !26
  %"3" = icmp ne i32 %"2", 0, !dbg !26
  %"4" = add nsw i32 %.01, %x2, !dbg !29
  %x2. = select i1 %"3", i32 %x2, i32 %"4", !dbg !31
  %.x2 = select i1 %"3", i32 %"4", i32 %x2, !dbg !31
  %"5" = add nsw i32 %.x2, %x2., !dbg !32
  br label %amir3_bb1, !dbg !33

amir3_bb3:                                        ; preds = %amir3_bb1, %amir3_bb4
  %.1 = phi i32 [ %"7", %amir3_bb4 ], [ %.01, %amir3_bb1 ]
  %"6" = icmp sgt i32 %.1, 0, !dbg !34
  br i1 %"6", label %amir3_bb4, label %amir3_bb5, !dbg !34

amir3_bb4:                                        ; preds = %amir3_bb3
  %"7" = add nsw i32 %.1, -1, !dbg !36
  br label %amir3_bb3, !dbg !38

amir3_bb5:                                        ; preds = %amir3_bb3
  ret void, !dbg !39
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

!0 = metadata !{i32 786449, metadata !1, i32 12, metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)", i1 false, metadata !"", i32 0, metadata !2, metadata !2, metadata !3, metadata !2, metadata !2, metadata !"", i32 1} ; [ DW_TAG_compile_unit ] [/liveness_analysis/amir3.c] [DW_LANG_C99]
!1 = metadata !{metadata !"amir3.c", metadata !"/liveness_analysis"}
!2 = metadata !{}
!3 = metadata !{metadata !4}
!4 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"amir3", metadata !"amir3", metadata !"", i32 7, metadata !6, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (i32, i32, i32)* @amir3, null, null, metadata !2, i32 8} ; [ DW_TAG_subprogram ] [line 7] [def] [scope 8] [amir3]
!5 = metadata !{i32 786473, metadata !1}          ; [ DW_TAG_file_type ] [/liveness_analysis/amir3.c]
!6 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !7, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!7 = metadata !{null, metadata !8, metadata !8, metadata !8}
!8 = metadata !{i32 786468, null, null, metadata !"int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!9 = metadata !{i32 2, metadata !"Dwarf Version", i32 4}
!10 = metadata !{i32 2, metadata !"Debug Info Version", i32 1}
!11 = metadata !{metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)"}
!12 = metadata !{i32 786689, metadata !4, metadata !"x5", metadata !5, i32 16777223, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [x5] [line 7]
!13 = metadata !{i32 7, i32 16, metadata !4, null}
!14 = metadata !{i32 786689, metadata !4, metadata !"x1", metadata !5, i32 33554439, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [x1] [line 7]
!15 = metadata !{i32 7, i32 24, metadata !4, null}
!16 = metadata !{i32 786689, metadata !4, metadata !"x2", metadata !5, i32 50331655, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [x2] [line 7]
!17 = metadata !{i32 7, i32 32, metadata !4, null}
!18 = metadata !{i32 0}
!19 = metadata !{i32 786688, metadata !4, metadata !"x3", metadata !5, i32 9, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [x3] [line 9]
!20 = metadata !{i32 9, i32 9, metadata !4, null}
!21 = metadata !{i32 786688, metadata !4, metadata !"x4", metadata !5, i32 10, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [x4] [line 10]
!22 = metadata !{i32 10, i32 9, metadata !4, null}
!23 = metadata !{i32 11, i32 5, metadata !4, null}
!24 = metadata !{i32 11, i32 5, metadata !25, null}
!25 = metadata !{i32 786443, metadata !1, metadata !4, i32 11, i32 5, i32 1, i32 5} ; [ DW_TAG_lexical_block ] [/liveness_analysis/amir3.c]
!26 = metadata !{i32 12, i32 13, metadata !27, null}
!27 = metadata !{i32 786443, metadata !1, metadata !28, i32 12, i32 13, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/liveness_analysis/amir3.c]
!28 = metadata !{i32 786443, metadata !1, metadata !4, i32 11, i32 22, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/liveness_analysis/amir3.c]
!29 = metadata !{i32 13, i32 13, metadata !30, null}
!30 = metadata !{i32 786443, metadata !1, metadata !27, i32 12, i32 23, i32 0, i32 2} ; [ DW_TAG_lexical_block ] [/liveness_analysis/amir3.c]
!31 = metadata !{i32 15, i32 9, metadata !30, null}
!32 = metadata !{i32 19, i32 9, metadata !28, null}
!33 = metadata !{i32 20, i32 5, metadata !28, null}
!34 = metadata !{i32 21, i32 5, metadata !35, null}
!35 = metadata !{i32 786443, metadata !1, metadata !4, i32 21, i32 5, i32 1, i32 6} ; [ DW_TAG_lexical_block ] [/liveness_analysis/amir3.c]
!36 = metadata !{i32 22, i32 9, metadata !37, null}
!37 = metadata !{i32 786443, metadata !1, metadata !4, i32 21, i32 20, i32 0, i32 4} ; [ DW_TAG_lexical_block ] [/liveness_analysis/amir3.c]
!38 = metadata !{i32 23, i32 5, metadata !37, null}
!39 = metadata !{i32 24, i32 1, metadata !4, null}

