; ModuleID = '/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/C_Integer/Stroeder_15/LarrazOliverasRodriguez-CarbonellRubio-FMCAD2013-Fig1_true-termination/generated/LarrazOliverasRodriguez-CarbonellRubio-FMCAD2013-Fig1_true-termination.inline.bc'
source_filename = "/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/C_Integer/Stroeder_15/LarrazOliverasRodriguez-CarbonellRubio-FMCAD2013-Fig1_true-termination/generated/LarrazOliverasRodriguez-CarbonellRubio-FMCAD2013-Fig1_true-termination.inline.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i32 0, ptr %1, align 4
  %5 = call i32 @__VERIFIER_nondet_int()
  store i32 %5, ptr %2, align 4
  %6 = call i32 @__VERIFIER_nondet_int()
  store i32 %6, ptr %3, align 4
  %7 = call i32 @__VERIFIER_nondet_int()
  store i32 %7, ptr %4, align 4
  %8 = load i32, ptr %2, align 4
  %9 = icmp sle i32 %8, 10000
  br i1 %9, label %10, label %40

10:                                               ; preds = %0
  %11 = load i32, ptr %2, align 4
  %12 = icmp sge i32 %11, -10000
  br i1 %12, label %13, label %40

13:                                               ; preds = %10
  %14 = load i32, ptr %3, align 4
  %15 = icmp sle i32 %14, 10000
  br i1 %15, label %16, label %40

16:                                               ; preds = %13
  %17 = load i32, ptr %4, align 4
  %18 = icmp sle i32 %17, 10000
  br i1 %18, label %19, label %40

19:                                               ; preds = %16
  br label %20

20:                                               ; preds = %35, %19
  %21 = load i32, ptr %3, align 4
  %22 = icmp sge i32 %21, 1
  br i1 %22, label %23, label %39

23:                                               ; preds = %20
  %24 = load i32, ptr %2, align 4
  %25 = sub nsw i32 %24, 1
  store i32 %25, ptr %2, align 4
  br label %26

26:                                               ; preds = %30, %23
  %27 = load i32, ptr %3, align 4
  %28 = load i32, ptr %4, align 4
  %29 = icmp slt i32 %27, %28
  br i1 %29, label %30, label %35

30:                                               ; preds = %26
  %31 = load i32, ptr %2, align 4
  %32 = add nsw i32 %31, 1
  store i32 %32, ptr %2, align 4
  %33 = load i32, ptr %4, align 4
  %34 = sub nsw i32 %33, 1
  store i32 %34, ptr %4, align 4
  br label %26, !llvm.loop !6

35:                                               ; preds = %26
  %36 = load i32, ptr %2, align 4
  %37 = load i32, ptr %3, align 4
  %38 = add nsw i32 %36, %37
  store i32 %38, ptr %3, align 4
  br label %20, !llvm.loop !8

39:                                               ; preds = %20
  br label %40

40:                                               ; preds = %39, %16, %13, %10, %0
  ret i32 0
}

declare i32 @__VERIFIER_nondet_int() #1

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
