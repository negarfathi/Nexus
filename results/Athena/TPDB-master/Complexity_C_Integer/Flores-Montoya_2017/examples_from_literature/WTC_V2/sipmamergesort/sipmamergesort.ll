; ModuleID = 'sipmamergesort.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind uwtable
define void @sipmamergesort_init(i32 %n) #0 {
sipmamergesort_init_bb0:
  call void @llvm.dbg.value(metadata !{i32 %n}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !14, i64 0, metadata !15), !dbg !16
  call void @llvm.dbg.value(metadata !14, i64 0, metadata !17), !dbg !18
  call void @llvm.dbg.value(metadata !14, i64 0, metadata !19), !dbg !20
  call void @llvm.dbg.value(metadata !{i32 %n}, i64 0, metadata !21), !dbg !22
  call void @llvm.dbg.value(metadata !14, i64 0, metadata !23), !dbg !24
  call void @llvm.dbg.value(metadata !{i32 %n}, i64 0, metadata !25), !dbg !26
  call void @llvm.dbg.value(metadata !{i32 %"1"}, i64 0, metadata !27), !dbg !28
  call void @llvm.dbg.value(metadata !{i32 %"2"}, i64 0, metadata !29), !dbg !30
  call void @llvm.dbg.value(metadata !{i32 %p.0}, i64 0, metadata !31), !dbg !32
  call void @llvm.dbg.value(metadata !{i32 %"4"}, i64 0, metadata !21), !dbg !22
  call void @llvm.dbg.value(metadata !{i32 %p.0}, i64 0, metadata !33), !dbg !34
  call void @llvm.dbg.value(metadata !{i32 %"6"}, i64 0, metadata !21), !dbg !22
  call void @llvm.dbg.value(metadata !{i32 %"11"}, i64 0, metadata !27), !dbg !28
  call void @llvm.dbg.value(metadata !{i32 %"12"}, i64 0, metadata !23), !dbg !24
  call void @llvm.dbg.value(metadata !{i32 %"13"}, i64 0, metadata !31), !dbg !32
  call void @llvm.dbg.value(metadata !{i32 %"11"}, i64 0, metadata !27), !dbg !28
  call void @llvm.dbg.value(metadata !{i32 %"14"}, i64 0, metadata !25), !dbg !26
  call void @llvm.dbg.value(metadata !{i32 %"15"}, i64 0, metadata !33), !dbg !34
  call void @llvm.dbg.value(metadata !{i32 %"4"}, i64 0, metadata !33), !dbg !34
  call void @llvm.dbg.value(metadata !{i32 %m.0}, i64 0, metadata !31), !dbg !32
  call void @llvm.dbg.value(metadata !14, i64 0, metadata !27), !dbg !28
  call void @llvm.dbg.value(metadata !{i32 %n}, i64 0, metadata !29), !dbg !30
  call void @llvm.dbg.value(metadata !{i32 %"1"}, i64 0, metadata !23), !dbg !24
  call void @llvm.dbg.value(metadata !{i32 %"2"}, i64 0, metadata !25), !dbg !26
  br label %sipmamergesort_init_bb1, !dbg !35

sipmamergesort_init_bb1:                          ; preds = %sipmamergesort_init_bb12, %sipmamergesort_init_bb0
  %up.0 = phi i32 [ 1, %sipmamergesort_init_bb0 ], [ %"26", %sipmamergesort_init_bb12 ]
  %p.0 = phi i32 [ 1, %sipmamergesort_init_bb0 ], [ %"27", %sipmamergesort_init_bb12 ]
  %"0" = icmp ne i32 %up.0, 0, !dbg !36
  %"1" = add nsw i32 %n, 1, !dbg !39
  %"2" = mul nsw i32 2, %n, !dbg !41
  %.n = select i1 %"0", i32 %"2", i32 %n, !dbg !42
  %. = select i1 %"0", i32 %"1", i32 1, !dbg !42
  %n. = select i1 %"0", i32 %n, i32 %"2", !dbg !42
  %.1 = select i1 %"0", i32 1, i32 %"1", !dbg !42
  br label %sipmamergesort_init_bb2, !dbg !43

