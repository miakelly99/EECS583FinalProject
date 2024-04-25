alloca is   %1 = alloca i32, align 4
load is   %2 = load i32, i32* %1, align 4
load is done
store is   store i32 5, i32* %1, align 4
store is done
ret is   ret i32 0
ret is done
found end of program at return node   ret i32 0
; ModuleID = 'super_simple.bc'
source_filename = "src/super_simple.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [4 x i8] c"%d\0A\00", align 1
@global_def = internal global i32 0, align 1
@global_use = internal global i32 0, align 1
@local_def = internal global i32 0, align 1
@local_use_number = internal global i32 0, align 1

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 {
  %1 = alloca i32, align 4
  store i32 5, i32* %1, align 4
  %2 = load i32, i32* @local_use_number, align 4
  %3 = load i32, i32* @local_def, align 4
  %4 = load i32, i32* @global_def, align 4
  %5 = mul i32 %3, %2
  %6 = add i32 %4, %5
  store i32 0, i32* @local_use_number, align 4
  store i32 %6, i32* @global_def, align 4
  store i32 5, i32* @local_def, align 4
  %7 = load i32, i32* %1, align 4
  %8 = load i32, i32* @local_use_number, align 4
  %9 = add i32 %8, 1
  store i32 %9, i32* @local_use_number, align 4
  %10 = load i32, i32* @global_use, align 4
  %11 = add i32 %10, %7
  store i32 %11, i32* @global_use, align 4
  %12 = call i32 (i8*, ...) @printf(i8* noundef getelementptr inbounds ([4 x i8], [4 x i8]* @.str, i64 0, i64 0), i32 noundef %7)
  %13 = load i32, i32* @local_use_number, align 4
  %14 = load i32, i32* @local_def, align 4
  %15 = load i32, i32* @global_def, align 4
  %16 = mul i32 %14, %13
  %17 = add i32 %15, %16
  store i32 0, i32* @local_use_number, align 4
  store i32 %17, i32* @global_def, align 4
  store i32 0, i32* @local_def, align 4
  %18 = load i32, i32* @global_def, align 4
  %19 = load i32, i32* @global_use, align 4
  %20 = icmp ne i32 %18, %19
  br i1 %20, label %21, label %22

21:                                               ; preds = %0
  ret i32 1

22:                                               ; preds = %0, <null operand!>
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

; ModuleID = 'super_simple.bc'
source_filename = "src/super_simple.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [4 x i8] c"%d\0A\00", align 1
@global_def = internal global i32 0, align 1
@global_use = internal global i32 0, align 1
@local_def = internal global i32 0, align 1
@local_use_number = internal global i32 0, align 1

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 {
  %1 = alloca i32, align 4
  store i32 5, i32* %1, align 4
  %2 = load i32, i32* @local_use_number, align 4
  %3 = load i32, i32* @local_def, align 4
  %4 = load i32, i32* @global_def, align 4
  %5 = mul i32 %3, %2
  %6 = add i32 %4, %5
  store i32 0, i32* @local_use_number, align 4
  store i32 %6, i32* @global_def, align 4
  store i32 5, i32* @local_def, align 4
  %7 = load i32, i32* %1, align 4
  %8 = load i32, i32* @local_use_number, align 4
  %9 = add i32 %8, 1
  store i32 %9, i32* @local_use_number, align 4
  %10 = load i32, i32* @global_use, align 4
  %11 = add i32 %10, %7
  store i32 %11, i32* @global_use, align 4
  %12 = call i32 (i8*, ...) @printf(i8* noundef getelementptr inbounds ([4 x i8], [4 x i8]* @.str, i64 0, i64 0), i32 noundef %7)
  %13 = load i32, i32* @local_use_number, align 4
  %14 = load i32, i32* @local_def, align 4
  %15 = load i32, i32* @global_def, align 4
  %16 = mul i32 %14, %13
  %17 = add i32 %15, %16
  store i32 0, i32* @local_use_number, align 4
  store i32 %17, i32* @global_def, align 4
  store i32 0, i32* @local_def, align 4
  %18 = load i32, i32* @global_def, align 4
  %19 = load i32, i32* @global_use, align 4
  %20 = icmp ne i32 %18, %19
  br i1 %20, label %21, label %22

21:                                               ; preds = %0
  ret i32 1

22:                                               ; preds = %0, <null operand!>
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

