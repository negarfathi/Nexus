; ModuleID = '/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/C_Integer/Stroeder_15/ChawdharyCookGulwaniSagivYang-ESOP2008-aaron4_true-termination/generated/ChawdharyCookGulwaniSagivYang-ESOP2008-aaron4_true-termination.inline.bc'
source_filename = "/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/C_Integer/Stroeder_15/ChawdharyCookGulwaniSagivYang-ESOP2008-aaron4_true-termination/generated/ChawdharyCookGulwaniSagivYang-ESOP2008-aaron4_true-termination.inline.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  store i32 0, ptr %1, align 4
  %8 = call i32 @__VERIFIER_nondet_int()
  store i32 %8, ptr %2, align 4
  %9 = call i32 @__VERIFIER_nondet_int()
  store i32 %9, ptr %3, align 4
  %10 = call i32 @__VERIFIER_nondet_int()
  store i32 %10, ptr %4, align 4
  %11 = call i32 @__VERIFIER_nondet_int()
  store i32 %11, ptr %5, align 4
  %12 = call i32 @__VERIFIER_nondet_int()
  store i32 %12, ptr %6, align 4
  %13 = call i32 @__VERIFIER_nondet_int()
  store i32 %13, ptr %7, align 4
  br label %14

14:                                               ; preds = %93, %0
  %15 = load i32, ptr %5, align 4
  %16 = load i32, ptr %2, align 4
  %17 = icmp sge i32 %15, %16
  br i1 %17, label %18, label %22

18:                                               ; preds = %14
  %19 = load i32, ptr %6, align 4
  %20 = load i32, ptr %3, align 4
  %21 = icmp sge i32 %19, %20
  br i1 %21, label %38, label %22

22:                                               ; preds = %18, %14
  %23 = load i32, ptr %5, align 4
  %24 = load i32, ptr %2, align 4
  %25 = icmp sge i32 %23, %24
  br i1 %25, label %26, label %30

26:                                               ; preds = %22
  %27 = load i32, ptr %6, align 4
  %28 = load i32, ptr %3, align 4
  %29 = icmp sle i32 %27, %28
  br i1 %29, label %38, label %30

30:                                               ; preds = %26, %22
  %31 = load i32, ptr %5, align 4
  %32 = load i32, ptr %2, align 4
  %33 = icmp sle i32 %31, %32
  br i1 %33, label %34, label %43

34:                                               ; preds = %30
  %35 = load i32, ptr %6, align 4
  %36 = load i32, ptr %3, align 4
  %37 = icmp sge i32 %35, %36
  br i1 %37, label %38, label %43

38:                                               ; preds = %34, %26, %18
  %39 = load i32, ptr %4, align 4
  %40 = load i32, ptr %7, align 4
  %41 = add nsw i32 %40, 1
  %42 = icmp sge i32 %39, %41
  br label %43

43:                                               ; preds = %38, %34, %30
  %44 = phi i1 [ false, %34 ], [ false, %30 ], [ %42, %38 ]
  br i1 %44, label %45, label %94

45:                                               ; preds = %43
  %46 = load i32, ptr %5, align 4
  %47 = load i32, ptr %2, align 4
  %48 = icmp sge i32 %46, %47
  br i1 %48, label %49, label %66

49:                                               ; preds = %45
  %50 = load i32, ptr %6, align 4
  %51 = load i32, ptr %3, align 4
  %52 = icmp sge i32 %50, %51
  br i1 %52, label %53, label %66

53:                                               ; preds = %49
  %54 = call i32 @__VERIFIER_nondet_int()
  %55 = icmp ne i32 %54, 0
  br i1 %55, label %56, label %62

56:                                               ; preds = %53
  %57 = load i32, ptr %3, align 4
  %58 = load i32, ptr %4, align 4
  %59 = add nsw i32 %57, %58
  store i32 %59, ptr %3, align 4
  %60 = load i32, ptr %4, align 4
  store i32 %60, ptr %7, align 4
  %61 = call i32 @__VERIFIER_nondet_int()
  store i32 %61, ptr %4, align 4
  br label %65

62:                                               ; preds = %53
  %63 = load i32, ptr %2, align 4
  %64 = add nsw i32 %63, 1
  store i32 %64, ptr %2, align 4
  br label %65

65:                                               ; preds = %62, %56
  br label %93

66:                                               ; preds = %49, %45
  %67 = load i32, ptr %5, align 4
  %68 = load i32, ptr %2, align 4
  %69 = icmp sge i32 %67, %68
  br i1 %69, label %70, label %77

70:                                               ; preds = %66
  %71 = load i32, ptr %6, align 4
  %72 = load i32, ptr %3, align 4
  %73 = icmp sle i32 %71, %72
  br i1 %73, label %74, label %77

74:                                               ; preds = %70
  %75 = load i32, ptr %2, align 4
  %76 = add nsw i32 %75, 1
  store i32 %76, ptr %2, align 4
  br label %92

77:                                               ; preds = %70, %66
  %78 = load i32, ptr %5, align 4
  %79 = load i32, ptr %2, align 4
  %80 = icmp sle i32 %78, %79
  br i1 %80, label %81, label %91

81:                                               ; preds = %77
  %82 = load i32, ptr %6, align 4
  %83 = load i32, ptr %3, align 4
  %84 = icmp sge i32 %82, %83
  br i1 %84, label %85, label %91

85:                                               ; preds = %81
  %86 = load i32, ptr %3, align 4
  %87 = load i32, ptr %4, align 4
  %88 = add nsw i32 %86, %87
  store i32 %88, ptr %3, align 4
  %89 = load i32, ptr %4, align 4
  store i32 %89, ptr %7, align 4
  %90 = call i32 @__VERIFIER_nondet_int()
  store i32 %90, ptr %4, align 4
  br label %91

91:                                               ; preds = %85, %81, %77
  br label %92

92:                                               ; preds = %91, %74
  br label %93

93:                                               ; preds = %92, %65
  br label %14, !llvm.loop !6

94:                                               ; preds = %43
  ret i32 0
}

declare i32 @__VERIFIER_nondet_int() #1

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
