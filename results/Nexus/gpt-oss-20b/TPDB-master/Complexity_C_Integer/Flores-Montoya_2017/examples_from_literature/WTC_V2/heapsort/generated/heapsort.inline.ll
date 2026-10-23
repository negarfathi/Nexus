; ModuleID = '/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/Complexity_C_Integer/Flores-Montoya_2017/examples_from_literature/WTC_V2/heapsort/generated/heapsort.inline.bc'
source_filename = "/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/Complexity_C_Integer/Flores-Montoya_2017/examples_from_literature/WTC_V2/heapsort/generated/heapsort.inline.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @heapsort(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  store i32 %0, ptr %3, align 4
  store i32 1, ptr %4, align 4
  br label %8

8:                                                ; preds = %84, %1
  %9 = load i32, ptr %3, align 4
  %10 = icmp sgt i32 %9, 0
  br i1 %10, label %11, label %14

11:                                               ; preds = %8
  %12 = load i32, ptr %4, align 4
  %13 = icmp sge i32 %12, 1
  br label %14

14:                                               ; preds = %11, %8
  %15 = phi i1 [ false, %8 ], [ %13, %11 ]
  br i1 %15, label %16, label %85

16:                                               ; preds = %14
  %17 = load i32, ptr %4, align 4
  %18 = mul nsw i32 2, %17
  store i32 %18, ptr %5, align 4
  %19 = load i32, ptr %4, align 4
  %20 = mul nsw i32 2, %19
  %21 = add nsw i32 %20, 1
  store i32 %21, ptr %6, align 4
  %22 = load i32, ptr %5, align 4
  %23 = load i32, ptr %3, align 4
  %24 = icmp sle i32 %22, %23
  br i1 %24, label %25, label %41

25:                                               ; preds = %16
  %26 = load i32, ptr %5, align 4
  %27 = icmp slt i32 %26, 1
  br i1 %27, label %32, label %28

28:                                               ; preds = %25
  %29 = load i32, ptr %5, align 4
  %30 = load i32, ptr %3, align 4
  %31 = icmp sgt i32 %29, %30
  br i1 %31, label %32, label %33

32:                                               ; preds = %28, %25
  store i32 0, ptr %2, align 4
  br label %86

33:                                               ; preds = %28
  %34 = call i32 (...) @nondet()
  %35 = icmp sgt i32 %34, 0
  br i1 %35, label %36, label %38

36:                                               ; preds = %33
  %37 = load i32, ptr %5, align 4
  store i32 %37, ptr %7, align 4
  br label %40

38:                                               ; preds = %33
  %39 = load i32, ptr %4, align 4
  store i32 %39, ptr %7, align 4
  br label %40

40:                                               ; preds = %38, %36
  br label %43

41:                                               ; preds = %16
  %42 = load i32, ptr %4, align 4
  store i32 %42, ptr %7, align 4
  br label %43

43:                                               ; preds = %41, %40
  %44 = load i32, ptr %6, align 4
  %45 = load i32, ptr %3, align 4
  %46 = icmp sle i32 %44, %45
  br i1 %46, label %47, label %61

47:                                               ; preds = %43
  %48 = load i32, ptr %6, align 4
  %49 = icmp slt i32 %48, 1
  br i1 %49, label %54, label %50

50:                                               ; preds = %47
  %51 = load i32, ptr %6, align 4
  %52 = load i32, ptr %3, align 4
  %53 = icmp sgt i32 %51, %52
  br i1 %53, label %54, label %55

54:                                               ; preds = %50, %47
  store i32 0, ptr %2, align 4
  br label %86

55:                                               ; preds = %50
  %56 = call i32 (...) @nondet()
  %57 = icmp sgt i32 %56, 0
  br i1 %57, label %58, label %60

58:                                               ; preds = %55
  %59 = load i32, ptr %6, align 4
  store i32 %59, ptr %7, align 4
  br label %60

60:                                               ; preds = %58, %55
  br label %61

61:                                               ; preds = %60, %43
  %62 = load i32, ptr %4, align 4
  %63 = load i32, ptr %7, align 4
  %64 = icmp ne i32 %62, %63
  br i1 %64, label %65, label %83

65:                                               ; preds = %61
  %66 = load i32, ptr %4, align 4
  %67 = icmp slt i32 %66, 1
  br i1 %67, label %72, label %68

68:                                               ; preds = %65
  %69 = load i32, ptr %4, align 4
  %70 = load i32, ptr %3, align 4
  %71 = icmp sgt i32 %69, %70
  br i1 %71, label %72, label %73

72:                                               ; preds = %68, %65
  store i32 0, ptr %2, align 4
  br label %86

73:                                               ; preds = %68
  %74 = load i32, ptr %7, align 4
  %75 = icmp slt i32 %74, 1
  br i1 %75, label %80, label %76

76:                                               ; preds = %73
  %77 = load i32, ptr %7, align 4
  %78 = load i32, ptr %3, align 4
  %79 = icmp sgt i32 %77, %78
  br i1 %79, label %80, label %81

80:                                               ; preds = %76, %73
  store i32 0, ptr %2, align 4
  br label %86

81:                                               ; preds = %76
  %82 = load i32, ptr %7, align 4
  store i32 %82, ptr %4, align 4
  br label %84

83:                                               ; preds = %61
  store i32 0, ptr %2, align 4
  br label %86

84:                                               ; preds = %81
  br label %8, !llvm.loop !6

85:                                               ; preds = %14
  store i32 0, ptr %2, align 4
  br label %86

86:                                               ; preds = %85, %83, %80, %72, %54, %32
  %87 = load i32, ptr %2, align 4
  ret i32 %87
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
