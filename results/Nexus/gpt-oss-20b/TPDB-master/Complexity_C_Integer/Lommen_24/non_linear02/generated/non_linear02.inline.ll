; ModuleID = '/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/Complexity_C_Integer/Lommen_24/non_linear02/generated/non_linear02.inline.bc'
source_filename = "/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/Complexity_C_Integer/Lommen_24/non_linear02/generated/non_linear02.inline.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @non_linear02(i32 noundef %0, i32 noundef %1, i32 noundef %2, i32 noundef %3, i32 noundef %4) #0 {
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  store i32 %0, ptr %6, align 4
  store i32 %1, ptr %7, align 4
  store i32 %2, ptr %8, align 4
  store i32 %3, ptr %9, align 4
  store i32 %4, ptr %10, align 4
  br label %11

11:                                               ; preds = %32, %5
  %12 = load i32, ptr %9, align 4
  %13 = load i32, ptr %9, align 4
  %14 = mul nsw i32 %12, %13
  %15 = load i32, ptr %8, align 4
  %16 = load i32, ptr %8, align 4
  %17 = mul nsw i32 %15, %16
  %18 = load i32, ptr %8, align 4
  %19 = mul nsw i32 %17, %18
  %20 = load i32, ptr %8, align 4
  %21 = mul nsw i32 %19, %20
  %22 = load i32, ptr %8, align 4
  %23 = mul nsw i32 %21, %22
  %24 = sub nsw i32 %14, %23
  %25 = load i32, ptr %10, align 4
  %26 = icmp slt i32 %24, %25
  br i1 %26, label %27, label %30

27:                                               ; preds = %11
  %28 = load i32, ptr %9, align 4
  %29 = icmp ne i32 %28, 0
  br label %30

30:                                               ; preds = %27, %11
  %31 = phi i1 [ false, %11 ], [ %29, %27 ]
  br i1 %31, label %32, label %45

32:                                               ; preds = %30
  %33 = load i32, ptr %6, align 4
  %34 = mul nsw i32 -1, %33
  store i32 %34, ptr %6, align 4
  %35 = load i32, ptr %7, align 4
  %36 = mul nsw i32 -1, %35
  store i32 %36, ptr %7, align 4
  %37 = load i32, ptr %9, align 4
  %38 = mul nsw i32 4, %37
  store i32 %38, ptr %9, align 4
  %39 = load i32, ptr %10, align 4
  %40 = mul nsw i32 9, %39
  %41 = load i32, ptr %8, align 4
  %42 = load i32, ptr %8, align 4
  %43 = mul nsw i32 %41, %42
  %44 = add nsw i32 %40, %43
  store i32 %44, ptr %10, align 4
  br label %11, !llvm.loop !6

45:                                               ; preds = %30
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
