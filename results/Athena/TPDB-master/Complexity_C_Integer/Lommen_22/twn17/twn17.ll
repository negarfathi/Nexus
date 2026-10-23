; ModuleID = 'twn17.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind uwtable
define i32 @twn17(i32 %a, i32 %b, i32 %c, i32 %d, i32 %e) #0 {
twn17_bb0:
  call void @llvm.dbg.value(metadata !{i32 %a}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !{i32 %b}, i64 0, metadata !14), !dbg !15
  call void @llvm.dbg.value(metadata !{i32 %c}, i64 0, metadata !16), !dbg !17
  call void @llvm.dbg.value(metadata !{i32 %d}, i64 0, metadata !18), !dbg !19
  call void @llvm.dbg.value(metadata !{i32 %e}, i64 0, metadata !20), !dbg !21
  call void @llvm.dbg.value(metadata !{i32 %.0}, i64 0, metadata !14), !dbg !15
  call void @llvm.dbg.value(metadata !{i32 %e}, i64 0, metadata !16), !dbg !17
  call void @llvm.dbg.value(metadata !{i32 %"11"}, i64 0, metadata !14), !dbg !15
  call void @llvm.dbg.value(metadata !{i32 %"15"}, i64 0, metadata !16), !dbg !17
  call void @llvm.dbg.value(metadata !{i32 %"30"}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !{i32 %"25"}, i64 0, metadata !14), !dbg !15
  call void @llvm.dbg.value(metadata !{i32 %"29"}, i64 0, metadata !16), !dbg !17
  br label %twn17_bb1, !dbg !22

twn17_bb1:                                        ; preds = %twn17_.critedge, %twn17_bb0
  %.01 = phi i32 [ %b, %twn17_bb0 ], [ %.4, %twn17_.critedge ]
  %.0 = phi i32 [ %a, %twn17_bb0 ], [ %"30", %twn17_.critedge ]
  %"0" = icmp sgt i32 %.0, 0, !dbg !23
  br i1 %"0", label %twn17_bb2, label %twn17_bb10, !dbg !23

twn17_bb2:                                        ; preds = %twn17_bb1
  %"1" = icmp sle i32 -5, %d, !dbg !25
  %"2" = icmp sle i32 %d, 5, !dbg !28
  %or.cond = and i1 %"1", %"2", !dbg !25
  br i1 %or.cond, label %twn17_bb3, label %twn17_bb6, !dbg !25

twn17_bb3:                                        ; preds = %twn17_bb2, %twn17_bb5
  %.02 = phi i32 [ %"15", %twn17_bb5 ], [ %e, %twn17_bb2 ]
  %.1 = phi i32 [ %"11", %twn17_bb5 ], [ %.0, %twn17_bb2 ]
  %"3" = icmp ne i32 %.1, 0, !dbg !30
  br i1 %"3", label %twn17_bb4, label %twn17_.critedge, !dbg !30

twn17_bb4:                                        ; preds = %twn17_bb3
  %"4" = mul nsw i32 %.1, %.1, !dbg !33
  %"5" = mul nsw i32 %d, %d, !dbg !33
  %"6" = mul nsw i32 %"5", %d, !dbg !33
  %"7" = mul nsw i32 %"6", %d, !dbg !33
  %"8" = mul nsw i32 %"7", %d, !dbg !33
  %"9" = add nsw i32 %"4", %"8", !dbg !33
  %"10" = icmp slt i32 %"9", %.02, !dbg !33
  br i1 %"10", label %twn17_bb5, label %twn17_.critedge, !dbg !35

twn17_bb5:                                        ; preds = %twn17_bb4
  %"11" = mul nsw i32 -2, %.1, !dbg !37
  %"12" = mul nsw i32 3, %.02, !dbg !39
  %"13" = mul nsw i32 %d, %d, !dbg !39
  %"14" = mul nsw i32 %"13", %d, !dbg !39
  %"15" = sub nsw i32 %"12", %"14", !dbg !39
  br label %twn17_bb3, !dbg !40

twn17_bb6:                                        ; preds = %twn17_bb2
  %"16" = icmp sgt i32 %d, 0, !dbg !41
  br i1 %"16", label %twn17_bb7, label %twn17_.critedge, !dbg !41

