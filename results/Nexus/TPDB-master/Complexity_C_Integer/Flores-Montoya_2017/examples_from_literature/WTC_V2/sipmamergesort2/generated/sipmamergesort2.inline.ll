; ModuleID = '/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/Complexity_C_Integer/Flores-Montoya_2017/examples_from_literature/WTC_V2/sipmamergesort2/generated/sipmamergesort2.inline.bc'
source_filename = "/home/quasar/Documents/Nexus/results_Nexus/gpt-oss-20b/TPDB-master/Complexity_C_Integer/Flores-Montoya_2017/examples_from_literature/WTC_V2/sipmamergesort2/generated/sipmamergesort2.inline.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define dso_local void @sipmamergesort2(i32 noundef %0) #0 {
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

14:                                               ; preds = %206, %1
  call void asm sideeffect "# NEXUS_SOURCE_LOOP_ID_1_PARENT_0", "~{memory},~{dirflag},~{fpsr},~{flags}"() #2, !srcloc !6
  store i32 1, ptr %8, align 4
  %15 = load i32, ptr %2, align 4
  store i32 %15, ptr %9, align 4
  store i32 1, ptr %5, align 4
  %16 = load i32, ptr %2, align 4
  store i32 %16, ptr %6, align 4
  %17 = load i32, ptr %2, align 4
  %18 = add nsw i32 %17, 1
  store i32 %18, ptr %3, align 4
  %19 = load i32, ptr %2, align 4
  %20 = mul nsw i32 2, %19
  store i32 %20, ptr %4, align 4
  br label %21

21:                                               ; preds = %102, %14
  call void asm sideeffect "# NEXUS_SOURCE_LOOP_ID_2_PARENT_1", "~{memory},~{dirflag},~{fpsr},~{flags}"() #2, !srcloc !7
  %22 = load i32, ptr %9, align 4
  %23 = load i32, ptr %10, align 4
  %24 = icmp sge i32 %22, %23
  br i1 %24, label %25, label %27

25:                                               ; preds = %21
  %26 = load i32, ptr %10, align 4
  store i32 %26, ptr %11, align 4
  br label %29

27:                                               ; preds = %21
  %28 = load i32, ptr %9, align 4
  store i32 %28, ptr %11, align 4
  br label %29

29:                                               ; preds = %27, %25
  %30 = load i32, ptr %9, align 4
  %31 = load i32, ptr %11, align 4
  %32 = sub nsw i32 %30, %31
  store i32 %32, ptr %9, align 4
  %33 = load i32, ptr %9, align 4
  %34 = load i32, ptr %10, align 4
  %35 = icmp sge i32 %33, %34
  br i1 %35, label %36, label %38

36:                                               ; preds = %29
  %37 = load i32, ptr %10, align 4
  store i32 %37, ptr %12, align 4
  br label %40

38:                                               ; preds = %29
  %39 = load i32, ptr %9, align 4
  store i32 %39, ptr %12, align 4
  br label %40

40:                                               ; preds = %38, %36
  %41 = load i32, ptr %9, align 4
  %42 = load i32, ptr %12, align 4
  %43 = sub nsw i32 %41, %42
  store i32 %43, ptr %9, align 4
  br label %44

44:                                               ; preds = %71, %40
  %45 = load i32, ptr %11, align 4
  %46 = icmp sgt i32 %45, 0
  br i1 %46, label %47, label %50

47:                                               ; preds = %44
  %48 = load i32, ptr %12, align 4
  %49 = icmp sgt i32 %48, 0
  br label %50

50:                                               ; preds = %47, %44
  %51 = phi i1 [ false, %44 ], [ %49, %47 ]
  br i1 %51, label %52, label %72

52:                                               ; preds = %50
  call void asm sideeffect "# NEXUS_SOURCE_LOOP_ID_3_PARENT_2", "~{memory},~{dirflag},~{fpsr},~{flags}"() #2, !srcloc !8
  %53 = call i32 (...) @nondet()
  %54 = icmp sgt i32 %53, 0
  br i1 %54, label %55, label %63

55:                                               ; preds = %52
  %56 = load i32, ptr %5, align 4
  %57 = load i32, ptr %8, align 4
  %58 = add nsw i32 %56, %57
  store i32 %58, ptr %5, align 4
  %59 = load i32, ptr %3, align 4
  %60 = add nsw i32 %59, 1
  store i32 %60, ptr %3, align 4
  %61 = load i32, ptr %11, align 4
  %62 = sub nsw i32 %61, 1
  store i32 %62, ptr %11, align 4
  br label %71

