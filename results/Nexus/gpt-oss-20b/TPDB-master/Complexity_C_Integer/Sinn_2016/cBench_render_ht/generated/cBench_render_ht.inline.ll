; ModuleID = '/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/Complexity_C_Integer/Sinn_2016/cBench_render_ht/generated/cBench_render_ht.inline.bc'
source_filename = "/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/Complexity_C_Integer/Sinn_2016/cBench_render_ht/generated/cBench_render_ht.inline.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define dso_local void @render_ht(i32 noundef %0, i32 noundef %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i32 %0, ptr %3, align 4
  store i32 %1, ptr %4, align 4
  br label %5

5:                                                ; preds = %19, %2
  %6 = load i32, ptr %3, align 4
  %7 = load i32, ptr %4, align 4
  %8 = sub nsw i32 %6, %7
  switch i32 %8, label %9 [
    i32 7, label %20
    i32 6, label %21
    i32 5, label %22
    i32 4, label %23
    i32 3, label %24
    i32 2, label %25
    i32 1, label %26
    i32 0, label %27
    i32 -7, label %28
    i32 -6, label %29
    i32 -5, label %30
    i32 -4, label %31
    i32 -3, label %32
    i32 -2, label %33
    i32 -1, label %34
  ]

9:                                                ; preds = %5
  %10 = load i32, ptr %3, align 4
  %11 = load i32, ptr %4, align 4
  %12 = icmp sgt i32 %10, %11
  br i1 %12, label %13, label %16

13:                                               ; preds = %9
  %14 = load i32, ptr %4, align 4
  %15 = add nsw i32 %14, 4
  store i32 %15, ptr %4, align 4
  br label %19

16:                                               ; preds = %9
  %17 = load i32, ptr %4, align 4
  %18 = sub nsw i32 %17, 4
  store i32 %18, ptr %4, align 4
  br label %19

19:                                               ; preds = %16, %13
  br label %5

20:                                               ; preds = %5
  br label %21

21:                                               ; preds = %5, %20
  br label %22

22:                                               ; preds = %5, %21
  br label %23

23:                                               ; preds = %5, %22
  br label %24

24:                                               ; preds = %5, %23
  br label %25

25:                                               ; preds = %5, %24
  br label %26

26:                                               ; preds = %5, %25
  br label %27

27:                                               ; preds = %5, %26
  br label %35

28:                                               ; preds = %5
  br label %29

29:                                               ; preds = %5, %28
  br label %30

30:                                               ; preds = %5, %29
  br label %31

31:                                               ; preds = %5, %30
  br label %32

32:                                               ; preds = %5, %31
  br label %33

33:                                               ; preds = %5, %32
  br label %34

34:                                               ; preds = %5, %33
  br label %35

35:                                               ; preds = %34, %27
  ret void
}

attributes #0 = { noinline nounwind uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }

!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.ident = !{!5}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 2}
!4 = !{i32 7, !"frame-pointer", i32 2}
!5 = !{!"Ubuntu clang version 18.1.3 (1ubuntu1)"}
