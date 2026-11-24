; ModuleID = '/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/Complexity_C_Integer/Lommen_23/size10/generated/size10.inline.bc'
source_filename = "/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/Complexity_C_Integer/Lommen_23/size10/generated/size10.inline.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @size10(i32 noundef %0, i32 noundef %1, i32 noundef %2, i32 noundef %3, i32 noundef %4) #0 {
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  store i32 %0, ptr %6, align 4
  store i32 %1, ptr %7, align 4
  store i32 %2, ptr %8, align 4
  store i32 %3, ptr %9, align 4
  store i32 %4, ptr %10, align 4
  %13 = load i32, ptr %6, align 4
  %14 = icmp sgt i32 %13, 0
  br i1 %14, label %15, label %67

15:                                               ; preds = %5
  %16 = load i32, ptr %10, align 4
  %17 = icmp sgt i32 %16, 0
  br i1 %17, label %18, label %67

18:                                               ; preds = %15
  br label %19

19:                                               ; preds = %57, %18
  %20 = load i32, ptr %10, align 4
  %21 = icmp sgt i32 %20, 0
  br i1 %21, label %22, label %66

22:                                               ; preds = %19
  call void asm sideeffect "# NEXUS_SOURCE_LOOP_ID_1_PARENT_0", "~{memory},~{dirflag},~{fpsr},~{flags}"() #1, !srcloc !6
  br label %23

23:                                               ; preds = %26, %22
  %24 = load i32, ptr %6, align 4
  %25 = icmp sgt i32 %24, 0
  br i1 %25, label %26, label %46

26:                                               ; preds = %23
  call void asm sideeffect "# NEXUS_SOURCE_LOOP_ID_2_PARENT_1", "~{memory},~{dirflag},~{fpsr},~{flags}"() #1, !srcloc !7
  %27 = load i32, ptr %6, align 4
  %28 = sub nsw i32 %27, 1
  store i32 %28, ptr %6, align 4
  %29 = load i32, ptr %7, align 4
  store i32 %29, ptr %11, align 4
  %30 = load i32, ptr %8, align 4
  store i32 %30, ptr %12, align 4
  %31 = load i32, ptr %11, align 4
  %32 = mul nsw i32 3, %31
  %33 = load i32, ptr %12, align 4
  %34 = mul nsw i32 2, %33
  %35 = add nsw i32 %32, %34
  store i32 %35, ptr %7, align 4
  %36 = load i32, ptr %11, align 4
  %37 = mul nsw i32 -5, %36
  %38 = load i32, ptr %12, align 4
  %39 = mul nsw i32 3, %38
  %40 = sub nsw i32 %37, %39
  store i32 %40, ptr %8, align 4
  %41 = load i32, ptr %6, align 4
  %42 = load i32, ptr %6, align 4
  %43 = mul nsw i32 %41, %42
  %44 = load i32, ptr %9, align 4
  %45 = add nsw i32 %43, %44
  store i32 %45, ptr %9, align 4
  br label %23, !llvm.loop !8

46:                                               ; preds = %23
  br label %47

47:                                               ; preds = %52, %46
  %48 = load i32, ptr %7, align 4
  %49 = load i32, ptr %9, align 4
  %50 = add nsw i32 %48, %49
  %51 = icmp sgt i32 %50, 0
  br i1 %51, label %52, label %57

52:                                               ; preds = %47
  call void asm sideeffect "# NEXUS_SOURCE_LOOP_ID_3_PARENT_1", "~{memory},~{dirflag},~{fpsr},~{flags}"() #1, !srcloc !10
  %53 = load i32, ptr %7, align 4
  %54 = sub nsw i32 %53, 1
  store i32 %54, ptr %7, align 4
  %55 = load i32, ptr %9, align 4
  %56 = sub nsw i32 %55, 1
  store i32 %56, ptr %9, align 4
  br label %47, !llvm.loop !11

57:                                               ; preds = %47
  %58 = load i32, ptr %10, align 4
  store i32 %58, ptr %6, align 4
  %59 = load i32, ptr %10, align 4
  %60 = mul nsw i32 2, %59
  store i32 %60, ptr %7, align 4
  %61 = load i32, ptr %10, align 4
  %62 = mul nsw i32 3, %61
  store i32 %62, ptr %8, align 4
  %63 = load i32, ptr %6, align 4
  store i32 %63, ptr %9, align 4
  %64 = load i32, ptr %10, align 4
  %65 = sub nsw i32 %64, 1
  store i32 %65, ptr %10, align 4
  br label %19, !llvm.loop !12

66:                                               ; preds = %19
  br label %67

67:                                               ; preds = %66, %15, %5
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
!6 = !{i64 113}
!7 = !{i64 207}
!8 = distinct !{!8, !9}
!9 = !{!"llvm.loop.mustprogress"}
!10 = !{i64 443}
!11 = distinct !{!11, !9}
!12 = distinct !{!12, !9}
!13 = !{i64 649}
