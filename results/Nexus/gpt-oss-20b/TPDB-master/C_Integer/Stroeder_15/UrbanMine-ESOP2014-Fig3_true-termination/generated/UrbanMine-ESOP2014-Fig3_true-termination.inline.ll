; ModuleID = '/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/C_Integer/Stroeder_15/UrbanMine-ESOP2014-Fig3_true-termination/generated/UrbanMine-ESOP2014-Fig3_true-termination.inline.bc'
source_filename = "/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/C_Integer/Stroeder_15/UrbanMine-ESOP2014-Fig3_true-termination/generated/UrbanMine-ESOP2014-Fig3_true-termination.inline.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  store i32 0, ptr %1, align 4
  %4 = call i32 @__VERIFIER_nondet_int()
  store i32 %4, ptr %2, align 4
  %5 = call i32 @__VERIFIER_nondet_int()
  store i32 %5, ptr %3, align 4
  br label %6

6:                                                ; preds = %39, %0
  %7 = load i32, ptr %2, align 4
  %8 = icmp ne i32 %7, 0
  br i1 %8, label %9, label %12

9:                                                ; preds = %6
  %10 = load i32, ptr %3, align 4
  %11 = icmp sgt i32 %10, 0
  br label %12

12:                                               ; preds = %9, %6
  %13 = phi i1 [ false, %6 ], [ %11, %9 ]
  br i1 %13, label %14, label %40

14:                                               ; preds = %12
  %15 = load i32, ptr %2, align 4
  %16 = icmp sgt i32 %15, 0
  br i1 %16, label %17, label %28

17:                                               ; preds = %14
  %18 = call i32 @__VERIFIER_nondet_int()
  %19 = icmp ne i32 %18, 0
  br i1 %19, label %20, label %24

20:                                               ; preds = %17
  %21 = load i32, ptr %2, align 4
  %22 = sub nsw i32 %21, 1
  store i32 %22, ptr %2, align 4
  %23 = call i32 @__VERIFIER_nondet_int()
  store i32 %23, ptr %3, align 4
  br label %27

24:                                               ; preds = %17
  %25 = load i32, ptr %3, align 4
  %26 = sub nsw i32 %25, 1
  store i32 %26, ptr %3, align 4
  br label %27

27:                                               ; preds = %24, %20
  br label %39

28:                                               ; preds = %14
  %29 = call i32 @__VERIFIER_nondet_int()
  %30 = icmp ne i32 %29, 0
  br i1 %30, label %31, label %34

31:                                               ; preds = %28
  %32 = load i32, ptr %2, align 4
  %33 = add nsw i32 %32, 1
  store i32 %33, ptr %2, align 4
  br label %38

34:                                               ; preds = %28
  %35 = load i32, ptr %3, align 4
  %36 = sub nsw i32 %35, 1
  store i32 %36, ptr %3, align 4
  %37 = call i32 @__VERIFIER_nondet_int()
  store i32 %37, ptr %2, align 4
  br label %38

38:                                               ; preds = %34, %31
  br label %39

39:                                               ; preds = %38, %27
  br label %6, !llvm.loop !6

40:                                               ; preds = %12
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
