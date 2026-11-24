; ModuleID = '/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/Complexity_C_Integer/Benamram_2025/amir5/generated/amir5.inline.bc'
source_filename = "/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/Complexity_C_Integer/Benamram_2025/amir5/generated/amir5.inline.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define dso_local void @amir5(i32 noundef %0, i32 noundef %1, i32 noundef %2, i32 noundef %3) #0 {
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  store i32 %0, ptr %5, align 4
  store i32 %1, ptr %6, align 4
  store i32 %2, ptr %7, align 4
  store i32 %3, ptr %8, align 4
  store i32 0, ptr %10, align 4
  br label %11

11:                                               ; preds = %28, %4
  %12 = load i32, ptr %8, align 4
  %13 = add nsw i32 %12, -1
  store i32 %13, ptr %8, align 4
  %14 = icmp sgt i32 %12, 0
  br i1 %14, label %15, label %31

15:                                               ; preds = %11
  call void asm sideeffect "# NEXUS_SOURCE_LOOP_ID_1_PARENT_0", "~{memory},~{dirflag},~{fpsr},~{flags}"() #1, !srcloc !6
  store i32 0, ptr %9, align 4
  br label %16

16:                                               ; preds = %25, %15
  %17 = load i32, ptr %9, align 4
  %18 = load i32, ptr %5, align 4
  %19 = icmp slt i32 %17, %18
  br i1 %19, label %20, label %28

20:                                               ; preds = %16
  call void asm sideeffect "# NEXUS_SOURCE_LOOP_ID_2_PARENT_1", "~{memory},~{dirflag},~{fpsr},~{flags}"() #1, !srcloc !7
  %21 = load i32, ptr %6, align 4
  %22 = load i32, ptr %7, align 4
  %23 = add nsw i32 %21, %22
  store i32 %23, ptr %7, align 4
  %24 = load i32, ptr %7, align 4
  store i32 %24, ptr %10, align 4
  br label %25

25:                                               ; preds = %20
  %26 = load i32, ptr %9, align 4
  %27 = add nsw i32 %26, 1
  store i32 %27, ptr %9, align 4
  br label %16, !llvm.loop !8

28:                                               ; preds = %16
  %29 = load i32, ptr %6, align 4
  store i32 %29, ptr %7, align 4
  %30 = load i32, ptr %10, align 4
  store i32 %30, ptr %5, align 4
  br label %11, !llvm.loop !10

31:                                               ; preds = %11
  br label %32

32:                                               ; preds = %35, %31
  %33 = load i32, ptr %5, align 4
  %34 = icmp sgt i32 %33, 0
  br i1 %34, label %35, label %38

35:                                               ; preds = %32
  call void asm sideeffect "# NEXUS_SOURCE_LOOP_ID_3_PARENT_0", "~{memory},~{dirflag},~{fpsr},~{flags}"() #1, !srcloc !11
  %36 = load i32, ptr %5, align 4
  %37 = add nsw i32 %36, -1
  store i32 %37, ptr %5, align 4
  br label %32, !llvm.loop !12

38:                                               ; preds = %32
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
!6 = !{i64 206}
!7 = !{i64 310}
!8 = distinct !{!8, !9}
!9 = !{!"llvm.loop.mustprogress"}
!10 = distinct !{!10, !9}
!11 = !{i64 501}
!12 = distinct !{!12, !9}
