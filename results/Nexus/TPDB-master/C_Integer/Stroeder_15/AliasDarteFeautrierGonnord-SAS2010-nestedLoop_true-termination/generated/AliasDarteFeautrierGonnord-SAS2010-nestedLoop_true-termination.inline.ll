; ModuleID = '/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/C_Integer/Stroeder_15/AliasDarteFeautrierGonnord-SAS2010-nestedLoop_true-termination/generated/AliasDarteFeautrierGonnord-SAS2010-nestedLoop_true-termination.inline.bc'
source_filename = "/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/C_Integer/Stroeder_15/AliasDarteFeautrierGonnord-SAS2010-nestedLoop_true-termination/generated/AliasDarteFeautrierGonnord-SAS2010-nestedLoop_true-termination.inline.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  store i32 0, ptr %1, align 4
  %8 = call i32 @__VERIFIER_nondet_int()
  store i32 %8, ptr %2, align 4
  %9 = call i32 @__VERIFIER_nondet_int()
  store i32 %9, ptr %3, align 4
  %10 = call i32 @__VERIFIER_nondet_int()
  store i32 %10, ptr %4, align 4
  %11 = call i32 @__VERIFIER_nondet_int()
  store i32 %11, ptr %6, align 4
  %12 = call i32 @__VERIFIER_nondet_int()
  store i32 %12, ptr %5, align 4
  %13 = call i32 @__VERIFIER_nondet_int()
  store i32 %13, ptr %7, align 4
  %14 = load i32, ptr %6, align 4
  %15 = icmp sle i32 0, %14
  br i1 %15, label %16, label %49

16:                                               ; preds = %0
  %17 = load i32, ptr %5, align 4
  %18 = icmp sle i32 0, %17
  br i1 %18, label %19, label %49

19:                                               ; preds = %16
  %20 = load i32, ptr %7, align 4
  %21 = icmp sle i32 0, %20
  br i1 %21, label %22, label %49

22:                                               ; preds = %19
  store i32 0, ptr %2, align 4
  br label %23

23:                                               ; preds = %45, %22
  %24 = load i32, ptr %2, align 4
  %25 = load i32, ptr %6, align 4
  %26 = icmp slt i32 %24, %25
  br i1 %26, label %27, label %48

27:                                               ; preds = %23
  call void asm sideeffect "# NEXUS_SOURCE_LOOP_ID_1_PARENT_0", "~{memory},~{dirflag},~{fpsr},~{flags}"() #2, !srcloc !6
  store i32 0, ptr %3, align 4
  br label %28

28:                                               ; preds = %43, %27
  %29 = load i32, ptr %3, align 4
  %30 = load i32, ptr %5, align 4
  %31 = icmp slt i32 %29, %30
  br i1 %31, label %32, label %45

32:                                               ; preds = %28
  call void asm sideeffect "# NEXUS_SOURCE_LOOP_ID_2_PARENT_1", "~{memory},~{dirflag},~{fpsr},~{flags}"() #2, !srcloc !7
  %33 = load i32, ptr %3, align 4
  %34 = add nsw i32 %33, 1
  store i32 %34, ptr %3, align 4
  %35 = load i32, ptr %2, align 4
  store i32 %35, ptr %4, align 4
  br label %36

36:                                               ; preds = %40, %32
  %37 = load i32, ptr %4, align 4
  %38 = load i32, ptr %7, align 4
  %39 = icmp slt i32 %37, %38
  br i1 %39, label %40, label %43

40:                                               ; preds = %36
  call void asm sideeffect "# NEXUS_SOURCE_LOOP_ID_3_PARENT_2", "~{memory},~{dirflag},~{fpsr},~{flags}"() #2, !srcloc !8
  %41 = load i32, ptr %4, align 4
  %42 = add nsw i32 %41, 1
  store i32 %42, ptr %4, align 4
  br label %36, !llvm.loop !9

43:                                               ; preds = %36
  %44 = load i32, ptr %4, align 4
  store i32 %44, ptr %2, align 4
  br label %28, !llvm.loop !11

45:                                               ; preds = %28
  %46 = load i32, ptr %2, align 4
  %47 = add nsw i32 %46, 1
  store i32 %47, ptr %2, align 4
  br label %23, !llvm.loop !12

48:                                               ; preds = %23
  br label %49

49:                                               ; preds = %48, %19, %16, %0
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
!6 = !{i64 638}
!7 = !{i64 740}
!8 = !{i64 859}
!9 = distinct !{!9, !10}
!10 = !{!"llvm.loop.mustprogress"}
!11 = distinct !{!11, !10}
!12 = distinct !{!12, !10}
!13 = !{i64 1006}
