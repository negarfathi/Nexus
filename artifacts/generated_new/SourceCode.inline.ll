; ModuleID = '/home/quasar/Documents/Nexus/artifacts/generated/SourceCode.inline.bc'
source_filename = "/home/quasar/Documents/Nexus/artifacts/generated/SourceCode.inline.c"
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
  %12 = load i32, ptr %2, align 4
  %13 = icmp slt i32 %12, 0
  br i1 %13, label %14, label %15

14:                                               ; preds = %0
  store i32 6, ptr %2, align 4
  br label %15

15:                                               ; preds = %14, %0
  %16 = load i32, ptr %2, align 4
  %17 = icmp sgt i32 %16, 10
  br i1 %17, label %18, label %19

18:                                               ; preds = %15
  store i32 10, ptr %2, align 4
  br label %19

19:                                               ; preds = %18, %15
  br label %20

20:                                               ; preds = %37, %36, %19
  %21 = load i32, ptr %2, align 4
  %22 = icmp sgt i32 %21, 0
  br i1 %22, label %23, label %40

23:                                               ; preds = %20
  %24 = load i32, ptr %2, align 4
  %25 = icmp eq i32 %24, 9
  br i1 %25, label %26, label %27

26:                                               ; preds = %23
  store i32 11, ptr %1, align 4
  br label %104

27:                                               ; preds = %23
  %28 = load i32, ptr %2, align 4
  %29 = icmp eq i32 %28, 7
  br i1 %29, label %30, label %31

30:                                               ; preds = %27
  br label %40

31:                                               ; preds = %27
  %32 = load i32, ptr %2, align 4
  %33 = sub nsw i32 %32, 1
  store i32 %33, ptr %2, align 4
  %34 = load i32, ptr %2, align 4
  %35 = icmp eq i32 %34, 5
  br i1 %35, label %36, label %37

36:                                               ; preds = %31
  br label %20, !llvm.loop !6

37:                                               ; preds = %31
  %38 = load i32, ptr %2, align 4
  %39 = sub nsw i32 %38, 1
  store i32 %39, ptr %2, align 4
  br label %20, !llvm.loop !6

40:                                               ; preds = %30, %20
  %41 = load i32, ptr %3, align 4
  %42 = icmp slt i32 %41, 0
  br i1 %42, label %43, label %44

43:                                               ; preds = %40
  store i32 0, ptr %3, align 4
  br label %44

44:                                               ; preds = %43, %40
  %45 = load i32, ptr %3, align 4
  %46 = icmp sgt i32 %45, 10
  br i1 %46, label %47, label %48

47:                                               ; preds = %44
  store i32 10, ptr %3, align 4
  br label %48

48:                                               ; preds = %47, %44
  %49 = load i32, ptr %3, align 4
  store i32 %49, ptr %6, align 4
  store i32 0, ptr %7, align 4
  br label %50

50:                                               ; preds = %100, %99, %56, %48
  %51 = load i32, ptr %6, align 4
  %52 = icmp sge i32 %51, 0
  br i1 %52, label %53, label %103

53:                                               ; preds = %50
  %54 = load i32, ptr %6, align 4
  %55 = icmp eq i32 %54, 10
  br i1 %55, label %56, label %57

56:                                               ; preds = %53
  store i32 4, ptr %6, align 4
  br label %50, !llvm.loop !8

57:                                               ; preds = %53
  %58 = load i32, ptr %6, align 4
  %59 = icmp eq i32 %58, 8
  br i1 %59, label %60, label %61

60:                                               ; preds = %57
  store i32 22, ptr %1, align 4
  br label %104

61:                                               ; preds = %57
  %62 = load i32, ptr %6, align 4
  %63 = icmp eq i32 %62, 6
  br i1 %63, label %64, label %65

64:                                               ; preds = %61
  br label %103

65:                                               ; preds = %61
  %66 = load i32, ptr %6, align 4
  %67 = add nsw i32 %66, 2
  store i32 %67, ptr %7, align 4
  br label %68

68:                                               ; preds = %92, %91, %85, %65
  %69 = load i32, ptr %7, align 4
  %70 = icmp sgt i32 %69, 0
  br i1 %70, label %71, label %93

71:                                               ; preds = %68
  %72 = load i32, ptr %7, align 4
  %73 = icmp eq i32 %72, 7
  br i1 %73, label %74, label %75

74:                                               ; preds = %71
  store i32 33, ptr %1, align 4
  br label %104

75:                                               ; preds = %71
  %76 = load i32, ptr %7, align 4
  %77 = icmp eq i32 %76, 5
  br i1 %77, label %78, label %79

78:                                               ; preds = %75
  br label %93

79:                                               ; preds = %75
  %80 = load i32, ptr %5, align 4
  %81 = icmp eq i32 %80, 0
  br i1 %81, label %82, label %86

82:                                               ; preds = %79
  %83 = load i32, ptr %7, align 4
  %84 = icmp eq i32 %83, 2
  br i1 %84, label %85, label %86

85:                                               ; preds = %82
  br label %68, !llvm.loop !9

86:                                               ; preds = %82, %79
  %87 = load i32, ptr %7, align 4
  %88 = sub nsw i32 %87, 1
  store i32 %88, ptr %7, align 4
  %89 = load i32, ptr %7, align 4
  %90 = icmp eq i32 %89, 3
  br i1 %90, label %91, label %92

91:                                               ; preds = %86
  br label %68, !llvm.loop !9

92:                                               ; preds = %86
  br label %68, !llvm.loop !9

93:                                               ; preds = %78, %68
  %94 = load i32, ptr %4, align 4
  %95 = icmp eq i32 %94, 0
  br i1 %95, label %96, label %100

96:                                               ; preds = %93
  %97 = load i32, ptr %6, align 4
  %98 = icmp eq i32 %97, 2
  br i1 %98, label %99, label %100

99:                                               ; preds = %96
  br label %50, !llvm.loop !8

100:                                              ; preds = %96, %93
  %101 = load i32, ptr %6, align 4
  %102 = sub nsw i32 %101, 1
  store i32 %102, ptr %6, align 4
  br label %50, !llvm.loop !8

103:                                              ; preds = %64, %50
  store i32 0, ptr %1, align 4
  br label %104

104:                                              ; preds = %103, %74, %60, %26
  %105 = load i32, ptr %1, align 4
  ret i32 %105
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
!8 = distinct !{!8, !7}
!9 = distinct !{!9, !7}
