; ModuleID = 'Loopus2011_ex2.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind uwtable
define void @Loopus2011_ex2(i32 %r, i32 %s) #0 {
Loopus2011_ex2_bb0:
  call void @llvm.dbg.value(metadata !{i32 %r}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !{i32 %s}, i64 0, metadata !14), !dbg !15
  call void @llvm.dbg.value(metadata !16, i64 0, metadata !17), !dbg !18
  call void @llvm.dbg.value(metadata !19, i64 0, metadata !20), !dbg !21
  call void @llvm.dbg.value(metadata !19, i64 0, metadata !22), !dbg !23
  call void @llvm.dbg.value(metadata !{i32 %"0"}, i64 0, metadata !24), !dbg !25
  call void @llvm.dbg.value(metadata !{i32 %"3"}, i64 0, metadata !17), !dbg !18
  call void @llvm.dbg.value(metadata !26, i64 0, metadata !20), !dbg !21
  call void @llvm.dbg.value(metadata !{i32 %"7"}, i64 0, metadata !17), !dbg !18
  call void @llvm.dbg.value(metadata !27, i64 0, metadata !22), !dbg !23
  call void @llvm.dbg.value(metadata !{i32 %"8"}, i64 0, metadata !14), !dbg !15
  call void @llvm.dbg.value(metadata !26, i64 0, metadata !20), !dbg !21
  call void @llvm.dbg.value(metadata !{i32 %"13"}, i64 0, metadata !17), !dbg !18
  call void @llvm.dbg.value(metadata !26, i64 0, metadata !22), !dbg !23
  call void @llvm.dbg.value(metadata !{i32 %"14"}, i64 0, metadata !14), !dbg !15
  br label %Loopus2011_ex2_bb1, !dbg !28

Loopus2011_ex2_bb1:                               ; preds = %Loopus2011_ex2_bb11, %Loopus2011_ex2_bb7, %Loopus2011_ex2_bb0
  %d.0 = phi i32 [ 0, %Loopus2011_ex2_bb0 ], [ 2, %Loopus2011_ex2_bb7 ], [ 1, %Loopus2011_ex2_bb11 ]
  %f.0 = phi i32 [ 0, %Loopus2011_ex2_bb0 ], [ %f.1, %Loopus2011_ex2_bb7 ], [ %f.2, %Loopus2011_ex2_bb11 ]
  %c.0 = phi i32 [ 4, %Loopus2011_ex2_bb0 ], [ %c.2, %Loopus2011_ex2_bb7 ], [ %c.3, %Loopus2011_ex2_bb11 ]
  %.0 = phi i32 [ %s, %Loopus2011_ex2_bb0 ], [ %"8", %Loopus2011_ex2_bb7 ], [ %"14", %Loopus2011_ex2_bb11 ]
  %"0" = call i32 (...)* @nondet(), !dbg !29
  %"1" = icmp eq i32 %c.0, 1, !dbg !31
  br i1 %"1", label %Loopus2011_ex2_bb12, label %Loopus2011_ex2_bb2, !dbg !31

Loopus2011_ex2_bb2:                               ; preds = %Loopus2011_ex2_bb1
  %"2" = icmp ne i32 %f.0, 0, !dbg !33
  br i1 %"2", label %Loopus2011_ex2_bb3, label %Loopus2011_ex2_bb4, !dbg !33

Loopus2011_ex2_bb3:                               ; preds = %Loopus2011_ex2_bb2
  %"3" = sdiv i32 %c.0, 2, !dbg !35
  br label %Loopus2011_ex2_bb4, !dbg !35

Loopus2011_ex2_bb4:                               ; preds = %Loopus2011_ex2_bb3, %Loopus2011_ex2_bb2
  %c.1 = phi i32 [ %"3", %Loopus2011_ex2_bb3 ], [ %c.0, %Loopus2011_ex2_bb2 ]
  %"4" = icmp sgt i32 %"0", %r, !dbg !37
  br i1 %"4", label %Loopus2011_ex2_bb5, label %Loopus2011_ex2_bb8, !dbg !37

Loopus2011_ex2_bb5:                               ; preds = %Loopus2011_ex2_bb4
  %"5" = icmp ne i32 %d.0, 1, !dbg !39
  %"6" = icmp ne i32 %f.0, 0, !dbg !42
  %or.cond = or i1 %"5", %"6", !dbg !39
  br i1 %or.cond, label %Loopus2011_ex2_bb7, label %Loopus2011_ex2_bb6, !dbg !39

Loopus2011_ex2_bb6:                               ; preds = %Loopus2011_ex2_bb5
  %"7" = sdiv i32 %c.1, 2, !dbg !44
  br label %Loopus2011_ex2_bb7, !dbg !46

