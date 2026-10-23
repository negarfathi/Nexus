; ModuleID = 'CPU2006_xdr3dfcoord.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind uwtable
define void @xdr3dfcoord(i32 %size, i32 %limit) #0 {
xdr3dfcoord_bb0:
  call void @llvm.dbg.value(metadata !{i32 %size}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !{i32 %limit}, i64 0, metadata !14), !dbg !15
  call void @llvm.dbg.value(metadata !16, i64 0, metadata !17), !dbg !18
  call void @llvm.dbg.value(metadata !16, i64 0, metadata !19), !dbg !21
  call void @llvm.dbg.value(metadata !22, i64 0, metadata !19), !dbg !21
  call void @llvm.dbg.value(metadata !{i32 %"5"}, i64 0, metadata !17), !dbg !18
  call void @llvm.dbg.value(metadata !16, i64 0, metadata !23), !dbg !24
  call void @llvm.dbg.value(metadata !{i32 %"8"}, i64 0, metadata !23), !dbg !24
  call void @llvm.dbg.value(metadata !{i32 %"9"}, i64 0, metadata !17), !dbg !18
  call void @llvm.dbg.value(metadata !16, i64 0, metadata !19), !dbg !21
  call void @llvm.dbg.value(metadata !22, i64 0, metadata !19), !dbg !21
  br label %xdr3dfcoord_bb1, !dbg !25

xdr3dfcoord_bb1:                                  ; preds = %xdr3dfcoord_bb8, %xdr3dfcoord_bb0
  %i.0 = phi i32 [ 0, %xdr3dfcoord_bb0 ], [ %i.1, %xdr3dfcoord_bb8 ]
  %"0" = icmp slt i32 %i.0, %size, !dbg !26
  br i1 %"0", label %xdr3dfcoord_bb2, label %xdr3dfcoord_bb10, !dbg !26

xdr3dfcoord_bb2:                                  ; preds = %xdr3dfcoord_bb1
  %"1" = add nsw i32 %i.0, 1, !dbg !28
  %"2" = icmp slt i32 %"1", %size, !dbg !28
  br i1 %"2", label %xdr3dfcoord_bb3, label %xdr3dfcoord_bb4, !dbg !28

xdr3dfcoord_bb3:                                  ; preds = %xdr3dfcoord_bb2
  %"3" = call i32 (...)* @random(), !dbg !30
  %"4" = icmp ne i32 %"3", 0, !dbg !30
  %. = select i1 %"4", i32 1, i32 0, !dbg !30
  br label %xdr3dfcoord_bb4, !dbg !33

xdr3dfcoord_bb4:                                  ; preds = %xdr3dfcoord_bb3, %xdr3dfcoord_bb2
  %is_small.1 = phi i32 [ %., %xdr3dfcoord_bb3 ], [ 0, %xdr3dfcoord_bb2 ]
  %"5" = add nsw i32 %i.0, 1, !dbg !34
  br label %xdr3dfcoord_bb5, !dbg !35

xdr3dfcoord_bb5:                                  ; preds = %xdr3dfcoord_bb7, %xdr3dfcoord_bb6, %xdr3dfcoord_bb4
  %run.0 = phi i32 [ 0, %xdr3dfcoord_bb4 ], [ %"8", %xdr3dfcoord_bb7 ], [ %"8", %xdr3dfcoord_bb6 ]
  %is_small.2 = phi i32 [ %is_small.1, %xdr3dfcoord_bb4 ], [ 0, %xdr3dfcoord_bb6 ], [ %.2, %xdr3dfcoord_bb7 ]
  %i.1 = phi i32 [ %"5", %xdr3dfcoord_bb4 ], [ %"9", %xdr3dfcoord_bb7 ], [ %"9", %xdr3dfcoord_bb6 ]
  %"6" = icmp ne i32 %is_small.2, 0, !dbg !36
  %"7" = icmp slt i32 %run.0, %limit, !dbg !38
  %.1 = select i1 %"6", i1 %"7", i1 false, !dbg !36
  br i1 %.1, label %xdr3dfcoord_bb6, label %xdr3dfcoord_bb8, !dbg !40

xdr3dfcoord_bb6:                                  ; preds = %xdr3dfcoord_bb5
  %"8" = add nsw i32 %run.0, 1, !dbg !42
  %"9" = add nsw i32 %i.1, 1, !dbg !44
  %"10" = icmp slt i32 %"9", %size, !dbg !45
  br i1 %"10", label %xdr3dfcoord_bb7, label %xdr3dfcoord_bb5, !dbg !45

xdr3dfcoord_bb7:                                  ; preds = %xdr3dfcoord_bb6
  %"11" = call i32 (...)* @random(), !dbg !47
  %"12" = icmp ne i32 %"11", 0, !dbg !47
  %.2 = select i1 %"12", i32 1, i32 0, !dbg !47
  br label %xdr3dfcoord_bb5, !dbg !47

xdr3dfcoord_bb8:                                  ; preds = %xdr3dfcoord_bb5, %xdr3dfcoord_bb9
  %k.0 = phi i32 [ %"14", %xdr3dfcoord_bb9 ], [ 0, %xdr3dfcoord_bb5 ]
  %"13" = icmp slt i32 %k.0, %run.0, !dbg !48
  br i1 %"13", label %xdr3dfcoord_bb9, label %xdr3dfcoord_bb1, !dbg !48

xdr3dfcoord_bb9:                                  ; preds = %xdr3dfcoord_bb8
  %"14" = add nsw i32 %k.0, 3, !dbg !52
  br label %xdr3dfcoord_bb8, !dbg !52

xdr3dfcoord_bb10:                                 ; preds = %xdr3dfcoord_bb1
  ret void, !dbg !53
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

