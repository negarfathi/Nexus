; ModuleID = '/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/Complexity_C_Integer/Lommen_24/non_linear07/generated/non_linear07.inline.bc'
source_filename = "/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/Complexity_C_Integer/Lommen_24/non_linear07/generated/non_linear07.inline.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @non_linear07(i32 noundef %0, i32 noundef %1, i32 noundef %2, i32 noundef %3) #0 {
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  store i32 %0, ptr %5, align 4
  store i32 %1, ptr %6, align 4
  store i32 %2, ptr %7, align 4
  store i32 %3, ptr %8, align 4
  br label %11

11:                                               ; preds = %27, %4
  %12 = load i32, ptr %8, align 4
  %13 = load i32, ptr %5, align 4
  %14 = load i32, ptr %6, align 4
  %15 = mul nsw i32 2, %14
  %16 = add nsw i32 %13, %15
  %17 = icmp slt i32 %12, %16
  br i1 %17, label %22, label %18

18:                                               ; preds = %11
  %19 = load i32, ptr %8, align 4
  %20 = load i32, ptr %7, align 4
  %21 = icmp slt i32 %19, %20
  br i1 %21, label %22, label %25

22:                                               ; preds = %18, %11
  %23 = load i32, ptr %8, align 4
  %24 = icmp sgt i32 %23, 0
  br label %25

25:                                               ; preds = %22, %18
  %26 = phi i1 [ false, %18 ], [ %24, %22 ]
  br i1 %26, label %27, label %47

27:                                               ; preds = %25
  call void asm sideeffect "# NEXUS_SOURCE_LOOP_ID_1_PARENT_0", "~{memory},~{dirflag},~{fpsr},~{flags}"() #1, !srcloc !6
  %28 = load i32, ptr %5, align 4
  store i32 %28, ptr %9, align 4
  %29 = load i32, ptr %6, align 4
  store i32 %29, ptr %10, align 4
  %30 = load i32, ptr %9, align 4
  %31 = mul nsw i32 2, %30
  %32 = load i32, ptr %9, align 4
  %33 = mul nsw i32 %31, %32
  %34 = load i32, ptr %9, align 4
  %35 = mul nsw i32 2, %34
  %36 = add nsw i32 %33, %35
  store i32 %36, ptr %5, align 4
  %37 = load i32, ptr %10, align 4
  %38 = mul nsw i32 2, %37
  %39 = load i32, ptr %9, align 4
  %40 = load i32, ptr %9, align 4
  %41 = mul nsw i32 %39, %40
  %42 = sub nsw i32 %38, %41
  store i32 %42, ptr %6, align 4
  %43 = load i32, ptr %7, align 4
  %44 = mul nsw i32 3, %43
  store i32 %44, ptr %7, align 4
  %45 = load i32, ptr %8, align 4
  %46 = mul nsw i32 4, %45
  store i32 %46, ptr %8, align 4
  br label %11, !llvm.loop !7

47:                                               ; preds = %25
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
!6 = !{i64 123}
!7 = distinct !{!7, !8}
!8 = !{!"llvm.loop.mustprogress"}
!9 = !{i64 324}
