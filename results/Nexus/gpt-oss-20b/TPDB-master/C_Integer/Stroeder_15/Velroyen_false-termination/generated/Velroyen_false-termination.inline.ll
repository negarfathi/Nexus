; ModuleID = '/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/C_Integer/Stroeder_15/Velroyen_false-termination/generated/Velroyen_false-termination.inline.bc'
source_filename = "/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/C_Integer/Stroeder_15/Velroyen_false-termination/generated/Velroyen_false-termination.inline.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  store i32 0, ptr %1, align 4
  br label %3

3:                                                ; preds = %26, %0
  %4 = load i32, ptr %2, align 4
  %5 = icmp ne i32 %4, 0
  br i1 %5, label %6, label %27

6:                                                ; preds = %3
  %7 = load i32, ptr %2, align 4
  %8 = icmp sle i32 -5, %7
  br i1 %8, label %9, label %25

9:                                                ; preds = %6
  %10 = load i32, ptr %2, align 4
  %11 = icmp sle i32 %10, 35
  br i1 %11, label %12, label %25

12:                                               ; preds = %9
  %13 = load i32, ptr %2, align 4
  %14 = icmp slt i32 %13, 0
  br i1 %14, label %15, label %16

15:                                               ; preds = %12
  store i32 -5, ptr %2, align 4
  br label %24

16:                                               ; preds = %12
  %17 = load i32, ptr %2, align 4
  %18 = icmp sgt i32 %17, 30
  br i1 %18, label %19, label %20

19:                                               ; preds = %16
  store i32 35, ptr %2, align 4
  br label %23

20:                                               ; preds = %16
  %21 = load i32, ptr %2, align 4
  %22 = sub nsw i32 %21, 1
  store i32 %22, ptr %2, align 4
  br label %23

23:                                               ; preds = %20, %19
  br label %24

24:                                               ; preds = %23, %15
  br label %26

25:                                               ; preds = %9, %6
  store i32 0, ptr %2, align 4
  br label %26

26:                                               ; preds = %25, %24
  br label %3, !llvm.loop !6

27:                                               ; preds = %3
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
