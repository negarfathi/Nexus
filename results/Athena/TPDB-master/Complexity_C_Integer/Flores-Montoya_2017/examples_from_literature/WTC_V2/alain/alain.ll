; ModuleID = 'alain.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind uwtable
define i32 @alain(i32 %x, i32 %y, i32 %z, i32 %n1, i32 %n2) #0 {
alain_bb0:
  call void @llvm.dbg.value(metadata !{i32 %x}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !{i32 %y}, i64 0, metadata !14), !dbg !15
  call void @llvm.dbg.value(metadata !{i32 %z}, i64 0, metadata !16), !dbg !17
  call void @llvm.dbg.value(metadata !{i32 %n1}, i64 0, metadata !18), !dbg !19
  call void @llvm.dbg.value(metadata !{i32 %n2}, i64 0, metadata !20), !dbg !21
  call void @llvm.dbg.value(metadata !22, i64 0, metadata !23), !dbg !24
  %"0" = mul nsw i32 2, %y, !dbg !25
  %"1" = icmp sle i32 %n2, %"0", !dbg !25
  %"2" = add nsw i32 %z, %y
  %"3" = icmp sle i32 %n2, %"2", !dbg !27
  %or.cond9 = or i1 %"1", %"3", !dbg !25
  br i1 %or.cond9, label %alain_bb7, label %alain_bb1, !dbg !25

alain_bb1:                                        ; preds = %alain_bb0
  %"4" = icmp sge i32 %z, 0, !dbg !29
  %"5" = icmp sge i32 %x, 0, !dbg !31
  %or.cond = and i1 %"4", %"5", !dbg !29
  %"6" = icmp sge i32 %y, 0, !dbg !33
  %or.cond5 = and i1 %or.cond, %"6", !dbg !29
  %"7" = icmp sge i32 %n1, 0, !dbg !35
  %or.cond6 = and i1 %or.cond5, %"7", !dbg !29
  %"8" = icmp sge i32 %n2, 0, !dbg !37
  %or.cond7 = and i1 %or.cond6, %"8", !dbg !29
  br i1 %or.cond7, label %alain_bb2, label %alain_bb7, !dbg !29

alain_bb2:                                        ; preds = %alain_bb1, %alain_bb6
  %c1.0 = phi i32 [ %"11", %alain_bb6 ], [ 0, %alain_bb1 ]
  %.03 = phi i32 [ %"15", %alain_bb6 ], [ %n2, %alain_bb1 ]
  %.02 = phi i32 [ %"9", %alain_bb6 ], [ %n1, %alain_bb1 ]
  %.01 = phi i32 [ %"15", %alain_bb6 ], [ %z, %alain_bb1 ]
  %"9" = add nsw i32 %.02, -1, !dbg !39
  %"10" = icmp sge i32 %"9", 0, !dbg !39
  br i1 %"10", label %alain_bb3, label %alain_bb7, !dbg !39

alain_bb3:                                        ; preds = %alain_bb2
  %"11" = add nsw i32 %c1.0, 1, !dbg !42
  br label %alain_bb4, !dbg !44

alain_bb4:                                        ; preds = %alain_bb5, %alain_bb3
  %c2.0 = phi i32 [ 0, %alain_bb3 ], [ %"14", %alain_bb5 ]
  %.14 = phi i32 [ %.03, %alain_bb3 ], [ %"13", %alain_bb5 ]
  %.1 = phi i32 [ %.01, %alain_bb3 ], [ %y, %alain_bb5 ]
  %"12" = icmp sgt i32 %.14, 0, !dbg !45
  br i1 %"12", label %alain_bb5, label %alain_bb6, !dbg !45

alain_bb5:                                        ; preds = %alain_bb4
  %"13" = add nsw i32 %.14, -1, !dbg !47
  %"14" = add nsw i32 %c2.0, 1, !dbg !49
  br label %alain_bb4, !dbg !50

alain_bb6:                                        ; preds = %alain_bb4
  %"15" = add nsw i32 %.1, %y, !dbg !51
  call void @llvm.dbg.value(metadata !{i32 %"15"}, i64 0, metadata !16), !dbg !17
  call void @llvm.dbg.value(metadata !{i32 %"15"}, i64 0, metadata !20), !dbg !21
  br label %alain_bb2, !dbg !52

alain_bb7:                                        ; preds = %alain_bb1, %alain_bb2, %alain_bb0
  ret i32 0, !dbg !53
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

