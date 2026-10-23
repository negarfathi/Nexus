; ModuleID = 'cBench_encode_mcu_AC_refine.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind uwtable
define void @encode_mcu_AC_refine(i32 %cinfo_Ss, i32 %cinfo_Se) #0 {
encode_mcu_AC_refine_bb0:
  call void @llvm.dbg.value(metadata !{i32 %cinfo_Ss}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !{i32 %cinfo_Se}, i64 0, metadata !14), !dbg !15
  call void @llvm.dbg.value(metadata !{i32 %cinfo_Se}, i64 0, metadata !16), !dbg !17
  call void @llvm.dbg.value(metadata !{i32 %cinfo_Ss}, i64 0, metadata !18), !dbg !19
  call void @llvm.dbg.value(metadata !{i32 %"1"}, i64 0, metadata !18), !dbg !19
  br label %encode_mcu_AC_refine_bb1, !dbg !20

encode_mcu_AC_refine_bb1:                         ; preds = %encode_mcu_AC_refine_bb2, %encode_mcu_AC_refine_bb0
  %k.0 = phi i32 [ %cinfo_Ss, %encode_mcu_AC_refine_bb0 ], [ %"1", %encode_mcu_AC_refine_bb2 ]
  %"0" = icmp sle i32 %k.0, %cinfo_Se, !dbg !22
  br i1 %"0", label %encode_mcu_AC_refine_bb2, label %encode_mcu_AC_refine_bb3, !dbg !22

encode_mcu_AC_refine_bb2:                         ; preds = %encode_mcu_AC_refine_bb1
  %"1" = add nsw i32 %k.0, 1, !dbg !25
  br label %encode_mcu_AC_refine_bb1, !dbg !25

encode_mcu_AC_refine_bb3:                         ; preds = %encode_mcu_AC_refine_bb1, %encode_mcu_AC_refine_.critedge
  %k.1 = phi i32 [ %"10", %encode_mcu_AC_refine_.critedge ], [ %cinfo_Ss, %encode_mcu_AC_refine_bb1 ]
  %r.0 = phi i32 [ %r.2, %encode_mcu_AC_refine_.critedge ], [ 0, %encode_mcu_AC_refine_bb1 ]
  %"2" = icmp sle i32 %k.1, %cinfo_Se, !dbg !26
  br i1 %"2", label %encode_mcu_AC_refine_bb4, label %encode_mcu_AC_refine_bb9, !dbg !26

encode_mcu_AC_refine_bb4:                         ; preds = %encode_mcu_AC_refine_bb3
  %"3" = call i32 (...)* @random(), !dbg !30
  %"4" = icmp ne i32 %"3", 0, !dbg !30
  br i1 %"4", label %encode_mcu_AC_refine_bb5, label %encode_mcu_AC_refine_bb6, !dbg !30

encode_mcu_AC_refine_bb5:                         ; preds = %encode_mcu_AC_refine_bb4
  %"5" = add nsw i32 %r.0, 1, !dbg !33
  br label %encode_mcu_AC_refine_.critedge, !dbg !35

encode_mcu_AC_refine_bb6:                         ; preds = %encode_mcu_AC_refine_bb4, %encode_mcu_AC_refine_bb8
  %r.1 = phi i32 [ %"9", %encode_mcu_AC_refine_bb8 ], [ %r.0, %encode_mcu_AC_refine_bb4 ]
  %"6" = icmp sgt i32 %r.1, 15, !dbg !36
  br i1 %"6", label %encode_mcu_AC_refine_bb7, label %encode_mcu_AC_refine_.critedge, !dbg !36

encode_mcu_AC_refine_bb7:                         ; preds = %encode_mcu_AC_refine_bb6
  %"7" = call i32 (...)* @random(), !dbg !38
  %"8" = icmp ne i32 %"7", 0, !dbg !38
  br i1 %"8", label %encode_mcu_AC_refine_bb8, label %encode_mcu_AC_refine_.critedge, !dbg !40

encode_mcu_AC_refine_bb8:                         ; preds = %encode_mcu_AC_refine_bb7
  %"9" = sub nsw i32 %r.1, 16, !dbg !42
  br label %encode_mcu_AC_refine_bb6, !dbg !44

encode_mcu_AC_refine_.critedge:                   ; preds = %encode_mcu_AC_refine_bb7, %encode_mcu_AC_refine_bb6, %encode_mcu_AC_refine_bb5
  %r.2 = phi i32 [ %"5", %encode_mcu_AC_refine_bb5 ], [ 0, %encode_mcu_AC_refine_bb6 ], [ 0, %encode_mcu_AC_refine_bb7 ]
  %"10" = add nsw i32 %k.1, 1, !dbg !45
  br label %encode_mcu_AC_refine_bb3, !dbg !45

encode_mcu_AC_refine_bb9:                         ; preds = %encode_mcu_AC_refine_bb3
  ret void, !dbg !46
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

