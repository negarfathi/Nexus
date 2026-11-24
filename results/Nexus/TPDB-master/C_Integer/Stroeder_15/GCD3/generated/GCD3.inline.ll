; ModuleID = '/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/C_Integer/Stroeder_15/GCD3/generated/GCD3.inline.bc'
source_filename = "/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/C_Integer/Stroeder_15/GCD3/generated/GCD3.inline.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  store i32 0, ptr %1, align 4
  %6 = call i32 @__VERIFIER_nondet_int()
  store i32 %6, ptr %2, align 4
  %7 = call i32 @__VERIFIER_nondet_int()
  store i32 %7, ptr %3, align 4
  br label %8

8:                                                ; preds = %54, %0
  %9 = load i32, ptr %3, align 4
  %10 = icmp sgt i32 %9, 0
  br i1 %10, label %11, label %14

11:                                               ; preds = %8
  %12 = load i32, ptr %2, align 4
  %13 = icmp sgt i32 %12, 0
  br label %14

14:                                               ; preds = %11, %8
  %15 = phi i1 [ false, %8 ], [ %13, %11 ]
  br i1 %15, label %16, label %56

16:                                               ; preds = %14
  call void asm sideeffect "# NEXUS_SOURCE_LOOP_ID_1_PARENT_0", "~{memory},~{dirflag},~{fpsr},~{flags}"() #2, !srcloc !6
  %17 = load i32, ptr %3, align 4
  store i32 %17, ptr %4, align 4
  %18 = load i32, ptr %2, align 4
  store i32 %18, ptr %5, align 4
  %19 = load i32, ptr %3, align 4
  %20 = icmp eq i32 %19, 0
  br i1 %20, label %21, label %23

21:                                               ; preds = %16
  %22 = load i32, ptr %3, align 4
  store i32 %22, ptr %3, align 4
  br label %30

23:                                               ; preds = %16
  %24 = load i32, ptr %3, align 4
  %25 = icmp slt i32 %24, 0
  br i1 %25, label %26, label %29

26:                                               ; preds = %23
  %27 = load i32, ptr %5, align 4
  %28 = sub nsw i32 0, %27
  store i32 %28, ptr %5, align 4
  br label %29

29:                                               ; preds = %26, %23
  br label %30

30:                                               ; preds = %29, %21
  %31 = load i32, ptr %5, align 4
  %32 = icmp sgt i32 %31, 0
  br i1 %32, label %33, label %44

33:                                               ; preds = %30
  br label %34

34:                                               ; preds = %38, %33
  %35 = load i32, ptr %5, align 4
  %36 = load i32, ptr %3, align 4
  %37 = icmp sge i32 %35, %36
  br i1 %37, label %38, label %42

38:                                               ; preds = %34
  call void asm sideeffect "# NEXUS_SOURCE_LOOP_ID_2_PARENT_1", "~{memory},~{dirflag},~{fpsr},~{flags}"() #2, !srcloc !7
  %39 = load i32, ptr %5, align 4
  %40 = load i32, ptr %3, align 4
  %41 = sub nsw i32 %39, %40
  store i32 %41, ptr %5, align 4
  br label %34, !llvm.loop !8

42:                                               ; preds = %34
  %43 = load i32, ptr %5, align 4
  store i32 %43, ptr %3, align 4
  br label %54

44:                                               ; preds = %30
  br label %45

45:                                               ; preds = %48, %44
  %46 = load i32, ptr %5, align 4
  %47 = icmp slt i32 %46, 0
  br i1 %47, label %48, label %52

48:                                               ; preds = %45
  call void asm sideeffect "# NEXUS_SOURCE_LOOP_ID_3_PARENT_1", "~{memory},~{dirflag},~{fpsr},~{flags}"() #2, !srcloc !10
  %49 = load i32, ptr %5, align 4
  %50 = load i32, ptr %3, align 4
  %51 = sub nsw i32 %49, %50
  store i32 %51, ptr %5, align 4
  br label %45, !llvm.loop !11

52:                                               ; preds = %45
  %53 = load i32, ptr %5, align 4
  store i32 %53, ptr %3, align 4
  br label %54

54:                                               ; preds = %52, %42
  %55 = load i32, ptr %4, align 4
  store i32 %55, ptr %2, align 4
  br label %8, !llvm.loop !12

56:                                               ; preds = %14
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
!6 = !{i64 258}
!7 = !{i64 570}
!8 = distinct !{!8, !9}
!9 = !{!"llvm.loop.mustprogress"}
!10 = !{i64 759}
!11 = distinct !{!11, !9}
!12 = distinct !{!12, !9}
!13 = !{i64 954}
