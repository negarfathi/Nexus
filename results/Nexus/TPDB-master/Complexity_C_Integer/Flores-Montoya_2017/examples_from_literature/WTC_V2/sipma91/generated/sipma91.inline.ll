; ModuleID = '/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/Complexity_C_Integer/Flores-Montoya_2017/examples_from_literature/WTC_V2/sipma91/generated/sipma91.inline.bc'
source_filename = "/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/Complexity_C_Integer/Flores-Montoya_2017/examples_from_literature/WTC_V2/sipma91/generated/sipma91.inline.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define dso_local void @sipma91(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  store i32 %0, ptr %2, align 4
  %6 = load i32, ptr %2, align 4
  store i32 %6, ptr %3, align 4
  store i32 1, ptr %4, align 4
  %7 = load i32, ptr %3, align 4
  %8 = icmp sgt i32 %7, 100
  br i1 %8, label %9, label %12

9:                                                ; preds = %1
  %10 = load i32, ptr %3, align 4
  %11 = sub nsw i32 %10, 10
  store i32 %11, ptr %5, align 4
  br label %53

12:                                               ; preds = %1
  br label %13

13:                                               ; preds = %16, %12
  %14 = load i32, ptr %3, align 4
  %15 = icmp sle i32 %14, 100
  br i1 %15, label %16, label %21

16:                                               ; preds = %13
  call void asm sideeffect "# NEXUS_SOURCE_LOOP_ID_1_PARENT_0", "~{memory},~{dirflag},~{fpsr},~{flags}"() #1, !srcloc !6
  %17 = load i32, ptr %3, align 4
  %18 = add nsw i32 %17, 11
  store i32 %18, ptr %3, align 4
  %19 = load i32, ptr %4, align 4
  %20 = add nsw i32 %19, 1
  store i32 %20, ptr %4, align 4
  br label %13, !llvm.loop !7

21:                                               ; preds = %13
  br label %22

22:                                               ; preds = %51, %21
  %23 = load i32, ptr %4, align 4
  %24 = icmp sgt i32 %23, 1
  br i1 %24, label %25, label %52

25:                                               ; preds = %22
  call void asm sideeffect "# NEXUS_SOURCE_LOOP_ID_2_PARENT_0", "~{memory},~{dirflag},~{fpsr},~{flags}"() #1, !srcloc !9
  %26 = load i32, ptr %3, align 4
  %27 = sub nsw i32 %26, 10
  store i32 %27, ptr %3, align 4
  %28 = load i32, ptr %4, align 4
  %29 = sub nsw i32 %28, 1
  store i32 %29, ptr %4, align 4
  %30 = load i32, ptr %3, align 4
  %31 = icmp sgt i32 %30, 100
  br i1 %31, label %32, label %38

32:                                               ; preds = %25
  %33 = load i32, ptr %4, align 4
  %34 = icmp eq i32 %33, 1
  br i1 %34, label %35, label %38

35:                                               ; preds = %32
  %36 = load i32, ptr %3, align 4
  %37 = sub nsw i32 %36, 10
  store i32 %37, ptr %5, align 4
  br label %51

38:                                               ; preds = %32, %25
  %39 = load i32, ptr %3, align 4
  %40 = icmp sgt i32 %39, 100
  br i1 %40, label %41, label %46

41:                                               ; preds = %38
  %42 = load i32, ptr %3, align 4
  %43 = sub nsw i32 %42, 10
  store i32 %43, ptr %3, align 4
  %44 = load i32, ptr %4, align 4
  %45 = sub nsw i32 %44, 1
  store i32 %45, ptr %4, align 4
  br label %46

46:                                               ; preds = %41, %38
  %47 = load i32, ptr %3, align 4
  %48 = add nsw i32 %47, 11
  store i32 %48, ptr %3, align 4
  %49 = load i32, ptr %4, align 4
  %50 = add nsw i32 %49, 1
  store i32 %50, ptr %4, align 4
  br label %51

51:                                               ; preds = %46, %35
  br label %22, !llvm.loop !10

52:                                               ; preds = %22
  br label %53

53:                                               ; preds = %52, %9
  ret void
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
!6 = !{i64 144}
!7 = distinct !{!7, !8}
!8 = !{!"llvm.loop.mustprogress"}
!9 = !{i64 282}
!10 = distinct !{!10, !8}
