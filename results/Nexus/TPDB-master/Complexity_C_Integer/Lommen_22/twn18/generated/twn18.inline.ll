; ModuleID = '/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/Complexity_C_Integer/Lommen_22/twn18/generated/twn18.inline.bc'
source_filename = "/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/Complexity_C_Integer/Lommen_22/twn18/generated/twn18.inline.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @twn18(i32 noundef %0, i32 noundef %1, i32 noundef %2, i32 noundef %3, i32 noundef %4) #0 {
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
  br label %13

13:                                               ; preds = %28, %5
  %14 = load i32, ptr %7, align 4
  %15 = load i32, ptr %7, align 4
  %16 = mul nsw i32 %14, %15
  %17 = icmp sgt i32 %16, 1
  br i1 %17, label %18, label %26

18:                                               ; preds = %13
  %19 = load i32, ptr %6, align 4
  %20 = load i32, ptr %8, align 4
  %21 = mul nsw i32 %19, %20
  %22 = load i32, ptr %6, align 4
  %23 = mul nsw i32 2, %22
  %24 = add nsw i32 %21, %23
  %25 = icmp sgt i32 %24, 0
  br label %26

26:                                               ; preds = %18, %13
  %27 = phi i1 [ false, %13 ], [ %25, %18 ]
  br i1 %27, label %28, label %50

28:                                               ; preds = %26
  call void asm sideeffect "# NEXUS_SOURCE_LOOP_ID_1_PARENT_0", "~{memory},~{dirflag},~{fpsr},~{flags}"() #1, !srcloc !6
  %29 = load i32, ptr %6, align 4
  store i32 %29, ptr %6, align 4
  %30 = load i32, ptr %7, align 4
  store i32 %30, ptr %11, align 4
  %31 = load i32, ptr %8, align 4
  store i32 %31, ptr %12, align 4
  %32 = load i32, ptr %11, align 4
  %33 = mul nsw i32 3, %32
  %34 = load i32, ptr %12, align 4
  %35 = mul nsw i32 4, %34
  %36 = sub nsw i32 %33, %35
  store i32 %36, ptr %7, align 4
  %37 = load i32, ptr %11, align 4
  %38 = mul nsw i32 4, %37
  %39 = load i32, ptr %12, align 4
  %40 = mul nsw i32 3, %39
  %41 = sub nsw i32 %38, %40
  store i32 %41, ptr %8, align 4
  %42 = load i32, ptr %9, align 4
  %43 = mul nsw i32 5, %42
  store i32 %43, ptr %9, align 4
  %44 = load i32, ptr %10, align 4
  %45 = mul nsw i32 5, %44
  %46 = load i32, ptr %6, align 4
  %47 = load i32, ptr %6, align 4
  %48 = mul nsw i32 %46, %47
  %49 = sub nsw i32 %45, %48
  store i32 %49, ptr %10, align 4
  br label %13, !llvm.loop !7

50:                                               ; preds = %26
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
!6 = !{i64 106}
!7 = distinct !{!7, !8}
!8 = !{!"llvm.loop.mustprogress"}
!9 = !{i64 319}
