; ModuleID = '/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/Complexity_C_Integer/Lommen_24/non_linear08/generated/non_linear08.inline.bc'
source_filename = "/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/Complexity_C_Integer/Lommen_24/non_linear08/generated/non_linear08.inline.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @non_linear08(i32 noundef %0, i32 noundef %1, i32 noundef %2, i32 noundef %3, i32 noundef %4) #0 {
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  %13 = alloca i32, align 4
  %14 = alloca i32, align 4
  store i32 %0, ptr %6, align 4
  store i32 %1, ptr %7, align 4
  store i32 %2, ptr %8, align 4
  store i32 %3, ptr %9, align 4
  store i32 %4, ptr %10, align 4
  br label %15

15:                                               ; preds = %33, %5
  %16 = load i32, ptr %10, align 4
  %17 = load i32, ptr %6, align 4
  %18 = load i32, ptr %7, align 4
  %19 = mul nsw i32 2, %18
  %20 = add nsw i32 %17, %19
  %21 = icmp slt i32 %16, %20
  br i1 %21, label %28, label %22

22:                                               ; preds = %15
  %23 = load i32, ptr %10, align 4
  %24 = load i32, ptr %8, align 4
  %25 = load i32, ptr %9, align 4
  %26 = sub nsw i32 %24, %25
  %27 = icmp slt i32 %23, %26
  br i1 %27, label %28, label %31

28:                                               ; preds = %22, %15
  %29 = load i32, ptr %10, align 4
  %30 = icmp sgt i32 %29, 0
  br label %31

31:                                               ; preds = %28, %22
  %32 = phi i1 [ false, %22 ], [ %30, %28 ]
  br i1 %32, label %33, label %69

33:                                               ; preds = %31
  call void asm sideeffect "# NEXUS_SOURCE_LOOP_ID_1_PARENT_0", "~{memory},~{dirflag},~{fpsr},~{flags}"() #1, !srcloc !6
  %34 = load i32, ptr %6, align 4
  store i32 %34, ptr %11, align 4
  %35 = load i32, ptr %7, align 4
  store i32 %35, ptr %12, align 4
  %36 = load i32, ptr %8, align 4
  store i32 %36, ptr %13, align 4
  %37 = load i32, ptr %9, align 4
  store i32 %37, ptr %14, align 4
  %38 = load i32, ptr %11, align 4
  %39 = mul nsw i32 2, %38
  %40 = load i32, ptr %11, align 4
  %41 = mul nsw i32 %39, %40
  %42 = load i32, ptr %11, align 4
  %43 = mul nsw i32 2, %42
  %44 = add nsw i32 %41, %43
  store i32 %44, ptr %6, align 4
  %45 = load i32, ptr %12, align 4
  %46 = mul nsw i32 2, %45
  %47 = load i32, ptr %11, align 4
  %48 = load i32, ptr %11, align 4
  %49 = mul nsw i32 %47, %48
  %50 = sub nsw i32 %46, %49
  store i32 %50, ptr %7, align 4
  %51 = load i32, ptr %13, align 4
  %52 = load i32, ptr %13, align 4
  %53 = mul nsw i32 %51, %52
  %54 = load i32, ptr %13, align 4
  %55 = add nsw i32 %53, %54
  %56 = load i32, ptr %14, align 4
  %57 = mul nsw i32 3, %56
  %58 = sub nsw i32 %55, %57
  store i32 %58, ptr %8, align 4
  %59 = load i32, ptr %13, align 4
  %60 = load i32, ptr %13, align 4
  %61 = mul nsw i32 %59, %60
  %62 = load i32, ptr %13, align 4
  %63 = add nsw i32 %61, %62
  %64 = load i32, ptr %13, align 4
  %65 = mul nsw i32 3, %64
  %66 = sub nsw i32 %63, %65
  store i32 %66, ptr %9, align 4
  %67 = load i32, ptr %10, align 4
  %68 = mul nsw i32 4, %67
  store i32 %68, ptr %10, align 4
  br label %15, !llvm.loop !7

69:                                               ; preds = %31
  call void asm sideeffect "# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE", "~{memory},~{dirflag},~{fpsr},~{flags}"() #1, !srcloc !9
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
!6 = !{i64 136}
!7 = distinct !{!7, !8}
!8 = !{!"llvm.loop.mustprogress"}
!9 = !{i64 418}
