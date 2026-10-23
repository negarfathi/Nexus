; ModuleID = '/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/Complexity_C_Integer/Sinn_2016/cBench_inflated_stored/generated/cBench_inflated_stored.inline.bc'
source_filename = "/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/Complexity_C_Integer/Sinn_2016/cBench_inflated_stored/generated/cBench_inflated_stored.inline.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define dso_local void @inflate_stored(i32 noundef %0, i32 noundef %1, i32 noundef %2) #0 {
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  store i32 %0, ptr %4, align 4
  store i32 %1, ptr %5, align 4
  store i32 %2, ptr %6, align 4
  %7 = load i32, ptr %4, align 4
  %8 = load i32, ptr %5, align 4
  %9 = sub nsw i32 %8, %7
  store i32 %9, ptr %5, align 4
  br label %10

10:                                               ; preds = %13, %3
  %11 = load i32, ptr %5, align 4
  %12 = icmp slt i32 %11, 16
  br i1 %12, label %13, label %16

13:                                               ; preds = %10
  %14 = load i32, ptr %5, align 4
  %15 = add nsw i32 %14, 8
  store i32 %15, ptr %5, align 4
  br label %10, !llvm.loop !6

16:                                               ; preds = %10
  %17 = load i32, ptr %5, align 4
  %18 = sub nsw i32 %17, 16
  store i32 %18, ptr %5, align 4
  br label %19

19:                                               ; preds = %22, %16
  %20 = load i32, ptr %5, align 4
  %21 = icmp slt i32 %20, 16
  br i1 %21, label %22, label %25

22:                                               ; preds = %19
  %23 = load i32, ptr %5, align 4
  %24 = add nsw i32 %23, 8
  store i32 %24, ptr %5, align 4
  br label %19, !llvm.loop !8

25:                                               ; preds = %19
  %26 = call i32 (...) @random()
  %27 = icmp ne i32 %26, 0
  br i1 %27, label %28, label %29

28:                                               ; preds = %25
  br label %48

29:                                               ; preds = %25
  %30 = load i32, ptr %5, align 4
  %31 = sub nsw i32 %30, 16
  store i32 %31, ptr %5, align 4
  br label %32

32:                                               ; preds = %44, %29
  %33 = load i32, ptr %4, align 4
  %34 = add nsw i32 %33, -1
  store i32 %34, ptr %4, align 4
  %35 = icmp sgt i32 %33, 0
  br i1 %35, label %36, label %47

36:                                               ; preds = %32
  br label %37

37:                                               ; preds = %41, %36
  %38 = load i32, ptr %5, align 4
  %39 = load i32, ptr %6, align 4
  %40 = icmp slt i32 %38, %39
  br i1 %40, label %41, label %44

41:                                               ; preds = %37
  %42 = load i32, ptr %5, align 4
  %43 = add nsw i32 %42, 8
  store i32 %43, ptr %5, align 4
  br label %37, !llvm.loop !9

44:                                               ; preds = %37
  %45 = load i32, ptr %5, align 4
  %46 = sub nsw i32 %45, 8
  store i32 %46, ptr %5, align 4
  br label %32, !llvm.loop !10

47:                                               ; preds = %32
  br label %48

48:                                               ; preds = %47, %28
  ret void
}

declare i32 @random(...) #1

attributes #0 = { noinline nounwind uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }

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
