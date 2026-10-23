; ModuleID = 'CPU2006_local_alloc.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind uwtable
define void @local_alloc(i32 %max_qty, i32 %n_basic_blocks, i32 %limit) #0 {
local_alloc_bb0:
  call void @llvm.dbg.value(metadata !{i32 %max_qty}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !{i32 %n_basic_blocks}, i64 0, metadata !14), !dbg !15
  call void @llvm.dbg.value(metadata !{i32 %limit}, i64 0, metadata !16), !dbg !17
  call void @llvm.dbg.value(metadata !{i32 %max_qty}, i64 0, metadata !18), !dbg !19
  call void @llvm.dbg.value(metadata !20, i64 0, metadata !21), !dbg !22
  call void @llvm.dbg.value(metadata !20, i64 0, metadata !23), !dbg !24
  call void @llvm.dbg.value(metadata !{i32 %"3"}, i64 0, metadata !23), !dbg !24
  call void @llvm.dbg.value(metadata !20, i64 0, metadata !18), !dbg !19
  call void @llvm.dbg.value(metadata !{i32 %"4"}, i64 0, metadata !21), !dbg !22
  br label %local_alloc_bb1, !dbg !25

local_alloc_bb1:                                  ; preds = %local_alloc_bb5, %local_alloc_bb0
  %b.0 = phi i32 [ 0, %local_alloc_bb0 ], [ %"4", %local_alloc_bb5 ]
  %next_qty.0 = phi i32 [ %max_qty, %local_alloc_bb0 ], [ 0, %local_alloc_bb5 ]
  %"0" = icmp slt i32 %b.0, %n_basic_blocks, !dbg !27
  br i1 %"0", label %local_alloc_bb2, label %local_alloc_bb6, !dbg !27

local_alloc_bb2:                                  ; preds = %local_alloc_bb1
  %"1" = icmp slt i32 %next_qty.0, %limit, !dbg !30
  br i1 %"1", label %local_alloc_bb3, label %local_alloc_bb5, !dbg !30

local_alloc_bb3:                                  ; preds = %local_alloc_bb2, %local_alloc_bb4
  %i.0 = phi i32 [ %"3", %local_alloc_bb4 ], [ 0, %local_alloc_bb2 ]
  %"2" = icmp slt i32 %i.0, %next_qty.0, !dbg !33
  br i1 %"2", label %local_alloc_bb4, label %local_alloc_bb5, !dbg !33

local_alloc_bb4:                                  ; preds = %local_alloc_bb3
  %"3" = add nsw i32 %i.0, 1, !dbg !38
  br label %local_alloc_bb3, !dbg !38

local_alloc_bb5:                                  ; preds = %local_alloc_bb3, %local_alloc_bb2
  %"4" = add nsw i32 %b.0, 1, !dbg !39
  br label %local_alloc_bb1, !dbg !39

local_alloc_bb6:                                  ; preds = %local_alloc_bb1
  ret void, !dbg !40
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

!0 = metadata !{i32 786449, metadata !1, i32 12, metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)", i1 false, metadata !"", i32 0, metadata !2, metadata !2, metadata !3, metadata !2, metadata !2, metadata !"", i32 1} ; [ DW_TAG_compile_unit ] [/liveness_analysis/CPU2006_local_alloc.c] [DW_LANG_C99]
!1 = metadata !{metadata !"CPU2006_local_alloc.c", metadata !"/liveness_analysis"}
!2 = metadata !{}
!3 = metadata !{metadata !4}
!4 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"local_alloc", metadata !"local_alloc", metadata !"", i32 4, metadata !6, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (i32, i32, i32)* @local_alloc, null, null, metadata !2, i32 5} ; [ DW_TAG_subprogram ] [line 4] [def] [scope 5] [local_alloc]
!5 = metadata !{i32 786473, metadata !1}          ; [ DW_TAG_file_type ] [/liveness_analysis/CPU2006_local_alloc.c]
!6 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !7, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!7 = metadata !{null, metadata !8, metadata !8, metadata !8}
!8 = metadata !{i32 786468, null, null, metadata !"int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!9 = metadata !{i32 2, metadata !"Dwarf Version", i32 4}
!10 = metadata !{i32 2, metadata !"Debug Info Version", i32 1}
!11 = metadata !{metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)"}
!12 = metadata !{i32 786689, metadata !4, metadata !"max_qty", metadata !5, i32 16777220, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [max_qty] [line 4]
!13 = metadata !{i32 4, i32 23, metadata !4, null}
!14 = metadata !{i32 786689, metadata !4, metadata !"n_basic_blocks", metadata !5, i32 33554436, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [n_basic_blocks] [line 4]
!15 = metadata !{i32 4, i32 36, metadata !4, null}
!16 = metadata !{i32 786689, metadata !4, metadata !"limit", metadata !5, i32 50331652, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [limit] [line 4]
!17 = metadata !{i32 4, i32 56, metadata !4, null}
!18 = metadata !{i32 786688, metadata !4, metadata !"next_qty", metadata !5, i32 8, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [next_qty] [line 8]
!19 = metadata !{i32 8, i32 7, metadata !4, null} ; [ DW_TAG_imported_declaration ]
!20 = metadata !{i32 0}
!21 = metadata !{i32 786688, metadata !4, metadata !"b", metadata !5, i32 6, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [b] [line 6]
!22 = metadata !{i32 6, i32 7, metadata !4, null}
!23 = metadata !{i32 786688, metadata !4, metadata !"i", metadata !5, i32 6, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [i] [line 6]
!24 = metadata !{i32 6, i32 10, metadata !4, null}
!25 = metadata !{i32 12, i32 8, metadata !26, null}
!26 = metadata !{i32 786443, metadata !1, metadata !4, i32 12, i32 3, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_local_alloc.c]
!27 = metadata !{i32 12, i32 8, metadata !28, null}
!28 = metadata !{i32 786443, metadata !1, metadata !29, i32 12, i32 8, i32 2, i32 10} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_local_alloc.c]
!29 = metadata !{i32 786443, metadata !1, metadata !26, i32 12, i32 8, i32 1, i32 7} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_local_alloc.c]
!30 = metadata !{i32 21, i32 11, metadata !31, null}
!31 = metadata !{i32 786443, metadata !1, metadata !32, i32 21, i32 11, i32 0, i32 2} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_local_alloc.c]
!32 = metadata !{i32 786443, metadata !1, metadata !26, i32 13, i32 5, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_local_alloc.c]
!33 = metadata !{i32 23, i32 9, metadata !34, null}
!34 = metadata !{i32 786443, metadata !1, metadata !35, i32 23, i32 9, i32 2, i32 9} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_local_alloc.c]
!35 = metadata !{i32 786443, metadata !1, metadata !36, i32 23, i32 9, i32 1, i32 8} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_local_alloc.c]
!36 = metadata !{i32 786443, metadata !1, metadata !37, i32 23, i32 4, i32 0, i32 4} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_local_alloc.c]
!37 = metadata !{i32 786443, metadata !1, metadata !31, i32 22, i32 2, i32 0, i32 3} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_local_alloc.c]
!38 = metadata !{i32 23, i32 30, metadata !36, null}
!39 = metadata !{i32 12, i32 35, metadata !26, null}
!40 = metadata !{i32 35, i32 1, metadata !4, null}

