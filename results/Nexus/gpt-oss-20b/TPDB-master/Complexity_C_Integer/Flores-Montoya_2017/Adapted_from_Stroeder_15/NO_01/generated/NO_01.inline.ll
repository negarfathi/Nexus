; ModuleID = '/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/Complexity_C_Integer/Flores-Montoya_2017/Adapted_from_Stroeder_15/NO_01/generated/NO_01.inline.bc'
source_filename = "/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/Complexity_C_Integer/Flores-Montoya_2017/Adapted_from_Stroeder_15/NO_01/generated/NO_01.inline.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @foo(i32 noundef %0, i32 noundef %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i32 %0, ptr %3, align 4
  store i32 %1, ptr %4, align 4
  store i32 864, ptr %3, align 4
  %5 = load i32, ptr %3, align 4
  %6 = icmp sle i32 %5, 10
  br i1 %6, label %7, label %15

7:                                                ; preds = %2
  store i32 0, ptr %4, align 4
  br label %8

8:                                                ; preds = %11, %7
  %9 = load i32, ptr %4, align 4
  %10 = icmp slt i32 %9, 100
  br i1 %10, label %11, label %14

11:                                               ; preds = %8
  %12 = load i32, ptr %4, align 4
  %13 = add nsw i32 %12, 1
  store i32 %13, ptr %4, align 4
  br label %8, !llvm.loop !6

14:                                               ; preds = %8
  br label %46

15:                                               ; preds = %2
  %16 = load i32, ptr %3, align 4
  %17 = icmp sle i32 %16, 50
  br i1 %17, label %18, label %26

18:                                               ; preds = %15
  store i32 0, ptr %4, align 4
  br label %19

19:                                               ; preds = %22, %18
  %20 = load i32, ptr %4, align 4
  %21 = icmp slt i32 %20, 101
  br i1 %21, label %22, label %25

22:                                               ; preds = %19
  %23 = load i32, ptr %4, align 4
  %24 = add nsw i32 %23, 1
  store i32 %24, ptr %4, align 4
  br label %19, !llvm.loop !8

25:                                               ; preds = %19
  br label %26

26:                                               ; preds = %25, %15
  %27 = load i32, ptr %3, align 4
  %28 = icmp sle i32 %27, 100
  br i1 %28, label %29, label %37

29:                                               ; preds = %26
  store i32 0, ptr %4, align 4
  br label %30

30:                                               ; preds = %33, %29
  %31 = load i32, ptr %4, align 4
  %32 = icmp slt i32 %31, 102
  br i1 %32, label %33, label %36

33:                                               ; preds = %30
  %34 = load i32, ptr %4, align 4
  %35 = add nsw i32 %34, 1
  store i32 %35, ptr %4, align 4
  br label %30, !llvm.loop !9

36:                                               ; preds = %30
  br label %45

37:                                               ; preds = %26
  store i32 0, ptr %4, align 4
  br label %38

38:                                               ; preds = %41, %37
  %39 = load i32, ptr %4, align 4
  %40 = icmp slt i32 %39, 103
  br i1 %40, label %41, label %44

41:                                               ; preds = %38
  %42 = load i32, ptr %4, align 4
  %43 = add nsw i32 %42, 0
  store i32 %43, ptr %4, align 4
  br label %38, !llvm.loop !10

44:                                               ; preds = %38
  br label %45

45:                                               ; preds = %44, %36
  br label %46

46:                                               ; preds = %45, %14
  ret i32 0
}

attributes #0 = { noinline nounwind uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }

!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.ident = !{!5}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 2}
!4 = !{i32 7, !"frame-pointer", i32 2}
!5 = !{!"Ubuntu clang version 18.1.3 (1ubuntu1)"}
!6 = distinct !{!6, !7}
!7 = !{!"llvm.loop.mustprogress"}
!8 = distinct !{!8, !7}
!9 = distinct !{!9, !7}
!10 = distinct !{!10, !7}
