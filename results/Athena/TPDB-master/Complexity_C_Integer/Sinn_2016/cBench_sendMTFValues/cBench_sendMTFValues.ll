; ModuleID = 'cBench_sendMTFValues.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind uwtable
define void @sendMTFValues(i32 %nGroups, i32 %alphaSize) #0 {
sendMTFValues_bb0:
  call void @llvm.dbg.value(metadata !{i32 %nGroups}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !{i32 %alphaSize}, i64 0, metadata !14), !dbg !15
  call void @llvm.dbg.value(metadata !{i32 %nGroups}, i64 0, metadata !16), !dbg !17
  call void @llvm.dbg.value(metadata !18, i64 0, metadata !19), !dbg !20
  call void @llvm.dbg.value(metadata !{i32 %"1"}, i64 0, metadata !21), !dbg !23
  call void @llvm.dbg.value(metadata !{i32 %"6"}, i64 0, metadata !21), !dbg !23
  br label %sendMTFValues_bb1, !dbg !24

sendMTFValues_bb1:                                ; preds = %sendMTFValues_bb6, %sendMTFValues_bb0
  %gs.0 = phi i32 [ 0, %sendMTFValues_bb0 ], [ %"15", %sendMTFValues_bb6 ]
  %nPart.0 = phi i32 [ %nGroups, %sendMTFValues_bb0 ], [ %"14", %sendMTFValues_bb6 ]
  %"0" = icmp sgt i32 %nPart.0, 0, !dbg !25
  br i1 %"0", label %sendMTFValues_bb2, label %sendMTFValues_bb7, !dbg !25

sendMTFValues_bb2:                                ; preds = %sendMTFValues_bb1
  %"1" = sub nsw i32 %gs.0, 1, !dbg !27
  br label %sendMTFValues_bb3, !dbg !28

sendMTFValues_bb3:                                ; preds = %sendMTFValues_bb4, %sendMTFValues_bb2
  %ge.0 = phi i32 [ %"1", %sendMTFValues_bb2 ], [ %"6", %sendMTFValues_bb4 ]
  %"2" = call i32 (...)* @random(), !dbg !29
  %"3" = icmp ne i32 %"2", 0, !dbg !29
  %"4" = sub nsw i32 %alphaSize, 1
  %"5" = icmp slt i32 %ge.0, %"4", !dbg !31
  %or.cond3 = and i1 %"3", %"5", !dbg !29
  br i1 %or.cond3, label %sendMTFValues_bb4, label %sendMTFValues_.critedge, !dbg !29

sendMTFValues_bb4:                                ; preds = %sendMTFValues_bb3
  %"6" = add nsw i32 %ge.0, 1, !dbg !33
  br label %sendMTFValues_bb3, !dbg !35

sendMTFValues_.critedge:                          ; preds = %sendMTFValues_bb3
  %"7" = icmp sgt i32 %ge.0, %gs.0, !dbg !36
  %"8" = icmp ne i32 %nPart.0, %nGroups, !dbg !38
  %or.cond = and i1 %"7", %"8", !dbg !36
  %"9" = icmp ne i32 %nPart.0, 1, !dbg !40
  %or.cond1 = and i1 %or.cond, %"9", !dbg !36
  br i1 %or.cond1, label %sendMTFValues_bb5, label %sendMTFValues_bb6, !dbg !36

sendMTFValues_bb5:                                ; preds = %sendMTFValues_.critedge
  %"10" = sub nsw i32 %nGroups, %nPart.0, !dbg !42
  %"11" = srem i32 %"10", 2, !dbg !42
  %"12" = icmp eq i32 %"11", 1, !dbg !42
  %"13" = add nsw i32 %ge.0, -1, !dbg !44
  call void @llvm.dbg.value(metadata !{i32 %"13"}, i64 0, metadata !21), !dbg !23
  %.ge.0 = select i1 %"12", i32 %"13", i32 %ge.0, !dbg !42
  br label %sendMTFValues_bb6, !dbg !42

sendMTFValues_bb6:                                ; preds = %sendMTFValues_bb5, %sendMTFValues_.critedge
  %ge.1 = phi i32 [ %ge.0, %sendMTFValues_.critedge ], [ %.ge.0, %sendMTFValues_bb5 ]
  %"14" = add nsw i32 %nPart.0, -1, !dbg !46
  call void @llvm.dbg.value(metadata !{i32 %"14"}, i64 0, metadata !16), !dbg !17
  %"15" = add nsw i32 %ge.1, 1, !dbg !47
  call void @llvm.dbg.value(metadata !{i32 %"15"}, i64 0, metadata !19), !dbg !20
  br label %sendMTFValues_bb1, !dbg !48

sendMTFValues_bb7:                                ; preds = %sendMTFValues_bb1
  ret void, !dbg !49
}

; Function Attrs: nounwind readnone
declare void @llvm.dbg.declare(metadata, metadata) #1

declare i32 @random(...) #2

declare i32 @__kittel_nondef.0()

; Function Attrs: nounwind readnone
declare void @llvm.dbg.value(metadata, i64, metadata) #1

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone }
attributes #2 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!9, !10}
!llvm.ident = !{!11}