63:                                               ; preds = %52
  %64 = load i32, ptr %5, align 4
  %65 = load i32, ptr %8, align 4
  %66 = add nsw i32 %64, %65
  store i32 %66, ptr %5, align 4
  %67 = load i32, ptr %4, align 4
  %68 = sub nsw i32 %67, 1
  store i32 %68, ptr %4, align 4
  %69 = load i32, ptr %12, align 4
  %70 = sub nsw i32 %69, 1
  store i32 %70, ptr %12, align 4
  br label %71

71:                                               ; preds = %63, %55
  br label %44, !llvm.loop !9

72:                                               ; preds = %50
  br label %73

73:                                               ; preds = %76, %72
  %74 = load i32, ptr %12, align 4
  %75 = icmp sgt i32 %74, 0
  br i1 %75, label %76, label %84

76:                                               ; preds = %73
  call void asm sideeffect "# NEXUS_SOURCE_LOOP_ID_4_PARENT_2", "~{memory},~{dirflag},~{fpsr},~{flags}"() #2, !srcloc !11
  %77 = load i32, ptr %5, align 4
  %78 = load i32, ptr %8, align 4
  %79 = add nsw i32 %77, %78
  store i32 %79, ptr %5, align 4
  %80 = load i32, ptr %4, align 4
  %81 = sub nsw i32 %80, 1
  store i32 %81, ptr %4, align 4
  %82 = load i32, ptr %12, align 4
  %83 = sub nsw i32 %82, 1
  store i32 %83, ptr %12, align 4
  br label %73, !llvm.loop !12

84:                                               ; preds = %73
  br label %85

85:                                               ; preds = %88, %84
  %86 = load i32, ptr %11, align 4
  %87 = icmp sgt i32 %86, 0
  br i1 %87, label %88, label %96

88:                                               ; preds = %85
  call void asm sideeffect "# NEXUS_SOURCE_LOOP_ID_5_PARENT_2", "~{memory},~{dirflag},~{fpsr},~{flags}"() #2, !srcloc !13
  %89 = load i32, ptr %5, align 4
  %90 = load i32, ptr %8, align 4
  %91 = add nsw i32 %89, %90
  store i32 %91, ptr %5, align 4
  %92 = load i32, ptr %3, align 4
  %93 = add nsw i32 %92, 1
  store i32 %93, ptr %3, align 4
  %94 = load i32, ptr %11, align 4
  %95 = sub nsw i32 %94, 1
  store i32 %95, ptr %11, align 4
  br label %85, !llvm.loop !14

96:                                               ; preds = %85
  %97 = load i32, ptr %8, align 4
  %98 = sub nsw i32 0, %97
  store i32 %98, ptr %8, align 4
  %99 = load i32, ptr %5, align 4
  store i32 %99, ptr %7, align 4
  %100 = load i32, ptr %6, align 4
  store i32 %100, ptr %5, align 4
  %101 = load i32, ptr %7, align 4
  store i32 %101, ptr %6, align 4
  br label %102

102:                                              ; preds = %96
  %103 = load i32, ptr %9, align 4
  %104 = icmp sgt i32 %103, 0
  br i1 %104, label %21, label %105, !llvm.loop !15

105:                                              ; preds = %102
  store i32 0, ptr %13, align 4
  %106 = load i32, ptr %10, align 4
  %107 = mul nsw i32 2, %106
  store i32 %107, ptr %10, align 4
  %108 = load i32, ptr %10, align 4
  %109 = load i32, ptr %2, align 4
  %110 = icmp sge i32 %108, %109
  br i1 %110, label %111, label %112

111:                                              ; preds = %105
  br label %210

112:                                              ; preds = %105
  store i32 1, ptr %8, align 4
  %113 = load i32, ptr %2, align 4
  store i32 %113, ptr %9, align 4
  store i32 1, ptr %3, align 4
  %114 = load i32, ptr %2, align 4
  store i32 %114, ptr %4, align 4
  %115 = load i32, ptr %2, align 4
  %116 = add nsw i32 %115, 1
  store i32 %116, ptr %5, align 4
  %117 = load i32, ptr %2, align 4
  %118 = mul nsw i32 2, %117
  store i32 %118, ptr %6, align 4
  br label %119

