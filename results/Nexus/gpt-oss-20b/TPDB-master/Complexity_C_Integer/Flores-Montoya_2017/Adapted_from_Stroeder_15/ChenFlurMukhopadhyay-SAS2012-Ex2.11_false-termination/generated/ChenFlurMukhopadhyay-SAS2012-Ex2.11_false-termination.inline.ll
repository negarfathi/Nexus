; ModuleID = '/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/Complexity_C_Integer/Flores-Montoya_2017/Adapted_from_Stroeder_15/ChenFlurMukhopadhyay-SAS2012-Ex2.11_false-termination/generated/ChenFlurMukhopadhyay-SAS2012-Ex2.11_false-termination.inline.bc'
source_filename = "/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/Complexity_C_Integer/Flores-Montoya_2017/Adapted_from_Stroeder_15/ChenFlurMukhopadhyay-SAS2012-Ex2.11_false-termination/generated/ChenFlurMukhopadhyay-SAS2012-Ex2.11_false-termination.inline.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @foo(i32 noundef %0, i32 noundef %1, i32 noundef %2) #0 {
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  store i32 %0, ptr %4, align 4
  store i32 %1, ptr %5, align 4
  store i32 %2, ptr %6, align 4
  br label %7

7:                                                ; preds = %14, %3
  %8 = load i32, ptr %4, align 4
  %9 = mul nsw i32 4, %8
  %10 = load i32, ptr %5, align 4
  %11 = mul nsw i32 5, %10
  %12 = sub nsw i32 %9, %11
  %13 = icmp sgt i32 %12, 0
  br i1 %13, label %14, label %23

14:                                               ; preds = %7
  %15 = load i32, ptr %4, align 4
  store i32 %15, ptr %6, align 4
  %16 = load i32, ptr %6, align 4
  %17 = mul nsw i32 2, %16
  %18 = load i32, ptr %5, align 4
  %19 = mul nsw i32 4, %18
  %20 = add nsw i32 %17, %19
  store i32 %20, ptr %4, align 4
  %21 = load i32, ptr %6, align 4
  %22 = mul nsw i32 4, %21
  store i32 %22, ptr %5, align 4
  br label %7, !llvm.loop !6

23:                                               ; preds = %7
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
