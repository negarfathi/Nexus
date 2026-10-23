; ModuleID = 'CPU2006_Perl_scan_vstring.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind uwtable
define void @Perl_scan_vstring(i32 %s, i32 %PL_bufend) #0 {
Perl_scan_vstring_bb0:
  call void @llvm.dbg.value(metadata !{i32 %s}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !{i32 %PL_bufend}, i64 0, metadata !14), !dbg !15
  call void @llvm.dbg.value(metadata !{i32 %s}, i64 0, metadata !16), !dbg !17
  call void @llvm.dbg.value(metadata !{i32 %s}, i64 0, metadata !18), !dbg !19
  %"0" = call i32 (...)* @nondet(), !dbg !20
  %"1" = icmp ne i32 %"0", 0, !dbg !20
  %"2" = add nsw i32 %s, 1, !dbg !22
  call void @llvm.dbg.value(metadata !{i32 %"2"}, i64 0, metadata !16), !dbg !17
  %.s = select i1 %"1", i32 %"2", i32 %s, !dbg !20
  call void @llvm.dbg.value(metadata !{i32 %"6"}, i64 0, metadata !16), !dbg !17
  br label %Perl_scan_vstring_bb1, !dbg !24

Perl_scan_vstring_bb1:                            ; preds = %Perl_scan_vstring_bb3, %Perl_scan_vstring_bb0
  %pos.1 = phi i32 [ %.s, %Perl_scan_vstring_bb0 ], [ %"6", %Perl_scan_vstring_bb3 ]
  %"3" = icmp slt i32 %pos.1, %PL_bufend, !dbg !25
  br i1 %"3", label %Perl_scan_vstring_bb2, label %Perl_scan_vstring_.critedge, !dbg !25

Perl_scan_vstring_bb2:                            ; preds = %Perl_scan_vstring_bb1
  %"4" = call i32 (...)* @nondet(), !dbg !27
  %"5" = icmp ne i32 %"4", 0, !dbg !27
  br i1 %"5", label %Perl_scan_vstring_bb3, label %Perl_scan_vstring_.critedge, !dbg !29

Perl_scan_vstring_bb3:                            ; preds = %Perl_scan_vstring_bb2
  %"6" = add nsw i32 %pos.1, 1, !dbg !31
  br label %Perl_scan_vstring_bb1, !dbg !31

Perl_scan_vstring_.critedge:                      ; preds = %Perl_scan_vstring_bb1, %Perl_scan_vstring_bb2
  %"7" = call i32 (...)* @nondet(), !dbg !32
  %"8" = icmp ne i32 %"7", 0, !dbg !32
  br i1 %"8", label %Perl_scan_vstring_bb4, label %Perl_scan_vstring_bb12, !dbg !32

Perl_scan_vstring_bb4:                            ; preds = %Perl_scan_vstring_.critedge
  %"9" = call i32 (...)* @nondet(), !dbg !34
  %"10" = icmp ne i32 %"9", 0, !dbg !34
  %"11" = add nsw i32 %s, 1, !dbg !37
  call void @llvm.dbg.value(metadata !{i32 %"11"}, i64 0, metadata !12), !dbg !13
  %.s1 = select i1 %"10", i32 %"11", i32 %s, !dbg !34
  call void @llvm.dbg.value(metadata !{i32 %pos.2}, i64 0, metadata !39), !dbg !43
  call void @llvm.dbg.value(metadata !{i32 %"12"}, i64 0, metadata !39), !dbg !43
  br label %Perl_scan_vstring_.critedge2, !dbg !44

Perl_scan_vstring_.critedge2:                     ; preds = %Perl_scan_vstring_bb10, %Perl_scan_vstring_bb9, %Perl_scan_vstring_bb4
  %pos.2 = phi i32 [ %pos.1, %Perl_scan_vstring_bb4 ], [ %pos.3, %Perl_scan_vstring_bb9 ], [ %pos.3, %Perl_scan_vstring_bb10 ]
  %.1 = phi i32 [ %.s1, %Perl_scan_vstring_bb4 ], [ %"18", %Perl_scan_vstring_bb9 ], [ %"18", %Perl_scan_vstring_bb10 ]
  br label %Perl_scan_vstring_bb5, !dbg !45

Perl_scan_vstring_bb5:                            ; preds = %Perl_scan_vstring_bb5, %Perl_scan_vstring_.critedge2
  %end.0 = phi i32 [ %pos.2, %Perl_scan_vstring_.critedge2 ], [ %"12", %Perl_scan_vstring_bb5 ]
  %"12" = add nsw i32 %end.0, -1, !dbg !46
  %"13" = icmp sge i32 %"12", %.1, !dbg !46
  br i1 %"13", label %Perl_scan_vstring_bb5, label %Perl_scan_vstring_bb6, !dbg !46

