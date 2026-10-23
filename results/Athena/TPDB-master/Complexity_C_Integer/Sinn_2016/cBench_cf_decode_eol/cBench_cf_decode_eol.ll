; ModuleID = 'cBench_cf_decode_eol.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind uwtable
define void @cf_decode_eol(i32 %ss_bits, i32 %ss_bits_left, i32 %ss_K, i32 %pr_ptr, i32 %pr_limit) #0 {
cf_decode_eol_bb0:
  call void @llvm.dbg.value(metadata !{i32 %ss_bits}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !{i32 %ss_bits_left}, i64 0, metadata !14), !dbg !15
  call void @llvm.dbg.value(metadata !{i32 %ss_K}, i64 0, metadata !16), !dbg !17
  call void @llvm.dbg.value(metadata !{i32 %pr_ptr}, i64 0, metadata !18), !dbg !19
  call void @llvm.dbg.value(metadata !{i32 %pr_limit}, i64 0, metadata !20), !dbg !21
  call void @llvm.dbg.value(metadata !{i32 %pr_ptr}, i64 0, metadata !22), !dbg !23
  call void @llvm.dbg.value(metadata !{i32 %pr_limit}, i64 0, metadata !24), !dbg !25
  call void @llvm.dbg.value(metadata !{i32 %ss_bits_left}, i64 0, metadata !26), !dbg !27
  call void @llvm.dbg.value(metadata !28, i64 0, metadata !29), !dbg !30
  call void @llvm.dbg.value(metadata !{i32 %"5"}, i64 0, metadata !22), !dbg !23
  call void @llvm.dbg.value(metadata !{i32 %"6"}, i64 0, metadata !26), !dbg !27
  call void @llvm.dbg.value(metadata !{i32 %"7"}, i64 0, metadata !26), !dbg !27
  call void @llvm.dbg.value(metadata !{i32 %"8"}, i64 0, metadata !22), !dbg !23
  call void @llvm.dbg.value(metadata !{i32 %"9"}, i64 0, metadata !26), !dbg !27
  call void @llvm.dbg.value(metadata !{i32 %"10"}, i64 0, metadata !29), !dbg !30
  br label %cf_decode_eol_bb1, !dbg !31

cf_decode_eol_bb1:                                ; preds = %cf_decode_eol_bb7, %cf_decode_eol_bb0
  %bits_left.0 = phi i32 [ %ss_bits_left, %cf_decode_eol_bb0 ], [ %"9", %cf_decode_eol_bb7 ]
  %zeros.0 = phi i32 [ 0, %cf_decode_eol_bb0 ], [ %"10", %cf_decode_eol_bb7 ]
  %p.0 = phi i32 [ %pr_ptr, %cf_decode_eol_bb0 ], [ %p.2, %cf_decode_eol_bb7 ]
  %"0" = icmp slt i32 %zeros.0, 11, !dbg !33
  br i1 %"0", label %cf_decode_eol_bb2, label %cf_decode_eol_bb8, !dbg !33

cf_decode_eol_bb2:                                ; preds = %cf_decode_eol_bb1
  %"1" = icmp slt i32 %bits_left.0, 1, !dbg !36
  br i1 %"1", label %cf_decode_eol_bb3, label %cf_decode_eol_bb7, !dbg !36

cf_decode_eol_bb3:                                ; preds = %cf_decode_eol_bb2
  %"2" = sub nsw i32 %pr_limit, %p.0, !dbg !39
  %"3" = icmp slt i32 %"2", 3, !dbg !39
  br i1 %"3", label %cf_decode_eol_bb4, label %cf_decode_eol_bb6, !dbg !39

cf_decode_eol_bb4:                                ; preds = %cf_decode_eol_bb3
  %"4" = icmp slt i32 %p.0, %pr_limit, !dbg !42
  br i1 %"4", label %cf_decode_eol_bb5, label %cf_decode_eol_bb13, !dbg !42

cf_decode_eol_bb5:                                ; preds = %cf_decode_eol_bb4
  %"5" = add nsw i32 %p.0, 1, !dbg !45
  %"6" = add nsw i32 %bits_left.0, 8, !dbg !46
  br label %cf_decode_eol_bb7, !dbg !47