!0 = metadata !{i32 786449, metadata !1, i32 12, metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)", i1 false, metadata !"", i32 0, metadata !2, metadata !2, metadata !3, metadata !2, metadata !2, metadata !"", i32 1} ; [ DW_TAG_compile_unit ] [/liveness_analysis/cBench_encode_mcu_AC_refine.c] [DW_LANG_C99]
!1 = metadata !{metadata !"cBench_encode_mcu_AC_refine.c", metadata !"/liveness_analysis"}
!2 = metadata !{}
!3 = metadata !{metadata !4}
!4 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"encode_mcu_AC_refine", metadata !"encode_mcu_AC_refine", metadata !"", i32 9, metadata !6, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (i32, i32)* @encode_mcu_AC_refine, null, null, metadata !2, i32 10} ; [ DW_TAG_subprogram ] [line 9] [def] [scope 10] [encode_mcu_AC_refine]
!5 = metadata !{i32 786473, metadata !1}          ; [ DW_TAG_file_type ] [/liveness_analysis/cBench_encode_mcu_AC_refine.c]
!6 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !7, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!7 = metadata !{null, metadata !8, metadata !8}
!8 = metadata !{i32 786468, null, null, metadata !"int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!9 = metadata !{i32 2, metadata !"Dwarf Version", i32 4}
!10 = metadata !{i32 2, metadata !"Debug Info Version", i32 1}
!11 = metadata !{metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)"}
!12 = metadata !{i32 786689, metadata !4, metadata !"cinfo_Ss", metadata !5, i32 16777225, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [cinfo_Ss] [line 9]
!13 = metadata !{i32 9, i32 31, metadata !4, null}
!14 = metadata !{i32 786689, metadata !4, metadata !"cinfo_Se", metadata !5, i32 33554441, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [cinfo_Se] [line 9]
!15 = metadata !{i32 9, i32 45, metadata !4, null}
!16 = metadata !{i32 786688, metadata !4, metadata !"Se", metadata !5, i32 17, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [Se] [line 17]
!17 = metadata !{i32 17, i32 9, metadata !4, null}
!18 = metadata !{i32 786688, metadata !4, metadata !"k", metadata !5, i32 13, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [k] [line 13]
!19 = metadata !{i32 13, i32 21, metadata !4, null}
!20 = metadata !{i32 28, i32 10, metadata !21, null}
!21 = metadata !{i32 786443, metadata !1, metadata !4, i32 28, i32 5, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_encode_mcu_AC_refine.c]
!22 = metadata !{i32 28, i32 10, metadata !23, null}
!23 = metadata !{i32 786443, metadata !1, metadata !24, i32 28, i32 10, i32 2, i32 8} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_encode_mcu_AC_refine.c]
!24 = metadata !{i32 786443, metadata !1, metadata !21, i32 28, i32 10, i32 1, i32 7} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_encode_mcu_AC_refine.c]
!25 = metadata !{i32 28, i32 33, metadata !21, null}
!26 = metadata !{i32 40, i32 10, metadata !27, null}
!27 = metadata !{i32 786443, metadata !1, metadata !28, i32 40, i32 10, i32 2, i32 13} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_encode_mcu_AC_refine.c]
!28 = metadata !{i32 786443, metadata !1, metadata !29, i32 40, i32 10, i32 1, i32 9} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_encode_mcu_AC_refine.c]
!29 = metadata !{i32 786443, metadata !1, metadata !4, i32 40, i32 5, i32 0, i32 2} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_encode_mcu_AC_refine.c]
!30 = metadata !{i32 41, i32 6, metadata !31, null}
!31 = metadata !{i32 786443, metadata !1, metadata !32, i32 41, i32 6, i32 0, i32 4} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_encode_mcu_AC_refine.c]
!32 = metadata !{i32 786443, metadata !1, metadata !29, i32 40, i32 38, i32 0, i32 3} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_encode_mcu_AC_refine.c]
!33 = metadata !{i32 42, i32 6, metadata !34, null}
!34 = metadata !{i32 786443, metadata !1, metadata !31, i32 41, i32 16, i32 0, i32 5} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_encode_mcu_AC_refine.c]
!35 = metadata !{i32 43, i32 6, metadata !34, null}
!36 = metadata !{i32 45, i32 2, metadata !37, null}
!37 = metadata !{i32 786443, metadata !1, metadata !32, i32 45, i32 2, i32 1, i32 10} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_encode_mcu_AC_refine.c]
!38 = metadata !{i32 45, i32 19, metadata !39, null}
!39 = metadata !{i32 786443, metadata !1, metadata !32, i32 45, i32 19, i32 2, i32 11} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_encode_mcu_AC_refine.c]
!40 = metadata !{i32 45, i32 19, metadata !41, null}
!41 = metadata !{i32 786443, metadata !1, metadata !32, i32 45, i32 19, i32 3, i32 12} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_encode_mcu_AC_refine.c]
!42 = metadata !{i32 48, i32 6, metadata !43, null}
!43 = metadata !{i32 786443, metadata !1, metadata !32, i32 45, i32 29, i32 0, i32 6} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_encode_mcu_AC_refine.c]
!44 = metadata !{i32 52, i32 2, metadata !43, null}
!45 = metadata !{i32 40, i32 33, metadata !29, null}
!46 = metadata !{i32 82, i32 1, metadata !4, null}

