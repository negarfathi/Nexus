; ModuleID = '/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/Complexity_C_Integer/Sinn_2016/cBench_cf_decode_eol/generated/cBench_cf_decode_eol.inline.bc'
source_filename = "/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/Complexity_C_Integer/Sinn_2016/cBench_cf_decode_eol/generated/cBench_cf_decode_eol.inline.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define dso_local void @cf_decode_eol(i32 noundef %0, i32 noundef %1, i32 noundef %2, i32 noundef %3, i32 noundef %4) #0 {
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
  store i32 %0, ptr %6, align 4
  store i32 %1, ptr %7, align 4
  store i32 %2, ptr %8, align 4
  store i32 %3, ptr %9, align 4
  store i32 %4, ptr %10, align 4
  %16 = load i32, ptr %9, align 4
  store i32 %16, ptr %14, align 4
  %17 = load i32, ptr %10, align 4
  store i32 %17, ptr %15, align 4
  %18 = load i32, ptr %7, align 4
  store i32 %18, ptr %11, align 4
  store i32 0, ptr %12, align 4
  br label %19

19:                                               ; preds = %50, %5
  %20 = load i32, ptr %12, align 4
  %21 = icmp slt i32 %20, 11
  br i1 %21, label %22, label %53

22:                                               ; preds = %19
  %23 = load i32, ptr %11, align 4
  %24 = icmp slt i32 %23, 1
  br i1 %24, label %25, label %47

25:                                               ; preds = %22
  %26 = load i32, ptr %15, align 4
  %27 = load i32, ptr %14, align 4
  %28 = sub nsw i32 %26, %27
  %29 = icmp slt i32 %28, 3
  br i1 %29, label %30, label %41

30:                                               ; preds = %25
  %31 = load i32, ptr %14, align 4
  %32 = load i32, ptr %15, align 4
  %33 = icmp slt i32 %31, %32
  br i1 %33, label %34, label %37

34:                                               ; preds = %30
  %35 = load i32, ptr %14, align 4
  %36 = add nsw i32 %35, 1
  store i32 %36, ptr %14, align 4
  br label %38

37:                                               ; preds = %30
  br label %88

38:                                               ; preds = %34
  %39 = load i32, ptr %11, align 4
  %40 = add nsw i32 %39, 8
  store i32 %40, ptr %11, align 4
  br label %46

41:                                               ; preds = %25
  %42 = load i32, ptr %11, align 4
  %43 = add nsw i32 %42, 24
  store i32 %43, ptr %11, align 4
  %44 = load i32, ptr %14, align 4
  %45 = add nsw i32 %44, 3
  store i32 %45, ptr %14, align 4
  br label %46

46:                                               ; preds = %41, %38
  br label %47

47:                                               ; preds = %46, %22
  %48 = load i32, ptr %11, align 4
  %49 = sub nsw i32 %48, 1
  store i32 %49, ptr %11, align 4
  br label %50

50:                                               ; preds = %47
  %51 = load i32, ptr %12, align 4
  %52 = add nsw i32 %51, 1
  store i32 %52, ptr %12, align 4
  br label %19, !llvm.loop !6

53:                                               ; preds = %19
  %54 = load i32, ptr %8, align 4
  %55 = icmp sgt i32 %54, 0
  %56 = zext i1 %55 to i64
  %57 = select i1 %55, i32 2, i32 1
  store i32 %57, ptr %13, align 4
  br label %58

58:                                               ; preds = %84, %53
  %59 = load i32, ptr %11, align 4
  %60 = load i32, ptr %13, align 4
  %61 = icmp slt i32 %59, %60
  br i1 %61, label %62, label %84

62:                                               ; preds = %58
  %63 = load i32, ptr %15, align 4
  %64 = load i32, ptr %14, align 4
  %65 = sub nsw i32 %63, %64
  %66 = icmp slt i32 %65, 3
  br i1 %66, label %67, label %78

67:                                               ; preds = %62
  %68 = load i32, ptr %14, align 4
  %69 = load i32, ptr %15, align 4
  %70 = icmp slt i32 %68, %69
  br i1 %70, label %71, label %74

71:                                               ; preds = %67
  %72 = load i32, ptr %14, align 4
  %73 = add nsw i32 %72, 1
  store i32 %73, ptr %14, align 4
  br label %75

74:                                               ; preds = %67
  br label %87

75:                                               ; preds = %71
  %76 = load i32, ptr %11, align 4
  %77 = add nsw i32 %76, 8
  store i32 %77, ptr %11, align 4
  br label %83

78:                                               ; preds = %62
  %79 = load i32, ptr %11, align 4
  %80 = add nsw i32 %79, 24
  store i32 %80, ptr %11, align 4
  %81 = load i32, ptr %14, align 4
  %82 = add nsw i32 %81, 3
  store i32 %82, ptr %14, align 4
  br label %83

83:                                               ; preds = %78, %75
  br label %84

84:                                               ; preds = %83, %58
  %85 = load i32, ptr %11, align 4
  %86 = sub nsw i32 %85, 1
  store i32 %86, ptr %11, align 4
  br label %58

87:                                               ; preds = %74
  br label %88

88:                                               ; preds = %87, %37
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
