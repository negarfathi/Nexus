; ModuleID = '/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/C_Integer/Stroeder_15/AliasDarteFeautrierGonnord-SAS2010-Fig2b_true-termination/generated/AliasDarteFeautrierGonnord-SAS2010-Fig2b_true-termination.inline.bc'
source_filename = "/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/C_Integer/Stroeder_15/AliasDarteFeautrierGonnord-SAS2010-Fig2b_true-termination/generated/AliasDarteFeautrierGonnord-SAS2010-Fig2b_true-termination.inline.c"
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

6:                                                ; preds = %46, %0
  %7 = load i32, ptr %2, align 4
  %8 = icmp sge i32 %7, 2
  br i1 %8, label %9, label %52

9:                                                ; preds = %6
  call void asm sideeffect "# NEXUS_SOURCE_LOOP_ID_1_PARENT_0", "~{memory},~{dirflag},~{fpsr},~{flags}"() #2, !srcloc !6
  %10 = load i32, ptr %2, align 4
  %11 = sub nsw i32 %10, 1
  store i32 %11, ptr %2, align 4
  %12 = load i32, ptr %3, align 4
  %13 = load i32, ptr %2, align 4
  %14 = add nsw i32 %12, %13
  store i32 %14, ptr %3, align 4
  br label %15

15:                                               ; preds = %43, %9
  %16 = load i32, ptr %3, align 4
  %17 = load i32, ptr %2, align 4
  %18 = add nsw i32 %17, 1
  %19 = icmp sge i32 %16, %18
  br i1 %19, label %20, label %23

20:                                               ; preds = %15
  %21 = call i32 @__VERIFIER_nondet_int()
  %22 = icmp ne i32 %21, 0
  br label %23

23:                                               ; preds = %20, %15
  %24 = phi i1 [ false, %15 ], [ %22, %20 ]
  br i1 %24, label %25, label %46

25:                                               ; preds = %23
  call void asm sideeffect "# NEXUS_SOURCE_LOOP_ID_2_PARENT_1", "~{memory},~{dirflag},~{fpsr},~{flags}"() #2, !srcloc !7
  %26 = load i32, ptr %3, align 4
  %27 = sub nsw i32 %26, 1
  store i32 %27, ptr %3, align 4
  br label %28

28:                                               ; preds = %38, %25
  %29 = load i32, ptr %3, align 4
  %30 = load i32, ptr %2, align 4
  %31 = add nsw i32 %30, 3
  %32 = icmp sge i32 %29, %31
  br i1 %32, label %33, label %36

33:                                               ; preds = %28
  %34 = call i32 @__VERIFIER_nondet_int()
  %35 = icmp ne i32 %34, 0
  br label %36

36:                                               ; preds = %33, %28
  %37 = phi i1 [ false, %28 ], [ %35, %33 ]
  br i1 %37, label %38, label %43

38:                                               ; preds = %36
  call void asm sideeffect "# NEXUS_SOURCE_LOOP_ID_3_PARENT_2", "~{memory},~{dirflag},~{fpsr},~{flags}"() #2, !srcloc !8
  %39 = load i32, ptr %2, align 4
  %40 = add nsw i32 %39, 1
  store i32 %40, ptr %2, align 4
  %41 = load i32, ptr %3, align 4
  %42 = sub nsw i32 %41, 2
  store i32 %42, ptr %3, align 4
  br label %28, !llvm.loop !9

43:                                               ; preds = %36
  %44 = load i32, ptr %3, align 4
  %45 = sub nsw i32 %44, 1
  store i32 %45, ptr %3, align 4
  br label %15, !llvm.loop !11

46:                                               ; preds = %23
  %47 = load i32, ptr %2, align 4
  %48 = sub nsw i32 %47, 1
  store i32 %48, ptr %2, align 4
  %49 = load i32, ptr %3, align 4
  %50 = load i32, ptr %2, align 4
  %51 = sub nsw i32 %49, %50
  store i32 %51, ptr %3, align 4
  br label %6, !llvm.loop !12

52:                                               ; preds = %6
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
!6 = !{i64 462}
!7 = !{i64 622}
!8 = !{i64 765}
!9 = distinct !{!9, !10}
!10 = !{!"llvm.loop.mustprogress"}
!11 = distinct !{!11, !10}
!12 = distinct !{!12, !10}
!13 = !{i64 941}
