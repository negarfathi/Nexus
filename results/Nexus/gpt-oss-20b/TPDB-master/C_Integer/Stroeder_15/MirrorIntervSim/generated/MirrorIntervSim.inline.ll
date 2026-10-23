; ModuleID = '/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/C_Integer/Stroeder_15/MirrorIntervSim/generated/MirrorIntervSim.inline.bc'
source_filename = "/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/C_Integer/Stroeder_15/MirrorIntervSim/generated/MirrorIntervSim.inline.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  store i32 0, ptr %1, align 4
  %3 = call i32 @__VERIFIER_nondet_int()
  store i32 %3, ptr %2, align 4
  br label %4

4:                                                ; preds = %27, %0
  %5 = load i32, ptr %2, align 4
  %6 = icmp ne i32 %5, 0
  br i1 %6, label %7, label %28

7:                                                ; preds = %4
  %8 = load i32, ptr %2, align 4
  %9 = icmp sle i32 -5, %8
  br i1 %9, label %10, label %26

10:                                               ; preds = %7
  %11 = load i32, ptr %2, align 4
  %12 = icmp sle i32 %11, 35
  br i1 %12, label %13, label %26

13:                                               ; preds = %10
  %14 = load i32, ptr %2, align 4
  %15 = icmp slt i32 %14, 0
  br i1 %15, label %16, label %17

16:                                               ; preds = %13
  store i32 -5, ptr %2, align 4
  br label %25

17:                                               ; preds = %13
  %18 = load i32, ptr %2, align 4
  %19 = icmp sgt i32 %18, 30
  br i1 %19, label %20, label %21

20:                                               ; preds = %17
  store i32 35, ptr %2, align 4
  br label %24

21:                                               ; preds = %17
  %22 = load i32, ptr %2, align 4
  %23 = sub nsw i32 %22, 1
  store i32 %23, ptr %2, align 4
  br label %24

24:                                               ; preds = %21, %20
  br label %25

25:                                               ; preds = %24, %16
  br label %27

26:                                               ; preds = %10, %7
  store i32 0, ptr %2, align 4
  br label %27

27:                                               ; preds = %26, %25
  br label %4, !llvm.loop !6

28:                                               ; preds = %4
  ret i32 0
}

declare i32 @__VERIFIER_nondet_int() #1

attributes #0 = { noinline nounwind uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }

!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.ident = !{!5}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 2}
!4 = !{i32 7, !"frame-pointer", i32 2}
!5 = !{!"Ubuntu clang version 18.1.3 (1ubuntu1)"}
!6 = distinct !{!6, !7}
!7 = !{!"llvm.loop.mustprogress"}
