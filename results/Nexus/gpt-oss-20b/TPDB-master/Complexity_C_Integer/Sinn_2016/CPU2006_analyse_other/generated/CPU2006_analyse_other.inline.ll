; ModuleID = '/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/Complexity_C_Integer/Sinn_2016/CPU2006_analyse_other/generated/CPU2006_analyse_other.inline.bc'
source_filename = "/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/Complexity_C_Integer/Sinn_2016/CPU2006_analyse_other/generated/CPU2006_analyse_other.inline.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define dso_local void @analyse_other(i32 noundef %0, i32 noundef %1, i32 noundef %2) #0 {
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
  %14 = alloca i32, align 4
  %15 = alloca i32, align 4
  %16 = alloca i32, align 4
  store i32 %0, ptr %4, align 4
  store i32 %1, ptr %5, align 4
  store i32 %2, ptr %6, align 4
  store i32 0, ptr %7, align 4
  store i32 0, ptr %16, align 4
  store i32 0, ptr %8, align 4
  br label %17

17:                                               ; preds = %26, %3
  %18 = load i32, ptr %8, align 4
  %19 = load i32, ptr %4, align 4
  %20 = icmp slt i32 %18, %19
  br i1 %20, label %21, label %29

21:                                               ; preds = %17
  %22 = call i32 (...) @random()
  %23 = icmp ne i32 %22, 0
  br i1 %23, label %24, label %25

24:                                               ; preds = %21
  br label %29

25:                                               ; preds = %21
  br label %26

26:                                               ; preds = %25
  %27 = load i32, ptr %8, align 4
  %28 = add nsw i32 %27, 1
  store i32 %28, ptr %8, align 4
  br label %17, !llvm.loop !6

29:                                               ; preds = %24, %17
  %30 = load i32, ptr %8, align 4
  %31 = load i32, ptr %4, align 4
  %32 = icmp slt i32 %30, %31
  br i1 %32, label %33, label %156

33:                                               ; preds = %29
  store i32 0, ptr %10, align 4
  br label %34

34:                                               ; preds = %63, %33
  %35 = load i32, ptr %10, align 4
  %36 = load i32, ptr %5, align 4
  %37 = icmp slt i32 %35, %36
  br i1 %37, label %38, label %66

38:                                               ; preds = %34
  %39 = call i32 (...) @random()
  %40 = icmp ne i32 %39, 0
  br i1 %40, label %41, label %62

41:                                               ; preds = %38
  store i32 0, ptr %11, align 4
  br label %42

42:                                               ; preds = %51, %41
  %43 = load i32, ptr %11, align 4
  %44 = load i32, ptr %16, align 4
  %45 = icmp slt i32 %43, %44
  br i1 %45, label %46, label %54

46:                                               ; preds = %42
  %47 = call i32 (...) @random()
  %48 = icmp ne i32 %47, 0
  br i1 %48, label %49, label %50

49:                                               ; preds = %46
  br label %54

50:                                               ; preds = %46
  br label %51

51:                                               ; preds = %50
  %52 = load i32, ptr %11, align 4
  %53 = add nsw i32 %52, 1
  store i32 %53, ptr %11, align 4
  br label %42, !llvm.loop !8

54:                                               ; preds = %49, %42
  %55 = load i32, ptr %11, align 4
  %56 = load i32, ptr %16, align 4
  %57 = icmp eq i32 %55, %56
  br i1 %57, label %58, label %61

58:                                               ; preds = %54
  %59 = load i32, ptr %16, align 4
  %60 = add nsw i32 %59, 1
  store i32 %60, ptr %16, align 4
  br label %61

61:                                               ; preds = %58, %54
  br label %62

62:                                               ; preds = %61, %38
  br label %63

63:                                               ; preds = %62
  %64 = load i32, ptr %10, align 4
  %65 = add nsw i32 %64, 1
  store i32 %65, ptr %10, align 4
  br label %34, !llvm.loop !9

66:                                               ; preds = %34
  store i32 0, ptr %8, align 4
  br label %67

67:                                               ; preds = %152, %66
  %68 = load i32, ptr %8, align 4
  %69 = load i32, ptr %16, align 4
  %70 = icmp slt i32 %68, %69
  br i1 %70, label %71, label %155

71:                                               ; preds = %67
  store i32 0, ptr %13, align 4
  store i32 0, ptr %9, align 4
  br label %72

72:                                               ; preds = %83, %71
  %73 = load i32, ptr %9, align 4
  %74 = load i32, ptr %5, align 4
  %75 = icmp slt i32 %73, %74
  br i1 %75, label %76, label %86

76:                                               ; preds = %72
  %77 = call i32 (...) @random()
  %78 = icmp ne i32 %77, 0
  br i1 %78, label %79, label %82

79:                                               ; preds = %76
  %80 = load i32, ptr %13, align 4
  %81 = add nsw i32 %80, 1
  store i32 %81, ptr %13, align 4
  br label %82

82:                                               ; preds = %79, %76
  br label %83

83:                                               ; preds = %82
  %84 = load i32, ptr %9, align 4
  %85 = add nsw i32 %84, 1
  store i32 %85, ptr %9, align 4
  br label %72, !llvm.loop !10

