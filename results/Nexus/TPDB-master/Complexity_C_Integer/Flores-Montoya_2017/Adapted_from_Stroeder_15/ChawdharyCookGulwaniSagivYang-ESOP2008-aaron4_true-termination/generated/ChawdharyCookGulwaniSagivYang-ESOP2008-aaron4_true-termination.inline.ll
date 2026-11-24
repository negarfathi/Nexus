; ModuleID = '/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/Complexity_C_Integer/Flores-Montoya_2017/Adapted_from_Stroeder_15/ChawdharyCookGulwaniSagivYang-ESOP2008-aaron4_true-termination/generated/ChawdharyCookGulwaniSagivYang-ESOP2008-aaron4_true-termination.inline.bc'
source_filename = "/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/Complexity_C_Integer/Flores-Montoya_2017/Adapted_from_Stroeder_15/ChawdharyCookGulwaniSagivYang-ESOP2008-aaron4_true-termination/generated/ChawdharyCookGulwaniSagivYang-ESOP2008-aaron4_true-termination.inline.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @foo(i32 noundef %0, i32 noundef %1, i32 noundef %2, i32 noundef %3, i32 noundef %4, i32 noundef %5) #0 {
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  store i32 %0, ptr %7, align 4
  store i32 %1, ptr %8, align 4
  store i32 %2, ptr %9, align 4
  store i32 %3, ptr %10, align 4
  store i32 %4, ptr %11, align 4
  store i32 %5, ptr %12, align 4
  br label %13

13:                                               ; preds = %92, %6
  %14 = load i32, ptr %10, align 4
  %15 = load i32, ptr %7, align 4
  %16 = icmp sge i32 %14, %15
  br i1 %16, label %17, label %21

17:                                               ; preds = %13
  %18 = load i32, ptr %11, align 4
  %19 = load i32, ptr %8, align 4
  %20 = icmp sge i32 %18, %19
  br i1 %20, label %37, label %21

21:                                               ; preds = %17, %13
  %22 = load i32, ptr %10, align 4
  %23 = load i32, ptr %7, align 4
  %24 = icmp sge i32 %22, %23
  br i1 %24, label %25, label %29

25:                                               ; preds = %21
  %26 = load i32, ptr %11, align 4
  %27 = load i32, ptr %8, align 4
  %28 = icmp sle i32 %26, %27
  br i1 %28, label %37, label %29

29:                                               ; preds = %25, %21
  %30 = load i32, ptr %10, align 4
  %31 = load i32, ptr %7, align 4
  %32 = icmp sle i32 %30, %31
  br i1 %32, label %33, label %42

33:                                               ; preds = %29
  %34 = load i32, ptr %11, align 4
  %35 = load i32, ptr %8, align 4
  %36 = icmp sge i32 %34, %35
  br i1 %36, label %37, label %42

37:                                               ; preds = %33, %25, %17
  %38 = load i32, ptr %9, align 4
  %39 = load i32, ptr %12, align 4
  %40 = add nsw i32 %39, 1
  %41 = icmp sge i32 %38, %40
  br label %42

42:                                               ; preds = %37, %33, %29
  %43 = phi i1 [ false, %33 ], [ false, %29 ], [ %41, %37 ]
  br i1 %43, label %44, label %93

44:                                               ; preds = %42
  call void asm sideeffect "# NEXUS_SOURCE_LOOP_ID_1_PARENT_0", "~{memory},~{dirflag},~{fpsr},~{flags}"() #2, !srcloc !6
  %45 = load i32, ptr %10, align 4
  %46 = load i32, ptr %7, align 4
  %47 = icmp sge i32 %45, %46
  br i1 %47, label %48, label %65

48:                                               ; preds = %44
  %49 = load i32, ptr %11, align 4
  %50 = load i32, ptr %8, align 4
  %51 = icmp sge i32 %49, %50
  br i1 %51, label %52, label %65

52:                                               ; preds = %48
  %53 = call i32 @__VERIFIER_nondet_int()
  %54 = icmp ne i32 %53, 0
  br i1 %54, label %55, label %61

55:                                               ; preds = %52
  %56 = load i32, ptr %8, align 4
  %57 = load i32, ptr %9, align 4
  %58 = add nsw i32 %56, %57
  store i32 %58, ptr %8, align 4
  %59 = load i32, ptr %9, align 4
  store i32 %59, ptr %12, align 4
  %60 = call i32 @__VERIFIER_nondet_int()
  store i32 %60, ptr %9, align 4
  br label %64

61:                                               ; preds = %52
  %62 = load i32, ptr %7, align 4
  %63 = add nsw i32 %62, 1
  store i32 %63, ptr %7, align 4
  br label %64

64:                                               ; preds = %61, %55
  br label %92

65:                                               ; preds = %48, %44
  %66 = load i32, ptr %10, align 4
  %67 = load i32, ptr %7, align 4
  %68 = icmp sge i32 %66, %67
  br i1 %68, label %69, label %76

69:                                               ; preds = %65
  %70 = load i32, ptr %11, align 4
  %71 = load i32, ptr %8, align 4
  %72 = icmp sle i32 %70, %71
  br i1 %72, label %73, label %76

73:                                               ; preds = %69
  %74 = load i32, ptr %7, align 4
  %75 = add nsw i32 %74, 1
  store i32 %75, ptr %7, align 4
  br label %91

76:                                               ; preds = %69, %65
  %77 = load i32, ptr %10, align 4
  %78 = load i32, ptr %7, align 4
  %79 = icmp sle i32 %77, %78
  br i1 %79, label %80, label %90

80:                                               ; preds = %76
  %81 = load i32, ptr %11, align 4
  %82 = load i32, ptr %8, align 4
  %83 = icmp sge i32 %81, %82
  br i1 %83, label %84, label %90

84:                                               ; preds = %80
  %85 = load i32, ptr %8, align 4
  %86 = load i32, ptr %9, align 4
  %87 = add nsw i32 %85, %86
  store i32 %87, ptr %8, align 4
  %88 = load i32, ptr %9, align 4
  store i32 %88, ptr %12, align 4
  %89 = call i32 @__VERIFIER_nondet_int()
  store i32 %89, ptr %9, align 4
  br label %90

90:                                               ; preds = %84, %80, %76
  br label %91

91:                                               ; preds = %90, %73
  br label %92

92:                                               ; preds = %91, %64
  br label %13, !llvm.loop !7

93:                                               ; preds = %42
  call void asm sideeffect "# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE", "~{memory},~{dirflag},~{fpsr},~{flags}"() #2, !srcloc !9
  ret i32 0
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
!6 = !{i64 209}
!7 = distinct !{!7, !8}
!8 = !{!"llvm.loop.mustprogress"}
!9 = !{i64 595}
