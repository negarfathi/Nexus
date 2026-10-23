; ModuleID = 'size12.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind uwtable
define i32 @size12(i32 %a, i32 %b, i32 %c, i32 %d) #0 {
size12_bb0:
  call void @llvm.dbg.value(metadata !{i32 %a}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !{i32 %b}, i64 0, metadata !14), !dbg !15
  call void @llvm.dbg.value(metadata !{i32 %c}, i64 0, metadata !16), !dbg !17
  call void @llvm.dbg.value(metadata !{i32 %d}, i64 0, metadata !18), !dbg !19
  call void @llvm.dbg.value(metadata !{i32 %a}, i64 0, metadata !20), !dbg !21
  call void @llvm.dbg.value(metadata !22, i64 0, metadata !23), !dbg !24
  call void @llvm.dbg.value(metadata !{i32 %"1"}, i64 0, metadata !20), !dbg !21
  call void @llvm.dbg.value(metadata !{i32 %"2"}, i64 0, metadata !23), !dbg !24
  call void @llvm.dbg.value(metadata !{i32 %"4"}, i64 0, metadata !23), !dbg !24
  call void @llvm.dbg.value(metadata !{i32 %"5"}, i64 0, metadata !25), !dbg !28
  call void @llvm.dbg.value(metadata !{i32 %a}, i64 0, metadata !16), !dbg !17
  call void @llvm.dbg.value(metadata !{i32 %.06}, i64 0, metadata !14), !dbg !15
  call void @llvm.dbg.value(metadata !{i32 %.06}, i64 0, metadata !16), !dbg !17
  call void @llvm.dbg.value(metadata !{i32 %a}, i64 0, metadata !14), !dbg !15
  br label %size12_bb1, !dbg !29

size12_bb1:                                       ; preds = %size12_bb5, %size12_bb0
  %t1.0 = phi i32 [ %a, %size12_bb0 ], [ %"1", %size12_bb5 ]
  %.06 = phi i32 [ %d, %size12_bb0 ], [ %"7", %size12_bb5 ]
  %.01 = phi i32 [ %c, %size12_bb0 ], [ %.12, %size12_bb5 ]
  %.0 = phi i32 [ %b, %size12_bb0 ], [ %.1, %size12_bb5 ]
  %"0" = icmp sgt i32 %t1.0, 0, !dbg !30
  br i1 %"0", label %size12_bb2, label %size12_bb6, !dbg !30

size12_bb2:                                       ; preds = %size12_bb1
  %"1" = sub nsw i32 %t1.0, 1, !dbg !32
  %"2" = add nsw i32 %.0, %.01, !dbg !33
  br label %size12_bb3, !dbg !34

size12_bb3:                                       ; preds = %size12_bb4, %size12_bb2
  %t2.0 = phi i32 [ %"2", %size12_bb2 ], [ %"4", %size12_bb4 ]
  %.12 = phi i32 [ %.01, %size12_bb2 ], [ %a..06, %size12_bb4 ]
  %.1 = phi i32 [ %.0, %size12_bb2 ], [ %.06.a, %size12_bb4 ]
  %"3" = icmp sgt i32 %t2.0, 0, !dbg !35
  br i1 %"3", label %size12_bb4, label %size12_bb5, !dbg !35

size12_bb4:                                       ; preds = %size12_bb3
  %"4" = sub nsw i32 %t2.0, 1, !dbg !37
  %"5" = call i32 @__VERIFIER_nondet_int(), !dbg !38
  %"6" = icmp sgt i32 %"5", 0, !dbg !39
  %a..06 = select i1 %"6", i32 %a, i32 %.06, !dbg !41
  %.06.a = select i1 %"6", i32 %.06, i32 %a, !dbg !41
  br label %size12_bb3, !dbg !43

size12_bb5:                                       ; preds = %size12_bb3
  %"7" = add nsw i32 %.1, %.12, !dbg !44
  call void @llvm.dbg.value(metadata !{i32 %"7"}, i64 0, metadata !18), !dbg !19
  br label %size12_bb1, !dbg !45

