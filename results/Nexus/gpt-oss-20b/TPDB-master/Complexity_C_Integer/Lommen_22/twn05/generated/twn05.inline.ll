; ModuleID = '/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/Complexity_C_Integer/Lommen_22/twn05/generated/twn05.inline.bc'
source_filename = "/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/Complexity_C_Integer/Lommen_22/twn05/generated/twn05.inline.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @twn05(i32 noundef %0, i32 noundef %1, i32 noundef %2, i32 noundef %3, i32 noundef %4, i32 noundef %5) #0 {
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  store i32 %0, ptr %7, align 4
  store i32 %1, ptr %8, align 4
  store i32 %2, ptr %9, align 4
  store i32 %3, ptr %10, align 4
  store i32 %4, ptr %11, align 4
  store i32 %5, ptr %12, align 4
  %13 = load i32, ptr %12, align 4
  %14 = icmp sgt i32 %13, 0
  br i1 %14, label %15, label %59

15:                                               ; preds = %6
  %16 = load i32, ptr %10, align 4
  store i32 %16, ptr %7, align 4
  %17 = load i32, ptr %11, align 4
  store i32 %17, ptr %8, align 4
  br label %18

18:                                               ; preds = %52, %15
  %19 = load i32, ptr %12, align 4
  %20 = icmp sgt i32 %19, 0
  br i1 %20, label %21, label %58

21:                                               ; preds = %18
  br label %22

22:                                               ; preds = %25, %21
  %23 = load i32, ptr %9, align 4
  %24 = icmp sgt i32 %23, 0
  br i1 %24, label %25, label %31

25:                                               ; preds = %22
  %26 = load i32, ptr %7, align 4
  %27 = load i32, ptr %9, align 4
  %28 = add nsw i32 %26, %27
  store i32 %28, ptr %7, align 4
  %29 = load i32, ptr %9, align 4
  %30 = sub nsw i32 %29, 1
  store i32 %30, ptr %9, align 4
  br label %22, !llvm.loop !6

31:                                               ; preds = %22
  br label %32

32:                                               ; preds = %43, %31
  %33 = load i32, ptr %7, align 4
  %34 = load i32, ptr %8, align 4
  %35 = load i32, ptr %8, align 4
  %36 = mul nsw i32 %34, %35
  %37 = icmp slt i32 %33, %36
  br i1 %37, label %38, label %41

38:                                               ; preds = %32
  %39 = load i32, ptr %7, align 4
  %40 = icmp sgt i32 %39, 0
  br label %41

41:                                               ; preds = %38, %32
  %42 = phi i1 [ false, %32 ], [ %40, %38 ]
  br i1 %42, label %43, label %52

43:                                               ; preds = %41
  %44 = load i32, ptr %7, align 4
  %45 = mul nsw i32 5, %44
  %46 = load i32, ptr %9, align 4
  %47 = load i32, ptr %9, align 4
  %48 = mul nsw i32 %46, %47
  %49 = add nsw i32 %45, %48
  store i32 %49, ptr %7, align 4
  %50 = load i32, ptr %8, align 4
  %51 = mul nsw i32 2, %50
  store i32 %51, ptr %8, align 4
  br label %32, !llvm.loop !8

52:                                               ; preds = %41
  %53 = load i32, ptr %10, align 4
  store i32 %53, ptr %7, align 4
  %54 = load i32, ptr %11, align 4
  store i32 %54, ptr %8, align 4
  %55 = load i32, ptr %12, align 4
  store i32 %55, ptr %9, align 4
  %56 = load i32, ptr %12, align 4
  %57 = sub nsw i32 %56, 1
  store i32 %57, ptr %12, align 4
  br label %18, !llvm.loop !9

58:                                               ; preds = %18
  br label %59

59:                                               ; preds = %58, %6
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
