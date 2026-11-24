; ModuleID = '/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/Complexity_C_Integer/Lommen_24/non_linear10/generated/non_linear10.inline.bc'
source_filename = "/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/Complexity_C_Integer/Lommen_24/non_linear10/generated/non_linear10.inline.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @non_linear10(i32 noundef %0, i32 noundef %1, i32 noundef %2, i32 noundef %3, i32 noundef %4, i32 noundef %5, i32 noundef %6) #0 {
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  %13 = alloca i32, align 4
  %14 = alloca i32, align 4
  %15 = alloca i32, align 4
  %16 = alloca i32, align 4
  %17 = alloca i32, align 4
  %18 = alloca i32, align 4
  %19 = alloca i32, align 4
  %20 = alloca i32, align 4
  store i32 %0, ptr %8, align 4
  store i32 %1, ptr %9, align 4
  store i32 %2, ptr %10, align 4
  store i32 %3, ptr %11, align 4
  store i32 %4, ptr %12, align 4
  store i32 %5, ptr %13, align 4
  store i32 %6, ptr %14, align 4
  store i32 1, ptr %15, align 4
  br label %21

21:                                               ; preds = %104, %7
  %22 = load i32, ptr %15, align 4
  %23 = icmp slt i32 0, %22
  br i1 %23, label %24, label %28

24:                                               ; preds = %21
  %25 = load i32, ptr %15, align 4
  %26 = load i32, ptr %14, align 4
  %27 = icmp sle i32 %25, %26
  br label %28

28:                                               ; preds = %24, %21
  %29 = phi i1 [ false, %21 ], [ %27, %24 ]
  br i1 %29, label %30, label %105

30:                                               ; preds = %28
  call void asm sideeffect "# NEXUS_SOURCE_LOOP_ID_1_PARENT_0", "~{memory},~{dirflag},~{fpsr},~{flags}"() #2, !srcloc !6
  %31 = load i32, ptr %14, align 4
  store i32 %31, ptr %8, align 4
  %32 = load i32, ptr %14, align 4
  store i32 %32, ptr %9, align 4
  store i32 2, ptr %10, align 4
  %33 = load i32, ptr %10, align 4
  store i32 %33, ptr %11, align 4
  %34 = load i32, ptr %14, align 4
  store i32 %34, ptr %12, align 4
  %35 = load i32, ptr %14, align 4
  store i32 %35, ptr %13, align 4
  %36 = load i32, ptr %14, align 4
  %37 = load i32, ptr %15, align 4
  %38 = sub nsw i32 %36, %37
  store i32 %38, ptr %14, align 4
  %39 = call i32 @__VERIFIER_nondet_int()
  store i32 %39, ptr %16, align 4
  br label %40

40:                                               ; preds = %64, %30
  %41 = load i32, ptr %11, align 4
  %42 = load i32, ptr %11, align 4
  %43 = mul nsw i32 %41, %42
  %44 = load i32, ptr %10, align 4
  %45 = load i32, ptr %10, align 4
  %46 = mul nsw i32 %44, %45
  %47 = load i32, ptr %10, align 4
  %48 = mul nsw i32 %46, %47
  %49 = load i32, ptr %10, align 4
  %50 = mul nsw i32 %48, %49
  %51 = load i32, ptr %10, align 4
  %52 = mul nsw i32 %50, %51
  %53 = sub nsw i32 %43, %52
  %54 = load i32, ptr %12, align 4
  %55 = mul nsw i32 2, %54
  %56 = load i32, ptr %13, align 4
  %57 = sub nsw i32 %55, %56
  %58 = icmp slt i32 %53, %57
  br i1 %58, label %59, label %62

59:                                               ; preds = %40
  %60 = load i32, ptr %11, align 4
  %61 = icmp ne i32 %60, 0
  br label %62

62:                                               ; preds = %59, %40
  %63 = phi i1 [ false, %40 ], [ %61, %59 ]
  br i1 %63, label %64, label %104

64:                                               ; preds = %62
  call void asm sideeffect "# NEXUS_SOURCE_LOOP_ID_2_PARENT_1", "~{memory},~{dirflag},~{fpsr},~{flags}"() #2, !srcloc !7
  %65 = load i32, ptr %8, align 4
  store i32 %65, ptr %17, align 4
  %66 = load i32, ptr %9, align 4
  store i32 %66, ptr %18, align 4
  %67 = load i32, ptr %17, align 4
  %68 = mul nsw i32 3, %67
  %69 = load i32, ptr %18, align 4
  %70 = mul nsw i32 2, %69
  %71 = add nsw i32 %68, %70
  store i32 %71, ptr %8, align 4
  %72 = load i32, ptr %17, align 4
  %73 = mul nsw i32 -5, %72
  %74 = load i32, ptr %18, align 4
  %75 = mul nsw i32 3, %74
  %76 = sub nsw i32 %73, %75
  store i32 %76, ptr %9, align 4
  %77 = load i32, ptr %11, align 4
  %78 = mul nsw i32 -2, %77
  store i32 %78, ptr %11, align 4
  %79 = load i32, ptr %12, align 4
  store i32 %79, ptr %19, align 4
  %80 = load i32, ptr %13, align 4
  store i32 %80, ptr %20, align 4
  %81 = load i32, ptr %19, align 4
  %82 = load i32, ptr %19, align 4
  %83 = load i32, ptr %19, align 4
  %84 = mul nsw i32 %82, %83
  %85 = add nsw i32 %81, %84
  %86 = load i32, ptr %10, align 4
  %87 = load i32, ptr %10, align 4
  %88 = mul nsw i32 %86, %87
  %89 = add nsw i32 %85, %88
  store i32 %89, ptr %12, align 4
  %90 = load i32, ptr %19, align 4
  %91 = mul nsw i32 -4, %90
  %92 = load i32, ptr %19, align 4
  %93 = mul nsw i32 2, %92
  %94 = load i32, ptr %19, align 4
  %95 = mul nsw i32 %93, %94
  %96 = add nsw i32 %91, %95
  %97 = load i32, ptr %20, align 4
  %98 = mul nsw i32 3, %97
  %99 = add nsw i32 %96, %98
  %100 = load i32, ptr %10, align 4
  %101 = load i32, ptr %10, align 4
  %102 = mul nsw i32 %100, %101
  %103 = add nsw i32 %99, %102
  store i32 %103, ptr %13, align 4
  br label %40, !llvm.loop !8

104:                                              ; preds = %62
  br label %21, !llvm.loop !10

105:                                              ; preds = %28
  %106 = load i32, ptr %8, align 4
  store i32 %106, ptr %14, align 4
  br label %107

107:                                              ; preds = %110, %105
  %108 = load i32, ptr %14, align 4
  %109 = icmp sgt i32 %108, 0
  br i1 %109, label %110, label %113

110:                                              ; preds = %107
  call void asm sideeffect "# NEXUS_SOURCE_LOOP_ID_3_PARENT_0", "~{memory},~{dirflag},~{fpsr},~{flags}"() #2, !srcloc !11
  %111 = load i32, ptr %14, align 4
  %112 = sub nsw i32 %111, 1
  store i32 %112, ptr %14, align 4
  br label %107, !llvm.loop !12

113:                                              ; preds = %107
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
!6 = !{i64 181}
!7 = !{i64 444}
!8 = distinct !{!8, !9}
!9 = !{!"llvm.loop.mustprogress"}
!10 = distinct !{!10, !9}
!11 = !{i64 787}
!12 = distinct !{!12, !9}
!13 = !{i64 885}
