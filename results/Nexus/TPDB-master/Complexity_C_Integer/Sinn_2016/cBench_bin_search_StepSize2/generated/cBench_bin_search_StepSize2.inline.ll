; ModuleID = '/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/Complexity_C_Integer/Sinn_2016/cBench_bin_search_StepSize2/generated/cBench_bin_search_StepSize2.inline.bc'
source_filename = "/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/Complexity_C_Integer/Sinn_2016/cBench_bin_search_StepSize2/generated/cBench_bin_search_StepSize2.inline.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@bin_search_StepSize2.c = internal global i32 4, align 4

; Function Attrs: noinline nounwind uwtable
define dso_local void @bin_search_StepSize2(i32 noundef %0, i32 noundef %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  store i32 %0, ptr %3, align 4
  store i32 %1, ptr %4, align 4
  store i32 0, ptr %6, align 4
  store i32 0, ptr %7, align 4
  br label %8

8:                                                ; preds = %64, %2
  call void asm sideeffect "# NEXUS_SOURCE_LOOP_ID_1_PARENT_0", "~{memory},~{dirflag},~{fpsr},~{flags}"() #2, !srcloc !6
  %9 = call i32 (...) @nondet()
  store i32 %9, ptr %5, align 4
  %10 = load i32, ptr @bin_search_StepSize2.c, align 4
  %11 = icmp eq i32 %10, 1
  br i1 %11, label %12, label %13

12:                                               ; preds = %8
  br label %65

13:                                               ; preds = %8
  %14 = load i32, ptr %6, align 4
  %15 = icmp ne i32 %14, 0
  br i1 %15, label %16, label %19

16:                                               ; preds = %13
  %17 = load i32, ptr @bin_search_StepSize2.c, align 4
  %18 = sdiv i32 %17, 2
  store i32 %18, ptr @bin_search_StepSize2.c, align 4
  br label %19

19:                                               ; preds = %16, %13
  %20 = load i32, ptr %5, align 4
  %21 = load i32, ptr %3, align 4
  %22 = icmp sgt i32 %20, %21
  br i1 %22, label %23, label %40

23:                                               ; preds = %19
  %24 = load i32, ptr %7, align 4
  %25 = icmp eq i32 %24, 1
  br i1 %25, label %26, label %32

26:                                               ; preds = %23
  %27 = load i32, ptr %6, align 4
  %28 = icmp ne i32 %27, 0
  br i1 %28, label %32, label %29

29:                                               ; preds = %26
  store i32 1, ptr %6, align 4
  %30 = load i32, ptr @bin_search_StepSize2.c, align 4
  %31 = sdiv i32 %30, 2
  store i32 %31, ptr @bin_search_StepSize2.c, align 4
  br label %32

32:                                               ; preds = %29, %26, %23
  store i32 2, ptr %7, align 4
  %33 = load i32, ptr @bin_search_StepSize2.c, align 4
  %34 = load i32, ptr %4, align 4
  %35 = add nsw i32 %34, %33
  store i32 %35, ptr %4, align 4
  %36 = load i32, ptr %4, align 4
  %37 = icmp sgt i32 %36, 255
  br i1 %37, label %38, label %39

38:                                               ; preds = %32
  br label %65

39:                                               ; preds = %32
  br label %63

40:                                               ; preds = %19
  %41 = load i32, ptr %5, align 4
  %42 = load i32, ptr %3, align 4
  %43 = icmp slt i32 %41, %42
  br i1 %43, label %44, label %61

44:                                               ; preds = %40
  %45 = load i32, ptr %7, align 4
  %46 = icmp eq i32 %45, 2
  br i1 %46, label %47, label %53

47:                                               ; preds = %44
  %48 = load i32, ptr %6, align 4
  %49 = icmp ne i32 %48, 0
  br i1 %49, label %53, label %50

50:                                               ; preds = %47
  store i32 1, ptr %6, align 4
  %51 = load i32, ptr @bin_search_StepSize2.c, align 4
  %52 = sdiv i32 %51, 2
  store i32 %52, ptr @bin_search_StepSize2.c, align 4
  br label %53

53:                                               ; preds = %50, %47, %44
  store i32 1, ptr %7, align 4
  %54 = load i32, ptr @bin_search_StepSize2.c, align 4
  %55 = load i32, ptr %4, align 4
  %56 = sub nsw i32 %55, %54
  store i32 %56, ptr %4, align 4
  %57 = load i32, ptr %4, align 4
  %58 = icmp slt i32 %57, 0
  br i1 %58, label %59, label %60

59:                                               ; preds = %53
  br label %65

60:                                               ; preds = %53
  br label %62

61:                                               ; preds = %40
  br label %65

62:                                               ; preds = %60
  br label %63

63:                                               ; preds = %62, %39
  br label %64

64:                                               ; preds = %63
  br i1 true, label %8, label %65

65:                                               ; preds = %64, %61, %59, %38, %12
  ret void
}

declare i32 @nondet(...) #1

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
!6 = !{i64 164}
