; ModuleID = 'rank3.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind uwtable
define void @rank2(i32 %m) #0 {
rank2_bb0:
  call void @llvm.dbg.value(metadata !{i32 %m}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !{i32 %m}, i64 0, metadata !14), !dbg !15
  call void @llvm.dbg.value(metadata !{i32 %m}, i64 0, metadata !16), !dbg !17
  call void @llvm.dbg.value(metadata !{i32 %"1"}, i64 0, metadata !14), !dbg !15
  call void @llvm.dbg.value(metadata !{i32 %"2"}, i64 0, metadata !16), !dbg !17
  call void @llvm.dbg.value(metadata !{i32 %"7"}, i64 0, metadata !16), !dbg !17
  call void @llvm.dbg.value(metadata !{i32 %"12"}, i64 0, metadata !14), !dbg !15
  call void @llvm.dbg.value(metadata !{i32 %"13"}, i64 0, metadata !16), !dbg !17
  br label %rank2_bb1, !dbg !18

rank2_bb1:                                        ; preds = %rank2_.critedge, %rank2_bb0
  %x.0 = phi i32 [ %m, %rank2_bb0 ], [ %"15", %rank2_.critedge ]
  %y.0 = phi i32 [ %m, %rank2_bb0 ], [ %"16", %rank2_.critedge ]
  %"0" = icmp sge i32 %x.0, 2, !dbg !19
  br i1 %"0", label %rank2_bb2, label %rank2_bb9, !dbg !19

rank2_bb2:                                        ; preds = %rank2_bb1
  %"1" = add nsw i32 %x.0, -1, !dbg !21
  %"2" = add nsw i32 %y.0, %"1", !dbg !23
  br label %rank2_bb3, !dbg !24

rank2_bb3:                                        ; preds = %rank2_.critedge1, %rank2_bb2
  %x.1 = phi i32 [ %"1", %rank2_bb2 ], [ %x.2, %rank2_.critedge1 ]
  %y.1 = phi i32 [ %"2", %rank2_bb2 ], [ %"14", %rank2_.critedge1 ]
  %"3" = add nsw i32 %x.1, 1, !dbg !25
  %"4" = icmp sge i32 %y.1, %"3", !dbg !25
  br i1 %"4", label %rank2_bb4, label %rank2_.critedge, !dbg !25

rank2_bb4:                                        ; preds = %rank2_bb3
  %"5" = call i32 (...)* @nondet(), !dbg !27
  %"6" = icmp sgt i32 %"5", 0, !dbg !27
  br i1 %"6", label %rank2_bb5, label %rank2_.critedge, !dbg !29

rank2_bb5:                                        ; preds = %rank2_bb4
  %"7" = add nsw i32 %y.1, -1, !dbg !31
  br label %rank2_bb6, !dbg !33

rank2_bb6:                                        ; preds = %rank2_bb8, %rank2_bb5
  %x.2 = phi i32 [ %x.1, %rank2_bb5 ], [ %"12", %rank2_bb8 ]
  %y.2 = phi i32 [ %"7", %rank2_bb5 ], [ %"13", %rank2_bb8 ]
  %"8" = add nsw i32 %x.2, 3, !dbg !34
  %"9" = icmp sge i32 %y.2, %"8", !dbg !34
  br i1 %"9", label %rank2_bb7, label %rank2_.critedge1, !dbg !34

rank2_bb7:                                        ; preds = %rank2_bb6
  %"10" = call i32 (...)* @nondet(), !dbg !36
  %"11" = icmp sgt i32 %"10", 0, !dbg !36
  br i1 %"11", label %rank2_bb8, label %rank2_.critedge1, !dbg !38

rank2_bb8:                                        ; preds = %rank2_bb7
  %"12" = add nsw i32 %x.2, 1, !dbg !40
  %"13" = sub nsw i32 %y.2, 2, !dbg !42
  br label %rank2_bb6, !dbg !43

rank2_.critedge1:                                 ; preds = %rank2_bb6, %rank2_bb7
  %"14" = add nsw i32 %y.2, -1, !dbg !44
  call void @llvm.dbg.value(metadata !{i32 %"14"}, i64 0, metadata !16), !dbg !17
  br label %rank2_bb3, !dbg !45

rank2_.critedge:                                  ; preds = %rank2_bb3, %rank2_bb4
  %"15" = add nsw i32 %x.1, -1, !dbg !46
  call void @llvm.dbg.value(metadata !{i32 %"15"}, i64 0, metadata !14), !dbg !15
  %"16" = sub nsw i32 %y.1, %"15", !dbg !47
  call void @llvm.dbg.value(metadata !{i32 %"16"}, i64 0, metadata !16), !dbg !17
  br label %rank2_bb1, !dbg !48

rank2_bb9:                                        ; preds = %rank2_bb1
  ret void, !dbg !49
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

