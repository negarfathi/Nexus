; ModuleID = '/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/Complexity_C_Integer/Lommen_22/twn15/generated/twn15.inline.bc'
source_filename = "/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/Complexity_C_Integer/Lommen_22/twn15/generated/twn15.inline.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @twn15(i32 noundef %0, i32 noundef %1, i32 noundef %2, i32 noundef %3, i32 noundef %4) #0 {
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  store i32 %0, ptr %6, align 4
  store i32 %1, ptr %7, align 4
  store i32 %2, ptr %8, align 4
  store i32 %3, ptr %9, align 4
  store i32 %4, ptr %10, align 4
  br label %11

11:                                               ; preds = %94, %5
  %12 = load i32, ptr %6, align 4
  %13 = icmp sgt i32 %12, 0
  br i1 %13, label %14, label %97

14:                                               ; preds = %11
  call void asm sideeffect "# NEXUS_SOURCE_LOOP_ID_1_PARENT_0", "~{memory},~{dirflag},~{fpsr},~{flags}"() #1, !srcloc !6
  %15 = load i32, ptr %6, align 4
  store i32 %15, ptr %7, align 4
  %16 = load i32, ptr %10, align 4
  store i32 %16, ptr %8, align 4
  %17 = load i32, ptr %9, align 4
  %18 = icmp sle i32 -5, %17
  br i1 %18, label %19, label %56

19:                                               ; preds = %14
  %20 = load i32, ptr %9, align 4
  %21 = icmp sle i32 %20, 5
  br i1 %21, label %22, label %56

22:                                               ; preds = %19
  br label %23

23:                                               ; preds = %44, %22
  %24 = load i32, ptr %7, align 4
  %25 = icmp ne i32 %24, 0
  br i1 %25, label %26, label %42

26:                                               ; preds = %23
  %27 = load i32, ptr %7, align 4
  %28 = load i32, ptr %7, align 4
  %29 = mul nsw i32 %27, %28
  %30 = load i32, ptr %9, align 4
  %31 = load i32, ptr %9, align 4
  %32 = mul nsw i32 %30, %31
  %33 = load i32, ptr %9, align 4
  %34 = mul nsw i32 %32, %33
  %35 = load i32, ptr %9, align 4
  %36 = mul nsw i32 %34, %35
  %37 = load i32, ptr %9, align 4
  %38 = mul nsw i32 %36, %37
  %39 = add nsw i32 %29, %38
  %40 = load i32, ptr %8, align 4
  %41 = icmp slt i32 %39, %40
  br label %42

42:                                               ; preds = %26, %23
  %43 = phi i1 [ false, %23 ], [ %41, %26 ]
  br i1 %43, label %44, label %55

44:                                               ; preds = %42
  call void asm sideeffect "# NEXUS_SOURCE_LOOP_ID_2_PARENT_1", "~{memory},~{dirflag},~{fpsr},~{flags}"() #1, !srcloc !7
  %45 = load i32, ptr %7, align 4
  %46 = mul nsw i32 -2, %45
  store i32 %46, ptr %7, align 4
  %47 = load i32, ptr %8, align 4
  %48 = mul nsw i32 3, %47
  %49 = load i32, ptr %9, align 4
  %50 = load i32, ptr %9, align 4
  %51 = mul nsw i32 %49, %50
  %52 = load i32, ptr %9, align 4
  %53 = mul nsw i32 %51, %52
  %54 = sub nsw i32 %48, %53
  store i32 %54, ptr %8, align 4
  br label %23, !llvm.loop !8

55:                                               ; preds = %42
  br label %94

56:                                               ; preds = %19, %14
  %57 = load i32, ptr %9, align 4
  %58 = icmp sgt i32 %57, 0
  br i1 %58, label %59, label %93

59:                                               ; preds = %56
  br label %60

60:                                               ; preds = %81, %59
  %61 = load i32, ptr %7, align 4
  %62 = icmp ne i32 %61, 0
  br i1 %62, label %63, label %79

63:                                               ; preds = %60
  %64 = load i32, ptr %7, align 4
  %65 = load i32, ptr %7, align 4
  %66 = mul nsw i32 %64, %65
  %67 = load i32, ptr %9, align 4
  %68 = load i32, ptr %9, align 4
  %69 = mul nsw i32 %67, %68
  %70 = load i32, ptr %9, align 4
  %71 = mul nsw i32 %69, %70
  %72 = load i32, ptr %9, align 4
  %73 = mul nsw i32 %71, %72
  %74 = load i32, ptr %9, align 4
  %75 = mul nsw i32 %73, %74
  %76 = add nsw i32 %66, %75
  %77 = load i32, ptr %8, align 4
  %78 = icmp slt i32 %76, %77
  br label %79

79:                                               ; preds = %63, %60
  %80 = phi i1 [ false, %60 ], [ %78, %63 ]
  br i1 %80, label %81, label %92

81:                                               ; preds = %79
  call void asm sideeffect "# NEXUS_SOURCE_LOOP_ID_3_PARENT_1", "~{memory},~{dirflag},~{fpsr},~{flags}"() #1, !srcloc !10
  %82 = load i32, ptr %7, align 4
  %83 = mul nsw i32 -2, %82
  store i32 %83, ptr %7, align 4
  %84 = load i32, ptr %8, align 4
  %85 = mul nsw i32 3, %84
  %86 = load i32, ptr %9, align 4
  %87 = load i32, ptr %9, align 4
  %88 = mul nsw i32 %86, %87
  %89 = load i32, ptr %9, align 4
  %90 = mul nsw i32 %88, %89
  %91 = sub nsw i32 %85, %90
  store i32 %91, ptr %8, align 4
  br label %60, !llvm.loop !11

92:                                               ; preds = %79
  br label %93

93:                                               ; preds = %92, %56
  br label %94

94:                                               ; preds = %93, %55
  %95 = load i32, ptr %6, align 4
  %96 = sub nsw i32 %95, 1
  store i32 %96, ptr %6, align 4
  br label %11, !llvm.loop !12

97:                                               ; preds = %11
  call void asm sideeffect "# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE", "~{memory},~{dirflag},~{fpsr},~{flags}"() #1, !srcloc !13
  ret i32 0
}

attributes #0 = { noinline nounwind uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nounwind }

!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.ident = !{!5}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 2}
!4 = !{i32 7, !"frame-pointer", i32 2}
!5 = !{!"Ubuntu clang version 18.1.3 (1ubuntu1)"}
!6 = !{i64 87}
!7 = !{i64 256}
!8 = distinct !{!8, !9}
!9 = !{!"llvm.loop.mustprogress"}
!10 = !{i64 454}
!11 = distinct !{!11, !9}
!12 = distinct !{!12, !9}
!13 = !{i64 607}
