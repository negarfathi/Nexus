; ModuleID = '/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/Complexity_C_Integer/Flores-Montoya_2017/examples_from_literature/WTC_V2/sipmamergesort/generated/sipmamergesort.inline.bc'
source_filename = "/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/Complexity_C_Integer/Flores-Montoya_2017/examples_from_literature/WTC_V2/sipmamergesort/generated/sipmamergesort.inline.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define dso_local void @sipmamergesort_init(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  %13 = alloca i32, align 4
  store i32 %0, ptr %2, align 4
  store i32 1, ptr %13, align 4
  store i32 1, ptr %10, align 4
  br label %14

14:                                               ; preds = %120, %1
  call void asm sideeffect "# NEXUS_SOURCE_LOOP_ID_1_PARENT_0", "~{memory},~{dirflag},~{fpsr},~{flags}"() #2, !srcloc !6
  store i32 1, ptr %8, align 4
  %15 = load i32, ptr %2, align 4
  store i32 %15, ptr %9, align 4
  %16 = load i32, ptr %13, align 4
  %17 = icmp ne i32 %16, 0
  br i1 %17, label %18, label %24

18:                                               ; preds = %14
  store i32 1, ptr %3, align 4
  %19 = load i32, ptr %2, align 4
  store i32 %19, ptr %4, align 4
  %20 = load i32, ptr %2, align 4
  %21 = add nsw i32 %20, 1
  store i32 %21, ptr %5, align 4
  %22 = load i32, ptr %2, align 4
  %23 = mul nsw i32 2, %22
  store i32 %23, ptr %6, align 4
  br label %30

24:                                               ; preds = %14
  store i32 1, ptr %5, align 4
  %25 = load i32, ptr %2, align 4
  store i32 %25, ptr %6, align 4
  %26 = load i32, ptr %2, align 4
  %27 = add nsw i32 %26, 1
  store i32 %27, ptr %3, align 4
  %28 = load i32, ptr %2, align 4
  %29 = mul nsw i32 2, %28
  store i32 %29, ptr %4, align 4
  br label %30

30:                                               ; preds = %24, %18
  br label %31

31:                                               ; preds = %112, %30
  call void asm sideeffect "# NEXUS_SOURCE_LOOP_ID_2_PARENT_1", "~{memory},~{dirflag},~{fpsr},~{flags}"() #2, !srcloc !7
  %32 = load i32, ptr %9, align 4
  %33 = load i32, ptr %10, align 4
  %34 = icmp sge i32 %32, %33
  br i1 %34, label %35, label %37

35:                                               ; preds = %31
  %36 = load i32, ptr %10, align 4
  store i32 %36, ptr %11, align 4
  br label %39

37:                                               ; preds = %31
  %38 = load i32, ptr %9, align 4
  store i32 %38, ptr %11, align 4
  br label %39

39:                                               ; preds = %37, %35
  %40 = load i32, ptr %9, align 4
  %41 = load i32, ptr %11, align 4
  %42 = sub nsw i32 %40, %41
  store i32 %42, ptr %9, align 4
  %43 = load i32, ptr %9, align 4
  %44 = load i32, ptr %10, align 4
  %45 = icmp sge i32 %43, %44
  br i1 %45, label %46, label %48

46:                                               ; preds = %39
  %47 = load i32, ptr %10, align 4
  store i32 %47, ptr %12, align 4
  br label %50

48:                                               ; preds = %39
  %49 = load i32, ptr %9, align 4
  store i32 %49, ptr %12, align 4
  br label %50

50:                                               ; preds = %48, %46
  %51 = load i32, ptr %9, align 4
  %52 = load i32, ptr %12, align 4
  %53 = sub nsw i32 %51, %52
  store i32 %53, ptr %9, align 4
  br label %54

54:                                               ; preds = %81, %50
  %55 = load i32, ptr %11, align 4
  %56 = icmp sgt i32 %55, 0
  br i1 %56, label %57, label %60

57:                                               ; preds = %54
  %58 = load i32, ptr %12, align 4
  %59 = icmp sgt i32 %58, 0
  br label %60

60:                                               ; preds = %57, %54
  %61 = phi i1 [ false, %54 ], [ %59, %57 ]
  br i1 %61, label %62, label %82

62:                                               ; preds = %60
  call void asm sideeffect "# NEXUS_SOURCE_LOOP_ID_3_PARENT_2", "~{memory},~{dirflag},~{fpsr},~{flags}"() #2, !srcloc !8
  %63 = call i32 (...) @nondet()
  %64 = icmp ne i32 %63, 0
  br i1 %64, label %65, label %73

65:                                               ; preds = %62
  %66 = load i32, ptr %5, align 4
  %67 = load i32, ptr %8, align 4
  %68 = add nsw i32 %66, %67
  store i32 %68, ptr %5, align 4
  %69 = load i32, ptr %3, align 4
  %70 = add nsw i32 %69, 1
  store i32 %70, ptr %3, align 4
  %71 = load i32, ptr %11, align 4
  %72 = sub nsw i32 %71, 1
  store i32 %72, ptr %11, align 4
  br label %81

