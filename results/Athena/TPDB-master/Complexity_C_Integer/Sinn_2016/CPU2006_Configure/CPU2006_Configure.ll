; ModuleID = 'CPU2006_Configure.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind uwtable
define void @Configure(i32 %ac) #0 {
Configure_bb0:
  call void @llvm.dbg.value(metadata !{i32 %ac}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !14, i64 0, metadata !15), !dbg !16
  %"0" = icmp sge i32 %ac, 3, !dbg !17
  br i1 %"0", label %Configure_bb1, label %Configure_bb2, !dbg !17

Configure_bb1:                                    ; preds = %Configure_bb0
  %"1" = call i32 (...)* @random(), !dbg !19
  %"2" = icmp ne i32 %"1", 0, !dbg !19
  call void @llvm.dbg.value(metadata !22, i64 0, metadata !15), !dbg !16
  %. = select i1 %"2", i32 3, i32 1, !dbg !19
  br label %Configure_bb2, !dbg !23

Configure_bb2:                                    ; preds = %Configure_bb4, %Configure_.critedge, %Configure_bb0, %Configure_bb1
  %CLcount.2 = phi i32 [ %., %Configure_bb1 ], [ 1, %Configure_bb0 ], [ %"6", %Configure_bb4 ], [ %CLcount.3, %Configure_.critedge ]
  %"3" = icmp slt i32 %CLcount.2, %ac, !dbg !24
  br i1 %"3", label %Configure_bb3, label %Configure_bb11, !dbg !24

Configure_bb3:                                    ; preds = %Configure_bb2
  %"4" = call i32 (...)* @random(), !dbg !26
  %"5" = icmp ne i32 %"4", 0, !dbg !26
  br i1 %"5", label %Configure_bb4, label %Configure_bb5, !dbg !26

Configure_bb4:                                    ; preds = %Configure_bb3
  %"6" = add nsw i32 %CLcount.2, 2, !dbg !29
  br label %Configure_bb2, !dbg !31

Configure_bb5:                                    ; preds = %Configure_bb3
  %"7" = call i32 (...)* @random(), !dbg !32
  %"8" = icmp ne i32 %"7", 0, !dbg !32
  br i1 %"8", label %Configure_bb6, label %Configure_bb11, !dbg !32

Configure_bb6:                                    ; preds = %Configure_bb5
  %"9" = add nsw i32 %CLcount.2, 1, !dbg !35
  br label %Configure_bb7, !dbg !37

Configure_bb7:                                    ; preds = %Configure_bb9, %Configure_bb6
  %NumberParams.0 = phi i32 [ %"9", %Configure_bb6 ], [ %"13", %Configure_bb9 ]
  %"10" = icmp slt i32 %NumberParams.0, %ac, !dbg !38
  br i1 %"10", label %Configure_bb8, label %Configure_.critedge, !dbg !38

Configure_bb8:                                    ; preds = %Configure_bb7
  %"11" = call i32 (...)* @random(), !dbg !40
  %"12" = icmp ne i32 %"11", 0, !dbg !40
  br i1 %"12", label %Configure_bb9, label %Configure_.critedge, !dbg !42

Configure_bb9:                                    ; preds = %Configure_bb8
  %"13" = add nsw i32 %NumberParams.0, 1, !dbg !44
  br label %Configure_bb7, !dbg !44

Configure_.critedge:                              ; preds = %Configure_bb8, %Configure_bb7, %Configure_bb10
  %CLcount.3 = phi i32 [ %"15", %Configure_bb10 ], [ %"9", %Configure_bb7 ], [ %"9", %Configure_bb8 ]
  %"14" = icmp slt i32 %CLcount.3, %NumberParams.0, !dbg !45
  br i1 %"14", label %Configure_bb10, label %Configure_bb2, !dbg !45

Configure_bb10:                                   ; preds = %Configure_.critedge
  %"15" = add nsw i32 %CLcount.3, 1, !dbg !47
  br label %Configure_.critedge, !dbg !49

Configure_bb11:                                   ; preds = %Configure_bb5, %Configure_bb2
  ret void, !dbg !50
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

