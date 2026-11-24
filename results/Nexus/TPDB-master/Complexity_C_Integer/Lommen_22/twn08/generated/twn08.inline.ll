; ModuleID = '/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/Complexity_C_Integer/Lommen_22/twn08/generated/twn08.inline.bc'
source_filename = "/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/Complexity_C_Integer/Lommen_22/twn08/generated/twn08.inline.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define dso_local void @f(i32 noundef %0, i32 noundef %1, i32 noundef %2, i32 noundef %3, i32 noundef %4, i32 noundef %5) #0 {
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  %13 = alloca i32, align 4
  %14 = alloca i32, align 4
  store i32 %0, ptr %7, align 4
  store i32 %1, ptr %8, align 4
  store i32 %2, ptr %9, align 4
  store i32 %3, ptr %10, align 4
  store i32 %4, ptr %11, align 4
  store i32 %5, ptr %12, align 4
  %15 = call i32 @__VERIFIER_nondet_int()
  store i32 %15, ptr %13, align 4
  %16 = call i32 @__VERIFIER_nondet_int()
  store i32 %16, ptr %14, align 4
  %17 = load i32, ptr %13, align 4
  store i32 %17, ptr %7, align 4
  %18 = load i32, ptr %14, align 4
  store i32 %18, ptr %9, align 4
  br label %19

19:                                               ; preds = %6, %67
  call void asm sideeffect "# NEXUS_SOURCE_LOOP_ID_1_PARENT_0", "~{memory},~{dirflag},~{fpsr},~{flags}"() #2, !srcloc !6
  %20 = load i32, ptr %7, align 4
  %21 = icmp sle i32 1, %20
  br i1 %21, label %22, label %33

22:                                               ; preds = %19
  %23 = load i32, ptr %7, align 4
  %24 = icmp sle i32 %23, 3
  br i1 %24, label %25, label %33

25:                                               ; preds = %22
  %26 = load i32, ptr %9, align 4
  %27 = icmp eq i32 %26, 0
  br i1 %27, label %28, label %33

28:                                               ; preds = %25
  %29 = load i32, ptr %7, align 4
  %30 = add nsw i32 %29, 1
  store i32 %30, ptr %7, align 4
  %31 = call i32 @__VERIFIER_nondet_int()
  store i32 %31, ptr %14, align 4
  %32 = load i32, ptr %14, align 4
  store i32 %32, ptr %9, align 4
  br label %67

33:                                               ; preds = %25, %22, %19
  %34 = load i32, ptr %8, align 4
  %35 = icmp sgt i32 %34, 1
  br i1 %35, label %36, label %44

36:                                               ; preds = %33
  %37 = load i32, ptr %9, align 4
  %38 = icmp eq i32 %37, 1
  br i1 %38, label %39, label %44

39:                                               ; preds = %36
  %40 = load i32, ptr %8, align 4
  %41 = sub nsw i32 %40, 1
  store i32 %41, ptr %8, align 4
  %42 = call i32 @__VERIFIER_nondet_int()
  store i32 %42, ptr %14, align 4
  %43 = load i32, ptr %14, align 4
  store i32 %43, ptr %9, align 4
  br label %66

44:                                               ; preds = %36, %33
  br label %45

45:                                               ; preds = %56, %44
  %46 = load i32, ptr %10, align 4
  %47 = load i32, ptr %11, align 4
  %48 = load i32, ptr %11, align 4
  %49 = mul nsw i32 %47, %48
  %50 = icmp slt i32 %46, %49
  br i1 %50, label %51, label %54

51:                                               ; preds = %45
  %52 = load i32, ptr %10, align 4
  %53 = icmp sgt i32 %52, 0
  br label %54

54:                                               ; preds = %51, %45
  %55 = phi i1 [ false, %45 ], [ %53, %51 ]
  br i1 %55, label %56, label %65

56:                                               ; preds = %54
  call void asm sideeffect "# NEXUS_SOURCE_LOOP_ID_2_PARENT_1", "~{memory},~{dirflag},~{fpsr},~{flags}"() #2, !srcloc !7
  %57 = load i32, ptr %10, align 4
  %58 = mul nsw i32 5, %57
  %59 = load i32, ptr %12, align 4
  %60 = load i32, ptr %12, align 4
  %61 = mul nsw i32 %59, %60
  %62 = add nsw i32 %58, %61
  store i32 %62, ptr %10, align 4
  %63 = load i32, ptr %11, align 4
  %64 = mul nsw i32 2, %63
  store i32 %64, ptr %11, align 4
  br label %45, !llvm.loop !8

65:                                               ; preds = %54
  br label %68

66:                                               ; preds = %39
  br label %67

67:                                               ; preds = %66, %28
  br label %19

68:                                               ; preds = %65
  ret void
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
!6 = !{i64 218}
!7 = !{i64 528}
!8 = distinct !{!8, !9}
!9 = !{!"llvm.loop.mustprogress"}
