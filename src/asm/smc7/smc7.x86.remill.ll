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
  %4 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 1, i32 0, i32 0   ; %4 = eax
  %5 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 3, i32 0, i32 0   ; %5 = ebx
  %6 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 5, i32 0, i32 0   ; %6 = ecx
  %7 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 9, i32 0, i32 0   ; %7 = esi
  %8 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 11, i32 0, i32 0  ; %8 = edi
  %9 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 15, i32 0, i32 0  ; %9 = ebp?
  %10 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 33, i32 0, i32 0 ; %10 = eip
  store i32 2, i32* %7, align 4, !tbaa !0 ; esi <- 2
  store i32 4, i32* %8, align 4, !tbaa !0 ; edi <- 4
  %11 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 2, i32 1  ; arithflags
  %12 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 2, i32 5
  %13 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 2, i32 9
  br label %14

; loop
; <label>:14:                                     ; preds = %14, %3
  %15 = phi i32 [ 51, %3 ], [ %21, %14 ]          ; 51 = address of new
  %16 = phi i32 [ 31, %3 ], [ %20, %14 ]          ; 31 = address of loop
  %17 = phi %struct.Memory* [ %2, %3 ], [ %19, %14 ]
  %18 = tail call i32 @__remill_read_memory_32(%struct.Memory* %17, i32 %16) #3                       ; mov edx, [eax](read intruction of loop)
  %19 = tail call %struct.Memory* @__remill_write_memory_32(%struct.Memory* %17, i32 %15, i32 %18) #3 ; mov [ebx], edx(write instruction of loop to new)
  %20 = add i32 %16, 2            ; eax += 2
  %21 = add i32 %15, 2            ; ebx += 2
  %22 = icmp eq i32 %16, 49       ; cmp eax, ecx
  br i1 %22, label %23, label %14 ; jne loop

; if eax and address of new  not equal than jump loop

; <label>:23:                                     ; preds = %14
  %24 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 7, i32 0, i32 0  ; %24 = edx
  %25 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 2, i32 3                ; arithflags
  %26 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 2, i32 7  
  %27 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 2, i32 13
  store i32 %18, i32* %24, align 4, !tbaa !0  ; %18 <- edx
  store i32 %21, i32* %5, align 4             ; %21 <- ebx
  store i32 %21, i32* %6, align 4, !tbaa !0   ; %21 <- ecx
  store i32 2, i32* %9, align 4, !tbaa !0     ; ebp <- 2
  store i8 1, i8* %11, align 1, !tbaa !4      ; arithflag <- 0 or 1
  store i8 0, i8* %25, align 1, !tbaa !18 
  store i8 1, i8* %12, align 1, !tbaa !19
  store i8 0, i8* %26, align 1, !tbaa !20
  store i8 1, i8* %13, align 1, !tbaa !21
  store i8 0, i8* %27, align 1, !tbaa !22

  store i32 1, i32* %4, align 4, !tbaa !0     ; eax <- 1
  %28 = add i32 %1, 100
  store i32 %28, i32* %10, align 4 ; eip <- PC + 100
  ; int 0x80
  %29 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 0, i32 2
  %30 = bitcast %union.anon* %29 to i32*
  store i32 128, i32* %30, align 8, !tbaa !0
  %31 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 0, i32 0
  store i32 4, i32* %31, align 16, !tbaa !23
  %32 = tail call %struct.Memory* @__remill_async_hyper_call(%struct.State* nonnull %0, i32 %28, %struct.Memory* %19)
  %33 = load i32, i32* %10, align 4
  %34 = tail call %struct.Memory* @__remill_missing_block(%struct.State* nonnull %0, i32 %33, %struct.Memory* %19)
  ret %struct.Memory* %34
}

; Function Attrs: noduplicate noinline nounwind optnone readnone
declare i32 @__remill_read_memory_32(%struct.Memory*, i32) #1

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

