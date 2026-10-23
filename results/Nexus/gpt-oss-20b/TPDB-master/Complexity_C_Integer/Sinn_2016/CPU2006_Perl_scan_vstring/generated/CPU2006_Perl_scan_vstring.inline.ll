; ModuleID = '/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/Complexity_C_Integer/Sinn_2016/CPU2006_Perl_scan_vstring/generated/CPU2006_Perl_scan_vstring.inline.bc'
source_filename = "/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/Complexity_C_Integer/Sinn_2016/CPU2006_Perl_scan_vstring/generated/CPU2006_Perl_scan_vstring.inline.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define dso_local void @Perl_scan_vstring(i32 noundef %0, i32 noundef %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  store i32 %0, ptr %3, align 4
  store i32 %1, ptr %4, align 4
  %8 = load i32, ptr %3, align 4
  store i32 %8, ptr %5, align 4
  %9 = load i32, ptr %3, align 4
  store i32 %9, ptr %6, align 4
  %10 = call i32 (...) @nondet()
  %11 = icmp ne i32 %10, 0
  br i1 %11, label %12, label %15

12:                                               ; preds = %2
  %13 = load i32, ptr %5, align 4
  %14 = add nsw i32 %13, 1
  store i32 %14, ptr %5, align 4
  br label %15

15:                                               ; preds = %12, %2
  br label %16

16:                                               ; preds = %25, %15
  %17 = load i32, ptr %5, align 4
  %18 = load i32, ptr %4, align 4
  %19 = icmp slt i32 %17, %18
  br i1 %19, label %20, label %23

20:                                               ; preds = %16
  %21 = call i32 (...) @nondet()
  %22 = icmp ne i32 %21, 0
  br label %23

23:                                               ; preds = %20, %16
  %24 = phi i1 [ false, %16 ], [ %22, %20 ]
  br i1 %24, label %25, label %28

25:                                               ; preds = %23
  %26 = load i32, ptr %5, align 4
  %27 = add nsw i32 %26, 1
  store i32 %27, ptr %5, align 4
  br label %16, !llvm.loop !6

28:                                               ; preds = %23
  %29 = call i32 (...) @nondet()
  %30 = icmp ne i32 %29, 0
  br i1 %30, label %31, label %74

31:                                               ; preds = %28
  %32 = call i32 (...) @nondet()
  %33 = icmp ne i32 %32, 0
  br i1 %33, label %34, label %37

34:                                               ; preds = %31
  %35 = load i32, ptr %3, align 4
  %36 = add nsw i32 %35, 1
  store i32 %36, ptr %3, align 4
  br label %37

37:                                               ; preds = %34, %31
  br label %38

38:                                               ; preds = %72, %37
  %39 = load i32, ptr %5, align 4
  store i32 %39, ptr %7, align 4
  br label %40

40:                                               ; preds = %45, %38
  %41 = load i32, ptr %7, align 4
  %42 = add nsw i32 %41, -1
  store i32 %42, ptr %7, align 4
  %43 = load i32, ptr %3, align 4
  %44 = icmp sge i32 %42, %43
  br i1 %44, label %45, label %46

45:                                               ; preds = %40
  br label %40, !llvm.loop !8

46:                                               ; preds = %40
  %47 = load i32, ptr %5, align 4
  %48 = add nsw i32 %47, 1
  %49 = load i32, ptr %4, align 4
  %50 = icmp slt i32 %48, %49
  br i1 %50, label %51, label %57

51:                                               ; preds = %46
  %52 = call i32 (...) @nondet()
  %53 = icmp ne i32 %52, 0
  br i1 %53, label %54, label %57

54:                                               ; preds = %51
  %55 = load i32, ptr %5, align 4
  %56 = add nsw i32 %55, 1
  store i32 %56, ptr %5, align 4
  store i32 %56, ptr %3, align 4
  br label %59

57:                                               ; preds = %51, %46
  %58 = load i32, ptr %5, align 4
  store i32 %58, ptr %3, align 4
  br label %73

59:                                               ; preds = %54
  br label %60

60:                                               ; preds = %69, %59
  %61 = load i32, ptr %5, align 4
  %62 = load i32, ptr %4, align 4
  %63 = icmp slt i32 %61, %62
  br i1 %63, label %64, label %67

64:                                               ; preds = %60
  %65 = call i32 (...) @nondet()
  %66 = icmp ne i32 %65, 0
  br label %67

67:                                               ; preds = %64, %60
  %68 = phi i1 [ false, %60 ], [ %66, %64 ]
  br i1 %68, label %69, label %72

69:                                               ; preds = %67
  %70 = load i32, ptr %5, align 4
  %71 = add nsw i32 %70, 1
  store i32 %71, ptr %5, align 4
  br label %60, !llvm.loop !9

72:                                               ; preds = %67
  br label %38

73:                                               ; preds = %57
  br label %74

74:                                               ; preds = %73, %28
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
