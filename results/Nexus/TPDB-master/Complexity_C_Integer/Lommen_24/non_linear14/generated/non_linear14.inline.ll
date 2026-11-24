; ModuleID = '/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/Complexity_C_Integer/Lommen_24/non_linear14/generated/non_linear14.inline.bc'
source_filename = "/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/Complexity_C_Integer/Lommen_24/non_linear14/generated/non_linear14.inline.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define dso_local void @non_linear14(i32 noundef %0, i32 noundef %1, i32 noundef %2, i32 noundef %3, i32 noundef %4, i32 noundef %5) #0 {
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  %13 = alloca i32, align 4
  %14 = alloca i32, align 4
  %15 = alloca i32, align 4
  %16 = alloca i32, align 4
  store i32 %0, ptr %7, align 4
  store i32 %1, ptr %8, align 4
  store i32 %2, ptr %9, align 4
  store i32 %3, ptr %10, align 4
  store i32 %4, ptr %11, align 4
  store i32 %5, ptr %12, align 4
  %17 = call i32 @__VERIFIER_nondet_int()
  store i32 %17, ptr %13, align 4
  %18 = call i32 @__VERIFIER_nondet_int()
  store i32 %18, ptr %14, align 4
  %19 = load i32, ptr %13, align 4
  store i32 %19, ptr %7, align 4
  br label %20

20:                                               ; preds = %6, %98
  call void asm sideeffect "# NEXUS_SOURCE_LOOP_ID_1_PARENT_0", "~{memory},~{dirflag},~{fpsr},~{flags}"() #2, !srcloc !6
  %21 = load i32, ptr %7, align 4
  %22 = icmp sle i32 1, %21
  br i1 %22, label %23, label %33

23:                                               ; preds = %20
  %24 = load i32, ptr %7, align 4
  %25 = icmp sle i32 %24, 3
  br i1 %25, label %26, label %33

26:                                               ; preds = %23
  %27 = load i32, ptr %14, align 4
  %28 = icmp eq i32 %27, 0
  br i1 %28, label %29, label %33

29:                                               ; preds = %26
  %30 = load i32, ptr %7, align 4
  %31 = add nsw i32 %30, 1
  store i32 %31, ptr %7, align 4
  %32 = call i32 @__VERIFIER_nondet_int()
  store i32 %32, ptr %14, align 4
  br label %98

33:                                               ; preds = %26, %23, %20
  %34 = load i32, ptr %8, align 4
  %35 = icmp sgt i32 %34, 1
  br i1 %35, label %36, label %43

36:                                               ; preds = %33
  %37 = load i32, ptr %14, align 4
  %38 = icmp eq i32 %37, 1
  br i1 %38, label %39, label %43

39:                                               ; preds = %36
  %40 = load i32, ptr %8, align 4
  %41 = sub nsw i32 %40, 1
  store i32 %41, ptr %8, align 4
  %42 = call i32 @__VERIFIER_nondet_int()
  store i32 %42, ptr %14, align 4
  br label %97

43:                                               ; preds = %36, %33
  br label %44

44:                                               ; preds = %68, %43
  %45 = load i32, ptr %10, align 4
  %46 = load i32, ptr %10, align 4
  %47 = mul nsw i32 %45, %46
  %48 = load i32, ptr %9, align 4
  %49 = load i32, ptr %9, align 4
  %50 = mul nsw i32 %48, %49
  %51 = load i32, ptr %9, align 4
  %52 = mul nsw i32 %50, %51
  %53 = load i32, ptr %9, align 4
  %54 = mul nsw i32 %52, %53
  %55 = load i32, ptr %9, align 4
  %56 = mul nsw i32 %54, %55
  %57 = sub nsw i32 %47, %56
  %58 = load i32, ptr %11, align 4
  %59 = mul nsw i32 2, %58
  %60 = load i32, ptr %12, align 4
  %61 = sub nsw i32 %59, %60
  %62 = icmp slt i32 %57, %61
  br i1 %62, label %63, label %66

63:                                               ; preds = %44
  %64 = load i32, ptr %10, align 4
  %65 = icmp ne i32 %64, 0
  br label %66

66:                                               ; preds = %63, %44
  %67 = phi i1 [ false, %44 ], [ %65, %63 ]
  br i1 %67, label %68, label %96

68:                                               ; preds = %66
  call void asm sideeffect "# NEXUS_SOURCE_LOOP_ID_2_PARENT_1", "~{memory},~{dirflag},~{fpsr},~{flags}"() #2, !srcloc !7
  %69 = load i32, ptr %10, align 4
  %70 = mul nsw i32 -2, %69
  store i32 %70, ptr %10, align 4
  %71 = load i32, ptr %11, align 4
  store i32 %71, ptr %15, align 4
  %72 = load i32, ptr %12, align 4
  store i32 %72, ptr %16, align 4
  %73 = load i32, ptr %15, align 4
  %74 = load i32, ptr %15, align 4
  %75 = load i32, ptr %15, align 4
  %76 = mul nsw i32 %74, %75
  %77 = add nsw i32 %73, %76
  %78 = load i32, ptr %9, align 4
  %79 = load i32, ptr %9, align 4
  %80 = mul nsw i32 %78, %79
  %81 = add nsw i32 %77, %80
  store i32 %81, ptr %11, align 4
  %82 = load i32, ptr %15, align 4
  %83 = mul nsw i32 -4, %82
  %84 = load i32, ptr %15, align 4
  %85 = mul nsw i32 2, %84
  %86 = load i32, ptr %15, align 4
  %87 = mul nsw i32 %85, %86
  %88 = add nsw i32 %83, %87
  %89 = load i32, ptr %16, align 4
  %90 = mul nsw i32 3, %89
  %91 = add nsw i32 %88, %90
  %92 = load i32, ptr %9, align 4
  %93 = load i32, ptr %9, align 4
  %94 = mul nsw i32 %92, %93
  %95 = add nsw i32 %91, %94
  store i32 %95, ptr %12, align 4
  br label %44, !llvm.loop !8

96:                                               ; preds = %66
  br label %99

97:                                               ; preds = %39
  br label %98

98:                                               ; preds = %97, %29
  br label %20

99:                                               ; preds = %96
  ret void
}

declare i32 @__VERIFIER_nondet_int() #1

attributes #0 = { noinline nounwind uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { nounwind }

!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.ident = !{!5}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 2}
!4 = !{i32 7, !"frame-pointer", i32 2}
!5 = !{!"Ubuntu clang version 18.1.3 (1ubuntu1)"}
!6 = !{i64 227}
!7 = !{i64 557}
!8 = distinct !{!8, !9}
!9 = !{!"llvm.loop.mustprogress"}
