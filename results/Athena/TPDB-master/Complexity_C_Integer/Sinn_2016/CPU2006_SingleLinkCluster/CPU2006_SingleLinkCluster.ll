; ModuleID = 'CPU2006_SingleLinkCluster.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind uwtable
define void @SingleLinkCluster(i32 %n) #0 {
SingleLinkCluster_bb0:
  call void @llvm.dbg.value(metadata !{i32 %n}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !{i32 %n}, i64 0, metadata !14), !dbg !16
  call void @llvm.dbg.value(metadata !17, i64 0, metadata !18), !dbg !19
  call void @llvm.dbg.value(metadata !{i32 %"1"}, i64 0, metadata !14), !dbg !16
  call void @llvm.dbg.value(metadata !{i32 %"2"}, i64 0, metadata !18), !dbg !19
  call void @llvm.dbg.value(metadata !{i32 %"4"}, i64 0, metadata !18), !dbg !19
  call void @llvm.dbg.value(metadata !{i32 %"5"}, i64 0, metadata !20), !dbg !24
  call void @llvm.dbg.value(metadata !{i32 %"10"}, i64 0, metadata !14), !dbg !16
  call void @llvm.dbg.value(metadata !{i32 %"11"}, i64 0, metadata !18), !dbg !19
  call void @llvm.dbg.value(metadata !{i32 %"12"}, i64 0, metadata !20), !dbg !24
  br label %SingleLinkCluster_bb1, !dbg !25

SingleLinkCluster_bb1:                            ; preds = %SingleLinkCluster_bb3, %SingleLinkCluster_bb0
  %b.0 = phi i32 [ 0, %SingleLinkCluster_bb0 ], [ %b.1, %SingleLinkCluster_bb3 ]
  %a.0 = phi i32 [ %n, %SingleLinkCluster_bb0 ], [ %a.1, %SingleLinkCluster_bb3 ]
  %"0" = icmp sgt i32 %a.0, 0, !dbg !26
  br i1 %"0", label %SingleLinkCluster_bb2, label %SingleLinkCluster_bb10, !dbg !26

SingleLinkCluster_bb2:                            ; preds = %SingleLinkCluster_bb1
  %"1" = add nsw i32 %a.0, -1, !dbg !28
  %"2" = add nsw i32 %b.0, 1, !dbg !29
  br label %SingleLinkCluster_bb3, !dbg !30

SingleLinkCluster_bb3:                            ; preds = %SingleLinkCluster_bb5, %SingleLinkCluster_bb2
  %b.1 = phi i32 [ %"2", %SingleLinkCluster_bb2 ], [ %b.2, %SingleLinkCluster_bb5 ]
  %a.1 = phi i32 [ %"1", %SingleLinkCluster_bb2 ], [ %a.2, %SingleLinkCluster_bb5 ]
  %"3" = icmp sgt i32 %b.1, 0, !dbg !31
  br i1 %"3", label %SingleLinkCluster_bb4, label %SingleLinkCluster_bb1, !dbg !31

SingleLinkCluster_bb4:                            ; preds = %SingleLinkCluster_bb3
  %"4" = add nsw i32 %b.1, -1, !dbg !33
  %"5" = sub i32 %n, 1, !dbg !34
  br label %SingleLinkCluster_bb5, !dbg !34

SingleLinkCluster_bb5:                            ; preds = %SingleLinkCluster_bb9, %SingleLinkCluster_bb4
  %i.0 = phi i32 [ %"5", %SingleLinkCluster_bb4 ], [ %"12", %SingleLinkCluster_bb9 ]
  %b.2 = phi i32 [ %"4", %SingleLinkCluster_bb4 ], [ %b.3, %SingleLinkCluster_bb9 ]
  %a.2 = phi i32 [ %a.1, %SingleLinkCluster_bb4 ], [ %a.3, %SingleLinkCluster_bb9 ]
  %"6" = icmp sgt i32 %i.0, 0, !dbg !35
  br i1 %"6", label %SingleLinkCluster_bb6, label %SingleLinkCluster_bb3, !dbg !35

SingleLinkCluster_bb6:                            ; preds = %SingleLinkCluster_bb5
  %"7" = icmp sgt i32 %a.2, 0, !dbg !38
  br i1 %"7", label %SingleLinkCluster_bb7, label %SingleLinkCluster_bb9, !dbg !38

SingleLinkCluster_bb7:                            ; preds = %SingleLinkCluster_bb6
  %"8" = call i32 (...)* @nondet(), !dbg !40
  %"9" = icmp ne i32 %"8", 0, !dbg !40
  br i1 %"9", label %SingleLinkCluster_bb8, label %SingleLinkCluster_bb9, !dbg !40

SingleLinkCluster_bb8:                            ; preds = %SingleLinkCluster_bb7
  %"10" = add nsw i32 %a.2, -1, !dbg !42
  %"11" = add nsw i32 %b.2, 1, !dbg !44
  br label %SingleLinkCluster_bb9, !dbg !45

SingleLinkCluster_bb9:                            ; preds = %SingleLinkCluster_bb6, %SingleLinkCluster_bb7, %SingleLinkCluster_bb8
  %b.3 = phi i32 [ %"11", %SingleLinkCluster_bb8 ], [ %b.2, %SingleLinkCluster_bb7 ], [ %b.2, %SingleLinkCluster_bb6 ]
  %a.3 = phi i32 [ %"10", %SingleLinkCluster_bb8 ], [ %a.2, %SingleLinkCluster_bb7 ], [ %a.2, %SingleLinkCluster_bb6 ]
  %"12" = add nsw i32 %i.0, -1, !dbg !46
  br label %SingleLinkCluster_bb5, !dbg !46

