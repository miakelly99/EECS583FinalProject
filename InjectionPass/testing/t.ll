; ModuleID = 'bc/simple_checksum.bc'
source_filename = "src/simple.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [10 x i8] c"%d\0A%d\0A%d\0A\00", align 1
@.str2 = private unnamed_addr constant [7 x i8] c"%p\0A%p\0A\00", align 1
@global_def = internal global i32 0, align 1
@global_use = internal global i32 0, align 1
@local_def = internal global i32 0, align 1
@local_use_number = internal global i32 0, align 1
@local_def.1 = internal global i32 0, align 1
@local_use_number.2 = internal global i32 0, align 1
@local_def.3 = internal global i32 0, align 1
@local_use_number.4 = internal global i32 0, align 1
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
  %4 = load i32, i32* @local_use_number, align 4
  %5 = load i32, i32* @local_def, align 4
  %6 = load i32, i32* @global_def, align 4
  %7 = mul i32 %5, %4
  %8 = add i32 %6, %7
  store i32 0, i32* @local_use_number, align 4
  store i32 %8, i32* @global_def, align 4
  store i32 5, i32* @local_def, align 4
  store i32 7, i32* %2, align 4
  %9 = load i32, i32* @local_use_number.2, align 4
  %10 = load i32, i32* @local_def.1, align 4
  %11 = load i32, i32* @global_def, align 4
  %12 = mul i32 %10, %9
  %13 = add i32 %11, %12
  store i32 0, i32* @local_use_number.2, align 4
  store i32 %13, i32* @global_def, align 4
  store i32 7, i32* @local_def.1, align 4
  store i32 10, i32* %3, align 4
  %14 = load i32, i32* @local_use_number.4, align 4
  %15 = load i32, i32* @local_def.3, align 4
  %16 = load i32, i32* @global_def, align 4
  %17 = mul i32 %15, %14
  %18 = add i32 %16, %17
  store i32 0, i32* @local_use_number.4, align 4
  store i32 %18, i32* @global_def, align 4
  store i32 10, i32* @local_def.3, align 4
  %19 = load i32, i32* %2, align 4
  %20 = load i32, i32* @local_use_number.2, align 4
  store volatile i32* @local_use_number.2, i32** @remote_injection_ptr, align 8
  %21 = add i32 %20, 1
  store i32 %21, i32* @local_use_number.2, align 4
  %22 = load i32, i32* @global_use, align 4
  %23 = add i32 %22, %19
  store i32 %23, i32* @global_use, align 4
  %24 = load i32, i32* %1, align 4
  %25 = load i32, i32* @local_use_number, align 4
  %26 = add i32 %25, 1
  store i32 %26, i32* @local_use_number, align 4
  %27 = load i32, i32* @global_use, align 4
  %28 = add i32 %27, %24
  store i32 %28, i32* @global_use, align 4
  %29 = add nsw i32 %19, %24
  store i32 %29, i32* %1, align 4
  %30 = load i32, i32* @local_use_number, align 4
  %31 = load i32, i32* @local_def, align 4
  %32 = load i32, i32* @global_def, align 4
  %33 = mul i32 %31, %30
  %34 = add i32 %32, %33
  store i32 0, i32* @local_use_number, align 4
  store i32 %34, i32* @global_def, align 4
  store i32 %29, i32* @local_def, align 4
  %35 = load i32, i32* %3, align 4
  %36 = load i32, i32* @local_use_number.4, align 4
  %37 = add i32 %36, 1
  store i32 %37, i32* @local_use_number.4, align 4
  %38 = load i32, i32* @global_use, align 4
  %39 = add i32 %38, %35
  store i32 %39, i32* @global_use, align 4
  %40 = load i32, i32* %1, align 4
  %41 = load i32, i32* @local_use_number, align 4
  %42 = add i32 %41, 1
  store i32 %42, i32* @local_use_number, align 4
  %43 = load i32, i32* @global_use, align 4
  %44 = add i32 %43, %40
  store i32 %44, i32* @global_use, align 4
  %45 = mul nsw i32 %35, %40
  store i32 %45, i32* %2, align 4
  %46 = load i32, i32* @local_use_number.2, align 4
  %47 = load i32, i32* @local_def.1, align 4
  %48 = load i32, i32* @global_def, align 4
  %49 = mul i32 %47, %46
  %50 = add i32 %48, %49
  store i32 0, i32* @local_use_number.2, align 4
  %51 = load i32*, i32** @remote_injection_ptr, align 8
  %52 = load i32, i32* %51, align 4
  %53 = load i32, i32* @iteration_number, align 4
  %54 = load i32, i32* @injection_index, align 4
  %55 = load i32, i32* @injection_index_max, align 4
  %56 = icmp slt i32 %54, %55
  br i1 %56, label %57, label %69