73:                                               ; preds = %62
  %74 = load i32, ptr %5, align 4
  %75 = load i32, ptr %8, align 4
  %76 = add nsw i32 %74, %75
  store i32 %76, ptr %5, align 4
  %77 = load i32, ptr %4, align 4
  %78 = sub nsw i32 %77, 1
  store i32 %78, ptr %4, align 4
  %79 = load i32, ptr %12, align 4
  %80 = sub nsw i32 %79, 1
  store i32 %80, ptr %12, align 4
  br label %81

81:                                               ; preds = %73, %65
  br label %54, !llvm.loop !9

82:                                               ; preds = %60
  br label %83

83:                                               ; preds = %86, %82
  %84 = load i32, ptr %12, align 4
  %85 = icmp sgt i32 %84, 0
  br i1 %85, label %86, label %94

86:                                               ; preds = %83
  call void asm sideeffect "# NEXUS_SOURCE_LOOP_ID_4_PARENT_2", "~{memory},~{dirflag},~{fpsr},~{flags}"() #2, !srcloc !11
  %87 = load i32, ptr %5, align 4
  %88 = load i32, ptr %8, align 4
  %89 = add nsw i32 %87, %88
  store i32 %89, ptr %5, align 4
  %90 = load i32, ptr %4, align 4
  %91 = sub nsw i32 %90, 1
  store i32 %91, ptr %4, align 4
  %92 = load i32, ptr %12, align 4
  %93 = sub nsw i32 %92, 1
  store i32 %93, ptr %12, align 4
  br label %83, !llvm.loop !12

94:                                               ; preds = %83
  br label %95

95:                                               ; preds = %98, %94
  %96 = load i32, ptr %11, align 4
  %97 = icmp sgt i32 %96, 0
  br i1 %97, label %98, label %106

98:                                               ; preds = %95
  call void asm sideeffect "# NEXUS_SOURCE_LOOP_ID_5_PARENT_2", "~{memory},~{dirflag},~{fpsr},~{flags}"() #2, !srcloc !13
  %99 = load i32, ptr %5, align 4
  %100 = load i32, ptr %8, align 4
  %101 = add nsw i32 %99, %100
  store i32 %101, ptr %5, align 4
  %102 = load i32, ptr %3, align 4
  %103 = add nsw i32 %102, 1
  store i32 %103, ptr %3, align 4
  %104 = load i32, ptr %11, align 4
  %105 = sub nsw i32 %104, 1
  store i32 %105, ptr %11, align 4
  br label %95, !llvm.loop !14

106:                                              ; preds = %95
  %107 = load i32, ptr %8, align 4
  %108 = sub nsw i32 0, %107
  store i32 %108, ptr %8, align 4
  %109 = load i32, ptr %5, align 4
  store i32 %109, ptr %7, align 4
  %110 = load i32, ptr %6, align 4
  store i32 %110, ptr %5, align 4
  %111 = load i32, ptr %7, align 4
  store i32 %111, ptr %6, align 4
  br label %112

112:                                              ; preds = %106
  %113 = load i32, ptr %9, align 4
  %114 = icmp sgt i32 %113, 0
  br i1 %114, label %31, label %115, !llvm.loop !15

115:                                              ; preds = %112
  %116 = load i32, ptr %13, align 4
  %117 = sub nsw i32 1, %116
  store i32 %117, ptr %13, align 4
  %118 = load i32, ptr %10, align 4
  %119 = mul nsw i32 2, %118
  store i32 %119, ptr %10, align 4
  br label %120

120:                                              ; preds = %115
  %121 = load i32, ptr %10, align 4
  %122 = load i32, ptr %2, align 4
  %123 = icmp slt i32 %121, %122
  br i1 %123, label %14, label %124, !llvm.loop !16

124:                                              ; preds = %120
  %125 = load i32, ptr %13, align 4
  %126 = icmp eq i32 %125, 0
  br i1 %126, label %127, label %136

127:                                              ; preds = %124
  store i32 1, ptr %3, align 4
  br label %128

128:                                              ; preds = %132, %127
  %129 = load i32, ptr %3, align 4
  %130 = load i32, ptr %2, align 4
  %131 = icmp sle i32 %129, %130
  br i1 %131, label %132, label %135

132:                                              ; preds = %128
  call void asm sideeffect "# NEXUS_SOURCE_LOOP_ID_6_PARENT_0", "~{memory},~{dirflag},~{fpsr},~{flags}"() #2, !srcloc !17
  %133 = load i32, ptr %3, align 4
  %134 = add nsw i32 %133, 1
  store i32 %134, ptr %3, align 4
  br label %128, !llvm.loop !18

135:                                              ; preds = %128
  br label %136

136:                                              ; preds = %135, %124
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
!6 = !{i64 213}
!7 = !{i64 460}
!8 = !{i64 691}
!9 = distinct !{!9, !10}
!10 = !{!"llvm.loop.mustprogress"}
!11 = !{i64 995}
!12 = distinct !{!12, !10}
!13 = !{i64 1171}
!14 = distinct !{!14, !10}
!15 = distinct !{!15, !10}
!16 = distinct !{!16, !10}
!17 = !{i64 1501}
!18 = distinct !{!18, !10}
