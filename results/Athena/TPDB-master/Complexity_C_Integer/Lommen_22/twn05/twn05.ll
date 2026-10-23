; ModuleID = 'twn05.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind uwtable
define i32 @twn05(i32 %a, i32 %b, i32 %c, i32 %d, i32 %e, i32 %f) #0 {
twn05_bb0:
  call void @llvm.dbg.value(metadata !{i32 %a}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !{i32 %b}, i64 0, metadata !14), !dbg !15
  call void @llvm.dbg.value(metadata !{i32 %c}, i64 0, metadata !16), !dbg !17
  call void @llvm.dbg.value(metadata !{i32 %d}, i64 0, metadata !18), !dbg !19
  call void @llvm.dbg.value(metadata !{i32 %e}, i64 0, metadata !20), !dbg !21
  call void @llvm.dbg.value(metadata !{i32 %f}, i64 0, metadata !22), !dbg !23
  %"0" = icmp sgt i32 %f, 0, !dbg !24
  br i1 %"0", label %twn05_bb1, label %twn05_bb7, !dbg !24

twn05_bb1:                                        ; preds = %twn05_bb0, %twn05_bb6
  %.05 = phi i32 [ %"12", %twn05_bb6 ], [ %f, %twn05_bb0 ]
  %.03 = phi i32 [ %.05, %twn05_bb6 ], [ %c, %twn05_bb0 ]
  %"1" = icmp sgt i32 %.05, 0, !dbg !26
  br i1 %"1", label %twn05_bb2, label %twn05_bb7, !dbg !26

twn05_bb2:                                        ; preds = %twn05_bb1, %twn05_bb3
  %.14 = phi i32 [ %"4", %twn05_bb3 ], [ %.03, %twn05_bb1 ]
  %.1 = phi i32 [ %"3", %twn05_bb3 ], [ %d, %twn05_bb1 ]
  %"2" = icmp sgt i32 %.14, 0, !dbg !29
  br i1 %"2", label %twn05_bb3, label %twn05_bb4, !dbg !29

twn05_bb3:                                        ; preds = %twn05_bb2
  %"3" = add nsw i32 %.1, %.14, !dbg !32
  %"4" = sub nsw i32 %.14, 1, !dbg !34
  br label %twn05_bb2, !dbg !35

twn05_bb4:                                        ; preds = %twn05_bb2, %twn05_bb5
  %.12 = phi i32 [ %"11", %twn05_bb5 ], [ %e, %twn05_bb2 ]
  %.2 = phi i32 [ %"10", %twn05_bb5 ], [ %.1, %twn05_bb2 ]
  %"5" = mul nsw i32 %.12, %.12, !dbg !36
  %"6" = icmp slt i32 %.2, %"5", !dbg !36
  %"7" = icmp sgt i32 %.2, 0, !dbg !38
  %. = select i1 %"6", i1 %"7", i1 false, !dbg !36
  br i1 %., label %twn05_bb5, label %twn05_bb6, !dbg !40

twn05_bb5:                                        ; preds = %twn05_bb4
  %"8" = mul nsw i32 5, %.2, !dbg !42
  %"9" = mul nsw i32 %.14, %.14, !dbg !42
  %"10" = add nsw i32 %"8", %"9", !dbg !42
  %"11" = mul nsw i32 2, %.12, !dbg !44
  br label %twn05_bb4, !dbg !45

twn05_bb6:                                        ; preds = %twn05_bb4
  call void @llvm.dbg.value(metadata !{i32 %d}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !{i32 %e}, i64 0, metadata !14), !dbg !15
  call void @llvm.dbg.value(metadata !{i32 %.05}, i64 0, metadata !16), !dbg !17
  %"12" = sub nsw i32 %.05, 1, !dbg !46
  call void @llvm.dbg.value(metadata !{i32 %"12"}, i64 0, metadata !22), !dbg !23
  br label %twn05_bb1, !dbg !47

twn05_bb7:                                        ; preds = %twn05_bb1, %twn05_bb0
  ret i32 0, !dbg !48
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