119:                                              ; preds = %200, %112
  call void asm sideeffect "# NEXUS_SOURCE_LOOP_ID_6_PARENT_1", "~{memory},~{dirflag},~{fpsr},~{flags}"() #2, !srcloc !16
  %120 = load i32, ptr %9, align 4
  %121 = load i32, ptr %10, align 4
  %122 = icmp sge i32 %120, %121
  br i1 %122, label %123, label %125

123:                                              ; preds = %119
  %124 = load i32, ptr %10, align 4
  store i32 %124, ptr %11, align 4
  br label %127

125:                                              ; preds = %119
  %126 = load i32, ptr %9, align 4
  store i32 %126, ptr %11, align 4
  br label %127

127:                                              ; preds = %125, %123
  %128 = load i32, ptr %9, align 4
  %129 = load i32, ptr %11, align 4
  %130 = sub nsw i32 %128, %129
  store i32 %130, ptr %9, align 4
  %131 = load i32, ptr %9, align 4
  %132 = load i32, ptr %10, align 4
  %133 = icmp sge i32 %131, %132
  br i1 %133, label %134, label %136

134:                                              ; preds = %127
  %135 = load i32, ptr %10, align 4
  store i32 %135, ptr %12, align 4
  br label %138

136:                                              ; preds = %127
  %137 = load i32, ptr %9, align 4
  store i32 %137, ptr %12, align 4
  br label %138

138:                                              ; preds = %136, %134
  %139 = load i32, ptr %9, align 4
  %140 = load i32, ptr %12, align 4
  %141 = sub nsw i32 %139, %140
  store i32 %141, ptr %9, align 4
  br label %142

142:                                              ; preds = %169, %138
  %143 = load i32, ptr %11, align 4
  %144 = icmp sgt i32 %143, 0
  br i1 %144, label %145, label %148

145:                                              ; preds = %142
  %146 = load i32, ptr %12, align 4
  %147 = icmp sgt i32 %146, 0
  br label %148

148:                                              ; preds = %145, %142
  %149 = phi i1 [ false, %142 ], [ %147, %145 ]
  br i1 %149, label %150, label %170

150:                                              ; preds = %148
  call void asm sideeffect "# NEXUS_SOURCE_LOOP_ID_7_PARENT_6", "~{memory},~{dirflag},~{fpsr},~{flags}"() #2, !srcloc !17
  %151 = call i32 (...) @nondet()
  %152 = icmp sgt i32 %151, 0
  br i1 %152, label %153, label %161

153:                                              ; preds = %150
  %154 = load i32, ptr %5, align 4
  %155 = load i32, ptr %8, align 4
  %156 = add nsw i32 %154, %155
  store i32 %156, ptr %5, align 4
  %157 = load i32, ptr %3, align 4
  %158 = add nsw i32 %157, 1
  store i32 %158, ptr %3, align 4
  %159 = load i32, ptr %11, align 4
  %160 = sub nsw i32 %159, 1
  store i32 %160, ptr %11, align 4
  br label %169

161:                                              ; preds = %150
  %162 = load i32, ptr %5, align 4
  %163 = load i32, ptr %8, align 4
  %164 = add nsw i32 %162, %163
  store i32 %164, ptr %5, align 4
  %165 = load i32, ptr %4, align 4
  %166 = sub nsw i32 %165, 1
  store i32 %166, ptr %4, align 4
  %167 = load i32, ptr %12, align 4
  %168 = sub nsw i32 %167, 1
  store i32 %168, ptr %12, align 4
  br label %169

169:                                              ; preds = %161, %153
  br label %142, !llvm.loop !18

170:                                              ; preds = %148
  br label %171

171:                                              ; preds = %174, %170
  %172 = load i32, ptr %12, align 4
  %173 = icmp sgt i32 %172, 0
  br i1 %173, label %174, label %182