SingleLinkCluster_bb10:                           ; preds = %SingleLinkCluster_bb1
  ret void, !dbg !47
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
!llvm.module.flags = !{!9, !10}
!llvm.ident = !{!11}

!0 = metadata !{i32 786449, metadata !1, i32 12, metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)", i1 false, metadata !"", i32 0, metadata !2, metadata !2, metadata !3, metadata !2, metadata !2, metadata !"", i32 1} ; [ DW_TAG_compile_unit ] [/liveness_analysis/CPU2006_SingleLinkCluster.c] [DW_LANG_C99]
!1 = metadata !{metadata !"CPU2006_SingleLinkCluster.c", metadata !"/liveness_analysis"}
!2 = metadata !{}
!3 = metadata !{metadata !4}
!4 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"SingleLinkCluster", metadata !"SingleLinkCluster", metadata !"", i32 6, metadata !6, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (i32)* @SingleLinkCluster, null, null, metadata !2, i32 6} ; [ DW_TAG_subprogram ] [line 6] [def] [SingleLinkCluster]
!5 = metadata !{i32 786473, metadata !1}          ; [ DW_TAG_file_type ] [/liveness_analysis/CPU2006_SingleLinkCluster.c]
!6 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !7, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!7 = metadata !{null, metadata !8}
!8 = metadata !{i32 786468, null, null, metadata !"unsigned int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 7} ; [ DW_TAG_base_type ] [unsigned int] [line 0, size 32, align 32, offset 0, enc DW_ATE_unsigned]
!9 = metadata !{i32 2, metadata !"Dwarf Version", i32 4}
!10 = metadata !{i32 2, metadata !"Debug Info Version", i32 1}
!11 = metadata !{metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)"}
!12 = metadata !{i32 786689, metadata !4, metadata !"n", metadata !5, i32 16777222, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [n] [line 6]
!13 = metadata !{i32 6, i32 37, metadata !4, null}
!14 = metadata !{i32 786688, metadata !4, metadata !"a", metadata !5, i32 7, metadata !15, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [a] [line 7]
!15 = metadata !{i32 786468, null, null, metadata !"int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!16 = metadata !{i32 7, i32 7, metadata !4, null}
!17 = metadata !{i32 0}
!18 = metadata !{i32 786688, metadata !4, metadata !"b", metadata !5, i32 8, metadata !15, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [b] [line 8]
!19 = metadata !{i32 8, i32 7, metadata !4, null} ; [ DW_TAG_imported_declaration ]
!20 = metadata !{i32 786688, metadata !21, metadata !"i", metadata !5, i32 14, metadata !15, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [i] [line 14]
!21 = metadata !{i32 786443, metadata !1, metadata !22, i32 14, i32 7, i32 0, i32 2} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_SingleLinkCluster.c]
!22 = metadata !{i32 786443, metadata !1, metadata !23, i32 12, i32 18, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_SingleLinkCluster.c]
!23 = metadata !{i32 786443, metadata !1, metadata !4, i32 9, i32 16, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_SingleLinkCluster.c]
!24 = metadata !{i32 14, i32 15, metadata !21, null}
!25 = metadata !{i32 9, i32 3, metadata !4, null}
!26 = metadata !{i32 9, i32 3, metadata !27, null}
!27 = metadata !{i32 786443, metadata !1, metadata !4, i32 9, i32 3, i32 1, i32 5} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_SingleLinkCluster.c]
!28 = metadata !{i32 10, i32 5, metadata !23, null}
!29 = metadata !{i32 11, i32 5, metadata !23, null}
!30 = metadata !{i32 12, i32 5, metadata !23, null}
!31 = metadata !{i32 12, i32 5, metadata !32, null}
!32 = metadata !{i32 786443, metadata !1, metadata !23, i32 12, i32 5, i32 1, i32 6} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_SingleLinkCluster.c]
!33 = metadata !{i32 13, i32 7, metadata !22, null}
!34 = metadata !{i32 14, i32 11, metadata !21, null}
!35 = metadata !{i32 14, i32 11, metadata !36, null}
!36 = metadata !{i32 786443, metadata !1, metadata !37, i32 14, i32 11, i32 2, i32 11} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_SingleLinkCluster.c]
!37 = metadata !{i32 786443, metadata !1, metadata !21, i32 14, i32 11, i32 1, i32 7} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_SingleLinkCluster.c]
!38 = metadata !{i32 15, i32 12, metadata !39, null}
!39 = metadata !{i32 786443, metadata !1, metadata !21, i32 15, i32 12, i32 0, i32 3} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_SingleLinkCluster.c]
!40 = metadata !{i32 15, i32 21, metadata !41, null}
!41 = metadata !{i32 786443, metadata !1, metadata !39, i32 15, i32 21, i32 1, i32 8} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_SingleLinkCluster.c]
!42 = metadata !{i32 16, i32 11, metadata !43, null}
!43 = metadata !{i32 786443, metadata !1, metadata !39, i32 15, i32 31, i32 0, i32 4} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_SingleLinkCluster.c]
!44 = metadata !{i32 17, i32 11, metadata !43, null}
!45 = metadata !{i32 18, i32 9, metadata !43, null}
!46 = metadata !{i32 14, i32 33, metadata !21, null}
!47 = metadata !{i32 21, i32 1, metadata !4, null}

