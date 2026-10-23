; ModuleID = '/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/C_Integer/Stroeder_15/NonTerminationSimple8_false-termination/generated/NonTerminationSimple8_false-termination.inline.bc'
source_filename = "/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/C_Integer/Stroeder_15/NonTerminationSimple8_false-termination/generated/NonTerminationSimple8_false-termination.inline.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  store i32 0, ptr %1, align 4
  %3 = call i32 @__VERIFIER_nondet_int()
  store i32 %3, ptr %2, align 4
  br label %4

4:                                                ; preds = %35, %0
  %5 = load i32, ptr %2, align 4
  %6 = icmp sge i32 %5, 0
  br i1 %6, label %7, label %36

7:                                                ; preds = %4
  %8 = call i32 @__VERIFIER_nondet_int()
  %9 = icmp ne i32 %8, 0
  br i1 %9, label %10, label %13

10:                                               ; preds = %7
  %11 = load i32, ptr %2, align 4
  %12 = add nsw i32 %11, 1
  store i32 %12, ptr %2, align 4
  br label %35

13:                                               ; preds = %7
  %14 = call i32 @__VERIFIER_nondet_int()
  %15 = icmp ne i32 %14, 0
  br i1 %15, label %16, label %19

16:                                               ; preds = %13
  %17 = load i32, ptr %2, align 4
  %18 = add nsw i32 %17, 2
  store i32 %18, ptr %2, align 4
  br label %34

19:                                               ; preds = %13
  %20 = call i32 @__VERIFIER_nondet_int()
  %21 = icmp ne i32 %20, 0
  br i1 %21, label %22, label %25

22:                                               ; preds = %19
  %23 = load i32, ptr %2, align 4
  %24 = add nsw i32 %23, 3
  store i32 %24, ptr %2, align 4
  br label %33

25:                                               ; preds = %19
  %26 = call i32 @__VERIFIER_nondet_int()
  %27 = icmp ne i32 %26, 0
  br i1 %27, label %28, label %31

28:                                               ; preds = %25
  %29 = load i32, ptr %2, align 4
  %30 = add nsw i32 %29, 4
  store i32 %30, ptr %2, align 4
  br label %32

31:                                               ; preds = %25
  store i32 -1, ptr %2, align 4
  br label %32

32:                                               ; preds = %31, %28
  br label %33

33:                                               ; preds = %32, %22
  br label %34

34:                                               ; preds = %33, %16
  br label %35

35:                                               ; preds = %34, %10
  br label %4, !llvm.loop !6

36:                                               ; preds = %4
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
