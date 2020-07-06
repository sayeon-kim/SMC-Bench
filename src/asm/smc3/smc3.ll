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
  %5 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 3, i32 0
  %6 = getelementptr inbounds %union.anon.1, %union.anon.1* %4, i32 0, i32 0
  %7 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 5, i32 0, i32 0
  %8 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 7, i32 0, i32 0
  %9 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 15, i32 0, i32 0
  %10 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 33, i32 0, i32 0
  %BL = bitcast %union.anon.1* %5 to i8*, !remill_register !0
  %BH = getelementptr i8, i8* %BL, i32 1, !remill_register !1
  %11 = load i32, i32* %9, align 4
  %12 = load i8, i8* %BH, align 1
  %13 = tail call zeroext i8 @__remill_read_memory_8(%struct.Memory* %2, i32 %11) #3
  %14 = or i8 %13, %12
  %15 = tail call %struct.Memory* @__remill_write_memory_8(%struct.Memory* %2, i32 %11, i8 zeroext %14) #3
  %16 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 2, i32 1
  %17 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 2, i32 3
  %18 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 2, i32 7
  %19 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 2, i32 9
  %20 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 2, i32 13
  %21 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 2, i32 5
  store i32 1, i32* %7, align 4, !tbaa !2
  %22 = add i32 %1, 16
  store i32 1, i32* %8, align 4, !tbaa !2
  br label %23

; <label>:23:                                     ; preds = %40, %3
  %24 = phi i32 [ 1, %3 ], [ %41, %40 ]
  %25 = phi i32 [ %22, %3 ], [ %43, %40 ]
  %26 = phi %struct.Memory* [ %15, %3 ], [ %42, %40 ]
  %27 = tail call i32 @__remill_read_memory_32(%struct.Memory* %26, i32 %11) #3
  %28 = icmp eq i32 %24, %27
  %29 = select i1 %28, i32 29, i32 5
  %30 = add i32 %25, %29
  br i1 %28, label %31, label %40

; <label>:31:                                     ; preds = %23
  %32 = getelementptr inbounds %union.anon.1, %union.anon.1* %5, i32 0, i32 0
  store i32 1, i32* %6, align 4, !tbaa !2
  store i32 0, i32* %32, align 4, !tbaa !2
  store i8 0, i8* %16, align 1, !tbaa !6
  store i8 1, i8* %17, align 1, !tbaa !20
  store i8 1, i8* %18, align 1, !tbaa !21
  store i8 0, i8* %19, align 1, !tbaa !22
  store i8 0, i8* %20, align 1, !tbaa !23
  store i8 0, i8* %21, align 1, !tbaa !24
  %33 = add i32 %30, 9
  store i32 %33, i32* %10, align 4
  %34 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 0, i32 2
  %35 = bitcast %union.anon* %34 to i32*
  store i32 128, i32* %35, align 8, !tbaa !2
  %36 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 0, i32 0
  store i32 4, i32* %36, align 16, !tbaa !25
  %37 = tail call %struct.Memory* @__remill_async_hyper_call(%struct.State* nonnull %0, i32 %33, %struct.Memory* %26)
  %38 = load i32, i32* %10, align 4
  %39 = tail call %struct.Memory* @__remill_missing_block(%struct.State* nonnull %0, i32 %38, %struct.Memory* %26)
  ret %struct.Memory* %39

; <label>:40:                                     ; preds = %23
  %41 = add i32 %24, 1
  store i32 %41, i32* %7, align 4, !tbaa !2
  %42 = tail call %struct.Memory* @__remill_write_memory_8(%struct.Memory* %26, i32 34, i8 zeroext 1) #3
  %43 = add i32 %30, -5
  br label %23
}

; Function Attrs: noduplicate noinline nounwind optnone readnone
declare zeroext i8 @__remill_read_memory_8(%struct.Memory*, i32) #1

; Function Attrs: noduplicate noinline nounwind optnone readnone
declare %struct.Memory* @__remill_write_memory_8(%struct.Memory*, i32, i8 zeroext) #1

; Function Attrs: noduplicate noinline nounwind optnone readnone
declare i32 @__remill_read_memory_32(%struct.Memory*, i32) #1

; Function Attrs: noduplicate noinline nounwind optnone
declare %struct.Memory* @__remill_async_hyper_call(%struct.State* dereferenceable(3376), i32, %struct.Memory*) #2