cf_decode_eol_bb6:                                ; preds = %cf_decode_eol_bb3
  %"7" = add nsw i32 %bits_left.0, 24, !dbg !48
  %"8" = add nsw i32 %p.0, 3, !dbg !48
  br label %cf_decode_eol_bb7

cf_decode_eol_bb7:                                ; preds = %cf_decode_eol_bb5, %cf_decode_eol_bb6, %cf_decode_eol_bb2
  %bits_left.2 = phi i32 [ %bits_left.0, %cf_decode_eol_bb2 ], [ %"6", %cf_decode_eol_bb5 ], [ %"7", %cf_decode_eol_bb6 ]
  %p.2 = phi i32 [ %p.0, %cf_decode_eol_bb2 ], [ %"5", %cf_decode_eol_bb5 ], [ %"8", %cf_decode_eol_bb6 ]
  %"9" = sub nsw i32 %bits_left.2, 1, !dbg !50
  %"10" = add nsw i32 %zeros.0, 1, !dbg !51
  br label %cf_decode_eol_bb1, !dbg !51

cf_decode_eol_bb8:                                ; preds = %cf_decode_eol_bb1
  %"11" = icmp sgt i32 %ss_K, 0, !dbg !52
  %"12" = select i1 %"11", i32 2, i32 1, !dbg !52
  call void @llvm.dbg.value(metadata !{i32 %"12"}, i64 0, metadata !53), !dbg !54
  call void @llvm.dbg.value(metadata !{i32 %"17"}, i64 0, metadata !22), !dbg !23
  call void @llvm.dbg.value(metadata !{i32 %"18"}, i64 0, metadata !26), !dbg !27
  call void @llvm.dbg.value(metadata !{i32 %"19"}, i64 0, metadata !26), !dbg !27
  call void @llvm.dbg.value(metadata !{i32 %"20"}, i64 0, metadata !22), !dbg !23
  call void @llvm.dbg.value(metadata !{i32 %"21"}, i64 0, metadata !26), !dbg !27
  br label %cf_decode_eol_bb9, !dbg !55

cf_decode_eol_bb9:                                ; preds = %cf_decode_eol_bb15, %cf_decode_eol_bb8
  %bits_left.3 = phi i32 [ %bits_left.0, %cf_decode_eol_bb8 ], [ %"21", %cf_decode_eol_bb15 ]
  %p.3 = phi i32 [ %p.0, %cf_decode_eol_bb8 ], [ %p.5, %cf_decode_eol_bb15 ]
  %"13" = icmp slt i32 %bits_left.3, %"12", !dbg !57
  br i1 %"13", label %cf_decode_eol_bb10, label %cf_decode_eol_bb15, !dbg !57

cf_decode_eol_bb10:                               ; preds = %cf_decode_eol_bb9
  %"14" = sub nsw i32 %pr_limit, %p.3, !dbg !60
  %"15" = icmp slt i32 %"14", 3, !dbg !60
  br i1 %"15", label %cf_decode_eol_bb11, label %cf_decode_eol_bb14, !dbg !60

cf_decode_eol_bb11:                               ; preds = %cf_decode_eol_bb10
  %"16" = icmp slt i32 %p.3, %pr_limit, !dbg !63
  br i1 %"16", label %cf_decode_eol_bb12, label %cf_decode_eol_bb13, !dbg !63

cf_decode_eol_bb12:                               ; preds = %cf_decode_eol_bb11
  %"17" = add nsw i32 %p.3, 1, !dbg !66
  %"18" = add nsw i32 %bits_left.3, 8, !dbg !67
  br label %cf_decode_eol_bb15, !dbg !68

cf_decode_eol_bb13:                               ; preds = %cf_decode_eol_bb11, %cf_decode_eol_bb4
  ret void, !dbg !69

cf_decode_eol_bb14:                               ; preds = %cf_decode_eol_bb10
  %"19" = add nsw i32 %bits_left.3, 24, !dbg !70
  %"20" = add nsw i32 %p.3, 3, !dbg !70
  br label %cf_decode_eol_bb15

