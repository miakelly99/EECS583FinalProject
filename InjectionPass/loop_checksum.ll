; ModuleID = 'loop.bc'
source_filename = "src/loop.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@I_MAX = dso_local constant i32 100000, align 4
@.str = private unnamed_addr constant [11 x i8] c"Sum is %d\0A\00", align 1
@global_def = internal global i32 0, align 1
@global_use = internal global i32 0, align 1
@local_def = internal global i32 0, align 1
@local_use_number = internal global i32 0, align 1
@local_def.1 = internal global i32 0, align 1
@local_use_number.2 = internal global i32 0, align 1
@local_def.3 = internal global i32 0, align 1
@local_use_number.4 = internal global i32 0, align 1
@local_def.5 = internal global i32 0, align 1
@local_use_number.6 = internal global i32 0, align 1

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i32 0, i32* %1, align 4
  %5 = load i32, i32* @local_use_number, align 4
  %6 = load i32, i32* @local_def, align 4
  %7 = load i32, i32* @global_def, align 4
  %8 = mul i32 %6, %5
  %9 = add i32 %7, %8
  store i32 0, i32* @local_use_number, align 4
  store i32 %9, i32* @global_def, align 4
  store i32 0, i32* @local_def, align 4
  store i32 0, i32* %4, align 4
  %10 = load i32, i32* @local_use_number.6, align 4
  %11 = load i32, i32* @local_def.5, align 4
  %12 = load i32, i32* @global_def, align 4
  %13 = mul i32 %11, %10
  %14 = add i32 %12, %13
  store i32 0, i32* @local_use_number.6, align 4
  store i32 %14, i32* @global_def, align 4
  store i32 0, i32* @local_def.5, align 4
  store i32 1, i32* %2, align 4
  %15 = load i32, i32* @local_use_number.2, align 4
  %16 = load i32, i32* @local_def.1, align 4
  %17 = load i32, i32* @global_def, align 4
  %18 = mul i32 %16, %15
  %19 = add i32 %17, %18
  store i32 0, i32* @local_use_number.2, align 4
  store i32 %19, i32* @global_def, align 4
  store i32 1, i32* @local_def.1, align 4
  br label %20

20:                                               ; preds = %81, %0
  %21 = load i32, i32* %2, align 4
  %22 = load i32, i32* @local_use_number.2, align 4
  %23 = add i32 %22, 1
  store i32 %23, i32* @local_use_number.2, align 4
  %24 = load i32, i32* @global_use, align 4
  %25 = add i32 %24, %21
  store i32 %25, i32* @global_use, align 4
  %26 = icmp sle i32 %21, 100000
  br i1 %26, label %27, label %93

27:                                               ; preds = %20
  store i32 1, i32* %3, align 4
  %28 = load i32, i32* @local_use_number.4, align 4
  %29 = load i32, i32* @local_def.3, align 4
  %30 = load i32, i32* @global_def, align 4
  %31 = mul i32 %29, %28
  %32 = add i32 %30, %31
  store i32 0, i32* @local_use_number.4, align 4
  store i32 %32, i32* @global_def, align 4
  store i32 1, i32* @local_def.3, align 4
  br label %33

33:                                               ; preds = %68, %27
  %34 = load i32, i32* %3, align 4
  %35 = load i32, i32* @local_use_number.4, align 4
  %36 = add i32 %35, 1
  store i32 %36, i32* @local_use_number.4, align 4
  %37 = load i32, i32* @global_use, align 4
  %38 = add i32 %37, %34
  store i32 %38, i32* @global_use, align 4
  %39 = load i32, i32* %2, align 4
  %40 = load i32, i32* @local_use_number.2, align 4
  %41 = add i32 %40, 1
  store i32 %41, i32* @local_use_number.2, align 4
  %42 = load i32, i32* @global_use, align 4
  %43 = add i32 %42, %39
  store i32 %43, i32* @global_use, align 4
  %44 = icmp sle i32 %34, %39
  br i1 %44, label %45, label %80

