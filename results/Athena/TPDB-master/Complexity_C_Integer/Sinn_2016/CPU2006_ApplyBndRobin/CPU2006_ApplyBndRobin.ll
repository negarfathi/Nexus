; ModuleID = 'CPU2006_ApplyBndRobin.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind uwtable
define void @ApplyBndRobin(i32 %GH_cctk_lsh_0, i32 %GH_cctk_lsh_1, i32 %GH_cctk_lsh_2, i32 %first_var, i32 %num_vars) #0 {
ApplyBndRobin_bb0:
  call void @llvm.dbg.value(metadata !{i32 %GH_cctk_lsh_0}, i64 0, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata !{i32 %GH_cctk_lsh_1}, i64 0, metadata !14), !dbg !15
  call void @llvm.dbg.value(metadata !{i32 %GH_cctk_lsh_2}, i64 0, metadata !16), !dbg !17
  call void @llvm.dbg.value(metadata !{i32 %first_var}, i64 0, metadata !18), !dbg !19
  call void @llvm.dbg.value(metadata !{i32 %num_vars}, i64 0, metadata !20), !dbg !21
  call void @llvm.dbg.value(metadata !{i32 %first_var}, i64 0, metadata !22), !dbg !23
  call void @llvm.dbg.value(metadata !24, i64 0, metadata !25), !dbg !28
  call void @llvm.dbg.value(metadata !24, i64 0, metadata !29), !dbg !30
  call void @llvm.dbg.value(metadata !31, i64 0, metadata !29), !dbg !30
  call void @llvm.dbg.value(metadata !24, i64 0, metadata !32), !dbg !33
  call void @llvm.dbg.value(metadata !24, i64 0, metadata !34), !dbg !35
  call void @llvm.dbg.value(metadata !31, i64 0, metadata !34), !dbg !35
  call void @llvm.dbg.value(metadata !31, i64 0, metadata !36), !dbg !37
  call void @llvm.dbg.value(metadata !{i32 %"18"}, i64 0, metadata !36), !dbg !37
  call void @llvm.dbg.value(metadata !{i32 %"19"}, i64 0, metadata !32), !dbg !33
  call void @llvm.dbg.value(metadata !38, i64 0, metadata !34), !dbg !35
  call void @llvm.dbg.value(metadata !38, i64 0, metadata !29), !dbg !30
  br label %ApplyBndRobin_bb1, !dbg !39

ApplyBndRobin_bb1:                                ; preds = %ApplyBndRobin_bb16, %ApplyBndRobin_bb0
  %var.0 = phi i32 [ %first_var, %ApplyBndRobin_bb0 ], [ %"21", %ApplyBndRobin_bb16 ]
  %"0" = add nsw i32 %first_var, %num_vars, !dbg !40
  %"1" = icmp slt i32 %var.0, %"0", !dbg !40
  br i1 %"1", label %ApplyBndRobin_bb2, label %ApplyBndRobin_bb17, !dbg !40

ApplyBndRobin_bb2:                                ; preds = %ApplyBndRobin_bb1, %ApplyBndRobin_bb15
  %k.0 = phi i32 [ %"20", %ApplyBndRobin_bb15 ], [ 0, %ApplyBndRobin_bb1 ]
  %"2" = icmp slt i32 %k.0, %GH_cctk_lsh_2, !dbg !43
  br i1 %"2", label %ApplyBndRobin_bb3, label %ApplyBndRobin_bb16, !dbg !43

ApplyBndRobin_bb3:                                ; preds = %ApplyBndRobin_bb2
  %"3" = icmp eq i32 %k.0, 0, !dbg !47
  br i1 %"3", label %ApplyBndRobin_bb4, label %ApplyBndRobin_bb5, !dbg !47

ApplyBndRobin_bb4:                                ; preds = %ApplyBndRobin_bb3
  %"4" = call i32 (...)* @random(), !dbg !50
  %"5" = icmp ne i32 %"4", 0, !dbg !50
  br i1 %"5", label %ApplyBndRobin_bb6, label %ApplyBndRobin_bb5, !dbg !50

ApplyBndRobin_bb5:                                ; preds = %ApplyBndRobin_bb4, %ApplyBndRobin_bb3
  %"6" = call i32 (...)* @random(), !dbg !52
  %"7" = icmp ne i32 %"6", 0, !dbg !52
  %. = select i1 %"7", i32 -1, i32 0, !dbg !52
  br label %ApplyBndRobin_bb6