twn17_bb7:                                        ; preds = %twn17_bb6, %twn17_bb9
  %.13 = phi i32 [ %"29", %twn17_bb9 ], [ %e, %twn17_bb6 ]
  %.2 = phi i32 [ %"25", %twn17_bb9 ], [ %.0, %twn17_bb6 ]
  %"17" = icmp ne i32 %.2, 0, !dbg !43
  br i1 %"17", label %twn17_bb8, label %twn17_.critedge, !dbg !43

twn17_bb8:                                        ; preds = %twn17_bb7
  %"18" = mul nsw i32 %.2, %.2, !dbg !46
  %"19" = mul nsw i32 %d, %d, !dbg !46
  %"20" = mul nsw i32 %"19", %d, !dbg !46
  %"21" = mul nsw i32 %"20", %d, !dbg !46
  %"22" = mul nsw i32 %"21", %d, !dbg !46
  %"23" = add nsw i32 %"18", %"22", !dbg !46
  %"24" = icmp slt i32 %"23", %.13, !dbg !46
  br i1 %"24", label %twn17_bb9, label %twn17_.critedge, !dbg !48

twn17_bb9:                                        ; preds = %twn17_bb8
  %"25" = mul nsw i32 -2, %.2, !dbg !50
  %"26" = mul nsw i32 3, %.13, !dbg !52
  %"27" = mul nsw i32 %d, %d, !dbg !52
  %"28" = mul nsw i32 %"27", %d, !dbg !52
  %"29" = sub nsw i32 %"26", %"28", !dbg !52
  br label %twn17_bb7, !dbg !53

twn17_.critedge:                                  ; preds = %twn17_bb6, %twn17_bb7, %twn17_bb8, %twn17_bb4, %twn17_bb3
  %.4 = phi i32 [ %.1, %twn17_bb3 ], [ %.1, %twn17_bb4 ], [ %.0, %twn17_bb6 ], [ %.2, %twn17_bb7 ], [ %.2, %twn17_bb8 ]
  %"30" = sub nsw i32 %.0, 1, !dbg !54
  br label %twn17_bb1, !dbg !55

twn17_bb10:                                       ; preds = %twn17_bb1, %twn17_bb11
  %.5 = phi i32 [ %"32", %twn17_bb11 ], [ %.01, %twn17_bb1 ]
  %"31" = icmp sgt i32 %.5, 0, !dbg !56
  br i1 %"31", label %twn17_bb11, label %twn17_bb12, !dbg !56

twn17_bb11:                                       ; preds = %twn17_bb10
  %"32" = sub nsw i32 %.5, 1, !dbg !58
  br label %twn17_bb10, !dbg !60

twn17_bb12:                                       ; preds = %twn17_bb10
  ret i32 0, !dbg !61
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

