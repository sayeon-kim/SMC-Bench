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
  %5 = getelementptr inbounds %union.anon.1, %union.anon.1* %4, i32 0, i32 0
  %6 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 3, i32 0, i32 0
  %7 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 5, i32 0, i32 0
  %8 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 7, i32 0, i32 0
  %9 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 13, i32 0, i32 0
  %10 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 33, i32 0, i32 0
  %AL = bitcast %union.anon.1* %4 to i8*, !remill_register !0
  store i32 0, i32* %5, align 4, !tbaa !1
  %11 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 2, i32 1
  store i8 0, i8* %11, align 1, !tbaa !5
  %12 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 2, i32 3
  store i8 1, i8* %12, align 1, !tbaa !19
  %13 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 2, i32 7
  store i8 1, i8* %13, align 1, !tbaa !20
  %14 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 2, i32 9
  store i8 0, i8* %14, align 1, !tbaa !21
  %15 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 2, i32 13
  store i8 0, i8* %15, align 1, !tbaa !22
  %16 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 2, i32 5
  store i8 0, i8* %16, align 1, !tbaa !23
  %17 = load i32, i32* %9, align 8, !tbaa !1
  %18 = add i32 %17, -4
  %19 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 5, i32 1, i32 0, i32 0
  %20 = load i32, i32* %19, align 8, !tbaa !1
  %21 = add i32 %20, %18
  %22 = tail call %struct.Memory* @__remill_write_memory_32(%struct.Memory* %2, i32 %21, i32 0) #3
  %23 = add i32 %17, -8
  %24 = add i32 %20, %23
  %25 = tail call %struct.Memory* @__remill_write_memory_32(%struct.Memory* %22, i32 %24, i32 1752379183) #3
  %26 = add i32 %17, -12
  %27 = add i32 %20, %26
  %28 = tail call %struct.Memory* @__remill_write_memory_32(%struct.Memory* %25, i32 %27, i32 1852400175) #3
  store i32 %26, i32* %9, align 4, !tbaa !1
  store i32 %26, i32* %6, align 4, !tbaa !1
  store i32 0, i32* %7, align 4, !tbaa !1
  store i32 0, i32* %8, align 4, !tbaa !1
  store i8 11, i8* %AL, align 1, !tbaa !24
  %29 = add i32 %1, 23
  store i32 %29, i32* %10, align 4
  %30 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 0, i32 2
  %31 = bitcast %union.anon* %30 to i32*
  store i32 128, i32* %31, align 8, !tbaa !1
  %32 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 0, i32 0
  store i32 4, i32* %32, align 16, !tbaa !25
  %33 = tail call %struct.Memory* @__remill_async_hyper_call(%struct.State* nonnull %0, i32 %29, %struct.Memory* %28)
  %34 = load i32, i32* %10, align 4
  %35 = tail call %struct.Memory* @__remill_missing_block(%struct.State* nonnull %0, i32 %34, %struct.Memory* %28)
  ret %struct.Memory* %35
}

; Function Attrs: noduplicate noinline nounwind optnone readnone
declare %struct.Memory* @__remill_write_memory_32(%struct.Memory*, i32, i32) #1

; Function Attrs: noduplicate noinline nounwind optnone
declare %struct.Memory* @__remill_async_hyper_call(%struct.State* dereferenceable(3376), i32, %struct.Memory*) #2

; Function Attrs: noduplicate noinline nounwind optnone
declare %struct.Memory* @__remill_missing_block(%struct.State* dereferenceable(3376), i32, %struct.Memory*) #2

attributes #0 = { noinline nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { noduplicate noinline nounwind optnone readnone "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { noduplicate noinline nounwind optnone "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nobuiltin nounwind readnone }

!0 = !{[3 x i8] c"AL\00"}
!1 = !{!2, !2, i64 0}
!2 = !{!"int", !3, i64 0}
!3 = !{!"omnipotent char", !4, i64 0}
!4 = !{!"Simple C++ TBAA"}
!5 = !{!6, !3, i64 2065}
!6 = !{!"_ZTS5State", !3, i64 16, !7, i64 2064, !3, i64 2080, !8, i64 2088, !10, i64 2112, !13, i64 2208, !14, i64 2480, !15, i64 2608, !16, i64 2736, !3, i64 2760, !3, i64 2768, !17, i64 3280}
!7 = !{!"_ZTS10ArithFlags", !3, i64 0, !3, i64 1, !3, i64 2, !3, i64 3, !3, i64 4, !3, i64 5, !3, i64 6, !3, i64 7, !3, i64 8, !3, i64 9, !3, i64 10, !3, i64 11, !3, i64 12, !3, i64 13, !3, i64 14, !3, i64 15}
!8 = !{!"_ZTS8Segments", !9, i64 0, !3, i64 2, !9, i64 4, !3, i64 6, !9, i64 8, !3, i64 10, !9, i64 12, !3, i64 14, !9, i64 16, !3, i64 18, !9, i64 20, !3, i64 22}
!9 = !{!"short", !3, i64 0}
!10 = !{!"_ZTS12AddressSpace", !11, i64 0, !12, i64 8, !11, i64 16, !12, i64 24, !11, i64 32, !12, i64 40, !11, i64 48, !12, i64 56, !11, i64 64, !12, i64 72, !11, i64 80, !12, i64 88}
!11 = !{!"long", !3, i64 0}
!12 = !{!"_ZTS3Reg", !3, i64 0, !2, i64 4}
!13 = !{!"_ZTS3GPR", !11, i64 0, !12, i64 8, !11, i64 16, !12, i64 24, !11, i64 32, !12, i64 40, !11, i64 48, !12, i64 56, !11, i64 64, !12, i64 72, !11, i64 80, !12, i64 88, !11, i64 96, !12, i64 104, !11, i64 112, !12, i64 120, !11, i64 128, !12, i64 136, !11, i64 144, !12, i64 152, !11, i64 160, !12, i64 168, !11, i64 176, !12, i64 184, !11, i64 192, !12, i64 200, !11, i64 208, !12, i64 216, !11, i64 224, !12, i64 232, !11, i64 240, !12, i64 248, !11, i64 256, !12, i64 264}
!14 = !{!"_ZTS8X87Stack", !3, i64 0}
!15 = !{!"_ZTS3MMX", !3, i64 0}
!16 = !{!"_ZTS14FPUStatusFlags", !3, i64 0, !3, i64 1, !3, i64 2, !3, i64 3, !3, i64 4, !3, i64 5, !3, i64 6, !3, i64 7, !3, i64 8, !3, i64 9, !3, i64 10, !3, i64 11, !3, i64 12, !3, i64 13, !3, i64 14, !3, i64 15, !3, i64 16, !3, i64 17, !3, i64 18, !3, i64 19, !3, i64 20}
!17 = !{!"_ZTS13SegmentCaches", !18, i64 0, !18, i64 16, !18, i64 32, !18, i64 48, !18, i64 64, !18, i64 80}
!18 = !{!"_ZTS13SegmentShadow", !3, i64 0, !2, i64 8, !2, i64 12}
!19 = !{!6, !3, i64 2067}
!20 = !{!6, !3, i64 2071}
!21 = !{!6, !3, i64 2073}
!22 = !{!6, !3, i64 2077}
!23 = !{!6, !3, i64 2069}
!24 = !{!3, !3, i64 0}
!25 = !{!26, !27, i64 0}
!26 = !{!"_ZTS9ArchState", !27, i64 0, !2, i64 4, !3, i64 8}
!27 = !{!"_ZTSN14AsyncHyperCall4NameE", !3, i64 0}
