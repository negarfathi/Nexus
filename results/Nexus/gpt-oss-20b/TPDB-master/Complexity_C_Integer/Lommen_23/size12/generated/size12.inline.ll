; ModuleID = '/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/Complexity_C_Integer/Lommen_23/size12/generated/size12.inline.bc'
source_filename = "/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/Complexity_C_Integer/Lommen_23/size12/generated/size12.inline.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @size12(i32 noundef %0, i32 noundef %1, i32 noundef %2, i32 noundef %3) #0 {
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
  %13 = load i32, ptr %5, align 4
  store i32 %13, ptr %9, align 4
  store i32 0, ptr %10, align 4
  br label %14

14:                                               ; preds = %39, %4
  %15 = load i32, ptr %9, align 4
  %16 = icmp sgt i32 %15, 0
  br i1 %16, label %17, label %43

17:                                               ; preds = %14
  %18 = load i32, ptr %9, align 4
  %19 = sub nsw i32 %18, 1
  store i32 %19, ptr %9, align 4
  %20 = load i32, ptr %6, align 4
  %21 = load i32, ptr %7, align 4
  %22 = add nsw i32 %20, %21
  store i32 %22, ptr %10, align 4
  br label %23

23:                                               ; preds = %38, %17
  %24 = load i32, ptr %10, align 4
  %25 = icmp sgt i32 %24, 0
  br i1 %25, label %26, label %39

26:                                               ; preds = %23
  %27 = load i32, ptr %10, align 4
  %28 = sub nsw i32 %27, 1
  store i32 %28, ptr %10, align 4
  %29 = call i32 @__VERIFIER_nondet_int()
  store i32 %29, ptr %11, align 4
  %30 = load i32, ptr %11, align 4
  %31 = icmp sgt i32 %30, 0
  br i1 %31, label %32, label %35

32:                                               ; preds = %26
  %33 = load i32, ptr %5, align 4
  store i32 %33, ptr %7, align 4
  %34 = load i32, ptr %8, align 4
  store i32 %34, ptr %6, align 4
  br label %38

35:                                               ; preds = %26
  %36 = load i32, ptr %8, align 4
  store i32 %36, ptr %7, align 4
  %37 = load i32, ptr %5, align 4
  store i32 %37, ptr %6, align 4
  br label %38

38:                                               ; preds = %35, %32
  br label %23, !llvm.loop !6

39:                                               ; preds = %23
  %40 = load i32, ptr %6, align 4
  %41 = load i32, ptr %7, align 4
  %42 = add nsw i32 %40, %41
  store i32 %42, ptr %8, align 4
  br label %14, !llvm.loop !8

43:                                               ; preds = %14
  br label %44

44:                                               ; preds = %62, %43
  %45 = load i32, ptr %8, align 4
  %46 = icmp sgt i32 %45, 0
  br i1 %46, label %47, label %63

47:                                               ; preds = %44
  %48 = load i32, ptr %8, align 4
  %49 = sub nsw i32 %48, 1
  store i32 %49, ptr %8, align 4
  %50 = call i32 @__VERIFIER_nondet_int()
  store i32 %50, ptr %12, align 4
  %51 = load i32, ptr %12, align 4
  %52 = icmp sgt i32 %51, 0
  br i1 %52, label %53, label %59

53:                                               ; preds = %47
  %54 = load i32, ptr %5, align 4
  %55 = load i32, ptr %6, align 4
  %56 = add nsw i32 %54, %55
  %57 = load i32, ptr %7, align 4
  %58 = add nsw i32 %56, %57
  store i32 %58, ptr %7, align 4
  br label %62

59:                                               ; preds = %47
  %60 = load i32, ptr %6, align 4
  store i32 %60, ptr %7, align 4
  %61 = load i32, ptr %5, align 4
  store i32 %61, ptr %6, align 4
  br label %62

62:                                               ; preds = %59, %53
  br label %44, !llvm.loop !9

63:                                               ; preds = %44
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
