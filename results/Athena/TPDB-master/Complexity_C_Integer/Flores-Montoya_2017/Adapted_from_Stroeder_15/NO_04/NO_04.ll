; ModuleID = 'NO_04.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind uwtable
define i32 @foo(i32 %i, i32 %j, i32 %k, i32 %l, i32 %m, i32 %a, i32 %b) #0 {
foo_bb0:
  call void @llvm.dbg.value(metadata !{i32 %i}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !{i32 %j}, i64 0, metadata !14), !dbg !15
  call void @llvm.dbg.value(metadata !{i32 %k}, i64 0, metadata !16), !dbg !17
  call void @llvm.dbg.value(metadata !{i32 %l}, i64 0, metadata !18), !dbg !19
  call void @llvm.dbg.value(metadata !{i32 %m}, i64 0, metadata !20), !dbg !21
  call void @llvm.dbg.value(metadata !{i32 %a}, i64 0, metadata !22), !dbg !23
  call void @llvm.dbg.value(metadata !{i32 %b}, i64 0, metadata !24), !dbg !25
  call void @llvm.dbg.value(metadata !26, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !{i32 %"1"}, i64 0, metadata !22), !dbg !23
  call void @llvm.dbg.value(metadata !26, i64 0, metadata !14), !dbg !15
  call void @llvm.dbg.value(metadata !{i32 %"4"}, i64 0, metadata !16), !dbg !17
  call void @llvm.dbg.value(metadata !{i32 %"8"}, i64 0, metadata !24), !dbg !25
  call void @llvm.dbg.value(metadata !26, i64 0, metadata !18), !dbg !19
  call void @llvm.dbg.value(metadata !{i32 %"13"}, i64 0, metadata !20), !dbg !21
  call void @llvm.dbg.value(metadata !{i32 %"15"}, i64 0, metadata !20), !dbg !21
  br label %foo_bb1, !dbg !27

foo_bb1:                                          ; preds = %foo_bb14, %foo_bb0
  %.0 = phi i32 [ 0, %foo_bb0 ], [ %"19", %foo_bb14 ]
  %"0" = icmp slt i32 %.0, 100, !dbg !28
  br i1 %"0", label %foo_bb2, label %foo_bb15, !dbg !28

foo_bb2:                                          ; preds = %foo_bb1
  %"1" = add nsw i32 %.0, 2, !dbg !30
  br label %foo_bb3, !dbg !32

foo_bb3:                                          ; preds = %foo_bb13, %foo_bb2
  %.01 = phi i32 [ 0, %foo_bb2 ], [ %"18", %foo_bb13 ]
  %"2" = icmp slt i32 %.01, %"1", !dbg !33
  br i1 %"2", label %foo_bb4, label %foo_bb14, !dbg !33

foo_bb4:                                          ; preds = %foo_bb3
  %"3" = add nsw i32 %.0, %.01, !dbg !35
  %"4" = add nsw i32 %"3", 3, !dbg !35
  br label %foo_bb5, !dbg !37

foo_bb5:                                          ; preds = %foo_bb12, %foo_bb4
  %.02 = phi i32 [ %"4", %foo_bb4 ], [ %"17", %foo_bb12 ]
  %"5" = icmp sge i32 %.02, 0, !dbg !38
  br i1 %"5", label %foo_bb6, label %foo_bb13, !dbg !38

foo_bb6:                                          ; preds = %foo_bb5
  %"6" = add nsw i32 %.0, %.01, !dbg !40
  %"7" = add nsw i32 %"6", %.02, !dbg !40
  %"8" = add nsw i32 %"7", 4, !dbg !40
  br label %foo_bb7, !dbg !42

foo_bb7:                                          ; preds = %foo_bb11, %foo_bb6
  %.03 = phi i32 [ 0, %foo_bb6 ], [ %"16", %foo_bb11 ]
  %"9" = icmp slt i32 %.03, %"8", !dbg !43
  br i1 %"9", label %foo_bb8, label %foo_bb12, !dbg !43

foo_bb8:                                          ; preds = %foo_bb7
  %"10" = add nsw i32 %.0, %.01, !dbg !45
  %"11" = add nsw i32 %"10", %.02, !dbg !45
  %"12" = add nsw i32 %"11", %.03, !dbg !45
  %"13" = add nsw i32 %"12", 1000, !dbg !45
  br label %foo_bb9, !dbg !47