!0 = !{!1, !1, i64 0}
!1 = !{!"int", !2, i64 0}
!2 = !{!"omnipotent char", !3, i64 0}
!3 = !{!"Simple C++ TBAA"}
!4 = !{!5, !2, i64 2065}
!5 = !{!"_ZTS5State", !2, i64 16, !6, i64 2064, !2, i64 2080, !7, i64 2088, !9, i64 2112, !12, i64 2208, !13, i64 2480, !14, i64 2608, !15, i64 2736, !2, i64 2760, !2, i64 2768, !16, i64 3280}
!6 = !{!"_ZTS10ArithFlags", !2, i64 0, !2, i64 1, !2, i64 2, !2, i64 3, !2, i64 4, !2, i64 5, !2, i64 6, !2, i64 7, !2, i64 8, !2, i64 9, !2, i64 10, !2, i64 11, !2, i64 12, !2, i64 13, !2, i64 14, !2, i64 15}
!7 = !{!"_ZTS8Segments", !8, i64 0, !2, i64 2, !8, i64 4, !2, i64 6, !8, i64 8, !2, i64 10, !8, i64 12, !2, i64 14, !8, i64 16, !2, i64 18, !8, i64 20, !2, i64 22}
!8 = !{!"short", !2, i64 0}
!9 = !{!"_ZTS12AddressSpace", !10, i64 0, !11, i64 8, !10, i64 16, !11, i64 24, !10, i64 32, !11, i64 40, !10, i64 48, !11, i64 56, !10, i64 64, !11, i64 72, !10, i64 80, !11, i64 88}
!10 = !{!"long", !2, i64 0}
!11 = !{!"_ZTS3Reg", !2, i64 0, !1, i64 4}
!12 = !{!"_ZTS3GPR", !10, i64 0, !11, i64 8, !10, i64 16, !11, i64 24, !10, i64 32, !11, i64 40, !10, i64 48, !11, i64 56, !10, i64 64, !11, i64 72, !10, i64 80, !11, i64 88, !10, i64 96, !11, i64 104, !10, i64 112, !11, i64 120, !10, i64 128, !11, i64 136, !10, i64 144, !11, i64 152, !10, i64 160, !11, i64 168, !10, i64 176, !11, i64 184, !10, i64 192, !11, i64 200, !10, i64 208, !11, i64 216, !10, i64 224, !11, i64 232, !10, i64 240, !11, i64 248, !10, i64 256, !11, i64 264}
!13 = !{!"_ZTS8X87Stack", !2, i64 0}
!14 = !{!"_ZTS3MMX", !2, i64 0}
!15 = !{!"_ZTS14FPUStatusFlags", !2, i64 0, !2, i64 1, !2, i64 2, !2, i64 3, !2, i64 4, !2, i64 5, !2, i64 6, !2, i64 7, !2, i64 8, !2, i64 9, !2, i64 10, !2, i64 11, !2, i64 12, !2, i64 13, !2, i64 14, !2, i64 15, !2, i64 16, !2, i64 17, !2, i64 18, !2, i64 19, !2, i64 20}
!16 = !{!"_ZTS13SegmentCaches", !17, i64 0, !17, i64 16, !17, i64 32, !17, i64 48, !17, i64 64, !17, i64 80}
!17 = !{!"_ZTS13SegmentShadow", !2, i64 0, !1, i64 8, !1, i64 12}
!18 = !{!5, !2, i64 2067}
!19 = !{!5, !2, i64 2069}
!20 = !{!5, !2, i64 2071}
!21 = !{!5, !2, i64 2073}
!22 = !{!5, !2, i64 2077}
!23 = !{!24, !25, i64 0}
!24 = !{!"_ZTS9ArchState", !25, i64 0, !1, i64 4, !2, i64 8}
!25 = !{!"_ZTSN14AsyncHyperCall4NameE", !2, i64 0}