cf_decode_eol_bb15:                               ; preds = %cf_decode_eol_bb12, %cf_decode_eol_bb14, %cf_decode_eol_bb9
  %bits_left.5 = phi i32 [ %bits_left.3, %cf_decode_eol_bb9 ], [ %"18", %cf_decode_eol_bb12 ], [ %"19", %cf_decode_eol_bb14 ]
  %p.5 = phi i32 [ %p.3, %cf_decode_eol_bb9 ], [ %"17", %cf_decode_eol_bb12 ], [ %"20", %cf_decode_eol_bb14 ]
  %"21" = sub nsw i32 %bits_left.5, 1, !dbg !72
  br label %cf_decode_eol_bb9, !dbg !73
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

!0 = metadata !{i32 786449, metadata !1, i32 12, metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)", i1 false, metadata !"", i32 0, metadata !2, metadata !2, metadata !3, metadata !2, metadata !2, metadata !"", i32 1} ; [ DW_TAG_compile_unit ] [/liveness_analysis/cBench_cf_decode_eol.c] [DW_LANG_C99]
!1 = metadata !{metadata !"cBench_cf_decode_eol.c", metadata !"/liveness_analysis"}
!2 = metadata !{}
!3 = metadata !{metadata !4}
!4 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"cf_decode_eol", metadata !"cf_decode_eol", metadata !"", i32 4, metadata !6, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (i32, i32, i32, i32, i32)* @cf_decode_eol, null, null, metadata !2, i32 5} ; [ DW_TAG_subprogram ] [line 4] [def] [scope 5] [cf_decode_eol]
!5 = metadata !{i32 786473, metadata !1}          ; [ DW_TAG_file_type ] [/liveness_analysis/cBench_cf_decode_eol.c]
!6 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !7, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!7 = metadata !{null, metadata !8, metadata !8, metadata !8, metadata !8, metadata !8}
!8 = metadata !{i32 786468, null, null, metadata !"int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!9 = metadata !{i32 2, metadata !"Dwarf Version", i32 4}
!10 = metadata !{i32 2, metadata !"Debug Info Version", i32 1}
!11 = metadata !{metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)"}
!12 = metadata !{i32 786689, metadata !4, metadata !"ss_bits", metadata !5, i32 16777220, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [ss_bits] [line 4]
!13 = metadata !{i32 4, i32 24, metadata !4, null}
!14 = metadata !{i32 786689, metadata !4, metadata !"ss_bits_left", metadata !5, i32 33554436, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [ss_bits_left] [line 4]
!15 = metadata !{i32 4, i32 37, metadata !4, null}
!16 = metadata !{i32 786689, metadata !4, metadata !"ss_K", metadata !5, i32 50331652, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [ss_K] [line 4]
!17 = metadata !{i32 4, i32 55, metadata !4, null}
!18 = metadata !{i32 786689, metadata !4, metadata !"pr_ptr", metadata !5, i32 67108868, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [pr_ptr] [line 4]
!19 = metadata !{i32 4, i32 65, metadata !4, null}
!20 = metadata !{i32 786689, metadata !4, metadata !"pr_limit", metadata !5, i32 83886084, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [pr_limit] [line 4]
!21 = metadata !{i32 4, i32 77, metadata !4, null}
!22 = metadata !{i32 786688, metadata !4, metadata !"p", metadata !5, i32 12, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [p] [line 12]
!23 = metadata !{i32 12, i32 9, metadata !4, null}
!24 = metadata !{i32 786688, metadata !4, metadata !"rlimit", metadata !5, i32 13, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [rlimit] [line 13]
!25 = metadata !{i32 13, i32 9, metadata !4, null}
!26 = metadata !{i32 786688, metadata !4, metadata !"bits_left", metadata !5, i32 9, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [bits_left] [line 9]
!27 = metadata !{i32 9, i32 9, metadata !4, null}
!28 = metadata !{i32 0}
!29 = metadata !{i32 786688, metadata !4, metadata !"zeros", metadata !5, i32 10, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [zeros] [line 10]
!30 = metadata !{i32 10, i32 9, metadata !4, null}
!31 = metadata !{i32 15, i32 10, metadata !32, null}
!32 = metadata !{i32 786443, metadata !1, metadata !4, i32 15, i32 5, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_cf_decode_eol.c]
!33 = metadata !{i32 15, i32 10, metadata !34, null}
!34 = metadata !{i32 786443, metadata !1, metadata !35, i32 15, i32 10, i32 2, i32 17} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_cf_decode_eol.c]
!35 = metadata !{i32 786443, metadata !1, metadata !32, i32 15, i32 10, i32 1, i32 16} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_cf_decode_eol.c]
!36 = metadata !{i32 16, i32 6, metadata !37, null}
!37 = metadata !{i32 786443, metadata !1, metadata !38, i32 16, i32 6, i32 0, i32 2} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_cf_decode_eol.c]
!38 = metadata !{i32 786443, metadata !1, metadata !32, i32 15, i32 46, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_cf_decode_eol.c]
!39 = metadata !{i32 17, i32 10, metadata !40, null}
!40 = metadata !{i32 786443, metadata !1, metadata !41, i32 17, i32 10, i32 0, i32 4} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_cf_decode_eol.c]
!41 = metadata !{i32 786443, metadata !1, metadata !37, i32 16, i32 21, i32 0, i32 3} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_cf_decode_eol.c]
!42 = metadata !{i32 19, i32 7, metadata !43, null}
!43 = metadata !{i32 786443, metadata !1, metadata !44, i32 19, i32 7, i32 0, i32 6} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_cf_decode_eol.c]
!44 = metadata !{i32 786443, metadata !1, metadata !40, i32 17, i32 26, i32 0, i32 5} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_cf_decode_eol.c]
!45 = metadata !{i32 20, i32 7, metadata !43, null}
!46 = metadata !{i32 27, i32 3, metadata !44, null}
!47 = metadata !{i32 28, i32 6, metadata !44, null}
!48 = metadata !{i32 33, i32 3, metadata !49, null}
!49 = metadata !{i32 786443, metadata !1, metadata !40, i32 28, i32 13, i32 0, i32 7} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_cf_decode_eol.c]
!50 = metadata !{i32 39, i32 2, metadata !38, null}
!51 = metadata !{i32 15, i32 37, metadata !32, null}
!52 = metadata !{i32 41, i32 5, metadata !4, null}
!53 = metadata !{i32 786688, metadata !4, metadata !"look_ahead", metadata !5, i32 11, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [look_ahead] [line 11]
!54 = metadata !{i32 11, i32 9, metadata !4, null}
!55 = metadata !{i32 42, i32 5, metadata !56, null}
!56 = metadata !{i32 786443, metadata !1, metadata !4, i32 42, i32 5, i32 0, i32 8} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_cf_decode_eol.c]
!57 = metadata !{i32 43, i32 6, metadata !58, null}
!58 = metadata !{i32 786443, metadata !1, metadata !59, i32 43, i32 6, i32 0, i32 10} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_cf_decode_eol.c]
!59 = metadata !{i32 786443, metadata !1, metadata !56, i32 42, i32 14, i32 0, i32 9} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_cf_decode_eol.c]
!60 = metadata !{i32 44, i32 10, metadata !61, null}
!61 = metadata !{i32 786443, metadata !1, metadata !62, i32 44, i32 10, i32 0, i32 12} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_cf_decode_eol.c]
!62 = metadata !{i32 786443, metadata !1, metadata !58, i32 43, i32 30, i32 0, i32 11} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_cf_decode_eol.c]
!63 = metadata !{i32 46, i32 7, metadata !64, null}
!64 = metadata !{i32 786443, metadata !1, metadata !65, i32 46, i32 7, i32 0, i32 14} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_cf_decode_eol.c]
!65 = metadata !{i32 786443, metadata !1, metadata !61, i32 44, i32 26, i32 0, i32 13} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_cf_decode_eol.c]
!66 = metadata !{i32 47, i32 7, metadata !64, null}
!67 = metadata !{i32 54, i32 3, metadata !65, null}
!68 = metadata !{i32 55, i32 6, metadata !65, null}
!69 = metadata !{i32 74, i32 7, metadata !4, null}
!70 = metadata !{i32 60, i32 3, metadata !71, null}
!71 = metadata !{i32 786443, metadata !1, metadata !61, i32 55, i32 13, i32 0, i32 15} ; [ DW_TAG_lexical_block ] [/liveness_analysis/cBench_cf_decode_eol.c]
!72 = metadata !{i32 65, i32 2, metadata !59, null}
!73 = metadata !{i32 66, i32 5, metadata !59, null}

