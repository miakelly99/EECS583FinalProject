; ModuleID = 'gap.bc'
source_filename = "src/gap.c"
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
  %NOP_CHECKSUM_LOAD = load i32, i32* %1, align 4
  %34 = load i32, i32* @local_use_number, align 4
  %35 = add i32 %34, 1
  store i32 %35, i32* @local_use_number, align 4
  %36 = load i32, i32* @global_use, align 4
  %37 = add i32 %36, %NOP_CHECKSUM_LOAD
  store i32 %37, i32* @global_use, align 4
  %38 = load i32, i32* @local_use_number, align 4
  %39 = add i32 %38, 1
  store i32 %39, i32* @local_use_number, align 4
  %40 = load i32, i32* @global_use, align 4
  %41 = add i32 %40, %NOP_CHECKSUM_LOAD
  store i32 %41, i32* @global_use, align 4
  %NOP_CHECKSUM_LOAD10 = load i32, i32* %2, align 4
  %42 = load i32, i32* @local_use_number.2, align 4
  %43 = add i32 %42, 1
  store i32 %43, i32* @local_use_number.2, align 4
  %44 = load i32, i32* @global_use, align 4
  %45 = add i32 %44, %NOP_CHECKSUM_LOAD10
  store i32 %45, i32* @global_use, align 4
  %46 = load i32, i32* @local_use_number.2, align 4
  %47 = add i32 %46, 1
  store i32 %47, i32* @local_use_number.2, align 4
  %48 = load i32, i32* @global_use, align 4
  %49 = add i32 %48, %NOP_CHECKSUM_LOAD10
  store i32 %49, i32* @global_use, align 4
  %NOP_CHECKSUM_LOAD14 = load i32, i32* %3, align 4
  %50 = load i32, i32* @local_use_number.4, align 4
  %51 = add i32 %50, 1
  store i32 %51, i32* @local_use_number.4, align 4
  %52 = load i32, i32* @global_use, align 4
  %53 = add i32 %52, %NOP_CHECKSUM_LOAD14
  store i32 %53, i32* @global_use, align 4
  %54 = load i32, i32* @local_use_number.4, align 4
  %55 = add i32 %54, 1
  store i32 %55, i32* @local_use_number.4, align 4
  %56 = load i32, i32* @global_use, align 4
  %57 = add i32 %56, %NOP_CHECKSUM_LOAD14
  store i32 %57, i32* @global_use, align 4
  %58 = load i32, i32* %3, align 4
  %59 = load i32, i32* @local_use_number.4, align 4
  %60 = add i32 %59, 1
  store i32 %60, i32* @local_use_number.4, align 4
  %61 = load i32, i32* @global_use, align 4
  %62 = add i32 %61, %58
  store i32 %62, i32* @global_use, align 4
  %63 = load i32, i32* @local_use_number.4, align 4
  %64 = add i32 %63, 1
  store i32 %64, i32* @local_use_number.4, align 4
  %65 = load i32, i32* @global_use, align 4
  %66 = add i32 %65, %58
  store i32 %66, i32* @global_use, align 4
  %67 = load i32, i32* %2, align 4
  %68 = load i32, i32* @local_use_number.2, align 4
  %69 = add i32 %68, 1
  store i32 %69, i32* @local_use_number.2, align 4
  %70 = load i32, i32* @global_use, align 4
  %71 = add i32 %70, %67
  store i32 %71, i32* @global_use, align 4
  %72 = load i32, i32* @local_use_number.2, align 4
  %73 = add i32 %72, 1
  store i32 %73, i32* @local_use_number.2, align 4
  %74 = load i32, i32* @global_use, align 4
  %75 = add i32 %74, %67
  store i32 %75, i32* @global_use, align 4
  %76 = sub nsw i32 %58, %67
  store i32 %76, i32* %2, align 4
  %77 = load i32, i32* @local_use_number.2, align 4
  %78 = load i32, i32* @local_def.1, align 4
  %79 = load i32, i32* @global_def, align 4
  %80 = mul i32 %78, %77
  %81 = add i32 %79, %80
  store i32 0, i32* @local_use_number.2, align 4
  store i32 %81, i32* @global_def, align 4
  store i32 %76, i32* @local_def.1, align 4
  %82 = load i32, i32* @local_use_number.2, align 4
  %83 = load i32, i32* @local_def.1, align 4
  %84 = load i32, i32* @global_def, align 4
  %85 = mul i32 %83, %82
  %86 = add i32 %84, %85
  store i32 0, i32* @local_use_number.2, align 4
  store i32 %86, i32* @global_def, align 4
  store i32 %76, i32* @local_def.1, align 4
  %NOP_CHECKSUM_LOAD23 = load i32, i32* %3, align 4
  %87 = load i32, i32* @local_use_number.4, align 4
  %88 = add i32 %87, 1
  store i32 %88, i32* @local_use_number.4, align 4
  %89 = load i32, i32* @global_use, align 4
  %90 = add i32 %89, %NOP_CHECKSUM_LOAD23
  store i32 %90, i32* @global_use, align 4
  %91 = load i32, i32* @local_use_number.4, align 4
  %92 = add i32 %91, 1
  store i32 %92, i32* @local_use_number.4, align 4
  %93 = load i32, i32* @global_use, align 4
  %94 = add i32 %93, %NOP_CHECKSUM_LOAD23
  store i32 %94, i32* @global_use, align 4
  %NOP_CHECKSUM_LOAD15 = load i32, i32* %3, align 4
  %95 = load i32, i32* @local_use_number.4, align 4
  %96 = add i32 %95, 1
  store i32 %96, i32* @local_use_number.4, align 4
  %97 = load i32, i32* @global_use, align 4
  %98 = add i32 %97, %NOP_CHECKSUM_LOAD15
  store i32 %98, i32* @global_use, align 4
  %99 = load i32, i32* @local_use_number.4, align 4
  %100 = add i32 %99, 1
  store i32 %100, i32* @local_use_number.4, align 4
  %101 = load i32, i32* @global_use, align 4
  %102 = add i32 %101, %NOP_CHECKSUM_LOAD15
  store i32 %102, i32* @global_use, align 4
  %NOP_CHECKSUM_LOAD1 = load i32, i32* %1, align 4
  %103 = load i32, i32* @local_use_number, align 4
  %104 = add i32 %103, 1
  store i32 %104, i32* @local_use_number, align 4
  %105 = load i32, i32* @global_use, align 4
  %106 = add i32 %105, %NOP_CHECKSUM_LOAD1
  store i32 %106, i32* @global_use, align 4
  %107 = load i32, i32* @local_use_number, align 4
  %108 = add i32 %107, 1
  store i32 %108, i32* @local_use_number, align 4
  %109 = load i32, i32* @global_use, align 4
  %110 = add i32 %109, %NOP_CHECKSUM_LOAD1
  store i32 %110, i32* @global_use, align 4
  %111 = load i32, i32* %2, align 4
  %112 = load i32, i32* @local_use_number.2, align 4
  %113 = add i32 %112, 1
  store i32 %113, i32* @local_use_number.2, align 4
  %114 = load i32, i32* @global_use, align 4
  %115 = add i32 %114, %111
  store i32 %115, i32* @global_use, align 4
  %116 = load i32, i32* @local_use_number.2, align 4
  %117 = add i32 %116, 1
  store i32 %117, i32* @local_use_number.2, align 4
  %118 = load i32, i32* @global_use, align 4
  %119 = add i32 %118, %111
  store i32 %119, i32* @global_use, align 4
  %NOP_CHECKSUM_LOAD24 = load i32, i32* %3, align 4
  %120 = load i32, i32* @local_use_number.4, align 4
  %121 = add i32 %120, 1
  store i32 %121, i32* @local_use_number.4, align 4
  %122 = load i32, i32* @global_use, align 4
  %123 = add i32 %122, %NOP_CHECKSUM_LOAD24
  store i32 %123, i32* @global_use, align 4
  %124 = load i32, i32* @local_use_number.4, align 4
  %125 = add i32 %124, 1
  store i32 %125, i32* @local_use_number.4, align 4
  %126 = load i32, i32* @global_use, align 4
  %127 = add i32 %126, %NOP_CHECKSUM_LOAD24
  store i32 %127, i32* @global_use, align 4
  %128 = add nsw i32 %111, 1
  store i32 %128, i32* %2, align 4
  %129 = load i32, i32* @local_use_number.2, align 4
  %130 = load i32, i32* @local_def.1, align 4
  %131 = load i32, i32* @global_def, align 4
  %132 = mul i32 %130, %129
  %133 = add i32 %131, %132
  store i32 0, i32* @local_use_number.2, align 4
  store i32 %133, i32* @global_def, align 4
  store i32 %128, i32* @local_def.1, align 4
  %134 = load i32, i32* @local_use_number.2, align 4
  %135 = load i32, i32* @local_def.1, align 4
  %136 = load i32, i32* @global_def, align 4
  %137 = mul i32 %135, %134
  %138 = add i32 %136, %137
  store i32 0, i32* @local_use_number.2, align 4
  store i32 %138, i32* @global_def, align 4
  store i32 %128, i32* @local_def.1, align 4
  %NOP_CHECKSUM_LOAD16 = load i32, i32* %3, align 4
  %139 = load i32, i32* @local_use_number.4, align 4
  %140 = add i32 %139, 1
  store i32 %140, i32* @local_use_number.4, align 4
  %141 = load i32, i32* @global_use, align 4
  %142 = add i32 %141, %NOP_CHECKSUM_LOAD16
  store i32 %142, i32* @global_use, align 4
  %143 = load i32, i32* @local_use_number.4, align 4
  %144 = add i32 %143, 1
  store i32 %144, i32* @local_use_number.4, align 4
  %145 = load i32, i32* @global_use, align 4
  %146 = add i32 %145, %NOP_CHECKSUM_LOAD16
  store i32 %146, i32* @global_use, align 4
  %NOP_CHECKSUM_LOAD2 = load i32, i32* %1, align 4
  %147 = load i32, i32* @local_use_number, align 4
  %148 = add i32 %147, 1
  store i32 %148, i32* @local_use_number, align 4
  %149 = load i32, i32* @global_use, align 4
  %150 = add i32 %149, %NOP_CHECKSUM_LOAD2
  store i32 %150, i32* @global_use, align 4
  %151 = load i32, i32* @local_use_number, align 4
  %152 = add i32 %151, 1
  store i32 %152, i32* @local_use_number, align 4
  %153 = load i32, i32* @global_use, align 4
  %154 = add i32 %153, %NOP_CHECKSUM_LOAD2
  store i32 %154, i32* @global_use, align 4
  %155 = load i32, i32* %2, align 4
  %156 = load i32, i32* @local_use_number.2, align 4
  %157 = add i32 %156, 1
  store i32 %157, i32* @local_use_number.2, align 4
  %158 = load i32, i32* @global_use, align 4
  %159 = add i32 %158, %155
  store i32 %159, i32* @global_use, align 4
  %160 = load i32, i32* @local_use_number.2, align 4
  %161 = add i32 %160, 1
  store i32 %161, i32* @local_use_number.2, align 4
  %162 = load i32, i32* @global_use, align 4
  %163 = add i32 %162, %155
  store i32 %163, i32* @global_use, align 4
  %164 = add nsw i32 %155, 2
  store i32 %164, i32* %2, align 4
  %165 = load i32, i32* @local_use_number.2, align 4
  %166 = load i32, i32* @local_def.1, align 4
  %167 = load i32, i32* @global_def, align 4
  %168 = mul i32 %166, %165
  %169 = add i32 %167, %168
  store i32 0, i32* @local_use_number.2, align 4
  store i32 %169, i32* @global_def, align 4
  store i32 %164, i32* @local_def.1, align 4
  %170 = load i32, i32* @local_use_number.2, align 4
  %171 = load i32, i32* @local_def.1, align 4
  %172 = load i32, i32* @global_def, align 4
  %173 = mul i32 %171, %170
  %174 = add i32 %172, %173
  store i32 0, i32* @local_use_number.2, align 4
  store i32 %174, i32* @global_def, align 4
  store i32 %164, i32* @local_def.1, align 4
  %NOP_CHECKSUM_LOAD17 = load i32, i32* %3, align 4
  %175 = load i32, i32* @local_use_number.4, align 4
  %176 = add i32 %175, 1
  store i32 %176, i32* @local_use_number.4, align 4
  %177 = load i32, i32* @global_use, align 4
  %178 = add i32 %177, %NOP_CHECKSUM_LOAD17
  store i32 %178, i32* @global_use, align 4
  %179 = load i32, i32* @local_use_number.4, align 4
  %180 = add i32 %179, 1
  store i32 %180, i32* @local_use_number.4, align 4
  %181 = load i32, i32* @global_use, align 4
  %182 = add i32 %181, %NOP_CHECKSUM_LOAD17
  store i32 %182, i32* @global_use, align 4
  %NOP_CHECKSUM_LOAD3 = load i32, i32* %1, align 4
  %183 = load i32, i32* @local_use_number, align 4
  %184 = add i32 %183, 1
  store i32 %184, i32* @local_use_number, align 4
  %185 = load i32, i32* @global_use, align 4
  %186 = add i32 %185, %NOP_CHECKSUM_LOAD3
  store i32 %186, i32* @global_use, align 4
  %187 = load i32, i32* @local_use_number, align 4
  %188 = add i32 %187, 1
  store i32 %188, i32* @local_use_number, align 4
  %189 = load i32, i32* @global_use, align 4
  %190 = add i32 %189, %NOP_CHECKSUM_LOAD3
  store i32 %190, i32* @global_use, align 4
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
  %200 = add nsw i32 %191, 3
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
  %NOP_CHECKSUM_LOAD18 = load i32, i32* %3, align 4
  %211 = load i32, i32* @local_use_number.4, align 4
  %212 = add i32 %211, 1
  store i32 %212, i32* @local_use_number.4, align 4
  %213 = load i32, i32* @global_use, align 4
  %214 = add i32 %213, %NOP_CHECKSUM_LOAD18
  store i32 %214, i32* @global_use, align 4
  %215 = load i32, i32* @local_use_number.4, align 4
  %216 = add i32 %215, 1
  store i32 %216, i32* @local_use_number.4, align 4
  %217 = load i32, i32* @global_use, align 4
  %218 = add i32 %217, %NOP_CHECKSUM_LOAD18
  store i32 %218, i32* @global_use, align 4
  %NOP_CHECKSUM_LOAD4 = load i32, i32* %1, align 4
  %219 = load i32, i32* @local_use_number, align 4
  %220 = add i32 %219, 1
  store i32 %220, i32* @local_use_number, align 4
  %221 = load i32, i32* @global_use, align 4
  %222 = add i32 %221, %NOP_CHECKSUM_LOAD4
  store i32 %222, i32* @global_use, align 4
  %223 = load i32, i32* @local_use_number, align 4
  %224 = add i32 %223, 1
  store i32 %224, i32* @local_use_number, align 4
  %225 = load i32, i32* @global_use, align 4
  %226 = add i32 %225, %NOP_CHECKSUM_LOAD4
  store i32 %226, i32* @global_use, align 4
  %227 = load i32, i32* %2, align 4
  %228 = load i32, i32* @local_use_number.2, align 4
  %229 = add i32 %228, 1
  store i32 %229, i32* @local_use_number.2, align 4
  %230 = load i32, i32* @global_use, align 4
  %231 = add i32 %230, %227
  store i32 %231, i32* @global_use, align 4
  %232 = load i32, i32* @local_use_number.2, align 4
  %233 = add i32 %232, 1
  store i32 %233, i32* @local_use_number.2, align 4
  %234 = load i32, i32* @global_use, align 4
  %235 = add i32 %234, %227
  store i32 %235, i32* @global_use, align 4
  %236 = add nsw i32 %227, 4
  store i32 %236, i32* %2, align 4
  %237 = load i32, i32* @local_use_number.2, align 4
  %238 = load i32, i32* @local_def.1, align 4
  %239 = load i32, i32* @global_def, align 4
  %240 = mul i32 %238, %237
  %241 = add i32 %239, %240
  store i32 0, i32* @local_use_number.2, align 4
  store i32 %241, i32* @global_def, align 4
  store i32 %236, i32* @local_def.1, align 4
  %242 = load i32, i32* @local_use_number.2, align 4
  %243 = load i32, i32* @local_def.1, align 4
  %244 = load i32, i32* @global_def, align 4
  %245 = mul i32 %243, %242
  %246 = add i32 %244, %245
  store i32 0, i32* @local_use_number.2, align 4
  store i32 %246, i32* @global_def, align 4
  store i32 %236, i32* @local_def.1, align 4
  %NOP_CHECKSUM_LOAD19 = load i32, i32* %3, align 4
  %247 = load i32, i32* @local_use_number.4, align 4
  %248 = add i32 %247, 1
  store i32 %248, i32* @local_use_number.4, align 4
  %249 = load i32, i32* @global_use, align 4
  %250 = add i32 %249, %NOP_CHECKSUM_LOAD19
  store i32 %250, i32* @global_use, align 4
  %251 = load i32, i32* @local_use_number.4, align 4
  %252 = add i32 %251, 1
  store i32 %252, i32* @local_use_number.4, align 4
  %253 = load i32, i32* @global_use, align 4
  %254 = add i32 %253, %NOP_CHECKSUM_LOAD19
  store i32 %254, i32* @global_use, align 4
  %NOP_CHECKSUM_LOAD5 = load i32, i32* %1, align 4
  %255 = load i32, i32* @local_use_number, align 4
  %256 = add i32 %255, 1
  store i32 %256, i32* @local_use_number, align 4
  %257 = load i32, i32* @global_use, align 4
  %258 = add i32 %257, %NOP_CHECKSUM_LOAD5
  store i32 %258, i32* @global_use, align 4
  %259 = load i32, i32* @local_use_number, align 4
  %260 = add i32 %259, 1
  store i32 %260, i32* @local_use_number, align 4
  %261 = load i32, i32* @global_use, align 4
  %262 = add i32 %261, %NOP_CHECKSUM_LOAD5
  store i32 %262, i32* @global_use, align 4
  %263 = load i32, i32* %2, align 4
  %264 = load i32, i32* @local_use_number.2, align 4
  %265 = add i32 %264, 1
  store i32 %265, i32* @local_use_number.2, align 4
  %266 = load i32, i32* @global_use, align 4
  %267 = add i32 %266, %263
  store i32 %267, i32* @global_use, align 4
  %268 = load i32, i32* @local_use_number.2, align 4
  %269 = add i32 %268, 1
  store i32 %269, i32* @local_use_number.2, align 4
  %270 = load i32, i32* @global_use, align 4
  %271 = add i32 %270, %263
  store i32 %271, i32* @global_use, align 4
  %272 = add nsw i32 %263, 5
  store i32 %272, i32* %2, align 4
  %273 = load i32, i32* @local_use_number.2, align 4
  %274 = load i32, i32* @local_def.1, align 4
  %275 = load i32, i32* @global_def, align 4
  %276 = mul i32 %274, %273
  %277 = add i32 %275, %276
  store i32 0, i32* @local_use_number.2, align 4
  store i32 %277, i32* @global_def, align 4
  store i32 %272, i32* @local_def.1, align 4
  %278 = load i32, i32* @local_use_number.2, align 4
  %279 = load i32, i32* @local_def.1, align 4
  %280 = load i32, i32* @global_def, align 4
  %281 = mul i32 %279, %278
  %282 = add i32 %280, %281
  store i32 0, i32* @local_use_number.2, align 4
  store i32 %282, i32* @global_def, align 4
  store i32 %272, i32* @local_def.1, align 4
  %NOP_CHECKSUM_LOAD20 = load i32, i32* %3, align 4
  %283 = load i32, i32* @local_use_number.4, align 4
  %284 = add i32 %283, 1
  store i32 %284, i32* @local_use_number.4, align 4
  %285 = load i32, i32* @global_use, align 4
  %286 = add i32 %285, %NOP_CHECKSUM_LOAD20
  store i32 %286, i32* @global_use, align 4
  %287 = load i32, i32* @local_use_number.4, align 4
  %288 = add i32 %287, 1
  store i32 %288, i32* @local_use_number.4, align 4
  %289 = load i32, i32* @global_use, align 4
  %290 = add i32 %289, %NOP_CHECKSUM_LOAD20
  store i32 %290, i32* @global_use, align 4
  %NOP_CHECKSUM_LOAD6 = load i32, i32* %1, align 4
  %291 = load i32, i32* @local_use_number, align 4
  %292 = add i32 %291, 1
  store i32 %292, i32* @local_use_number, align 4
  %293 = load i32, i32* @global_use, align 4
  %294 = add i32 %293, %NOP_CHECKSUM_LOAD6
  store i32 %294, i32* @global_use, align 4
  %295 = load i32, i32* @local_use_number, align 4
  %296 = add i32 %295, 1
  store i32 %296, i32* @local_use_number, align 4
  %297 = load i32, i32* @global_use, align 4
  %298 = add i32 %297, %NOP_CHECKSUM_LOAD6
  store i32 %298, i32* @global_use, align 4
  %299 = load i32, i32* %2, align 4
  %300 = load i32, i32* @local_use_number.2, align 4
  %301 = add i32 %300, 1
  store i32 %301, i32* @local_use_number.2, align 4
  %302 = load i32, i32* @global_use, align 4
  %303 = add i32 %302, %299
  store i32 %303, i32* @global_use, align 4
  %304 = load i32, i32* @local_use_number.2, align 4
  %305 = add i32 %304, 1
  store i32 %305, i32* @local_use_number.2, align 4
  %306 = load i32, i32* @global_use, align 4
  %307 = add i32 %306, %299
  store i32 %307, i32* @global_use, align 4
  %308 = add nsw i32 %299, 6
  store i32 %308, i32* %2, align 4
  %309 = load i32, i32* @local_use_number.2, align 4
  %310 = load i32, i32* @local_def.1, align 4
  %311 = load i32, i32* @global_def, align 4
  %312 = mul i32 %310, %309
  %313 = add i32 %311, %312
  store i32 0, i32* @local_use_number.2, align 4
  store i32 %313, i32* @global_def, align 4
  store i32 %308, i32* @local_def.1, align 4
  %314 = load i32, i32* @local_use_number.2, align 4
  %315 = load i32, i32* @local_def.1, align 4
  %316 = load i32, i32* @global_def, align 4
  %317 = mul i32 %315, %314
  %318 = add i32 %316, %317
  store i32 0, i32* @local_use_number.2, align 4
  store i32 %318, i32* @global_def, align 4
  store i32 %308, i32* @local_def.1, align 4
  %NOP_CHECKSUM_LOAD21 = load i32, i32* %3, align 4
  %319 = load i32, i32* @local_use_number.4, align 4
  %320 = add i32 %319, 1
  store i32 %320, i32* @local_use_number.4, align 4
  %321 = load i32, i32* @global_use, align 4
  %322 = add i32 %321, %NOP_CHECKSUM_LOAD21
  store i32 %322, i32* @global_use, align 4
  %323 = load i32, i32* @local_use_number.4, align 4
  %324 = add i32 %323, 1
  store i32 %324, i32* @local_use_number.4, align 4
  %325 = load i32, i32* @global_use, align 4
  %326 = add i32 %325, %NOP_CHECKSUM_LOAD21
  store i32 %326, i32* @global_use, align 4
  %NOP_CHECKSUM_LOAD7 = load i32, i32* %1, align 4
  %327 = load i32, i32* @local_use_number, align 4
  %328 = add i32 %327, 1
  store i32 %328, i32* @local_use_number, align 4
  %329 = load i32, i32* @global_use, align 4
  %330 = add i32 %329, %NOP_CHECKSUM_LOAD7
  store i32 %330, i32* @global_use, align 4
  %331 = load i32, i32* @local_use_number, align 4
  %332 = add i32 %331, 1
  store i32 %332, i32* @local_use_number, align 4
  %333 = load i32, i32* @global_use, align 4
  %334 = add i32 %333, %NOP_CHECKSUM_LOAD7
  store i32 %334, i32* @global_use, align 4
  %335 = load i32, i32* %2, align 4
  %336 = load i32, i32* @local_use_number.2, align 4
  %337 = add i32 %336, 1
  store i32 %337, i32* @local_use_number.2, align 4
  %338 = load i32, i32* @global_use, align 4
  %339 = add i32 %338, %335
  store i32 %339, i32* @global_use, align 4
  %340 = load i32, i32* @local_use_number.2, align 4
  %341 = add i32 %340, 1
  store i32 %341, i32* @local_use_number.2, align 4
  %342 = load i32, i32* @global_use, align 4
  %343 = add i32 %342, %335
  store i32 %343, i32* @global_use, align 4
  %344 = add nsw i32 %335, 7
  store i32 %344, i32* %2, align 4
  %345 = load i32, i32* @local_use_number.2, align 4
  %346 = load i32, i32* @local_def.1, align 4
  %347 = load i32, i32* @global_def, align 4
  %348 = mul i32 %346, %345
  %349 = add i32 %347, %348
  store i32 0, i32* @local_use_number.2, align 4
  store i32 %349, i32* @global_def, align 4
  store i32 %344, i32* @local_def.1, align 4
  %350 = load i32, i32* @local_use_number.2, align 4
  %351 = load i32, i32* @local_def.1, align 4
  %352 = load i32, i32* @global_def, align 4
  %353 = mul i32 %351, %350
  %354 = add i32 %352, %353
  store i32 0, i32* @local_use_number.2, align 4
  store i32 %354, i32* @global_def, align 4
  store i32 %344, i32* @local_def.1, align 4
  %NOP_CHECKSUM_LOAD22 = load i32, i32* %3, align 4
  %355 = load i32, i32* @local_use_number.4, align 4
  %356 = add i32 %355, 1
  store i32 %356, i32* @local_use_number.4, align 4
  %357 = load i32, i32* @global_use, align 4
  %358 = add i32 %357, %NOP_CHECKSUM_LOAD22
  store i32 %358, i32* @global_use, align 4
  %359 = load i32, i32* @local_use_number.4, align 4
  %360 = add i32 %359, 1
  store i32 %360, i32* @local_use_number.4, align 4
  %361 = load i32, i32* @global_use, align 4
  %362 = add i32 %361, %NOP_CHECKSUM_LOAD22
  store i32 %362, i32* @global_use, align 4
  %NOP_CHECKSUM_LOAD8 = load i32, i32* %1, align 4
  %363 = load i32, i32* @local_use_number, align 4
  %364 = add i32 %363, 1
  store i32 %364, i32* @local_use_number, align 4
  %365 = load i32, i32* @global_use, align 4
  %366 = add i32 %365, %NOP_CHECKSUM_LOAD8
  store i32 %366, i32* @global_use, align 4
  %367 = load i32, i32* @local_use_number, align 4
  %368 = add i32 %367, 1
  store i32 %368, i32* @local_use_number, align 4
  %369 = load i32, i32* @global_use, align 4
  %370 = add i32 %369, %NOP_CHECKSUM_LOAD8
  store i32 %370, i32* @global_use, align 4
  %371 = load i32, i32* %3, align 4
  %372 = load i32, i32* @local_use_number.4, align 4
  %373 = add i32 %372, 1
  store i32 %373, i32* @local_use_number.4, align 4
  %374 = load i32, i32* @global_use, align 4
  %375 = add i32 %374, %371
  store i32 %375, i32* @global_use, align 4
  %376 = load i32, i32* @local_use_number.4, align 4
  %377 = add i32 %376, 1
  store i32 %377, i32* @local_use_number.4, align 4
  %378 = load i32, i32* @global_use, align 4
  %379 = add i32 %378, %371
  store i32 %379, i32* @global_use, align 4
  %NOP_CHECKSUM_LOAD11 = load i32, i32* %2, align 4
  %380 = load i32, i32* @local_use_number.2, align 4
  %381 = add i32 %380, 1
  store i32 %381, i32* @local_use_number.2, align 4
  %382 = load i32, i32* @global_use, align 4
  %383 = add i32 %382, %NOP_CHECKSUM_LOAD11
  store i32 %383, i32* @global_use, align 4
  %384 = load i32, i32* @local_use_number.2, align 4
  %385 = add i32 %384, 1
  store i32 %385, i32* @local_use_number.2, align 4
  %386 = load i32, i32* @global_use, align 4
  %387 = add i32 %386, %NOP_CHECKSUM_LOAD11
  store i32 %387, i32* @global_use, align 4
  %388 = load i32, i32* %2, align 4
  %389 = load i32, i32* @local_use_number.2, align 4
  %390 = add i32 %389, 1
  store i32 %390, i32* @local_use_number.2, align 4
  %391 = load i32, i32* @global_use, align 4
  %392 = add i32 %391, %388
  store i32 %392, i32* @global_use, align 4
  %393 = load i32, i32* @local_use_number.2, align 4
  %394 = add i32 %393, 1
  store i32 %394, i32* @local_use_number.2, align 4
  %395 = load i32, i32* @global_use, align 4
  %396 = add i32 %395, %388
  store i32 %396, i32* @global_use, align 4
  %NOP_CHECKSUM_LOAD25 = load i32, i32* %3, align 4
  %397 = load i32, i32* @local_use_number.4, align 4
  %398 = add i32 %397, 1
  store i32 %398, i32* @local_use_number.4, align 4
  %399 = load i32, i32* @global_use, align 4
  %400 = add i32 %399, %NOP_CHECKSUM_LOAD25
  store i32 %400, i32* @global_use, align 4
  %401 = load i32, i32* @local_use_number.4, align 4
  %402 = add i32 %401, 1
  store i32 %402, i32* @local_use_number.4, align 4
  %403 = load i32, i32* @global_use, align 4
  %404 = add i32 %403, %NOP_CHECKSUM_LOAD25
  store i32 %404, i32* @global_use, align 4
  %405 = mul nsw i32 %371, %388
  store i32 %405, i32* %3, align 4
  %406 = load i32, i32* @local_use_number.4, align 4
  %407 = load i32, i32* @local_def.3, align 4
  %408 = load i32, i32* @global_def, align 4
  %409 = mul i32 %407, %406
  %410 = add i32 %408, %409
  store i32 0, i32* @local_use_number.4, align 4
  store i32 %410, i32* @global_def, align 4
  store i32 %405, i32* @local_def.3, align 4
  %411 = load i32, i32* @local_use_number.4, align 4
  %412 = load i32, i32* @local_def.3, align 4
  %413 = load i32, i32* @global_def, align 4
  %414 = mul i32 %412, %411
  %415 = add i32 %413, %414
  store i32 0, i32* @local_use_number.4, align 4
  store i32 %415, i32* @global_def, align 4
  store i32 %405, i32* @local_def.3, align 4
  %NOP_CHECKSUM_LOAD13 = load i32, i32* %2, align 4
  %416 = load i32, i32* @local_use_number.2, align 4
  %417 = add i32 %416, 1
  store i32 %417, i32* @local_use_number.2, align 4
  %418 = load i32, i32* @global_use, align 4
  %419 = add i32 %418, %NOP_CHECKSUM_LOAD13
  store i32 %419, i32* @global_use, align 4
  %420 = load i32, i32* @local_use_number.2, align 4
  %421 = add i32 %420, 1
  store i32 %421, i32* @local_use_number.2, align 4
  %422 = load i32, i32* @global_use, align 4
  %423 = add i32 %422, %NOP_CHECKSUM_LOAD13
  store i32 %423, i32* @global_use, align 4
  %NOP_CHECKSUM_LOAD12 = load i32, i32* %2, align 4
  %424 = load i32, i32* @local_use_number.2, align 4
  %425 = add i32 %424, 1
  store i32 %425, i32* @local_use_number.2, align 4
  %426 = load i32, i32* @global_use, align 4
  %427 = add i32 %426, %NOP_CHECKSUM_LOAD12
  store i32 %427, i32* @global_use, align 4
  %428 = load i32, i32* @local_use_number.2, align 4
  %429 = add i32 %428, 1
  store i32 %429, i32* @local_use_number.2, align 4
  %430 = load i32, i32* @global_use, align 4
  %431 = add i32 %430, %NOP_CHECKSUM_LOAD12
  store i32 %431, i32* @global_use, align 4
  %NOP_CHECKSUM_LOAD26 = load i32, i32* %3, align 4
  %432 = load i32, i32* @local_use_number.4, align 4
  %433 = add i32 %432, 1
  store i32 %433, i32* @local_use_number.4, align 4
  %434 = load i32, i32* @global_use, align 4
  %435 = add i32 %434, %NOP_CHECKSUM_LOAD26
  store i32 %435, i32* @global_use, align 4
  %436 = load i32, i32* @local_use_number.4, align 4
  %437 = add i32 %436, 1
  store i32 %437, i32* @local_use_number.4, align 4
  %438 = load i32, i32* @global_use, align 4
  %439 = add i32 %438, %NOP_CHECKSUM_LOAD26
  store i32 %439, i32* @global_use, align 4
  %NOP_CHECKSUM_LOAD9 = load i32, i32* %1, align 4
  %440 = load i32, i32* @local_use_number, align 4
  %441 = add i32 %440, 1
  store i32 %441, i32* @local_use_number, align 4
  %442 = load i32, i32* @global_use, align 4
  %443 = add i32 %442, %NOP_CHECKSUM_LOAD9
  store i32 %443, i32* @global_use, align 4
  %444 = load i32, i32* @local_use_number, align 4
  %445 = add i32 %444, 1
  store i32 %445, i32* @local_use_number, align 4
  %446 = load i32, i32* @global_use, align 4
  %447 = add i32 %446, %NOP_CHECKSUM_LOAD9
  store i32 %447, i32* @global_use, align 4
  %448 = load i32, i32* %2, align 4
  %449 = load i32, i32* @local_use_number.2, align 4
  %450 = add i32 %449, 1
  store i32 %450, i32* @local_use_number.2, align 4
  %451 = load i32, i32* @global_use, align 4
  %452 = add i32 %451, %448
  store i32 %452, i32* @global_use, align 4
  %453 = load i32, i32* @local_use_number.2, align 4
  %454 = add i32 %453, 1
  store i32 %454, i32* @local_use_number.2, align 4
  %455 = load i32, i32* @global_use, align 4
  %456 = add i32 %455, %448
  store i32 %456, i32* @global_use, align 4
  %457 = load i32, i32* %3, align 4
  %458 = load i32, i32* @local_use_number.4, align 4
  %459 = add i32 %458, 1
  store i32 %459, i32* @local_use_number.4, align 4
  %460 = load i32, i32* @global_use, align 4
  %461 = add i32 %460, %457
  store i32 %461, i32* @global_use, align 4
  %462 = load i32, i32* @local_use_number.4, align 4
  %463 = add i32 %462, 1
  store i32 %463, i32* @local_use_number.4, align 4
  %464 = load i32, i32* @global_use, align 4
  %465 = add i32 %464, %457
  store i32 %465, i32* @global_use, align 4
  %466 = call i32 (i8*, ...) @printf(i8* noundef getelementptr inbounds ([7 x i8], [7 x i8]* @.str, i64 0, i64 0), i32 noundef %448, i32 noundef %457)
  %467 = load i32, i32* @local_use_number, align 4
  %468 = load i32, i32* @local_def, align 4
  %469 = load i32, i32* @global_def, align 4
  %470 = mul i32 %468, %467
  %471 = add i32 %469, %470
  store i32 0, i32* @local_use_number, align 4
  store i32 %471, i32* @global_def, align 4
  store i32 0, i32* @local_def, align 4
  %472 = load i32, i32* @local_use_number.2, align 4
  %473 = load i32, i32* @local_def.1, align 4
  %474 = load i32, i32* @global_def, align 4
  %475 = mul i32 %473, %472
  %476 = add i32 %474, %475
  store i32 0, i32* @local_use_number.2, align 4
  store i32 %476, i32* @global_def, align 4
  store i32 0, i32* @local_def.1, align 4
  %477 = load i32, i32* @local_use_number.4, align 4
  %478 = load i32, i32* @local_def.3, align 4
  %479 = load i32, i32* @global_def, align 4
  %480 = mul i32 %478, %477
  %481 = add i32 %479, %480
  store i32 0, i32* @local_use_number.4, align 4
  store i32 %481, i32* @global_def, align 4
  store i32 0, i32* @local_def.3, align 4
  %482 = load i32, i32* @global_def, align 4
  %483 = load i32, i32* @global_use, align 4
  %484 = icmp ne i32 %482, %483
  br i1 %484, label %485, label %486

485:                                              ; preds = %0
  ret i32 1

486:                                              ; preds = %0, <null operand!>
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

