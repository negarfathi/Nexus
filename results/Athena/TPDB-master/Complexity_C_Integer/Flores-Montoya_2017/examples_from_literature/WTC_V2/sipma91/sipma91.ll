; ModuleID = 'sipma91.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind uwtable
define void @sipma91(i32 %x) #0 {
sipma91_bb0:
  call void @llvm.dbg.value(metadata !{i32 %x}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !{i32 %x}, i64 0, metadata !14), !dbg !15
  call void @llvm.dbg.value(metadata !16, i64 0, metadata !17), !dbg !18
  %"0" = icmp sgt i32 %x, 100, !dbg !19
  br i1 %"0", label %sipma91_bb8, label %sipma91_bb1, !dbg !19

sipma91_bb1:                                      ; preds = %sipma91_bb0, %sipma91_bb2
  %y2.0 = phi i32 [ %"3", %sipma91_bb2 ], [ 1, %sipma91_bb0 ]
  %y1.0 = phi i32 [ %"2", %sipma91_bb2 ], [ %x, %sipma91_bb0 ]
  %"1" = icmp sle i32 %y1.0, 100, !dbg !21
  br i1 %"1", label %sipma91_bb2, label %sipma91_bb3, !dbg !21

sipma91_bb2:                                      ; preds = %sipma91_bb1
  %"2" = add nsw i32 %y1.0, 11, !dbg !24
  %"3" = add nsw i32 %y2.0, 1, !dbg !26
  br label %sipma91_bb1, !dbg !27

sipma91_bb3:                                      ; preds = %sipma91_bb7, %sipma91_bb4, %sipma91_bb1
  %y2.1 = phi i32 [ %y2.0, %sipma91_bb1 ], [ %"13", %sipma91_bb7 ], [ %"6", %sipma91_bb4 ]
  %y1.1 = phi i32 [ %y1.0, %sipma91_bb1 ], [ %"12", %sipma91_bb7 ], [ %"5", %sipma91_bb4 ]
  %"4" = icmp sgt i32 %y2.1, 1, !dbg !28
  br i1 %"4", label %sipma91_bb4, label %sipma91_bb8, !dbg !28

sipma91_bb4:                                      ; preds = %sipma91_bb3
  %"5" = sub nsw i32 %y1.1, 10, !dbg !30
  %"6" = sub nsw i32 %y2.1, 1, !dbg !32
  %"7" = icmp sgt i32 %"5", 100, !dbg !33
  %"8" = icmp eq i32 %"6", 1, !dbg !35
  %or.cond = and i1 %"7", %"8", !dbg !33
  br i1 %or.cond, label %sipma91_bb3, label %sipma91_bb5, !dbg !33

sipma91_bb5:                                      ; preds = %sipma91_bb4
  %"9" = icmp sgt i32 %"5", 100, !dbg !37
  br i1 %"9", label %sipma91_bb6, label %sipma91_bb7, !dbg !37

sipma91_bb6:                                      ; preds = %sipma91_bb5
  %"10" = sub nsw i32 %"5", 10, !dbg !40
  %"11" = sub nsw i32 %"6", 1, !dbg !42
  br label %sipma91_bb7, !dbg !43

sipma91_bb7:                                      ; preds = %sipma91_bb6, %sipma91_bb5
  %y2.2 = phi i32 [ %"11", %sipma91_bb6 ], [ %"6", %sipma91_bb5 ]
  %y1.2 = phi i32 [ %"10", %sipma91_bb6 ], [ %"5", %sipma91_bb5 ]
  %"12" = add nsw i32 %y1.2, 11, !dbg !44
  %"13" = add nsw i32 %y2.2, 1, !dbg !45
  br label %sipma91_bb3

sipma91_bb8:                                      ; preds = %sipma91_bb3, %sipma91_bb0
  ret void, !dbg !46
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