Loopus2011_ex2_bb7:                               ; preds = %Loopus2011_ex2_bb5, %Loopus2011_ex2_bb6
  %f.1 = phi i32 [ 1, %Loopus2011_ex2_bb6 ], [ %f.0, %Loopus2011_ex2_bb5 ]
  %c.2 = phi i32 [ %"7", %Loopus2011_ex2_bb6 ], [ %c.1, %Loopus2011_ex2_bb5 ]
  %"8" = add nsw i32 %.0, %c.2, !dbg !47
  %"9" = icmp sgt i32 %"8", 255, !dbg !48
  br i1 %"9", label %Loopus2011_ex2_bb12, label %Loopus2011_ex2_bb1, !dbg !48

Loopus2011_ex2_bb8:                               ; preds = %Loopus2011_ex2_bb4
  %"10" = icmp slt i32 %"0", %r, !dbg !50
  br i1 %"10", label %Loopus2011_ex2_bb9, label %Loopus2011_ex2_bb12, !dbg !50

Loopus2011_ex2_bb9:                               ; preds = %Loopus2011_ex2_bb8
  %"11" = icmp ne i32 %d.0, 2, !dbg !52
  %"12" = icmp ne i32 %f.0, 0, !dbg !55
  %or.cond1 = or i1 %"11", %"12", !dbg !52
  br i1 %or.cond1, label %Loopus2011_ex2_bb11, label %Loopus2011_ex2_bb10, !dbg !52

Loopus2011_ex2_bb10:                              ; preds = %Loopus2011_ex2_bb9
  %"13" = sdiv i32 %c.1, 2, !dbg !57
  br label %Loopus2011_ex2_bb11, !dbg !59

Loopus2011_ex2_bb11:                              ; preds = %Loopus2011_ex2_bb9, %Loopus2011_ex2_bb10
  %f.2 = phi i32 [ 1, %Loopus2011_ex2_bb10 ], [ %f.0, %Loopus2011_ex2_bb9 ]
  %c.3 = phi i32 [ %"13", %Loopus2011_ex2_bb10 ], [ %c.1, %Loopus2011_ex2_bb9 ]
  %"14" = sub nsw i32 %.0, %c.3, !dbg !60
  %"15" = icmp slt i32 %"14", 0, !dbg !61
  br i1 %"15", label %Loopus2011_ex2_bb12, label %Loopus2011_ex2_bb1, !dbg !61

Loopus2011_ex2_bb12:                              ; preds = %Loopus2011_ex2_bb8, %Loopus2011_ex2_bb11, %Loopus2011_ex2_bb7, %Loopus2011_ex2_bb1
  ret void, !dbg !63
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

