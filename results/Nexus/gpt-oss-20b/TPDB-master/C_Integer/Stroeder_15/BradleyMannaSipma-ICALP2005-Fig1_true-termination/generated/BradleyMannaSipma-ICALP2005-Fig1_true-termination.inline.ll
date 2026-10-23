; ModuleID = '/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/C_Integer/Stroeder_15/BradleyMannaSipma-ICALP2005-Fig1_true-termination/generated/BradleyMannaSipma-ICALP2005-Fig1_true-termination.inline.bc'
source_filename = "/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/C_Integer/Stroeder_15/BradleyMannaSipma-ICALP2005-Fig1_true-termination/generated/BradleyMannaSipma-ICALP2005-Fig1_true-termination.inline.c"
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
  %8 = load i32, ptr %4, align 4
  %9 = icmp slt i32 %8, 536870912
  br i1 %9, label %10, label %45

10:                                               ; preds = %0
  %11 = load i32, ptr %2, align 4
  %12 = icmp slt i32 %11, 536870912
  br i1 %12, label %13, label %45

13:                                               ; preds = %10
  %14 = load i32, ptr %3, align 4
  %15 = icmp slt i32 %14, 536870912
  br i1 %15, label %16, label %45

16:                                               ; preds = %13
  %17 = load i32, ptr %2, align 4
  %18 = icmp sge i32 %17, -1073741824
  br i1 %18, label %19, label %45

19:                                               ; preds = %16
  %20 = load i32, ptr %2, align 4
  %21 = load i32, ptr %3, align 4
  %22 = add nsw i32 %20, %21
  %23 = icmp sge i32 %22, 0
  br i1 %23, label %24, label %44

24:                                               ; preds = %19
  br label %25

25:                                               ; preds = %42, %24
  %26 = load i32, ptr %2, align 4
  %27 = load i32, ptr %4, align 4
  %28 = icmp sle i32 %26, %27
  br i1 %28, label %29, label %43

29:                                               ; preds = %25
  %30 = call i32 @__VERIFIER_nondet_int()
  %31 = icmp ne i32 %30, 0
  br i1 %31, label %32, label %39

32:                                               ; preds = %29
  %33 = load i32, ptr %2, align 4
  %34 = mul nsw i32 2, %33
  %35 = load i32, ptr %3, align 4
  %36 = add nsw i32 %34, %35
  store i32 %36, ptr %2, align 4
  %37 = load i32, ptr %3, align 4
  %38 = add nsw i32 %37, 1
  store i32 %38, ptr %3, align 4
  br label %42

39:                                               ; preds = %29
  %40 = load i32, ptr %2, align 4
  %41 = add nsw i32 %40, 1
  store i32 %41, ptr %2, align 4
  br label %42

42:                                               ; preds = %39, %32
  br label %25, !llvm.loop !6

43:                                               ; preds = %25
  br label %44

44:                                               ; preds = %43, %19
  br label %45

45:                                               ; preds = %44, %16, %13, %10, %0
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
