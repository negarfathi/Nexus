; ModuleID = 'amir8.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind uwtable
define void @amir8(i32 %L1, i32 %L2, i32 %X, i32 %Y) #0 {
amir8_bb0:
  call void @llvm.dbg.value(metadata !{i32 %L1}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !{i32 %L2}, i64 0, metadata !14), !dbg !15
  call void @llvm.dbg.value(metadata !{i32 %X}, i64 0, metadata !16), !dbg !17
  call void @llvm.dbg.value(metadata !{i32 %Y}, i64 0, metadata !18), !dbg !19
  call void @llvm.dbg.value(metadata !20, i64 0, metadata !21), !dbg !22
  call void @llvm.dbg.value(metadata !20, i64 0, metadata !23), !dbg !24
  call void @llvm.dbg.value(metadata !{i32 %"0"}, i64 0, metadata !14), !dbg !15
  call void @llvm.dbg.value(metadata !{i32 %.01}, i64 0, metadata !25), !dbg !26
  call void @llvm.dbg.value(metadata !{i32 %Y}, i64 0, metadata !27), !dbg !28
  call void @llvm.dbg.value(metadata !20, i64 0, metadata !29), !dbg !30
  call void @llvm.dbg.value(metadata !{i32 %.01}, i64 0, metadata !31), !dbg !35
  call void @llvm.dbg.value(metadata !{i32 %.01}, i64 0, metadata !27), !dbg !28
  call void @llvm.dbg.value(metadata !{i32 %.01}, i64 0, metadata !25), !dbg !26
  call void @llvm.dbg.value(metadata !{i32 %"3"}, i64 0, metadata !29), !dbg !30
  br label %amir8_bb1, !dbg !36

amir8_bb1:                                        ; preds = %amir8_bb6, %amir8_bb0
  %.01 = phi i32 [ %X, %amir8_bb0 ], [ %"6", %amir8_bb6 ]
  %.0 = phi i32 [ %L2, %amir8_bb0 ], [ %"0", %amir8_bb6 ]
  %"0" = add nsw i32 %.0, -1, !dbg !37
  %"1" = icmp sgt i32 %.0, 0, !dbg !37
  br i1 %"1", label %amir8_bb2, label %amir8_bb7, !dbg !37

amir8_bb2:                                        ; preds = %amir8_bb1, %amir8_bb3
  %i.0 = phi i32 [ %"3", %amir8_bb3 ], [ 0, %amir8_bb1 ]
  %"2" = icmp slt i32 %i.0, %L1, !dbg !39
  br i1 %"2", label %amir8_bb3, label %amir8_bb4, !dbg !39

amir8_bb3:                                        ; preds = %amir8_bb2
  %"3" = add nsw i32 %i.0, 1, !dbg !42
  br label %amir8_bb2, !dbg !42

amir8_bb4:                                        ; preds = %amir8_bb2, %amir8_bb5
  %i.1 = phi i32 [ %"5", %amir8_bb5 ], [ 0, %amir8_bb2 ]
  %"4" = icmp slt i32 %i.1, %L1, !dbg !43
  br i1 %"4", label %amir8_bb5, label %amir8_bb6, !dbg !43

amir8_bb5:                                        ; preds = %amir8_bb4
  %"5" = add nsw i32 %i.1, 1, !dbg !47
  br label %amir8_bb4, !dbg !47

amir8_bb6:                                        ; preds = %amir8_bb4
  call void @llvm.dbg.value(metadata !{i32 %Y}, i64 0, metadata !23), !dbg !24
  %"6" = add nsw i32 %.01, %Y, !dbg !48
  call void @llvm.dbg.value(metadata !{i32 %"6"}, i64 0, metadata !16), !dbg !17
  br label %amir8_bb1, !dbg !49

amir8_bb7:                                        ; preds = %amir8_bb1, %amir8_bb8
  %.1 = phi i32 [ %"8", %amir8_bb8 ], [ %.01, %amir8_bb1 ]
  %"7" = icmp sgt i32 %.1, 0, !dbg !50
  br i1 %"7", label %amir8_bb8, label %amir8_bb9, !dbg !50

amir8_bb8:                                        ; preds = %amir8_bb7
  %"8" = add nsw i32 %.1, -1, !dbg !53
  br label %amir8_bb7, !dbg !53

amir8_bb9:                                        ; preds = %amir8_bb7
  ret void, !dbg !55
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