foo_bb9:                                          ; preds = %foo_bb10, %foo_bb8
  %.04 = phi i32 [ %"13", %foo_bb8 ], [ %"15", %foo_bb10 ]
  %"14" = icmp sge i32 %.04, 0, !dbg !48
  br i1 %"14", label %foo_bb10, label %foo_bb11, !dbg !48

foo_bb10:                                         ; preds = %foo_bb9
  %"15" = sub nsw i32 %.04, 0, !dbg !50
  br label %foo_bb9, !dbg !52

foo_bb11:                                         ; preds = %foo_bb9
  %"16" = add nsw i32 %.03, 1, !dbg !53
  call void @llvm.dbg.value(metadata !{i32 %"16"}, i64 0, metadata !18), !dbg !19
  br label %foo_bb7, !dbg !54

foo_bb12:                                         ; preds = %foo_bb7
  %"17" = sub nsw i32 %.02, 1, !dbg !55
  call void @llvm.dbg.value(metadata !{i32 %"17"}, i64 0, metadata !16), !dbg !17
  br label %foo_bb5, !dbg !56

foo_bb13:                                         ; preds = %foo_bb5
  %"18" = add nsw i32 %.01, 1, !dbg !57
  call void @llvm.dbg.value(metadata !{i32 %"18"}, i64 0, metadata !14), !dbg !15
  br label %foo_bb3, !dbg !58

foo_bb14:                                         ; preds = %foo_bb3
  %"19" = add nsw i32 %.0, 1, !dbg !59
  call void @llvm.dbg.value(metadata !{i32 %"19"}, i64 0, metadata !12), !dbg !13
  br label %foo_bb1, !dbg !60

foo_bb15:                                         ; preds = %foo_bb1
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

