; ModuleID = '/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/Complexity_C_Integer/Flores-Montoya_2017/Adapted_from_Stroeder_15/LarrazOliverasRodriguez-CarbonellRubio-FMCAD2013-Fig1_true-termination/generated/LarrazOliverasRodriguez-CarbonellRubio-FMCAD2013-Fig1_true-termination.inline.bc'
source_filename = "/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/Complexity_C_Integer/Flores-Montoya_2017/Adapted_from_Stroeder_15/LarrazOliverasRodriguez-CarbonellRubio-FMCAD2013-Fig1_true-termination/generated/LarrazOliverasRodriguez-CarbonellRubio-FMCAD2013-Fig1_true-termination.inline.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @foo(i32 noundef %0, i32 noundef %1, i32 noundef %2) #0 {
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  store i32 %0, ptr %4, align 4
  store i32 %1, ptr %5, align 4
  store i32 %2, ptr %6, align 4
  %7 = load i32, ptr %4, align 4
  %8 = icmp sle i32 %7, 10000
  br i1 %8, label %9, label %39

9:                                                ; preds = %3
  %10 = load i32, ptr %4, align 4
  %11 = icmp sge i32 %10, -10000
  br i1 %11, label %12, label %39

12:                                               ; preds = %9
  %13 = load i32, ptr %5, align 4
  %14 = icmp sle i32 %13, 10000
  br i1 %14, label %15, label %39

15:                                               ; preds = %12
  %16 = load i32, ptr %6, align 4
  %17 = icmp sle i32 %16, 10000
  br i1 %17, label %18, label %39

18:                                               ; preds = %15
  br label %19

19:                                               ; preds = %34, %18
  %20 = load i32, ptr %5, align 4
  %21 = icmp sge i32 %20, 1
  br i1 %21, label %22, label %38

22:                                               ; preds = %19
  %23 = load i32, ptr %4, align 4
  %24 = sub nsw i32 %23, 1
  store i32 %24, ptr %4, align 4
  br label %25

25:                                               ; preds = %29, %22
  %26 = load i32, ptr %5, align 4
  %27 = load i32, ptr %6, align 4
  %28 = icmp slt i32 %26, %27
  br i1 %28, label %29, label %34

29:                                               ; preds = %25
  %30 = load i32, ptr %4, align 4
  %31 = add nsw i32 %30, 1
  store i32 %31, ptr %4, align 4
  %32 = load i32, ptr %6, align 4
  %33 = sub nsw i32 %32, 1
  store i32 %33, ptr %6, align 4
  br label %25, !llvm.loop !6

34:                                               ; preds = %25
  %35 = load i32, ptr %4, align 4
  %36 = load i32, ptr %5, align 4
  %37 = add nsw i32 %35, %36
  store i32 %37, ptr %5, align 4
  br label %19, !llvm.loop !8

38:                                               ; preds = %19
  br label %39

39:                                               ; preds = %38, %15, %12, %9, %3
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