size12_bb6:                                       ; preds = %size12_bb8, %size12_bb7, %size12_bb1
  %.17 = phi i32 [ %.06, %size12_bb1 ], [ %"9", %size12_bb7 ], [ %"9", %size12_bb8 ]
  %.34 = phi i32 [ %.01, %size12_bb1 ], [ %"13", %size12_bb8 ], [ %.3, %size12_bb7 ]
  %.3 = phi i32 [ %.0, %size12_bb1 ], [ %.3, %size12_bb8 ], [ %a, %size12_bb7 ]
  %"8" = icmp sgt i32 %.17, 0, !dbg !46
  br i1 %"8", label %size12_bb7, label %size12_bb9, !dbg !46

size12_bb7:                                       ; preds = %size12_bb6
  %"9" = sub nsw i32 %.17, 1, !dbg !48
  %"10" = call i32 @__VERIFIER_nondet_int(), !dbg !50
  %"11" = icmp sgt i32 %"10", 0, !dbg !51
  br i1 %"11", label %size12_bb8, label %size12_bb6, !dbg !51

size12_bb8:                                       ; preds = %size12_bb7
  %"12" = add nsw i32 %a, %.3, !dbg !53
  %"13" = add nsw i32 %"12", %.34, !dbg !53
  br label %size12_bb6, !dbg !55

size12_bb9:                                       ; preds = %size12_bb6
  ret i32 0, !dbg !56
}

; Function Attrs: nounwind readnone
declare void @llvm.dbg.declare(metadata, metadata) #1

declare i32 @__VERIFIER_nondet_int() #2

declare i32 @__kittel_nondef.0()

; Function Attrs: nounwind readnone
declare void @llvm.dbg.value(metadata, i64, metadata) #1

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone }
attributes #2 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!9, !10}
!llvm.ident = !{!11}