!0 = metadata !{i32 786449, metadata !1, i32 12, metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)", i1 false, metadata !"", i32 0, metadata !2, metadata !2, metadata !3, metadata !2, metadata !2, metadata !"", i32 1} ; [ DW_TAG_compile_unit ] [/liveness_analysis/cBench_sendMTFValues.c] [DW_LANG_C99]
!1 = metadata !{metadata !"cBench_sendMTFValues.c", metadata !"/liveness_analysis"}
!2 = metadata !{}
!3 = metadata !{metadata !4}
!4 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"sendMTFValues", metadata !"sendMTFValues", metadata !"", i32 6, metadata !6, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (i32, i32)* @sendMTFValues, null, null, metadata !2, i32 6} ; [ DW_TAG_subprogram ] [line 6] [def] [sendMTFValues]
!5 = metadata !{i32 786473, metadata !1}          ; [ DW_TAG_file_type ] [/liveness_analysis/cBench_sendMTFValues.c]
!6 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !7, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!7 = metadata !{null, metadata !8, metadata !8}
!8 = metadata !{i32 786468, null, null, metadata !"int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!9 = metadata !{i32 2, metadata !"Dwarf Version", i32 4}
!10 = metadata !{i32 2, metadata !"Debug Info Version", i32 1}
!11 = metadata !{metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)"}
!12 = metadata !{i32 786689, metadata !4, metadata !"nGroups", metadata !5, i32 16777222, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [nGroups] [line 6]
!13 = metadata !{i32 6, i32 24, metadata !4, null}
!14 = metadata !{i32 786689, metadata !4, metadata !"alphaSize", metadata !5, i32 33554438, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [alphaSize] [line 6]
!15 = metadata !{i32 6, i32 37, metadata !4, null}
!16 = metadata !{i32 786688, metadata !4, metadata !"nPart", metadata !5, i32 7, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [nPart] [line 7]
!17 = metadata !{i32 7, i32 6, metadata !4, null}
!18 = metadata !{i32 0}
!19 = metadata !{i32 786688, metadata !4, metadata !"gs", metadata !5, i32 10, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [gs] [line 10]
!20 = metadata !{i32 10, i32 6, metadata !4, null}
!21 = metadata !{i32 786688, metadata !22, metadata !"ge", metadata !5, i32 13, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [ge] [line 13]
!22 = metadata !{i32 786443, metadata !1, metadata !4, i32 11, i32 20, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_sendMTFValues.c]
!23 = metadata !{i32 13, i32 7, metadata !22, null}
!24 = metadata !{i32 11, i32 2, metadata !4, null}
!25 = metadata !{i32 11, i32 2, metadata !26, null}
!26 = metadata !{i32 786443, metadata !1, metadata !4, i32 11, i32 2, i32 1, i32 4} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_sendMTFValues.c]
!27 = metadata !{i32 13, i32 3, metadata !22, null}
!28 = metadata !{i32 15, i32 3, metadata !22, null}
!29 = metadata !{i32 15, i32 10, metadata !30, null}
!30 = metadata !{i32 786443, metadata !1, metadata !22, i32 15, i32 10, i32 1, i32 5} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_sendMTFValues.c]
!31 = metadata !{i32 15, i32 10, metadata !32, null}
!32 = metadata !{i32 786443, metadata !1, metadata !22, i32 15, i32 10, i32 2, i32 6} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_sendMTFValues.c]
!33 = metadata !{i32 16, i32 4, metadata !34, null}
!34 = metadata !{i32 786443, metadata !1, metadata !22, i32 15, i32 42, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_sendMTFValues.c]
!35 = metadata !{i32 18, i32 3, metadata !34, null}
!36 = metadata !{i32 19, i32 7, metadata !37, null}
!37 = metadata !{i32 786443, metadata !1, metadata !22, i32 19, i32 7, i32 0, i32 2} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_sendMTFValues.c]
!38 = metadata !{i32 19, i32 7, metadata !39, null}
!39 = metadata !{i32 786443, metadata !1, metadata !37, i32 19, i32 7, i32 1, i32 8} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_sendMTFValues.c]
!40 = metadata !{i32 19, i32 7, metadata !41, null}
!41 = metadata !{i32 786443, metadata !1, metadata !37, i32 19, i32 7, i32 2, i32 9} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_sendMTFValues.c]
!42 = metadata !{i32 19, i32 7, metadata !43, null}
!43 = metadata !{i32 786443, metadata !1, metadata !37, i32 19, i32 7, i32 3, i32 10} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_sendMTFValues.c]
!44 = metadata !{i32 22, i32 4, metadata !45, null}
!45 = metadata !{i32 786443, metadata !1, metadata !37, i32 20, i32 38, i32 0, i32 3} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_sendMTFValues.c]
!46 = metadata !{i32 30, i32 3, metadata !22, null}
!47 = metadata !{i32 31, i32 3, metadata !22, null}
!48 = metadata !{i32 33, i32 2, metadata !22, null}
!49 = metadata !{i32 34, i32 1, metadata !4, null}

