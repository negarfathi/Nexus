; ModuleID = '/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/Complexity_C_Integer/Lommen_22/twn09/generated/twn09.inline.bc'
source_filename = "/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/Complexity_C_Integer/Lommen_22/twn09/generated/twn09.inline.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @twn09(i32 noundef %0, i32 noundef %1, i32 noundef %2) #0 {
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  store i32 %0, ptr %4, align 4
  store i32 %1, ptr %5, align 4
  store i32 %2, ptr %6, align 4
  %7 = load i32, ptr %4, align 4
  %8 = icmp sgt i32 %7, 0
  br i1 %8, label %9, label %53

9:                                                ; preds = %3
  br label %10

10:                                               ; preds = %13, %9
  %11 = load i32, ptr %6, align 4
  %12 = icmp sgt i32 %11, 0
  br i1 %12, label %13, label %19

13:                                               ; preds = %10
  %14 = load i32, ptr %4, align 4
  %15 = load i32, ptr %6, align 4
  %16 = add nsw i32 %14, %15
  store i32 %16, ptr %4, align 4
  %17 = load i32, ptr %6, align 4
  %18 = sub nsw i32 %17, 1
  store i32 %18, ptr %6, align 4
  br label %10, !llvm.loop !6

19:                                               ; preds = %10
  %20 = load i32, ptr %6, align 4
  %21 = icmp sle i32 %20, 0
  br i1 %21, label %22, label %52

22:                                               ; preds = %19
  br label %23

23:                                               ; preds = %29, %22
  %24 = load i32, ptr %4, align 4
  %25 = load i32, ptr %5, align 4
  %26 = load i32, ptr %5, align 4
  %27 = mul nsw i32 %25, %26
  %28 = icmp slt i32 %24, %27
  br i1 %28, label %29, label %51

29:                                               ; preds = %23
  %30 = load i32, ptr %5, align 4
  %31 = mul nsw i32 -2, %30
  store i32 %31, ptr %6, align 4
  %32 = load i32, ptr %4, align 4
  %33 = mul nsw i32 5, %32
  store i32 %33, ptr %4, align 4
  %34 = load i32, ptr %5, align 4
  %35 = load i32, ptr %6, align 4
  %36 = add nsw i32 %34, %35
  store i32 %36, ptr %6, align 4
  %37 = load i32, ptr %4, align 4
  %38 = load i32, ptr %6, align 4
  %39 = load i32, ptr %6, align 4
  %40 = mul nsw i32 %38, %39
  %41 = load i32, ptr %6, align 4
  %42 = mul nsw i32 %40, %41
  %43 = load i32, ptr %6, align 4
  %44 = mul nsw i32 %42, %43
  %45 = add nsw i32 %37, %44
  store i32 %45, ptr %4, align 4
  %46 = load i32, ptr %5, align 4
  %47 = mul nsw i32 2, %46
  store i32 %47, ptr %5, align 4
  %48 = load i32, ptr %5, align 4
  %49 = load i32, ptr %6, align 4
  %50 = add nsw i32 %48, %49
  store i32 %50, ptr %6, align 4
  br label %23, !llvm.loop !8

51:                                               ; preds = %23
  br label %52

52:                                               ; preds = %51, %19
  br label %53

53:                                               ; preds = %52, %3
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
