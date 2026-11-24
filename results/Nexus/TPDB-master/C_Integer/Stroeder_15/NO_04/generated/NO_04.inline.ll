; ModuleID = '/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/C_Integer/Stroeder_15/NO_04/generated/NO_04.inline.bc'
source_filename = "/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/C_Integer/Stroeder_15/NO_04/generated/NO_04.inline.c"
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
  %8 = alloca i32, align 4
  store i32 0, ptr %1, align 4
  store i32 0, ptr %2, align 4
  br label %9

9:                                                ; preds = %62, %0
  %10 = load i32, ptr %2, align 4
  %11 = icmp slt i32 %10, 100
  br i1 %11, label %12, label %65

12:                                               ; preds = %9
  call void asm sideeffect "# NEXUS_SOURCE_LOOP_ID_1_PARENT_0", "~{memory},~{dirflag},~{fpsr},~{flags}"() #1, !srcloc !6
  %13 = load i32, ptr %2, align 4
  %14 = add nsw i32 %13, 2
  store i32 %14, ptr %7, align 4
  store i32 0, ptr %3, align 4
  br label %15

15:                                               ; preds = %59, %12
  %16 = load i32, ptr %3, align 4
  %17 = load i32, ptr %7, align 4
  %18 = icmp slt i32 %16, %17
  br i1 %18, label %19, label %62

19:                                               ; preds = %15
  call void asm sideeffect "# NEXUS_SOURCE_LOOP_ID_2_PARENT_1", "~{memory},~{dirflag},~{fpsr},~{flags}"() #1, !srcloc !7
  %20 = load i32, ptr %2, align 4
  %21 = load i32, ptr %3, align 4
  %22 = add nsw i32 %20, %21
  %23 = add nsw i32 %22, 3
  store i32 %23, ptr %4, align 4
  br label %24

24:                                               ; preds = %56, %19
  %25 = load i32, ptr %4, align 4
  %26 = icmp sge i32 %25, 0
  br i1 %26, label %27, label %59

27:                                               ; preds = %24
  call void asm sideeffect "# NEXUS_SOURCE_LOOP_ID_3_PARENT_2", "~{memory},~{dirflag},~{fpsr},~{flags}"() #1, !srcloc !8
  %28 = load i32, ptr %2, align 4
  %29 = load i32, ptr %3, align 4
  %30 = add nsw i32 %28, %29
  %31 = load i32, ptr %4, align 4
  %32 = add nsw i32 %30, %31
  %33 = add nsw i32 %32, 4
  store i32 %33, ptr %8, align 4
  store i32 0, ptr %5, align 4
  br label %34

34:                                               ; preds = %53, %27
  %35 = load i32, ptr %5, align 4
  %36 = load i32, ptr %8, align 4
  %37 = icmp slt i32 %35, %36
  br i1 %37, label %38, label %56

38:                                               ; preds = %34
  call void asm sideeffect "# NEXUS_SOURCE_LOOP_ID_4_PARENT_3", "~{memory},~{dirflag},~{fpsr},~{flags}"() #1, !srcloc !9
  %39 = load i32, ptr %2, align 4
  %40 = load i32, ptr %3, align 4
  %41 = add nsw i32 %39, %40
  %42 = load i32, ptr %4, align 4
  %43 = add nsw i32 %41, %42
  %44 = load i32, ptr %5, align 4
  %45 = add nsw i32 %43, %44
  %46 = add nsw i32 %45, 1000
  store i32 %46, ptr %6, align 4
  br label %47

47:                                               ; preds = %50, %38
  %48 = load i32, ptr %6, align 4
  %49 = icmp sge i32 %48, 0
  br i1 %49, label %50, label %53

50:                                               ; preds = %47
  call void asm sideeffect "# NEXUS_SOURCE_LOOP_ID_5_PARENT_4", "~{memory},~{dirflag},~{fpsr},~{flags}"() #1, !srcloc !10
  %51 = load i32, ptr %6, align 4
  %52 = sub nsw i32 %51, 0
  store i32 %52, ptr %6, align 4
  br label %47, !llvm.loop !11

53:                                               ; preds = %47
  %54 = load i32, ptr %5, align 4
  %55 = add nsw i32 %54, 1
  store i32 %55, ptr %5, align 4
  br label %34, !llvm.loop !13

56:                                               ; preds = %34
  %57 = load i32, ptr %4, align 4
  %58 = sub nsw i32 %57, 1
  store i32 %58, ptr %4, align 4
  br label %24, !llvm.loop !14

59:                                               ; preds = %24
  %60 = load i32, ptr %3, align 4
  %61 = add nsw i32 %60, 1
  store i32 %61, ptr %3, align 4
  br label %15, !llvm.loop !15

62:                                               ; preds = %15
  %63 = load i32, ptr %2, align 4
  %64 = add nsw i32 %63, 1
  store i32 %64, ptr %2, align 4
  br label %9, !llvm.loop !16

65:                                               ; preds = %9
  call void asm sideeffect "# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE", "~{memory},~{dirflag},~{fpsr},~{flags}"() #1, !srcloc !17
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
!6 = !{i64 225}
!7 = !{i64 354}
!8 = !{i64 479}
!9 = !{i64 636}
!10 = !{i64 784}
!11 = distinct !{!11, !12}
!12 = !{!"llvm.loop.mustprogress"}
!13 = distinct !{!13, !12}
!14 = distinct !{!14, !12}
!15 = distinct !{!15, !12}
!16 = distinct !{!16, !12}
!17 = !{i64 1063}
