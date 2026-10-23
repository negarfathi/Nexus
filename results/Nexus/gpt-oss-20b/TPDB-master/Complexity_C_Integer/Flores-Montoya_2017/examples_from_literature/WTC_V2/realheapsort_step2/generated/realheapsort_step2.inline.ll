; ModuleID = '/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/Complexity_C_Integer/Flores-Montoya_2017/examples_from_literature/WTC_V2/realheapsort_step2/generated/realheapsort_step2.inline.bc'
source_filename = "/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/Complexity_C_Integer/Flores-Montoya_2017/examples_from_literature/WTC_V2/realheapsort_step2/generated/realheapsort_step2.inline.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define dso_local void @realheapsort_step2(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  store i32 %0, ptr %2, align 4
  %7 = load i32, ptr %2, align 4
  %8 = icmp sgt i32 %7, 2
  br i1 %8, label %9, label %62

9:                                                ; preds = %1
  store i32 0, ptr %4, align 4
  br label %10

10:                                               ; preds = %58, %9
  %11 = load i32, ptr %4, align 4
  %12 = load i32, ptr %2, align 4
  %13 = sub nsw i32 %12, 2
  %14 = icmp sle i32 %11, %13
  br i1 %14, label %15, label %61

15:                                               ; preds = %10
  store i32 0, ptr %5, align 4
  store i32 0, ptr %6, align 4
  %16 = call i32 (...) @nondet()
  store i32 %16, ptr %3, align 4
  br label %17

17:                                               ; preds = %56, %15
  %18 = load i32, ptr %5, align 4
  %19 = mul nsw i32 2, %18
  %20 = add nsw i32 %19, 1
  %21 = load i32, ptr %2, align 4
  %22 = sub nsw i32 %21, 2
  %23 = load i32, ptr %4, align 4
  %24 = sub nsw i32 %22, %23
  %25 = icmp sle i32 %20, %24
  br i1 %25, label %26, label %57

26:                                               ; preds = %17
  %27 = load i32, ptr %5, align 4
  %28 = mul nsw i32 2, %27
  %29 = add nsw i32 %28, 1
  %30 = load i32, ptr %2, align 4
  %31 = sub nsw i32 %30, 2
  %32 = load i32, ptr %4, align 4
  %33 = sub nsw i32 %31, %32
  %34 = icmp eq i32 %29, %33
  br i1 %34, label %39, label %35

35:                                               ; preds = %26
  %36 = call i32 (...) @nondet()
  %37 = call i32 (...) @nondet()
  %38 = icmp slt i32 %36, %37
  br i1 %38, label %39, label %43

39:                                               ; preds = %35, %26
  %40 = load i32, ptr %5, align 4
  %41 = mul nsw i32 2, %40
  %42 = add nsw i32 %41, 1
  store i32 %42, ptr %6, align 4
  br label %47

43:                                               ; preds = %35
  %44 = load i32, ptr %5, align 4
  %45 = mul nsw i32 2, %44
  %46 = add nsw i32 %45, 2
  store i32 %46, ptr %6, align 4
  br label %47

47:                                               ; preds = %43, %39
  %48 = call i32 (...) @nondet()
  %49 = call i32 (...) @nondet()
  %50 = icmp sgt i32 %48, %49
  br i1 %50, label %51, label %54

51:                                               ; preds = %47
  %52 = call i32 (...) @nondet()
  store i32 %52, ptr %3, align 4
  %53 = load i32, ptr %6, align 4
  store i32 %53, ptr %5, align 4
  br label %56

54:                                               ; preds = %47
  %55 = load i32, ptr %2, align 4
  store i32 %55, ptr %5, align 4
  br label %56

56:                                               ; preds = %54, %51
  br label %17, !llvm.loop !6

57:                                               ; preds = %17
  br label %58

58:                                               ; preds = %57
  %59 = load i32, ptr %4, align 4
  %60 = add nsw i32 %59, 1
  store i32 %60, ptr %4, align 4
  br label %10, !llvm.loop !8

61:                                               ; preds = %10
  br label %62

62:                                               ; preds = %61, %1
  ret void
}

declare i32 @nondet(...) #1

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
