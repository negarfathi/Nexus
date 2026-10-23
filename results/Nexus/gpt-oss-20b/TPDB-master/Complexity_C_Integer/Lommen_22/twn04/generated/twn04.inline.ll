; ModuleID = '/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/Complexity_C_Integer/Lommen_22/twn04/generated/twn04.inline.bc'
source_filename = "/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/Complexity_C_Integer/Lommen_22/twn04/generated/twn04.inline.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @twn04(i32 noundef %0, i32 noundef %1, i32 noundef %2, i32 noundef %3, i32 noundef %4) #0 {
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
  %11 = load i32, ptr %9, align 4
  %12 = icmp sgt i32 %11, 0
  br i1 %12, label %13, label %46

13:                                               ; preds = %5
  %14 = load i32, ptr %9, align 4
  store i32 %14, ptr %6, align 4
  %15 = load i32, ptr %10, align 4
  store i32 %15, ptr %7, align 4
  br label %16

16:                                               ; preds = %40, %13
  %17 = load i32, ptr %8, align 4
  %18 = icmp sgt i32 %17, 0
  br i1 %18, label %19, label %45

19:                                               ; preds = %16
  br label %20

20:                                               ; preds = %31, %19
  %21 = load i32, ptr %6, align 4
  %22 = load i32, ptr %7, align 4
  %23 = load i32, ptr %7, align 4
  %24 = mul nsw i32 %22, %23
  %25 = icmp slt i32 %21, %24
  br i1 %25, label %26, label %29

26:                                               ; preds = %20
  %27 = load i32, ptr %6, align 4
  %28 = icmp sgt i32 %27, 0
  br label %29

29:                                               ; preds = %26, %20
  %30 = phi i1 [ false, %20 ], [ %28, %26 ]
  br i1 %30, label %31, label %40

31:                                               ; preds = %29
  %32 = load i32, ptr %6, align 4
  %33 = mul nsw i32 5, %32
  %34 = load i32, ptr %8, align 4
  %35 = load i32, ptr %8, align 4
  %36 = mul nsw i32 %34, %35
  %37 = add nsw i32 %33, %36
  store i32 %37, ptr %6, align 4
  %38 = load i32, ptr %7, align 4
  %39 = mul nsw i32 2, %38
  store i32 %39, ptr %7, align 4
  br label %20, !llvm.loop !6

40:                                               ; preds = %29
  %41 = load i32, ptr %9, align 4
  store i32 %41, ptr %6, align 4
  %42 = load i32, ptr %10, align 4
  store i32 %42, ptr %7, align 4
  %43 = load i32, ptr %8, align 4
  %44 = sub nsw i32 %43, 1
  store i32 %44, ptr %8, align 4
  br label %16, !llvm.loop !8

45:                                               ; preds = %16
  br label %46

46:                                               ; preds = %45, %5
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