!0 = metadata !{i32 786449, metadata !1, i32 12, metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)", i1 false, metadata !"", i32 0, metadata !2, metadata !2, metadata !3, metadata !2, metadata !2, metadata !"", i32 1} ; [ DW_TAG_compile_unit ] [/liveness_analysis/CPU2006_xdr3dfcoord.c] [DW_LANG_C99]
!1 = metadata !{metadata !"CPU2006_xdr3dfcoord.c", metadata !"/liveness_analysis"}
!2 = metadata !{}
!3 = metadata !{metadata !4}
!4 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"xdr3dfcoord", metadata !"xdr3dfcoord", metadata !"", i32 4, metadata !6, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (i32, i32)* @xdr3dfcoord, null, null, metadata !2, i32 4} ; [ DW_TAG_subprogram ] [line 4] [def] [xdr3dfcoord]
!5 = metadata !{i32 786473, metadata !1}          ; [ DW_TAG_file_type ] [/liveness_analysis/CPU2006_xdr3dfcoord.c]
!6 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !7, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!7 = metadata !{null, metadata !8, metadata !8}
!8 = metadata !{i32 786468, null, null, metadata !"int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!9 = metadata !{i32 2, metadata !"Dwarf Version", i32 4}
!10 = metadata !{i32 2, metadata !"Debug Info Version", i32 1}
!11 = metadata !{metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)"}
!12 = metadata !{i32 786689, metadata !4, metadata !"size", metadata !5, i32 16777220, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [size] [line 4]
!13 = metadata !{i32 4, i32 22, metadata !4, null}
!14 = metadata !{i32 786689, metadata !4, metadata !"limit", metadata !5, i32 33554436, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [limit] [line 4]
!15 = metadata !{i32 4, i32 32, metadata !4, null}
!16 = metadata !{i32 0}
!17 = metadata !{i32 786688, metadata !4, metadata !"i", metadata !5, i32 5, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [i] [line 5]
!18 = metadata !{i32 5, i32 6, metadata !4, null}
!19 = metadata !{i32 786688, metadata !20, metadata !"is_small", metadata !5, i32 7, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [is_small] [line 7]
!20 = metadata !{i32 786443, metadata !1, metadata !4, i32 6, i32 19, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_xdr3dfcoord.c]
!21 = metadata !{i32 7, i32 10, metadata !20, null}
!22 = metadata !{i32 1}
!23 = metadata !{i32 786688, metadata !20, metadata !"run", metadata !5, i32 16, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [run] [line 16]
!24 = metadata !{i32 16, i32 10, metadata !20, null}
!25 = metadata !{i32 6, i32 2, metadata !4, null}
!26 = metadata !{i32 6, i32 2, metadata !27, null}
!27 = metadata !{i32 786443, metadata !1, metadata !4, i32 6, i32 2, i32 1, i32 10} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_xdr3dfcoord.c]
!28 = metadata !{i32 8, i32 10, metadata !29, null} ; [ DW_TAG_imported_declaration ]
!29 = metadata !{i32 786443, metadata !1, metadata !20, i32 8, i32 10, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_xdr3dfcoord.c]
!30 = metadata !{i32 9, i32 7, metadata !31, null}
!31 = metadata !{i32 786443, metadata !1, metadata !32, i32 9, i32 7, i32 0, i32 3} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_xdr3dfcoord.c]
!32 = metadata !{i32 786443, metadata !1, metadata !29, i32 8, i32 24, i32 0, i32 2} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_xdr3dfcoord.c]
!33 = metadata !{i32 13, i32 6, metadata !32, null}
!34 = metadata !{i32 14, i32 6, metadata !20, null}
!35 = metadata !{i32 17, i32 6, metadata !20, null}
!36 = metadata !{i32 17, i32 6, metadata !37, null}
!37 = metadata !{i32 786443, metadata !1, metadata !20, i32 17, i32 6, i32 1, i32 11} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_xdr3dfcoord.c]
!38 = metadata !{i32 17, i32 6, metadata !39, null}
!39 = metadata !{i32 786443, metadata !1, metadata !20, i32 17, i32 6, i32 2, i32 12} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_xdr3dfcoord.c]
!40 = metadata !{i32 17, i32 6, metadata !41, null}
!41 = metadata !{i32 786443, metadata !1, metadata !20, i32 17, i32 6, i32 3, i32 13} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_xdr3dfcoord.c]
!42 = metadata !{i32 18, i32 3, metadata !43, null}
!43 = metadata !{i32 786443, metadata !1, metadata !20, i32 17, i32 38, i32 0, i32 5} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_xdr3dfcoord.c]
!44 = metadata !{i32 19, i32 3, metadata !43, null}
!45 = metadata !{i32 21, i32 7, metadata !46, null}
!46 = metadata !{i32 786443, metadata !1, metadata !43, i32 21, i32 7, i32 0, i32 6} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_xdr3dfcoord.c]
!47 = metadata !{i32 22, i32 4, metadata !46, null}
!48 = metadata !{i32 26, i32 11, metadata !49, null}
!49 = metadata !{i32 786443, metadata !1, metadata !50, i32 26, i32 11, i32 2, i32 15} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_xdr3dfcoord.c]
!50 = metadata !{i32 786443, metadata !1, metadata !51, i32 26, i32 11, i32 1, i32 14} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_xdr3dfcoord.c]
!51 = metadata !{i32 786443, metadata !1, metadata !20, i32 26, i32 6, i32 0, i32 8} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_xdr3dfcoord.c]
!52 = metadata !{i32 26, i32 29, metadata !51, null}
!53 = metadata !{i32 29, i32 1, metadata !4, null}

