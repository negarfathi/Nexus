; ModuleID = '/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/C_Integer/Stroeder_15/AliasDarteFeautrierGonnord-SAS2010-complex_true-termination/generated/AliasDarteFeautrierGonnord-SAS2010-complex_true-termination.inline.bc'
source_filename = "/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/C_Integer/Stroeder_15/AliasDarteFeautrierGonnord-SAS2010-complex_true-termination/generated/AliasDarteFeautrierGonnord-SAS2010-complex_true-termination.inline.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  store i32 0, ptr %1, align 4
  %4 = call i32 @__VERIFIER_nondet_int()
  store i32 %4, ptr %2, align 4
  %5 = call i32 @__VERIFIER_nondet_int()
  store i32 %5, ptr %3, align 4
  br label %6

6:                                                ; preds = %36, %0
  %7 = load i32, ptr %2, align 4
  %8 = icmp slt i32 %7, 30
  br i1 %8, label %9, label %41

9:                                                ; preds = %6
  call void asm sideeffect "# NEXUS_SOURCE_LOOP_ID_1_PARENT_0", "~{memory},~{dirflag},~{fpsr},~{flags}"() #2, !srcloc !6
  br label %10

10:                                               ; preds = %35, %9
  %11 = load i32, ptr %3, align 4
  %12 = load i32, ptr %2, align 4
  %13 = icmp slt i32 %11, %12
  br i1 %13, label %14, label %36

14:                                               ; preds = %10
  call void asm sideeffect "# NEXUS_SOURCE_LOOP_ID_2_PARENT_1", "~{memory},~{dirflag},~{fpsr},~{flags}"() #2, !srcloc !7
  %15 = load i32, ptr %3, align 4
  %16 = icmp sgt i32 %15, 5
  br i1 %16, label %17, label %20

17:                                               ; preds = %14
  %18 = load i32, ptr %3, align 4
  %19 = add nsw i32 %18, 7
  store i32 %19, ptr %3, align 4
  br label %23

20:                                               ; preds = %14
  %21 = load i32, ptr %3, align 4
  %22 = add nsw i32 %21, 2
  store i32 %22, ptr %3, align 4
  br label %23

23:                                               ; preds = %20, %17
  %24 = load i32, ptr %3, align 4
  %25 = icmp sge i32 %24, 10
  br i1 %25, label %26, label %32

26:                                               ; preds = %23
  %27 = load i32, ptr %3, align 4
  %28 = icmp sle i32 %27, 12
  br i1 %28, label %29, label %32

29:                                               ; preds = %26
  %30 = load i32, ptr %2, align 4
  %31 = add nsw i32 %30, 10
  store i32 %31, ptr %2, align 4
  br label %35

32:                                               ; preds = %26, %23
  %33 = load i32, ptr %2, align 4
  %34 = add nsw i32 %33, 1
  store i32 %34, ptr %2, align 4
  br label %35

35:                                               ; preds = %32, %29
  br label %10, !llvm.loop !8

36:                                               ; preds = %10
  %37 = load i32, ptr %2, align 4
  %38 = add nsw i32 %37, 2
  store i32 %38, ptr %2, align 4
  %39 = load i32, ptr %3, align 4
  %40 = sub nsw i32 %39, 10
  store i32 %40, ptr %3, align 4
  br label %6, !llvm.loop !10

41:                                               ; preds = %6
  call void asm sideeffect "# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE", "~{memory},~{dirflag},~{fpsr},~{flags}"() #2, !srcloc !11
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
!6 = !{i64 461}
!7 = !{i64 552}
!8 = distinct !{!8, !9}
!9 = !{!"llvm.loop.mustprogress"}
!10 = distinct !{!10, !9}
!11 = !{i64 820}
