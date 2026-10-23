; ModuleID = 'sipmamergesort2.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind uwtable
define void @sipmamergesort2(i32 %n) #0 {
sipmamergesort2_bb0:
  call void @llvm.dbg.value(metadata !{i32 %n}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !14, i64 0, metadata !15), !dbg !16
  call void @llvm.dbg.value(metadata !14, i64 0, metadata !17), !dbg !18
  call void @llvm.dbg.value(metadata !14, i64 0, metadata !19), !dbg !20
  call void @llvm.dbg.value(metadata !{i32 %n}, i64 0, metadata !21), !dbg !22
  call void @llvm.dbg.value(metadata !14, i64 0, metadata !23), !dbg !24
  call void @llvm.dbg.value(metadata !{i32 %n}, i64 0, metadata !25), !dbg !26
  call void @llvm.dbg.value(metadata !{i32 %"0"}, i64 0, metadata !27), !dbg !28
  call void @llvm.dbg.value(metadata !{i32 %"1"}, i64 0, metadata !29), !dbg !30
  call void @llvm.dbg.value(metadata !{i32 %p.0}, i64 0, metadata !31), !dbg !32
  call void @llvm.dbg.value(metadata !{i32 %"3"}, i64 0, metadata !21), !dbg !22
  call void @llvm.dbg.value(metadata !{i32 %p.0}, i64 0, metadata !33), !dbg !34
  call void @llvm.dbg.value(metadata !{i32 %"5"}, i64 0, metadata !21), !dbg !22
  call void @llvm.dbg.value(metadata !{i32 %"10"}, i64 0, metadata !23), !dbg !24
  call void @llvm.dbg.value(metadata !{i32 %"11"}, i64 0, metadata !27), !dbg !28
  call void @llvm.dbg.value(metadata !{i32 %"12"}, i64 0, metadata !31), !dbg !32
  call void @llvm.dbg.value(metadata !{i32 %"10"}, i64 0, metadata !23), !dbg !24
  call void @llvm.dbg.value(metadata !{i32 %"13"}, i64 0, metadata !29), !dbg !30
  call void @llvm.dbg.value(metadata !{i32 %"14"}, i64 0, metadata !33), !dbg !34
  call void @llvm.dbg.value(metadata !{i32 %"3"}, i64 0, metadata !33), !dbg !34
  call void @llvm.dbg.value(metadata !{i32 %m.0}, i64 0, metadata !31), !dbg !32
  br label %sipmamergesort2_bb1, !dbg !35

sipmamergesort2_bb1:                              ; preds = %sipmamergesort2_bb24, %sipmamergesort2_bb0
  %p.0 = phi i32 [ 1, %sipmamergesort2_bb0 ], [ %"52", %sipmamergesort2_bb24 ]
  %"0" = add nsw i32 %n, 1, !dbg !36
  %"1" = mul nsw i32 2, %n, !dbg !38
  br label %sipmamergesort2_bb2, !dbg !39

sipmamergesort2_bb2:                              ; preds = %sipmamergesort2_bb11, %sipmamergesort2_bb1
  %m.0 = phi i32 [ %n, %sipmamergesort2_bb1 ], [ %"5", %sipmamergesort2_bb11 ]
  %h.0 = phi i32 [ 1, %sipmamergesort2_bb1 ], [ %"23", %sipmamergesort2_bb11 ]
  %l.0 = phi i32 [ %n, %sipmamergesort2_bb1 ], [ %k.4, %sipmamergesort2_bb11 ]
  %k.0 = phi i32 [ 1, %sipmamergesort2_bb1 ], [ %l.0, %sipmamergesort2_bb11 ]
  %j.0 = phi i32 [ %"1", %sipmamergesort2_bb1 ], [ %j.3, %sipmamergesort2_bb11 ]
  %i.0 = phi i32 [ %"0", %sipmamergesort2_bb1 ], [ %i.3, %sipmamergesort2_bb11 ]
  %"2" = icmp sge i32 %m.0, %p.0, !dbg !40
  %p.0.m.0 = select i1 %"2", i32 %p.0, i32 %m.0, !dbg !43
  %"3" = sub nsw i32 %m.0, %p.0.m.0, !dbg !44
  %"4" = icmp sge i32 %"3", %p.0, !dbg !45
  %r.0 = select i1 %"4", i32 %p.0, i32 %"3", !dbg !45
  %"5" = sub nsw i32 %"3", %r.0, !dbg !47
  br label %sipmamergesort2_bb3, !dbg !48

