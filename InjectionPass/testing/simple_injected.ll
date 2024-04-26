; ModuleID = 'simple.bc'
source_filename = "src/simple.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [10 x i8] c"%d\0A%d\0A%d\0A\00", align 1
@.str2 = private unnamed_addr constant [7 x i8] c"%p\0A%p\0A\00", align 1
@iteration_number = internal global i32 0, align 1
@injection_index = internal global i32 0, align 1
@injection_index_max = internal global i32 1, align 1
@iteration_number_array = internal global [1 x i32] [i32 1], align 1
@injection_array = internal global [1 x i32] [i32 1], align 1
@remote_injection_ptr = internal global i32* null, align 1

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  store i32 5, i32* %1, align 4
  store i32 7, i32* %2, align 4
  store i32 10, i32* %3, align 4
  %4 = load i32, i32* %2, align 4
  %5 = load i32, i32* %1, align 4
  %6 = add nsw i32 %4, %5
  store i32 %6, i32* %1, align 4
  %7 = load i32, i32* %3, align 4
  store volatile i32* %3, i32** @remote_injection_ptr, align 8
  %8 = load i32, i32* %1, align 4
  %9 = mul nsw i32 %7, %8
  store i32 %9, i32* %2, align 4
  %10 = load i32, i32* %2, align 4
  %11 = load i32, i32* %1, align 4
  %12 = sub nsw i32 %10, %11
  store i32 %12, i32* %3, align 4
  %13 = load i32, i32* %2, align 4
  %14 = load i32, i32* %1, align 4
  %15 = sdiv i32 %13, %14
  store i32 %15, i32* %2, align 4
  %16 = load i32, i32* %1, align 4
  %17 = load i32, i32* %1, align 4
  %18 = load i32*, i32** @remote_injection_ptr, align 8
  %19 = load i32, i32* %18, align 4
  %20 = load i32, i32* @iteration_number, align 4
  %21 = load i32, i32* @injection_index, align 4
  %22 = load i32, i32* @injection_index_max, align 4
  %23 = icmp slt i32 %21, %22
  br i1 %23, label %24, label %36

24:                                               ; preds = %0
  %p1 = call i32 (i8*, ...) @printf(i8* noundef getelementptr inbounds ([7 x i8], [7 x i8]* @.str2, i64 0, i64 0), i32* %3, i32* %18)
  %25 = getelementptr [1 x i32], [1 x i32]* @iteration_number_array, i32 0, i32 %21
  %26 = load i32, i32* %25, align 4
  %27 = add i32 %20, 1
  store i32 %27, i32* @iteration_number, align 4
  %28 = icmp eq i32 %26, %27
  br i1 %28, label %29, label %34

29:                                               ; preds = %24
  %p2 = call i32 (i8*, ...) @printf(i8* noundef getelementptr inbounds ([7 x i8], [7 x i8]* @.str2, i64 0, i64 0), i32* %3, i32* %18)
  %30 = getelementptr [1 x i32], [1 x i32]* @injection_array, i32 0, i32 %21
  %31 = load i32, i32* %30, align 4
  %32 = xor i32 %19, %31
  store i32 %32, i32* %3, align 4
  %33 = add i32 %21, 1
  store i32 %33, i32* @injection_index, align 4
  br label %34

34:                                               ; preds = %24, %29
  %35 = phi i32 [ %19, %24 ], [ %32, %29 ]
  br label %36

36:                                               ; preds = %0, %34
  %37 = phi i32 [ %19, %0 ], [ %35, %34 ]
  %38 = mul nsw i32 %16, %17
  store i32 %38, i32* %1, align 4
  %39 = load i32, i32* %1, align 4
  %40 = load i32, i32* %2, align 4
  %41 = load i32, i32* %3, align 4
  %42 = call i32 (i8*, ...) @printf(i8* noundef getelementptr inbounds ([10 x i8], [10 x i8]* @.str, i64 0, i64 0), i32 noundef %39, i32 noundef %40, i32 noundef %41)
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

