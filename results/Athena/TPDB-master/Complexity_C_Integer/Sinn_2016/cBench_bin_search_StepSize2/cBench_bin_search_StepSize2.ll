; ModuleID = 'cBench_bin_search_StepSize2.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@"'bin_search_StepSize2.c" = internal global i32 4, align 4

; Function Attrs: nounwind uwtable
define void @bin_search_StepSize2(i32 %r, i32 %s) #0 {
bin_search_StepSize2_bb0:
  call void @llvm.dbg.value(metadata !{i32 %r}, i64 0, metadata !14), !dbg !15
  call void @llvm.dbg.value(metadata !{i32 %s}, i64 0, metadata !16), !dbg !17
  call void @llvm.dbg.value(metadata !18, i64 0, metadata !19), !dbg !20
  call void @llvm.dbg.value(metadata !18, i64 0, metadata !21), !dbg !22
  call void @llvm.dbg.value(metadata !{i32 %"0"}, i64 0, metadata !23), !dbg !24
  call void @llvm.dbg.value(metadata !25, i64 0, metadata !19), !dbg !20
  call void @llvm.dbg.value(metadata !26, i64 0, metadata !21), !dbg !22
  call void @llvm.dbg.value(metadata !{i32 %"12"}, i64 0, metadata !16), !dbg !17
  call void @llvm.dbg.value(metadata !25, i64 0, metadata !19), !dbg !20
  call void @llvm.dbg.value(metadata !25, i64 0, metadata !21), !dbg !22
  call void @llvm.dbg.value(metadata !{i32 %"20"}, i64 0, metadata !16), !dbg !17
  br label %bin_search_StepSize2_bb1, !dbg !27

bin_search_StepSize2_bb1:                         ; preds = %bin_search_StepSize2_bb11, %bin_search_StepSize2_bb7, %bin_search_StepSize2_bb0
  %d.0 = phi i32 [ 0, %bin_search_StepSize2_bb0 ], [ 2, %bin_search_StepSize2_bb7 ], [ 1, %bin_search_StepSize2_bb11 ]
  %f.0 = phi i32 [ 0, %bin_search_StepSize2_bb0 ], [ %f.1, %bin_search_StepSize2_bb7 ], [ %f.2, %bin_search_StepSize2_bb11 ]
  %.0 = phi i32 [ %s, %bin_search_StepSize2_bb0 ], [ %"12", %bin_search_StepSize2_bb7 ], [ %"20", %bin_search_StepSize2_bb11 ]
  %"0" = call i32 (...)* @nondet(), !dbg !28
  %"1" = load i32* @"'bin_search_StepSize2.c", align 4, !dbg !30
  %"2" = icmp eq i32 %"1", 1, !dbg !30
  br i1 %"2", label %bin_search_StepSize2_bb12, label %bin_search_StepSize2_bb2, !dbg !30

bin_search_StepSize2_bb2:                         ; preds = %bin_search_StepSize2_bb1
  %"3" = icmp ne i32 %f.0, 0, !dbg !32
  br i1 %"3", label %bin_search_StepSize2_bb3, label %bin_search_StepSize2_bb4, !dbg !32

bin_search_StepSize2_bb3:                         ; preds = %bin_search_StepSize2_bb2
  %"4" = load i32* @"'bin_search_StepSize2.c", align 4, !dbg !34
  %"5" = sdiv i32 %"4", 2, !dbg !34
  store i32 %"5", i32* @"'bin_search_StepSize2.c", align 4, !dbg !34
  br label %bin_search_StepSize2_bb4, !dbg !34

bin_search_StepSize2_bb4:                         ; preds = %bin_search_StepSize2_bb3, %bin_search_StepSize2_bb2
  %"6" = icmp sgt i32 %"0", %r, !dbg !36
  br i1 %"6", label %bin_search_StepSize2_bb5, label %bin_search_StepSize2_bb8, !dbg !36

bin_search_StepSize2_bb5:                         ; preds = %bin_search_StepSize2_bb4
  %"7" = icmp ne i32 %d.0, 1, !dbg !38
  %"8" = icmp ne i32 %f.0, 0, !dbg !41
  %or.cond = or i1 %"7", %"8", !dbg !38
  br i1 %or.cond, label %bin_search_StepSize2_bb7, label %bin_search_StepSize2_bb6, !dbg !38

bin_search_StepSize2_bb6:                         ; preds = %bin_search_StepSize2_bb5
  %"9" = load i32* @"'bin_search_StepSize2.c", align 4, !dbg !43
  %"10" = sdiv i32 %"9", 2, !dbg !43
  store i32 %"10", i32* @"'bin_search_StepSize2.c", align 4, !dbg !43
  br label %bin_search_StepSize2_bb7, !dbg !45

