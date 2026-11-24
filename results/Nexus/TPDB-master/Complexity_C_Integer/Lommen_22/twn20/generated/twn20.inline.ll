; ModuleID = '/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/Complexity_C_Integer/Lommen_22/twn20/generated/twn20.inline.bc'
source_filename = "/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/Complexity_C_Integer/Lommen_22/twn20/generated/twn20.inline.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @twn20(i32 noundef %0, i32 noundef %1, i32 noundef %2) #0 {
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  store i32 %0, ptr %4, align 4
  store i32 %1, ptr %5, align 4
  store i32 %2, ptr %6, align 4
  %7 = load i32, ptr %6, align 4
  %8 = icmp sgt i32 %7, 0
  br i1 %8, label %9, label %45

9:                                                ; preds = %3
  br label %10

10:                                               ; preds = %31, %9
  %11 = load i32, ptr %4, align 4
  %12 = load i32, ptr %4, align 4
  %13 = mul nsw i32 %11, %12
  %14 = load i32, ptr %6, align 4
  %15 = load i32, ptr %6, align 4
  %16 = mul nsw i32 %14, %15
  %17 = load i32, ptr %6, align 4
  %18 = mul nsw i32 %16, %17
  %19 = load i32, ptr %6, align 4
  %20 = mul nsw i32 %18, %19
  %21 = load i32, ptr %6, align 4
  %22 = mul nsw i32 %20, %21
  %23 = add nsw i32 %13, %22
  %24 = load i32, ptr %5, align 4
  %25 = icmp slt i32 %23, %24
  br i1 %25, label %26, label %29

26:                                               ; preds = %10
  %27 = load i32, ptr %4, align 4
  %28 = icmp ne i32 %27, 0
  br label %29

29:                                               ; preds = %26, %10
  %30 = phi i1 [ false, %10 ], [ %28, %26 ]
  br i1 %30, label %31, label %44

31:                                               ; preds = %29
  call void asm sideeffect "# NEXUS_SOURCE_LOOP_ID_1_PARENT_0", "~{memory},~{dirflag},~{fpsr},~{flags}"() #1, !srcloc !6
  %32 = load i32, ptr %4, align 4
  %33 = mul nsw i32 4, %32
  store i32 %33, ptr %4, align 4
  %34 = load i32, ptr %5, align 4
  %35 = mul nsw i32 9, %34
  %36 = load i32, ptr %6, align 4
  %37 = mul nsw i32 8, %36
  %38 = load i32, ptr %6, align 4
  %39 = mul nsw i32 %37, %38
  %40 = load i32, ptr %6, align 4
  %41 = mul nsw i32 %39, %40
  %42 = sub nsw i32 %35, %41
  store i32 %42, ptr %5, align 4
  %43 = load i32, ptr %6, align 4
  store i32 %43, ptr %6, align 4
  br label %10, !llvm.loop !7

44:                                               ; preds = %29
  br label %45

45:                                               ; preds = %44, %3
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
!6 = !{i64 113}
!7 = distinct !{!7, !8}
!8 = !{!"llvm.loop.mustprogress"}
!9 = !{i64 253}
