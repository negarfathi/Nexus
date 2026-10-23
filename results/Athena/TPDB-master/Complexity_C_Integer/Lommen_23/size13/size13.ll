; ModuleID = 'size13.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind uwtable
define i32 @size13(i32 %a, i32 %b, i32 %c, i32 %d) #0 {
size13_bb0:
  call void @llvm.dbg.value(metadata !{i32 %a}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !{i32 %b}, i64 0, metadata !14), !dbg !15
  call void @llvm.dbg.value(metadata !{i32 %c}, i64 0, metadata !16), !dbg !17
  call void @llvm.dbg.value(metadata !{i32 %d}, i64 0, metadata !18), !dbg !19
  call void @llvm.dbg.value(metadata !{i32 %a}, i64 0, metadata !20), !dbg !21
  call void @llvm.dbg.value(metadata !22, i64 0, metadata !23), !dbg !24
  call void @llvm.dbg.value(metadata !22, i64 0, metadata !25), !dbg !26
  call void @llvm.dbg.value(metadata !{i32 %"1"}, i64 0, metadata !20), !dbg !21
  call void @llvm.dbg.value(metadata !{i32 %"2"}, i64 0, metadata !23), !dbg !24
  call void @llvm.dbg.value(metadata !{i32 %"4"}, i64 0, metadata !25), !dbg !26
  call void @llvm.dbg.value(metadata !{i32 %"6"}, i64 0, metadata !23), !dbg !24
  call void @llvm.dbg.value(metadata !{i32 %a}, i64 0, metadata !16), !dbg !17
  call void @llvm.dbg.value(metadata !{i32 %.03}, i64 0, metadata !14), !dbg !15
  br label %size13_bb1, !dbg !27

size13_bb1:                                       ; preds = %size13_bb3, %size13_bb0
  %t3.0 = phi i32 [ 0, %size13_bb0 ], [ %"4", %size13_bb3 ]
  %t1.0 = phi i32 [ %a, %size13_bb0 ], [ %"1", %size13_bb3 ]
  %.03 = phi i32 [ %d, %size13_bb0 ], [ %.1, %size13_bb3 ]
  %.01 = phi i32 [ %c, %size13_bb0 ], [ %.12, %size13_bb3 ]
  %.0 = phi i32 [ %b, %size13_bb0 ], [ %.1, %size13_bb3 ]
  %"0" = icmp sgt i32 %t1.0, 0, !dbg !28
  br i1 %"0", label %size13_bb2, label %size13_bb5, !dbg !28

size13_bb2:                                       ; preds = %size13_bb1
  %"1" = sub nsw i32 %t1.0, 1, !dbg !30
  %"2" = add nsw i32 %.0, %.01, !dbg !32
  %"3" = mul nsw i32 %"1", %"1", !dbg !33
  %"4" = add nsw i32 %t3.0, %"3", !dbg !33
  br label %size13_bb3, !dbg !34

size13_bb3:                                       ; preds = %size13_bb4, %size13_bb2
  %t2.0 = phi i32 [ %"2", %size13_bb2 ], [ %"6", %size13_bb4 ]
  %.12 = phi i32 [ %.01, %size13_bb2 ], [ %a, %size13_bb4 ]
  %.1 = phi i32 [ %.0, %size13_bb2 ], [ %.03, %size13_bb4 ]
  %"5" = icmp sgt i32 %t2.0, 0, !dbg !35
  br i1 %"5", label %size13_bb4, label %size13_bb1, !dbg !35

size13_bb4:                                       ; preds = %size13_bb3
  %"6" = sub nsw i32 %t2.0, 1, !dbg !37
  br label %size13_bb3, !dbg !39

size13_bb5:                                       ; preds = %size13_bb1, %size13_bb6
  %t3.1 = phi i32 [ %"8", %size13_bb6 ], [ %t3.0, %size13_bb1 ]
  %"7" = icmp sgt i32 %t3.1, 0, !dbg !40
  br i1 %"7", label %size13_bb6, label %size13_bb7, !dbg !40

size13_bb6:                                       ; preds = %size13_bb5
  %"8" = sub nsw i32 %t3.1, 1, !dbg !42
  br label %size13_bb5, !dbg !44

size13_bb7:                                       ; preds = %size13_bb5
  ret i32 0, !dbg !45
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