!0 = metadata !{i32 786449, metadata !1, i32 12, metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)", i1 false, metadata !"", i32 0, metadata !2, metadata !2, metadata !3, metadata !2, metadata !2, metadata !"", i32 1} ; [ DW_TAG_compile_unit ] [/liveness_analysis/rank3.c] [DW_LANG_C99]
!1 = metadata !{metadata !"rank3.c", metadata !"/liveness_analysis"}
!2 = metadata !{}
!3 = metadata !{metadata !4}
!4 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"rank2", metadata !"rank2", metadata !"", i32 5, metadata !6, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (i32)* @rank2, null, null, metadata !2, i32 6} ; [ DW_TAG_subprogram ] [line 5] [def] [scope 6] [rank2]
!5 = metadata !{i32 786473, metadata !1}          ; [ DW_TAG_file_type ] [/liveness_analysis/rank3.c]
!6 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !7, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!7 = metadata !{null, metadata !8}
!8 = metadata !{i32 786468, null, null, metadata !"int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!9 = metadata !{i32 2, metadata !"Dwarf Version", i32 4}
!10 = metadata !{i32 2, metadata !"Debug Info Version", i32 1}
!11 = metadata !{metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)"}
!12 = metadata !{i32 786689, metadata !4, metadata !"m", metadata !5, i32 16777221, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [m] [line 5]
!13 = metadata !{i32 5, i32 16, metadata !4, null}
!14 = metadata !{i32 786688, metadata !4, metadata !"x", metadata !5, i32 7, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [x] [line 7]
!15 = metadata !{i32 7, i32 5, metadata !4, null}
!16 = metadata !{i32 786688, metadata !4, metadata !"y", metadata !5, i32 8, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [y] [line 8]
!17 = metadata !{i32 8, i32 5, metadata !4, null} ; [ DW_TAG_imported_declaration ]
!18 = metadata !{i32 9, i32 1, metadata !4, null}
!19 = metadata !{i32 9, i32 1, metadata !20, null}
!20 = metadata !{i32 786443, metadata !1, metadata !4, i32 9, i32 1, i32 1, i32 3} ; [ DW_TAG_lexical_block ] [/liveness_analysis/rank3.c]
!21 = metadata !{i32 10, i32 5, metadata !22, null}
!22 = metadata !{i32 786443, metadata !1, metadata !4, i32 9, i32 13, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/liveness_analysis/rank3.c]
!23 = metadata !{i32 10, i32 10, metadata !22, null}
!24 = metadata !{i32 11, i32 5, metadata !22, null}
!25 = metadata !{i32 11, i32 5, metadata !26, null}
!26 = metadata !{i32 786443, metadata !1, metadata !22, i32 11, i32 5, i32 1, i32 4} ; [ DW_TAG_lexical_block ] [/liveness_analysis/rank3.c]
!27 = metadata !{i32 11, i32 21, metadata !28, null}
!28 = metadata !{i32 786443, metadata !1, metadata !22, i32 11, i32 21, i32 2, i32 5} ; [ DW_TAG_lexical_block ] [/liveness_analysis/rank3.c]
!29 = metadata !{i32 11, i32 21, metadata !30, null}
!30 = metadata !{i32 786443, metadata !1, metadata !22, i32 11, i32 21, i32 3, i32 6} ; [ DW_TAG_lexical_block ] [/liveness_analysis/rank3.c]
!31 = metadata !{i32 12, i32 9, metadata !32, null}
!32 = metadata !{i32 786443, metadata !1, metadata !22, i32 11, i32 33, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/liveness_analysis/rank3.c]
!33 = metadata !{i32 13, i32 9, metadata !32, null}
!34 = metadata !{i32 13, i32 9, metadata !35, null}
!35 = metadata !{i32 786443, metadata !1, metadata !32, i32 13, i32 9, i32 1, i32 7} ; [ DW_TAG_lexical_block ] [/liveness_analysis/rank3.c]
!36 = metadata !{i32 13, i32 25, metadata !37, null}
!37 = metadata !{i32 786443, metadata !1, metadata !32, i32 13, i32 25, i32 2, i32 8} ; [ DW_TAG_lexical_block ] [/liveness_analysis/rank3.c]
!38 = metadata !{i32 13, i32 25, metadata !39, null}
!39 = metadata !{i32 786443, metadata !1, metadata !32, i32 13, i32 25, i32 3, i32 9} ; [ DW_TAG_lexical_block ] [/liveness_analysis/rank3.c]
!40 = metadata !{i32 14, i32 12, metadata !41, null}
!41 = metadata !{i32 786443, metadata !1, metadata !32, i32 13, i32 37, i32 0, i32 2} ; [ DW_TAG_lexical_block ] [/liveness_analysis/rank3.c]
!42 = metadata !{i32 14, i32 17, metadata !41, null}
!43 = metadata !{i32 15, i32 6, metadata !41, null}
!44 = metadata !{i32 16, i32 9, metadata !32, null}
!45 = metadata !{i32 17, i32 5, metadata !32, null}
!46 = metadata !{i32 18, i32 2, metadata !22, null}
!47 = metadata !{i32 18, i32 7, metadata !22, null}
!48 = metadata !{i32 19, i32 2, metadata !22, null}
!49 = metadata !{i32 20, i32 1, metadata !4, null}

