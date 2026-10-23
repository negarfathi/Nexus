; ModuleID = '/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/Complexity_C_Integer/Flores-Montoya_2017/Adapted_from_Stroeder_15/AliasDarteFeautrierGonnord-SAS2010-Fig2b_true-termination/generated/AliasDarteFeautrierGonnord-SAS2010-Fig2b_true-termination.inline.bc'
source_filename = "/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/Complexity_C_Integer/Flores-Montoya_2017/Adapted_from_Stroeder_15/AliasDarteFeautrierGonnord-SAS2010-Fig2b_true-termination/generated/AliasDarteFeautrierGonnord-SAS2010-Fig2b_true-termination.inline.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @foo(i32 noundef %0, i32 noundef %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i32 %0, ptr %3, align 4
  store i32 %1, ptr %4, align 4
  br label %5

5:                                                ; preds = %45, %2
  %6 = load i32, ptr %3, align 4
  %7 = icmp sge i32 %6, 2
  br i1 %7, label %8, label %51

8:                                                ; preds = %5
  %9 = load i32, ptr %3, align 4
  %10 = sub nsw i32 %9, 1
  store i32 %10, ptr %3, align 4
  %11 = load i32, ptr %4, align 4
  %12 = load i32, ptr %3, align 4
  %13 = add nsw i32 %11, %12
  store i32 %13, ptr %4, align 4
  br label %14

14:                                               ; preds = %42, %8
  %15 = load i32, ptr %4, align 4
  %16 = load i32, ptr %3, align 4
  %17 = add nsw i32 %16, 1
  %18 = icmp sge i32 %15, %17
  br i1 %18, label %19, label %22

19:                                               ; preds = %14
  %20 = call i32 @__VERIFIER_nondet_int()
  %21 = icmp ne i32 %20, 0
  br label %22

22:                                               ; preds = %19, %14
  %23 = phi i1 [ false, %14 ], [ %21, %19 ]
  br i1 %23, label %24, label %45

24:                                               ; preds = %22
  %25 = load i32, ptr %4, align 4
  %26 = sub nsw i32 %25, 1
  store i32 %26, ptr %4, align 4
  br label %27

27:                                               ; preds = %37, %24
  %28 = load i32, ptr %4, align 4
  %29 = load i32, ptr %3, align 4
  %30 = add nsw i32 %29, 3
  %31 = icmp sge i32 %28, %30
  br i1 %31, label %32, label %35

32:                                               ; preds = %27
  %33 = call i32 @__VERIFIER_nondet_int()
  %34 = icmp ne i32 %33, 0
  br label %35

35:                                               ; preds = %32, %27
  %36 = phi i1 [ false, %27 ], [ %34, %32 ]
  br i1 %36, label %37, label %42

37:                                               ; preds = %35
  %38 = load i32, ptr %3, align 4
  %39 = add nsw i32 %38, 1
  store i32 %39, ptr %3, align 4
  %40 = load i32, ptr %4, align 4
  %41 = sub nsw i32 %40, 2
  store i32 %41, ptr %4, align 4
  br label %27, !llvm.loop !6

42:                                               ; preds = %35
  %43 = load i32, ptr %4, align 4
  %44 = sub nsw i32 %43, 1
  store i32 %44, ptr %4, align 4
  br label %14, !llvm.loop !8

45:                                               ; preds = %22
  %46 = load i32, ptr %3, align 4
  %47 = sub nsw i32 %46, 1
  store i32 %47, ptr %3, align 4
  %48 = load i32, ptr %4, align 4
  %49 = load i32, ptr %3, align 4
  %50 = sub nsw i32 %48, %49
  store i32 %50, ptr %4, align 4
  br label %5, !llvm.loop !9

51:                                               ; preds = %5
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
!9 = distinct !{!9, !7}
