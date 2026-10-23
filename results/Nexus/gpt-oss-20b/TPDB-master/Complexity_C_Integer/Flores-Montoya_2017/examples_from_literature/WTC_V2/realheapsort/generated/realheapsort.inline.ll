; ModuleID = '/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/Complexity_C_Integer/Flores-Montoya_2017/examples_from_literature/WTC_V2/realheapsort/generated/realheapsort.inline.bc'
source_filename = "/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/Complexity_C_Integer/Flores-Montoya_2017/examples_from_literature/WTC_V2/realheapsort/generated/realheapsort.inline.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define dso_local void @realheapsort(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  store i32 %0, ptr %2, align 4
  %7 = load i32, ptr %2, align 4
  %8 = icmp sgt i32 %7, 2
  br i1 %8, label %9, label %89

9:                                                ; preds = %1
  store i32 1, ptr %4, align 4
  br label %10

10:                                               ; preds = %33, %9
  %11 = load i32, ptr %4, align 4
  %12 = load i32, ptr %2, align 4
  %13 = sub nsw i32 %12, 1
  %14 = icmp sle i32 %11, %13
  br i1 %14, label %15, label %36

15:                                               ; preds = %10
  %16 = load i32, ptr %4, align 4
  store i32 %16, ptr %5, align 4
  br label %17

17:                                               ; preds = %26, %15
  %18 = load i32, ptr %5, align 4
  %19 = icmp sgt i32 %18, 0
  br i1 %19, label %20, label %24

20:                                               ; preds = %17
  %21 = call i32 (...) @nondet()
  %22 = call i32 (...) @nondet()
  %23 = icmp sgt i32 %21, %22
  br label %24

24:                                               ; preds = %20, %17
  %25 = phi i1 [ false, %17 ], [ %23, %20 ]
  br i1 %25, label %26, label %32

26:                                               ; preds = %24
  %27 = call i32 (...) @nondet()
  store i32 %27, ptr %3, align 4
  %28 = load i32, ptr %5, align 4
  %29 = add nsw i32 %28, 1
  %30 = sdiv i32 %29, 2
  %31 = sub nsw i32 %30, 1
  store i32 %31, ptr %5, align 4
  br label %17, !llvm.loop !6

32:                                               ; preds = %24
  br label %33

33:                                               ; preds = %32
  %34 = load i32, ptr %4, align 4
  %35 = add nsw i32 %34, 1
  store i32 %35, ptr %4, align 4
  br label %10, !llvm.loop !8

36:                                               ; preds = %10
  store i32 0, ptr %4, align 4
  br label %37

37:                                               ; preds = %85, %36
  %38 = load i32, ptr %4, align 4
  %39 = load i32, ptr %2, align 4
  %40 = sub nsw i32 %39, 2
  %41 = icmp sle i32 %38, %40
  br i1 %41, label %42, label %88

42:                                               ; preds = %37
  store i32 0, ptr %5, align 4
  store i32 0, ptr %6, align 4
  %43 = call i32 (...) @nondet()
  store i32 %43, ptr %3, align 4
  br label %44

44:                                               ; preds = %83, %42
  %45 = load i32, ptr %5, align 4
  %46 = mul nsw i32 2, %45
  %47 = add nsw i32 %46, 1
  %48 = load i32, ptr %2, align 4
  %49 = sub nsw i32 %48, 2
  %50 = load i32, ptr %4, align 4
  %51 = sub nsw i32 %49, %50
  %52 = icmp sle i32 %47, %51
  br i1 %52, label %53, label %84

53:                                               ; preds = %44
  %54 = load i32, ptr %5, align 4
  %55 = mul nsw i32 2, %54
  %56 = add nsw i32 %55, 1
  %57 = load i32, ptr %2, align 4
  %58 = sub nsw i32 %57, 2
  %59 = load i32, ptr %4, align 4
  %60 = sub nsw i32 %58, %59
  %61 = icmp eq i32 %56, %60
  br i1 %61, label %66, label %62

62:                                               ; preds = %53
  %63 = call i32 (...) @nondet()
  %64 = call i32 (...) @nondet()
  %65 = icmp slt i32 %63, %64
  br i1 %65, label %66, label %70

66:                                               ; preds = %62, %53
  %67 = load i32, ptr %5, align 4
  %68 = mul nsw i32 2, %67
  %69 = add nsw i32 %68, 1
  store i32 %69, ptr %6, align 4
  br label %74

70:                                               ; preds = %62
  %71 = load i32, ptr %5, align 4
  %72 = mul nsw i32 2, %71
  %73 = add nsw i32 %72, 2
  store i32 %73, ptr %6, align 4
  br label %74

74:                                               ; preds = %70, %66
  %75 = call i32 (...) @nondet()
  %76 = call i32 (...) @nondet()
  %77 = icmp sgt i32 %75, %76
  br i1 %77, label %78, label %81

78:                                               ; preds = %74
  %79 = call i32 (...) @nondet()
  store i32 %79, ptr %3, align 4
  %80 = load i32, ptr %6, align 4
  store i32 %80, ptr %5, align 4
  br label %83

81:                                               ; preds = %74
  %82 = load i32, ptr %2, align 4
  store i32 %82, ptr %5, align 4
  br label %83

83:                                               ; preds = %81, %78
  br label %44, !llvm.loop !9

84:                                               ; preds = %44
  br label %85

85:                                               ; preds = %84
  %86 = load i32, ptr %4, align 4
  %87 = add nsw i32 %86, 1
  store i32 %87, ptr %4, align 4
  br label %37, !llvm.loop !10

88:                                               ; preds = %37
  br label %89

89:                                               ; preds = %88, %1
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
!9 = distinct !{!9, !7}
!10 = distinct !{!10, !7}
