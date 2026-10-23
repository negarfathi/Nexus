; ModuleID = '/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/Complexity_C_Integer/Benamram_2025/amir8/generated/amir8.inline.bc'
source_filename = "/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/Complexity_C_Integer/Benamram_2025/amir8/generated/amir8.inline.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define dso_local void @amir8(i32 noundef %0, i32 noundef %1, i32 noundef %2, i32 noundef %3) #0 {
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  %13 = alloca i32, align 4
  %14 = alloca i32, align 4
  %15 = alloca i32, align 4
  store i32 %0, ptr %5, align 4
  store i32 %1, ptr %6, align 4
  store i32 %2, ptr %7, align 4
  store i32 %3, ptr %8, align 4
  store i32 0, ptr %12, align 4
  store i32 0, ptr %13, align 4
  br label %16

16:                                               ; preds = %49, %4
  %17 = load i32, ptr %6, align 4
  %18 = add nsw i32 %17, -1
  store i32 %18, ptr %6, align 4
  %19 = icmp sgt i32 %17, 0
  br i1 %19, label %20, label %54

20:                                               ; preds = %16
  %21 = load i32, ptr %7, align 4
  store i32 %21, ptr %9, align 4
  %22 = load i32, ptr %8, align 4
  store i32 %22, ptr %10, align 4
  store i32 0, ptr %11, align 4
  br label %23

23:                                               ; preds = %31, %20
  %24 = load i32, ptr %11, align 4
  %25 = load i32, ptr %5, align 4
  %26 = icmp slt i32 %24, %25
  br i1 %26, label %27, label %34

27:                                               ; preds = %23
  %28 = load i32, ptr %9, align 4
  store i32 %28, ptr %14, align 4
  %29 = load i32, ptr %9, align 4
  store i32 %29, ptr %10, align 4
  %30 = load i32, ptr %14, align 4
  store i32 %30, ptr %9, align 4
  br label %31

31:                                               ; preds = %27
  %32 = load i32, ptr %11, align 4
  %33 = add nsw i32 %32, 1
  store i32 %33, ptr %11, align 4
  br label %23, !llvm.loop !6

34:                                               ; preds = %23
  %35 = load i32, ptr %9, align 4
  store i32 %35, ptr %12, align 4
  %36 = load i32, ptr %8, align 4
  store i32 %36, ptr %9, align 4
  %37 = load i32, ptr %7, align 4
  store i32 %37, ptr %10, align 4
  store i32 0, ptr %11, align 4
  br label %38

38:                                               ; preds = %46, %34
  %39 = load i32, ptr %11, align 4
  %40 = load i32, ptr %5, align 4
  %41 = icmp slt i32 %39, %40
  br i1 %41, label %42, label %49

42:                                               ; preds = %38
  %43 = load i32, ptr %9, align 4
  store i32 %43, ptr %15, align 4
  %44 = load i32, ptr %9, align 4
  store i32 %44, ptr %10, align 4
  %45 = load i32, ptr %15, align 4
  store i32 %45, ptr %9, align 4
  br label %46

46:                                               ; preds = %42
  %47 = load i32, ptr %11, align 4
  %48 = add nsw i32 %47, 1
  store i32 %48, ptr %11, align 4
  br label %38, !llvm.loop !8

49:                                               ; preds = %38
  %50 = load i32, ptr %9, align 4
  store i32 %50, ptr %13, align 4
  %51 = load i32, ptr %12, align 4
  %52 = load i32, ptr %13, align 4
  %53 = add nsw i32 %51, %52
  store i32 %53, ptr %7, align 4
  br label %16, !llvm.loop !9

54:                                               ; preds = %16
  br label %55

55:                                               ; preds = %58, %54
  %56 = load i32, ptr %7, align 4
  %57 = icmp sgt i32 %56, 0
  br i1 %57, label %58, label %61

58:                                               ; preds = %55
  %59 = load i32, ptr %7, align 4
  %60 = add nsw i32 %59, -1
  store i32 %60, ptr %7, align 4
  br label %55, !llvm.loop !10

61:                                               ; preds = %55
  ret void
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
!10 = distinct !{!10, !7}