45:                                               ; preds = %33
  %46 = load i32, i32* %2, align 4
  %47 = load i32, i32* @local_use_number.2, align 4
  %48 = add i32 %47, 1
  store i32 %48, i32* @local_use_number.2, align 4
  %49 = load i32, i32* @global_use, align 4
  %50 = add i32 %49, %46
  store i32 %50, i32* @global_use, align 4
  %51 = load i32, i32* %3, align 4
  %52 = load i32, i32* @local_use_number.4, align 4
  %53 = add i32 %52, 1
  store i32 %53, i32* @local_use_number.4, align 4
  %54 = load i32, i32* @global_use, align 4
  %55 = add i32 %54, %51
  store i32 %55, i32* @global_use, align 4
  %56 = sdiv i32 %46, %51
  %57 = load i32, i32* %4, align 4
  %58 = load i32, i32* @local_use_number.6, align 4
  %59 = add i32 %58, 1
  store i32 %59, i32* @local_use_number.6, align 4
  %60 = load i32, i32* @global_use, align 4
  %61 = add i32 %60, %57
  store i32 %61, i32* @global_use, align 4
  %62 = add nsw i32 %57, %56
  store i32 %62, i32* %4, align 4
  %63 = load i32, i32* @local_use_number.6, align 4
  %64 = load i32, i32* @local_def.5, align 4
  %65 = load i32, i32* @global_def, align 4
  %66 = mul i32 %64, %63
  %67 = add i32 %65, %66
  store i32 0, i32* @local_use_number.6, align 4
  store i32 %67, i32* @global_def, align 4
  store i32 %62, i32* @local_def.5, align 4
  br label %68

68:                                               ; preds = %45
  %69 = load i32, i32* %3, align 4
  %70 = load i32, i32* @local_use_number.4, align 4
  %71 = add i32 %70, 1
  store i32 %71, i32* @local_use_number.4, align 4
  %72 = load i32, i32* @global_use, align 4
  %73 = add i32 %72, %69
  store i32 %73, i32* @global_use, align 4
  %74 = add nsw i32 %69, 1
  store i32 %74, i32* %3, align 4
  %75 = load i32, i32* @local_use_number.4, align 4
  %76 = load i32, i32* @local_def.3, align 4
  %77 = load i32, i32* @global_def, align 4
  %78 = mul i32 %76, %75
  %79 = add i32 %77, %78
  store i32 0, i32* @local_use_number.4, align 4
  store i32 %79, i32* @global_def, align 4
  store i32 %74, i32* @local_def.3, align 4
  br label %33, !llvm.loop !6

80:                                               ; preds = %33
  br label %81

81:                                               ; preds = %80
  %82 = load i32, i32* %2, align 4
  %83 = load i32, i32* @local_use_number.2, align 4
  %84 = add i32 %83, 1
  store i32 %84, i32* @local_use_number.2, align 4
  %85 = load i32, i32* @global_use, align 4
  %86 = add i32 %85, %82
  store i32 %86, i32* @global_use, align 4
  %87 = add nsw i32 %82, 1
  store i32 %87, i32* %2, align 4
  %88 = load i32, i32* @local_use_number.2, align 4
  %89 = load i32, i32* @local_def.1, align 4
  %90 = load i32, i32* @global_def, align 4
  %91 = mul i32 %89, %88
  %92 = add i32 %90, %91
  store i32 0, i32* @local_use_number.2, align 4
  store i32 %92, i32* @global_def, align 4
  store i32 %87, i32* @local_def.1, align 4
  br label %20, !llvm.loop !8