86:                                               ; preds = %72
  %87 = load i32, ptr %6, align 4
  %88 = icmp ne i32 %87, 0
  br i1 %88, label %89, label %151

89:                                               ; preds = %86
  %90 = call i32 (...) @random()
  %91 = icmp ne i32 %90, 0
  br i1 %91, label %92, label %150

92:                                               ; preds = %89
  store i32 0, ptr %15, align 4
  store i32 0, ptr %10, align 4
  br label %93

93:                                               ; preds = %118, %92
  %94 = load i32, ptr %10, align 4
  %95 = load i32, ptr %13, align 4
  %96 = icmp slt i32 %94, %95
  br i1 %96, label %97, label %121

97:                                               ; preds = %93
  store i32 0, ptr %11, align 4
  br label %98

98:                                               ; preds = %107, %97
  %99 = load i32, ptr %11, align 4
  %100 = load i32, ptr %15, align 4
  %101 = icmp slt i32 %99, %100
  br i1 %101, label %102, label %110

102:                                              ; preds = %98
  %103 = call i32 (...) @random()
  %104 = icmp ne i32 %103, 0
  br i1 %104, label %105, label %106

105:                                              ; preds = %102
  br label %110

106:                                              ; preds = %102
  br label %107

107:                                              ; preds = %106
  %108 = load i32, ptr %11, align 4
  %109 = add nsw i32 %108, 1
  store i32 %109, ptr %11, align 4
  br label %98, !llvm.loop !11

110:                                              ; preds = %105, %98
  %111 = load i32, ptr %11, align 4
  %112 = load i32, ptr %15, align 4
  %113 = icmp eq i32 %111, %112
  br i1 %113, label %114, label %117

114:                                              ; preds = %110
  %115 = load i32, ptr %15, align 4
  %116 = add nsw i32 %115, 1
  store i32 %116, ptr %15, align 4
  br label %117

117:                                              ; preds = %114, %110
  br label %118

118:                                              ; preds = %117
  %119 = load i32, ptr %10, align 4
  %120 = add nsw i32 %119, 1
  store i32 %120, ptr %10, align 4
  br label %93, !llvm.loop !12

121:                                              ; preds = %93
  %122 = load i32, ptr %15, align 4
  %123 = icmp sgt i32 %122, 1
  br i1 %123, label %124, label %149

124:                                              ; preds = %121
  store i32 0, ptr %11, align 4
  br label %125

125:                                              ; preds = %145, %124
  %126 = load i32, ptr %11, align 4
  %127 = load i32, ptr %15, align 4
  %128 = icmp slt i32 %126, %127
  br i1 %128, label %129, label %148

129:                                              ; preds = %125
  store i32 0, ptr %14, align 4
  store i32 0, ptr %10, align 4
  br label %130

130:                                              ; preds = %141, %129
  %131 = load i32, ptr %10, align 4
  %132 = load i32, ptr %13, align 4
  %133 = icmp slt i32 %131, %132
  br i1 %133, label %134, label %144

134:                                              ; preds = %130
  %135 = call i32 (...) @random()
  %136 = icmp ne i32 %135, 0
  br i1 %136, label %137, label %140

137:                                              ; preds = %134
  %138 = load i32, ptr %14, align 4
  %139 = add nsw i32 %138, 1
  store i32 %139, ptr %14, align 4
  br label %140

140:                                              ; preds = %137, %134
  br label %141

141:                                              ; preds = %140
  %142 = load i32, ptr %10, align 4
  %143 = add nsw i32 %142, 1
  store i32 %143, ptr %10, align 4
  br label %130, !llvm.loop !13

144:                                              ; preds = %130
  br label %145

145:                                              ; preds = %144
  %146 = load i32, ptr %11, align 4
  %147 = add nsw i32 %146, 1
  store i32 %147, ptr %11, align 4
  br label %125, !llvm.loop !14

148:                                              ; preds = %125
  br label %149

149:                                              ; preds = %148, %121
  br label %150

150:                                              ; preds = %149, %89
  br label %151

151:                                              ; preds = %150, %86
  br label %152

152:                                              ; preds = %151
  %153 = load i32, ptr %8, align 4
  %154 = add nsw i32 %153, 1
  store i32 %154, ptr %8, align 4
  br label %67, !llvm.loop !15

155:                                              ; preds = %67
  br label %156

156:                                              ; preds = %155, %29
  ret void
}

declare i32 @random(...) #1

attributes #0 = { noinline nounwind uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }

!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.ident = !{!5}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 2}
!4 = !{i32 7, !"frame-pointer", i32 2}
!5 = !{!"Ubuntu clang version 18.1.3 (1ubuntu1)"}
!6 = distinct !{!6, !7}
!7 = !{!"llvm.loop.mustprogress"}
!8 = distinct !{!8, !7}
!9 = distinct !{!9, !7}
!10 = distinct !{!10, !7}
!11 = distinct !{!11, !7}
!12 = distinct !{!12, !7}
!13 = distinct !{!13, !7}
!14 = distinct !{!14, !7}
!15 = distinct !{!15, !7}