sipmamergesort2_bb3:                              ; preds = %sipmamergesort2_bb5, %sipmamergesort2_bb6, %sipmamergesort2_bb2
  %r.1 = phi i32 [ %r.0, %sipmamergesort2_bb2 ], [ %r.1, %sipmamergesort2_bb5 ], [ %"14", %sipmamergesort2_bb6 ]
  %q.1 = phi i32 [ %p.0.m.0, %sipmamergesort2_bb2 ], [ %"12", %sipmamergesort2_bb5 ], [ %q.1, %sipmamergesort2_bb6 ]
  %k.1 = phi i32 [ %k.0, %sipmamergesort2_bb2 ], [ %"10", %sipmamergesort2_bb5 ], [ %"10", %sipmamergesort2_bb6 ]
  %j.1 = phi i32 [ %j.0, %sipmamergesort2_bb2 ], [ %j.1, %sipmamergesort2_bb5 ], [ %"13", %sipmamergesort2_bb6 ]
  %i.1 = phi i32 [ %i.0, %sipmamergesort2_bb2 ], [ %"11", %sipmamergesort2_bb5 ], [ %i.1, %sipmamergesort2_bb6 ]
  %"6" = icmp sgt i32 %q.1, 0, !dbg !49
  %"7" = icmp sgt i32 %r.1, 0, !dbg !51
  %. = select i1 %"6", i1 %"7", i1 false, !dbg !49
  br i1 %., label %sipmamergesort2_bb4, label %sipmamergesort2_bb7, !dbg !53

sipmamergesort2_bb4:                              ; preds = %sipmamergesort2_bb3
  %"8" = call i32 (...)* @nondet(), !dbg !55
  %"9" = icmp sgt i32 %"8", 0, !dbg !55
  %"10" = add nsw i32 %k.1, %h.0, !dbg !57
  br i1 %"9", label %sipmamergesort2_bb5, label %sipmamergesort2_bb6, !dbg !55

sipmamergesort2_bb5:                              ; preds = %sipmamergesort2_bb4
  %"11" = add nsw i32 %i.1, 1, !dbg !59
  %"12" = sub nsw i32 %q.1, 1, !dbg !60
  br label %sipmamergesort2_bb3, !dbg !61

sipmamergesort2_bb6:                              ; preds = %sipmamergesort2_bb4
  %"13" = sub nsw i32 %j.1, 1, !dbg !62
  %"14" = sub nsw i32 %r.1, 1, !dbg !64
  br label %sipmamergesort2_bb3

sipmamergesort2_bb7:                              ; preds = %sipmamergesort2_bb3, %sipmamergesort2_bb8
  %r.3 = phi i32 [ %"18", %sipmamergesort2_bb8 ], [ %r.1, %sipmamergesort2_bb3 ]
  %k.3 = phi i32 [ %"16", %sipmamergesort2_bb8 ], [ %k.1, %sipmamergesort2_bb3 ]
  %j.3 = phi i32 [ %"17", %sipmamergesort2_bb8 ], [ %j.1, %sipmamergesort2_bb3 ]
  %"15" = icmp sgt i32 %r.3, 0, !dbg !65
  br i1 %"15", label %sipmamergesort2_bb8, label %sipmamergesort2_bb9, !dbg !65

sipmamergesort2_bb8:                              ; preds = %sipmamergesort2_bb7
  %"16" = add nsw i32 %k.3, %h.0, !dbg !67
  %"17" = sub nsw i32 %j.3, 1, !dbg !69
  %"18" = sub nsw i32 %r.3, 1, !dbg !70
  br label %sipmamergesort2_bb7, !dbg !71

sipmamergesort2_bb9:                              ; preds = %sipmamergesort2_bb7, %sipmamergesort2_bb10
  %q.3 = phi i32 [ %"22", %sipmamergesort2_bb10 ], [ %q.1, %sipmamergesort2_bb7 ]
  %k.4 = phi i32 [ %"20", %sipmamergesort2_bb10 ], [ %k.3, %sipmamergesort2_bb7 ]
  %i.3 = phi i32 [ %"21", %sipmamergesort2_bb10 ], [ %i.1, %sipmamergesort2_bb7 ]
  %"19" = icmp sgt i32 %q.3, 0, !dbg !72
  br i1 %"19", label %sipmamergesort2_bb10, label %sipmamergesort2_bb11, !dbg !72

sipmamergesort2_bb10:                             ; preds = %sipmamergesort2_bb9
  %"20" = add nsw i32 %k.4, %h.0, !dbg !74
  %"21" = add nsw i32 %i.3, 1, !dbg !76
  %"22" = sub nsw i32 %q.3, 1, !dbg !77
  br label %sipmamergesort2_bb9, !dbg !78