!0 = metadata !{i32 786449, metadata !1, i32 12, metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)", i1 false, metadata !"", i32 0, metadata !2, metadata !2, metadata !3, metadata !2, metadata !2, metadata !"", i32 1} ; [ DW_TAG_compile_unit ] [/liveness_analysis/amir8.c] [DW_LANG_C99]
!1 = metadata !{metadata !"amir8.c", metadata !"/liveness_analysis"}
!2 = metadata !{}
!3 = metadata !{metadata !4}
!4 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"amir8", metadata !"amir8", metadata !"", i32 6, metadata !6, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (i32, i32, i32, i32)* @amir8, null, null, metadata !2, i32 7} ; [ DW_TAG_subprogram ] [line 6] [def] [scope 7] [amir8]
!5 = metadata !{i32 786473, metadata !1}          ; [ DW_TAG_file_type ] [/liveness_analysis/amir8.c]
!6 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !7, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!7 = metadata !{null, metadata !8, metadata !8, metadata !8, metadata !8}
!8 = metadata !{i32 786468, null, null, metadata !"int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!9 = metadata !{i32 2, metadata !"Dwarf Version", i32 4}
!10 = metadata !{i32 2, metadata !"Debug Info Version", i32 1}
!11 = metadata !{metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)"}
!12 = metadata !{i32 786689, metadata !4, metadata !"L1", metadata !5, i32 16777222, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [L1] [line 6]
!13 = metadata !{i32 6, i32 16, metadata !4, null}
!14 = metadata !{i32 786689, metadata !4, metadata !"L2", metadata !5, i32 33554438, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [L2] [line 6]
!15 = metadata !{i32 6, i32 24, metadata !4, null}
!16 = metadata !{i32 786689, metadata !4, metadata !"X", metadata !5, i32 50331654, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [X] [line 6]
!17 = metadata !{i32 6, i32 32, metadata !4, null}
!18 = metadata !{i32 786689, metadata !4, metadata !"Y", metadata !5, i32 67108870, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [Y] [line 6]
!19 = metadata !{i32 6, i32 39, metadata !4, null}
!20 = metadata !{i32 0}
!21 = metadata !{i32 786688, metadata !4, metadata !"R1", metadata !5, i32 9, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [R1] [line 9]
!22 = metadata !{i32 9, i32 9, metadata !4, null}
!23 = metadata !{i32 786688, metadata !4, metadata !"R2", metadata !5, i32 10, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [R2] [line 10]
!24 = metadata !{i32 10, i32 9, metadata !4, null}
!25 = metadata !{i32 786688, metadata !4, metadata !"A", metadata !5, i32 8, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [A] [line 8]
!26 = metadata !{i32 8, i32 9, metadata !4, null} ; [ DW_TAG_imported_declaration ]
!27 = metadata !{i32 786688, metadata !4, metadata !"B", metadata !5, i32 8, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [B] [line 8]
!28 = metadata !{i32 8, i32 12, metadata !4, null} ; [ DW_TAG_imported_declaration ]
!29 = metadata !{i32 786688, metadata !4, metadata !"i", metadata !5, i32 8, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [i] [line 8]
!30 = metadata !{i32 8, i32 15, metadata !4, null} ; [ DW_TAG_imported_declaration ]
!31 = metadata !{i32 786688, metadata !32, metadata !"tmp", metadata !5, i32 14, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [tmp] [line 14]
!32 = metadata !{i32 786443, metadata !1, metadata !33, i32 13, i32 30, i32 0, i32 2} ; [ DW_TAG_lexical_block ] [/liveness_analysis/amir8.c]
!33 = metadata !{i32 786443, metadata !1, metadata !34, i32 13, i32 9, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/liveness_analysis/amir8.c]
!34 = metadata !{i32 786443, metadata !1, metadata !4, i32 11, i32 24, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/liveness_analysis/amir8.c]
!35 = metadata !{i32 14, i32 17, metadata !32, null}
!36 = metadata !{i32 11, i32 5, metadata !4, null}
!37 = metadata !{i32 11, i32 5, metadata !38, null}
!38 = metadata !{i32 786443, metadata !1, metadata !4, i32 11, i32 5, i32 1, i32 5} ; [ DW_TAG_lexical_block ] [/liveness_analysis/amir8.c]
!39 = metadata !{i32 13, i32 14, metadata !40, null}
!40 = metadata !{i32 786443, metadata !1, metadata !41, i32 13, i32 14, i32 2, i32 7} ; [ DW_TAG_lexical_block ] [/liveness_analysis/amir8.c]
!41 = metadata !{i32 786443, metadata !1, metadata !33, i32 13, i32 14, i32 1, i32 6} ; [ DW_TAG_lexical_block ] [/liveness_analysis/amir8.c]
!42 = metadata !{i32 13, i32 25, metadata !33, null}
!43 = metadata !{i32 21, i32 14, metadata !44, null}
!44 = metadata !{i32 786443, metadata !1, metadata !45, i32 21, i32 14, i32 2, i32 9} ; [ DW_TAG_lexical_block ] [/liveness_analysis/amir8.c]
!45 = metadata !{i32 786443, metadata !1, metadata !46, i32 21, i32 14, i32 1, i32 8} ; [ DW_TAG_lexical_block ] [/liveness_analysis/amir8.c]
!46 = metadata !{i32 786443, metadata !1, metadata !34, i32 21, i32 9, i32 0, i32 3} ; [ DW_TAG_lexical_block ] [/liveness_analysis/amir8.c]
!47 = metadata !{i32 21, i32 25, metadata !46, null}
!48 = metadata !{i32 27, i32 9, metadata !34, null}
!49 = metadata !{i32 28, i32 5, metadata !34, null}
!50 = metadata !{i32 29, i32 5, metadata !51, null}
!51 = metadata !{i32 786443, metadata !1, metadata !52, i32 29, i32 5, i32 3, i32 12} ; [ DW_TAG_lexical_block ] [/liveness_analysis/amir8.c]
!52 = metadata !{i32 786443, metadata !1, metadata !4, i32 29, i32 5, i32 1, i32 10} ; [ DW_TAG_lexical_block ] [/liveness_analysis/amir8.c]
!53 = metadata !{i32 29, i32 17, metadata !54, null}
!54 = metadata !{i32 786443, metadata !1, metadata !4, i32 29, i32 17, i32 2, i32 11} ; [ DW_TAG_lexical_block ] [/liveness_analysis/amir8.c]
!55 = metadata !{i32 30, i32 1, metadata !4, null}

