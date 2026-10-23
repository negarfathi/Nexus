; ModuleID = '/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/Complexity_C_Integer/Lommen_24/non_linear12/generated/non_linear12.inline.bc'
source_filename = "/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/Complexity_C_Integer/Lommen_24/non_linear12/generated/non_linear12.inline.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @non_linear12(i32 noundef %0, i32 noundef %1, i32 noundef %2, i32 noundef %3) #0 {
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  store i32 %0, ptr %5, align 4
  store i32 %1, ptr %6, align 4
  store i32 %2, ptr %7, align 4
  store i32 %3, ptr %8, align 4
  br label %13

13:                                               ; preds = %57, %4
  %14 = load i32, ptr %8, align 4
  %15 = icmp sgt i32 %14, 0
  br i1 %15, label %16, label %58

16:                                               ; preds = %13
  %17 = call i32 @__VERIFIER_nondet_int()
  %18 = icmp ne i32 %17, 0
  br i1 %18, label %19, label %38

19:                                               ; preds = %16
  %20 = load i32, ptr %5, align 4
  store i32 %20, ptr %9, align 4
  %21 = load i32, ptr %6, align 4
  store i32 %21, ptr %10, align 4
  %22 = load i32, ptr %9, align 4
  %23 = mul nsw i32 3, %22
  %24 = load i32, ptr %10, align 4
  %25 = mul nsw i32 2, %24
  %26 = add nsw i32 %23, %25
  %27 = load i32, ptr %7, align 4
  %28 = load i32, ptr %7, align 4
  %29 = mul nsw i32 %27, %28
  %30 = add nsw i32 %26, %29
  store i32 %30, ptr %5, align 4
  %31 = load i32, ptr %9, align 4
  %32 = mul nsw i32 -5, %31
  %33 = load i32, ptr %10, align 4
  %34 = mul nsw i32 3, %33
  %35 = sub nsw i32 %32, %34
  store i32 %35, ptr %6, align 4
  %36 = load i32, ptr %8, align 4
  %37 = sub nsw i32 %36, 1
  store i32 %37, ptr %8, align 4
  br label %57

38:                                               ; preds = %16
  %39 = load i32, ptr %5, align 4
  store i32 %39, ptr %11, align 4
  %40 = load i32, ptr %6, align 4
  store i32 %40, ptr %12, align 4
  %41 = load i32, ptr %11, align 4
  %42 = mul nsw i32 3, %41
  %43 = load i32, ptr %12, align 4
  %44 = mul nsw i32 2, %43
  %45 = add nsw i32 %42, %44
  %46 = load i32, ptr %7, align 4
  %47 = load i32, ptr %7, align 4
  %48 = mul nsw i32 %46, %47
  %49 = add nsw i32 %45, %48
  store i32 %49, ptr %5, align 4
  %50 = load i32, ptr %11, align 4
  %51 = mul nsw i32 -5, %50
  %52 = load i32, ptr %12, align 4
  %53 = mul nsw i32 3, %52
  %54 = sub nsw i32 %51, %53
  store i32 %54, ptr %6, align 4
  %55 = load i32, ptr %8, align 4
  %56 = sub nsw i32 %55, 1
  store i32 %56, ptr %8, align 4
  br label %57

57:                                               ; preds = %38, %19
  br label %13, !llvm.loop !6

58:                                               ; preds = %13
  %59 = load i32, ptr %5, align 4
  store i32 %59, ptr %8, align 4
  br label %60

60:                                               ; preds = %63, %58
  %61 = load i32, ptr %8, align 4
  %62 = icmp sgt i32 %61, 0
  br i1 %62, label %63, label %66

63:                                               ; preds = %60
  %64 = load i32, ptr %8, align 4
  %65 = sub nsw i32 %64, 1
  store i32 %65, ptr %8, align 4
  br label %60, !llvm.loop !8

66:                                               ; preds = %60
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
