; ModuleID = '/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/Complexity_C_Integer/Flores-Montoya_2017/Adapted_from_Stroeder_15/ChawdharyCookGulwaniSagivYang-ESOP2008-aaron6_true-termination/generated/ChawdharyCookGulwaniSagivYang-ESOP2008-aaron6_true-termination.inline.bc'
source_filename = "/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/Complexity_C_Integer/Flores-Montoya_2017/Adapted_from_Stroeder_15/ChawdharyCookGulwaniSagivYang-ESOP2008-aaron6_true-termination/generated/ChawdharyCookGulwaniSagivYang-ESOP2008-aaron6_true-termination.inline.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @foo(i32 noundef %0, i32 noundef %1, i32 noundef %2, i32 noundef %3, i32 noundef %4) #0 {
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
  %11 = load i32, ptr %6, align 4
  %12 = load i32, ptr %8, align 4
  %13 = add nsw i32 %11, %12
  %14 = icmp sge i32 %13, 0
  br i1 %14, label %15, label %52

15:                                               ; preds = %5
  br label %16

16:                                               ; preds = %50, %15
  %17 = load i32, ptr %6, align 4
  %18 = load i32, ptr %10, align 4
  %19 = icmp sle i32 %17, %18
  br i1 %19, label %20, label %37

20:                                               ; preds = %16
  %21 = load i32, ptr %6, align 4
  %22 = load i32, ptr %7, align 4
  %23 = mul nsw i32 2, %22
  %24 = load i32, ptr %8, align 4
  %25 = add nsw i32 %23, %24
  %26 = icmp sge i32 %21, %25
  br i1 %26, label %27, label %37

27:                                               ; preds = %20
  %28 = load i32, ptr %8, align 4
  %29 = load i32, ptr %9, align 4
  %30 = add nsw i32 %29, 1
  %31 = icmp sge i32 %28, %30
  br i1 %31, label %32, label %37

32:                                               ; preds = %27
  %33 = load i32, ptr %6, align 4
  %34 = load i32, ptr %7, align 4
  %35 = add nsw i32 %34, 1
  %36 = icmp sge i32 %33, %35
  br label %37

37:                                               ; preds = %32, %27, %20, %16
  %38 = phi i1 [ false, %27 ], [ false, %20 ], [ false, %16 ], [ %36, %32 ]
  br i1 %38, label %39, label %51

39:                                               ; preds = %37
  %40 = call i32 @__VERIFIER_nondet_int()
  %41 = icmp ne i32 %40, 0
  br i1 %41, label %42, label %47

42:                                               ; preds = %39
  %43 = load i32, ptr %6, align 4
  store i32 %43, ptr %7, align 4
  %44 = load i32, ptr %8, align 4
  store i32 %44, ptr %9, align 4
  %45 = call i32 @__VERIFIER_nondet_int()
  store i32 %45, ptr %6, align 4
  %46 = call i32 @__VERIFIER_nondet_int()
  store i32 %46, ptr %8, align 4
  br label %50

47:                                               ; preds = %39
  %48 = load i32, ptr %6, align 4
  store i32 %48, ptr %7, align 4
  %49 = call i32 @__VERIFIER_nondet_int()
  store i32 %49, ptr %6, align 4
  br label %50

50:                                               ; preds = %47, %42
  br label %16, !llvm.loop !6

51:                                               ; preds = %37
  br label %52

52:                                               ; preds = %51, %5
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