93:                                               ; preds = %20
  %94 = load i32, i32* %4, align 4
  %95 = load i32, i32* @local_use_number.6, align 4
  %96 = add i32 %95, 1
  store i32 %96, i32* @local_use_number.6, align 4
  %97 = load i32, i32* @global_use, align 4
  %98 = add i32 %97, %94
  store i32 %98, i32* @global_use, align 4
  %99 = call i32 (i8*, ...) @printf(i8* noundef getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i64 0, i64 0), i32 noundef %94)
  %100 = load i32, i32* @local_use_number, align 4
  %101 = load i32, i32* @local_def, align 4
  %102 = load i32, i32* @global_def, align 4
  %103 = mul i32 %101, %100
  %104 = add i32 %102, %103
  store i32 0, i32* @local_use_number, align 4
  store i32 %104, i32* @global_def, align 4
  store i32 0, i32* @local_def, align 4
  %105 = load i32, i32* @local_use_number.2, align 4
  %106 = load i32, i32* @local_def.1, align 4
  %107 = load i32, i32* @global_def, align 4
  %108 = mul i32 %106, %105
  %109 = add i32 %107, %108
  store i32 0, i32* @local_use_number.2, align 4
  store i32 %109, i32* @global_def, align 4
  store i32 0, i32* @local_def.1, align 4
  %110 = load i32, i32* @local_use_number.4, align 4
  %111 = load i32, i32* @local_def.3, align 4
  %112 = load i32, i32* @global_def, align 4
  %113 = mul i32 %111, %110
  %114 = add i32 %112, %113
  store i32 0, i32* @local_use_number.4, align 4
  store i32 %114, i32* @global_def, align 4
  store i32 0, i32* @local_def.3, align 4
  %115 = load i32, i32* @local_use_number.6, align 4
  %116 = load i32, i32* @local_def.5, align 4
  %117 = load i32, i32* @global_def, align 4
  %118 = mul i32 %116, %115
  %119 = add i32 %117, %118
  store i32 0, i32* @local_use_number.6, align 4
  store i32 %119, i32* @global_def, align 4
  store i32 0, i32* @local_def.5, align 4
  %120 = load i32, i32* @global_def, align 4
  %121 = load i32, i32* @global_use, align 4
  %122 = icmp ne i32 %120, %121
  br i1 %122, label %123, label %124

123:                                              ; preds = %93
  ret i32 1

124:                                              ; preds = %93, <null operand!>
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

; ModuleID = 'loop.bc'
source_filename = "src/loop.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@I_MAX = dso_local constant i32 100000, align 4
@.str = private unnamed_addr constant [11 x i8] c"Sum is %d\0A\00", align 1
@global_def = internal global i32 0, align 1
@global_use = internal global i32 0, align 1
@local_def = internal global i32 0, align 1
@local_use_number = internal global i32 0, align 1
@local_def.1 = internal global i32 0, align 1
@local_use_number.2 = internal global i32 0, align 1
@local_def.3 = internal global i32 0, align 1
@local_use_number.4 = internal global i32 0, align 1
@local_def.5 = internal global i32 0, align 1
@local_use_number.6 = internal global i32 0, align 1

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i32 0, i32* %1, align 4
  %5 = load i32, i32* @local_use_number, align 4
  %6 = load i32, i32* @local_def, align 4
  %7 = load i32, i32* @global_def, align 4
  %8 = mul i32 %6, %5
  %9 = add i32 %7, %8
  store i32 0, i32* @local_use_number, align 4
  store i32 %9, i32* @global_def, align 4
  store i32 0, i32* @local_def, align 4
  store i32 0, i32* %4, align 4
  %10 = load i32, i32* @local_use_number.6, align 4
  %11 = load i32, i32* @local_def.5, align 4
  %12 = load i32, i32* @global_def, align 4
  %13 = mul i32 %11, %10
  %14 = add i32 %12, %13
  store i32 0, i32* @local_use_number.6, align 4
  store i32 %14, i32* @global_def, align 4
  store i32 0, i32* @local_def.5, align 4
  store i32 1, i32* %2, align 4
  %15 = load i32, i32* @local_use_number.2, align 4
  %16 = load i32, i32* @local_def.1, align 4
  %17 = load i32, i32* @global_def, align 4
  %18 = mul i32 %16, %15
  %19 = add i32 %17, %18
  store i32 0, i32* @local_use_number.2, align 4
  store i32 %19, i32* @global_def, align 4
  store i32 1, i32* @local_def.1, align 4
  br label %20

