; ModuleID = 'cBench_PackBitsEncode.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind uwtable
define void @PackBitsEncode(i32 %cc) #0 {
PackBitsEncode_bb0:
  call void @llvm.dbg.value(metadata !{i32 %cc}, i64 0, metadata !19), !dbg !20
  call void @llvm.dbg.value(metadata !21, i64 0, metadata !22), !dbg !23
  call void @llvm.dbg.value(metadata !{i32 %"1"}, i64 0, metadata !19), !dbg !20
  call void @llvm.dbg.value(metadata !24, i64 0, metadata !25), !dbg !27
  call void @llvm.dbg.value(metadata !{i64 %"5"}, i64 0, metadata !25), !dbg !27
  br label %PackBitsEncode_bb1, !dbg !28

PackBitsEncode_bb1:                               ; preds = %PackBitsEncode_NewDefault, %PackBitsEncode_bb5, %PackBitsEncode_bb6, %PackBitsEncode_bb9, %PackBitsEncode_bb10, %PackBitsEncode_bb11, %PackBitsEncode_bb12, %PackBitsEncode_bb0
  %state.0 = phi i32 [ 0, %PackBitsEncode_bb0 ], [ %state.1, %PackBitsEncode_NewDefault ], [ 2, %PackBitsEncode_bb6 ], [ 1, %PackBitsEncode_bb5 ], [ %.state.1, %PackBitsEncode_bb10 ], [ 3, %PackBitsEncode_bb9 ], [ %state.1, %PackBitsEncode_bb12 ], [ 1, %PackBitsEncode_bb11 ]
  %.0 = phi i32 [ %cc, %PackBitsEncode_bb0 ], [ %"1", %PackBitsEncode_bb12 ], [ %"1", %PackBitsEncode_bb11 ], [ %"1", %PackBitsEncode_bb10 ], [ %"1", %PackBitsEncode_bb9 ], [ %"1", %PackBitsEncode_bb6 ], [ %"1", %PackBitsEncode_bb5 ], [ %"1", %PackBitsEncode_NewDefault ]
  %"0" = icmp sgt i32 %.0, 0, !dbg !29
  br i1 %"0", label %PackBitsEncode_bb2, label %PackBitsEncode_bb16, !dbg !29

PackBitsEncode_bb2:                               ; preds = %PackBitsEncode_bb1, %PackBitsEncode_bb4
  %.0.sink = phi i32 [ %"1", %PackBitsEncode_bb4 ], [ %.0, %PackBitsEncode_bb1 ]
  %n.0 = phi i64 [ %"5", %PackBitsEncode_bb4 ], [ 1, %PackBitsEncode_bb1 ]
  %"1" = add nsw i32 %.0.sink, -1, !dbg !31
  %"2" = icmp sgt i32 %"1", 0, !dbg !33
  br i1 %"2", label %PackBitsEncode_bb3, label %PackBitsEncode_.critedge, !dbg !33

PackBitsEncode_bb3:                               ; preds = %PackBitsEncode_bb2
  %"3" = call i32 (...)* @random(), !dbg !37
  %"4" = icmp ne i32 %"3", 0, !dbg !37
  br i1 %"4", label %PackBitsEncode_bb4, label %PackBitsEncode_.critedge, !dbg !39

PackBitsEncode_bb4:                               ; preds = %PackBitsEncode_bb3
  %"5" = add nsw i64 %n.0, 1, !dbg !41
  br label %PackBitsEncode_bb2, !dbg !42

PackBitsEncode_.critedge:                         ; preds = %PackBitsEncode_bb15, %PackBitsEncode_bb14, %PackBitsEncode_bb9, %PackBitsEncode_bb3, %PackBitsEncode_bb2, %PackBitsEncode_bb13, %PackBitsEncode_bb7
  %state.1 = phi i32 [ %state.1, %PackBitsEncode_bb13 ], [ 2, %PackBitsEncode_bb7 ], [ %state.0, %PackBitsEncode_bb2 ], [ %state.0, %PackBitsEncode_bb3 ], [ 3, %PackBitsEncode_bb9 ], [ %., %PackBitsEncode_bb15 ], [ 0, %PackBitsEncode_bb14 ]
  %n.1 = phi i64 [ %"15", %PackBitsEncode_bb13 ], [ %"8", %PackBitsEncode_bb7 ], [ %n.0, %PackBitsEncode_bb2 ], [ %n.0, %PackBitsEncode_bb3 ], [ %n.1, %PackBitsEncode_bb9 ], [ %n.1, %PackBitsEncode_bb14 ], [ %n.1, %PackBitsEncode_bb15 ]
  br label %PackBitsEncode_NodeBlock5

