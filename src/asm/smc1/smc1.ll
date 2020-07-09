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
  ;struct.state -> 7th argument of struct.state(%struct.GPR) -> 2th argument of struct.GPR(%struct.Reg) -> 1st argument of struct.Reg(%union.anon.1) -> 1st argument of union.anon.1(i32)indexing
   ;define i32* @foo(%struct.State* %0) nounwind uwtable readnone optsize ssp
  ;{
  ;entry:
    ;%4 = getelementptr inbounds %struct.state, %struct.state* %0, i64 0, i32 6, i32 3, i32 0

    ;ret i32* %4
  ;}
  ;%4 : i32
  %5 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 3, i32 0, i32 0 ;%5 : i32
  %6 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 5, i32 0, i32 0 ;%6 : i32
  %7 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 7, i32 0, i32 0 ;%7 : i32
  %8 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 33, i32 0, i32 0 ;%8 : i32
  
  %9 = tail call i32 @__remill_read_memory_32(%struct.Memory* %2, i32 24) #3
  ;%9 : i32
  ;Send control flow to @__remill_read_memory_32
  %10 = tail call %struct.Memory* @__remill_write_memory_32(%struct.Memory* %2, i32 72, i32 %9) #3
  ;%10 : %struct.Memory*
  ;Send control flow to @__remill_write_memory_32
  %11 = tail call i32 @__remill_read_memory_32(%struct.Memory* %10, i32 27) #3
  ;%11 : i32
  ;Send control flow to @__remill_read_memory_32
  %12 = tail call %struct.Memory* @__remill_write_memory_32(%struct.Memory* %10, i32 75, i32 %11) #3
  ;%12 : %struct.Memory*
  ;Send control flow to @__remill_write_memory_32
  
  store i32 4, i32* %4, align 4, !tbaa !0
  ;store 4 into %4, alignment 4byte(if store type < alignment -> data can be stored in memory without trapping in the defalult address space)
  store i32 1, i32* %5, align 4, !tbaa !0
  ;store 1 into %5
  store i32 0, i32* %6, align 4, !tbaa !0
  ;store 0 into %6
  store i32 15, i32* %7, align 4, !tbaa !0
  ;store 15 into %7
  %13 = add i32 %1, 100 ;%13 = %1 + 100
  store i32 %13, i32* %8, align 4 
  ;store %13 into %8
  %14 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 0, i32 2
  ;%14 : %union.anon
  %15 = bitcast %union.anon* %14 to i32* ;%15 = read %14 of i32* type
  store i32 128, i32* %15, align 8, !tbaa !4
  ;store 128 into %15
  %16 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 0, i32 0
  ;%16 : int32
  store i32 4, i32* %16, align 16, !tbaa !5
  ;store 4 into %16
  %17 = tail call %struct.Memory* @__remill_async_hyper_call(%struct.State* nonnull %0, i32 %13, %struct.Memory* %12)
  ;%17 : %struct.Memory*
  ;Send control flow to @__remill_async_hyper_call
  %18 = load i32, i32* %8, align 4
  ;load %8 to %18
  %19 = icmp eq i32 %18, 100
  br i1 %19, label %22, label %20
  ;if (%18 == 100) -> jump to %22 / else jump to %20

20:                                               ; preds = %3
  %21 = tail call %struct.Memory* @__remill_missing_block(%struct.State* nonnull %0, i32 %18, %struct.Memory* %12)
  ;%21 : %struct.Memory*
  ;Send control flow to @__remill_missing_block
  ret %struct.Memory* %21

22:                                               ; preds = %3
  store i32 1, i32* %4, align 4, !tbaa !0
  ;store 1 into %4
  store i32 0, i32* %5, align 4, !tbaa !0
  ;store 0 into %5
  store i32 112, i32* %8, align 4
  ;store 112 into %8
  store i32 128, i32* %15, align 8, !tbaa !4
  ;store 128 into %15
  store i32 4, i32* %16, align 16, !tbaa !5
  ;store 4 into %16
  %23 = tail call %struct.Memory* @__remill_async_hyper_call(%struct.State* nonnull %0, i32 112, %struct.Memory* %12)
  ;%23 : %struct.Memory*
  ;Send control flow to @__remill_async_hyper_call
  %24 = load i32, i32* %8, align 4
  ;load %8 to %24
  %25 = tail call %struct.Memory* @__remill_missing_block(%struct.State* nonnull %0, i32 %24, %struct.Memory* %12)
  ;%25 : %struct.Memory*
  ;Send control flow to @__remill_missing_block
  ret %struct.Memory* %25
}

; Function Attrs: noduplicate noinline nounwind optnone readnone
declare dso_local i32 @__remill_read_memory_32(%struct.Memory*, i32) #1

; Function Attrs: noduplicate noinline nounwind optnone readnone
declare dso_local %struct.Memory* @__remill_write_memory_32(%struct.Memory*, i32, i32) #1

; Function Attrs: noduplicate noinline nounwind optnone
declare dso_local %struct.Memory* @__remill_async_hyper_call(%struct.State* dereferenceable(3376), i32, %struct.Memory*) #2

; Function Attrs: noduplicate noinline nounwind optnone
declare dso_local %struct.Memory* @__remill_missing_block(%struct.State* dereferenceable(3376), i32, %struct.Memory*) #2

attributes #0 = { noinline nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { noduplicate noinline nounwind optnone readnone "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { noduplicate noinline nounwind optnone "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nobuiltin nounwind readnone }

!0 = !{!1, !1, i64 0}
!1 = !{!"int", !2, i64 0}
!2 = !{!"omnipotent char", !3, i64 0}
!3 = !{!"Simple C++ TBAA"}
!4 = !{!2, !2, i64 0}
!5 = !{!6, !7, i64 0}
!6 = !{!"_ZTS9ArchState", !7, i64 0, !1, i64 4, !2, i64 8}
!7 = !{!"_ZTSN14AsyncHyperCall4NameE", !2, i64 0}