20:                                               ; preds = %81, %0
  %21 = load i32, i32* %2, align 4
  %22 = load i32, i32* @local_use_number.2, align 4
  %23 = add i32 %22, 1
  store i32 %23, i32* @local_use_number.2, align 4
  %24 = load i32, i32* @global_use, align 4
  %25 = add i32 %24, %21
  store i32 %25, i32* @global_use, align 4
  %26 = icmp sle i32 %21, 100000
  br i1 %26, label %27, label %93

27:                                               ; preds = %20
  store i32 1, i32* %3, align 4
  %28 = load i32, i32* @local_use_number.4, align 4
  %29 = load i32, i32* @local_def.3, align 4
  %30 = load i32, i32* @global_def, align 4
  %31 = mul i32 %29, %28
  %32 = add i32 %30, %31
  store i32 0, i32* @local_use_number.4, align 4
  store i32 %32, i32* @global_def, align 4
  store i32 1, i32* @local_def.3, align 4
  br label %33

33:                                               ; preds = %68, %27
  %34 = load i32, i32* %3, align 4
  %35 = load i32, i32* @local_use_number.4, align 4
  %36 = add i32 %35, 1
  store i32 %36, i32* @local_use_number.4, align 4
  %37 = load i32, i32* @global_use, align 4
  %38 = add i32 %37, %34
  store i32 %38, i32* @global_use, align 4
  %39 = load i32, i32* %2, align 4
  %40 = load i32, i32* @local_use_number.2, align 4
  %41 = add i32 %40, 1
  store i32 %41, i32* @local_use_number.2, align 4
  %42 = load i32, i32* @global_use, align 4
  %43 = add i32 %42, %39
  store i32 %43, i32* @global_use, align 4
  %44 = icmp sle i32 %34, %39
  br i1 %44, label %45, label %80

45:                                               ; preds = %33
  %46 = load i32, i32* %2, align 4
  %47 = load i32, i32* @local_use_number.2, align 4
  %48 = add i32 %47, 1
  store i32 %48, i32* @local_use_number.2, align 4
  %49 = load i32, i32* @global_use, align 4
  %50 = add i32 %49, %46
  store i32 %50, i32* @global_use, align 4
  %51 = load i32, i32* %3, align 4
  %52 = load i32, i32* @local_use_number.4, align 4
  %53 = add i32 %52, 1
  store i32 %53, i32* @local_use_number.4, align 4
  %54 = load i32, i32* @global_use, align 4
  %55 = add i32 %54, %51
  store i32 %55, i32* @global_use, align 4
  %56 = sdiv i32 %46, %51
  %57 = load i32, i32* %4, align 4
  %58 = load i32, i32* @local_use_number.6, align 4
  %59 = add i32 %58, 1
  store i32 %59, i32* @local_use_number.6, align 4
  %60 = load i32, i32* @global_use, align 4
  %61 = add i32 %60, %57
  store i32 %61, i32* @global_use, align 4
  %62 = add nsw i32 %57, %56
  store i32 %62, i32* %4, align 4
  %63 = load i32, i32* @local_use_number.6, align 4
  %64 = load i32, i32* @local_def.5, align 4
  %65 = load i32, i32* @global_def, align 4
  %66 = mul i32 %64, %63
  %67 = add i32 %65, %66
  store i32 0, i32* @local_use_number.6, align 4
  store i32 %67, i32* @global_def, align 4
  store i32 %62, i32* @local_def.5, align 4
  br label %68

