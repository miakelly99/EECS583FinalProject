; ModuleID = 'bc/super_simple_checksum.bc'
source_filename = "src/super_simple.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [4 x i8] c"%d\0A\00", align 1
@global_def = internal global i32 0, align 1
@global_use = internal global i32 0, align 1
@local_def = internal global i32 0, align 1
@local_use_number = internal global i32 0, align 1
@iteration_number = internal global i32 0, align 1
@injection_index = internal global i32 0, align 1
@injection_index_max = internal global i32 1, align 1
@iteration_number_array = internal global [1 x i32] [i32 1], align 1
@injection_array = internal global [1 x i32] [i32 1], align 1

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 {
  %1 = alloca i32, align 4 ; x
  store i32 5, i32* %1, align 4 ; 5 in x
  %2 = load i32, i32* @local_use_number, align 4 ; 0
  %3 = load i32, i32* @local_def, align 4 ; 0
  %4 = load i32, i32* @iteration_number, align 4 ; 0
  %5 = load i32, i32* @injection_index, align 4 ; 0
  %6 = load i32, i32* @injection_index_max, align 4 ; 1
  %7 = icmp slt i32 %5, %6 ; 0 < 1 ==> true
  br i1 %7, label %8, label %20 ; branch to %8

8:                                                ; preds = %0
  %9 = getelementptr [1 x i32], [1 x i32]* @iteration_number_array, i32 0, i32 %5 ; load iteration number from array
  %10 = load i32, i32* %9, align 4 ; 1
  %11 = add i32 %4, 1 ; 1
  store i32 %11, i32* @iteration_number, align 4 ; 1 in @iteration_number
  %12 = icmp eq i32 %10, %11 ; true
  br i1 %12, label %13, label %18 ; branch to 13

13:                                               ; preds = %8
  %14 = getelementptr [1 x i32], [1 x i32]* @injection_array, i32 0, i32 %5 ; load injection number from array
  %15 = load i32, i32* %14, align 4
  %16 = xor i32 %3, %15
  store i32 %16, i32* @local_def, align 4
  %17 = add i32 %5, 1
  store i32 %17, i32* @injection_index, align 4
  br label %18

18:                                               ; preds = %8, %13
  %19 = phi i32 [ %3, %8 ], [ %16, %13 ]
  br label %20

20:                                               ; preds = %0, %18
  %21 = phi i32 [ %3, %0 ], [ %19, %18 ]
  %22 = load i32, i32* @global_def, align 4
  %23 = mul i32 %21, %2
  %24 = add i32 %22, %23
  store i32 0, i32* @local_use_number, align 4
  store i32 %24, i32* @global_def, align 4
  store i32 5, i32* @local_def, align 4
  %25 = load i32, i32* %1, align 4
  %26 = load i32, i32* @local_use_number, align 4
  %27 = add i32 %26, 1
  store i32 %27, i32* @local_use_number, align 4
  %28 = load i32, i32* @global_use, align 4
  %29 = add i32 %28, %25
  store i32 %29, i32* @global_use, align 4
  %30 = call i32 (i8*, ...) @printf(i8* noundef getelementptr inbounds ([4 x i8], [4 x i8]* @.str, i64 0, i64 0), i32 noundef %25)
  %31 = load i32, i32* @local_use_number, align 4
  %32 = load i32, i32* @local_def, align 4
  %33 = load i32, i32* @global_def, align 4
  %34 = mul i32 %32, %31
  %35 = add i32 %33, %34
  store i32 0, i32* @local_use_number, align 4
  store i32 %35, i32* @global_def, align 4
  store i32 0, i32* @local_def, align 4
  %36 = load i32, i32* @global_def, align 4
  %37 = load i32, i32* @global_use, align 4
  %38 = icmp ne i32 %36, %37
  br i1 %38, label %39, label %40

39:                                               ; preds = %20
  ret i32 1

40:                                               ; preds = %20
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