!0 = metadata !{i32 786449, metadata !1, i32 12, metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)", i1 false, metadata !"", i32 0, metadata !2, metadata !2, metadata !3, metadata !2, metadata !2, metadata !"", i32 1} ; [ DW_TAG_compile_unit ] [/liveness_analysis/Loopus2011_ex2.c] [DW_LANG_C99]
!1 = metadata !{metadata !"Loopus2011_ex2.c", metadata !"/liveness_analysis"}
!2 = metadata !{}
!3 = metadata !{metadata !4}
!4 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"Loopus2011_ex2", metadata !"Loopus2011_ex2", metadata !"", i32 4, metadata !6, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (i32, i32)* @Loopus2011_ex2, null, null, metadata !2, i32 4} ; [ DW_TAG_subprogram ] [line 4] [def] [Loopus2011_ex2]
!5 = metadata !{i32 786473, metadata !1}          ; [ DW_TAG_file_type ] [/liveness_analysis/Loopus2011_ex2.c]
!6 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !7, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!7 = metadata !{null, metadata !8, metadata !8}
!8 = metadata !{i32 786468, null, null, metadata !"int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!9 = metadata !{i32 2, metadata !"Dwarf Version", i32 4}
!10 = metadata !{i32 2, metadata !"Debug Info Version", i32 1}
!11 = metadata !{metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)"}
!12 = metadata !{i32 786689, metadata !4, metadata !"r", metadata !5, i32 16777220, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [r] [line 4]
!13 = metadata !{i32 4, i32 25, metadata !4, null}
!14 = metadata !{i32 786689, metadata !4, metadata !"s", metadata !5, i32 33554436, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [s] [line 4]
!15 = metadata !{i32 4, i32 32, metadata !4, null}
!16 = metadata !{i32 4}
!17 = metadata !{i32 786688, metadata !4, metadata !"c", metadata !5, i32 5, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [c] [line 5]
!18 = metadata !{i32 5, i32 5, metadata !4, null}
!19 = metadata !{i32 0}
!20 = metadata !{i32 786688, metadata !4, metadata !"f", metadata !5, i32 5, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [f] [line 5]
!21 = metadata !{i32 5, i32 23, metadata !4, null}
!22 = metadata !{i32 786688, metadata !4, metadata !"d", metadata !5, i32 5, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [d] [line 5]
!23 = metadata !{i32 5, i32 34, metadata !4, null}
!24 = metadata !{i32 786688, metadata !4, metadata !"n", metadata !5, i32 5, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [n] [line 5]
!25 = metadata !{i32 5, i32 16, metadata !4, null}
!26 = metadata !{i32 1}
!27 = metadata !{i32 2}
!28 = metadata !{i32 6, i32 1, metadata !4, null}
!29 = metadata !{i32 7, i32 7, metadata !30, null}
!30 = metadata !{i32 786443, metadata !1, metadata !4, i32 6, i32 4, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/liveness_analysis/Loopus2011_ex2.c]
!31 = metadata !{i32 8, i32 7, metadata !32, null} ; [ DW_TAG_imported_declaration ]
!32 = metadata !{i32 786443, metadata !1, metadata !30, i32 8, i32 7, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/liveness_analysis/Loopus2011_ex2.c]
!33 = metadata !{i32 9, i32 7, metadata !34, null}
!34 = metadata !{i32 786443, metadata !1, metadata !30, i32 9, i32 7, i32 0, i32 2} ; [ DW_TAG_lexical_block ] [/liveness_analysis/Loopus2011_ex2.c]
!35 = metadata !{i32 9, i32 10, metadata !36, null}
!36 = metadata !{i32 786443, metadata !1, metadata !34, i32 9, i32 10, i32 1, i32 14} ; [ DW_TAG_lexical_block ] [/liveness_analysis/Loopus2011_ex2.c]
!37 = metadata !{i32 10, i32 7, metadata !38, null}
!38 = metadata !{i32 786443, metadata !1, metadata !30, i32 10, i32 7, i32 0, i32 3} ; [ DW_TAG_lexical_block ] [/liveness_analysis/Loopus2011_ex2.c]
!39 = metadata !{i32 11, i32 9, metadata !40, null}
!40 = metadata !{i32 786443, metadata !1, metadata !41, i32 11, i32 9, i32 0, i32 5} ; [ DW_TAG_lexical_block ] [/liveness_analysis/Loopus2011_ex2.c]
!41 = metadata !{i32 786443, metadata !1, metadata !38, i32 10, i32 14, i32 0, i32 4} ; [ DW_TAG_lexical_block ] [/liveness_analysis/Loopus2011_ex2.c]
!42 = metadata !{i32 11, i32 9, metadata !43, null}
!43 = metadata !{i32 786443, metadata !1, metadata !40, i32 11, i32 9, i32 1, i32 15} ; [ DW_TAG_lexical_block ] [/liveness_analysis/Loopus2011_ex2.c]
!44 = metadata !{i32 11, i32 31, metadata !45, null}
!45 = metadata !{i32 786443, metadata !1, metadata !40, i32 11, i32 23, i32 0, i32 6} ; [ DW_TAG_lexical_block ] [/liveness_analysis/Loopus2011_ex2.c]
!46 = metadata !{i32 11, i32 39, metadata !45, null}
!47 = metadata !{i32 12, i32 12, metadata !41, null}
!48 = metadata !{i32 13, i32 9, metadata !49, null}
!49 = metadata !{i32 786443, metadata !1, metadata !41, i32 13, i32 9, i32 0, i32 7} ; [ DW_TAG_lexical_block ] [/liveness_analysis/Loopus2011_ex2.c]
!50 = metadata !{i32 14, i32 12, metadata !51, null}
!51 = metadata !{i32 786443, metadata !1, metadata !38, i32 14, i32 12, i32 0, i32 8} ; [ DW_TAG_lexical_block ] [/liveness_analysis/Loopus2011_ex2.c]
!52 = metadata !{i32 15, i32 9, metadata !53, null}
!53 = metadata !{i32 786443, metadata !1, metadata !54, i32 15, i32 9, i32 0, i32 10} ; [ DW_TAG_lexical_block ] [/liveness_analysis/Loopus2011_ex2.c]
!54 = metadata !{i32 786443, metadata !1, metadata !51, i32 14, i32 19, i32 0, i32 9} ; [ DW_TAG_lexical_block ] [/liveness_analysis/Loopus2011_ex2.c]
!55 = metadata !{i32 15, i32 9, metadata !56, null}
!56 = metadata !{i32 786443, metadata !1, metadata !53, i32 15, i32 9, i32 1, i32 19} ; [ DW_TAG_lexical_block ] [/liveness_analysis/Loopus2011_ex2.c]
!57 = metadata !{i32 15, i32 31, metadata !58, null}
!58 = metadata !{i32 786443, metadata !1, metadata !53, i32 15, i32 23, i32 0, i32 11} ; [ DW_TAG_lexical_block ] [/liveness_analysis/Loopus2011_ex2.c]
!59 = metadata !{i32 15, i32 39, metadata !58, null}
!60 = metadata !{i32 16, i32 12, metadata !54, null}
!61 = metadata !{i32 17, i32 9, metadata !62, null}
!62 = metadata !{i32 786443, metadata !1, metadata !54, i32 17, i32 9, i32 0, i32 12} ; [ DW_TAG_lexical_block ] [/liveness_analysis/Loopus2011_ex2.c]
!63 = metadata !{i32 20, i32 1, metadata !4, null}