sipmamergesort2_bb11:                             ; preds = %sipmamergesort2_bb9
  %"23" = sub nsw i32 0, %h.0, !dbg !79
  call void @llvm.dbg.value(metadata !{i32 %"23"}, i64 0, metadata !19), !dbg !20
  call void @llvm.dbg.value(metadata !{i32 %k.4}, i64 0, metadata !80), !dbg !81
  call void @llvm.dbg.value(metadata !{i32 %l.0}, i64 0, metadata !23), !dbg !24
  call void @llvm.dbg.value(metadata !{i32 %k.4}, i64 0, metadata !25), !dbg !26
  %"24" = icmp sgt i32 %"5", 0, !dbg !82
  br i1 %"24", label %sipmamergesort2_bb2, label %sipmamergesort2_bb12, !dbg !82

sipmamergesort2_bb12:                             ; preds = %sipmamergesort2_bb11
  call void @llvm.dbg.value(metadata !84, i64 0, metadata !15), !dbg !16
  %"25" = mul nsw i32 2, %p.0, !dbg !85
  call void @llvm.dbg.value(metadata !{i32 %"25"}, i64 0, metadata !17), !dbg !18
  %"26" = icmp sge i32 %"25", %n, !dbg !86
  br i1 %"26", label %sipmamergesort2_bb25, label %sipmamergesort2_bb13, !dbg !86

sipmamergesort2_bb13:                             ; preds = %sipmamergesort2_bb12
  call void @llvm.dbg.value(metadata !14, i64 0, metadata !19), !dbg !20
  call void @llvm.dbg.value(metadata !{i32 %n}, i64 0, metadata !21), !dbg !22
  call void @llvm.dbg.value(metadata !14, i64 0, metadata !27), !dbg !28
  call void @llvm.dbg.value(metadata !{i32 %n}, i64 0, metadata !29), !dbg !30
  %"27" = add nsw i32 %n, 1, !dbg !88
  call void @llvm.dbg.value(metadata !{i32 %"27"}, i64 0, metadata !23), !dbg !24
  %"28" = mul nsw i32 2, %n, !dbg !89
  call void @llvm.dbg.value(metadata !{i32 %"28"}, i64 0, metadata !25), !dbg !26
  call void @llvm.dbg.value(metadata !{i32 %"25"}, i64 0, metadata !31), !dbg !32
  call void @llvm.dbg.value(metadata !{i32 %"30"}, i64 0, metadata !21), !dbg !22
  call void @llvm.dbg.value(metadata !{i32 %"25"}, i64 0, metadata !33), !dbg !34
  call void @llvm.dbg.value(metadata !{i32 %"32"}, i64 0, metadata !21), !dbg !22
  call void @llvm.dbg.value(metadata !{i32 %"37"}, i64 0, metadata !23), !dbg !24
  call void @llvm.dbg.value(metadata !{i32 %"38"}, i64 0, metadata !27), !dbg !28
  call void @llvm.dbg.value(metadata !{i32 %"39"}, i64 0, metadata !31), !dbg !32
  call void @llvm.dbg.value(metadata !{i32 %"37"}, i64 0, metadata !23), !dbg !24
  call void @llvm.dbg.value(metadata !{i32 %"40"}, i64 0, metadata !29), !dbg !30
  call void @llvm.dbg.value(metadata !{i32 %"41"}, i64 0, metadata !33), !dbg !34
  call void @llvm.dbg.value(metadata !{i32 %"30"}, i64 0, metadata !33), !dbg !34
  call void @llvm.dbg.value(metadata !{i32 %m.1}, i64 0, metadata !31), !dbg !32
  br label %sipmamergesort2_bb14, !dbg !90

sipmamergesort2_bb14:                             ; preds = %sipmamergesort2_bb23, %sipmamergesort2_bb13
  %m.1 = phi i32 [ %n, %sipmamergesort2_bb13 ], [ %"32", %sipmamergesort2_bb23 ]
  %h.1 = phi i32 [ 1, %sipmamergesort2_bb13 ], [ %"50", %sipmamergesort2_bb23 ]
  %l.1 = phi i32 [ %"28", %sipmamergesort2_bb13 ], [ %k.9, %sipmamergesort2_bb23 ]
  %k.5 = phi i32 [ %"27", %sipmamergesort2_bb13 ], [ %l.1, %sipmamergesort2_bb23 ]
  %j.4 = phi i32 [ %n, %sipmamergesort2_bb13 ], [ %j.7, %sipmamergesort2_bb23 ]
  %i.4 = phi i32 [ 1, %sipmamergesort2_bb13 ], [ %i.7, %sipmamergesort2_bb23 ]
  %"29" = icmp sge i32 %m.1, %"25", !dbg !91
  %.m.1 = select i1 %"29", i32 %"25", i32 %m.1, !dbg !94
  %"30" = sub nsw i32 %m.1, %.m.1, !dbg !95
  %"31" = icmp sge i32 %"30", %"25", !dbg !96
  %r.4 = select i1 %"31", i32 %"25", i32 %"30", !dbg !96
  %"32" = sub nsw i32 %"30", %r.4, !dbg !98
  br label %sipmamergesort2_bb15, !dbg !99

