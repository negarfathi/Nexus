; ModuleID = '/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/Complexity_C_Integer/Lommen_23/size13/generated/size13.inline.bc'
source_filename = "/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/Complexity_C_Integer/Lommen_23/size13/generated/size13.inline.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @size13(i32 noundef %0, i32 noundef %1, i32 noundef %2, i32 noundef %3) #0 {
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  store i32 %0, ptr %5, align 4
  store i32 %1, ptr %6, align 4
  store i32 %2, ptr %7, align 4
  store i32 %3, ptr %8, align 4
  %12 = load i32, ptr %5, align 4
  store i32 %12, ptr %9, align 4
  store i32 0, ptr %10, align 4
  store i32 0, ptr %11, align 4
  br label %13

13:                                               ; preds = %35, %4
  %14 = load i32, ptr %9, align 4
  %15 = icmp sgt i32 %14, 0
  br i1 %15, label %16, label %37

16:                                               ; preds = %13
  %17 = load i32, ptr %9, align 4
  %18 = sub nsw i32 %17, 1
  store i32 %18, ptr %9, align 4
  %19 = load i32, ptr %6, align 4
  %20 = load i32, ptr %7, align 4
  %21 = add nsw i32 %19, %20
  store i32 %21, ptr %10, align 4
  %22 = load i32, ptr %11, align 4
  %23 = load i32, ptr %9, align 4
  %24 = load i32, ptr %9, align 4
  %25 = mul nsw i32 %23, %24
  %26 = add nsw i32 %22, %25
  store i32 %26, ptr %11, align 4
  br label %27

27:                                               ; preds = %30, %16
  %28 = load i32, ptr %10, align 4
  %29 = icmp sgt i32 %28, 0
  br i1 %29, label %30, label %35

30:                                               ; preds = %27
  %31 = load i32, ptr %10, align 4
  %32 = sub nsw i32 %31, 1
  store i32 %32, ptr %10, align 4
  %33 = load i32, ptr %5, align 4
  store i32 %33, ptr %7, align 4
  %34 = load i32, ptr %8, align 4
  store i32 %34, ptr %6, align 4
  br label %27, !llvm.loop !6

35:                                               ; preds = %27
  %36 = load i32, ptr %6, align 4
  store i32 %36, ptr %8, align 4
  br label %13, !llvm.loop !8

37:                                               ; preds = %13
  br label %38

38:                                               ; preds = %41, %37
  %39 = load i32, ptr %11, align 4
  %40 = icmp sgt i32 %39, 0
  br i1 %40, label %41, label %44

41:                                               ; preds = %38
  %42 = load i32, ptr %11, align 4
  %43 = sub nsw i32 %42, 1
  store i32 %43, ptr %11, align 4
  br label %38, !llvm.loop !9

44:                                               ; preds = %38
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
