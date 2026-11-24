; ModuleID = '/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/C_Integer/Stroeder_15/AliasDarteFeautrierGonnord-SAS2010-speedFails4_true-termination/generated/AliasDarteFeautrierGonnord-SAS2010-speedFails4_true-termination.inline.bc'
source_filename = "/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/C_Integer/Stroeder_15/AliasDarteFeautrierGonnord-SAS2010-speedFails4_true-termination/generated/AliasDarteFeautrierGonnord-SAS2010-speedFails4_true-termination.inline.c"
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
  store i32 0, ptr %1, align 4
  %7 = call i32 @__VERIFIER_nondet_int()
  store i32 %7, ptr %2, align 4
  %8 = call i32 @__VERIFIER_nondet_int()
  store i32 %8, ptr %3, align 4
  %9 = call i32 @__VERIFIER_nondet_int()
  store i32 %9, ptr %4, align 4
  %10 = call i32 @__VERIFIER_nondet_int()
  store i32 %10, ptr %5, align 4
  %11 = load i32, ptr %5, align 4
  %12 = icmp sge i32 %11, 1
  br i1 %12, label %13, label %14

13:                                               ; preds = %0
  store i32 1, ptr %6, align 4
  br label %15

14:                                               ; preds = %0
  store i32 -1, ptr %6, align 4
  br label %15

15:                                               ; preds = %14, %13
  br label %16

16:                                               ; preds = %31, %15
  %17 = load i32, ptr %3, align 4
  %18 = load i32, ptr %4, align 4
  %19 = icmp sle i32 %17, %18
  br i1 %19, label %20, label %32

20:                                               ; preds = %16
  call void asm sideeffect "# NEXUS_SOURCE_LOOP_ID_1_PARENT_0", "~{memory},~{dirflag},~{fpsr},~{flags}"() #2, !srcloc !6
  %21 = load i32, ptr %5, align 4
  %22 = icmp sge i32 %21, 1
  br i1 %22, label %23, label %27

23:                                               ; preds = %20
  %24 = load i32, ptr %3, align 4
  %25 = load i32, ptr %6, align 4
  %26 = add nsw i32 %24, %25
  store i32 %26, ptr %3, align 4
  br label %31

27:                                               ; preds = %20
  %28 = load i32, ptr %3, align 4
  %29 = load i32, ptr %6, align 4
  %30 = sub nsw i32 %28, %29
  store i32 %30, ptr %3, align 4
  br label %31

31:                                               ; preds = %27, %23
  br label %16, !llvm.loop !7

32:                                               ; preds = %16
  call void asm sideeffect "# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE", "~{memory},~{dirflag},~{fpsr},~{flags}"() #2, !srcloc !9
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
!6 = !{i64 581}
!7 = distinct !{!7, !8}
!8 = !{!"llvm.loop.mustprogress"}
!9 = !{i64 719}