!0 = metadata !{i32 786449, metadata !1, i32 12, metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)", i1 false, metadata !"", i32 0, metadata !2, metadata !2, metadata !3, metadata !2, metadata !2, metadata !"", i32 1} ; [ DW_TAG_compile_unit ] [/liveness_analysis/size13.c] [DW_LANG_C99]
!1 = metadata !{metadata !"size13.c", metadata !"/liveness_analysis"}
!2 = metadata !{}
!3 = metadata !{metadata !4}
!4 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"size13", metadata !"size13", metadata !"", i32 1, metadata !6, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, i32 (i32, i32, i32, i32)* @size13, null, null, metadata !2, i32 1} ; [ DW_TAG_subprogram ] [line 1] [def] [size13]
!5 = metadata !{i32 786473, metadata !1}          ; [ DW_TAG_file_type ] [/liveness_analysis/size13.c]
!6 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !7, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!7 = metadata !{metadata !8, metadata !8, metadata !8, metadata !8, metadata !8}
!8 = metadata !{i32 786468, null, null, metadata !"int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!9 = metadata !{i32 2, metadata !"Dwarf Version", i32 4}
!10 = metadata !{i32 2, metadata !"Debug Info Version", i32 1}
!11 = metadata !{metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)"}
!12 = metadata !{i32 786689, metadata !4, metadata !"a", metadata !5, i32 16777217, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [a] [line 1]
!13 = metadata !{i32 1, i32 16, metadata !4, null}
!14 = metadata !{i32 786689, metadata !4, metadata !"b", metadata !5, i32 33554433, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [b] [line 1]
!15 = metadata !{i32 1, i32 23, metadata !4, null}
!16 = metadata !{i32 786689, metadata !4, metadata !"c", metadata !5, i32 50331649, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [c] [line 1]
!17 = metadata !{i32 1, i32 30, metadata !4, null}
!18 = metadata !{i32 786689, metadata !4, metadata !"d", metadata !5, i32 67108865, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [d] [line 1]
!19 = metadata !{i32 1, i32 37, metadata !4, null}
!20 = metadata !{i32 786688, metadata !4, metadata !"t1", metadata !5, i32 2, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [t1] [line 2]
!21 = metadata !{i32 2, i32 7, metadata !4, null}
!22 = metadata !{i32 0}
!23 = metadata !{i32 786688, metadata !4, metadata !"t2", metadata !5, i32 3, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [t2] [line 3]
!24 = metadata !{i32 3, i32 7, metadata !4, null}
!25 = metadata !{i32 786688, metadata !4, metadata !"t3", metadata !5, i32 4, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [t3] [line 4]
!26 = metadata !{i32 4, i32 7, metadata !4, null}
!27 = metadata !{i32 5, i32 3, metadata !4, null}
!28 = metadata !{i32 5, i32 3, metadata !29, null}
!29 = metadata !{i32 786443, metadata !1, metadata !4, i32 5, i32 3, i32 1, i32 3} ; [ DW_TAG_lexical_block ] [/liveness_analysis/size13.c]
!30 = metadata !{i32 6, i32 5, metadata !31, null}
!31 = metadata !{i32 786443, metadata !1, metadata !4, i32 5, i32 17, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/liveness_analysis/size13.c]
!32 = metadata !{i32 7, i32 5, metadata !31, null}
!33 = metadata !{i32 8, i32 5, metadata !31, null} ; [ DW_TAG_imported_declaration ]
!34 = metadata !{i32 9, i32 5, metadata !31, null}
!35 = metadata !{i32 9, i32 5, metadata !36, null}
!36 = metadata !{i32 786443, metadata !1, metadata !31, i32 9, i32 5, i32 1, i32 4} ; [ DW_TAG_lexical_block ] [/liveness_analysis/size13.c]
!37 = metadata !{i32 10, i32 7, metadata !38, null}
!38 = metadata !{i32 786443, metadata !1, metadata !31, i32 9, i32 19, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/liveness_analysis/size13.c]
!39 = metadata !{i32 13, i32 5, metadata !38, null}
!40 = metadata !{i32 16, i32 3, metadata !41, null}
!41 = metadata !{i32 786443, metadata !1, metadata !4, i32 16, i32 3, i32 1, i32 5} ; [ DW_TAG_lexical_block ] [/liveness_analysis/size13.c]
!42 = metadata !{i32 17, i32 5, metadata !43, null}
!43 = metadata !{i32 786443, metadata !1, metadata !4, i32 16, i32 17, i32 0, i32 2} ; [ DW_TAG_lexical_block ] [/liveness_analysis/size13.c]
!44 = metadata !{i32 18, i32 3, metadata !43, null}
!45 = metadata !{i32 19, i32 3, metadata !4, null}