!0 = metadata !{i32 786449, metadata !1, i32 12, metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)", i1 false, metadata !"", i32 0, metadata !2, metadata !2, metadata !3, metadata !2, metadata !2, metadata !"", i32 1} ; [ DW_TAG_compile_unit ] [/liveness_analysis/CPU2006_Configure.c] [DW_LANG_C99]
!1 = metadata !{metadata !"CPU2006_Configure.c", metadata !"/liveness_analysis"}
!2 = metadata !{}
!3 = metadata !{metadata !4}
!4 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"Configure", metadata !"Configure", metadata !"", i32 6, metadata !6, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (i32)* @Configure, null, null, metadata !2, i32 7} ; [ DW_TAG_subprogram ] [line 6] [def] [scope 7] [Configure]
!5 = metadata !{i32 786473, metadata !1}          ; [ DW_TAG_file_type ] [/liveness_analysis/CPU2006_Configure.c]
!6 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !7, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!7 = metadata !{null, metadata !8}
!8 = metadata !{i32 786468, null, null, metadata !"int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!9 = metadata !{i32 2, metadata !"Dwarf Version", i32 4}
!10 = metadata !{i32 2, metadata !"Debug Info Version", i32 1}
!11 = metadata !{metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)"}
!12 = metadata !{i32 786689, metadata !4, metadata !"ac", metadata !5, i32 16777222, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [ac] [line 6]
!13 = metadata !{i32 6, i32 20, metadata !4, null}
!14 = metadata !{i32 1}
!15 = metadata !{i32 786688, metadata !4, metadata !"CLcount", metadata !5, i32 9, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [CLcount] [line 9]
!16 = metadata !{i32 9, i32 9, metadata !4, null}
!17 = metadata !{i32 20, i32 9, metadata !18, null}
!18 = metadata !{i32 786443, metadata !1, metadata !4, i32 20, i32 9, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_Configure.c]
!19 = metadata !{i32 21, i32 6, metadata !20, null}
!20 = metadata !{i32 786443, metadata !1, metadata !21, i32 21, i32 6, i32 0, i32 2} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_Configure.c]
!21 = metadata !{i32 786443, metadata !1, metadata !18, i32 20, i32 18, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_Configure.c]
!22 = metadata !{i32 3}
!23 = metadata !{i32 28, i32 5, metadata !21, null}
!24 = metadata !{i32 36, i32 5, metadata !25, null}
!25 = metadata !{i32 786443, metadata !1, metadata !4, i32 36, i32 5, i32 1, i32 12} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_Configure.c]
!26 = metadata !{i32 40, i32 6, metadata !27, null}
!27 = metadata !{i32 786443, metadata !1, metadata !28, i32 40, i32 6, i32 0, i32 5} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_Configure.c]
!28 = metadata !{i32 786443, metadata !1, metadata !4, i32 36, i32 26, i32 0, i32 4} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_Configure.c]
!29 = metadata !{i32 48, i32 6, metadata !30, null}
!30 = metadata !{i32 786443, metadata !1, metadata !27, i32 40, i32 16, i32 0, i32 6} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_Configure.c]
!31 = metadata !{i32 49, i32 2, metadata !30, null}
!32 = metadata !{i32 50, i32 10, metadata !33, null}
!33 = metadata !{i32 786443, metadata !1, metadata !34, i32 50, i32 10, i32 0, i32 8} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_Configure.c]
!34 = metadata !{i32 786443, metadata !1, metadata !27, i32 49, i32 9, i32 0, i32 7} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_Configure.c]
!35 = metadata !{i32 51, i32 3, metadata !36, null}
!36 = metadata !{i32 786443, metadata !1, metadata !33, i32 50, i32 20, i32 0, i32 9} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_Configure.c]
!37 = metadata !{i32 54, i32 3, metadata !36, null}
!38 = metadata !{i32 54, i32 3, metadata !39, null}
!39 = metadata !{i32 786443, metadata !1, metadata !36, i32 54, i32 3, i32 1, i32 13} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_Configure.c]
!40 = metadata !{i32 54, i32 31, metadata !41, null}
!41 = metadata !{i32 786443, metadata !1, metadata !36, i32 54, i32 31, i32 2, i32 14} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_Configure.c]
!42 = metadata !{i32 54, i32 31, metadata !43, null}
!43 = metadata !{i32 786443, metadata !1, metadata !36, i32 54, i32 31, i32 3, i32 15} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_Configure.c]
!44 = metadata !{i32 55, i32 7, metadata !36, null}
!45 = metadata !{i32 60, i32 3, metadata !46, null}
!46 = metadata !{i32 786443, metadata !1, metadata !36, i32 60, i32 3, i32 1, i32 16} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_Configure.c]
!47 = metadata !{i32 73, i32 7, metadata !48, null}
!48 = metadata !{i32 786443, metadata !1, metadata !36, i32 60, i32 34, i32 0, i32 10} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_Configure.c]
!49 = metadata !{i32 74, i32 3, metadata !48, null}
!50 = metadata !{i32 90, i32 1, metadata !4, null}