!0 = metadata !{i32 786449, metadata !1, i32 12, metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)", i1 false, metadata !"", i32 0, metadata !2, metadata !2, metadata !3, metadata !2, metadata !2, metadata !"", i32 1} ; [ DW_TAG_compile_unit ] [/liveness_analysis/alain.c] [DW_LANG_C99]
!1 = metadata !{metadata !"alain.c", metadata !"/liveness_analysis"}
!2 = metadata !{}
!3 = metadata !{metadata !4}
!4 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"alain", metadata !"alain", metadata !"", i32 2, metadata !6, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, i32 (i32, i32, i32, i32, i32)* @alain, null, null, metadata !2, i32 3} ; [ DW_TAG_subprogram ] [line 2] [def] [scope 3] [alain]
!5 = metadata !{i32 786473, metadata !1}          ; [ DW_TAG_file_type ] [/liveness_analysis/alain.c]
!6 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !7, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!7 = metadata !{metadata !8, metadata !8, metadata !8, metadata !8, metadata !8, metadata !8}
!8 = metadata !{i32 786468, null, null, metadata !"int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!9 = metadata !{i32 2, metadata !"Dwarf Version", i32 4}
!10 = metadata !{i32 2, metadata !"Debug Info Version", i32 1}
!11 = metadata !{metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)"}
!12 = metadata !{i32 786689, metadata !4, metadata !"x", metadata !5, i32 16777218, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [x] [line 2]
!13 = metadata !{i32 2, i32 15, metadata !4, null}
!14 = metadata !{i32 786689, metadata !4, metadata !"y", metadata !5, i32 33554434, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [y] [line 2]
!15 = metadata !{i32 2, i32 21, metadata !4, null}
!16 = metadata !{i32 786689, metadata !4, metadata !"z", metadata !5, i32 50331650, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [z] [line 2]
!17 = metadata !{i32 2, i32 27, metadata !4, null}
!18 = metadata !{i32 786689, metadata !4, metadata !"n1", metadata !5, i32 67108866, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [n1] [line 2]
!19 = metadata !{i32 2, i32 33, metadata !4, null}
!20 = metadata !{i32 786689, metadata !4, metadata !"n2", metadata !5, i32 83886082, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [n2] [line 2]
!21 = metadata !{i32 2, i32 40, metadata !4, null}
!22 = metadata !{i32 0}
!23 = metadata !{i32 786688, metadata !4, metadata !"c1", metadata !5, i32 5, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [c1] [line 5]
!24 = metadata !{i32 5, i32 7, metadata !4, null}
!25 = metadata !{i32 7, i32 6, metadata !26, null}
!26 = metadata !{i32 786443, metadata !1, metadata !4, i32 7, i32 6, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/liveness_analysis/alain.c]
!27 = metadata !{i32 8, i32 6, metadata !28, null} ; [ DW_TAG_imported_declaration ]
!28 = metadata !{i32 786443, metadata !1, metadata !4, i32 8, i32 6, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/liveness_analysis/alain.c]
!29 = metadata !{i32 9, i32 6, metadata !30, null}
!30 = metadata !{i32 786443, metadata !1, metadata !4, i32 9, i32 6, i32 0, i32 2} ; [ DW_TAG_lexical_block ] [/liveness_analysis/alain.c]
!31 = metadata !{i32 9, i32 6, metadata !32, null}
!32 = metadata !{i32 786443, metadata !1, metadata !30, i32 9, i32 6, i32 1, i32 8} ; [ DW_TAG_lexical_block ] [/liveness_analysis/alain.c]
!33 = metadata !{i32 9, i32 6, metadata !34, null}
!34 = metadata !{i32 786443, metadata !1, metadata !30, i32 9, i32 6, i32 2, i32 9} ; [ DW_TAG_lexical_block ] [/liveness_analysis/alain.c]
!35 = metadata !{i32 9, i32 6, metadata !36, null}
!36 = metadata !{i32 786443, metadata !1, metadata !30, i32 9, i32 6, i32 3, i32 10} ; [ DW_TAG_lexical_block ] [/liveness_analysis/alain.c]
!37 = metadata !{i32 9, i32 6, metadata !38, null}
!38 = metadata !{i32 786443, metadata !1, metadata !30, i32 9, i32 6, i32 4, i32 11} ; [ DW_TAG_lexical_block ] [/liveness_analysis/alain.c]
!39 = metadata !{i32 11, i32 7, metadata !40, null}
!40 = metadata !{i32 786443, metadata !1, metadata !41, i32 11, i32 7, i32 1, i32 12} ; [ DW_TAG_lexical_block ] [/liveness_analysis/alain.c]
!41 = metadata !{i32 786443, metadata !1, metadata !30, i32 10, i32 5, i32 0, i32 3} ; [ DW_TAG_lexical_block ] [/liveness_analysis/alain.c]
!42 = metadata !{i32 14, i32 11, metadata !43, null}
!43 = metadata !{i32 786443, metadata !1, metadata !41, i32 12, i32 2, i32 0, i32 4} ; [ DW_TAG_lexical_block ] [/liveness_analysis/alain.c]
!44 = metadata !{i32 15, i32 4, metadata !43, null}
!45 = metadata !{i32 15, i32 4, metadata !46, null}
!46 = metadata !{i32 786443, metadata !1, metadata !43, i32 15, i32 4, i32 1, i32 13} ; [ DW_TAG_lexical_block ] [/liveness_analysis/alain.c]
!47 = metadata !{i32 17, i32 8, metadata !48, null}
!48 = metadata !{i32 786443, metadata !1, metadata !43, i32 16, i32 6, i32 0, i32 5} ; [ DW_TAG_lexical_block ] [/liveness_analysis/alain.c]
!49 = metadata !{i32 19, i32 15, metadata !48, null}
!50 = metadata !{i32 20, i32 6, metadata !48, null}
!51 = metadata !{i32 21, i32 4, metadata !43, null}
!52 = metadata !{i32 23, i32 2, metadata !43, null}
!53 = metadata !{i32 26, i32 1, metadata !4, null}