sipmamergesort_init_bb2:                          ; preds = %sipmamergesort_init_bb11, %sipmamergesort_init_bb1
  %m.0 = phi i32 [ %n, %sipmamergesort_init_bb1 ], [ %"6", %sipmamergesort_init_bb11 ]
  %h.0 = phi i32 [ 1, %sipmamergesort_init_bb1 ], [ %"24", %sipmamergesort_init_bb11 ]
  %l.1 = phi i32 [ %.n, %sipmamergesort_init_bb1 ], [ %k.5, %sipmamergesort_init_bb11 ]
  %k.1 = phi i32 [ %., %sipmamergesort_init_bb1 ], [ %l.1, %sipmamergesort_init_bb11 ]
  %j.1 = phi i32 [ %n., %sipmamergesort_init_bb1 ], [ %j.4, %sipmamergesort_init_bb11 ]
  %i.1 = phi i32 [ %.1, %sipmamergesort_init_bb1 ], [ %i.4, %sipmamergesort_init_bb11 ]
  %"3" = icmp sge i32 %m.0, %p.0, !dbg !44
  %p.0.m.0 = select i1 %"3", i32 %p.0, i32 %m.0, !dbg !47
  %"4" = sub nsw i32 %m.0, %p.0.m.0, !dbg !48
  %"5" = icmp sge i32 %"4", %p.0, !dbg !49
  %r.0 = select i1 %"5", i32 %p.0, i32 %"4", !dbg !49
  %"6" = sub nsw i32 %"4", %r.0, !dbg !51
  br label %sipmamergesort_init_bb3, !dbg !52

sipmamergesort_init_bb3:                          ; preds = %sipmamergesort_init_bb5, %sipmamergesort_init_bb6, %sipmamergesort_init_bb2
  %r.1 = phi i32 [ %r.0, %sipmamergesort_init_bb2 ], [ %r.1, %sipmamergesort_init_bb5 ], [ %"15", %sipmamergesort_init_bb6 ]
  %q.1 = phi i32 [ %p.0.m.0, %sipmamergesort_init_bb2 ], [ %"13", %sipmamergesort_init_bb5 ], [ %q.1, %sipmamergesort_init_bb6 ]
  %k.2 = phi i32 [ %k.1, %sipmamergesort_init_bb2 ], [ %"11", %sipmamergesort_init_bb5 ], [ %"11", %sipmamergesort_init_bb6 ]
  %j.2 = phi i32 [ %j.1, %sipmamergesort_init_bb2 ], [ %j.2, %sipmamergesort_init_bb5 ], [ %"14", %sipmamergesort_init_bb6 ]
  %i.2 = phi i32 [ %i.1, %sipmamergesort_init_bb2 ], [ %"12", %sipmamergesort_init_bb5 ], [ %i.2, %sipmamergesort_init_bb6 ]
  %"7" = icmp sgt i32 %q.1, 0, !dbg !53
  %"8" = icmp sgt i32 %r.1, 0, !dbg !55
  %.2 = select i1 %"7", i1 %"8", i1 false, !dbg !53
  br i1 %.2, label %sipmamergesort_init_bb4, label %sipmamergesort_init_bb7, !dbg !57

sipmamergesort_init_bb4:                          ; preds = %sipmamergesort_init_bb3
  %"9" = call i32 (...)* @nondet(), !dbg !59
  %"10" = icmp ne i32 %"9", 0, !dbg !59
  %"11" = add nsw i32 %k.2, %h.0, !dbg !61
  br i1 %"10", label %sipmamergesort_init_bb5, label %sipmamergesort_init_bb6, !dbg !59

sipmamergesort_init_bb5:                          ; preds = %sipmamergesort_init_bb4
  %"12" = add nsw i32 %i.2, 1, !dbg !63
  %"13" = sub nsw i32 %q.1, 1, !dbg !64
  br label %sipmamergesort_init_bb3, !dbg !65

