; ModuleID = '/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/C_Integer/Stroeder_15/Gothenburg_true-termination/generated/Gothenburg_true-termination.inline.bc'
source_filename = "/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/C_Integer/Stroeder_15/Gothenburg_true-termination/generated/Gothenburg_true-termination.inline.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  store i32 0, ptr %1, align 4
  %6 = call i32 @__VERIFIER_nondet_int()
  store i32 %6, ptr %2, align 4
  %7 = call i32 @__VERIFIER_nondet_int()
  store i32 %7, ptr %3, align 4
  %8 = call i32 @__VERIFIER_nondet_int()
  store i32 %8, ptr %4, align 4
  %9 = call i32 @__VERIFIER_nondet_int()
  store i32 %9, ptr %5, align 4
  %10 = load i32, ptr %2, align 4
  %11 = load i32, ptr %3, align 4
  %12 = icmp eq i32 %10, %11
  br i1 %12, label %13, label %36

13:                                               ; preds = %0
  br label %14

14:                                               ; preds = %22, %13
  %15 = load i32, ptr %4, align 4
  %16 = icmp sge i32 %15, 0
  br i1 %16, label %20, label %17

17:                                               ; preds = %14
  %18 = load i32, ptr %5, align 4
  %19 = icmp sge i32 %18, 0
  br label %20

20:                                               ; preds = %17, %14
  %21 = phi i1 [ true, %14 ], [ %19, %17 ]
  br i1 %21, label %22, label %35

22:                                               ; preds = %20
  %23 = load i32, ptr %4, align 4
  %24 = load i32, ptr %2, align 4
  %25 = add nsw i32 %23, %24
  %26 = load i32, ptr %3, align 4
  %27 = sub nsw i32 %25, %26
  %28 = sub nsw i32 %27, 1
  store i32 %28, ptr %4, align 4
  %29 = load i32, ptr %5, align 4
  %30 = load i32, ptr %3, align 4
  %31 = add nsw i32 %29, %30
  %32 = load i32, ptr %2, align 4
  %33 = sub nsw i32 %31, %32
  %34 = sub nsw i32 %33, 1
  store i32 %34, ptr %5, align 4
  br label %14, !llvm.loop !6

35:                                               ; preds = %20
  br label %36

36:                                               ; preds = %35, %0
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