57:                                               ; preds = %0
  %58 = getelementptr [1 x i32], [1 x i32]* @iteration_number_array, i32 0, i32 %54
  %59 = load i32, i32* %58, align 4
  %60 = add i32 %53, 1
  store i32 %60, i32* @iteration_number, align 4
  %61 = icmp eq i32 %59, %60
  br i1 %61, label %62, label %67

62:                                               ; preds = %57
  %63 = getelementptr [1 x i32], [1 x i32]* @injection_array, i32 0, i32 %54
  %64 = load i32, i32* %63, align 4
  %65 = xor i32 %52, %64
  store i32 %65, i32* %51, align 4
  %66 = add i32 %54, 1
  store i32 %66, i32* @injection_index, align 4
  %p1 = call i32 (i8*, ...) @printf(i8* noundef getelementptr inbounds ([7 x i8], [7 x i8]* @.str2, i64 0, i64 0), i32* noundef %3, i32* noundef %51)
  br label %67

67:                                               ; preds = %57, %62
  %68 = phi i32 [ %52, %57 ], [ %65, %62 ]
  br label %69

69:                                               ; preds = %0, %67
  %70 = phi i32 [ %52, %0 ], [ %68, %67 ]
  store i32 %50, i32* @global_def, align 4
  store i32 %45, i32* @local_def.1, align 4
  %71 = load i32, i32* %2, align 4
  %72 = load i32, i32* @local_use_number.2, align 4
  %73 = add i32 %72, 1
  store i32 %73, i32* @local_use_number.2, align 4
  %74 = load i32, i32* @global_use, align 4
  %75 = add i32 %74, %71
  store i32 %75, i32* @global_use, align 4
  %76 = load i32, i32* %1, align 4
  %77 = load i32, i32* @local_use_number, align 4
  %78 = add i32 %77, 1
  store i32 %78, i32* @local_use_number, align 4
  %79 = load i32, i32* @global_use, align 4
  %80 = add i32 %79, %76
  store i32 %80, i32* @global_use, align 4
  %81 = sub nsw i32 %71, %76
  store i32 %81, i32* %3, align 4
  %82 = load i32, i32* @local_use_number.4, align 4
  %83 = load i32, i32* @local_def.3, align 4
  %84 = load i32, i32* @global_def, align 4
  %85 = mul i32 %83, %82
  %86 = add i32 %84, %85
  store i32 0, i32* @local_use_number.4, align 4
  store i32 %86, i32* @global_def, align 4
  store i32 %81, i32* @local_def.3, align 4
  %87 = load i32, i32* %2, align 4
  %88 = load i32, i32* @local_use_number.2, align 4
  %89 = add i32 %88, 1
  store i32 %89, i32* @local_use_number.2, align 4
  %90 = load i32, i32* @global_use, align 4
  %91 = add i32 %90, %87
  store i32 %91, i32* @global_use, align 4
  %92 = load i32, i32* %1, align 4
  %93 = load i32, i32* @local_use_number, align 4
  %94 = add i32 %93, 1
  store i32 %94, i32* @local_use_number, align 4
  %95 = load i32, i32* @global_use, align 4
  %96 = add i32 %95, %92
  store i32 %96, i32* @global_use, align 4
  %97 = sdiv i32 %87, %92
  store i32 %97, i32* %2, align 4
  %98 = load i32, i32* @local_use_number.2, align 4
  %99 = load i32, i32* @local_def.1, align 4
  %100 = load i32, i32* @global_def, align 4
  %101 = mul i32 %99, %98
  %102 = add i32 %100, %101
  store i32 0, i32* @local_use_number.2, align 4
  store i32 %102, i32* @global_def, align 4
  store i32 %97, i32* @local_def.1, align 4
  %103 = load i32, i32* %1, align 4
  %104 = load i32, i32* @local_use_number, align 4
  %105 = add i32 %104, 1
  store i32 %105, i32* @local_use_number, align 4
  %106 = load i32, i32* @global_use, align 4
  %107 = add i32 %106, %103
  store i32 %107, i32* @global_use, align 4
  %108 = load i32, i32* %1, align 4
  %109 = load i32, i32* @local_use_number, align 4
  %110 = add i32 %109, 1
  store i32 %110, i32* @local_use_number, align 4
  %111 = load i32, i32* @global_use, align 4
  %112 = add i32 %111, %108
  store i32 %112, i32* @global_use, align 4
  %113 = mul nsw i32 %103, %108
  store i32 %113, i32* %1, align 4
  %114 = load i32, i32* @local_use_number, align 4
  %115 = load i32, i32* @local_def, align 4
  %116 = load i32, i32* @global_def, align 4
  %117 = mul i32 %115, %114
  %118 = add i32 %116, %117
  store i32 0, i32* @local_use_number, align 4
  store i32 %118, i32* @global_def, align 4
  store i32 %113, i32* @local_def, align 4
  %119 = load i32, i32* %1, align 4
  %120 = load i32, i32* @local_use_number, align 4
  %121 = add i32 %120, 1
  store i32 %121, i32* @local_use_number, align 4
  %122 = load i32, i32* @global_use, align 4
  %123 = add i32 %122, %119
  store i32 %123, i32* @global_use, align 4
  %124 = load i32, i32* %2, align 4
  %125 = load i32, i32* @local_use_number.2, align 4
  %126 = add i32 %125, 1
  store i32 %126, i32* @local_use_number.2, align 4
  %127 = load i32, i32* @global_use, align 4
  %128 = add i32 %127, %124
  store i32 %128, i32* @global_use, align 4
  %129 = load i32, i32* %3, align 4
  %130 = load i32, i32* @local_use_number.4, align 4
  %131 = add i32 %130, 1
  store i32 %131, i32* @local_use_number.4, align 4
  %132 = load i32, i32* @global_use, align 4
  %133 = add i32 %132, %129
  store i32 %133, i32* @global_use, align 4
  %134 = call i32 (i8*, ...) @printf(i8* noundef getelementptr inbounds ([10 x i8], [10 x i8]* @.str, i64 0, i64 0), i32 noundef %119, i32 noundef %124, i32 noundef %129)
  %135 = load i32, i32* @local_use_number, align 4
  %136 = load i32, i32* @local_def, align 4
  %137 = load i32, i32* @global_def, align 4
  %138 = mul i32 %136, %135
  %139 = add i32 %137, %138
  store i32 0, i32* @local_use_number, align 4
  store i32 %139, i32* @global_def, align 4
  store i32 0, i32* @local_def, align 4
  %140 = load i32, i32* @local_use_number.2, align 4
  %141 = load i32, i32* @local_def.1, align 4
  %142 = load i32, i32* @global_def, align 4
  %143 = mul i32 %141, %140
  %144 = add i32 %142, %143
  store i32 0, i32* @local_use_number.2, align 4
  store i32 %144, i32* @global_def, align 4
  store i32 0, i32* @local_def.1, align 4
  %145 = load i32, i32* @local_use_number.4, align 4
  %146 = load i32, i32* @local_def.3, align 4
  %147 = load i32, i32* @global_def, align 4
  %148 = mul i32 %146, %145
  %149 = add i32 %147, %148
  store i32 0, i32* @local_use_number.4, align 4
  store i32 %149, i32* @global_def, align 4
  store i32 0, i32* @local_def.3, align 4
  %150 = load i32, i32* @global_def, align 4
  %151 = load i32, i32* @global_use, align 4
  %152 = icmp ne i32 %150, %151
  br i1 %152, label %153, label %154

153:                                              ; preds = %69
  ret i32 1

154:                                              ; preds = %69
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