sipmamergesort_init_bb6:                          ; preds = %sipmamergesort_init_bb4
  %"14" = sub nsw i32 %j.2, 1, !dbg !66
  %"15" = sub nsw i32 %r.1, 1, !dbg !68
  br label %sipmamergesort_init_bb3

sipmamergesort_init_bb7:                          ; preds = %sipmamergesort_init_bb3, %sipmamergesort_init_bb8
  %r.3 = phi i32 [ %"19", %sipmamergesort_init_bb8 ], [ %r.1, %sipmamergesort_init_bb3 ]
  %k.4 = phi i32 [ %"17", %sipmamergesort_init_bb8 ], [ %k.2, %sipmamergesort_init_bb3 ]
  %j.4 = phi i32 [ %"18", %sipmamergesort_init_bb8 ], [ %j.2, %sipmamergesort_init_bb3 ]
  %"16" = icmp sgt i32 %r.3, 0, !dbg !69
  br i1 %"16", label %sipmamergesort_init_bb8, label %sipmamergesort_init_bb9, !dbg !69

sipmamergesort_init_bb8:                          ; preds = %sipmamergesort_init_bb7
  %"17" = add nsw i32 %k.4, %h.0, !dbg !71
  %"18" = sub nsw i32 %j.4, 1, !dbg !73
  %"19" = sub nsw i32 %r.3, 1, !dbg !74
  br label %sipmamergesort_init_bb7, !dbg !75

sipmamergesort_init_bb9:                          ; preds = %sipmamergesort_init_bb7, %sipmamergesort_init_bb10
  %q.3 = phi i32 [ %"23", %sipmamergesort_init_bb10 ], [ %q.1, %sipmamergesort_init_bb7 ]
  %k.5 = phi i32 [ %"21", %sipmamergesort_init_bb10 ], [ %k.4, %sipmamergesort_init_bb7 ]
  %i.4 = phi i32 [ %"22", %sipmamergesort_init_bb10 ], [ %i.2, %sipmamergesort_init_bb7 ]
  %"20" = icmp sgt i32 %q.3, 0, !dbg !76
  br i1 %"20", label %sipmamergesort_init_bb10, label %sipmamergesort_init_bb11, !dbg !76

sipmamergesort_init_bb10:                         ; preds = %sipmamergesort_init_bb9
  %"21" = add nsw i32 %k.5, %h.0, !dbg !78
  %"22" = add nsw i32 %i.4, 1, !dbg !80
  %"23" = sub nsw i32 %q.3, 1, !dbg !81
  br label %sipmamergesort_init_bb9, !dbg !82

sipmamergesort_init_bb11:                         ; preds = %sipmamergesort_init_bb9
  %"24" = sub nsw i32 0, %h.0, !dbg !83
  call void @llvm.dbg.value(metadata !{i32 %"24"}, i64 0, metadata !19), !dbg !20
  call void @llvm.dbg.value(metadata !{i32 %k.5}, i64 0, metadata !84), !dbg !85
  call void @llvm.dbg.value(metadata !{i32 %l.1}, i64 0, metadata !27), !dbg !28
  call void @llvm.dbg.value(metadata !{i32 %k.5}, i64 0, metadata !29), !dbg !30
  %"25" = icmp sgt i32 %"6", 0, !dbg !86
  br i1 %"25", label %sipmamergesort_init_bb2, label %sipmamergesort_init_bb12, !dbg !86

sipmamergesort_init_bb12:                         ; preds = %sipmamergesort_init_bb11
  %"26" = sub nsw i32 1, %up.0, !dbg !88
  call void @llvm.dbg.value(metadata !{i32 %"26"}, i64 0, metadata !15), !dbg !16
  %"27" = mul nsw i32 2, %p.0, !dbg !89
  call void @llvm.dbg.value(metadata !{i32 %"27"}, i64 0, metadata !17), !dbg !18
  %"28" = icmp slt i32 %"27", %n, !dbg !90
  br i1 %"28", label %sipmamergesort_init_bb1, label %sipmamergesort_init_bb13, !dbg !90

