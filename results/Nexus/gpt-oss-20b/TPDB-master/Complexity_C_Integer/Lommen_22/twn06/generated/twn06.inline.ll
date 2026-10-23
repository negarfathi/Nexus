; ModuleID = '/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/Complexity_C_Integer/Lommen_22/twn06/generated/twn06.inline.bc'
source_filename = "/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/Complexity_C_Integer/Lommen_22/twn06/generated/twn06.inline.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @twn06(i32 noundef %0, i32 noundef %1, i32 noundef %2, i32 noundef %3, i32 noundef %4, i32 noundef %5) #0 {
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  %13 = alloca i32, align 4
  %14 = alloca i32, align 4
  store i32 %0, ptr %7, align 4
  store i32 %1, ptr %8, align 4
  store i32 %2, ptr %9, align 4
  store i32 %3, ptr %10, align 4
  store i32 %4, ptr %11, align 4
  store i32 %5, ptr %12, align 4
  %15 = load i32, ptr %10, align 4
  %16 = icmp sgt i32 %15, 0
  br i1 %16, label %17, label %78

17:                                               ; preds = %6
  %18 = load i32, ptr %10, align 4
  store i32 %18, ptr %7, align 4
  %19 = load i32, ptr %11, align 4
  store i32 %19, ptr %8, align 4
  br label %20

20:                                               ; preds = %72, %17
  %21 = load i32, ptr %9, align 4
  %22 = icmp sgt i32 %21, 0
  br i1 %22, label %23, label %77

23:                                               ; preds = %20
  br label %24

24:                                               ; preds = %27, %23
  %25 = load i32, ptr %9, align 4
  %26 = icmp sgt i32 %25, 0
  br i1 %26, label %27, label %33

27:                                               ; preds = %24
  %28 = load i32, ptr %7, align 4
  %29 = load i32, ptr %9, align 4
  %30 = add nsw i32 %28, %29
  store i32 %30, ptr %7, align 4
  %31 = load i32, ptr %9, align 4
  %32 = sub nsw i32 %31, 1
  store i32 %32, ptr %9, align 4
  br label %24, !llvm.loop !6

33:                                               ; preds = %24
  %34 = load i32, ptr %12, align 4
  store i32 %34, ptr %9, align 4
  br label %35

35:                                               ; preds = %50, %33
  %36 = load i32, ptr %8, align 4
  %37 = load i32, ptr %8, align 4
  %38 = mul nsw i32 %36, %37
  %39 = icmp sgt i32 %38, 1
  br i1 %39, label %40, label %48

40:                                               ; preds = %35
  %41 = load i32, ptr %7, align 4
  %42 = load i32, ptr %9, align 4
  %43 = mul nsw i32 %41, %42
  %44 = load i32, ptr %7, align 4
  %45 = mul nsw i32 2, %44
  %46 = add nsw i32 %43, %45
  %47 = icmp sgt i32 %46, 0
  br label %48

48:                                               ; preds = %40, %35
  %49 = phi i1 [ false, %35 ], [ %47, %40 ]
  br i1 %49, label %50, label %72

50:                                               ; preds = %48
  %51 = load i32, ptr %7, align 4
  store i32 %51, ptr %7, align 4
  %52 = load i32, ptr %8, align 4
  store i32 %52, ptr %13, align 4
  %53 = load i32, ptr %9, align 4
  store i32 %53, ptr %14, align 4
  %54 = load i32, ptr %13, align 4
  %55 = mul nsw i32 3, %54
  %56 = load i32, ptr %14, align 4
  %57 = mul nsw i32 4, %56
  %58 = sub nsw i32 %55, %57
  store i32 %58, ptr %8, align 4
  %59 = load i32, ptr %13, align 4
  %60 = mul nsw i32 4, %59
  %61 = load i32, ptr %14, align 4
  %62 = mul nsw i32 3, %61
  %63 = sub nsw i32 %60, %62
  store i32 %63, ptr %9, align 4
  %64 = load i32, ptr %10, align 4
  %65 = mul nsw i32 5, %64
  store i32 %65, ptr %10, align 4
  %66 = load i32, ptr %11, align 4
  %67 = mul nsw i32 5, %66
  %68 = load i32, ptr %7, align 4
  %69 = load i32, ptr %7, align 4
  %70 = mul nsw i32 %68, %69
  %71 = sub nsw i32 %67, %70
  store i32 %71, ptr %11, align 4
  br label %35, !llvm.loop !8

72:                                               ; preds = %48
  %73 = load i32, ptr %10, align 4
  store i32 %73, ptr %7, align 4
  %74 = load i32, ptr %11, align 4
  store i32 %74, ptr %8, align 4
  %75 = load i32, ptr %12, align 4
  %76 = sub nsw i32 %75, 1
  store i32 %76, ptr %12, align 4
  br label %20, !llvm.loop !9

77:                                               ; preds = %20
  br label %78

78:                                               ; preds = %77, %6
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
!8 = distinct !{!8, !7}
!9 = distinct !{!9, !7}
