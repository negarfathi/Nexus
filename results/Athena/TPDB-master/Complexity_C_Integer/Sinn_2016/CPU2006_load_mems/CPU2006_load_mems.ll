; ModuleID = 'CPU2006_load_mems.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind uwtable
define void @load_mems(i32 %ptr, i32 %word_num_, i32 %bit_num_) #0 {
load_mems_bb0:
  call void @llvm.dbg.value(metadata !{i32 %ptr}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !{i32 %word_num_}, i64 0, metadata !14), !dbg !15
  call void @llvm.dbg.value(metadata !{i32 %bit_num_}, i64 0, metadata !16), !dbg !17
  call void @llvm.dbg.value(metadata !{i32 %"7"}, i64 0, metadata !16), !dbg !17
  call void @llvm.dbg.value(metadata !18, i64 0, metadata !16), !dbg !17
  call void @llvm.dbg.value(metadata !{i32 %"8"}, i64 0, metadata !14), !dbg !15
  br label %load_mems_bb1, !dbg !19

load_mems_bb1:                                    ; preds = %load_mems_bb8, %load_mems_bb0
  %.02 = phi i32 [ %bit_num_, %load_mems_bb0 ], [ %.13, %load_mems_bb8 ]
  %.01 = phi i32 [ %word_num_, %load_mems_bb0 ], [ 0, %load_mems_bb8 ]
  %.0 = phi i32 [ %ptr, %load_mems_bb0 ], [ %"9", %load_mems_bb8 ]
  %"0" = icmp sgt i32 %.0, 0, !dbg !21
  br i1 %"0", label %load_mems_bb2, label %load_mems_bb9, !dbg !21

load_mems_bb2:                                    ; preds = %load_mems_bb1, %load_mems_bb7
  %.13 = phi i32 [ 0, %load_mems_bb7 ], [ %.02, %load_mems_bb1 ]
  %.1 = phi i32 [ %"8", %load_mems_bb7 ], [ %.01, %load_mems_bb1 ]
  %"1" = icmp slt i32 %.1, 2, !dbg !24
  br i1 %"1", label %load_mems_bb3, label %load_mems_bb8, !dbg !24

load_mems_bb3:                                    ; preds = %load_mems_bb2
  %"2" = call i32 (...)* @random(), !dbg !29
  %"3" = icmp ne i32 %"2", 0, !dbg !29
  br i1 %"3", label %load_mems_bb4, label %load_mems_bb7, !dbg !29

load_mems_bb4:                                    ; preds = %load_mems_bb3, %load_mems_bb6
  %.2 = phi i32 [ %"7", %load_mems_bb6 ], [ %.13, %load_mems_bb3 ]
  %"4" = icmp slt i32 %.2, 64, !dbg !32
  br i1 %"4", label %load_mems_bb5, label %load_mems_bb7, !dbg !32

load_mems_bb5:                                    ; preds = %load_mems_bb4
  %"5" = call i32 (...)* @random(), !dbg !37
  %"6" = icmp ne i32 %"5", 0, !dbg !37
  br i1 %"6", label %load_mems_bb7, label %load_mems_bb6, !dbg !37

load_mems_bb6:                                    ; preds = %load_mems_bb5
  %"7" = add nsw i32 %.2, 1, !dbg !40
  br label %load_mems_bb4, !dbg !40

load_mems_bb7:                                    ; preds = %load_mems_bb3, %load_mems_bb5, %load_mems_bb4
  %"8" = add nsw i32 %.1, 1, !dbg !41
  br label %load_mems_bb2, !dbg !41

load_mems_bb8:                                    ; preds = %load_mems_bb2
  call void @llvm.dbg.value(metadata !18, i64 0, metadata !14), !dbg !15
  %"9" = add nsw i32 %.0, -1, !dbg !42
  call void @llvm.dbg.value(metadata !{i32 %"9"}, i64 0, metadata !12), !dbg !13
  br label %load_mems_bb1, !dbg !42

load_mems_bb9:                                    ; preds = %load_mems_bb1
  ret void, !dbg !43
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

