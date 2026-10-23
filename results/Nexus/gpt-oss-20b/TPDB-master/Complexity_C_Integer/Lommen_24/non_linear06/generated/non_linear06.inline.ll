; ModuleID = '/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/Complexity_C_Integer/Lommen_24/non_linear06/generated/non_linear06.inline.bc'
source_filename = "/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/Complexity_C_Integer/Lommen_24/non_linear06/generated/non_linear06.inline.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @non_linear06(i32 noundef %0, i32 noundef %1, i32 noundef %2, i32 noundef %3, i32 noundef %4, i32 noundef %5) #0 {
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  %13 = alloca i32, align 4
  %14 = alloca i32, align 4
  %15 = alloca i32, align 4
  %16 = alloca i32, align 4
  store i32 %0, ptr %7, align 4
  store i32 %1, ptr %8, align 4
  store i32 %2, ptr %9, align 4
  store i32 %3, ptr %10, align 4
  store i32 %4, ptr %11, align 4
  store i32 %5, ptr %12, align 4
  br label %17

17:                                               ; preds = %41, %6
  %18 = load i32, ptr %10, align 4
  %19 = load i32, ptr %10, align 4
  %20 = mul nsw i32 %18, %19
  %21 = load i32, ptr %9, align 4
  %22 = load i32, ptr %9, align 4
  %23 = mul nsw i32 %21, %22
  %24 = load i32, ptr %9, align 4
  %25 = mul nsw i32 %23, %24
  %26 = load i32, ptr %9, align 4
  %27 = mul nsw i32 %25, %26
  %28 = load i32, ptr %9, align 4
  %29 = mul nsw i32 %27, %28
  %30 = sub nsw i32 %20, %29
  %31 = load i32, ptr %11, align 4
  %32 = mul nsw i32 2, %31
  %33 = load i32, ptr %12, align 4
  %34 = sub nsw i32 %32, %33
  %35 = icmp slt i32 %30, %34
  br i1 %35, label %36, label %39

36:                                               ; preds = %17
  %37 = load i32, ptr %10, align 4
  %38 = icmp ne i32 %37, 0
  br label %39

39:                                               ; preds = %36, %17
  %40 = phi i1 [ false, %17 ], [ %38, %36 ]
  br i1 %40, label %41, label %81

41:                                               ; preds = %39
  %42 = load i32, ptr %7, align 4
  store i32 %42, ptr %13, align 4
  %43 = load i32, ptr %8, align 4
  store i32 %43, ptr %14, align 4
  %44 = load i32, ptr %13, align 4
  %45 = mul nsw i32 3, %44
  %46 = load i32, ptr %14, align 4
  %47 = mul nsw i32 2, %46
  %48 = add nsw i32 %45, %47
  store i32 %48, ptr %7, align 4
  %49 = load i32, ptr %13, align 4
  %50 = mul nsw i32 -5, %49
  %51 = load i32, ptr %14, align 4
  %52 = mul nsw i32 3, %51
  %53 = sub nsw i32 %50, %52
  store i32 %53, ptr %8, align 4
  %54 = load i32, ptr %10, align 4
  %55 = mul nsw i32 -2, %54
  store i32 %55, ptr %10, align 4
  %56 = load i32, ptr %11, align 4
  store i32 %56, ptr %15, align 4
  %57 = load i32, ptr %12, align 4
  store i32 %57, ptr %16, align 4
  %58 = load i32, ptr %15, align 4
  %59 = load i32, ptr %15, align 4
  %60 = load i32, ptr %15, align 4
  %61 = mul nsw i32 %59, %60
  %62 = add nsw i32 %58, %61
  %63 = load i32, ptr %9, align 4
  %64 = load i32, ptr %9, align 4
  %65 = mul nsw i32 %63, %64
  %66 = add nsw i32 %62, %65
  store i32 %66, ptr %11, align 4
  %67 = load i32, ptr %15, align 4
  %68 = mul nsw i32 -4, %67
  %69 = load i32, ptr %15, align 4
  %70 = mul nsw i32 2, %69
  %71 = load i32, ptr %15, align 4
  %72 = mul nsw i32 %70, %71
  %73 = add nsw i32 %68, %72
  %74 = load i32, ptr %16, align 4
  %75 = mul nsw i32 3, %74
  %76 = add nsw i32 %73, %75
  %77 = load i32, ptr %9, align 4
  %78 = load i32, ptr %9, align 4
  %79 = mul nsw i32 %77, %78
  %80 = add nsw i32 %76, %79
  store i32 %80, ptr %12, align 4
  br label %17, !llvm.loop !6

81:                                               ; preds = %39
  ret i32 0
}

attributes #0 = { noinline nounwind uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }

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
