; ModuleID = '/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/Complexity_C_Integer/Lommen_24/non_linear17/generated/non_linear17.inline.bc'
source_filename = "/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/Complexity_C_Integer/Lommen_24/non_linear17/generated/non_linear17.inline.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define dso_local void @f(i32 noundef %0, i32 noundef %1, i32 noundef %2, i32 noundef %3, i32 noundef %4, i32 noundef %5, i32 noundef %6) #0 {
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  %13 = alloca i32, align 4
  %14 = alloca i32, align 4
  %15 = alloca i32, align 4
  %16 = alloca i32, align 4
  store i32 %0, ptr %8, align 4
  store i32 %1, ptr %9, align 4
  store i32 %2, ptr %10, align 4
  store i32 %3, ptr %11, align 4
  store i32 %4, ptr %12, align 4
  store i32 %5, ptr %13, align 4
  store i32 %6, ptr %14, align 4
  %17 = call i32 @__VERIFIER_nondet_int()
  store i32 %17, ptr %15, align 4
  %18 = call i32 @__VERIFIER_nondet_int()
  store i32 %18, ptr %16, align 4
  %19 = load i32, ptr %15, align 4
  store i32 %19, ptr %8, align 4
  %20 = load i32, ptr %16, align 4
  store i32 %20, ptr %14, align 4
  br label %21

21:                                               ; preds = %7, %48
  %22 = load i32, ptr %8, align 4
  %23 = icmp sle i32 1, %22
  br i1 %23, label %24, label %35

24:                                               ; preds = %21
  %25 = load i32, ptr %8, align 4
  %26 = icmp sle i32 %25, 3
  br i1 %26, label %27, label %35

27:                                               ; preds = %24
  %28 = load i32, ptr %14, align 4
  %29 = icmp eq i32 %28, 0
  br i1 %29, label %30, label %35

30:                                               ; preds = %27
  %31 = load i32, ptr %8, align 4
  %32 = add nsw i32 %31, 1
  store i32 %32, ptr %8, align 4
  %33 = call i32 @__VERIFIER_nondet_int()
  store i32 %33, ptr %16, align 4
  %34 = load i32, ptr %16, align 4
  store i32 %34, ptr %14, align 4
  br label %48

35:                                               ; preds = %27, %24, %21
  %36 = load i32, ptr %9, align 4
  %37 = icmp sgt i32 %36, 1
  br i1 %37, label %38, label %46

38:                                               ; preds = %35
  %39 = load i32, ptr %14, align 4
  %40 = icmp eq i32 %39, 1
  br i1 %40, label %41, label %46

41:                                               ; preds = %38
  %42 = load i32, ptr %9, align 4
  %43 = sub nsw i32 %42, 1
  store i32 %43, ptr %9, align 4
  %44 = call i32 @__VERIFIER_nondet_int()
  store i32 %44, ptr %16, align 4
  %45 = load i32, ptr %16, align 4
  store i32 %45, ptr %14, align 4
  br label %47

46:                                               ; preds = %38, %35
  br label %49

47:                                               ; preds = %41
  br label %48

48:                                               ; preds = %47, %30
  br label %21

49:                                               ; preds = %46
  br label %50

50:                                               ; preds = %59, %49
  %51 = load i32, ptr %13, align 4
  %52 = load i32, ptr %12, align 4
  %53 = icmp slt i32 %51, %52
  br i1 %53, label %54, label %57

54:                                               ; preds = %50
  %55 = load i32, ptr %13, align 4
  %56 = icmp sgt i32 %55, 0
  br label %57

57:                                               ; preds = %54, %50
  %58 = phi i1 [ false, %50 ], [ %56, %54 ]
  br i1 %58, label %59, label %64

59:                                               ; preds = %57
  %60 = load i32, ptr %12, align 4
  %61 = mul nsw i32 2, %60
  store i32 %61, ptr %12, align 4
  %62 = load i32, ptr %13, align 4
  %63 = mul nsw i32 3, %62
  store i32 %63, ptr %13, align 4
  br label %50, !llvm.loop !6

64:                                               ; preds = %57
  br label %65

65:                                               ; preds = %68, %64
  %66 = load i32, ptr %13, align 4
  %67 = icmp sgt i32 %66, 0
  br i1 %67, label %68, label %71

68:                                               ; preds = %65
  %69 = load i32, ptr %13, align 4
  %70 = sub nsw i32 %69, 1
  store i32 %70, ptr %13, align 4
  br label %65, !llvm.loop !8

71:                                               ; preds = %65
  ret void
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
