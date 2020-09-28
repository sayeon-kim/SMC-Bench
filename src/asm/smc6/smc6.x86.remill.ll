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
  %4 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 1, i32 0
   ;%4 = eax
  %5 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 3, i32 0
  ;%5 = ebx
  %6 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 33, i32 0, i32 0
  ;%10 = eip
  %AX = bitcast %union.anon.1* %4 to i16*, !remill_register !0
  %BL = bitcast %union.anon.1* %5 to i8*, !remill_register !1
  %7 = tail call zeroext i16 @__remill_read_memory_16(%struct.Memory* %2, i32 134512736) #3
  ; load addr(_start)
  store i16 %7, i16* %AX, align 2, !tbaa !2
  ; mov ax, [_start]  
  store i8 -112, i8* %BL, align 1, !tbaa !6
  ; mov bl, 0x90
  %8 = tail call %struct.Memory* @__remill_write_memory_8(%struct.Memory* %2, i32 134512736, i8 zeroext -112) #3
  ; mov [_start], bl 
  %9 = tail call %struct.Memory* @__remill_write_memory_8(%struct.Memory* %8, i32 134512737, i8 zeroext -112) #3
  ; mov [_start+1], bl 
  %10 = tail call %struct.Memory* @__remill_write_memory_8(%struct.Memory* %9, i32 134512776, i8 zeroext -112) #3
  ; mov [re_start], bl 
  %11 = tail call %struct.Memory* @__remill_write_memory_8(%struct.Memory* %10, i32 134512777, i8 zeroext -112) #3
  ; mov [re_start+1], bl  
  %12 = add i32 %1, 45
  ; %12 <- 'halt' next addr
  store i32 %12, i32* %6, align 4
  ; eip = 'halt' next addr
  %13 = tail call %struct.Memory* @__remill_missing_block(%struct.State* nonnull %0, i32 %12, %struct.Memory* %11)
  ret %struct.Memory* %13
}

; Function Attrs: noduplicate noinline nounwind optnone readnone
declare zeroext i16 @__remill_read_memory_16(%struct.Memory*, i32) #1

; Function Attrs: noduplicate noinline nounwind optnone readnone
declare %struct.Memory* @__remill_write_memory_8(%struct.Memory*, i32, i8 zeroext) #1

; Function Attrs: noduplicate noinline nounwind optnone
declare %struct.Memory* @__remill_missing_block(%struct.State* dereferenceable(3376), i32, %struct.Memory*) #2

attributes #0 = { noinline nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { noduplicate noinline nounwind optnone readnone "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { noduplicate noinline nounwind optnone "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nobuiltin nounwind readnone }

!0 = !{[3 x i8] c"AX\00"}
!1 = !{[3 x i8] c"BL\00"}
!2 = !{!3, !3, i64 0}
!3 = !{!"short", !4, i64 0}
!4 = !{!"omnipotent char", !5, i64 0}
!5 = !{!"Simple C++ TBAA"}
!6 = !{!4, !4, i64 0}