ApplyBndRobin_bb6:                                ; preds = %ApplyBndRobin_bb4, %ApplyBndRobin_bb5
  %dz.1 = phi i32 [ %., %ApplyBndRobin_bb5 ], [ 1, %ApplyBndRobin_bb4 ]
  br label %ApplyBndRobin_bb7, !dbg !54

ApplyBndRobin_bb7:                                ; preds = %ApplyBndRobin_bb14, %ApplyBndRobin_bb6
  %j.0 = phi i32 [ 0, %ApplyBndRobin_bb6 ], [ %"19", %ApplyBndRobin_bb14 ]
  %"8" = icmp slt i32 %j.0, %GH_cctk_lsh_1, !dbg !56
  br i1 %"8", label %ApplyBndRobin_bb8, label %ApplyBndRobin_bb15, !dbg !56

ApplyBndRobin_bb8:                                ; preds = %ApplyBndRobin_bb7
  %"9" = icmp eq i32 %j.0, 0, !dbg !59
  br i1 %"9", label %ApplyBndRobin_bb9, label %ApplyBndRobin_bb10, !dbg !59

ApplyBndRobin_bb9:                                ; preds = %ApplyBndRobin_bb8
  %"10" = call i32 (...)* @random(), !dbg !62
  %"11" = icmp ne i32 %"10", 0, !dbg !62
  br i1 %"11", label %ApplyBndRobin_bb11, label %ApplyBndRobin_bb10, !dbg !62

ApplyBndRobin_bb10:                               ; preds = %ApplyBndRobin_bb9, %ApplyBndRobin_bb8
  %"12" = call i32 (...)* @random(), !dbg !64
  %"13" = icmp ne i32 %"12", 0, !dbg !64
  %.1 = select i1 %"13", i32 -1, i32 0, !dbg !64
  br label %ApplyBndRobin_bb11

ApplyBndRobin_bb11:                               ; preds = %ApplyBndRobin_bb9, %ApplyBndRobin_bb10
  %dy.1 = phi i32 [ %.1, %ApplyBndRobin_bb10 ], [ 1, %ApplyBndRobin_bb9 ]
  %"14" = icmp ne i32 %dy.1, 0, !dbg !66
  %"15" = icmp ne i32 %dz.1, 0, !dbg !68
  %or.cond = or i1 %"14", %"15", !dbg !66
  br i1 %or.cond, label %ApplyBndRobin_bb12, label %ApplyBndRobin_bb14, !dbg !66

ApplyBndRobin_bb12:                               ; preds = %ApplyBndRobin_bb11, %ApplyBndRobin_bb13
  %i.0 = phi i32 [ %"18", %ApplyBndRobin_bb13 ], [ 1, %ApplyBndRobin_bb11 ]
  %"16" = sub nsw i32 %GH_cctk_lsh_0, 1, !dbg !70
  %"17" = icmp slt i32 %i.0, %"16", !dbg !70
  br i1 %"17", label %ApplyBndRobin_bb13, label %ApplyBndRobin_bb14, !dbg !70

ApplyBndRobin_bb13:                               ; preds = %ApplyBndRobin_bb12
  %"18" = add nsw i32 %i.0, 1, !dbg !75
  br label %ApplyBndRobin_bb12, !dbg !75

ApplyBndRobin_bb14:                               ; preds = %ApplyBndRobin_bb11, %ApplyBndRobin_bb12
  %"19" = add nsw i32 %j.0, 1, !dbg !76
  br label %ApplyBndRobin_bb7, !dbg !76

ApplyBndRobin_bb15:                               ; preds = %ApplyBndRobin_bb7
  %"20" = add nsw i32 %k.0, 1, !dbg !77
  call void @llvm.dbg.value(metadata !{i32 %"20"}, i64 0, metadata !25), !dbg !28
  br label %ApplyBndRobin_bb2, !dbg !77

ApplyBndRobin_bb16:                               ; preds = %ApplyBndRobin_bb2
  %"21" = add nsw i32 %var.0, 1, !dbg !78
  call void @llvm.dbg.value(metadata !{i32 %"21"}, i64 0, metadata !22), !dbg !23
  br label %ApplyBndRobin_bb1, !dbg !78

ApplyBndRobin_bb17:                               ; preds = %ApplyBndRobin_bb1
  ret void, !dbg !79
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

