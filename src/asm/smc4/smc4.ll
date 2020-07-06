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
  %4 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 5, i32 0
  %5 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 7, i32 0
  %6 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 1, i32 0, i32 0
  %7 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 3, i32 0, i32 0
  %8 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 9, i32 0, i32 0
  %9 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 11, i32 0, i32 0
  %10 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 33, i32 0, i32 0
  %CL = bitcast %union.anon.1* %4 to i8*, !remill_register !0
  %DL = bitcast %union.anon.1* %5 to i8*, !remill_register !1
  store i32 10, i32* %9, align 4, !tbaa !2
  %11 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 2, i32 1
  %12 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 2, i32 3
  %13 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 2, i32 5
  %14 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 2, i32 7
  %15 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 2, i32 9
  %16 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 2, i32 13
  %17 = tail call zeroext i8 @__remill_read_memory_8(%struct.Memory* %2, i32 51) #4
  %18 = lshr i8 %17, 7
  %19 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 0, i32 2
  %20 = bitcast %union.anon* %19 to i32*
  %21 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 0, i32 0
  %22 = tail call zeroext i8 @__remill_read_memory_8(%struct.Memory* %2, i32 8) #4
  %23 = sub i8 %22, %17
  %24 = icmp ult i8 %22, %17
  %25 = zext i1 %24 to i8
  %26 = zext i8 %23 to i32
  %27 = tail call i32 @llvm.ctpop.i32(i32 %26) #5
  %28 = trunc i32 %27 to i8
  %29 = and i8 %28, 1
  %30 = xor i8 %29, 1
  %31 = xor i8 %22, %17
  %32 = xor i8 %31, %23
  %33 = lshr i8 %32, 4
  %34 = and i8 %33, 1
  %35 = icmp eq i8 %23, 0
  %36 = zext i1 %35 to i8
  %37 = lshr i8 %23, 7
  %38 = lshr i8 %22, 7
  %39 = xor i8 %38, %18
  %40 = xor i8 %37, %38
  %41 = add nuw nsw i8 %40, %39
  %42 = icmp eq i8 %41, 2
  %43 = zext i1 %42 to i8
  %44 = select i1 %35, i32 20, i32 22
  %45 = add i32 %1, 14
  store i32 42, i32* %7, align 4, !tbaa !2
  store i8 %22, i8* %CL, align 1, !tbaa !6
  store i32 43, i32* %8, align 4, !tbaa !2
  store i8 %17, i8* %DL, align 1, !tbaa !6
  store i8 %25, i8* %11, align 1, !tbaa !7
  store i8 %30, i8* %12, align 1, !tbaa !21
  store i8 %34, i8* %13, align 1, !tbaa !22
  store i8 %36, i8* %14, align 1, !tbaa !23
  store i8 %37, i8* %15, align 1, !tbaa !24
  store i8 %43, i8* %16, align 1, !tbaa !25
  %46 = add i32 %45, %44
  br i1 %35, label %._crit_edge, label %.lr.ph.preheader

.lr.ph.preheader:                                 ; preds = %3
  %47 = add nuw nsw i32 %44, 14
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader, %56
  %48 = phi i32 [ %47, %56 ], [ %46, %.lr.ph.preheader ]
  store i32 1, i32* %6, align 4, !tbaa !2
  %49 = add i32 %48, 7
  store i32 %49, i32* %10, align 4
  store i32 128, i32* %20, align 8, !tbaa !2
  store i32 4, i32* %21, align 16, !tbaa !26
  %50 = tail call %struct.Memory* @__remill_async_hyper_call(%struct.State* nonnull %0, i32 %49, %struct.Memory* %2)
  %51 = load i32, i32* %10, align 4
  %52 = icmp eq i32 %51, 43
  br i1 %52, label %56, label %54

._crit_edge.loopexit:                             ; preds = %56
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %3
  store i32 10, i32* %10, align 4, !tbaa !2
  %53 = tail call %struct.Memory* @__remill_jump(%struct.State* nonnull %0, i32 10, %struct.Memory* %2)
  ret %struct.Memory* %53

; <label>:54:                                     ; preds = %.lr.ph
  %55 = tail call %struct.Memory* @__remill_missing_block(%struct.State* nonnull %0, i32 %51, %struct.Memory* %2)
  ret %struct.Memory* %55

; <label>:56:                                     ; preds = %.lr.ph
  store i32 10, i32* %9, align 4, !tbaa !2
  store i32 42, i32* %7, align 4, !tbaa !2
  store i8 %22, i8* %CL, align 1, !tbaa !6
  store i32 43, i32* %8, align 4, !tbaa !2
  store i8 %17, i8* %DL, align 1, !tbaa !6
  store i8 %25, i8* %11, align 1, !tbaa !7
  store i8 %30, i8* %12, align 1, !tbaa !21
  store i8 %34, i8* %13, align 1, !tbaa !22
  store i8 %36, i8* %14, align 1, !tbaa !23
  store i8 %37, i8* %15, align 1, !tbaa !24
  store i8 %43, i8* %16, align 1, !tbaa !25
  br i1 %35, label %._crit_edge.loopexit, label %.lr.ph
}