sipmamergesort2_bb15:                             ; preds = %sipmamergesort2_bb17, %sipmamergesort2_bb18, %sipmamergesort2_bb14
  %r.5 = phi i32 [ %r.4, %sipmamergesort2_bb14 ], [ %r.5, %sipmamergesort2_bb17 ], [ %"41", %sipmamergesort2_bb18 ]
  %q.5 = phi i32 [ %.m.1, %sipmamergesort2_bb14 ], [ %"39", %sipmamergesort2_bb17 ], [ %q.5, %sipmamergesort2_bb18 ]
  %k.6 = phi i32 [ %k.5, %sipmamergesort2_bb14 ], [ %"37", %sipmamergesort2_bb17 ], [ %"37", %sipmamergesort2_bb18 ]
  %j.5 = phi i32 [ %j.4, %sipmamergesort2_bb14 ], [ %j.5, %sipmamergesort2_bb17 ], [ %"40", %sipmamergesort2_bb18 ]
  %i.5 = phi i32 [ %i.4, %sipmamergesort2_bb14 ], [ %"38", %sipmamergesort2_bb17 ], [ %i.5, %sipmamergesort2_bb18 ]
  %"33" = icmp sgt i32 %q.5, 0, !dbg !100
  %"34" = icmp sgt i32 %r.5, 0, !dbg !102
  %.1 = select i1 %"33", i1 %"34", i1 false, !dbg !100
  br i1 %.1, label %sipmamergesort2_bb16, label %sipmamergesort2_bb19, !dbg !104

sipmamergesort2_bb16:                             ; preds = %sipmamergesort2_bb15
  %"35" = call i32 (...)* @nondet(), !dbg !106
  %"36" = icmp sgt i32 %"35", 0, !dbg !106
  %"37" = add nsw i32 %k.6, %h.1, !dbg !108
  br i1 %"36", label %sipmamergesort2_bb17, label %sipmamergesort2_bb18, !dbg !106

sipmamergesort2_bb17:                             ; preds = %sipmamergesort2_bb16
  %"38" = add nsw i32 %i.5, 1, !dbg !110
  %"39" = sub nsw i32 %q.5, 1, !dbg !111
  br label %sipmamergesort2_bb15, !dbg !112

sipmamergesort2_bb18:                             ; preds = %sipmamergesort2_bb16
  %"40" = sub nsw i32 %j.5, 1, !dbg !113
  %"41" = sub nsw i32 %r.5, 1, !dbg !115
  br label %sipmamergesort2_bb15

sipmamergesort2_bb19:                             ; preds = %sipmamergesort2_bb15, %sipmamergesort2_bb20
  %r.7 = phi i32 [ %"45", %sipmamergesort2_bb20 ], [ %r.5, %sipmamergesort2_bb15 ]
  %k.8 = phi i32 [ %"43", %sipmamergesort2_bb20 ], [ %k.6, %sipmamergesort2_bb15 ]
  %j.7 = phi i32 [ %"44", %sipmamergesort2_bb20 ], [ %j.5, %sipmamergesort2_bb15 ]
  %"42" = icmp sgt i32 %r.7, 0, !dbg !116
  br i1 %"42", label %sipmamergesort2_bb20, label %sipmamergesort2_bb21, !dbg !116

sipmamergesort2_bb20:                             ; preds = %sipmamergesort2_bb19
  %"43" = add nsw i32 %k.8, %h.1, !dbg !118
  %"44" = sub nsw i32 %j.7, 1, !dbg !120
  %"45" = sub nsw i32 %r.7, 1, !dbg !121
  br label %sipmamergesort2_bb19, !dbg !122

sipmamergesort2_bb21:                             ; preds = %sipmamergesort2_bb19, %sipmamergesort2_bb22
  %q.7 = phi i32 [ %"49", %sipmamergesort2_bb22 ], [ %q.5, %sipmamergesort2_bb19 ]
  %k.9 = phi i32 [ %"47", %sipmamergesort2_bb22 ], [ %k.8, %sipmamergesort2_bb19 ]
  %i.7 = phi i32 [ %"48", %sipmamergesort2_bb22 ], [ %i.5, %sipmamergesort2_bb19 ]
  %"46" = icmp sgt i32 %q.7, 0, !dbg !123
  br i1 %"46", label %sipmamergesort2_bb22, label %sipmamergesort2_bb23, !dbg !123

sipmamergesort2_bb22:                             ; preds = %sipmamergesort2_bb21
  %"47" = add nsw i32 %k.9, %h.1, !dbg !125
  %"48" = add nsw i32 %i.7, 1, !dbg !127
  %"49" = sub nsw i32 %q.7, 1, !dbg !128
  br label %sipmamergesort2_bb21, !dbg !129

