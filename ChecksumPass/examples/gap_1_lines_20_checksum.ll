considering inst   store i32 0, i32* %1, align 4
added new load instruction   %NOP_CHECKSUM_LOAD = load i32, i32* %1, align 4
added new load instruction   %NOP_CHECKSUM_LOAD1 = load i32, i32* %1, align 4
considering inst   %128 = load i32, i32* %2, align 4
considering inst   %117 = load i32, i32* %2, align 4
considering inst   store i32 %106, i32* %2, align 4
considering inst   %101 = load i32, i32* %2, align 4
considering inst   store i32 %95, i32* %2, align 4
considering inst   %90 = load i32, i32* %2, align 4
considering inst   store i32 %84, i32* %2, align 4
considering inst   %79 = load i32, i32* %2, align 4
considering inst   store i32 %73, i32* %2, align 4
considering inst   %68 = load i32, i32* %2, align 4
considering inst   store i32 %62, i32* %2, align 4
considering inst   %57 = load i32, i32* %2, align 4
considering inst   store i32 %51, i32* %2, align 4
considering inst   %46 = load i32, i32* %2, align 4
considering inst   store i32 %40, i32* %2, align 4
considering inst   %35 = load i32, i32* %2, align 4
considering inst   store i32 %29, i32* %2, align 4
considering inst   %24 = load i32, i32* %2, align 4
considering inst   store i32 5, i32* %2, align 4
considering inst   %133 = load i32, i32* %3, align 4
considering inst   store i32 %122, i32* %3, align 4
considering inst   %112 = load i32, i32* %3, align 4
considering inst   %19 = load i32, i32* %3, align 4
added new load instruction   %NOP_CHECKSUM_LOAD2 = load i32, i32* %3, align 4
considering inst   store i32 10, i32* %3, align 4
considering inst   %NOP_CHECKSUM_LOAD1 = load i32, i32* %1, align 4
considering inst   %NOP_CHECKSUM_LOAD = load i32, i32* %1, align 4
added new load instruction   %NOP_CHECKSUM_LOAD3 = load i32, i32* %1, align 4
considering inst   store i32 0, i32* %1, align 4
added new load instruction   %NOP_CHECKSUM_LOAD4 = load i32, i32* %1, align 4
considering inst   %240 = load i32, i32* %2, align 4
considering inst   %220 = load i32, i32* %2, align 4
considering inst   store i32 %200, i32* %2, align 4
considering inst   %191 = load i32, i32* %2, align 4
considering inst   store i32 %180, i32* %2, align 4
considering inst   %171 = load i32, i32* %2, align 4
considering inst   store i32 %160, i32* %2, align 4
considering inst   %147 = load i32, i32* %2, align 4
considering inst   store i32 %136, i32* %2, align 4
considering inst   %127 = load i32, i32* %2, align 4
considering inst   store i32 %112, i32* %2, align 4
considering inst   %103 = load i32, i32* %2, align 4
considering inst   store i32 %92, i32* %2, align 4
considering inst   %83 = load i32, i32* %2, align 4
considering inst   store i32 %72, i32* %2, align 4
considering inst   %63 = load i32, i32* %2, align 4
considering inst   store i32 %52, i32* %2, align 4
considering inst   %43 = load i32, i32* %2, align 4
considering inst   store i32 5, i32* %2, align 4
considering inst   %NOP_CHECKSUM_LOAD2 = load i32, i32* %3, align 4
considering inst   %253 = load i32, i32* %3, align 4
considering inst   store i32 %229, i32* %3, align 4
considering inst   %211 = load i32, i32* %3, align 4
considering inst   %34 = load i32, i32* %3, align 4
added new load instruction   %NOP_CHECKSUM_LOAD5 = load i32, i32* %3, align 4
considering inst   store i32 10, i32* %3, align 4
; ModuleID = 'gap_1_lines_20.bc'
source_filename = "src/gap_1_lines_20.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [7 x i8] c"%d\0A%d\0A\00", align 1
@global_def = internal global i32 0, align 1
@global_use = internal global i32 0, align 1
@local_def = internal global i32 0, align 1
@local_use_number = internal global i32 0, align 1
@local_def.1 = internal global i32 0, align 1
@local_use_number.2 = internal global i32 0, align 1
@local_def.3 = internal global i32 0, align 1
@local_use_number.4 = internal global i32 0, align 1

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  store i32 0, i32* %1, align 4
  %4 = load i32, i32* @local_use_number, align 4
  %5 = load i32, i32* @local_def, align 4
  %6 = load i32, i32* @global_def, align 4
  %7 = mul i32 %5, %4
  %8 = add i32 %6, %7
  store i32 0, i32* @local_use_number, align 4
  store i32 %8, i32* @global_def, align 4
  store i32 0, i32* @local_def, align 4
  %9 = load i32, i32* @local_use_number, align 4
  %10 = load i32, i32* @local_def, align 4
  %11 = load i32, i32* @global_def, align 4
  %12 = mul i32 %10, %9
  %13 = add i32 %11, %12
  store i32 0, i32* @local_use_number, align 4
  store i32 %13, i32* @global_def, align 4
  store i32 0, i32* @local_def, align 4
  store i32 5, i32* %2, align 4
  %14 = load i32, i32* @local_use_number.2, align 4
  %15 = load i32, i32* @local_def.1, align 4
  %16 = load i32, i32* @global_def, align 4
  %17 = mul i32 %15, %14
  %18 = add i32 %16, %17
  store i32 0, i32* @local_use_number.2, align 4
  store i32 %18, i32* @global_def, align 4
  store i32 5, i32* @local_def.1, align 4
  %19 = load i32, i32* @local_use_number.2, align 4
  %20 = load i32, i32* @local_def.1, align 4
  %21 = load i32, i32* @global_def, align 4
  %22 = mul i32 %20, %19
  %23 = add i32 %21, %22
  store i32 0, i32* @local_use_number.2, align 4
  store i32 %23, i32* @global_def, align 4
  store i32 5, i32* @local_def.1, align 4
  store i32 10, i32* %3, align 4
  %24 = load i32, i32* @local_use_number.4, align 4
  %25 = load i32, i32* @local_def.3, align 4
  %26 = load i32, i32* @global_def, align 4
  %27 = mul i32 %25, %24
  %28 = add i32 %26, %27
  store i32 0, i32* @local_use_number.4, align 4
  store i32 %28, i32* @global_def, align 4
  store i32 10, i32* @local_def.3, align 4
  %29 = load i32, i32* @local_use_number.4, align 4
  %30 = load i32, i32* @local_def.3, align 4
  %31 = load i32, i32* @global_def, align 4
  %32 = mul i32 %30, %29
  %33 = add i32 %31, %32
  store i32 0, i32* @local_use_number.4, align 4
  store i32 %33, i32* @global_def, align 4
  store i32 10, i32* @local_def.3, align 4
  %34 = load i32, i32* %3, align 4
  %35 = load i32, i32* @local_use_number.4, align 4
  %36 = add i32 %35, 1
  store i32 %36, i32* @local_use_number.4, align 4
  %37 = load i32, i32* @global_use, align 4
  %38 = add i32 %37, %34
  store i32 %38, i32* @global_use, align 4
  %39 = load i32, i32* @local_use_number.4, align 4
  %40 = add i32 %39, 1
  store i32 %40, i32* @local_use_number.4, align 4
  %41 = load i32, i32* @global_use, align 4
  %42 = add i32 %41, %34
  store i32 %42, i32* @global_use, align 4
  %43 = load i32, i32* %2, align 4
  %44 = load i32, i32* @local_use_number.2, align 4
  %45 = add i32 %44, 1
  store i32 %45, i32* @local_use_number.2, align 4
  %46 = load i32, i32* @global_use, align 4
  %47 = add i32 %46, %43
  store i32 %47, i32* @global_use, align 4
  %48 = load i32, i32* @local_use_number.2, align 4
  %49 = add i32 %48, 1
  store i32 %49, i32* @local_use_number.2, align 4
  %50 = load i32, i32* @global_use, align 4
  %51 = add i32 %50, %43
  store i32 %51, i32* @global_use, align 4
  %52 = sub nsw i32 %34, %43
  store i32 %52, i32* %2, align 4
  %53 = load i32, i32* @local_use_number.2, align 4
  %54 = load i32, i32* @local_def.1, align 4
  %55 = load i32, i32* @global_def, align 4
  %56 = mul i32 %54, %53
  %57 = add i32 %55, %56
  store i32 0, i32* @local_use_number.2, align 4
  store i32 %57, i32* @global_def, align 4
  store i32 %52, i32* @local_def.1, align 4
  %58 = load i32, i32* @local_use_number.2, align 4
  %59 = load i32, i32* @local_def.1, align 4
  %60 = load i32, i32* @global_def, align 4
  %61 = mul i32 %59, %58
  %62 = add i32 %60, %61
  store i32 0, i32* @local_use_number.2, align 4
  store i32 %62, i32* @global_def, align 4
  store i32 %52, i32* @local_def.1, align 4
  %63 = load i32, i32* %2, align 4
  %64 = load i32, i32* @local_use_number.2, align 4
  %65 = add i32 %64, 1
  store i32 %65, i32* @local_use_number.2, align 4
  %66 = load i32, i32* @global_use, align 4
  %NOP_CHECKSUM_LOAD4 = load i32, i32* %1, align 4
  %67 = add i32 %66, %63
  store i32 %67, i32* @global_use, align 4
  %68 = load i32, i32* @local_use_number.2, align 4
  %69 = add i32 %68, 1
  store i32 %69, i32* @local_use_number.2, align 4
  %70 = load i32, i32* @global_use, align 4
  %71 = add i32 %70, %63
  store i32 %71, i32* @global_use, align 4
  %72 = add nsw i32 %63, 1
  store i32 %72, i32* %2, align 4
  %73 = load i32, i32* @local_use_number.2, align 4
  %74 = load i32, i32* @local_def.1, align 4
  %75 = load i32, i32* @global_def, align 4
  %76 = mul i32 %74, %73
  %77 = add i32 %75, %76
  store i32 0, i32* @local_use_number.2, align 4
  store i32 %77, i32* @global_def, align 4
  store i32 %72, i32* @local_def.1, align 4
  %78 = load i32, i32* @local_use_number.2, align 4
  %79 = load i32, i32* @local_def.1, align 4
  %80 = load i32, i32* @global_def, align 4
  %81 = mul i32 %79, %78
  %82 = add i32 %80, %81
  store i32 0, i32* @local_use_number.2, align 4
  store i32 %82, i32* @global_def, align 4
  store i32 %72, i32* @local_def.1, align 4
  %83 = load i32, i32* %2, align 4
  %84 = load i32, i32* @local_use_number.2, align 4
  %85 = add i32 %84, 1
  store i32 %85, i32* @local_use_number.2, align 4
  %86 = load i32, i32* @global_use, align 4
  %87 = add i32 %86, %83
  store i32 %87, i32* @global_use, align 4
  %88 = load i32, i32* @local_use_number.2, align 4
  %89 = add i32 %88, 1
  store i32 %89, i32* @local_use_number.2, align 4
  %90 = load i32, i32* @global_use, align 4
  %91 = add i32 %90, %83
  store i32 %91, i32* @global_use, align 4
  %92 = add nsw i32 %83, 2
  store i32 %92, i32* %2, align 4
  %93 = load i32, i32* @local_use_number.2, align 4
  %94 = load i32, i32* @local_def.1, align 4
  %95 = load i32, i32* @global_def, align 4
  %96 = mul i32 %94, %93
  %97 = add i32 %95, %96
  store i32 0, i32* @local_use_number.2, align 4
  store i32 %97, i32* @global_def, align 4
  store i32 %92, i32* @local_def.1, align 4
  %98 = load i32, i32* @local_use_number.2, align 4
  %NOP_CHECKSUM_LOAD5 = load i32, i32* %3, align 4
  %99 = load i32, i32* @local_def.1, align 4
  %100 = load i32, i32* @global_def, align 4
  %101 = mul i32 %99, %98
  %102 = add i32 %100, %101
  store i32 0, i32* @local_use_number.2, align 4
  store i32 %102, i32* @global_def, align 4
  store i32 %92, i32* @local_def.1, align 4
  %103 = load i32, i32* %2, align 4
  %104 = load i32, i32* @local_use_number.2, align 4
  %105 = add i32 %104, 1
  store i32 %105, i32* @local_use_number.2, align 4
  %106 = load i32, i32* @global_use, align 4
  %107 = add i32 %106, %103
  store i32 %107, i32* @global_use, align 4
  %108 = load i32, i32* @local_use_number.2, align 4
  %109 = add i32 %108, 1
  store i32 %109, i32* @local_use_number.2, align 4
  %110 = load i32, i32* @global_use, align 4
  %111 = add i32 %110, %103
  store i32 %111, i32* @global_use, align 4
  %112 = add nsw i32 %103, 3
  store i32 %112, i32* %2, align 4
  %113 = load i32, i32* @local_use_number.2, align 4
  %114 = load i32, i32* @local_def.1, align 4
  %115 = load i32, i32* @global_def, align 4
  %116 = mul i32 %114, %113
  %117 = add i32 %115, %116
  store i32 0, i32* @local_use_number.2, align 4
  store i32 %117, i32* @global_def, align 4
  store i32 %112, i32* @local_def.1, align 4
  %118 = load i32, i32* @local_use_number.2, align 4
  %119 = load i32, i32* @local_def.1, align 4
  %120 = load i32, i32* @global_def, align 4
  %121 = mul i32 %119, %118
  %122 = add i32 %120, %121
  store i32 0, i32* @local_use_number.2, align 4
  %NOP_CHECKSUM_LOAD = load i32, i32* %1, align 4
  %123 = load i32, i32* @local_use_number, align 4
  %124 = add i32 %123, 1
  store i32 %124, i32* @local_use_number, align 4
  %125 = load i32, i32* @global_use, align 4
  %126 = add i32 %125, %NOP_CHECKSUM_LOAD
  store i32 %126, i32* @global_use, align 4
  store i32 %122, i32* @global_def, align 4
  store i32 %112, i32* @local_def.1, align 4
  %127 = load i32, i32* %2, align 4
  %128 = load i32, i32* @local_use_number.2, align 4
  %129 = add i32 %128, 1
  store i32 %129, i32* @local_use_number.2, align 4
  %130 = load i32, i32* @global_use, align 4
  %131 = add i32 %130, %127
  store i32 %131, i32* @global_use, align 4
  %132 = load i32, i32* @local_use_number.2, align 4
  %133 = add i32 %132, 1
  store i32 %133, i32* @local_use_number.2, align 4
  %134 = load i32, i32* @global_use, align 4
  %135 = add i32 %134, %127
  store i32 %135, i32* @global_use, align 4
  %136 = add nsw i32 %127, 4
  store i32 %136, i32* %2, align 4
  %137 = load i32, i32* @local_use_number.2, align 4
  %138 = load i32, i32* @local_def.1, align 4
  %139 = load i32, i32* @global_def, align 4
  %140 = mul i32 %138, %137
  %141 = add i32 %139, %140
  store i32 0, i32* @local_use_number.2, align 4
  store i32 %141, i32* @global_def, align 4
  store i32 %136, i32* @local_def.1, align 4
  %142 = load i32, i32* @local_use_number.2, align 4
  %143 = load i32, i32* @local_def.1, align 4
  %144 = load i32, i32* @global_def, align 4
  %145 = mul i32 %143, %142
  %146 = add i32 %144, %145
  store i32 0, i32* @local_use_number.2, align 4
  store i32 %146, i32* @global_def, align 4
  store i32 %136, i32* @local_def.1, align 4
  %147 = load i32, i32* %2, align 4
  %148 = load i32, i32* @local_use_number.2, align 4
  %149 = add i32 %148, 1
  store i32 %149, i32* @local_use_number.2, align 4
  %150 = load i32, i32* @global_use, align 4
  %151 = add i32 %150, %147
  store i32 %151, i32* @global_use, align 4
  %152 = load i32, i32* @local_use_number.2, align 4
  %153 = add i32 %152, 1
  store i32 %153, i32* @local_use_number.2, align 4
  %154 = load i32, i32* @global_use, align 4
  %155 = add i32 %154, %147
  store i32 %155, i32* @global_use, align 4
  %NOP_CHECKSUM_LOAD2 = load i32, i32* %3, align 4
  %156 = load i32, i32* @local_use_number.4, align 4
  %157 = add i32 %156, 1
  store i32 %157, i32* @local_use_number.4, align 4
  %158 = load i32, i32* @global_use, align 4
  %159 = add i32 %158, %NOP_CHECKSUM_LOAD2
  store i32 %159, i32* @global_use, align 4
  %160 = add nsw i32 %147, 5
  store i32 %160, i32* %2, align 4
  %161 = load i32, i32* @local_use_number.2, align 4
  %162 = load i32, i32* @local_def.1, align 4
  %163 = load i32, i32* @global_def, align 4
  %164 = mul i32 %162, %161
  %165 = add i32 %163, %164
  store i32 0, i32* @local_use_number.2, align 4
  store i32 %165, i32* @global_def, align 4
  store i32 %160, i32* @local_def.1, align 4
  %166 = load i32, i32* @local_use_number.2, align 4
  %167 = load i32, i32* @local_def.1, align 4
  %168 = load i32, i32* @global_def, align 4
  %169 = mul i32 %167, %166
  %170 = add i32 %168, %169
  store i32 0, i32* @local_use_number.2, align 4
  store i32 %170, i32* @global_def, align 4
  store i32 %160, i32* @local_def.1, align 4
  %171 = load i32, i32* %2, align 4
  %172 = load i32, i32* @local_use_number.2, align 4
  %173 = add i32 %172, 1
  store i32 %173, i32* @local_use_number.2, align 4
  %174 = load i32, i32* @global_use, align 4
  %175 = add i32 %174, %171
  store i32 %175, i32* @global_use, align 4
  %176 = load i32, i32* @local_use_number.2, align 4
  %177 = add i32 %176, 1
  store i32 %177, i32* @local_use_number.2, align 4
  %178 = load i32, i32* @global_use, align 4
  %179 = add i32 %178, %171
  store i32 %179, i32* @global_use, align 4
  %180 = add nsw i32 %171, 6
  store i32 %180, i32* %2, align 4
  %181 = load i32, i32* @local_use_number.2, align 4
  %182 = load i32, i32* @local_def.1, align 4
  %183 = load i32, i32* @global_def, align 4
  %184 = mul i32 %182, %181
  %185 = add i32 %183, %184
  store i32 0, i32* @local_use_number.2, align 4
  store i32 %185, i32* @global_def, align 4
  %NOP_CHECKSUM_LOAD3 = load i32, i32* %1, align 4
  store i32 %180, i32* @local_def.1, align 4
  %186 = load i32, i32* @local_use_number.2, align 4
  %187 = load i32, i32* @local_def.1, align 4
  %188 = load i32, i32* @global_def, align 4
  %189 = mul i32 %187, %186
  %190 = add i32 %188, %189
  store i32 0, i32* @local_use_number.2, align 4
  store i32 %190, i32* @global_def, align 4
  store i32 %180, i32* @local_def.1, align 4
  %191 = load i32, i32* %2, align 4
  %192 = load i32, i32* @local_use_number.2, align 4
  %193 = add i32 %192, 1
  store i32 %193, i32* @local_use_number.2, align 4
  %194 = load i32, i32* @global_use, align 4
  %195 = add i32 %194, %191
  store i32 %195, i32* @global_use, align 4
  %196 = load i32, i32* @local_use_number.2, align 4
  %197 = add i32 %196, 1
  store i32 %197, i32* @local_use_number.2, align 4
  %198 = load i32, i32* @global_use, align 4
  %199 = add i32 %198, %191
  store i32 %199, i32* @global_use, align 4
  %200 = add nsw i32 %191, 7
  store i32 %200, i32* %2, align 4
  %201 = load i32, i32* @local_use_number.2, align 4
  %202 = load i32, i32* @local_def.1, align 4
  %203 = load i32, i32* @global_def, align 4
  %204 = mul i32 %202, %201
  %205 = add i32 %203, %204
  store i32 0, i32* @local_use_number.2, align 4
  store i32 %205, i32* @global_def, align 4
  store i32 %200, i32* @local_def.1, align 4
  %206 = load i32, i32* @local_use_number.2, align 4
  %207 = load i32, i32* @local_def.1, align 4
  %208 = load i32, i32* @global_def, align 4
  %209 = mul i32 %207, %206
  %210 = add i32 %208, %209
  store i32 0, i32* @local_use_number.2, align 4
  store i32 %210, i32* @global_def, align 4
  store i32 %200, i32* @local_def.1, align 4
  %211 = load i32, i32* %3, align 4
  %212 = load i32, i32* @local_use_number.4, align 4
  %213 = add i32 %212, 1
  store i32 %213, i32* @local_use_number.4, align 4
  %214 = load i32, i32* @global_use, align 4
  %215 = add i32 %214, %211
  store i32 %215, i32* @global_use, align 4
  %216 = load i32, i32* @local_use_number.4, align 4
  %217 = add i32 %216, 1
  store i32 %217, i32* @local_use_number.4, align 4
  %218 = load i32, i32* @global_use, align 4
  %219 = add i32 %218, %211
  store i32 %219, i32* @global_use, align 4
  %220 = load i32, i32* %2, align 4
  %221 = load i32, i32* @local_use_number.2, align 4
  %222 = add i32 %221, 1
  store i32 %222, i32* @local_use_number.2, align 4
  %223 = load i32, i32* @global_use, align 4
  %224 = add i32 %223, %220
  store i32 %224, i32* @global_use, align 4
  %225 = load i32, i32* @local_use_number.2, align 4
  %226 = add i32 %225, 1
  store i32 %226, i32* @local_use_number.2, align 4
  %227 = load i32, i32* @global_use, align 4
  %228 = add i32 %227, %220
  store i32 %228, i32* @global_use, align 4
  %229 = mul nsw i32 %211, %220
  store i32 %229, i32* %3, align 4
  %230 = load i32, i32* @local_use_number.4, align 4
  %231 = load i32, i32* @local_def.3, align 4
  %232 = load i32, i32* @global_def, align 4
  %233 = mul i32 %231, %230
  %234 = add i32 %232, %233
  store i32 0, i32* @local_use_number.4, align 4
  store i32 %234, i32* @global_def, align 4
  store i32 %229, i32* @local_def.3, align 4
  %235 = load i32, i32* @local_use_number.4, align 4
  %236 = load i32, i32* @local_def.3, align 4
  %237 = load i32, i32* @global_def, align 4
  %238 = mul i32 %236, %235
  %239 = add i32 %237, %238
  store i32 0, i32* @local_use_number.4, align 4
  store i32 %239, i32* @global_def, align 4
  store i32 %229, i32* @local_def.3, align 4
  %240 = load i32, i32* %2, align 4
  %241 = load i32, i32* @local_use_number.2, align 4
  %242 = add i32 %241, 1
  store i32 %242, i32* @local_use_number.2, align 4
  %243 = load i32, i32* @global_use, align 4
  %244 = add i32 %243, %240
  store i32 %244, i32* @global_use, align 4
  %245 = load i32, i32* @local_use_number.2, align 4
  %246 = add i32 %245, 1
  store i32 %246, i32* @local_use_number.2, align 4
  %247 = load i32, i32* @global_use, align 4
  %NOP_CHECKSUM_LOAD1 = load i32, i32* %1, align 4
  %248 = load i32, i32* @local_use_number, align 4
  %249 = add i32 %248, 1
  store i32 %249, i32* @local_use_number, align 4
  %250 = load i32, i32* @global_use, align 4
  %251 = add i32 %250, %NOP_CHECKSUM_LOAD1
  store i32 %251, i32* @global_use, align 4
  %252 = add i32 %247, %240
  store i32 %252, i32* @global_use, align 4
  %253 = load i32, i32* %3, align 4
  %254 = load i32, i32* @local_use_number.4, align 4
  %255 = add i32 %254, 1
  store i32 %255, i32* @local_use_number.4, align 4
  %256 = load i32, i32* @global_use, align 4
  %257 = add i32 %256, %253
  store i32 %257, i32* @global_use, align 4
  %258 = load i32, i32* @local_use_number.4, align 4
  %259 = add i32 %258, 1
  store i32 %259, i32* @local_use_number.4, align 4
  %260 = load i32, i32* @global_use, align 4
  %261 = add i32 %260, %253
  store i32 %261, i32* @global_use, align 4
  %262 = call i32 (i8*, ...) @printf(i8* noundef getelementptr inbounds ([7 x i8], [7 x i8]* @.str, i64 0, i64 0), i32 noundef %240, i32 noundef %253)
  %263 = load i32, i32* @local_use_number, align 4
  %264 = load i32, i32* @local_def, align 4
  %265 = load i32, i32* @global_def, align 4
  %266 = mul i32 %264, %263
  %267 = add i32 %265, %266
  store i32 0, i32* @local_use_number, align 4
  store i32 %267, i32* @global_def, align 4
  store i32 0, i32* @local_def, align 4
  %268 = load i32, i32* @local_use_number.2, align 4
  %269 = load i32, i32* @local_def.1, align 4
  %270 = load i32, i32* @global_def, align 4
  %271 = mul i32 %269, %268
  %272 = add i32 %270, %271
  store i32 0, i32* @local_use_number.2, align 4
  store i32 %272, i32* @global_def, align 4
  store i32 0, i32* @local_def.1, align 4
  %273 = load i32, i32* @local_use_number.4, align 4
  %274 = load i32, i32* @local_def.3, align 4
  %275 = load i32, i32* @global_def, align 4
  %276 = mul i32 %274, %273
  %277 = add i32 %275, %276
  store i32 0, i32* @local_use_number.4, align 4
  store i32 %277, i32* @global_def, align 4
  store i32 0, i32* @local_def.3, align 4
  %278 = load i32, i32* @global_def, align 4
  %279 = load i32, i32* @global_use, align 4
  %280 = icmp ne i32 %278, %279
  br i1 %280, label %281, label %282

281:                                              ; preds = %0
  ret i32 1

282:                                              ; preds = %0, <null operand!>
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