; Function Attrs: noduplicate noinline nounwind optnone readnone
declare zeroext i8 @__remill_read_memory_8(%struct.Memory*, i32) #1

; Function Attrs: nounwind readnone
declare i32 @llvm.ctpop.i32(i32) #2

; Function Attrs: noduplicate noinline nounwind optnone
declare %struct.Memory* @__remill_async_hyper_call(%struct.State* dereferenceable(3376), i32, %struct.Memory*) #3

; Function Attrs: noduplicate noinline nounwind optnone
declare %struct.Memory* @__remill_jump(%struct.State* dereferenceable(3376), i32, %struct.Memory*) #3

; Function Attrs: noduplicate noinline nounwind optnone
declare %struct.Memory* @__remill_missing_block(%struct.State* dereferenceable(3376), i32, %struct.Memory*) #3

attributes #0 = { noinline nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { noduplicate noinline nounwind optnone readnone "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readnone }
attributes #3 = { noduplicate noinline nounwind optnone "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nobuiltin nounwind readnone }
attributes #5 = { nounwind }

!0 = !{[3 x i8] c"CL\00"}
!1 = !{[3 x i8] c"DL\00"}
!2 = !{!3, !3, i64 0}
!3 = !{!"int", !4, i64 0}
!4 = !{!"omnipotent char", !5, i64 0}
!5 = !{!"Simple C++ TBAA"}
!6 = !{!4, !4, i64 0}
!7 = !{!8, !4, i64 2065}
!8 = !{!"_ZTS5State", !4, i64 16, !9, i64 2064, !4, i64 2080, !10, i64 2088, !12, i64 2112, !15, i64 2208, !16, i64 2480, !17, i64 2608, !18, i64 2736, !4, i64 2760, !4, i64 2768, !19, i64 3280}
!9 = !{!"_ZTS10ArithFlags", !4, i64 0, !4, i64 1, !4, i64 2, !4, i64 3, !4, i64 4, !4, i64 5, !4, i64 6, !4, i64 7, !4, i64 8, !4, i64 9, !4, i64 10, !4, i64 11, !4, i64 12, !4, i64 13, !4, i64 14, !4, i64 15}
!10 = !{!"_ZTS8Segments", !11, i64 0, !4, i64 2, !11, i64 4, !4, i64 6, !11, i64 8, !4, i64 10, !11, i64 12, !4, i64 14, !11, i64 16, !4, i64 18, !11, i64 20, !4, i64 22}
!11 = !{!"short", !4, i64 0}
!12 = !{!"_ZTS12AddressSpace", !13, i64 0, !14, i64 8, !13, i64 16, !14, i64 24, !13, i64 32, !14, i64 40, !13, i64 48, !14, i64 56, !13, i64 64, !14, i64 72, !13, i64 80, !14, i64 88}
!13 = !{!"long", !4, i64 0}
!14 = !{!"_ZTS3Reg", !4, i64 0, !3, i64 4}
!15 = !{!"_ZTS3GPR", !13, i64 0, !14, i64 8, !13, i64 16, !14, i64 24, !13, i64 32, !14, i64 40, !13, i64 48, !14, i64 56, !13, i64 64, !14, i64 72, !13, i64 80, !14, i64 88, !13, i64 96, !14, i64 104, !13, i64 112, !14, i64 120, !13, i64 128, !14, i64 136, !13, i64 144, !14, i64 152, !13, i64 160, !14, i64 168, !13, i64 176, !14, i64 184, !13, i64 192, !14, i64 200, !13, i64 208, !14, i64 216, !13, i64 224, !14, i64 232, !13, i64 240, !14, i64 248, !13, i64 256, !14, i64 264}
!16 = !{!"_ZTS8X87Stack", !4, i64 0}
!17 = !{!"_ZTS3MMX", !4, i64 0}
!18 = !{!"_ZTS14FPUStatusFlags", !4, i64 0, !4, i64 1, !4, i64 2, !4, i64 3, !4, i64 4, !4, i64 5, !4, i64 6, !4, i64 7, !4, i64 8, !4, i64 9, !4, i64 10, !4, i64 11, !4, i64 12, !4, i64 13, !4, i64 14, !4, i64 15, !4, i64 16, !4, i64 17, !4, i64 18, !4, i64 19, !4, i64 20}
!19 = !{!"_ZTS13SegmentCaches", !20, i64 0, !20, i64 16, !20, i64 32, !20, i64 48, !20, i64 64, !20, i64 80}
!20 = !{!"_ZTS13SegmentShadow", !4, i64 0, !3, i64 8, !3, i64 12}
!21 = !{!8, !4, i64 2067}
!22 = !{!8, !4, i64 2069}
!23 = !{!8, !4, i64 2071}
!24 = !{!8, !4, i64 2073}
!25 = !{!8, !4, i64 2077}
!26 = !{!27, !28, i64 0}
!27 = !{!"_ZTS9ArchState", !28, i64 0, !3, i64 4, !4, i64 8}
!28 = !{!"_ZTSN14AsyncHyperCall4NameE", !4, i64 0}
