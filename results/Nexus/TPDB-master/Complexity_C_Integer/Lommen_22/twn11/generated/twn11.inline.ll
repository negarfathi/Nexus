; ModuleID = '/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/Complexity_C_Integer/Lommen_22/twn11/generated/twn11.inline.bc'
source_filename = "/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/Complexity_C_Integer/Lommen_22/twn11/generated/twn11.inline.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @twn11(i32 noundef %0, i32 noundef %1, i32 noundef %2) #0 {
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  store i32 %0, ptr %4, align 4
  store i32 %1, ptr %5, align 4
  store i32 %2, ptr %6, align 4
  br label %7

7:                                                ; preds = %19, %3
  %8 = load i32, ptr %5, align 4
  %9 = mul nsw i32 4, %8
  %10 = load i32, ptr %5, align 4
  %11 = mul nsw i32 %9, %10
  %12 = load i32, ptr %4, align 4
  %13 = add nsw i32 %11, %12
  %14 = load i32, ptr %5, align 4
  %15 = add nsw i32 %13, %14
  %16 = load i32, ptr %6, align 4
  %17 = add nsw i32 %15, %16
  %18 = icmp sgt i32 %17, 0
  br i1 %18, label %19, label %123

19:                                               ; preds = %7
  call void asm sideeffect "# NEXUS_SOURCE_LOOP_ID_1_PARENT_0", "~{memory},~{dirflag},~{fpsr},~{flags}"() #1, !srcloc !6
  %20 = load i32, ptr %4, align 4
  %21 = load i32, ptr %4, align 4
  %22 = mul nsw i32 8, %21
  %23 = load i32, ptr %5, align 4
  %24 = mul nsw i32 %22, %23
  %25 = load i32, ptr %5, align 4
  %26 = mul nsw i32 %24, %25
  %27 = add nsw i32 %20, %26
  %28 = load i32, ptr %5, align 4
  %29 = mul nsw i32 16, %28
  %30 = load i32, ptr %5, align 4
  %31 = mul nsw i32 %29, %30
  %32 = load i32, ptr %5, align 4
  %33 = mul nsw i32 %31, %32
  %34 = add nsw i32 %27, %33
  %35 = load i32, ptr %5, align 4
  %36 = mul nsw i32 16, %35
  %37 = load i32, ptr %5, align 4
  %38 = mul nsw i32 %36, %37
  %39 = load i32, ptr %6, align 4
  %40 = mul nsw i32 %38, %39
  %41 = add nsw i32 %34, %40
  store i32 %41, ptr %4, align 4
  %42 = load i32, ptr %5, align 4
  %43 = load i32, ptr %4, align 4
  %44 = load i32, ptr %4, align 4
  %45 = mul nsw i32 %43, %44
  %46 = sub nsw i32 %42, %45
  %47 = load i32, ptr %4, align 4
  %48 = mul nsw i32 4, %47
  %49 = load i32, ptr %5, align 4
  %50 = mul nsw i32 %48, %49
  %51 = sub nsw i32 %46, %50
  %52 = load i32, ptr %4, align 4
  %53 = mul nsw i32 4, %52
  %54 = load i32, ptr %6, align 4
  %55 = mul nsw i32 %53, %54
  %56 = sub nsw i32 %51, %55
  %57 = load i32, ptr %5, align 4
  %58 = mul nsw i32 4, %57
  %59 = load i32, ptr %5, align 4
  %60 = mul nsw i32 %58, %59
  %61 = sub nsw i32 %56, %60
  %62 = load i32, ptr %5, align 4
  %63 = mul nsw i32 8, %62
  %64 = load i32, ptr %6, align 4
  %65 = mul nsw i32 %63, %64
  %66 = sub nsw i32 %61, %65
  %67 = load i32, ptr %6, align 4
  %68 = mul nsw i32 4, %67
  %69 = load i32, ptr %6, align 4
  %70 = mul nsw i32 %68, %69
  %71 = sub nsw i32 %66, %70
  store i32 %71, ptr %5, align 4
  %72 = load i32, ptr %6, align 4
  %73 = load i32, ptr %4, align 4
  %74 = mul nsw i32 4, %73
  %75 = load i32, ptr %5, align 4
  %76 = mul nsw i32 %74, %75
  %77 = load i32, ptr %5, align 4
  %78 = mul nsw i32 %76, %77
  %79 = sub nsw i32 %72, %78
  %80 = load i32, ptr %5, align 4
  %81 = mul nsw i32 8, %80
  %82 = load i32, ptr %5, align 4
  %83 = mul nsw i32 %81, %82
  %84 = load i32, ptr %5, align 4
  %85 = mul nsw i32 %83, %84
  %86 = sub nsw i32 %79, %85
  %87 = load i32, ptr %5, align 4
  %88 = mul nsw i32 8, %87
  %89 = load i32, ptr %5, align 4
  %90 = mul nsw i32 %88, %89
  %91 = load i32, ptr %6, align 4
  %92 = mul nsw i32 %90, %91
  %93 = sub nsw i32 %86, %92
  %94 = load i32, ptr %4, align 4
  %95 = load i32, ptr %4, align 4
  %96 = mul nsw i32 %94, %95
  %97 = add nsw i32 %93, %96
  %98 = load i32, ptr %4, align 4
  %99 = mul nsw i32 4, %98
  %100 = load i32, ptr %5, align 4
  %101 = mul nsw i32 %99, %100
  %102 = add nsw i32 %97, %101
  %103 = load i32, ptr %4, align 4
  %104 = mul nsw i32 4, %103
  %105 = load i32, ptr %6, align 4
  %106 = mul nsw i32 %104, %105
  %107 = add nsw i32 %102, %106
  %108 = load i32, ptr %5, align 4
  %109 = mul nsw i32 4, %108
  %110 = load i32, ptr %5, align 4
  %111 = mul nsw i32 %109, %110
  %112 = add nsw i32 %107, %111
  %113 = load i32, ptr %5, align 4
  %114 = mul nsw i32 8, %113
  %115 = load i32, ptr %6, align 4
  %116 = mul nsw i32 %114, %115
  %117 = add nsw i32 %112, %116
  %118 = load i32, ptr %6, align 4
  %119 = mul nsw i32 4, %118
  %120 = load i32, ptr %6, align 4
  %121 = mul nsw i32 %119, %120
  %122 = add nsw i32 %117, %121
  store i32 %122, ptr %6, align 4
  br label %7, !llvm.loop !7

123:                                              ; preds = %7
  call void asm sideeffect "# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE", "~{memory},~{dirflag},~{fpsr},~{flags}"() #1, !srcloc !9
  ret i32 0
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
!6 = !{i64 85}
!7 = distinct !{!7, !8}
!8 = !{!"llvm.loop.mustprogress"}
!9 = !{i64 369}