PackBitsEncode_NodeBlock5:                        ; preds = %PackBitsEncode_.critedge
  %Pivot6 = icmp slt i32 %state.1, 2
  br i1 %Pivot6, label %PackBitsEncode_NodeBlock, label %PackBitsEncode_NodeBlock3

PackBitsEncode_NodeBlock:                         ; preds = %PackBitsEncode_NodeBlock5
  %Pivot = icmp slt i32 %state.1, 1
  br i1 %Pivot, label %PackBitsEncode_LeafBlock, label %PackBitsEncode_bb8

PackBitsEncode_LeafBlock:                         ; preds = %PackBitsEncode_NodeBlock
  %SwitchLeaf = icmp eq i32 %state.1, 0
  br i1 %SwitchLeaf, label %PackBitsEncode_bb5, label %PackBitsEncode_NewDefault

PackBitsEncode_bb5:                               ; preds = %PackBitsEncode_LeafBlock
  %"6" = icmp sgt i64 %n.1, 1, !dbg !43
  br i1 %"6", label %PackBitsEncode_bb6, label %PackBitsEncode_bb1, !dbg !43

PackBitsEncode_bb6:                               ; preds = %PackBitsEncode_bb5
  %"7" = icmp sgt i64 %n.1, 128, !dbg !46
  br i1 %"7", label %PackBitsEncode_bb7, label %PackBitsEncode_bb1, !dbg !46

PackBitsEncode_bb7:                               ; preds = %PackBitsEncode_bb6
  %"8" = sub nsw i64 %n.1, 128, !dbg !49
  br label %PackBitsEncode_.critedge, !dbg !51

PackBitsEncode_bb8:                               ; preds = %PackBitsEncode_NodeBlock
  %"9" = icmp sgt i64 %n.1, 1, !dbg !52
  br i1 %"9", label %PackBitsEncode_bb9, label %PackBitsEncode_bb10, !dbg !52

PackBitsEncode_bb9:                               ; preds = %PackBitsEncode_bb8
  %"10" = icmp sgt i64 %n.1, 128, !dbg !54
  br i1 %"10", label %PackBitsEncode_.critedge, label %PackBitsEncode_bb1, !dbg !54

PackBitsEncode_bb10:                              ; preds = %PackBitsEncode_bb8
  %"11" = call i32 (...)* @random(), !dbg !57
  %"12" = icmp ne i32 %"11", 0, !dbg !57
  call void @llvm.dbg.value(metadata !21, i64 0, metadata !22), !dbg !23
  %.state.1 = select i1 %"12", i32 0, i32 %state.1, !dbg !57
  br label %PackBitsEncode_bb1

PackBitsEncode_NodeBlock3:                        ; preds = %PackBitsEncode_NodeBlock5
  %Pivot4 = icmp slt i32 %state.1, 3
  br i1 %Pivot4, label %PackBitsEncode_bb11, label %PackBitsEncode_LeafBlock1

PackBitsEncode_bb11:                              ; preds = %PackBitsEncode_NodeBlock3
  %"13" = icmp sgt i64 %n.1, 1, !dbg !60
  br i1 %"13", label %PackBitsEncode_bb12, label %PackBitsEncode_bb1, !dbg !60

PackBitsEncode_bb12:                              ; preds = %PackBitsEncode_bb11
  %"14" = icmp sgt i64 %n.1, 128, !dbg !62
  br i1 %"14", label %PackBitsEncode_bb13, label %PackBitsEncode_bb1, !dbg !62

PackBitsEncode_bb13:                              ; preds = %PackBitsEncode_bb12
  %"15" = sub nsw i64 %n.1, 128, !dbg !65
  br label %PackBitsEncode_.critedge, !dbg !67

PackBitsEncode_LeafBlock1:                        ; preds = %PackBitsEncode_NodeBlock3
  %SwitchLeaf2 = icmp eq i32 %state.1, 3
  br i1 %SwitchLeaf2, label %PackBitsEncode_bb14, label %PackBitsEncode_NewDefault

PackBitsEncode_bb14:                              ; preds = %PackBitsEncode_LeafBlock1
  %"16" = call i32 (...)* @random(), !dbg !68
  %"17" = icmp ne i32 %"16", 0, !dbg !68
  br i1 %"17", label %PackBitsEncode_.critedge, label %PackBitsEncode_bb15, !dbg !68

PackBitsEncode_bb15:                              ; preds = %PackBitsEncode_bb14
  %"18" = call i32 (...)* @random(), !dbg !70
  %"19" = icmp ne i32 %"18", 0, !dbg !70
  %. = select i1 %"19", i32 1, i32 2, !dbg !72
  br label %PackBitsEncode_.critedge