!0 = metadata !{i32 786449, metadata !1, i32 12, metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)", i1 false, metadata !"", i32 0, metadata !2, metadata !2, metadata !3, metadata !2, metadata !2, metadata !"", i32 1} ; [ DW_TAG_compile_unit ] [/liveness_analysis/CPU2006_ApplyBndRobin.c] [DW_LANG_C99]
!1 = metadata !{metadata !"CPU2006_ApplyBndRobin.c", metadata !"/liveness_analysis"}
!2 = metadata !{}
!3 = metadata !{metadata !4}
!4 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"ApplyBndRobin", metadata !"ApplyBndRobin", metadata !"", i32 6, metadata !6, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (i32, i32, i32, i32, i32)* @ApplyBndRobin, null, null, metadata !2, i32 6} ; [ DW_TAG_subprogram ] [line 6] [def] [ApplyBndRobin]
!5 = metadata !{i32 786473, metadata !1}          ; [ DW_TAG_file_type ] [/liveness_analysis/CPU2006_ApplyBndRobin.c]
!6 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !7, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!7 = metadata !{null, metadata !8, metadata !8, metadata !8, metadata !8, metadata !8}
!8 = metadata !{i32 786468, null, null, metadata !"int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!9 = metadata !{i32 2, metadata !"Dwarf Version", i32 4}
!10 = metadata !{i32 2, metadata !"Debug Info Version", i32 1}
!11 = metadata !{metadata !"clang version 3.5.2 (http://llvm.org/git/clang.git 395a76d5372abd34fa791f6c10ebcdf43d74c8bd) (http://llvm.org/git/llvm.git a4cf325e41fca33c7ce7deef39a7bcf25fb38266)"}
!12 = metadata !{i32 786689, metadata !4, metadata !"GH_cctk_lsh_0", metadata !5, i32 16777222, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [GH_cctk_lsh_0] [line 6]
!13 = metadata !{i32 6, i32 24, metadata !4, null}
!14 = metadata !{i32 786689, metadata !4, metadata !"GH_cctk_lsh_1", metadata !5, i32 33554438, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [GH_cctk_lsh_1] [line 6]
!15 = metadata !{i32 6, i32 43, metadata !4, null}
!16 = metadata !{i32 786689, metadata !4, metadata !"GH_cctk_lsh_2", metadata !5, i32 50331654, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [GH_cctk_lsh_2] [line 6]
!17 = metadata !{i32 6, i32 62, metadata !4, null}
!18 = metadata !{i32 786689, metadata !4, metadata !"first_var", metadata !5, i32 67108870, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [first_var] [line 6]
!19 = metadata !{i32 6, i32 81, metadata !4, null}
!20 = metadata !{i32 786689, metadata !4, metadata !"num_vars", metadata !5, i32 83886086, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [num_vars] [line 6]
!21 = metadata !{i32 6, i32 96, metadata !4, null}
!22 = metadata !{i32 786688, metadata !4, metadata !"var", metadata !5, i32 7, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [var] [line 7]
!23 = metadata !{i32 7, i32 7, metadata !4, null}
!24 = metadata !{i32 0}
!25 = metadata !{i32 786688, metadata !26, metadata !"k", metadata !5, i32 9, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [k] [line 9]
!26 = metadata !{i32 786443, metadata !1, metadata !27, i32 8, i32 60, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_ApplyBndRobin.c]
!27 = metadata !{i32 786443, metadata !1, metadata !4, i32 8, i32 3, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_ApplyBndRobin.c]
!28 = metadata !{i32 9, i32 12, metadata !26, null}
!29 = metadata !{i32 786688, metadata !26, metadata !"dz", metadata !5, i32 10, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [dz] [line 10]
!30 = metadata !{i32 10, i32 10, metadata !26, null}
!31 = metadata !{i32 1}
!32 = metadata !{i32 786688, metadata !26, metadata !"j", metadata !5, i32 9, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [j] [line 9]
!33 = metadata !{i32 9, i32 9, metadata !26, null}
!34 = metadata !{i32 786688, metadata !26, metadata !"dy", metadata !5, i32 10, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [dy] [line 10]
!35 = metadata !{i32 10, i32 6, metadata !26, null}
!36 = metadata !{i32 786688, metadata !26, metadata !"i", metadata !5, i32 9, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [i] [line 9]
!37 = metadata !{i32 9, i32 6, metadata !26, null}
!38 = metadata !{i32 -1}
!39 = metadata !{i32 8, i32 8, metadata !27, null} ; [ DW_TAG_imported_declaration ]
!40 = metadata !{i32 8, i32 8, metadata !41, null} ; [ DW_TAG_imported_declaration ]
!41 = metadata !{i32 786443, metadata !1, metadata !42, i32 8, i32 8, i32 2, i32 29} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_ApplyBndRobin.c]
!42 = metadata !{i32 786443, metadata !1, metadata !27, i32 8, i32 8, i32 1, i32 19} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_ApplyBndRobin.c]
!43 = metadata !{i32 14, i32 7, metadata !44, null}
!44 = metadata !{i32 786443, metadata !1, metadata !45, i32 14, i32 7, i32 2, i32 28} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_ApplyBndRobin.c]
!45 = metadata !{i32 786443, metadata !1, metadata !46, i32 14, i32 7, i32 1, i32 20} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_ApplyBndRobin.c]
!46 = metadata !{i32 786443, metadata !1, metadata !26, i32 14, i32 2, i32 0, i32 2} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_ApplyBndRobin.c]
!47 = metadata !{i32 16, i32 10, metadata !48, null}
!48 = metadata !{i32 786443, metadata !1, metadata !49, i32 16, i32 10, i32 0, i32 4} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_ApplyBndRobin.c]
!49 = metadata !{i32 786443, metadata !1, metadata !46, i32 14, i32 38, i32 0, i32 3} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_ApplyBndRobin.c]
!50 = metadata !{i32 16, i32 20, metadata !51, null}
!51 = metadata !{i32 786443, metadata !1, metadata !48, i32 16, i32 20, i32 1, i32 21} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_ApplyBndRobin.c]
!52 = metadata !{i32 18, i32 17, metadata !53, null}
!53 = metadata !{i32 786443, metadata !1, metadata !48, i32 18, i32 17, i32 0, i32 6} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_ApplyBndRobin.c]
!54 = metadata !{i32 21, i32 11, metadata !55, null}
!55 = metadata !{i32 786443, metadata !1, metadata !49, i32 21, i32 6, i32 0, i32 8} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_ApplyBndRobin.c]
!56 = metadata !{i32 21, i32 11, metadata !57, null}
!57 = metadata !{i32 786443, metadata !1, metadata !58, i32 21, i32 11, i32 2, i32 27} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_ApplyBndRobin.c]
!58 = metadata !{i32 786443, metadata !1, metadata !55, i32 21, i32 11, i32 1, i32 22} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_ApplyBndRobin.c]
!59 = metadata !{i32 23, i32 7, metadata !60, null}
!60 = metadata !{i32 786443, metadata !1, metadata !61, i32 23, i32 7, i32 0, i32 10} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_ApplyBndRobin.c]
!61 = metadata !{i32 786443, metadata !1, metadata !55, i32 21, i32 42, i32 0, i32 9} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_ApplyBndRobin.c]
!62 = metadata !{i32 23, i32 17, metadata !63, null}
!63 = metadata !{i32 786443, metadata !1, metadata !60, i32 23, i32 17, i32 1, i32 23} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_ApplyBndRobin.c]
!64 = metadata !{i32 25, i32 14, metadata !65, null}
!65 = metadata !{i32 786443, metadata !1, metadata !60, i32 25, i32 14, i32 0, i32 12} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_ApplyBndRobin.c]
!66 = metadata !{i32 48, i32 7, metadata !67, null}
!67 = metadata !{i32 786443, metadata !1, metadata !61, i32 48, i32 7, i32 0, i32 14} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_ApplyBndRobin.c]
!68 = metadata !{i32 48, i32 7, metadata !69, null}
!69 = metadata !{i32 786443, metadata !1, metadata !67, i32 48, i32 7, i32 1, i32 24} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_ApplyBndRobin.c]
!70 = metadata !{i32 54, i32 12, metadata !71, null}
!71 = metadata !{i32 786443, metadata !1, metadata !72, i32 54, i32 12, i32 2, i32 26} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_ApplyBndRobin.c]
!72 = metadata !{i32 786443, metadata !1, metadata !73, i32 54, i32 12, i32 1, i32 25} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_ApplyBndRobin.c]
!73 = metadata !{i32 786443, metadata !1, metadata !74, i32 54, i32 7, i32 0, i32 16} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_ApplyBndRobin.c]
!74 = metadata !{i32 786443, metadata !1, metadata !67, i32 48, i32 17, i32 0, i32 15} ; [ DW_TAG_lexical_block ] [/liveness_analysis/CPU2006_ApplyBndRobin.c]
!75 = metadata !{i32 54, i32 42, metadata !73, null}
!76 = metadata !{i32 21, i32 37, metadata !55, null}
!77 = metadata !{i32 14, i32 33, metadata !46, null}
!78 = metadata !{i32 8, i32 53, metadata !27, null} ; [ DW_TAG_imported_declaration ]
!79 = metadata !{i32 93, i32 1, metadata !4, null}