bin_search_StepSize2_bb7:                         ; preds = %bin_search_StepSize2_bb5, %bin_search_StepSize2_bb6
  %f.1 = phi i32 [ 1, %bin_search_StepSize2_bb6 ], [ %f.0, %bin_search_StepSize2_bb5 ]
  %"11" = load i32* @"'bin_search_StepSize2.c", align 4, !dbg !46
  %"12" = add nsw i32 %.0, %"11", !dbg !46
  %"13" = icmp sgt i32 %"12", 255, !dbg !47
  br i1 %"13", label %bin_search_StepSize2_bb12, label %bin_search_StepSize2_bb1, !dbg !47

bin_search_StepSize2_bb8:                         ; preds = %bin_search_StepSize2_bb4
  %"14" = icmp slt i32 %"0", %r, !dbg !49
  br i1 %"14", label %bin_search_StepSize2_bb9, label %bin_search_StepSize2_bb12, !dbg !49

bin_search_StepSize2_bb9:                         ; preds = %bin_search_StepSize2_bb8
  %"15" = icmp ne i32 %d.0, 2, !dbg !51
  %"16" = icmp ne i32 %f.0, 0, !dbg !54
  %or.cond1 = or i1 %"15", %"16", !dbg !51
  br i1 %or.cond1, label %bin_search_StepSize2_bb11, label %bin_search_StepSize2_bb10, !dbg !51

bin_search_StepSize2_bb10:                        ; preds = %bin_search_StepSize2_bb9
  %"17" = load i32* @"'bin_search_StepSize2.c", align 4, !dbg !56
  %"18" = sdiv i32 %"17", 2, !dbg !56
  store i32 %"18", i32* @"'bin_search_StepSize2.c", align 4, !dbg !56
  br label %bin_search_StepSize2_bb11, !dbg !58

bin_search_StepSize2_bb11:                        ; preds = %bin_search_StepSize2_bb9, %bin_search_StepSize2_bb10
  %f.2 = phi i32 [ 1, %bin_search_StepSize2_bb10 ], [ %f.0, %bin_search_StepSize2_bb9 ]
  %"19" = load i32* @"'bin_search_StepSize2.c", align 4, !dbg !59
  %"20" = sub nsw i32 %.0, %"19", !dbg !59
  %"21" = icmp slt i32 %"20", 0, !dbg !60
  br i1 %"21", label %bin_search_StepSize2_bb12, label %bin_search_StepSize2_bb1, !dbg !60

bin_search_StepSize2_bb12:                        ; preds = %bin_search_StepSize2_bb8, %bin_search_StepSize2_bb11, %bin_search_StepSize2_bb7, %bin_search_StepSize2_bb1
  ret void, !dbg !62
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
!llvm.module.flags = !{!11, !12}
!llvm.ident = !{!13}

