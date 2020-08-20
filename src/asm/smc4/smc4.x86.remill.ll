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
define %struct.Memory* @sub_0(%struct.State* noalias dereferenceable(3376), i32, %struct.Memory* noalias) local_unnamed_addr #0 {
  %4 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 1, i32 0, i32 0 ;%4 == eax
  %5 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 3, i32 0, i32 0 ;%5 == ebx
  %6 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 11, i32 0, i32 0 ;%6 == edi?
  %7 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 33, i32 0, i32 0 ;%7 == eip
  store i32 134512748, i32* %4, align 4, !tbaa !0 ;eax = 134512748 /13452748(10) == 804806c(16)
  %8 = add i32 %1, 8 ;%8 = PC + 8
  %9 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 13, i32 0, i32 0 ;%9 == esp
  %10 = load i32, i32* %9, align 8, !tbaa !0 ;esp에 있는 값을 %10에 불러옴
  %11 = add i32 %10, -4 ;%11 = esp 불러온 값에 -4
  %12 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 5, i32 1, i32 0, i32 0 ;%12 <- AddressSpace
  %13 = load i32, i32* %12, align 8, !tbaa !0 ;%13 = AddressSpace
  %14 = add i32 %13, %11 ;%14 = AddressSpace + esp - 4
  %15 = tail call %struct.Memory* @__remill_write_memory_32(%struct.Memory* %2, i32 %14, i32 %8) #3 ;PC + 8의 주소에 있는 값을 AddressSpace + esp - 4에 집어넣음
  store i32 %11, i32* %9, align 4, !tbaa !0 ;esp <- esp - 4
  store i32 134512748, i32* %7, align 4, !tbaa !0 ;eip = 134512748
  %16 = tail call %struct.Memory* @__remill_function_call(%struct.State* nonnull %0, i32 134512748, %struct.Memory* %15)
  %17 = load i32, i32* %6, align 4 ;%17 = %6
  %18 = load i32, i32* %7, align 4 ;%18 = 134512748
  store i32 %17, i32* %5, align 4, !tbaa !0 ;ebx = %6
  store i32 1, i32* %4, align 4, !tbaa !0 ;eax = 1
  %19 = add i32 %18, 38 ;%19 = 134512748 + 38
  store i32 %19, i32* %7, align 4 ;eip = 134512748 + 38 /0x8048092 -> addr call eax
  %20 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 0, i32 2 ;%20 = ArithFlags
  %21 = bitcast %union.anon* %20 to i32*
  store i32 128, i32* %21, align 8, !tbaa !0 ;int 0x80 systemcall
  %22 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 0, i32 0 ;%22 = ArchState
  store i32 4, i32* %22, align 16, !tbaa !4
  %23 = tail call %struct.Memory* @__remill_async_hyper_call(%struct.State* nonnull %0, i32 %19, %struct.Memory* %15)
  %24 = load i32, i32* %7, align 4
  %25 = icmp eq i32 %24, 46
  br i1 %25, label %28, label %26

; <label>:26:                                     ; preds = %3
  %27 = tail call %struct.Memory* @__remill_missing_block(%struct.State* nonnull %0, i32 %24, %struct.Memory* %15)
  ret %struct.Memory* %27

; <label>:28:                                     ; preds = %3
  store i32 134512748, i32* %4, align 4, !tbaa !0
  %29 = load i32, i32* %9, align 8, !tbaa !0
  %30 = add i32 %29, -4
  %31 = load i32, i32* %12, align 8, !tbaa !0
  %32 = add i32 %31, %30
  %33 = tail call %struct.Memory* @__remill_write_memory_32(%struct.Memory* %15, i32 %32, i32 53) #3
  store i32 %30, i32* %9, align 4, !tbaa !0
  store i32 134512748, i32* %7, align 4, !tbaa !0
  %34 = tail call %struct.Memory* @__remill_function_call(%struct.State* nonnull %0, i32 134512748, %struct.Memory* %33)
  %35 = load i32, i32* %7, align 4
  %36 = tail call %struct.Memory* @__remill_missing_block(%struct.State* nonnull %0, i32 %35, %struct.Memory* %33)
  ret %struct.Memory* %36
}

; Function Attrs: noduplicate noinline nounwind optnone readnone
declare %struct.Memory* @__remill_write_memory_32(%struct.Memory*, i32, i32) #1

; Function Attrs: noduplicate noinline nounwind optnone
declare %struct.Memory* @__remill_function_call(%struct.State* dereferenceable(3376), i32, %struct.Memory*) #2

; Function Attrs: noduplicate noinline nounwind optnone
declare %struct.Memory* @__remill_async_hyper_call(%struct.State* dereferenceable(3376), i32, %struct.Memory*) #2

; Function Attrs: noduplicate noinline nounwind optnone
declare %struct.Memory* @__remill_missing_block(%struct.State* dereferenceable(3376), i32, %struct.Memory*) #2

attributes #0 = { noinline nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { noduplicate noinline nounwind optnone readnone "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { noduplicate noinline nounwind optnone "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nobuiltin nounwind readnone }

!0 = !{!1, !1, i64 0}
!1 = !{!"int", !2, i64 0}
!2 = !{!"omnipotent char", !3, i64 0}
!3 = !{!"Simple C++ TBAA"}
!4 = !{!5, !6, i64 0}
!5 = !{!"_ZTS9ArchState", !6, i64 0, !1, i64 4, !2, i64 8}
!6 = !{!"_ZTSN14AsyncHyperCall4NameE", !2, i64 0}
