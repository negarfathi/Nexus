; ModuleID = '/Users/nfathi2/Documents/liveness_analysis/Nexus/artifacts/generated/SourceCode.inline.bc'
source_filename = "/Users/nfathi2/Documents/liveness_analysis/Nexus/artifacts/generated/SourceCode.inline.c"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx15.0.0"

; Function Attrs: noinline nounwind ssp uwtable(sync)
define i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  store i32 0, ptr %1, align 4
  %8 = call i32 @__VERIFIER_nondet_int()
  store i32 %8, ptr %2, align 4
  %9 = call i32 @__VERIFIER_nondet_int()
  store i32 %9, ptr %3, align 4
  %10 = call i32 @__VERIFIER_nondet_int()
  store i32 %10, ptr %4, align 4
  %11 = call i32 @__VERIFIER_nondet_int()
  store i32 %11, ptr %5, align 4
  %12 = load i32, ptr %2, align 4
  %13 = icmp slt i32 %12, 0
  br i1 %13, label %14, label %15

14:                                               ; preds = %0
  store i32 6, ptr %2, align 4
  br label %15

15:                                               ; preds = %14, %0
  %16 = load i32, ptr %2, align 4
  %17 = icmp sgt i32 %16, 10
  br i1 %17, label %18, label %19

18:                                               ; preds = %15
  store i32 10, ptr %2, align 4
  br label %19

19:                                               ; preds = %18, %15
  br label %20

20:                                               ; preds = %37, %19
  %21 = load i32, ptr %2, align 4
  %22 = icmp sgt i32 %21, 0
  br i1 %22, label %23, label %41

23:                                               ; preds = %20
  %24 = load i32, ptr %2, align 4
  %25 = icmp eq i32 %24, 9
  br i1 %25, label %26, label %27

26:                                               ; preds = %23
  store i32 11, ptr %1, align 4
  br label %110

27:                                               ; preds = %23
  %28 = load i32, ptr %2, align 4
  %29 = icmp eq i32 %28, 7
  br i1 %29, label %30, label %31

30:                                               ; preds = %27
  br label %42

31:                                               ; preds = %27
  %32 = load i32, ptr %2, align 4
  %33 = sub nsw i32 %32, 1
  store i32 %33, ptr %2, align 4
  %34 = load i32, ptr %2, align 4
  %35 = icmp eq i32 %34, 5
  br i1 %35, label %36, label %38

36:                                               ; preds = %31
  br label %37

37:                                               ; preds = %36, %38
  br label %20, !llvm.loop !5

38:                                               ; preds = %31
  %39 = load i32, ptr %2, align 4
  %40 = sub nsw i32 %39, 1
  store i32 %40, ptr %2, align 4
  br label %37

41:                                               ; preds = %20
  br label %42

42:                                               ; preds = %41, %30
  %43 = load i32, ptr %3, align 4
  %44 = icmp slt i32 %43, 0
  br i1 %44, label %45, label %46

45:                                               ; preds = %42
  store i32 0, ptr %3, align 4
  br label %46

46:                                               ; preds = %45, %42
  %47 = load i32, ptr %3, align 4
  %48 = icmp sgt i32 %47, 10
  br i1 %48, label %49, label %50

49:                                               ; preds = %46
  store i32 10, ptr %3, align 4
  br label %50

50:                                               ; preds = %49, %46
  %51 = load i32, ptr %3, align 4
  store i32 %51, ptr %6, align 4
  store i32 0, ptr %7, align 4
  br label %52

52:                                               ; preds = %59, %50
  %53 = load i32, ptr %6, align 4
  %54 = icmp sge i32 %53, 0
  br i1 %54, label %55, label %108

55:                                               ; preds = %52
  %56 = load i32, ptr %6, align 4
  %57 = icmp eq i32 %56, 10
  br i1 %57, label %58, label %60

58:                                               ; preds = %55
  store i32 4, ptr %6, align 4
  br label %59

59:                                               ; preds = %58, %104, %105
  br label %52, !llvm.loop !7

60:                                               ; preds = %55
  %61 = load i32, ptr %6, align 4
  %62 = icmp eq i32 %61, 8
  br i1 %62, label %63, label %64

63:                                               ; preds = %60
  store i32 22, ptr %1, align 4
  br label %110

64:                                               ; preds = %60
  %65 = load i32, ptr %6, align 4
  %66 = icmp eq i32 %65, 6
  br i1 %66, label %67, label %68

67:                                               ; preds = %64
  br label %109

68:                                               ; preds = %64
  %69 = load i32, ptr %6, align 4
  %70 = add nsw i32 %69, 2
  store i32 %70, ptr %7, align 4
  br label %71

71:                                               ; preds = %89, %68
  %72 = load i32, ptr %7, align 4
  %73 = icmp sgt i32 %72, 0
  br i1 %73, label %74, label %97

74:                                               ; preds = %71
  %75 = load i32, ptr %7, align 4
  %76 = icmp eq i32 %75, 7
  br i1 %76, label %77, label %78

77:                                               ; preds = %74
  store i32 33, ptr %1, align 4
  br label %110

78:                                               ; preds = %74
  %79 = load i32, ptr %7, align 4
  %80 = icmp eq i32 %79, 5
  br i1 %80, label %81, label %82

81:                                               ; preds = %78
  br label %98

82:                                               ; preds = %78
  %83 = load i32, ptr %5, align 4
  %84 = icmp eq i32 %83, 0
  br i1 %84, label %85, label %90

85:                                               ; preds = %82
  %86 = load i32, ptr %7, align 4
  %87 = icmp eq i32 %86, 2
  br i1 %87, label %88, label %90

88:                                               ; preds = %85
  br label %89

89:                                               ; preds = %88, %95, %96
  br label %71, !llvm.loop !8

90:                                               ; preds = %85, %82
  %91 = load i32, ptr %7, align 4
  %92 = sub nsw i32 %91, 1
  store i32 %92, ptr %7, align 4
  %93 = load i32, ptr %7, align 4
  %94 = icmp eq i32 %93, 3
  br i1 %94, label %95, label %96

95:                                               ; preds = %90
  br label %89

96:                                               ; preds = %90
  br label %89

97:                                               ; preds = %71
  br label %98

98:                                               ; preds = %97, %81
  %99 = load i32, ptr %4, align 4
  %100 = icmp eq i32 %99, 0
  br i1 %100, label %101, label %105

101:                                              ; preds = %98
  %102 = load i32, ptr %6, align 4
  %103 = icmp eq i32 %102, 2
  br i1 %103, label %104, label %105

104:                                              ; preds = %101
  br label %59

105:                                              ; preds = %101, %98
  %106 = load i32, ptr %6, align 4
  %107 = sub nsw i32 %106, 1
  store i32 %107, ptr %6, align 4
  br label %59

108:                                              ; preds = %52
  br label %109

109:                                              ; preds = %108, %67
  store i32 0, ptr %1, align 4
  br label %110

110:                                              ; preds = %109, %77, %63, %26
  %111 = load i32, ptr %1, align 4
  ret i32 %111
}

declare i32 @__VERIFIER_nondet_int() #1

attributes #0 = { noinline nounwind ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #1 = { "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }

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
!8 = distinct !{!8, !6}