; Function Attrs: noduplicate noinline nounwind optnone
declare %struct.Memory* @__remill_missing_block(%struct.State* dereferenceable(3376), i32, %struct.Memory*) #2

attributes #0 = { noinline nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { noduplicate noinline nounwind optnone readnone "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { noduplicate noinline nounwind optnone "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nobuiltin nounwind readnone }

!0 = !{[3 x i8] c"BL\00"}
!1 = !{[3 x i8] c"BH\00"}
!2 = !{!3, !3, i64 0}
!3 = !{!"int", !4, i64 0}
!4 = !{!"omnipotent char", !5, i64 0}
!5 = !{!"Simple C++ TBAA"}
!6 = !{!7, !4, i64 2065}
!7 = !{!"_ZTS5State", !4, i64 16, !8, i64 2064, !4, i64 2080, !9, i64 2088, !11, i64 2112, !14, i64 2208, !15, i64 2480, !16, i64 2608, !17, i64 2736, !4, i64 2760, !4, i64 2768, !18, i64 3280}
!8 = !{!"_ZTS10ArithFlags", !4, i64 0, !4, i64 1, !4, i64 2, !4, i64 3, !4, i64 4, !4, i64 5, !4, i64 6, !4, i64 7, !4, i64 8, !4, i64 9, !4, i64 10, !4, i64 11, !4, i64 12, !4, i64 13, !4, i64 14, !4, i64 15}
!9 = !{!"_ZTS8Segments", !10, i64 0, !4, i64 2, !10, i64 4, !4, i64 6, !10, i64 8, !4, i64 10, !10, i64 12, !4, i64 14, !10, i64 16, !4, i64 18, !10, i64 20, !4, i64 22}
!10 = !{!"short", !4, i64 0}
!11 = !{!"_ZTS12AddressSpace", !12, i64 0, !13, i64 8, !12, i64 16, !13, i64 24, !12, i64 32, !13, i64 40, !12, i64 48, !13, i64 56, !12, i64 64, !13, i64 72, !12, i64 80, !13, i64 88}
!12 = !{!"long", !4, i64 0}
!13 = !{!"_ZTS3Reg", !4, i64 0, !3, i64 4}
!14 = !{!"_ZTS3GPR", !12, i64 0, !13, i64 8, !12, i64 16, !13, i64 24, !12, i64 32, !13, i64 40, !12, i64 48, !13, i64 56, !12, i64 64, !13, i64 72, !12, i64 80, !13, i64 88, !12, i64 96, !13, i64 104, !12, i64 112, !13, i64 120, !12, i64 128, !13, i64 136, !12, i64 144, !13, i64 152, !12, i64 160, !13, i64 168, !12, i64 176, !13, i64 184, !12, i64 192, !13, i64 200, !12, i64 208, !13, i64 216, !12, i64 224, !13, i64 232, !12, i64 240, !13, i64 248, !12, i64 256, !13, i64 264}
!15 = !{!"_ZTS8X87Stack", !4, i64 0}
!16 = !{!"_ZTS3MMX", !4, i64 0}
!17 = !{!"_ZTS14FPUStatusFlags", !4, i64 0, !4, i64 1, !4, i64 2, !4, i64 3, !4, i64 4, !4, i64 5, !4, i64 6, !4, i64 7, !4, i64 8, !4, i64 9, !4, i64 10, !4, i64 11, !4, i64 12, !4, i64 13, !4, i64 14, !4, i64 15, !4, i64 16, !4, i64 17, !4, i64 18, !4, i64 19, !4, i64 20}
!18 = !{!"_ZTS13SegmentCaches", !19, i64 0, !19, i64 16, !19, i64 32, !19, i64 48, !19, i64 64, !19, i64 80}
!19 = !{!"_ZTS13SegmentShadow", !4, i64 0, !3, i64 8, !3, i64 12}
!20 = !{!7, !4, i64 2067}
!21 = !{!7, !4, i64 2071}
!22 = !{!7, !4, i64 2073}
!23 = !{!7, !4, i64 2077}
!24 = !{!7, !4, i64 2069}
!25 = !{!26, !27, i64 0}
!26 = !{!"_ZTS9ArchState", !27, i64 0, !3, i64 4, !4, i64 8}
!27 = !{!"_ZTSN14AsyncHyperCall4NameE", !4, i64 0}
