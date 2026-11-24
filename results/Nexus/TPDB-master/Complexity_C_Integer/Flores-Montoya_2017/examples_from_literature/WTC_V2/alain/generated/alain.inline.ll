; ModuleID = '/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/Complexity_C_Integer/Flores-Montoya_2017/examples_from_literature/WTC_V2/alain/generated/alain.inline.bc'
source_filename = "/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/Complexity_C_Integer/Flores-Montoya_2017/examples_from_literature/WTC_V2/alain/generated/alain.inline.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @alain(i32 noundef %0, i32 noundef %1, i32 noundef %2, i32 noundef %3, i32 noundef %4) #0 {
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  %13 = alloca i32, align 4
  store i32 %0, ptr %7, align 4
  store i32 %1, ptr %8, align 4
  store i32 %2, ptr %9, align 4
  store i32 %3, ptr %10, align 4
  store i32 %4, ptr %11, align 4
  store i32 0, ptr %12, align 4
  %14 = load i32, ptr %11, align 4
  %15 = load i32, ptr %8, align 4
  %16 = mul nsw i32 2, %15
  %17 = icmp sle i32 %14, %16
  br i1 %17, label %18, label %19

18:                                               ; preds = %5
  call void asm sideeffect "# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE", "~{memory},~{dirflag},~{fpsr},~{flags}"() #1, !srcloc !6
  store i32 0, ptr %6, align 4
  br label %65

19:                                               ; preds = %5
  %20 = load i32, ptr %11, align 4
  %21 = load i32, ptr %9, align 4
  %22 = load i32, ptr %8, align 4
  %23 = add nsw i32 %21, %22
  %24 = icmp sle i32 %20, %23
  br i1 %24, label %25, label %26

25:                                               ; preds = %19
  call void asm sideeffect "# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE", "~{memory},~{dirflag},~{fpsr},~{flags}"() #1, !srcloc !7
  store i32 0, ptr %6, align 4
  br label %65

26:                                               ; preds = %19
  %27 = load i32, ptr %9, align 4
  %28 = icmp sge i32 %27, 0
  br i1 %28, label %29, label %64

29:                                               ; preds = %26
  %30 = load i32, ptr %7, align 4
  %31 = icmp sge i32 %30, 0
  br i1 %31, label %32, label %64

32:                                               ; preds = %29
  %33 = load i32, ptr %8, align 4
  %34 = icmp sge i32 %33, 0
  br i1 %34, label %35, label %64

35:                                               ; preds = %32
  %36 = load i32, ptr %10, align 4
  %37 = icmp sge i32 %36, 0
  br i1 %37, label %38, label %64

38:                                               ; preds = %35
  %39 = load i32, ptr %11, align 4
  %40 = icmp sge i32 %39, 0
  br i1 %40, label %41, label %64

41:                                               ; preds = %38
  br label %42

42:                                               ; preds = %58, %41
  %43 = load i32, ptr %10, align 4
  %44 = add nsw i32 %43, -1
  store i32 %44, ptr %10, align 4
  %45 = icmp sge i32 %44, 0
  br i1 %45, label %46, label %63

46:                                               ; preds = %42
  call void asm sideeffect "# NEXUS_SOURCE_LOOP_ID_1_PARENT_0", "~{memory},~{dirflag},~{fpsr},~{flags}"() #1, !srcloc !8
  store i32 0, ptr %13, align 4
  %47 = load i32, ptr %12, align 4
  %48 = add nsw i32 %47, 1
  store i32 %48, ptr %12, align 4
  br label %49

49:                                               ; preds = %52, %46
  %50 = load i32, ptr %11, align 4
  %51 = icmp sgt i32 %50, 0
  br i1 %51, label %52, label %58

52:                                               ; preds = %49
  call void asm sideeffect "# NEXUS_SOURCE_LOOP_ID_2_PARENT_1", "~{memory},~{dirflag},~{fpsr},~{flags}"() #1, !srcloc !9
  %53 = load i32, ptr %11, align 4
  %54 = add nsw i32 %53, -1
  store i32 %54, ptr %11, align 4
  %55 = load i32, ptr %8, align 4
  store i32 %55, ptr %9, align 4
  %56 = load i32, ptr %13, align 4
  %57 = add nsw i32 %56, 1
  store i32 %57, ptr %13, align 4
  br label %49, !llvm.loop !10

58:                                               ; preds = %49
  %59 = load i32, ptr %9, align 4
  %60 = load i32, ptr %8, align 4
  %61 = add nsw i32 %59, %60
  store i32 %61, ptr %9, align 4
  %62 = load i32, ptr %9, align 4
  store i32 %62, ptr %11, align 4
  br label %42, !llvm.loop !12

63:                                               ; preds = %42
  br label %64

64:                                               ; preds = %63, %38, %35, %32, %29, %26
  call void asm sideeffect "# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE", "~{memory},~{dirflag},~{fpsr},~{flags}"() #1, !srcloc !13
  store i32 0, ptr %6, align 4
  br label %65

65:                                               ; preds = %64, %25, %18
  %66 = load i32, ptr %6, align 4
  ret i32 %66
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
!6 = !{i64 112}
!7 = !{i64 219}
!8 = !{i64 386}
!9 = !{i64 517}
!10 = distinct !{!10, !11}
!11 = !{!"llvm.loop.mustprogress"}
!12 = distinct !{!12, !11}
!13 = !{i64 680}