sipmamergesort2_bb23:                             ; preds = %sipmamergesort2_bb21
  %"50" = sub nsw i32 0, %h.1, !dbg !130
  call void @llvm.dbg.value(metadata !{i32 %"50"}, i64 0, metadata !19), !dbg !20
  call void @llvm.dbg.value(metadata !{i32 %k.9}, i64 0, metadata !80), !dbg !81
  call void @llvm.dbg.value(metadata !{i32 %l.1}, i64 0, metadata !23), !dbg !24
  call void @llvm.dbg.value(metadata !{i32 %k.9}, i64 0, metadata !25), !dbg !26
  %"51" = icmp sgt i32 %"32", 0, !dbg !131
  br i1 %"51", label %sipmamergesort2_bb14, label %sipmamergesort2_bb24, !dbg !131

sipmamergesort2_bb24:                             ; preds = %sipmamergesort2_bb23
  call void @llvm.dbg.value(metadata !14, i64 0, metadata !15), !dbg !16
  %"52" = mul nsw i32 2, %"25", !dbg !133
  call void @llvm.dbg.value(metadata !{i32 %"52"}, i64 0, metadata !17), !dbg !18
  %"53" = icmp slt i32 %"52", %n, !dbg !134
  br i1 %"53", label %sipmamergesort2_bb1, label %sipmamergesort2_bb25, !dbg !134

sipmamergesort2_bb25:                             ; preds = %sipmamergesort2_bb12, %sipmamergesort2_bb24
  %up.0 = phi i32 [ 1, %sipmamergesort2_bb24 ], [ 0, %sipmamergesort2_bb12 ]
  %"54" = icmp eq i32 %up.0, 0, !dbg !136
  br i1 %"54", label %sipmamergesort2_bb26, label %sipmamergesort2_bb28, !dbg !136

sipmamergesort2_bb26:                             ; preds = %sipmamergesort2_bb25, %sipmamergesort2_bb27
  %i.8 = phi i32 [ %"56", %sipmamergesort2_bb27 ], [ 1, %sipmamergesort2_bb25 ]
  %"55" = icmp sle i32 %i.8, %n, !dbg !138
  br i1 %"55", label %sipmamergesort2_bb27, label %sipmamergesort2_bb28, !dbg !138

sipmamergesort2_bb27:                             ; preds = %sipmamergesort2_bb26
  %"56" = add nsw i32 %i.8, 1, !dbg !141
  br label %sipmamergesort2_bb26, !dbg !143

sipmamergesort2_bb28:                             ; preds = %sipmamergesort2_bb26, %sipmamergesort2_bb25
  ret void, !dbg !144
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