174:                                              ; preds = %171
  call void asm sideeffect "# NEXUS_SOURCE_LOOP_ID_8_PARENT_6", "~{memory},~{dirflag},~{fpsr},~{flags}"() #2, !srcloc !19
  %175 = load i32, ptr %5, align 4
  %176 = load i32, ptr %8, align 4
  %177 = add nsw i32 %175, %176
  store i32 %177, ptr %5, align 4
  %178 = load i32, ptr %4, align 4
  %179 = sub nsw i32 %178, 1
  store i32 %179, ptr %4, align 4
  %180 = load i32, ptr %12, align 4
  %181 = sub nsw i32 %180, 1
  store i32 %181, ptr %12, align 4
  br label %171, !llvm.loop !20

182:                                              ; preds = %171
  br label %183

183:                                              ; preds = %186, %182
  %184 = load i32, ptr %11, align 4
  %185 = icmp sgt i32 %184, 0
  br i1 %185, label %186, label %194

186:                                              ; preds = %183
  call void asm sideeffect "# NEXUS_SOURCE_LOOP_ID_9_PARENT_6", "~{memory},~{dirflag},~{fpsr},~{flags}"() #2, !srcloc !21
  %187 = load i32, ptr %5, align 4
  %188 = load i32, ptr %8, align 4
  %189 = add nsw i32 %187, %188
  store i32 %189, ptr %5, align 4
  %190 = load i32, ptr %3, align 4
  %191 = add nsw i32 %190, 1
  store i32 %191, ptr %3, align 4
  %192 = load i32, ptr %11, align 4
  %193 = sub nsw i32 %192, 1
  store i32 %193, ptr %11, align 4
  br label %183, !llvm.loop !22

194:                                              ; preds = %183
  %195 = load i32, ptr %8, align 4
  %196 = sub nsw i32 0, %195
  store i32 %196, ptr %8, align 4
  %197 = load i32, ptr %5, align 4
  store i32 %197, ptr %7, align 4
  %198 = load i32, ptr %6, align 4
  store i32 %198, ptr %5, align 4
  %199 = load i32, ptr %7, align 4
  store i32 %199, ptr %6, align 4
  br label %200

200:                                              ; preds = %194
  %201 = load i32, ptr %9, align 4
  %202 = icmp sgt i32 %201, 0
  br i1 %202, label %119, label %203, !llvm.loop !23

203:                                              ; preds = %200
  store i32 1, ptr %13, align 4
  %204 = load i32, ptr %10, align 4
  %205 = mul nsw i32 2, %204
  store i32 %205, ptr %10, align 4
  br label %206

206:                                              ; preds = %203
  %207 = load i32, ptr %10, align 4
  %208 = load i32, ptr %2, align 4
  %209 = icmp slt i32 %207, %208
  br i1 %209, label %14, label %210, !llvm.loop !24

210:                                              ; preds = %206, %111
  %211 = load i32, ptr %13, align 4
  %212 = icmp eq i32 %211, 0
  br i1 %212, label %213, label %222

213:                                              ; preds = %210
  store i32 1, ptr %3, align 4
  br label %214

214:                                              ; preds = %218, %213
  %215 = load i32, ptr %3, align 4
  %216 = load i32, ptr %2, align 4
  %217 = icmp sle i32 %215, %216
  br i1 %217, label %218, label %221

218:                                              ; preds = %214
  call void asm sideeffect "# NEXUS_SOURCE_LOOP_ID_10_PARENT_0", "~{memory},~{dirflag},~{fpsr},~{flags}"() #2, !srcloc !25
  %219 = load i32, ptr %3, align 4
  %220 = add nsw i32 %219, 1
  store i32 %220, ptr %3, align 4
  br label %214, !llvm.loop !26

221:                                              ; preds = %214
  br label %222

222:                                              ; preds = %221, %210
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
!6 = !{i64 209}
!7 = !{i64 383}
!8 = !{i64 614}
!9 = distinct !{!9, !10}
!10 = !{!"llvm.loop.mustprogress"}
!11 = !{i64 920}
!12 = distinct !{!12, !10}
!13 = !{i64 1096}
!14 = distinct !{!14, !10}
!15 = distinct !{!15, !10}
!16 = !{i64 1494}
!17 = !{i64 1731}
!18 = distinct !{!18, !10}
!19 = !{i64 2037}
!20 = distinct !{!20, !10}
!21 = !{i64 2213}
!22 = distinct !{!22, !10}
!23 = distinct !{!23, !10}
!24 = distinct !{!24, !10}
!25 = !{i64 2559}
!26 = distinct !{!26, !10}