!0 = metadata !{i32 786449, metadata !1, i32 12, metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)", i1 false, metadata !"", i32 0, metadata !2, metadata !2, metadata !3, metadata !2, metadata !2, metadata !"", i32 1} ; [ DW_TAG_compile_unit ] [/liveness_analysis/twn05.c] [DW_LANG_C99]
!1 = metadata !{metadata !"twn05.c", metadata !"/liveness_analysis"}
!2 = metadata !{}
!3 = metadata !{metadata !4}
!4 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"twn05", metadata !"twn05", metadata !"", i32 1, metadata !6, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, i32 (i32, i32, i32, i32, i32, i32)* @twn05, null, null, metadata !2, i32 1} ; [ DW_TAG_subprogram ] [line 1] [def] [twn05]
!5 = metadata !{i32 786473, metadata !1}          ; [ DW_TAG_file_type ] [/liveness_analysis/twn05.c]
!6 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !7, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!7 = metadata !{metadata !8, metadata !8, metadata !8, metadata !8, metadata !8, metadata !8, metadata !8}
!8 = metadata !{i32 786468, null, null, metadata !"int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!9 = metadata !{i32 2, metadata !"Dwarf Version", i32 4}
!10 = metadata !{i32 2, metadata !"Debug Info Version", i32 1}
!11 = metadata !{metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)"}
!12 = metadata !{i32 786689, metadata !4, metadata !"a", metadata !5, i32 16777217, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [a] [line 1]
!13 = metadata !{i32 1, i32 15, metadata !4, null}
!14 = metadata !{i32 786689, metadata !4, metadata !"b", metadata !5, i32 33554433, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [b] [line 1]
!15 = metadata !{i32 1, i32 22, metadata !4, null}
!16 = metadata !{i32 786689, metadata !4, metadata !"c", metadata !5, i32 50331649, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [c] [line 1]
!17 = metadata !{i32 1, i32 29, metadata !4, null}
!18 = metadata !{i32 786689, metadata !4, metadata !"d", metadata !5, i32 67108865, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [d] [line 1]
!19 = metadata !{i32 1, i32 36, metadata !4, null}
!20 = metadata !{i32 786689, metadata !4, metadata !"e", metadata !5, i32 83886081, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [e] [line 1]
!21 = metadata !{i32 1, i32 43, metadata !4, null}
!22 = metadata !{i32 786689, metadata !4, metadata !"f", metadata !5, i32 100663297, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [f] [line 1]
!23 = metadata !{i32 1, i32 50, metadata !4, null}
!24 = metadata !{i32 2, i32 6, metadata !25, null}
!25 = metadata !{i32 786443, metadata !1, metadata !4, i32 2, i32 6, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/liveness_analysis/twn05.c]
!26 = metadata !{i32 5, i32 5, metadata !27, null}
!27 = metadata !{i32 786443, metadata !1, metadata !28, i32 5, i32 5, i32 1, i32 5} ; [ DW_TAG_lexical_block ] [/liveness_analysis/twn05.c]
!28 = metadata !{i32 786443, metadata !1, metadata !25, i32 2, i32 13, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/liveness_analysis/twn05.c]
!29 = metadata !{i32 6, i32 7, metadata !30, null}
!30 = metadata !{i32 786443, metadata !1, metadata !31, i32 6, i32 7, i32 1, i32 6} ; [ DW_TAG_lexical_block ] [/liveness_analysis/twn05.c]
!31 = metadata !{i32 786443, metadata !1, metadata !28, i32 5, i32 18, i32 0, i32 2} ; [ DW_TAG_lexical_block ] [/liveness_analysis/twn05.c]
!32 = metadata !{i32 7, i32 9, metadata !33, null}
!33 = metadata !{i32 786443, metadata !1, metadata !31, i32 6, i32 20, i32 0, i32 3} ; [ DW_TAG_lexical_block ] [/liveness_analysis/twn05.c]
!34 = metadata !{i32 8, i32 9, metadata !33, null} ; [ DW_TAG_imported_declaration ]
!35 = metadata !{i32 9, i32 7, metadata !33, null}
!36 = metadata !{i32 10, i32 7, metadata !37, null}
!37 = metadata !{i32 786443, metadata !1, metadata !31, i32 10, i32 7, i32 1, i32 7} ; [ DW_TAG_lexical_block ] [/liveness_analysis/twn05.c]
!38 = metadata !{i32 10, i32 7, metadata !39, null}
!39 = metadata !{i32 786443, metadata !1, metadata !31, i32 10, i32 7, i32 2, i32 8} ; [ DW_TAG_lexical_block ] [/liveness_analysis/twn05.c]
!40 = metadata !{i32 10, i32 7, metadata !41, null}
!41 = metadata !{i32 786443, metadata !1, metadata !31, i32 10, i32 7, i32 3, i32 9} ; [ DW_TAG_lexical_block ] [/liveness_analysis/twn05.c]
!42 = metadata !{i32 11, i32 9, metadata !43, null}
!43 = metadata !{i32 786443, metadata !1, metadata !31, i32 10, i32 31, i32 0, i32 4} ; [ DW_TAG_lexical_block ] [/liveness_analysis/twn05.c]
!44 = metadata !{i32 12, i32 9, metadata !43, null}
!45 = metadata !{i32 13, i32 7, metadata !43, null}
!46 = metadata !{i32 17, i32 7, metadata !31, null}
!47 = metadata !{i32 18, i32 5, metadata !31, null}
!48 = metadata !{i32 20, i32 3, metadata !4, null}

