; ModuleID = '/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/Complexity_C_Integer/Sinn_2016/cBench_PackBitsEncode/generated/cBench_PackBitsEncode.inline.bc'
source_filename = "/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/Complexity_C_Integer/Sinn_2016/cBench_PackBitsEncode/generated/cBench_PackBitsEncode.inline.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define dso_local void @PackBitsEncode(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  %3 = alloca i64, align 8
  %4 = alloca i64, align 8
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  store i32 %0, ptr %2, align 4
  store i32 0, ptr %6, align 4
  br label %7

7:                                                ; preds = %79, %1
  %8 = load i32, ptr %2, align 4
  %9 = icmp sgt i32 %8, 0
  br i1 %9, label %10, label %80

10:                                               ; preds = %7
  call void asm sideeffect "# NEXUS_SOURCE_LOOP_ID_1_PARENT_0", "~{memory},~{dirflag},~{fpsr},~{flags}"() #2, !srcloc !6
  %11 = load i32, ptr %2, align 4
  %12 = add nsw i32 %11, -1
  store i32 %12, ptr %2, align 4
  store i64 1, ptr %3, align 8
  br label %13

13:                                               ; preds = %24, %10
  %14 = load i32, ptr %2, align 4
  %15 = icmp sgt i32 %14, 0
  br i1 %15, label %16, label %19

16:                                               ; preds = %13
  %17 = call i32 (...) @random()
  %18 = icmp ne i32 %17, 0
  br label %19

19:                                               ; preds = %16, %13
  %20 = phi i1 [ false, %13 ], [ %18, %16 ]
  br i1 %20, label %21, label %27

21:                                               ; preds = %19
  call void asm sideeffect "# NEXUS_SOURCE_LOOP_ID_2_PARENT_1", "~{memory},~{dirflag},~{fpsr},~{flags}"() #2, !srcloc !7
  %22 = load i64, ptr %3, align 8
  %23 = add nsw i64 %22, 1
  store i64 %23, ptr %3, align 8
  br label %24

24:                                               ; preds = %21
  %25 = load i32, ptr %2, align 4
  %26 = add nsw i32 %25, -1
  store i32 %26, ptr %2, align 4
  br label %13, !llvm.loop !8

27:                                               ; preds = %19
  br label %28

28:                                               ; preds = %78, %62, %48, %36, %27
  %29 = load i32, ptr %6, align 4
  switch i32 %29, label %79 [
    i32 0, label %30
    i32 1, label %42
    i32 2, label %56
    i32 3, label %68
  ]

30:                                               ; preds = %28
  %31 = load i64, ptr %3, align 8
  %32 = icmp sgt i64 %31, 1
  br i1 %32, label %33, label %40

33:                                               ; preds = %30
  store i32 2, ptr %6, align 4
  %34 = load i64, ptr %3, align 8
  %35 = icmp sgt i64 %34, 128
  br i1 %35, label %36, label %39

36:                                               ; preds = %33
  %37 = load i64, ptr %3, align 8
  %38 = sub nsw i64 %37, 128
  store i64 %38, ptr %3, align 8
  br label %28

39:                                               ; preds = %33
  br label %41

40:                                               ; preds = %30
  store i32 1, ptr %6, align 4
  br label %41

41:                                               ; preds = %40, %39
  br label %79

42:                                               ; preds = %28
  %43 = load i64, ptr %3, align 8
  %44 = icmp sgt i64 %43, 1
  br i1 %44, label %45, label %50

45:                                               ; preds = %42
  store i32 3, ptr %6, align 4
  %46 = load i64, ptr %3, align 8
  %47 = icmp sgt i64 %46, 128
  br i1 %47, label %48, label %49

48:                                               ; preds = %45
  br label %28

49:                                               ; preds = %45
  br label %55

50:                                               ; preds = %42
  %51 = call i32 (...) @random()
  %52 = icmp ne i32 %51, 0
  br i1 %52, label %53, label %54

53:                                               ; preds = %50
  store i32 0, ptr %6, align 4
  br label %54

54:                                               ; preds = %53, %50
  br label %55

55:                                               ; preds = %54, %49
  br label %79

56:                                               ; preds = %28
  %57 = load i64, ptr %3, align 8
  %58 = icmp sgt i64 %57, 1
  br i1 %58, label %59, label %66

59:                                               ; preds = %56
  %60 = load i64, ptr %3, align 8
  %61 = icmp sgt i64 %60, 128
  br i1 %61, label %62, label %65

62:                                               ; preds = %59
  %63 = load i64, ptr %3, align 8
  %64 = sub nsw i64 %63, 128
  store i64 %64, ptr %3, align 8
  br label %28

65:                                               ; preds = %59
  br label %67

66:                                               ; preds = %56
  store i32 1, ptr %6, align 4
  br label %67

67:                                               ; preds = %66, %65
  br label %79

68:                                               ; preds = %28
  %69 = call i32 (...) @random()
  %70 = icmp ne i32 %69, 0
  br i1 %70, label %71, label %72

71:                                               ; preds = %68
  store i32 0, ptr %6, align 4
  br label %78

72:                                               ; preds = %68
  %73 = call i32 (...) @random()
  %74 = icmp ne i32 %73, 0
  br i1 %74, label %75, label %76

75:                                               ; preds = %72
  store i32 1, ptr %6, align 4
  br label %77

76:                                               ; preds = %72
  store i32 2, ptr %6, align 4
  br label %77

77:                                               ; preds = %76, %75
  br label %78

78:                                               ; preds = %77, %71
  br label %28

79:                                               ; preds = %28, %67, %55, %41
  br label %7, !llvm.loop !10

80:                                               ; preds = %7
  ret void
}

declare i32 @random(...) #1

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
!6 = !{i64 466}
!7 = !{i64 617}
!8 = distinct !{!8, !9}
!9 = !{!"llvm.loop.mustprogress"}
!10 = distinct !{!10, !9}