!0 = metadata !{i32 786449, metadata !1, i32 12, metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)", i1 false, metadata !"", i32 0, metadata !2, metadata !2, metadata !3, metadata !2, metadata !2, metadata !"", i32 1} ; [ DW_TAG_compile_unit ] [/liveness_analysis/twn17.c] [DW_LANG_C99]
!1 = metadata !{metadata !"twn17.c", metadata !"/liveness_analysis"}
!2 = metadata !{}
!3 = metadata !{metadata !4}
!4 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"twn17", metadata !"twn17", metadata !"", i32 1, metadata !6, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, i32 (i32, i32, i32, i32, i32)* @twn17, null, null, metadata !2, i32 1} ; [ DW_TAG_subprogram ] [line 1] [def] [twn17]
!5 = metadata !{i32 786473, metadata !1}          ; [ DW_TAG_file_type ] [/liveness_analysis/twn17.c]
!6 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !7, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!7 = metadata !{metadata !8, metadata !8, metadata !8, metadata !8, metadata !8, metadata !8}
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
!22 = metadata !{i32 2, i32 3, metadata !4, null}
!23 = metadata !{i32 2, i32 3, metadata !24, null}
!24 = metadata !{i32 786443, metadata !1, metadata !4, i32 2, i32 3, i32 1, i32 8} ; [ DW_TAG_lexical_block ] [/liveness_analysis/twn17.c]
!25 = metadata !{i32 5, i32 8, metadata !26, null}
!26 = metadata !{i32 786443, metadata !1, metadata !27, i32 5, i32 8, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/liveness_analysis/twn17.c]
!27 = metadata !{i32 786443, metadata !1, metadata !4, i32 2, i32 16, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/liveness_analysis/twn17.c]
!28 = metadata !{i32 5, i32 8, metadata !29, null}
!29 = metadata !{i32 786443, metadata !1, metadata !26, i32 5, i32 8, i32 1, i32 9} ; [ DW_TAG_lexical_block ] [/liveness_analysis/twn17.c]
!30 = metadata !{i32 6, i32 7, metadata !31, null}
!31 = metadata !{i32 786443, metadata !1, metadata !32, i32 6, i32 7, i32 1, i32 10} ; [ DW_TAG_lexical_block ] [/liveness_analysis/twn17.c]
!32 = metadata !{i32 786443, metadata !1, metadata !26, i32 5, i32 27, i32 0, i32 2} ; [ DW_TAG_lexical_block ] [/liveness_analysis/twn17.c]
!33 = metadata !{i32 6, i32 7, metadata !34, null}
!34 = metadata !{i32 786443, metadata !1, metadata !32, i32 6, i32 7, i32 2, i32 11} ; [ DW_TAG_lexical_block ] [/liveness_analysis/twn17.c]
!35 = metadata !{i32 6, i32 7, metadata !36, null}
!36 = metadata !{i32 786443, metadata !1, metadata !32, i32 6, i32 7, i32 3, i32 12} ; [ DW_TAG_lexical_block ] [/liveness_analysis/twn17.c]
!37 = metadata !{i32 7, i32 9, metadata !38, null}
!38 = metadata !{i32 786443, metadata !1, metadata !32, i32 6, i32 45, i32 0, i32 3} ; [ DW_TAG_lexical_block ] [/liveness_analysis/twn17.c]
!39 = metadata !{i32 8, i32 9, metadata !38, null} ; [ DW_TAG_imported_declaration ]
!40 = metadata !{i32 9, i32 7, metadata !38, null}
!41 = metadata !{i32 11, i32 14, metadata !42, null}
!42 = metadata !{i32 786443, metadata !1, metadata !26, i32 11, i32 14, i32 0, i32 4} ; [ DW_TAG_lexical_block ] [/liveness_analysis/twn17.c]
!43 = metadata !{i32 12, i32 7, metadata !44, null}
!44 = metadata !{i32 786443, metadata !1, metadata !45, i32 12, i32 7, i32 1, i32 13} ; [ DW_TAG_lexical_block ] [/liveness_analysis/twn17.c]
!45 = metadata !{i32 786443, metadata !1, metadata !42, i32 11, i32 21, i32 0, i32 5} ; [ DW_TAG_lexical_block ] [/liveness_analysis/twn17.c]
!46 = metadata !{i32 12, i32 7, metadata !47, null}
!47 = metadata !{i32 786443, metadata !1, metadata !45, i32 12, i32 7, i32 2, i32 14} ; [ DW_TAG_lexical_block ] [/liveness_analysis/twn17.c]
!48 = metadata !{i32 12, i32 7, metadata !49, null}
!49 = metadata !{i32 786443, metadata !1, metadata !45, i32 12, i32 7, i32 3, i32 15} ; [ DW_TAG_lexical_block ] [/liveness_analysis/twn17.c]
!50 = metadata !{i32 13, i32 9, metadata !51, null}
!51 = metadata !{i32 786443, metadata !1, metadata !45, i32 12, i32 45, i32 0, i32 6} ; [ DW_TAG_lexical_block ] [/liveness_analysis/twn17.c]
!52 = metadata !{i32 14, i32 9, metadata !51, null}
!53 = metadata !{i32 15, i32 7, metadata !51, null}
!54 = metadata !{i32 17, i32 5, metadata !27, null}
!55 = metadata !{i32 18, i32 3, metadata !27, null}
!56 = metadata !{i32 19, i32 3, metadata !57, null}
!57 = metadata !{i32 786443, metadata !1, metadata !4, i32 19, i32 3, i32 1, i32 16} ; [ DW_TAG_lexical_block ] [/liveness_analysis/twn17.c]
!58 = metadata !{i32 20, i32 5, metadata !59, null}
!59 = metadata !{i32 786443, metadata !1, metadata !4, i32 19, i32 16, i32 0, i32 7} ; [ DW_TAG_lexical_block ] [/liveness_analysis/twn17.c]
!60 = metadata !{i32 21, i32 3, metadata !59, null}
!61 = metadata !{i32 22, i32 3, metadata !4, null}

