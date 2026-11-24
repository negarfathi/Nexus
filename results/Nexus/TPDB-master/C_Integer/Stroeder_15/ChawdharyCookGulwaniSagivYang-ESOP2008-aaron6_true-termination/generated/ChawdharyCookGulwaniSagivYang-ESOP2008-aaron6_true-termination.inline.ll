; ModuleID = '/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/C_Integer/Stroeder_15/ChawdharyCookGulwaniSagivYang-ESOP2008-aaron6_true-termination/generated/ChawdharyCookGulwaniSagivYang-ESOP2008-aaron6_true-termination.inline.bc'
source_filename = "/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/C_Integer/Stroeder_15/ChawdharyCookGulwaniSagivYang-ESOP2008-aaron6_true-termination/generated/ChawdharyCookGulwaniSagivYang-ESOP2008-aaron6_true-termination.inline.c"
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
  %11 = call i32 @__VERIFIER_nondet_int()
  store i32 %11, ptr %6, align 4
  %12 = load i32, ptr %2, align 4
  %13 = load i32, ptr %4, align 4
  %14 = add nsw i32 %12, %13
  %15 = icmp sge i32 %14, 0
  br i1 %15, label %16, label %53

16:                                               ; preds = %0
  br label %17

17:                                               ; preds = %51, %16
  %18 = load i32, ptr %2, align 4
  %19 = load i32, ptr %6, align 4
  %20 = icmp sle i32 %18, %19
  br i1 %20, label %21, label %38

21:                                               ; preds = %17
  %22 = load i32, ptr %2, align 4
  %23 = load i32, ptr %3, align 4
  %24 = mul nsw i32 2, %23
  %25 = load i32, ptr %4, align 4
  %26 = add nsw i32 %24, %25
  %27 = icmp sge i32 %22, %26
  br i1 %27, label %28, label %38

28:                                               ; preds = %21
  %29 = load i32, ptr %4, align 4
  %30 = load i32, ptr %5, align 4
  %31 = add nsw i32 %30, 1
  %32 = icmp sge i32 %29, %31
  br i1 %32, label %33, label %38

33:                                               ; preds = %28
  %34 = load i32, ptr %2, align 4
  %35 = load i32, ptr %3, align 4
  %36 = add nsw i32 %35, 1
  %37 = icmp sge i32 %34, %36
  br label %38

38:                                               ; preds = %33, %28, %21, %17
  %39 = phi i1 [ false, %28 ], [ false, %21 ], [ false, %17 ], [ %37, %33 ]
  br i1 %39, label %40, label %52

40:                                               ; preds = %38
  call void asm sideeffect "# NEXUS_SOURCE_LOOP_ID_1_PARENT_0", "~{memory},~{dirflag},~{fpsr},~{flags}"() #2, !srcloc !6
  %41 = call i32 @__VERIFIER_nondet_int()
  %42 = icmp ne i32 %41, 0
  br i1 %42, label %43, label %48

43:                                               ; preds = %40
  %44 = load i32, ptr %2, align 4
  store i32 %44, ptr %3, align 4
  %45 = load i32, ptr %4, align 4
  store i32 %45, ptr %5, align 4
  %46 = call i32 @__VERIFIER_nondet_int()
  store i32 %46, ptr %2, align 4
  %47 = call i32 @__VERIFIER_nondet_int()
  store i32 %47, ptr %4, align 4
  br label %51

48:                                               ; preds = %40
  %49 = load i32, ptr %2, align 4
  store i32 %49, ptr %3, align 4
  %50 = call i32 @__VERIFIER_nondet_int()
  store i32 %50, ptr %2, align 4
  br label %51

51:                                               ; preds = %48, %43
  br label %17, !llvm.loop !7

52:                                               ; preds = %38
  br label %53

53:                                               ; preds = %52, %0
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
!6 = !{i64 568}
!7 = distinct !{!7, !8}
!8 = !{!"llvm.loop.mustprogress"}
!9 = !{i64 843}