PackBitsEncode_NewDefault:                        ; preds = %PackBitsEncode_LeafBlock1, %PackBitsEncode_LeafBlock
  br label %PackBitsEncode_bb1

PackBitsEncode_bb16:                              ; preds = %PackBitsEncode_bb1
  ret void, !dbg !73
}

; Function Attrs: nounwind readnone
declare void @llvm.dbg.declare(metadata, metadata) #1

declare i32 @random(...) #2

declare i32 @__kittel_nondef.0()

declare i64 @__kittel_nondef.1()

; Function Attrs: nounwind readnone
declare void @llvm.dbg.value(metadata, i64, metadata) #1

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone }
attributes #2 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!16, !17}
!llvm.ident = !{!18}

!0 = metadata !{i32 786449, metadata !1, i32 12, metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)", i1 false, metadata !"", i32 0, metadata !2, metadata !9, metadata !15, metadata !9, metadata !9, metadata !"", i32 1} ; [ DW_TAG_compile_unit ] [/liveness_analysis/cBench_PackBitsEncode.c] [DW_LANG_C99]
!1 = metadata !{metadata !"cBench_PackBitsEncode.c", metadata !"/liveness_analysis"}
!2 = metadata !{metadata !3}
!3 = metadata !{i32 786436, metadata !1, metadata !4, metadata !"", i32 12, i64 32, i64 32, i32 0, i32 0, null, metadata !10, i32 0, null, null, null} ; [ DW_TAG_enumeration_type ] [line 12, size 32, align 32, offset 0] [def] [from ]
!4 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"PackBitsEncode", metadata !"PackBitsEncode", metadata !"", i32 6, metadata !6, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (i32)* @PackBitsEncode, null, null, metadata !9, i32 7} ; [ DW_TAG_subprogram ] [line 6] [def] [scope 7] [PackBitsEncode]
!5 = metadata !{i32 786473, metadata !1}          ; [ DW_TAG_file_type ] [/liveness_analysis/cBench_PackBitsEncode.c]
!6 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !7, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!7 = metadata !{null, metadata !8}
!8 = metadata !{i32 786468, null, null, metadata !"int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!9 = metadata !{}
!10 = metadata !{metadata !11, metadata !12, metadata !13, metadata !14}
!11 = metadata !{i32 786472, metadata !"BASE", i64 0} ; [ DW_TAG_enumerator ] [BASE :: 0]
!12 = metadata !{i32 786472, metadata !"LITERAL", i64 1} ; [ DW_TAG_enumerator ] [LITERAL :: 1]
!13 = metadata !{i32 786472, metadata !"RUN", i64 2} ; [ DW_TAG_enumerator ] [RUN :: 2]
!14 = metadata !{i32 786472, metadata !"LITERAL_RUN", i64 3} ; [ DW_TAG_enumerator ] [LITERAL_RUN :: 3]
!15 = metadata !{metadata !4}
!16 = metadata !{i32 2, metadata !"Dwarf Version", i32 4}
!17 = metadata !{i32 2, metadata !"Debug Info Version", i32 1}
!18 = metadata !{metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)"}
!19 = metadata !{i32 786689, metadata !4, metadata !"cc", metadata !5, i32 16777222, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [cc] [line 6]
!20 = metadata !{i32 6, i32 25, metadata !4, null}
!21 = metadata !{i32 0}
!22 = metadata !{i32 786688, metadata !4, metadata !"state", metadata !5, i32 12, metadata !3, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [state] [line 12]
!23 = metadata !{i32 12, i32 46, metadata !4, null}
!24 = metadata !{i64 1}
!25 = metadata !{i32 786688, metadata !4, metadata !"n", metadata !5, i32 10, metadata !26, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [n] [line 10]
!26 = metadata !{i32 786468, null, null, metadata !"long int", i32 0, i64 64, i64 64, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [long int] [line 0, size 64, align 64, offset 0, enc DW_ATE_signed]
!27 = metadata !{i32 10, i32 10, metadata !4, null}
!28 = metadata !{i32 18, i32 5, metadata !4, null}
!29 = metadata !{i32 18, i32 5, metadata !30, null}
!30 = metadata !{i32 786443, metadata !1, metadata !4, i32 18, i32 5, i32 1, i32 21} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_PackBitsEncode.c]
!31 = metadata !{i32 20, i32 2, metadata !32, null}
!32 = metadata !{i32 786443, metadata !1, metadata !4, i32 18, i32 20, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_PackBitsEncode.c]
!33 = metadata !{i32 21, i32 2, metadata !34, null}
!34 = metadata !{i32 786443, metadata !1, metadata !35, i32 21, i32 2, i32 4, i32 25} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_PackBitsEncode.c]
!35 = metadata !{i32 786443, metadata !1, metadata !36, i32 21, i32 2, i32 1, i32 22} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_PackBitsEncode.c]
!36 = metadata !{i32 786443, metadata !1, metadata !32, i32 21, i32 2, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_PackBitsEncode.c]
!37 = metadata !{i32 21, i32 19, metadata !38, null}
!38 = metadata !{i32 786443, metadata !1, metadata !36, i32 21, i32 19, i32 2, i32 23} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_PackBitsEncode.c]
!39 = metadata !{i32 21, i32 19, metadata !40, null}
!40 = metadata !{i32 786443, metadata !1, metadata !36, i32 21, i32 19, i32 3, i32 24} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_PackBitsEncode.c]
!41 = metadata !{i32 22, i32 6, metadata !36, null}
!42 = metadata !{i32 21, i32 29, metadata !36, null}
!43 = metadata !{i32 42, i32 10, metadata !44, null}
!44 = metadata !{i32 786443, metadata !1, metadata !45, i32 42, i32 10, i32 0, i32 3} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_PackBitsEncode.c]
!45 = metadata !{i32 786443, metadata !1, metadata !32, i32 40, i32 17, i32 0, i32 2} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_PackBitsEncode.c]
!46 = metadata !{i32 44, i32 7, metadata !47, null}
!47 = metadata !{i32 786443, metadata !1, metadata !48, i32 44, i32 7, i32 0, i32 5} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_PackBitsEncode.c]
!48 = metadata !{i32 786443, metadata !1, metadata !44, i32 42, i32 17, i32 0, i32 4} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_PackBitsEncode.c]
!49 = metadata !{i32 47, i32 7, metadata !50, null}
!50 = metadata !{i32 786443, metadata !1, metadata !47, i32 44, i32 16, i32 0, i32 6} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_PackBitsEncode.c]
!51 = metadata !{i32 48, i32 7, metadata !50, null}
!52 = metadata !{i32 60, i32 10, metadata !53, null}
!53 = metadata !{i32 786443, metadata !1, metadata !45, i32 60, i32 10, i32 0, i32 8} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_PackBitsEncode.c]
!54 = metadata !{i32 62, i32 7, metadata !55, null}
!55 = metadata !{i32 786443, metadata !1, metadata !56, i32 62, i32 7, i32 0, i32 10} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_PackBitsEncode.c]
!56 = metadata !{i32 786443, metadata !1, metadata !53, i32 60, i32 17, i32 0, i32 9} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_PackBitsEncode.c]
!57 = metadata !{i32 71, i32 7, metadata !58, null}
!58 = metadata !{i32 786443, metadata !1, metadata !59, i32 71, i32 7, i32 0, i32 13} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_PackBitsEncode.c]
!59 = metadata !{i32 786443, metadata !1, metadata !53, i32 70, i32 13, i32 0, i32 12} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_PackBitsEncode.c]
!60 = metadata !{i32 77, i32 10, metadata !61, null}
!61 = metadata !{i32 786443, metadata !1, metadata !45, i32 77, i32 10, i32 0, i32 14} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_PackBitsEncode.c]
!62 = metadata !{i32 78, i32 7, metadata !63, null}
!63 = metadata !{i32 786443, metadata !1, metadata !64, i32 78, i32 7, i32 0, i32 16} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_PackBitsEncode.c]
!64 = metadata !{i32 786443, metadata !1, metadata !61, i32 77, i32 17, i32 0, i32 15} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_PackBitsEncode.c]
!65 = metadata !{i32 81, i32 7, metadata !66, null}
!66 = metadata !{i32 786443, metadata !1, metadata !63, i32 78, i32 16, i32 0, i32 17} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_PackBitsEncode.c]
!67 = metadata !{i32 82, i32 7, metadata !66, null}
!68 = metadata !{i32 98, i32 9, metadata !69, null}
!69 = metadata !{i32 786443, metadata !1, metadata !45, i32 98, i32 9, i32 0, i32 19} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_PackBitsEncode.c]
!70 = metadata !{i32 100, i32 14, metadata !71, null}
!71 = metadata !{i32 786443, metadata !1, metadata !69, i32 100, i32 14, i32 0, i32 20} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_PackBitsEncode.c]
!72 = metadata !{i32 101, i32 3, metadata !71, null}
!73 = metadata !{i32 111, i32 1, metadata !4, null}