sipmamergesort_init_bb13:                         ; preds = %sipmamergesort_init_bb12
  %"29" = icmp eq i32 %"26", 0, !dbg !92
  br i1 %"29", label %sipmamergesort_init_bb14, label %sipmamergesort_init_bb16, !dbg !92

sipmamergesort_init_bb14:                         ; preds = %sipmamergesort_init_bb13, %sipmamergesort_init_bb15
  %i.5 = phi i32 [ %"31", %sipmamergesort_init_bb15 ], [ 1, %sipmamergesort_init_bb13 ]
  %"30" = icmp sle i32 %i.5, %n, !dbg !94
  br i1 %"30", label %sipmamergesort_init_bb15, label %sipmamergesort_init_bb16, !dbg !94

sipmamergesort_init_bb15:                         ; preds = %sipmamergesort_init_bb14
  %"31" = add nsw i32 %i.5, 1, !dbg !97
  br label %sipmamergesort_init_bb14, !dbg !99

sipmamergesort_init_bb16:                         ; preds = %sipmamergesort_init_bb14, %sipmamergesort_init_bb13
  ret void, !dbg !100
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

!0 = metadata !{i32 786449, metadata !1, i32 12, metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)", i1 false, metadata !"", i32 0, metadata !2, metadata !2, metadata !3, metadata !2, metadata !2, metadata !"", i32 1} ; [ DW_TAG_compile_unit ] [/liveness_analysis/sipmamergesort.c] [DW_LANG_C99]
!1 = metadata !{metadata !"sipmamergesort.c", metadata !"/liveness_analysis"}
!2 = metadata !{}
!3 = metadata !{metadata !4}
!4 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"sipmamergesort_init", metadata !"sipmamergesort_init", metadata !"", i32 3, metadata !6, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (i32)* @sipmamergesort_init, null, null, metadata !2, i32 3} ; [ DW_TAG_subprogram ] [line 3] [def] [sipmamergesort_init]
!5 = metadata !{i32 786473, metadata !1}          ; [ DW_TAG_file_type ] [/liveness_analysis/sipmamergesort.c]
!6 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !7, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!7 = metadata !{null, metadata !8}
!8 = metadata !{i32 786468, null, null, metadata !"int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!9 = metadata !{i32 2, metadata !"Dwarf Version", i32 4}
!10 = metadata !{i32 2, metadata !"Debug Info Version", i32 1}
!11 = metadata !{metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)"}
!12 = metadata !{i32 786689, metadata !4, metadata !"n", metadata !5, i32 16777219, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [n] [line 3]
!13 = metadata !{i32 3, i32 30, metadata !4, null}
!14 = metadata !{i32 1}
!15 = metadata !{i32 786688, metadata !4, metadata !"up", metadata !5, i32 6, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [up] [line 6]
!16 = metadata !{i32 6, i32 7, metadata !4, null}
!17 = metadata !{i32 786688, metadata !4, metadata !"p", metadata !5, i32 5, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [p] [line 5]
!18 = metadata !{i32 5, i32 13, metadata !4, null}
!19 = metadata !{i32 786688, metadata !4, metadata !"h", metadata !5, i32 5, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [h] [line 5]
!20 = metadata !{i32 5, i32 7, metadata !4, null}
!21 = metadata !{i32 786688, metadata !4, metadata !"m", metadata !5, i32 5, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [m] [line 5]
!22 = metadata !{i32 5, i32 10, metadata !4, null}
!23 = metadata !{i32 786688, metadata !4, metadata !"i", metadata !5, i32 4, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [i] [line 4]
!24 = metadata !{i32 4, i32 7, metadata !4, null}
!25 = metadata !{i32 786688, metadata !4, metadata !"j", metadata !5, i32 4, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [j] [line 4]
!26 = metadata !{i32 4, i32 10, metadata !4, null}
!27 = metadata !{i32 786688, metadata !4, metadata !"k", metadata !5, i32 4, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [k] [line 4]
!28 = metadata !{i32 4, i32 13, metadata !4, null}
!29 = metadata !{i32 786688, metadata !4, metadata !"l", metadata !5, i32 4, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [l] [line 4]
!30 = metadata !{i32 4, i32 16, metadata !4, null}
!31 = metadata !{i32 786688, metadata !4, metadata !"q", metadata !5, i32 5, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [q] [line 5]
!32 = metadata !{i32 5, i32 16, metadata !4, null}
!33 = metadata !{i32 786688, metadata !4, metadata !"r", metadata !5, i32 5, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [r] [line 5]
!34 = metadata !{i32 5, i32 19, metadata !4, null}
!35 = metadata !{i32 12, i32 3, metadata !4, null}
!36 = metadata !{i32 15, i32 8, metadata !37, null}
!37 = metadata !{i32 786443, metadata !1, metadata !38, i32 15, i32 8, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/liveness_analysis/sipmamergesort.c]
!38 = metadata !{i32 786443, metadata !1, metadata !4, i32 12, i32 5, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/liveness_analysis/sipmamergesort.c]
!39 = metadata !{i32 18, i32 7, metadata !40, null}
!40 = metadata !{i32 786443, metadata !1, metadata !37, i32 15, i32 11, i32 0, i32 2} ; [ DW_TAG_lexical_block ] [/liveness_analysis/sipmamergesort.c]
!41 = metadata !{i32 19, i32 7, metadata !40, null}
!42 = metadata !{i32 20, i32 5, metadata !40, null}
!43 = metadata !{i32 27, i32 5, metadata !38, null}
!44 = metadata !{i32 28, i32 10, metadata !45, null}
!45 = metadata !{i32 786443, metadata !1, metadata !46, i32 28, i32 10, i32 0, i32 5} ; [ DW_TAG_lexical_block ] [/liveness_analysis/sipmamergesort.c]
!46 = metadata !{i32 786443, metadata !1, metadata !38, i32 27, i32 7, i32 0, i32 4} ; [ DW_TAG_lexical_block ] [/liveness_analysis/sipmamergesort.c]
!47 = metadata !{i32 29, i32 2, metadata !45, null}
!48 = metadata !{i32 31, i32 7, metadata !46, null}
!49 = metadata !{i32 32, i32 10, metadata !50, null}
!50 = metadata !{i32 786443, metadata !1, metadata !46, i32 32, i32 10, i32 0, i32 6} ; [ DW_TAG_lexical_block ] [/liveness_analysis/sipmamergesort.c]
!51 = metadata !{i32 35, i32 7, metadata !46, null}
!52 = metadata !{i32 37, i32 7, metadata !46, null}
!53 = metadata !{i32 37, i32 7, metadata !54, null}
!54 = metadata !{i32 786443, metadata !1, metadata !46, i32 37, i32 7, i32 1, i32 15} ; [ DW_TAG_lexical_block ] [/liveness_analysis/sipmamergesort.c]
!55 = metadata !{i32 37, i32 7, metadata !56, null}
!56 = metadata !{i32 786443, metadata !1, metadata !46, i32 37, i32 7, i32 2, i32 16} ; [ DW_TAG_lexical_block ] [/liveness_analysis/sipmamergesort.c]
!57 = metadata !{i32 37, i32 7, metadata !58, null}
!58 = metadata !{i32 786443, metadata !1, metadata !46, i32 37, i32 7, i32 3, i32 17} ; [ DW_TAG_lexical_block ] [/liveness_analysis/sipmamergesort.c]
!59 = metadata !{i32 38, i32 12, metadata !60, null}
!60 = metadata !{i32 786443, metadata !1, metadata !46, i32 38, i32 12, i32 0, i32 7} ; [ DW_TAG_lexical_block ] [/liveness_analysis/sipmamergesort.c]
!61 = metadata !{i32 40, i32 11, metadata !62, null}
!62 = metadata !{i32 786443, metadata !1, metadata !60, i32 38, i32 21, i32 0, i32 8} ; [ DW_TAG_lexical_block ] [/liveness_analysis/sipmamergesort.c]
!63 = metadata !{i32 41, i32 11, metadata !62, null}
!64 = metadata !{i32 42, i32 11, metadata !62, null}
!65 = metadata !{i32 43, i32 9, metadata !62, null}
!66 = metadata !{i32 46, i32 11, metadata !67, null}
!67 = metadata !{i32 786443, metadata !1, metadata !60, i32 43, i32 16, i32 0, i32 9} ; [ DW_TAG_lexical_block ] [/liveness_analysis/sipmamergesort.c]
!68 = metadata !{i32 47, i32 11, metadata !67, null}
!69 = metadata !{i32 50, i32 7, metadata !70, null}
!70 = metadata !{i32 786443, metadata !1, metadata !46, i32 50, i32 7, i32 1, i32 18} ; [ DW_TAG_lexical_block ] [/liveness_analysis/sipmamergesort.c]
!71 = metadata !{i32 52, i32 9, metadata !72, null}
!72 = metadata !{i32 786443, metadata !1, metadata !46, i32 50, i32 19, i32 0, i32 10} ; [ DW_TAG_lexical_block ] [/liveness_analysis/sipmamergesort.c]
!73 = metadata !{i32 53, i32 9, metadata !72, null}
!74 = metadata !{i32 54, i32 9, metadata !72, null}
!75 = metadata !{i32 55, i32 7, metadata !72, null}
!76 = metadata !{i32 57, i32 7, metadata !77, null}
!77 = metadata !{i32 786443, metadata !1, metadata !46, i32 57, i32 7, i32 1, i32 19} ; [ DW_TAG_lexical_block ] [/liveness_analysis/sipmamergesort.c]
!78 = metadata !{i32 59, i32 9, metadata !79, null}
!79 = metadata !{i32 786443, metadata !1, metadata !46, i32 57, i32 19, i32 0, i32 11} ; [ DW_TAG_lexical_block ] [/liveness_analysis/sipmamergesort.c]
!80 = metadata !{i32 60, i32 9, metadata !79, null}
!81 = metadata !{i32 61, i32 9, metadata !79, null}
!82 = metadata !{i32 62, i32 7, metadata !79, null}
!83 = metadata !{i32 64, i32 7, metadata !46, null}
!84 = metadata !{i32 786688, metadata !4, metadata !"t", metadata !5, i32 4, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [t] [line 4]
!85 = metadata !{i32 4, i32 19, metadata !4, null}
!86 = metadata !{i32 68, i32 5, metadata !87, null}
!87 = metadata !{i32 786443, metadata !1, metadata !46, i32 68, i32 5, i32 1, i32 20} ; [ DW_TAG_lexical_block ] [/liveness_analysis/sipmamergesort.c]
!88 = metadata !{i32 69, i32 5, metadata !38, null}
!89 = metadata !{i32 70, i32 5, metadata !38, null}
!90 = metadata !{i32 71, i32 3, metadata !91, null}
!91 = metadata !{i32 786443, metadata !1, metadata !38, i32 71, i32 3, i32 1, i32 21} ; [ DW_TAG_lexical_block ] [/liveness_analysis/sipmamergesort.c]
!92 = metadata !{i32 73, i32 6, metadata !93, null}
!93 = metadata !{i32 786443, metadata !1, metadata !4, i32 73, i32 6, i32 0, i32 12} ; [ DW_TAG_lexical_block ] [/liveness_analysis/sipmamergesort.c]
!94 = metadata !{i32 75, i32 5, metadata !95, null}
!95 = metadata !{i32 786443, metadata !1, metadata !96, i32 75, i32 5, i32 1, i32 22} ; [ DW_TAG_lexical_block ] [/liveness_analysis/sipmamergesort.c]
!96 = metadata !{i32 786443, metadata !1, metadata !93, i32 73, i32 14, i32 0, i32 13} ; [ DW_TAG_lexical_block ] [/liveness_analysis/sipmamergesort.c]
!97 = metadata !{i32 77, i32 7, metadata !98, null}
!98 = metadata !{i32 786443, metadata !1, metadata !96, i32 75, i32 18, i32 0, i32 14} ; [ DW_TAG_lexical_block ] [/liveness_analysis/sipmamergesort.c]
!99 = metadata !{i32 78, i32 5, metadata !98, null}
!100 = metadata !{i32 81, i32 1, metadata !4, null}