Perl_scan_vstring_bb6:                            ; preds = %Perl_scan_vstring_bb5
  %"14" = add nsw i32 %pos.2, 1, !dbg !48
  %"15" = icmp slt i32 %"14", %PL_bufend, !dbg !48
  br i1 %"15", label %Perl_scan_vstring_bb7, label %Perl_scan_vstring_bb12, !dbg !48

Perl_scan_vstring_bb7:                            ; preds = %Perl_scan_vstring_bb6
  %"16" = call i32 (...)* @nondet(), !dbg !50
  %"17" = icmp ne i32 %"16", 0, !dbg !50
  br i1 %"17", label %Perl_scan_vstring_bb8, label %Perl_scan_vstring_bb12, !dbg !50

Perl_scan_vstring_bb8:                            ; preds = %Perl_scan_vstring_bb7
  %"18" = add nsw i32 %pos.2, 1, !dbg !52
  call void @llvm.dbg.value(metadata !{i32 %"18"}, i64 0, metadata !16), !dbg !17
  call void @llvm.dbg.value(metadata !{i32 %"18"}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !{i32 %"22"}, i64 0, metadata !16), !dbg !17
  br label %Perl_scan_vstring_bb9, !dbg !53

Perl_scan_vstring_bb9:                            ; preds = %Perl_scan_vstring_bb11, %Perl_scan_vstring_bb8
  %pos.3 = phi i32 [ %"18", %Perl_scan_vstring_bb8 ], [ %"22", %Perl_scan_vstring_bb11 ]
  %"19" = icmp slt i32 %pos.3, %PL_bufend, !dbg !54
  br i1 %"19", label %Perl_scan_vstring_bb10, label %Perl_scan_vstring_.critedge2, !dbg !54

Perl_scan_vstring_bb10:                           ; preds = %Perl_scan_vstring_bb9
  %"20" = call i32 (...)* @nondet(), !dbg !56
  %"21" = icmp ne i32 %"20", 0, !dbg !56
  br i1 %"21", label %Perl_scan_vstring_bb11, label %Perl_scan_vstring_.critedge2, !dbg !58

Perl_scan_vstring_bb11:                           ; preds = %Perl_scan_vstring_bb10
  %"22" = add nsw i32 %pos.3, 1, !dbg !60
  br label %Perl_scan_vstring_bb9, !dbg !60

Perl_scan_vstring_bb12:                           ; preds = %Perl_scan_vstring_bb7, %Perl_scan_vstring_bb6, %Perl_scan_vstring_.critedge
  ret void, !dbg !61
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