!0 = metadata !{i32 786449, metadata !1, i32 12, metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)", i1 false, metadata !"", i32 0, metadata !2, metadata !2, metadata !3, metadata !9, metadata !2, metadata !"", i32 1} ; [ DW_TAG_compile_unit ] [/liveness_analysis/cBench_bin_search_StepSize2.c] [DW_LANG_C99]
!1 = metadata !{metadata !"cBench_bin_search_StepSize2.c", metadata !"/liveness_analysis"}
!2 = metadata !{}
!3 = metadata !{metadata !4}
!4 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"bin_search_StepSize2", metadata !"bin_search_StepSize2", metadata !"", i32 5, metadata !6, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (i32, i32)* @bin_search_StepSize2, null, null, metadata !2, i32 5} ; [ DW_TAG_subprogram ] [line 5] [def] [bin_search_StepSize2]
!5 = metadata !{i32 786473, metadata !1}          ; [ DW_TAG_file_type ] [/liveness_analysis/cBench_bin_search_StepSize2.c]
!6 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !7, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!7 = metadata !{null, metadata !8, metadata !8}
!8 = metadata !{i32 786468, null, null, metadata !"int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!9 = metadata !{metadata !10}
!10 = metadata !{i32 786484, i32 0, metadata !4, metadata !"c", metadata !"c", metadata !"", metadata !5, i32 6, metadata !8, i32 1, i32 1, i32* @"'bin_search_StepSize2.c", null} ; [ DW_TAG_variable ] [c] [line 6] [local] [def]
!11 = metadata !{i32 2, metadata !"Dwarf Version", i32 4}
!12 = metadata !{i32 2, metadata !"Debug Info Version", i32 1}
!13 = metadata !{metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)"}
!14 = metadata !{i32 786689, metadata !4, metadata !"r", metadata !5, i32 16777221, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [r] [line 5]
!15 = metadata !{i32 5, i32 32, metadata !4, null}
!16 = metadata !{i32 786689, metadata !4, metadata !"s", metadata !5, i32 33554437, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [s] [line 5]
!17 = metadata !{i32 5, i32 39, metadata !4, null}
!18 = metadata !{i32 0}
!19 = metadata !{i32 786688, metadata !4, metadata !"f", metadata !5, i32 6, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [f] [line 6]
!20 = metadata !{i32 6, i32 30, metadata !4, null}
!21 = metadata !{i32 786688, metadata !4, metadata !"d", metadata !5, i32 6, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [d] [line 6]
!22 = metadata !{i32 6, i32 41, metadata !4, null}
!23 = metadata !{i32 786688, metadata !4, metadata !"n", metadata !5, i32 6, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [n] [line 6]
!24 = metadata !{i32 6, i32 23, metadata !4, null}
!25 = metadata !{i32 1}
!26 = metadata !{i32 2}
!27 = metadata !{i32 7, i32 1, metadata !4, null}
!28 = metadata !{i32 8, i32 7, metadata !29, null} ; [ DW_TAG_imported_declaration ]
!29 = metadata !{i32 786443, metadata !1, metadata !4, i32 7, i32 4, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_bin_search_StepSize2.c]
!30 = metadata !{i32 9, i32 7, metadata !31, null}
!31 = metadata !{i32 786443, metadata !1, metadata !29, i32 9, i32 7, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_bin_search_StepSize2.c]
!32 = metadata !{i32 10, i32 7, metadata !33, null}
!33 = metadata !{i32 786443, metadata !1, metadata !29, i32 10, i32 7, i32 0, i32 2} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_bin_search_StepSize2.c]
!34 = metadata !{i32 10, i32 10, metadata !35, null}
!35 = metadata !{i32 786443, metadata !1, metadata !33, i32 10, i32 10, i32 1, i32 14} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_bin_search_StepSize2.c]
!36 = metadata !{i32 11, i32 7, metadata !37, null}
!37 = metadata !{i32 786443, metadata !1, metadata !29, i32 11, i32 7, i32 0, i32 3} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_bin_search_StepSize2.c]
!38 = metadata !{i32 12, i32 9, metadata !39, null}
!39 = metadata !{i32 786443, metadata !1, metadata !40, i32 12, i32 9, i32 0, i32 5} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_bin_search_StepSize2.c]
!40 = metadata !{i32 786443, metadata !1, metadata !37, i32 11, i32 14, i32 0, i32 4} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_bin_search_StepSize2.c]
!41 = metadata !{i32 12, i32 9, metadata !42, null}
!42 = metadata !{i32 786443, metadata !1, metadata !39, i32 12, i32 9, i32 1, i32 15} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_bin_search_StepSize2.c]
!43 = metadata !{i32 13, i32 11, metadata !44, null}
!44 = metadata !{i32 786443, metadata !1, metadata !39, i32 12, i32 23, i32 0, i32 6} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_bin_search_StepSize2.c]
!45 = metadata !{i32 14, i32 2, metadata !44, null}
!46 = metadata !{i32 15, i32 12, metadata !40, null}
!47 = metadata !{i32 16, i32 9, metadata !48, null}
!48 = metadata !{i32 786443, metadata !1, metadata !40, i32 16, i32 9, i32 0, i32 7} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_bin_search_StepSize2.c]
!49 = metadata !{i32 18, i32 12, metadata !50, null}
!50 = metadata !{i32 786443, metadata !1, metadata !37, i32 18, i32 12, i32 0, i32 8} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_bin_search_StepSize2.c]
!51 = metadata !{i32 19, i32 9, metadata !52, null}
!52 = metadata !{i32 786443, metadata !1, metadata !53, i32 19, i32 9, i32 0, i32 10} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_bin_search_StepSize2.c]
!53 = metadata !{i32 786443, metadata !1, metadata !50, i32 18, i32 19, i32 0, i32 9} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_bin_search_StepSize2.c]
!54 = metadata !{i32 19, i32 9, metadata !55, null}
!55 = metadata !{i32 786443, metadata !1, metadata !52, i32 19, i32 9, i32 1, i32 17} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_bin_search_StepSize2.c]
!56 = metadata !{i32 20, i32 11, metadata !57, null}
!57 = metadata !{i32 786443, metadata !1, metadata !52, i32 19, i32 23, i32 0, i32 11} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_bin_search_StepSize2.c]
!58 = metadata !{i32 21, i32 2, metadata !57, null}
!59 = metadata !{i32 22, i32 12, metadata !53, null}
!60 = metadata !{i32 23, i32 9, metadata !61, null}
!61 = metadata !{i32 786443, metadata !1, metadata !53, i32 23, i32 9, i32 0, i32 12} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_bin_search_StepSize2.c]
!62 = metadata !{i32 28, i32 1, metadata !4, null}

