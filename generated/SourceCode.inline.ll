; ModuleID = '/Users/nfathi2/Documents/liveness_analysis/Nexus/artifacts/generated/SourceCode.inline.bc'
source_filename = "/Users/nfathi2/Documents/liveness_analysis/Nexus/artifacts/generated/SourceCode.inline.c"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx15.0.0"

@flag = global i32 0, align 4

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  store i32 0, ptr %6, align 4
  %10 = call i32 @__VERIFIER_nondet_int()
  store i32 %10, ptr %7, align 4
  store i32 0, ptr %8, align 4
  br label %11

11:                                               ; preds = %67, %0
  %12 = load i32, ptr %7, align 4
  store i32 %12, ptr %5, align 4
  %13 = load i32, ptr %5, align 4
  %14 = icmp eq i32 %13, 1
  br i1 %14, label %15, label %16

15:                                               ; preds = %11
  store i32 0, ptr %4, align 4
  br label %17

16:                                               ; preds = %11
  store i32 1, ptr %4, align 4
  br label %17

17:                                               ; preds = %15, %16
  %18 = load i32, ptr %4, align 4
  %19 = icmp ne i32 %18, 0
  br i1 %19, label %20, label %68

20:                                               ; preds = %17
  store i32 0, ptr %8, align 4
  br label %21

21:                                               ; preds = %62, %20
  %22 = load i32, ptr %8, align 4
  %23 = icmp eq i32 %22, 0
  br i1 %23, label %24, label %63

24:                                               ; preds = %21
  %25 = call i32 @__VERIFIER_nondet_int()
  store i32 %25, ptr %9, align 4
  %26 = load i32, ptr %9, align 4
  switch i32 %26, label %52 [
    i32 1, label %27
    i32 2, label %53
  ]

27:                                               ; preds = %24
  %28 = load i32, ptr @flag, align 4
  %29 = add nsw i32 %28, 1
  store i32 %29, ptr @flag, align 4
  %30 = icmp slt i32 %28, 100
  br i1 %30, label %31, label %33

31:                                               ; preds = %27
  %32 = call i32 @__VERIFIER_nondet_int() #2
  store i32 %32, ptr %3, align 4
  br label %34

33:                                               ; preds = %27
  store i32 -1, ptr %3, align 4
  br label %34

34:                                               ; preds = %31, %33
  %35 = load i32, ptr %3, align 4
  %36 = icmp slt i32 %35, 0
  %37 = zext i1 %36 to i32
  store i32 %37, ptr %8, align 4
  br i1 %36, label %38, label %39

38:                                               ; preds = %34
  br label %62

39:                                               ; preds = %34
  %40 = load i32, ptr @flag, align 4
  %41 = add nsw i32 %40, 1
  store i32 %41, ptr @flag, align 4
  %42 = icmp slt i32 %40, 100
  br i1 %42, label %43, label %45

43:                                               ; preds = %39
  %44 = call i32 @__VERIFIER_nondet_int() #2
  store i32 %44, ptr %2, align 4
  br label %46

45:                                               ; preds = %39
  store i32 -1, ptr %2, align 4
  br label %46

46:                                               ; preds = %43, %45
  %47 = load i32, ptr %2, align 4
  %48 = icmp eq i32 %47, 0
  %49 = zext i1 %48 to i32
  store i32 %49, ptr %8, align 4
  br i1 %48, label %50, label %51

50:                                               ; preds = %46
  store i32 1, ptr %8, align 4
  br label %51

51:                                               ; preds = %50, %46
  br label %62

52:                                               ; preds = %24
  br label %53

53:                                               ; preds = %24, %52
  %54 = load i32, ptr @flag, align 4
  %55 = add nsw i32 %54, 1
  store i32 %55, ptr @flag, align 4
  %56 = icmp slt i32 %54, 100
  br i1 %56, label %57, label %59

57:                                               ; preds = %53
  %58 = call i32 @__VERIFIER_nondet_int() #2
  store i32 %58, ptr %1, align 4
  br label %60

59:                                               ; preds = %53
  store i32 -1, ptr %1, align 4
  br label %60

60:                                               ; preds = %57, %59
  %61 = load i32, ptr %1, align 4
  store i32 %61, ptr %8, align 4
  br label %62

62:                                               ; preds = %60, %51, %38
  br label %21, !llvm.loop !5

63:                                               ; preds = %21
  %64 = load i32, ptr %8, align 4
  %65 = icmp eq i32 %64, -1
  br i1 %65, label %66, label %67

66:                                               ; preds = %63
  store i32 1, ptr %7, align 4
  br label %67

67:                                               ; preds = %66, %63
  br label %11, !llvm.loop !7

68:                                               ; preds = %17
  ret i32 0
}

declare i32 @__VERIFIER_nondet_int() #1

attributes #0 = { noinline nounwind optnone ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #1 = { "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #2 = { nounwind }

!llvm.module.flags = !{!0, !1, !2, !3}
!llvm.ident = !{!4}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"uwtable", i32 1}
!3 = !{i32 7, !"frame-pointer", i32 1}
!4 = !{!"Homebrew clang version 21.1.5"}
!5 = distinct !{!5, !6}
!6 = !{!"llvm.loop.mustprogress"}
!7 = distinct !{!7, !6}
