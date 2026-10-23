; ModuleID = '/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/Complexity_C_Integer/Flores-Montoya_2017/examples_from_literature/WTC_V2/terminatorbubble/generated/terminatorbubble.inline.bc'
source_filename = "/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/Complexity_C_Integer/Flores-Montoya_2017/examples_from_literature/WTC_V2/terminatorbubble/generated/terminatorbubble.inline.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @terminatorbubble(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  store i32 %0, ptr %3, align 4
  store i32 0, ptr %4, align 4
  %8 = load i32, ptr %3, align 4
  store i32 %8, ptr %5, align 4
  %9 = load i32, ptr %3, align 4
  %10 = icmp sgt i32 %9, 0
  br i1 %10, label %11, label %62

11:                                               ; preds = %1
  br label %12

12:                                               ; preds = %59, %11
  %13 = load i32, ptr %5, align 4
  %14 = icmp sge i32 %13, 1
  br i1 %14, label %15, label %61

15:                                               ; preds = %12
  %16 = load i32, ptr %3, align 4
  %17 = icmp sle i32 %16, 0
  br i1 %17, label %18, label %19

18:                                               ; preds = %15
  store i32 0, ptr %2, align 4
  br label %63

19:                                               ; preds = %15
  store i32 1, ptr %6, align 4
  store i32 0, ptr %7, align 4
  br label %20

20:                                               ; preds = %48, %19
  %21 = load i32, ptr %6, align 4
  %22 = load i32, ptr %5, align 4
  %23 = sub nsw i32 %22, 1
  %24 = icmp sle i32 %21, %23
  br i1 %24, label %25, label %51

25:                                               ; preds = %20
  %26 = load i32, ptr %6, align 4
  %27 = icmp slt i32 %26, 1
  br i1 %27, label %32, label %28

28:                                               ; preds = %25
  %29 = load i32, ptr %6, align 4
  %30 = load i32, ptr %3, align 4
  %31 = icmp sgt i32 %29, %30
  br i1 %31, label %32, label %33

32:                                               ; preds = %28, %25
  store i32 0, ptr %2, align 4
  br label %63

33:                                               ; preds = %28
  %34 = load i32, ptr %6, align 4
  %35 = add nsw i32 %34, 1
  %36 = icmp slt i32 %35, 1
  br i1 %36, label %42, label %37

37:                                               ; preds = %33
  %38 = load i32, ptr %6, align 4
  %39 = add nsw i32 %38, 1
  %40 = load i32, ptr %3, align 4
  %41 = icmp sgt i32 %39, %40
  br i1 %41, label %42, label %43

42:                                               ; preds = %37, %33
  store i32 0, ptr %2, align 4
  br label %63

43:                                               ; preds = %37
  %44 = call i32 (...) @nondet()
  %45 = icmp sgt i32 %44, 0
  br i1 %45, label %46, label %48

46:                                               ; preds = %43
  %47 = load i32, ptr %6, align 4
  store i32 %47, ptr %7, align 4
  br label %48

48:                                               ; preds = %46, %43
  %49 = load i32, ptr %6, align 4
  %50 = add nsw i32 %49, 1
  store i32 %50, ptr %6, align 4
  br label %20, !llvm.loop !6

51:                                               ; preds = %20
  %52 = load i32, ptr %7, align 4
  %53 = icmp sgt i32 1, %52
  br i1 %53, label %58, label %54

54:                                               ; preds = %51
  %55 = load i32, ptr %7, align 4
  %56 = load i32, ptr %5, align 4
  %57 = icmp sge i32 %55, %56
  br i1 %57, label %58, label %59

58:                                               ; preds = %54, %51
  store i32 0, ptr %2, align 4
  br label %63

59:                                               ; preds = %54
  %60 = load i32, ptr %7, align 4
  store i32 %60, ptr %5, align 4
  br label %12, !llvm.loop !8

61:                                               ; preds = %12
  br label %62

62:                                               ; preds = %61, %1
  store i32 0, ptr %2, align 4
  br label %63

63:                                               ; preds = %62, %58, %42, %32, %18
  %64 = load i32, ptr %2, align 4
  ret i32 %64
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
