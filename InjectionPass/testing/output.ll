; ModuleID = 'loop.bc'
source_filename = "src/loop.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [11 x i8] c"Sum is %d\0A\00", align 1
@iteration_number = internal global i32 0, align 1
@injection_index = internal global i32 0, align 1
@injection_index_max = internal global i32 2, align 1
@iteration_number_array = internal global [2 x i32] [i32 1, i32 5], align 1
@injection_array = internal global [2 x i32] [i32 1, i32 1], align 1

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i32 0, i32* %1, align 4
  store i32 0, i32* %4, align 4
  store i32 1, i32* %2, align 4
  br label %5

5:                                                ; preds = %41, %0
  %6 = load i32, i32* %2, align 4
  %7 = icmp sle i32 %6, 3
  br i1 %7, label %8, label %44

8:                                                ; preds = %5
  store i32 1, i32* %3, align 4
  br label %9

9:                                                ; preds = %37, %8
  %10 = load i32, i32* %3, align 4
  %11 = load i32, i32* %2, align 4
  %12 = icmp sle i32 %10, %11
  br i1 %12, label %13, label %40

13:                                               ; preds = %9
  %14 = load i32, i32* %2, align 4
  %15 = load i32, i32* %3, align 4
  %16 = mul nsw i32 %14, %15
  %17 = load i32, i32* %4, align 4
  %18 = load i32, i32* @iteration_number, align 4
  %19 = load i32, i32* @injection_index, align 4
  %20 = load i32, i32* @injection_index_max, align 4
  %21 = icmp slt i32 %19, %20
  br i1 %21, label %22, label %34

22:                                               ; preds = %13
  %23 = getelementptr [2 x i32], [2 x i32]* @iteration_number_array, i32 0, i32 %19
  %24 = load i32, i32* %23, align 4
  %25 = add i32 %18, 1
  store i32 %25, i32* @iteration_number, align 4
  %26 = icmp eq i32 %24, %25
  br i1 %26, label %27, label %32

27:                                               ; preds = %22
  %28 = getelementptr [2 x i32], [2 x i32]* @injection_array, i32 0, i32 %19
  %29 = load i32, i32* %28, align 4
  %30 = xor i32 %17, %29
  store i32 %30, i32* %4, align 4
  %31 = add i32 %19, 1
  store i32 %31, i32* @injection_index, align 4
  br label %32

32:                                               ; preds = %22, %27
  %33 = phi i32 [ %17, %22 ], [ %30, %27 ]
  br label %34

34:                                               ; preds = %13, %32
  %35 = phi i32 [ %17, %13 ], [ %33, %32 ]
  %36 = add nsw i32 %35, %16
  store i32 %36, i32* %4, align 4
  br label %37

37:                                               ; preds = %34
  %38 = load i32, i32* %3, align 4
  %39 = add nsw i32 %38, 1
  store i32 %39, i32* %3, align 4
  br label %9, !llvm.loop !6

40:                                               ; preds = %9
  br label %41

41:                                               ; preds = %40
  %42 = load i32, i32* %2, align 4
  %43 = add nsw i32 %42, 1
  store i32 %43, i32* %2, align 4
  br label %5, !llvm.loop !8

44:                                               ; preds = %5
  %45 = load i32, i32* %4, align 4
  %46 = call i32 (i8*, ...) @printf(i8* noundef getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i64 0, i64 0), i32 noundef %45)
  ret i32 0
}

declare i32 @printf(i8* noundef, ...) #1

attributes #0 = { noinline nounwind uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }

!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.ident = !{!5}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 1}
!4 = !{i32 7, !"frame-pointer", i32 2}
!5 = !{!"Ubuntu clang version 14.0.0-1ubuntu1.1"}
!6 = distinct !{!6, !7}
!7 = !{!"llvm.loop.mustprogress"}
!8 = distinct !{!8, !7}

