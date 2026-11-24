; ModuleID = '/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/C_Integer/Stroeder_15/NO_01/generated/NO_01.inline.bc'
source_filename = "/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/C_Integer/Stroeder_15/NO_01/generated/NO_01.inline.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  store i32 0, ptr %1, align 4
  store i32 864, ptr %2, align 4
  %4 = load i32, ptr %2, align 4
  %5 = icmp sle i32 %4, 10
  br i1 %5, label %6, label %14

6:                                                ; preds = %0
  store i32 0, ptr %3, align 4
  br label %7

7:                                                ; preds = %10, %6
  %8 = load i32, ptr %3, align 4
  %9 = icmp slt i32 %8, 100
  br i1 %9, label %10, label %13

10:                                               ; preds = %7
  call void asm sideeffect "# NEXUS_SOURCE_LOOP_ID_1_PARENT_0", "~{memory},~{dirflag},~{fpsr},~{flags}"() #1, !srcloc !6
  %11 = load i32, ptr %3, align 4
  %12 = add nsw i32 %11, 1
  store i32 %12, ptr %3, align 4
  br label %7, !llvm.loop !7

13:                                               ; preds = %7
  br label %45

14:                                               ; preds = %0
  %15 = load i32, ptr %2, align 4
  %16 = icmp sle i32 %15, 50
  br i1 %16, label %17, label %25

17:                                               ; preds = %14
  store i32 0, ptr %3, align 4
  br label %18

18:                                               ; preds = %21, %17
  %19 = load i32, ptr %3, align 4
  %20 = icmp slt i32 %19, 101
  br i1 %20, label %21, label %24

21:                                               ; preds = %18
  call void asm sideeffect "# NEXUS_SOURCE_LOOP_ID_2_PARENT_0", "~{memory},~{dirflag},~{fpsr},~{flags}"() #1, !srcloc !9
  %22 = load i32, ptr %3, align 4
  %23 = add nsw i32 %22, 1
  store i32 %23, ptr %3, align 4
  br label %18, !llvm.loop !10

24:                                               ; preds = %18
  br label %25

25:                                               ; preds = %24, %14
  %26 = load i32, ptr %2, align 4
  %27 = icmp sle i32 %26, 100
  br i1 %27, label %28, label %36

28:                                               ; preds = %25
  store i32 0, ptr %3, align 4
  br label %29

29:                                               ; preds = %32, %28
  %30 = load i32, ptr %3, align 4
  %31 = icmp slt i32 %30, 102
  br i1 %31, label %32, label %35

32:                                               ; preds = %29
  call void asm sideeffect "# NEXUS_SOURCE_LOOP_ID_3_PARENT_0", "~{memory},~{dirflag},~{fpsr},~{flags}"() #1, !srcloc !11
  %33 = load i32, ptr %3, align 4
  %34 = add nsw i32 %33, 1
  store i32 %34, ptr %3, align 4
  br label %29, !llvm.loop !12

35:                                               ; preds = %29
  br label %44

36:                                               ; preds = %25
  store i32 0, ptr %3, align 4
  br label %37

37:                                               ; preds = %40, %36
  %38 = load i32, ptr %3, align 4
  %39 = icmp slt i32 %38, 103
  br i1 %39, label %40, label %43

40:                                               ; preds = %37
  call void asm sideeffect "# NEXUS_SOURCE_LOOP_ID_4_PARENT_0", "~{memory},~{dirflag},~{fpsr},~{flags}"() #1, !srcloc !13
  %41 = load i32, ptr %3, align 4
  %42 = add nsw i32 %41, 0
  store i32 %42, ptr %3, align 4
  br label %37, !llvm.loop !14

43:                                               ; preds = %37
  br label %44

44:                                               ; preds = %43, %35
  br label %45

45:                                               ; preds = %44, %13
  call void asm sideeffect "# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE", "~{memory},~{dirflag},~{fpsr},~{flags}"() #1, !srcloc !15
  ret i32 0
}

attributes #0 = { noinline nounwind uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nounwind }

!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.ident = !{!5}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 2}
!4 = !{i32 7, !"frame-pointer", i32 2}
!5 = !{!"Ubuntu clang version 18.1.3 (1ubuntu1)"}
!6 = !{i64 215}
!7 = distinct !{!7, !8}
!8 = !{!"llvm.loop.mustprogress"}
!9 = !{i64 408}
!10 = distinct !{!10, !8}
!11 = !{i64 603}
!12 = distinct !{!12, !8}
!13 = !{i64 789}
!14 = distinct !{!14, !8}
!15 = !{i64 928}
