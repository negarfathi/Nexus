; ModuleID = '/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/Complexity_C_Integer/Flores-Montoya_2017/Adapted_from_Stroeder_15/GCD3/generated/GCD3.inline.bc'
source_filename = "/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/Complexity_C_Integer/Flores-Montoya_2017/Adapted_from_Stroeder_15/GCD3/generated/GCD3.inline.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @foo(i32 noundef %0, i32 noundef %1, i32 noundef %2, i32 noundef %3) #0 {
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  store i32 %0, ptr %5, align 4
  store i32 %1, ptr %6, align 4
  store i32 %2, ptr %7, align 4
  store i32 %3, ptr %8, align 4
  br label %9

9:                                                ; preds = %55, %4
  %10 = load i32, ptr %6, align 4
  %11 = icmp sgt i32 %10, 0
  br i1 %11, label %12, label %15

12:                                               ; preds = %9
  %13 = load i32, ptr %5, align 4
  %14 = icmp sgt i32 %13, 0
  br label %15

15:                                               ; preds = %12, %9
  %16 = phi i1 [ false, %9 ], [ %14, %12 ]
  br i1 %16, label %17, label %57

17:                                               ; preds = %15
  %18 = load i32, ptr %6, align 4
  store i32 %18, ptr %7, align 4
  %19 = load i32, ptr %5, align 4
  store i32 %19, ptr %8, align 4
  %20 = load i32, ptr %6, align 4
  %21 = icmp eq i32 %20, 0
  br i1 %21, label %22, label %24

22:                                               ; preds = %17
  %23 = load i32, ptr %6, align 4
  store i32 %23, ptr %6, align 4
  br label %31

24:                                               ; preds = %17
  %25 = load i32, ptr %6, align 4
  %26 = icmp slt i32 %25, 0
  br i1 %26, label %27, label %30

27:                                               ; preds = %24
  %28 = load i32, ptr %8, align 4
  %29 = sub nsw i32 0, %28
  store i32 %29, ptr %8, align 4
  br label %30

30:                                               ; preds = %27, %24
  br label %31

31:                                               ; preds = %30, %22
  %32 = load i32, ptr %8, align 4
  %33 = icmp sgt i32 %32, 0
  br i1 %33, label %34, label %45

34:                                               ; preds = %31
  br label %35

35:                                               ; preds = %39, %34
  %36 = load i32, ptr %8, align 4
  %37 = load i32, ptr %6, align 4
  %38 = icmp sge i32 %36, %37
  br i1 %38, label %39, label %43

39:                                               ; preds = %35
  %40 = load i32, ptr %8, align 4
  %41 = load i32, ptr %6, align 4
  %42 = sub nsw i32 %40, %41
  store i32 %42, ptr %8, align 4
  br label %35, !llvm.loop !6

43:                                               ; preds = %35
  %44 = load i32, ptr %8, align 4
  store i32 %44, ptr %6, align 4
  br label %55

45:                                               ; preds = %31
  br label %46

46:                                               ; preds = %49, %45
  %47 = load i32, ptr %8, align 4
  %48 = icmp slt i32 %47, 0
  br i1 %48, label %49, label %53

49:                                               ; preds = %46
  %50 = load i32, ptr %8, align 4
  %51 = load i32, ptr %6, align 4
  %52 = sub nsw i32 %50, %51
  store i32 %52, ptr %8, align 4
  br label %46, !llvm.loop !8

53:                                               ; preds = %46
  %54 = load i32, ptr %8, align 4
  store i32 %54, ptr %6, align 4
  br label %55

55:                                               ; preds = %53, %43
  %56 = load i32, ptr %7, align 4
  store i32 %56, ptr %5, align 4
  br label %9, !llvm.loop !9

57:                                               ; preds = %15
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
