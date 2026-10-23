; ModuleID = '/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/Complexity_C_Integer/Lommen_24/non_linear01/generated/non_linear01.inline.bc'
source_filename = "/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/Complexity_C_Integer/Lommen_24/non_linear01/generated/non_linear01.inline.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @non_linear01(i32 noundef %0, i32 noundef %1, i32 noundef %2, i32 noundef %3, i32 noundef %4) #0 {
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  store i32 %0, ptr %6, align 4
  store i32 %1, ptr %7, align 4
  store i32 %2, ptr %8, align 4
  store i32 %3, ptr %9, align 4
  store i32 %4, ptr %10, align 4
  br label %13

13:                                               ; preds = %34, %5
  %14 = load i32, ptr %9, align 4
  %15 = load i32, ptr %9, align 4
  %16 = mul nsw i32 %14, %15
  %17 = load i32, ptr %8, align 4
  %18 = load i32, ptr %8, align 4
  %19 = mul nsw i32 %17, %18
  %20 = load i32, ptr %8, align 4
  %21 = mul nsw i32 %19, %20
  %22 = load i32, ptr %8, align 4
  %23 = mul nsw i32 %21, %22
  %24 = load i32, ptr %8, align 4
  %25 = mul nsw i32 %23, %24
  %26 = sub nsw i32 %16, %25
  %27 = load i32, ptr %10, align 4
  %28 = icmp slt i32 %26, %27
  br i1 %28, label %29, label %32

29:                                               ; preds = %13
  %30 = load i32, ptr %9, align 4
  %31 = icmp ne i32 %30, 0
  br label %32

32:                                               ; preds = %29, %13
  %33 = phi i1 [ false, %13 ], [ %31, %29 ]
  br i1 %33, label %34, label %55

34:                                               ; preds = %32
  %35 = load i32, ptr %6, align 4
  store i32 %35, ptr %11, align 4
  %36 = load i32, ptr %7, align 4
  store i32 %36, ptr %12, align 4
  %37 = load i32, ptr %11, align 4
  %38 = mul nsw i32 3, %37
  %39 = load i32, ptr %12, align 4
  %40 = mul nsw i32 2, %39
  %41 = add nsw i32 %38, %40
  store i32 %41, ptr %6, align 4
  %42 = load i32, ptr %11, align 4
  %43 = mul nsw i32 -5, %42
  %44 = load i32, ptr %12, align 4
  %45 = mul nsw i32 3, %44
  %46 = sub nsw i32 %43, %45
  store i32 %46, ptr %7, align 4
  %47 = load i32, ptr %9, align 4
  %48 = mul nsw i32 -2, %47
  store i32 %48, ptr %9, align 4
  %49 = load i32, ptr %10, align 4
  %50 = mul nsw i32 3, %49
  %51 = load i32, ptr %8, align 4
  %52 = load i32, ptr %8, align 4
  %53 = mul nsw i32 %51, %52
  %54 = add nsw i32 %50, %53
  store i32 %54, ptr %10, align 4
  br label %13, !llvm.loop !6

55:                                               ; preds = %32
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