!0 = metadata !{i32 786449, metadata !1, i32 12, metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)", i1 false, metadata !"", i32 0, metadata !2, metadata !2, metadata !3, metadata !2, metadata !2, metadata !"", i32 1} ; [ DW_TAG_compile_unit ] [/liveness_analysis/sipma91.c] [DW_LANG_C99]
!1 = metadata !{metadata !"sipma91.c", metadata !"/liveness_analysis"}
!2 = metadata !{}
!3 = metadata !{metadata !4}
!4 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"sipma91", metadata !"sipma91", metadata !"", i32 3, metadata !6, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (i32)* @sipma91, null, null, metadata !2, i32 3} ; [ DW_TAG_subprogram ] [line 3] [def] [sipma91]
!5 = metadata !{i32 786473, metadata !1}          ; [ DW_TAG_file_type ] [/liveness_analysis/sipma91.c]
!6 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !7, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!7 = metadata !{null, metadata !8}
!8 = metadata !{i32 786468, null, null, metadata !"int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!9 = metadata !{i32 2, metadata !"Dwarf Version", i32 4}
!10 = metadata !{i32 2, metadata !"Debug Info Version", i32 1}
!11 = metadata !{metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)"}
!12 = metadata !{i32 786689, metadata !4, metadata !"x", metadata !5, i32 16777219, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [x] [line 3]
!13 = metadata !{i32 3, i32 18, metadata !4, null}
!14 = metadata !{i32 786688, metadata !4, metadata !"y1", metadata !5, i32 4, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [y1] [line 4]
!15 = metadata !{i32 4, i32 7, metadata !4, null}
!16 = metadata !{i32 1}
!17 = metadata !{i32 786688, metadata !4, metadata !"y2", metadata !5, i32 4, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [y2] [line 4]
!18 = metadata !{i32 4, i32 11, metadata !4, null}
!19 = metadata !{i32 9, i32 6, metadata !20, null}
!20 = metadata !{i32 786443, metadata !1, metadata !4, i32 9, i32 6, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/liveness_analysis/sipma91.c]
!21 = metadata !{i32 11, i32 5, metadata !22, null}
!22 = metadata !{i32 786443, metadata !1, metadata !23, i32 11, i32 5, i32 1, i32 9} ; [ DW_TAG_lexical_block ] [/liveness_analysis/sipma91.c]
!23 = metadata !{i32 786443, metadata !1, metadata !20, i32 10, i32 8, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/liveness_analysis/sipma91.c]
!24 = metadata !{i32 12, i32 7, metadata !25, null}
!25 = metadata !{i32 786443, metadata !1, metadata !23, i32 11, i32 21, i32 0, i32 2} ; [ DW_TAG_lexical_block ] [/liveness_analysis/sipma91.c]
!26 = metadata !{i32 13, i32 7, metadata !25, null}
!27 = metadata !{i32 14, i32 5, metadata !25, null}
!28 = metadata !{i32 16, i32 5, metadata !29, null}
!29 = metadata !{i32 786443, metadata !1, metadata !23, i32 16, i32 5, i32 1, i32 10} ; [ DW_TAG_lexical_block ] [/liveness_analysis/sipma91.c]
!30 = metadata !{i32 17, i32 7, metadata !31, null}
!31 = metadata !{i32 786443, metadata !1, metadata !23, i32 16, i32 18, i32 0, i32 3} ; [ DW_TAG_lexical_block ] [/liveness_analysis/sipma91.c]
!32 = metadata !{i32 18, i32 7, metadata !31, null}
!33 = metadata !{i32 19, i32 10, metadata !34, null}
!34 = metadata !{i32 786443, metadata !1, metadata !31, i32 19, i32 10, i32 0, i32 4} ; [ DW_TAG_lexical_block ] [/liveness_analysis/sipma91.c]
!35 = metadata !{i32 19, i32 10, metadata !36, null}
!36 = metadata !{i32 786443, metadata !1, metadata !34, i32 19, i32 10, i32 1, i32 11} ; [ DW_TAG_lexical_block ] [/liveness_analysis/sipma91.c]
!37 = metadata !{i32 21, i32 5, metadata !38, null}
!38 = metadata !{i32 786443, metadata !1, metadata !39, i32 21, i32 5, i32 0, i32 6} ; [ DW_TAG_lexical_block ] [/liveness_analysis/sipma91.c]
!39 = metadata !{i32 786443, metadata !1, metadata !34, i32 20, i32 12, i32 0, i32 5} ; [ DW_TAG_lexical_block ] [/liveness_analysis/sipma91.c]
!40 = metadata !{i32 22, i32 11, metadata !41, null}
!41 = metadata !{i32 786443, metadata !1, metadata !38, i32 21, i32 14, i32 0, i32 7} ; [ DW_TAG_lexical_block ] [/liveness_analysis/sipma91.c]
!42 = metadata !{i32 23, i32 11, metadata !41, null}
!43 = metadata !{i32 24, i32 9, metadata !41, null}
!44 = metadata !{i32 25, i32 9, metadata !39, null}
!45 = metadata !{i32 26, i32 9, metadata !39, null}
!46 = metadata !{i32 30, i32 1, metadata !4, null}

