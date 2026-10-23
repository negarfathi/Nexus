; ModuleID = '/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/Complexity_C_Integer/Lommen_23/size07/generated/size07.inline.bc'
source_filename = "/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/Complexity_C_Integer/Lommen_23/size07/generated/size07.inline.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @size07(i32 noundef %0, i32 noundef %1, i32 noundef %2, i32 noundef %3) #0 {
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  store i32 %0, ptr %5, align 4
  store i32 %1, ptr %6, align 4
  store i32 %2, ptr %7, align 4
  store i32 %3, ptr %8, align 4
  br label %11

11:                                               ; preds = %14, %4
  %12 = load i32, ptr %5, align 4
  %13 = icmp sgt i32 %12, 0
  br i1 %13, label %14, label %34

14:                                               ; preds = %11
  %15 = load i32, ptr %5, align 4
  %16 = sub nsw i32 %15, 1
  store i32 %16, ptr %5, align 4
  %17 = load i32, ptr %6, align 4
  store i32 %17, ptr %9, align 4
  %18 = load i32, ptr %7, align 4
  store i32 %18, ptr %10, align 4
  %19 = load i32, ptr %9, align 4
  %20 = mul nsw i32 3, %19
  %21 = load i32, ptr %10, align 4
  %22 = add nsw i32 %20, %21
  store i32 %22, ptr %6, align 4
  %23 = load i32, ptr %9, align 4
  %24 = mul nsw i32 -6, %23
  %25 = load i32, ptr %10, align 4
  %26 = mul nsw i32 2, %25
  %27 = sub nsw i32 %24, %26
  store i32 %27, ptr %7, align 4
  %28 = load i32, ptr %8, align 4
  %29 = load i32, ptr %5, align 4
  %30 = mul nsw i32 2, %29
  %31 = load i32, ptr %5, align 4
  %32 = mul nsw i32 %30, %31
  %33 = add nsw i32 %28, %32
  store i32 %33, ptr %8, align 4
  br label %11, !llvm.loop !6

34:                                               ; preds = %11
  br label %35

35:                                               ; preds = %40, %34
  %36 = load i32, ptr %6, align 4
  %37 = load i32, ptr %8, align 4
  %38 = add nsw i32 %36, %37
  %39 = icmp sgt i32 %38, 0
  br i1 %39, label %40, label %45

40:                                               ; preds = %35
  %41 = load i32, ptr %6, align 4
  %42 = sub nsw i32 %41, 1
  store i32 %42, ptr %6, align 4
  %43 = load i32, ptr %8, align 4
  %44 = sub nsw i32 %43, 1
  store i32 %44, ptr %8, align 4
  br label %35, !llvm.loop !8

45:                                               ; preds = %35
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