!0 = metadata !{i32 786449, metadata !1, i32 12, metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)", i1 false, metadata !"", i32 0, metadata !2, metadata !2, metadata !3, metadata !2, metadata !2, metadata !"", i32 1} ; [ DW_TAG_compile_unit ] [/liveness_analysis/sipmamergesort2.c] [DW_LANG_C99]
!1 = metadata !{metadata !"sipmamergesort2.c", metadata !"/liveness_analysis"}
!2 = metadata !{}
!3 = metadata !{metadata !4}
!4 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"sipmamergesort2", metadata !"sipmamergesort2", metadata !"", i32 3, metadata !6, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (i32)* @sipmamergesort2, null, null, metadata !2, i32 3} ; [ DW_TAG_subprogram ] [line 3] [def] [sipmamergesort2]
!5 = metadata !{i32 786473, metadata !1}          ; [ DW_TAG_file_type ] [/liveness_analysis/sipmamergesort2.c]
!6 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !7, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!7 = metadata !{null, metadata !8}
!8 = metadata !{i32 786468, null, null, metadata !"int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!9 = metadata !{i32 2, metadata !"Dwarf Version", i32 4}
!10 = metadata !{i32 2, metadata !"Debug Info Version", i32 1}
!11 = metadata !{metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)"}
!12 = metadata !{i32 786689, metadata !4, metadata !"n", metadata !5, i32 16777219, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [n] [line 3]
!13 = metadata !{i32 3, i32 26, metadata !4, null}
!14 = metadata !{i32 1}
!15 = metadata !{i32 786688, metadata !4, metadata !"up", metadata !5, i32 6, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [up] [line 6]
!16 = metadata !{i32 6, i32 7, metadata !4, null}
!17 = metadata !{i32 786688, metadata !4, metadata !"p", metadata !5, i32 5, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [p] [line 5]
!18 = metadata !{i32 5, i32 13, metadata !4, null}
!19 = metadata !{i32 786688, metadata !4, metadata !"h", metadata !5, i32 5, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [h] [line 5]
!20 = metadata !{i32 5, i32 7, metadata !4, null}
!21 = metadata !{i32 786688, metadata !4, metadata !"m", metadata !5, i32 5, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [m] [line 5]
!22 = metadata !{i32 5, i32 10, metadata !4, null}
!23 = metadata !{i32 786688, metadata !4, metadata !"k", metadata !5, i32 4, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [k] [line 4]
!24 = metadata !{i32 4, i32 13, metadata !4, null}
!25 = metadata !{i32 786688, metadata !4, metadata !"l", metadata !5, i32 4, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [l] [line 4]
!26 = metadata !{i32 4, i32 16, metadata !4, null}
!27 = metadata !{i32 786688, metadata !4, metadata !"i", metadata !5, i32 4, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [i] [line 4]
!28 = metadata !{i32 4, i32 7, metadata !4, null}
!29 = metadata !{i32 786688, metadata !4, metadata !"j", metadata !5, i32 4, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [j] [line 4]
!30 = metadata !{i32 4, i32 10, metadata !4, null}
!31 = metadata !{i32 786688, metadata !4, metadata !"q", metadata !5, i32 5, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [q] [line 5]
!32 = metadata !{i32 5, i32 16, metadata !4, null}
!33 = metadata !{i32 786688, metadata !4, metadata !"r", metadata !5, i32 5, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [r] [line 5]
!34 = metadata !{i32 5, i32 19, metadata !4, null}
!35 = metadata !{i32 12, i32 3, metadata !4, null}
!36 = metadata !{i32 19, i32 5, metadata !37, null}
!37 = metadata !{i32 786443, metadata !1, metadata !4, i32 12, i32 5, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/liveness_analysis/sipmamergesort2.c]
!38 = metadata !{i32 20, i32 5, metadata !37, null}
!39 = metadata !{i32 23, i32 5, metadata !37, null}
!40 = metadata !{i32 24, i32 10, metadata !41, null}
!41 = metadata !{i32 786443, metadata !1, metadata !42, i32 24, i32 10, i32 0, i32 2} ; [ DW_TAG_lexical_block ] [/liveness_analysis/sipmamergesort2.c]
!42 = metadata !{i32 786443, metadata !1, metadata !37, i32 23, i32 7, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/liveness_analysis/sipmamergesort2.c]
!43 = metadata !{i32 25, i32 2, metadata !41, null}
!44 = metadata !{i32 27, i32 7, metadata !42, null}
!45 = metadata !{i32 28, i32 10, metadata !46, null}
!46 = metadata !{i32 786443, metadata !1, metadata !42, i32 28, i32 10, i32 0, i32 3} ; [ DW_TAG_lexical_block ] [/liveness_analysis/sipmamergesort2.c]
!47 = metadata !{i32 31, i32 7, metadata !42, null}
!48 = metadata !{i32 33, i32 7, metadata !42, null}
!49 = metadata !{i32 33, i32 7, metadata !50, null}
!50 = metadata !{i32 786443, metadata !1, metadata !42, i32 33, i32 7, i32 1, i32 21} ; [ DW_TAG_lexical_block ] [/liveness_analysis/sipmamergesort2.c]
!51 = metadata !{i32 33, i32 7, metadata !52, null}
!52 = metadata !{i32 786443, metadata !1, metadata !42, i32 33, i32 7, i32 2, i32 22} ; [ DW_TAG_lexical_block ] [/liveness_analysis/sipmamergesort2.c]
!53 = metadata !{i32 33, i32 7, metadata !54, null}
!54 = metadata !{i32 786443, metadata !1, metadata !42, i32 33, i32 7, i32 3, i32 23} ; [ DW_TAG_lexical_block ] [/liveness_analysis/sipmamergesort2.c]
!55 = metadata !{i32 34, i32 12, metadata !56, null}
!56 = metadata !{i32 786443, metadata !1, metadata !42, i32 34, i32 12, i32 0, i32 4} ; [ DW_TAG_lexical_block ] [/liveness_analysis/sipmamergesort2.c]
!57 = metadata !{i32 36, i32 11, metadata !58, null}
!58 = metadata !{i32 786443, metadata !1, metadata !56, i32 34, i32 23, i32 0, i32 5} ; [ DW_TAG_lexical_block ] [/liveness_analysis/sipmamergesort2.c]
!59 = metadata !{i32 37, i32 11, metadata !58, null}
!60 = metadata !{i32 38, i32 11, metadata !58, null}
!61 = metadata !{i32 39, i32 9, metadata !58, null}
!62 = metadata !{i32 42, i32 11, metadata !63, null}
!63 = metadata !{i32 786443, metadata !1, metadata !56, i32 39, i32 16, i32 0, i32 6} ; [ DW_TAG_lexical_block ] [/liveness_analysis/sipmamergesort2.c]
!64 = metadata !{i32 43, i32 11, metadata !63, null}
!65 = metadata !{i32 46, i32 7, metadata !66, null}
!66 = metadata !{i32 786443, metadata !1, metadata !42, i32 46, i32 7, i32 1, i32 24} ; [ DW_TAG_lexical_block ] [/liveness_analysis/sipmamergesort2.c]
!67 = metadata !{i32 48, i32 9, metadata !68, null}
!68 = metadata !{i32 786443, metadata !1, metadata !42, i32 46, i32 19, i32 0, i32 7} ; [ DW_TAG_lexical_block ] [/liveness_analysis/sipmamergesort2.c]
!69 = metadata !{i32 49, i32 9, metadata !68, null}
!70 = metadata !{i32 50, i32 9, metadata !68, null}
!71 = metadata !{i32 51, i32 7, metadata !68, null}
!72 = metadata !{i32 53, i32 7, metadata !73, null}
!73 = metadata !{i32 786443, metadata !1, metadata !42, i32 53, i32 7, i32 1, i32 25} ; [ DW_TAG_lexical_block ] [/liveness_analysis/sipmamergesort2.c]
!74 = metadata !{i32 55, i32 9, metadata !75, null}
!75 = metadata !{i32 786443, metadata !1, metadata !42, i32 53, i32 19, i32 0, i32 8} ; [ DW_TAG_lexical_block ] [/liveness_analysis/sipmamergesort2.c]
!76 = metadata !{i32 56, i32 9, metadata !75, null}
!77 = metadata !{i32 57, i32 9, metadata !75, null}
!78 = metadata !{i32 58, i32 7, metadata !75, null} ; [ DW_TAG_imported_module ]
!79 = metadata !{i32 60, i32 7, metadata !42, null}
!80 = metadata !{i32 786688, metadata !4, metadata !"t", metadata !5, i32 4, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [t] [line 4]
!81 = metadata !{i32 4, i32 19, metadata !4, null}
!82 = metadata !{i32 64, i32 5, metadata !83, null}
!83 = metadata !{i32 786443, metadata !1, metadata !42, i32 64, i32 5, i32 1, i32 26} ; [ DW_TAG_lexical_block ] [/liveness_analysis/sipmamergesort2.c]
!84 = metadata !{i32 0}
!85 = metadata !{i32 66, i32 5, metadata !37, null}
!86 = metadata !{i32 69, i32 9, metadata !87, null}
!87 = metadata !{i32 786443, metadata !1, metadata !37, i32 69, i32 9, i32 0, i32 9} ; [ DW_TAG_lexical_block ] [/liveness_analysis/sipmamergesort2.c]
!88 = metadata !{i32 76, i32 5, metadata !37, null}
!89 = metadata !{i32 77, i32 5, metadata !37, null}
!90 = metadata !{i32 79, i32 5, metadata !37, null}
!91 = metadata !{i32 80, i32 10, metadata !92, null}
!92 = metadata !{i32 786443, metadata !1, metadata !93, i32 80, i32 10, i32 0, i32 11} ; [ DW_TAG_lexical_block ] [/liveness_analysis/sipmamergesort2.c]
!93 = metadata !{i32 786443, metadata !1, metadata !37, i32 79, i32 7, i32 0, i32 10} ; [ DW_TAG_lexical_block ] [/liveness_analysis/sipmamergesort2.c]
!94 = metadata !{i32 81, i32 2, metadata !92, null}
!95 = metadata !{i32 83, i32 7, metadata !93, null}
!96 = metadata !{i32 84, i32 10, metadata !97, null}
!97 = metadata !{i32 786443, metadata !1, metadata !93, i32 84, i32 10, i32 0, i32 12} ; [ DW_TAG_lexical_block ] [/liveness_analysis/sipmamergesort2.c]
!98 = metadata !{i32 87, i32 7, metadata !93, null}
!99 = metadata !{i32 89, i32 7, metadata !93, null}
!100 = metadata !{i32 89, i32 7, metadata !101, null}
!101 = metadata !{i32 786443, metadata !1, metadata !93, i32 89, i32 7, i32 1, i32 28} ; [ DW_TAG_lexical_block ] [/liveness_analysis/sipmamergesort2.c]
!102 = metadata !{i32 89, i32 7, metadata !103, null}
!103 = metadata !{i32 786443, metadata !1, metadata !93, i32 89, i32 7, i32 2, i32 29} ; [ DW_TAG_lexical_block ] [/liveness_analysis/sipmamergesort2.c]
!104 = metadata !{i32 89, i32 7, metadata !105, null}
!105 = metadata !{i32 786443, metadata !1, metadata !93, i32 89, i32 7, i32 3, i32 30} ; [ DW_TAG_lexical_block ] [/liveness_analysis/sipmamergesort2.c]
!106 = metadata !{i32 90, i32 12, metadata !107, null}
!107 = metadata !{i32 786443, metadata !1, metadata !93, i32 90, i32 12, i32 0, i32 13} ; [ DW_TAG_lexical_block ] [/liveness_analysis/sipmamergesort2.c]
!108 = metadata !{i32 92, i32 11, metadata !109, null}
!109 = metadata !{i32 786443, metadata !1, metadata !107, i32 90, i32 23, i32 0, i32 14} ; [ DW_TAG_lexical_block ] [/liveness_analysis/sipmamergesort2.c]
!110 = metadata !{i32 93, i32 11, metadata !109, null}
!111 = metadata !{i32 94, i32 11, metadata !109, null}
!112 = metadata !{i32 95, i32 9, metadata !109, null}
!113 = metadata !{i32 98, i32 11, metadata !114, null}
!114 = metadata !{i32 786443, metadata !1, metadata !107, i32 95, i32 16, i32 0, i32 15} ; [ DW_TAG_lexical_block ] [/liveness_analysis/sipmamergesort2.c]
!115 = metadata !{i32 99, i32 11, metadata !114, null}
!116 = metadata !{i32 102, i32 7, metadata !117, null}
!117 = metadata !{i32 786443, metadata !1, metadata !93, i32 102, i32 7, i32 1, i32 31} ; [ DW_TAG_lexical_block ] [/liveness_analysis/sipmamergesort2.c]
!118 = metadata !{i32 104, i32 9, metadata !119, null}
!119 = metadata !{i32 786443, metadata !1, metadata !93, i32 102, i32 19, i32 0, i32 16} ; [ DW_TAG_lexical_block ] [/liveness_analysis/sipmamergesort2.c]
!120 = metadata !{i32 105, i32 9, metadata !119, null}
!121 = metadata !{i32 106, i32 9, metadata !119, null}
!122 = metadata !{i32 107, i32 7, metadata !119, null}
!123 = metadata !{i32 109, i32 7, metadata !124, null}
!124 = metadata !{i32 786443, metadata !1, metadata !93, i32 109, i32 7, i32 1, i32 32} ; [ DW_TAG_lexical_block ] [/liveness_analysis/sipmamergesort2.c]
!125 = metadata !{i32 111, i32 9, metadata !126, null}
!126 = metadata !{i32 786443, metadata !1, metadata !93, i32 109, i32 19, i32 0, i32 17} ; [ DW_TAG_lexical_block ] [/liveness_analysis/sipmamergesort2.c]
!127 = metadata !{i32 112, i32 9, metadata !126, null}
!128 = metadata !{i32 113, i32 9, metadata !126, null}
!129 = metadata !{i32 114, i32 7, metadata !126, null}
!130 = metadata !{i32 116, i32 7, metadata !93, null}
!131 = metadata !{i32 120, i32 5, metadata !132, null}
!132 = metadata !{i32 786443, metadata !1, metadata !93, i32 120, i32 5, i32 1, i32 33} ; [ DW_TAG_lexical_block ] [/liveness_analysis/sipmamergesort2.c]
!133 = metadata !{i32 122, i32 5, metadata !37, null}
!134 = metadata !{i32 125, i32 3, metadata !135, null}
!135 = metadata !{i32 786443, metadata !1, metadata !37, i32 125, i32 3, i32 1, i32 34} ; [ DW_TAG_lexical_block ] [/liveness_analysis/sipmamergesort2.c]
!136 = metadata !{i32 131, i32 6, metadata !137, null}
!137 = metadata !{i32 786443, metadata !1, metadata !4, i32 131, i32 6, i32 0, i32 18} ; [ DW_TAG_lexical_block ] [/liveness_analysis/sipmamergesort2.c]
!138 = metadata !{i32 133, i32 5, metadata !139, null}
!139 = metadata !{i32 786443, metadata !1, metadata !140, i32 133, i32 5, i32 1, i32 35} ; [ DW_TAG_lexical_block ] [/liveness_analysis/sipmamergesort2.c]
!140 = metadata !{i32 786443, metadata !1, metadata !137, i32 131, i32 14, i32 0, i32 19} ; [ DW_TAG_lexical_block ] [/liveness_analysis/sipmamergesort2.c]
!141 = metadata !{i32 135, i32 7, metadata !142, null}
!142 = metadata !{i32 786443, metadata !1, metadata !140, i32 133, i32 18, i32 0, i32 20} ; [ DW_TAG_lexical_block ] [/liveness_analysis/sipmamergesort2.c]
!143 = metadata !{i32 136, i32 5, metadata !142, null}
!144 = metadata !{i32 139, i32 1, metadata !4, null}