!0 = metadata !{i32 786449, metadata !1, i32 12, metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)", i1 false, metadata !"", i32 0, metadata !2, metadata !2, metadata !3, metadata !2, metadata !2, metadata !"", i32 1} ; [ DW_TAG_compile_unit ] [/liveness_analysis/NO_04.c] [DW_LANG_C99]
!1 = metadata !{metadata !"NO_04.c", metadata !"/liveness_analysis"}
!2 = metadata !{}
!3 = metadata !{metadata !4}
!4 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"foo", metadata !"foo", metadata !"", i32 3, metadata !6, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, i32 (i32, i32, i32, i32, i32, i32, i32)* @foo, null, null, metadata !2, i32 3} ; [ DW_TAG_subprogram ] [line 3] [def] [foo]
!5 = metadata !{i32 786473, metadata !1}          ; [ DW_TAG_file_type ] [/liveness_analysis/NO_04.c]
!6 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !7, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!7 = metadata !{metadata !8, metadata !8, metadata !8, metadata !8, metadata !8, metadata !8, metadata !8, metadata !8}
!8 = metadata !{i32 786468, null, null, metadata !"int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!9 = metadata !{i32 2, metadata !"Dwarf Version", i32 4}
!10 = metadata !{i32 2, metadata !"Debug Info Version", i32 1}
!11 = metadata !{metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)"}
!12 = metadata !{i32 786689, metadata !4, metadata !"i", metadata !5, i32 16777219, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [i] [line 3]
!13 = metadata !{i32 3, i32 13, metadata !4, null}
!14 = metadata !{i32 786689, metadata !4, metadata !"j", metadata !5, i32 33554435, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [j] [line 3]
!15 = metadata !{i32 3, i32 19, metadata !4, null}
!16 = metadata !{i32 786689, metadata !4, metadata !"k", metadata !5, i32 50331651, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [k] [line 3]
!17 = metadata !{i32 3, i32 25, metadata !4, null}
!18 = metadata !{i32 786689, metadata !4, metadata !"l", metadata !5, i32 67108867, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [l] [line 3]
!19 = metadata !{i32 3, i32 31, metadata !4, null}
!20 = metadata !{i32 786689, metadata !4, metadata !"m", metadata !5, i32 83886083, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [m] [line 3]
!21 = metadata !{i32 3, i32 37, metadata !4, null}
!22 = metadata !{i32 786689, metadata !4, metadata !"a", metadata !5, i32 100663299, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [a] [line 3]
!23 = metadata !{i32 3, i32 43, metadata !4, null}
!24 = metadata !{i32 786689, metadata !4, metadata !"b", metadata !5, i32 117440515, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [b] [line 3]
!25 = metadata !{i32 3, i32 49, metadata !4, null}
!26 = metadata !{i32 0}
!27 = metadata !{i32 5, i32 1, metadata !4, null}
!28 = metadata !{i32 5, i32 1, metadata !29, null}
!29 = metadata !{i32 786443, metadata !1, metadata !4, i32 5, i32 1, i32 1, i32 5} ; [ DW_TAG_lexical_block ] [/liveness_analysis/NO_04.c]
!30 = metadata !{i32 6, i32 9, metadata !31, null}
!31 = metadata !{i32 786443, metadata !1, metadata !4, i32 5, i32 17, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/liveness_analysis/NO_04.c]
!32 = metadata !{i32 8, i32 9, metadata !31, null} ; [ DW_TAG_imported_declaration ]
!33 = metadata !{i32 8, i32 9, metadata !34, null} ; [ DW_TAG_imported_declaration ]
!34 = metadata !{i32 786443, metadata !1, metadata !31, i32 8, i32 9, i32 1, i32 6} ; [ DW_TAG_lexical_block ] [/liveness_analysis/NO_04.c]
!35 = metadata !{i32 9, i32 13, metadata !36, null}
!36 = metadata !{i32 786443, metadata !1, metadata !31, i32 8, i32 23, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/liveness_analysis/NO_04.c]
!37 = metadata !{i32 10, i32 13, metadata !36, null}
!38 = metadata !{i32 10, i32 13, metadata !39, null}
!39 = metadata !{i32 786443, metadata !1, metadata !36, i32 10, i32 13, i32 1, i32 7} ; [ DW_TAG_lexical_block ] [/liveness_analysis/NO_04.c]
!40 = metadata !{i32 11, i32 17, metadata !41, null}
!41 = metadata !{i32 786443, metadata !1, metadata !36, i32 10, i32 28, i32 0, i32 2} ; [ DW_TAG_lexical_block ] [/liveness_analysis/NO_04.c]
!42 = metadata !{i32 13, i32 17, metadata !41, null}
!43 = metadata !{i32 13, i32 17, metadata !44, null}
!44 = metadata !{i32 786443, metadata !1, metadata !41, i32 13, i32 17, i32 1, i32 8} ; [ DW_TAG_lexical_block ] [/liveness_analysis/NO_04.c]
!45 = metadata !{i32 14, i32 21, metadata !46, null}
!46 = metadata !{i32 786443, metadata !1, metadata !41, i32 13, i32 31, i32 0, i32 3} ; [ DW_TAG_lexical_block ] [/liveness_analysis/NO_04.c]
!47 = metadata !{i32 15, i32 21, metadata !46, null}
!48 = metadata !{i32 15, i32 21, metadata !49, null}
!49 = metadata !{i32 786443, metadata !1, metadata !46, i32 15, i32 21, i32 1, i32 9} ; [ DW_TAG_lexical_block ] [/liveness_analysis/NO_04.c]
!50 = metadata !{i32 16, i32 25, metadata !51, null}
!51 = metadata !{i32 786443, metadata !1, metadata !46, i32 15, i32 36, i32 0, i32 4} ; [ DW_TAG_lexical_block ] [/liveness_analysis/NO_04.c]
!52 = metadata !{i32 17, i32 21, metadata !51, null}
!53 = metadata !{i32 18, i32 21, metadata !46, null}
!54 = metadata !{i32 19, i32 17, metadata !46, null}
!55 = metadata !{i32 20, i32 17, metadata !41, null}
!56 = metadata !{i32 21, i32 13, metadata !41, null}
!57 = metadata !{i32 22, i32 13, metadata !36, null}
!58 = metadata !{i32 23, i32 9, metadata !36, null}
!59 = metadata !{i32 24, i32 9, metadata !31, null}
!60 = metadata !{i32 25, i32 5, metadata !31, null}
!61 = metadata !{i32 26, i32 1, metadata !4, null}

