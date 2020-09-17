; ModuleID = 'smc6.c'
source_filename = "smc6.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [48 x i8] c"Error while changing page permissions of foo()\0A\00", align 1
@err_string = dso_local global i8* getelementptr inbounds ([48 x i8], [48 x i8]* @.str, i32 0, i32 0), align 8
@store_instruction = dso_local global [44 x i8] c"\C7E\A8\00\00\00\00\EB\1D\8BE\A8Hc\D0H\8BE\B8H\01\C2\8BE\A8H\98\0F\B6D\05\C0\88\02\83E\A8\01\83}\A8\04~\DD", align 16
@jr_instruction = dso_local global [2 x i8] c"\EB\00", align 1
@.str.1 = private unnamed_addr constant [6 x i8] c"\E98\FF\FF\FF\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i8*, align 8
  ; unsigned char*  ptr_reg9
  %3 = alloca i8*, align 8
  ; unsigned char*  ptr_reg4
  %4 = alloca [44 x i8], align 16
  ; unsigned char   reg8[MAX(SIZE_OF_SW, SIZE_OF_JR)]
  %5 = alloca i32, align 4
  ; int i
  %6 = alloca i32, align 4
  ; int dummy
  store i32 0, i32* %1, align 4
  br label %7


;start: 
7:                                                ; preds = %0
  call void @get_permission(i8* bitcast (i32 ()* @main to i8*))
  get_permission(main)
  store i8* getelementptr inbounds (i8, i8* bitcast (i32 ()* @main to i8*), i64 259), i8** %2, align 8
  ; ptr_reg9 = (unsigned char*)main + GEN
  %8 = getelementptr inbounds [44 x i8], [44 x i8]* %4, i64 0, i64 0
  ; %8 = reg8
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %8, i8* align 16 getelementptr inbounds ([44 x i8], [44 x i8]* @store_instruction, i64 0, i64 0), i64 44, i1 false)
  ; memcpy(reg8, store_instruction, SIZE_OF_SW)

  ;%9 라벨부터 %25라벨까지
  ; for(i = 0; i < SIZE_OF_SW; i++) ptr_reg9[i] = reg8[i];
  ; 해당 부분
  store i32 0, i32* %5, align 4
  ; for(i = 0; 초기화부분
  br label %9

9:                                                ; preds = %21, %7
  %10 = load i32, i32* %5, align 4
  ; %10 = i
  %11 = icmp slt i32 %10, 44
  ; for(i = 0; i < SIZE_OF_SW;
  br i1 %11, label %12, label %24

12:                                               ; preds = %9
  %13 = load i32, i32* %5, align 4
  %14 = sext i32 %13 to i64
  %15 = getelementptr inbounds [44 x i8], [44 x i8]* %4, i64 0, i64 %14
  %16 = load i8, i8* %15, align 1
  ; reg8[i]
  %17 = load i8*, i8** %2, align 8
  %18 = load i32, i32* %5, align 4
  %19 = sext i32 %18 to i64
  %20 = getelementptr inbounds i8, i8* %17, i64 %19
  ; ptr_reg9[i]
  store i8 %16, i8* %20, align 1
  ; ptr_reg9[i] = reg8[i]
  br label %21

21:                                               ; preds = %12
  %22 = load i32, i32* %5, align 4
  %23 = add nsw i32 %22, 1
  store i32 %23, i32* %5, align 4
  ; for(i = 0; i < SIZE_OF_SW; i++
  br label %9

24:                                               ; preds = %9
  %25 = getelementptr inbounds [44 x i8], [44 x i8]* %4, i64 0, i64 0
  ; %25 = reg8
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %25, i8* align 1 getelementptr inbounds ([2 x i8], [2 x i8]* @jr_instruction, i64 0, i64 0), i64 2, i1 false)
  ; memcpy(reg8, jr_instruction, SIZE_OF_JR)


  ; %26라벨부터 %42라벨 전까지
  ; for(i =  0; i < SIZE_OF_JR; i++) (ptr_reg9 + SIZE_OF_SW)[i] = reg8[i]
  ; 해당 부분
  store i32 0, i32* %5, align 4
  ; for(i = 0; 초기화 부분
  br label %26

26:                                               ; preds = %39, %24
  %27 = load i32, i32* %5, align 4
  %28 = icmp slt i32 %27, 2
  ; for(i =  0; i < SIZE_OF_JR;
  br i1 %28, label %29, label %42

29:                                               ; preds = %26
  %30 = load i32, i32* %5, align 4
  %31 = sext i32 %30 to i64
  %32 = getelementptr inbounds [44 x i8], [44 x i8]* %4, i64 0, i64 %31
  %33 = load i8, i8* %32, align 1
  ; %33 = reg8[i]
  %34 = load i8*, i8** %2, align 8
  ; %34 = ptr_reg9
  %35 = getelementptr inbounds i8, i8* %34, i64 44
  ; ptr_reg9 + SIZE_OF_SW
  %36 = load i32, i32* %5, align 4
  %37 = sext i32 %36 to i64
  %38 = getelementptr inbounds i8, i8* %35, i64 %37
  ; (ptr_reg9 + SIZE_OF_SW)[i]
  store i8 %33, i8* %38, align 1
  ; (ptr_reg9 + SIZE_OF_SW)[i] = reg8[i]
  br label %39

39:                                               ; preds = %29
  %40 = load i32, i32* %5, align 4
  %41 = add nsw i32 %40, 1
  store i32 %41, i32* %5, align 4
  ; for(i =  0; i < SIZE_OF_JR; i++
  br label %26

42:                                               ; preds = %26
  store i8* getelementptr inbounds (i8, i8* bitcast (i32 ()* @main to i8*), i64 305), i8** %3, align 8
  ; ptr_reg4 = (unsigned char*)main + GGEN
  store i8* getelementptr inbounds (i8, i8* bitcast (i32 ()* @main to i8*), i64 23), i8** %2, align 8
  ; ptr_reg9 = (unsigned char*)main + START
  %43 = getelementptr inbounds [44 x i8], [44 x i8]* %4, i64 0, i64 0
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %43, i8* align 1 getelementptr inbounds ([6 x i8], [6 x i8]* @.str.1, i64 0, i64 0), i64 5, i1 false)
  ; memcpy(reg8, "\xe9\x38\xff\xff\xff", SIZE_OF_JMPQ) 
  br label %44
  ; goto gen


;gen: 
44:                                               ; preds = %42
  %45 = load i32, i32* %6, align 4
  %46 = add nsw i32 %45, 1
  store i32 %46, i32* %6, align 4
  ; dummy++;
  %47 = load i32, i32* %6, align 4
  %48 = add nsw i32 %47, 1
  store i32 %48, i32* %6, align 4
  ;  dummy++;
  %49 = load i32, i32* %6, align 4
  %50 = add nsw i32 %49, 1
  store i32 %50, i32* %6, align 4
  ;  dummy++;
  %51 = load i32, i32* %6, align 4
  %52 = add nsw i32 %51, 1
  store i32 %52, i32* %6, align 4
  ;  dummy++;
  %53 = load i32, i32* %6, align 4
  %54 = add nsw i32 %53, 1
  store i32 %54, i32* %6, align 4
  ;  dummy++;
  %55 = load i32, i32* %6, align 4
  %56 = add nsw i32 %55, 1
  store i32 %56, i32* %6, align 4
  ;  dummy++;
  %57 = load i32, i32* %6, align 4
  %58 = add nsw i32 %57, 1
  store i32 %58, i32* %6, align 4
  ;  dummy++;
  %59 = load i32, i32* %6, align 4
  %60 = add nsw i32 %59, 1
  store i32 %60, i32* %6, align 4
  ;  dummy++;
  %61 = load i32, i32* %6, align 4
  %62 = add nsw i32 %61, 1
  store i32 %62, i32* %6, align 4
  ;  dummy++;
  %63 = load i32, i32* %6, align 4
  %64 = add nsw i32 %63, 1
  store i32 %64, i32* %6, align 4
  ;  dummy++;
  %65 = load i32, i32* %6, align 4
  %66 = mul nsw i32 %65, 2
  store i32 %66, i32* %6, align 4
  ; dummy*=2
  %67 = load i32, i32* %6, align 4
  %68 = mul nsw i32 %67, 2
  store i32 %68, i32* %6, align 4
  ; dummy*=2
  br label %69

;ggen:
69:                                               ; preds = %44
  ret i32 0
  ; return 0
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @get_permission(i8*) #0 {
  %2 = alloca i8*, align 8
  store i8* %0, i8** %2, align 8
  %3 = load i8*, i8** %2, align 8
  %4 = call i32 @change_page_permissions_of_address(i8* %3)
  %5 = icmp eq i32 %4, -1
  br i1 %5, label %6, label %12

6:                                                ; preds = %1
  %7 = load i8*, i8** @err_string, align 8
  %8 = load i8*, i8** @err_string, align 8
  %9 = call i64 @strlen(i8* %8) #6
  %10 = add i64 %9, 1
  %11 = call i64 @write(i32 2, i8* %7, i64 %10)
  call void @exit(i32 1) #7
  unreachable

12:                                               ; preds = %1
  ret void
}

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture writeonly, i8* nocapture readonly, i64, i1 immarg) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @change_page_permissions_of_address(i8*) #0 {
  %2 = alloca i32, align 4
  %3 = alloca i8*, align 8
  %4 = alloca i32, align 4
  store i8* %0, i8** %3, align 8
  store i32 4096, i32* %4, align 4
  %5 = load i8*, i8** %3, align 8
  %6 = ptrtoint i8* %5 to i64
  %7 = load i32, i32* %4, align 4
  %8 = sext i32 %7 to i64
  %9 = urem i64 %6, %8
  %10 = load i8*, i8** %3, align 8
  %11 = sub i64 0, %9
  %12 = getelementptr i8, i8* %10, i64 %11
  store i8* %12, i8** %3, align 8
  %13 = load i8*, i8** %3, align 8
  %14 = load i32, i32* %4, align 4
  %15 = sext i32 %14 to i64
  %16 = call i32 @mprotect(i8* %13, i64 %15, i32 7) #8
  %17 = icmp eq i32 %16, -1
  br i1 %17, label %18, label %19

18:                                               ; preds = %1
  store i32 -1, i32* %2, align 4
  br label %20

19:                                               ; preds = %1
  store i32 0, i32* %2, align 4
  br label %20

20:                                               ; preds = %19, %18
  %21 = load i32, i32* %2, align 4
  ret i32 %21
}

declare dso_local i64 @write(i32, i8*, i64) #2

; Function Attrs: nounwind readonly
declare dso_local i64 @strlen(i8*) #3

; Function Attrs: noreturn nounwind
declare dso_local void @exit(i32) #4

; Function Attrs: nounwind
declare dso_local i32 @mprotect(i8*, i64, i32) #5

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { argmemonly nounwind }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind readonly "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { noreturn nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #6 = { nounwind readonly }
attributes #7 = { noreturn nounwind }
attributes #8 = { nounwind }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 9.0.0-2~ubuntu18.04.2 (tags/RELEASE_900/final)"}




clang-9 -c -emit-llvm -S -target x86_64-pc-linux-gnu smc4.c