!0 = metadata !{i32 786449, metadata !1, i32 12, metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)", i1 false, metadata !"", i32 0, metadata !2, metadata !2, metadata !3, metadata !2, metadata !2, metadata !"", i32 1} ; [ DW_TAG_compile_unit ] [/liveness_analysis/CPU2006_Perl_scan_vstring.c] [DW_LANG_C99]
!1 = metadata !{metadata !"CPU2006_Perl_scan_vstring.c", metadata !"/liveness_analysis"}
!2 = metadata !{}
!3 = metadata !{metadata !4}
!4 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"Perl_scan_vstring", metadata !"Perl_scan_vstring", metadata !"", i32 7, metadata !6, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (i32, i32)* @Perl_scan_vstring, null, null, metadata !2, i32 8} ; [ DW_TAG_subprogram ] [line 7] [def] [scope 8] [Perl_scan_vstring]
!5 = metadata !{i32 786473, metadata !1}          ; [ DW_TAG_file_type ] [/liveness_analysis/CPU2006_Perl_scan_vstring.c]
!6 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !7, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!7 = metadata !{null, metadata !8, metadata !8}
!8 = metadata !{i32 786468, null, null, metadata !"int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!9 = metadata !{i32 2, metadata !"Dwarf Version", i32 4}
!10 = metadata !{i32 2, metadata !"Debug Info Version", i32 1}
!11 = metadata !{metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)"}
!12 = metadata !{i32 786689, metadata !4, metadata !"s", metadata !5, i32 16777223, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [s] [line 7]
!13 = metadata !{i32 7, i32 23, metadata !4, null}
!14 = metadata !{i32 786689, metadata !4, metadata !"PL_bufend", metadata !5, i32 33554439, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [PL_bufend] [line 7]
!15 = metadata !{i32 7, i32 30, metadata !4, null}
!16 = metadata !{i32 786688, metadata !4, metadata !"pos", metadata !5, i32 9, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [pos] [line 9]
!17 = metadata !{i32 9, i32 9, metadata !4, null}
!18 = metadata !{i32 786688, metadata !4, metadata !"start", metadata !5, i32 10, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [start] [line 10]
!19 = metadata !{i32 10, i32 9, metadata !4, null}
!20 = metadata !{i32 11, i32 9, metadata !21, null}
!21 = metadata !{i32 786443, metadata !1, metadata !4, i32 11, i32 9, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_Perl_scan_vstring.c]
!22 = metadata !{i32 11, i32 19, metadata !23, null}
!23 = metadata !{i32 786443, metadata !1, metadata !21, i32 11, i32 19, i32 1, i32 10} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_Perl_scan_vstring.c]
!24 = metadata !{i32 12, i32 5, metadata !4, null}
!25 = metadata !{i32 12, i32 5, metadata !26, null}
!26 = metadata !{i32 786443, metadata !1, metadata !4, i32 12, i32 5, i32 1, i32 11} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_Perl_scan_vstring.c]
!27 = metadata !{i32 12, i32 31, metadata !28, null}
!28 = metadata !{i32 786443, metadata !1, metadata !4, i32 12, i32 31, i32 2, i32 12} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_Perl_scan_vstring.c]
!29 = metadata !{i32 12, i32 31, metadata !30, null}
!30 = metadata !{i32 786443, metadata !1, metadata !4, i32 12, i32 31, i32 3, i32 13} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_Perl_scan_vstring.c]
!31 = metadata !{i32 13, i32 2, metadata !4, null}
!32 = metadata !{i32 15, i32 9, metadata !33, null}
!33 = metadata !{i32 786443, metadata !1, metadata !4, i32 15, i32 9, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_Perl_scan_vstring.c]
!34 = metadata !{i32 17, i32 6, metadata !35, null}
!35 = metadata !{i32 786443, metadata !1, metadata !36, i32 17, i32 6, i32 0, i32 3} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_Perl_scan_vstring.c]
!36 = metadata !{i32 786443, metadata !1, metadata !33, i32 15, i32 19, i32 0, i32 2} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_Perl_scan_vstring.c]
!37 = metadata !{i32 17, i32 16, metadata !38, null}
!38 = metadata !{i32 786443, metadata !1, metadata !35, i32 17, i32 16, i32 1, i32 14} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_Perl_scan_vstring.c]
!39 = metadata !{i32 786688, metadata !40, metadata !"end", metadata !5, i32 21, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [end] [line 21]
!40 = metadata !{i32 786443, metadata !1, metadata !41, i32 20, i32 6, i32 0, i32 6} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_Perl_scan_vstring.c]
!41 = metadata !{i32 786443, metadata !1, metadata !42, i32 19, i32 11, i32 0, i32 5} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_Perl_scan_vstring.c]
!42 = metadata !{i32 786443, metadata !1, metadata !36, i32 19, i32 2, i32 0, i32 4} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_Perl_scan_vstring.c]
!43 = metadata !{i32 21, i32 7, metadata !40, null}
!44 = metadata !{i32 19, i32 2, metadata !42, null}
!45 = metadata !{i32 22, i32 3, metadata !40, null}
!46 = metadata !{i32 22, i32 3, metadata !47, null}
!47 = metadata !{i32 786443, metadata !1, metadata !40, i32 22, i32 3, i32 1, i32 15} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_Perl_scan_vstring.c]
!48 = metadata !{i32 25, i32 10, metadata !49, null}
!49 = metadata !{i32 786443, metadata !1, metadata !41, i32 25, i32 10, i32 0, i32 8} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_Perl_scan_vstring.c]
!50 = metadata !{i32 25, i32 33, metadata !51, null}
!51 = metadata !{i32 786443, metadata !1, metadata !49, i32 25, i32 33, i32 1, i32 16} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_Perl_scan_vstring.c]
!52 = metadata !{i32 26, i32 4, metadata !49, null}
!53 = metadata !{i32 31, i32 6, metadata !41, null}
!54 = metadata !{i32 31, i32 6, metadata !55, null}
!55 = metadata !{i32 786443, metadata !1, metadata !41, i32 31, i32 6, i32 1, i32 17} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_Perl_scan_vstring.c]
!56 = metadata !{i32 31, i32 32, metadata !57, null}
!57 = metadata !{i32 786443, metadata !1, metadata !41, i32 31, i32 32, i32 2, i32 18} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_Perl_scan_vstring.c]
!58 = metadata !{i32 31, i32 32, metadata !59, null}
!59 = metadata !{i32 786443, metadata !1, metadata !41, i32 31, i32 32, i32 3, i32 19} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_Perl_scan_vstring.c]
!60 = metadata !{i32 32, i32 4, metadata !41, null}
!61 = metadata !{i32 35, i32 1, metadata !4, null}

