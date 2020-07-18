; ModuleID = 'lifted_code'
source_filename = "lifted_code"
target datalayout = "e-m:e-p:32:32-f64:32:64-f80:32-n8:16:32-S128"
target triple = "i386-pc-linux-gnu-elf"

%struct.State = type { %struct.ArchState, [32 x %union.VectorReg], %struct.ArithFlags, %union.anon, %struct.Segments, %struct.AddressSpace, %struct.GPR, %struct.X87Stack, %struct.MMX, %struct.FPUStatusFlags, %union.anon, %union.FPU, %struct.SegmentCaches }
%struct.ArchState = type { i32, i32, %union.anon }
%union.VectorReg = type { %union.vec512_t }
%union.vec512_t = type { %struct.uint64v8_t }
%struct.uint64v8_t = type { [8 x i64] }
%struct.ArithFlags = type { i8, i8, i8, i8, i8, i8, i8, i8, i8, i8, i8, i8, i8, i8, i8, i8 }
%struct.Segments = type { i16, %union.SegmentSelector, i16, %union.SegmentSelector, i16, %union.SegmentSelector, i16, %union.SegmentSelector, i16, %union.SegmentSelector, i16, %union.SegmentSelector }
%union.SegmentSelector = type { i16 }
%struct.AddressSpace = type { i64, %struct.Reg, i64, %struct.Reg, i64, %struct.Reg, i64, %struct.Reg, i64, %struct.Reg, i64, %struct.Reg }
%struct.Reg = type { %union.anon.1, i32 }
%union.anon.1 = type { i32 }
%struct.GPR = type { i64, %struct.Reg, i64, %struct.Reg, i64, %struct.Reg, i64, %struct.Reg, i64, %struct.Reg, i64, %struct.Reg, i64, %struct.Reg, i64, %struct.Reg, i64, %struct.Reg, i64, %struct.Reg, i64, %struct.Reg, i64, %struct.Reg, i64, %struct.Reg, i64, %struct.Reg, i64, %struct.Reg, i64, %struct.Reg, i64, %struct.Reg }
%struct.X87Stack = type { [8 x %struct.anon.3] }
%struct.anon.3 = type { i64, double }
%struct.MMX = type { [8 x %struct.anon.4] }
%struct.anon.4 = type { i64, %union.vec64_t }
%union.vec64_t = type { %struct.uint64v1_t }
%struct.uint64v1_t = type { [1 x i64] }
%struct.FPUStatusFlags = type { i8, i8, i8, i8, i8, i8, i8, i8, i8, i8, i8, i8, i8, i8, i8, i8, i8, i8, i8, i8, [4 x i8] }
%union.anon = type { i64 }
%union.FPU = type { %struct.anon.13 }
%struct.anon.13 = type { %struct.FpuFXSAVE, [96 x i8] }
%struct.FpuFXSAVE = type { %union.SegmentSelector, %union.SegmentSelector, %union.FPUAbridgedTagWord, i8, i16, i32, %union.SegmentSelector, i16, i32, %union.SegmentSelector, i16, %union.anon.1, %union.anon.1, [8 x %struct.FPUStackElem], [16 x %union.vec128_t] }
%union.FPUAbridgedTagWord = type { i8 }
%struct.FPUStackElem = type { %union.anon.11, [6 x i8] }
%union.anon.11 = type { %struct.float80_t }
%struct.float80_t = type { [10 x i8] }
%union.vec128_t = type { %struct.uint128v1_t }
%struct.uint128v1_t = type { [1 x i128] }
%struct.SegmentCaches = type { %struct.SegmentShadow, %struct.SegmentShadow, %struct.SegmentShadow, %struct.SegmentShadow, %struct.SegmentShadow, %struct.SegmentShadow }
%struct.SegmentShadow = type { %union.anon, i32, i32 }
%struct.Memory = type opaque

; Function Attrs: noinline nounwind
define dso_local %struct.Memory* @sub_0(%struct.State* noalias dereferenceable(3376), i32, %struct.Memory* noalias) local_unnamed_addr #0 {
  %4 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 1, i32 0, i32 0
  %5 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 33, i32 0, i32 0
  %6 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 13, i32 0, i32 0
  %7 = load i32, i32* %6, align 8, !tbaa !0
  %8 = add i32 %7, -4
  %9 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 5, i32 1, i32 0, i32 0
  %10 = load i32, i32* %9, align 8, !tbaa !0
  %11 = add i32 %10, %8
  %12 = tail call %struct.Memory* @__remill_write_memory_32(%struct.Memory* %2, i32 %11, i32 1111) #3
  %13 = add i32 %7, -8
  %14 = add i32 %10, %13
  %15 = tail call %struct.Memory* @__remill_write_memory_32(%struct.Memory* %12, i32 %14, i32 2222) #3
  %16 = add i32 %7, -12
  %17 = add i32 %10, %16
  %18 = tail call %struct.Memory* @__remill_write_memory_32(%struct.Memory* %15, i32 %17, i32 3333) #3
  %19 = add i32 %7, -16
  %20 = add i32 %10, %19
  %21 = tail call %struct.Memory* @__remill_write_memory_32(%struct.Memory* %18, i32 %20, i32 4444) #3
  %22 = add i32 %7, -20
  %23 = add i32 %10, %22
  %24 = tail call %struct.Memory* @__remill_write_memory_32(%struct.Memory* %21, i32 %23, i32 5555) #3
  %25 = add i32 %7, -24
  %26 = add i32 %10, %25
  %27 = tail call %struct.Memory* @__remill_write_memory_32(%struct.Memory* %24, i32 %26, i32 6666) #3
  %28 = add i32 %7, -28
  %29 = add i32 %10, %28
  %30 = tail call %struct.Memory* @__remill_write_memory_32(%struct.Memory* %27, i32 %29, i32 7777) #3
  %31 = add i32 %7, -32
  %32 = add i32 %10, %31
  %33 = tail call %struct.Memory* @__remill_write_memory_32(%struct.Memory* %30, i32 %32, i32 8888) #3
  store i32 9999, i32* %4, align 4, !tbaa !3
  %34 = add i32 %1, 54
  store i32 %34, i32* %5, align 4
  %35 = add i32 %7, -36
  %36 = add i32 %10, %35
  %37 = tail call %struct.Memory* @__remill_write_memory_32(%struct.Memory* %33, i32 %36, i32 9999) #3
  store i32 %35, i32* %6, align 4, !tbaa !3
  %38 = tail call %struct.Memory* @__remill_missing_block(%struct.State* nonnull %0, i32 %34, %struct.Memory* %37)
  ret %struct.Memory* %38
}

; Function Attrs: noduplicate noinline nounwind optnone readnone
declare dso_local %struct.Memory* @__remill_write_memory_32(%struct.Memory*, i32, i32) #1

; Function Attrs: noduplicate noinline nounwind optnone
declare dso_local %struct.Memory* @__remill_missing_block(%struct.State* dereferenceable(3376), i32, %struct.Memory*) #2

attributes #0 = { noinline nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { noduplicate noinline nounwind optnone readnone "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { noduplicate noinline nounwind optnone "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nobuiltin nounwind readnone }

!0 = !{!1, !1, i64 0}
!1 = !{!"omnipotent char", !2, i64 0}
!2 = !{!"Simple C++ TBAA"}
!3 = !{!4, !4, i64 0}
!4 = !{!"int", !1, i64 0}
