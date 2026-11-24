; ModuleID = '/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/Complexity_C_Integer/Lommen_24/non_linear09/generated/non_linear09.inline.bc'
source_filename = "/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/Complexity_C_Integer/Lommen_24/non_linear09/generated/non_linear09.inline.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @non_linear09(i32 noundef %0, i32 noundef %1, i32 noundef %2, i32 noundef %3, i32 noundef %4, i32 noundef %5) #0 {
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
  store i32 1, ptr %13, align 4
  br label %17

17:                                               ; preds = %76, %6
  %18 = load i32, ptr %13, align 4
  %19 = icmp slt i32 0, %18
  br i1 %19, label %20, label %24

20:                                               ; preds = %17
  %21 = load i32, ptr %13, align 4
  %22 = load i32, ptr %12, align 4
  %23 = icmp sle i32 %21, %22
  br label %24

24:                                               ; preds = %20, %17
  %25 = phi i1 [ false, %17 ], [ %23, %20 ]
  br i1 %25, label %26, label %77

26:                                               ; preds = %24
  call void asm sideeffect "# NEXUS_SOURCE_LOOP_ID_1_PARENT_0", "~{memory},~{dirflag},~{fpsr},~{flags}"() #2, !srcloc !6
  %27 = load i32, ptr %12, align 4
  store i32 %27, ptr %7, align 4
  %28 = load i32, ptr %12, align 4
  store i32 %28, ptr %8, align 4
  store i32 2, ptr %9, align 4
  %29 = load i32, ptr %9, align 4
  store i32 %29, ptr %10, align 4
  %30 = load i32, ptr %12, align 4
  store i32 %30, ptr %11, align 4
  %31 = load i32, ptr %12, align 4
  %32 = sub nsw i32 %31, 1
  store i32 %32, ptr %12, align 4
  %33 = call i32 @__VERIFIER_nondet_int()
  store i32 %33, ptr %14, align 4
  br label %34

34:                                               ; preds = %55, %26
  %35 = load i32, ptr %10, align 4
  %36 = load i32, ptr %10, align 4
  %37 = mul nsw i32 %35, %36
  %38 = load i32, ptr %9, align 4
  %39 = load i32, ptr %9, align 4
  %40 = mul nsw i32 %38, %39
  %41 = load i32, ptr %9, align 4
  %42 = mul nsw i32 %40, %41
  %43 = load i32, ptr %9, align 4
  %44 = mul nsw i32 %42, %43
  %45 = load i32, ptr %9, align 4
  %46 = mul nsw i32 %44, %45
  %47 = sub nsw i32 %37, %46
  %48 = load i32, ptr %11, align 4
  %49 = icmp slt i32 %47, %48
  br i1 %49, label %50, label %53

50:                                               ; preds = %34
  %51 = load i32, ptr %10, align 4
  %52 = icmp ne i32 %51, 0
  br label %53

53:                                               ; preds = %50, %34
  %54 = phi i1 [ false, %34 ], [ %52, %50 ]
  br i1 %54, label %55, label %76

55:                                               ; preds = %53
  call void asm sideeffect "# NEXUS_SOURCE_LOOP_ID_2_PARENT_1", "~{memory},~{dirflag},~{fpsr},~{flags}"() #2, !srcloc !7
  %56 = load i32, ptr %7, align 4
  store i32 %56, ptr %15, align 4
  %57 = load i32, ptr %8, align 4
  store i32 %57, ptr %16, align 4
  %58 = load i32, ptr %15, align 4
  %59 = mul nsw i32 3, %58
  %60 = load i32, ptr %16, align 4
  %61 = mul nsw i32 2, %60
  %62 = add nsw i32 %59, %61
  store i32 %62, ptr %7, align 4
  %63 = load i32, ptr %15, align 4
  %64 = mul nsw i32 -5, %63
  %65 = load i32, ptr %16, align 4
  %66 = mul nsw i32 3, %65
  %67 = sub nsw i32 %64, %66
  store i32 %67, ptr %8, align 4
  %68 = load i32, ptr %10, align 4
  %69 = mul nsw i32 -2, %68
  store i32 %69, ptr %10, align 4
  %70 = load i32, ptr %11, align 4
  %71 = mul nsw i32 3, %70
  %72 = load i32, ptr %9, align 4
  %73 = load i32, ptr %9, align 4
  %74 = mul nsw i32 %72, %73
  %75 = add nsw i32 %71, %74
  store i32 %75, ptr %11, align 4
  br label %34, !llvm.loop !8

76:                                               ; preds = %53
  br label %17, !llvm.loop !10

77:                                               ; preds = %24
  %78 = load i32, ptr %7, align 4
  store i32 %78, ptr %12, align 4
  br label %79

79:                                               ; preds = %82, %77
  %80 = load i32, ptr %12, align 4
  %81 = icmp sgt i32 %80, 0
  br i1 %81, label %82, label %85

82:                                               ; preds = %79
  call void asm sideeffect "# NEXUS_SOURCE_LOOP_ID_3_PARENT_0", "~{memory},~{dirflag},~{fpsr},~{flags}"() #2, !srcloc !11
  %83 = load i32, ptr %12, align 4
  %84 = sub nsw i32 %83, 1
  store i32 %84, ptr %12, align 4
  br label %79, !llvm.loop !12

85:                                               ; preds = %79
  call void asm sideeffect "# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE", "~{memory},~{dirflag},~{fpsr},~{flags}"() #2, !srcloc !13
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
!6 = !{i64 173}
!7 = !{i64 416}
!8 = distinct !{!8, !9}
!9 = !{!"llvm.loop.mustprogress"}
!10 = distinct !{!10, !9}
!11 = !{i64 663}
!12 = distinct !{!12, !9}
!13 = !{i64 761}