68:                                               ; preds = %45
  %69 = load i32, i32* %3, align 4
  %70 = load i32, i32* @local_use_number.4, align 4
  %71 = add i32 %70, 1
  store i32 %71, i32* @local_use_number.4, align 4
  %72 = load i32, i32* @global_use, align 4
  %73 = add i32 %72, %69
  store i32 %73, i32* @global_use, align 4
  %74 = add nsw i32 %69, 1
  store i32 %74, i32* %3, align 4
  %75 = load i32, i32* @local_use_number.4, align 4
  %76 = load i32, i32* @local_def.3, align 4
  %77 = load i32, i32* @global_def, align 4
  %78 = mul i32 %76, %75
  %79 = add i32 %77, %78
  store i32 0, i32* @local_use_number.4, align 4
  store i32 %79, i32* @global_def, align 4
  store i32 %74, i32* @local_def.3, align 4
  br label %33, !llvm.loop !6

80:                                               ; preds = %33
  br label %81

81:                                               ; preds = %80
  %82 = load i32, i32* %2, align 4
  %83 = load i32, i32* @local_use_number.2, align 4
  %84 = add i32 %83, 1
  store i32 %84, i32* @local_use_number.2, align 4
  %85 = load i32, i32* @global_use, align 4
  %86 = add i32 %85, %82
  store i32 %86, i32* @global_use, align 4
  %87 = add nsw i32 %82, 1
  store i32 %87, i32* %2, align 4
  %88 = load i32, i32* @local_use_number.2, align 4
  %89 = load i32, i32* @local_def.1, align 4
  %90 = load i32, i32* @global_def, align 4
  %91 = mul i32 %89, %88
  %92 = add i32 %90, %91
  store i32 0, i32* @local_use_number.2, align 4
  store i32 %92, i32* @global_def, align 4
  store i32 %87, i32* @local_def.1, align 4
  br label %20, !llvm.loop !8

93:                                               ; preds = %20
  %94 = load i32, i32* %4, align 4
  %95 = load i32, i32* @local_use_number.6, align 4
  %96 = add i32 %95, 1
  store i32 %96, i32* @local_use_number.6, align 4
  %97 = load i32, i32* @global_use, align 4
  %98 = add i32 %97, %94
  store i32 %98, i32* @global_use, align 4
  %99 = call i32 (i8*, ...) @printf(i8* noundef getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i64 0, i64 0), i32 noundef %94)
  %100 = load i32, i32* @local_use_number, align 4
  %101 = load i32, i32* @local_def, align 4
  %102 = load i32, i32* @global_def, align 4
  %103 = mul i32 %101, %100
  %104 = add i32 %102, %103
  store i32 0, i32* @local_use_number, align 4
  store i32 %104, i32* @global_def, align 4
  store i32 0, i32* @local_def, align 4
  %105 = load i32, i32* @local_use_number.2, align 4
  %106 = load i32, i32* @local_def.1, align 4
  %107 = load i32, i32* @global_def, align 4
  %108 = mul i32 %106, %105
  %109 = add i32 %107, %108
  store i32 0, i32* @local_use_number.2, align 4
  store i32 %109, i32* @global_def, align 4
  store i32 0, i32* @local_def.1, align 4
  %110 = load i32, i32* @local_use_number.4, align 4
  %111 = load i32, i32* @local_def.3, align 4
  %112 = load i32, i32* @global_def, align 4
  %113 = mul i32 %111, %110
  %114 = add i32 %112, %113
  store i32 0, i32* @local_use_number.4, align 4
  store i32 %114, i32* @global_def, align 4
  store i32 0, i32* @local_def.3, align 4
  %115 = load i32, i32* @local_use_number.6, align 4
  %116 = load i32, i32* @local_def.5, align 4
  %117 = load i32, i32* @global_def, align 4
  %118 = mul i32 %116, %115
  %119 = add i32 %117, %118
  store i32 0, i32* @local_use_number.6, align 4
  store i32 %119, i32* @global_def, align 4
  store i32 0, i32* @local_def.5, align 4
  %120 = load i32, i32* @global_def, align 4
  %121 = load i32, i32* @global_use, align 4
  %122 = icmp ne i32 %120, %121
  br i1 %122, label %123, label %124

123:                                              ; preds = %93
  ret i32 1

124:                                              ; preds = %93, <null operand!>
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

