; ModuleID = '/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/Complexity_C_Integer/Flores-Montoya_2017/Adapted_from_Stroeder_15/NO_04/generated/NO_04.inline.bc'
source_filename = "/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/Complexity_C_Integer/Flores-Montoya_2017/Adapted_from_Stroeder_15/NO_04/generated/NO_04.inline.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @foo(i32 noundef %0, i32 noundef %1, i32 noundef %2, i32 noundef %3, i32 noundef %4, i32 noundef %5, i32 noundef %6) #0 {
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  %13 = alloca i32, align 4
  %14 = alloca i32, align 4
  store i32 %0, ptr %8, align 4
  store i32 %1, ptr %9, align 4
  store i32 %2, ptr %10, align 4
  store i32 %3, ptr %11, align 4
  store i32 %4, ptr %12, align 4
  store i32 %5, ptr %13, align 4
  store i32 %6, ptr %14, align 4
  store i32 0, ptr %8, align 4
  br label %15

15:                                               ; preds = %68, %7
  %16 = load i32, ptr %8, align 4
  %17 = icmp slt i32 %16, 100
  br i1 %17, label %18, label %71

18:                                               ; preds = %15
  %19 = load i32, ptr %8, align 4
  %20 = add nsw i32 %19, 2
  store i32 %20, ptr %13, align 4
  store i32 0, ptr %9, align 4
  br label %21

21:                                               ; preds = %65, %18
  %22 = load i32, ptr %9, align 4
  %23 = load i32, ptr %13, align 4
  %24 = icmp slt i32 %22, %23
  br i1 %24, label %25, label %68

25:                                               ; preds = %21
  %26 = load i32, ptr %8, align 4
  %27 = load i32, ptr %9, align 4
  %28 = add nsw i32 %26, %27
  %29 = add nsw i32 %28, 3
  store i32 %29, ptr %10, align 4
  br label %30

30:                                               ; preds = %62, %25
  %31 = load i32, ptr %10, align 4
  %32 = icmp sge i32 %31, 0
  br i1 %32, label %33, label %65

33:                                               ; preds = %30
  %34 = load i32, ptr %8, align 4
  %35 = load i32, ptr %9, align 4
  %36 = add nsw i32 %34, %35
  %37 = load i32, ptr %10, align 4
  %38 = add nsw i32 %36, %37
  %39 = add nsw i32 %38, 4
  store i32 %39, ptr %14, align 4
  store i32 0, ptr %11, align 4
  br label %40

40:                                               ; preds = %59, %33
  %41 = load i32, ptr %11, align 4
  %42 = load i32, ptr %14, align 4
  %43 = icmp slt i32 %41, %42
  br i1 %43, label %44, label %62

44:                                               ; preds = %40
  %45 = load i32, ptr %8, align 4
  %46 = load i32, ptr %9, align 4
  %47 = add nsw i32 %45, %46
  %48 = load i32, ptr %10, align 4
  %49 = add nsw i32 %47, %48
  %50 = load i32, ptr %11, align 4
  %51 = add nsw i32 %49, %50
  %52 = add nsw i32 %51, 1000
  store i32 %52, ptr %12, align 4
  br label %53

53:                                               ; preds = %56, %44
  %54 = load i32, ptr %12, align 4
  %55 = icmp sge i32 %54, 0
  br i1 %55, label %56, label %59

56:                                               ; preds = %53
  %57 = load i32, ptr %12, align 4
  %58 = sub nsw i32 %57, 0
  store i32 %58, ptr %12, align 4
  br label %53, !llvm.loop !6

59:                                               ; preds = %53
  %60 = load i32, ptr %11, align 4
  %61 = add nsw i32 %60, 1
  store i32 %61, ptr %11, align 4
  br label %40, !llvm.loop !8

62:                                               ; preds = %40
  %63 = load i32, ptr %10, align 4
  %64 = sub nsw i32 %63, 1
  store i32 %64, ptr %10, align 4
  br label %30, !llvm.loop !9

65:                                               ; preds = %30
  %66 = load i32, ptr %9, align 4
  %67 = add nsw i32 %66, 1
  store i32 %67, ptr %9, align 4
  br label %21, !llvm.loop !10

68:                                               ; preds = %21
  %69 = load i32, ptr %8, align 4
  %70 = add nsw i32 %69, 1
  store i32 %70, ptr %8, align 4
  br label %15, !llvm.loop !11

71:                                               ; preds = %15
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
!10 = distinct !{!10, !7}
!11 = distinct !{!11, !7}