!0 = metadata !{i32 786449, metadata !1, i32 12, metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)", i1 false, metadata !"", i32 0, metadata !2, metadata !2, metadata !3, metadata !2, metadata !2, metadata !"", i32 1} ; [ DW_TAG_compile_unit ] [/liveness_analysis/CPU2006_load_mems.c] [DW_LANG_C99]
!1 = metadata !{metadata !"CPU2006_load_mems.c", metadata !"/liveness_analysis"}
!2 = metadata !{}
!3 = metadata !{metadata !4}
!4 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"load_mems", metadata !"load_mems", metadata !"", i32 10, metadata !6, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (i32, i32, i32)* @load_mems, null, null, metadata !2, i32 10} ; [ DW_TAG_subprogram ] [line 10] [def] [load_mems]
!5 = metadata !{i32 786473, metadata !1}          ; [ DW_TAG_file_type ] [/liveness_analysis/CPU2006_load_mems.c]
!6 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !7, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!7 = metadata !{null, metadata !8, metadata !8, metadata !8}
!8 = metadata !{i32 786468, null, null, metadata !"int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!9 = metadata !{i32 2, metadata !"Dwarf Version", i32 4}
!10 = metadata !{i32 2, metadata !"Debug Info Version", i32 1}
!11 = metadata !{metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)"}
!12 = metadata !{i32 786689, metadata !4, metadata !"ptr", metadata !5, i32 16777226, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [ptr] [line 10]
!13 = metadata !{i32 10, i32 20, metadata !4, null}
!14 = metadata !{i32 786689, metadata !4, metadata !"word_num_", metadata !5, i32 33554442, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [word_num_] [line 10]
!15 = metadata !{i32 10, i32 29, metadata !4, null}
!16 = metadata !{i32 786689, metadata !4, metadata !"bit_num_", metadata !5, i32 50331658, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [bit_num_] [line 10]
!17 = metadata !{i32 10, i32 44, metadata !4, null}
!18 = metadata !{i32 0}
!19 = metadata !{i32 12, i32 6, metadata !20, null}
!20 = metadata !{i32 786443, metadata !1, metadata !4, i32 12, i32 6, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_load_mems.c]
!21 = metadata !{i32 12, i32 6, metadata !22, null}
!22 = metadata !{i32 786443, metadata !1, metadata !23, i32 12, i32 6, i32 2, i32 15} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_load_mems.c]
!23 = metadata !{i32 786443, metadata !1, metadata !20, i32 12, i32 6, i32 1, i32 9} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_load_mems.c]
!24 = metadata !{i32 13, i32 3, metadata !25, null}
!25 = metadata !{i32 786443, metadata !1, metadata !26, i32 13, i32 3, i32 2, i32 14} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_load_mems.c]
!26 = metadata !{i32 786443, metadata !1, metadata !27, i32 13, i32 3, i32 1, i32 10} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_load_mems.c]
!27 = metadata !{i32 786443, metadata !1, metadata !28, i32 13, i32 3, i32 0, i32 2} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_load_mems.c]
!28 = metadata !{i32 786443, metadata !1, metadata !20, i32 12, i32 29, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_load_mems.c]
!29 = metadata !{i32 14, i32 11, metadata !30, null}
!30 = metadata !{i32 786443, metadata !1, metadata !31, i32 14, i32 11, i32 0, i32 4} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_load_mems.c]
!31 = metadata !{i32 786443, metadata !1, metadata !27, i32 13, i32 38, i32 0, i32 3} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_load_mems.c]
!32 = metadata !{i32 15, i32 4, metadata !33, null}
!33 = metadata !{i32 786443, metadata !1, metadata !34, i32 15, i32 4, i32 2, i32 13} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_load_mems.c]
!34 = metadata !{i32 786443, metadata !1, metadata !35, i32 15, i32 4, i32 1, i32 11} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_load_mems.c]
!35 = metadata !{i32 786443, metadata !1, metadata !36, i32 15, i32 4, i32 0, i32 6} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_load_mems.c]
!36 = metadata !{i32 786443, metadata !1, metadata !30, i32 14, i32 21, i32 0, i32 5} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_load_mems.c]
!37 = metadata !{i32 16, i32 8, metadata !38, null}
!38 = metadata !{i32 786443, metadata !1, metadata !39, i32 16, i32 8, i32 0, i32 8} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_load_mems.c]
!39 = metadata !{i32 786443, metadata !1, metadata !35, i32 15, i32 43, i32 0, i32 7} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_load_mems.c]
!40 = metadata !{i32 15, i32 31, metadata !35, null}
!41 = metadata !{i32 13, i32 25, metadata !27, null}
!42 = metadata !{i32 12, i32 22, metadata !20, null}
!43 = metadata !{i32 23, i32 1, metadata !4, null}

