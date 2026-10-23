; ModuleID = '/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/C_Integer/Stroeder_15/PodelskiRybalchenko-VMCAI2004-Ex1_true-termination/generated/PodelskiRybalchenko-VMCAI2004-Ex1_true-termination.inline.bc'
source_filename = "/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/C_Integer/Stroeder_15/PodelskiRybalchenko-VMCAI2004-Ex1_true-termination/generated/PodelskiRybalchenko-VMCAI2004-Ex1_true-termination.inline.c"
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
  br label %8

8:                                                ; preds = %30, %0
  %9 = load i32, ptr %2, align 4
  %10 = load i32, ptr %3, align 4
  %11 = sub nsw i32 %9, %10
  %12 = icmp sge i32 %11, 1
  br i1 %12, label %13, label %36

13:                                               ; preds = %8
  %14 = call i32 @__VERIFIER_nondet_int()
  store i32 %14, ptr %4, align 4
  %15 = load i32, ptr %4, align 4
  %16 = icmp slt i32 %15, 0
  br i1 %16, label %17, label %20

17:                                               ; preds = %13
  %18 = load i32, ptr %4, align 4
  %19 = sub nsw i32 0, %18
  store i32 %19, ptr %4, align 4
  br label %20

20:                                               ; preds = %17, %13
  %21 = load i32, ptr %2, align 4
  %22 = load i32, ptr %4, align 4
  %23 = sub nsw i32 %21, %22
  store i32 %23, ptr %2, align 4
  %24 = call i32 @__VERIFIER_nondet_int()
  store i32 %24, ptr %5, align 4
  %25 = load i32, ptr %5, align 4
  %26 = icmp slt i32 %25, 0
  br i1 %26, label %27, label %30

27:                                               ; preds = %20
  %28 = load i32, ptr %5, align 4
  %29 = sub nsw i32 0, %28
  store i32 %29, ptr %5, align 4
  br label %30

30:                                               ; preds = %27, %20
  %31 = load i32, ptr %5, align 4
  %32 = add nsw i32 %31, 1
  store i32 %32, ptr %5, align 4
  %33 = load i32, ptr %3, align 4
  %34 = load i32, ptr %5, align 4
  %35 = add nsw i32 %33, %34
  store i32 %35, ptr %3, align 4
  br label %8, !llvm.loop !6

36:                                               ; preds = %8
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