!0 = metadata !{i32 786449, metadata !1, i32 12, metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)", i1 false, metadata !"", i32 0, metadata !2, metadata !2, metadata !3, metadata !2, metadata !2, metadata !"", i32 1} ; [ DW_TAG_compile_unit ] [/liveness_analysis/size12.c] [DW_LANG_C99]
!1 = metadata !{metadata !"size12.c", metadata !"/liveness_analysis"}
!2 = metadata !{}
!3 = metadata !{metadata !4}
!4 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"size12", metadata !"size12", metadata !"", i32 3, metadata !6, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, i32 (i32, i32, i32, i32)* @size12, null, null, metadata !2, i32 3} ; [ DW_TAG_subprogram ] [line 3] [def] [size12]
!5 = metadata !{i32 786473, metadata !1}          ; [ DW_TAG_file_type ] [/liveness_analysis/size12.c]
!6 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !7, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!7 = metadata !{metadata !8, metadata !8, metadata !8, metadata !8, metadata !8}
!8 = metadata !{i32 786468, null, null, metadata !"int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!9 = metadata !{i32 2, metadata !"Dwarf Version", i32 4}
!10 = metadata !{i32 2, metadata !"Debug Info Version", i32 1}
!11 = metadata !{metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)"}
!12 = metadata !{i32 786689, metadata !4, metadata !"a", metadata !5, i32 16777219, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [a] [line 3]
!13 = metadata !{i32 3, i32 16, metadata !4, null}
!14 = metadata !{i32 786689, metadata !4, metadata !"b", metadata !5, i32 33554435, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [b] [line 3]
!15 = metadata !{i32 3, i32 23, metadata !4, null}
!16 = metadata !{i32 786689, metadata !4, metadata !"c", metadata !5, i32 50331651, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [c] [line 3]
!17 = metadata !{i32 3, i32 30, metadata !4, null}
!18 = metadata !{i32 786689, metadata !4, metadata !"d", metadata !5, i32 67108867, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [d] [line 3]
!19 = metadata !{i32 3, i32 37, metadata !4, null}
!20 = metadata !{i32 786688, metadata !4, metadata !"t1", metadata !5, i32 4, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [t1] [line 4]
!21 = metadata !{i32 4, i32 7, metadata !4, null}
!22 = metadata !{i32 0}
!23 = metadata !{i32 786688, metadata !4, metadata !"t2", metadata !5, i32 5, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [t2] [line 5]
!24 = metadata !{i32 5, i32 7, metadata !4, null}
!25 = metadata !{i32 786688, metadata !26, metadata !"u", metadata !5, i32 11, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [u] [line 11]
!26 = metadata !{i32 786443, metadata !1, metadata !27, i32 9, i32 19, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/liveness_analysis/size12.c]
!27 = metadata !{i32 786443, metadata !1, metadata !4, i32 6, i32 17, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/liveness_analysis/size12.c]
!28 = metadata !{i32 11, i32 11, metadata !26, null}
!29 = metadata !{i32 6, i32 3, metadata !4, null}
!30 = metadata !{i32 6, i32 3, metadata !31, null}
!31 = metadata !{i32 786443, metadata !1, metadata !4, i32 6, i32 3, i32 1, i32 9} ; [ DW_TAG_lexical_block ] [/liveness_analysis/size12.c]
!32 = metadata !{i32 7, i32 5, metadata !27, null}
!33 = metadata !{i32 8, i32 5, metadata !27, null} ; [ DW_TAG_imported_declaration ]
!34 = metadata !{i32 9, i32 5, metadata !27, null}
!35 = metadata !{i32 9, i32 5, metadata !36, null}
!36 = metadata !{i32 786443, metadata !1, metadata !27, i32 9, i32 5, i32 1, i32 10} ; [ DW_TAG_lexical_block ] [/liveness_analysis/size12.c]
!37 = metadata !{i32 10, i32 7, metadata !26, null}
!38 = metadata !{i32 11, i32 15, metadata !26, null}
!39 = metadata !{i32 12, i32 10, metadata !40, null}
!40 = metadata !{i32 786443, metadata !1, metadata !26, i32 12, i32 10, i32 0, i32 2} ; [ DW_TAG_lexical_block ] [/liveness_analysis/size12.c]
!41 = metadata !{i32 15, i32 7, metadata !42, null}
!42 = metadata !{i32 786443, metadata !1, metadata !40, i32 12, i32 17, i32 0, i32 3} ; [ DW_TAG_lexical_block ] [/liveness_analysis/size12.c]
!43 = metadata !{i32 19, i32 5, metadata !26, null}
!44 = metadata !{i32 20, i32 5, metadata !27, null}
!45 = metadata !{i32 21, i32 3, metadata !27, null}
!46 = metadata !{i32 22, i32 3, metadata !47, null}
!47 = metadata !{i32 786443, metadata !1, metadata !4, i32 22, i32 3, i32 1, i32 11} ; [ DW_TAG_lexical_block ] [/liveness_analysis/size12.c]
!48 = metadata !{i32 23, i32 5, metadata !49, null}
!49 = metadata !{i32 786443, metadata !1, metadata !4, i32 22, i32 16, i32 0, i32 5} ; [ DW_TAG_lexical_block ] [/liveness_analysis/size12.c]
!50 = metadata !{i32 24, i32 13, metadata !49, null}
!51 = metadata !{i32 25, i32 8, metadata !52, null}
!52 = metadata !{i32 786443, metadata !1, metadata !49, i32 25, i32 8, i32 0, i32 6} ; [ DW_TAG_lexical_block ] [/liveness_analysis/size12.c]
!53 = metadata !{i32 26, i32 7, metadata !54, null}
!54 = metadata !{i32 786443, metadata !1, metadata !52, i32 25, i32 15, i32 0, i32 7} ; [ DW_TAG_lexical_block ] [/liveness_analysis/size12.c]
!55 = metadata !{i32 27, i32 5, metadata !54, null}
!56 = metadata !{i32 32, i32 3, metadata !4, null}

