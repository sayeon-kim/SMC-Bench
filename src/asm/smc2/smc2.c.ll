; ModuleID = 'smc2.c'
source_filename = "smc2.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [48 x i8] c"Error while changing page permissions of foo()\0A\00", align 1
@err_string = dso_local global i8* getelementptr inbounds ([48 x i8], [48 x i8]* @.str, i32 0, i32 0), align 8
@.str.1 = private unnamed_addr constant [6 x i8] c"%x%x \00", align 1
@.str.2 = private unnamed_addr constant [11 x i8] c"\0Amain: %p\0A\00", align 1
@.str.3 = private unnamed_addr constant [14 x i8] c"ret_addr: %p\0A\00", align 1
@ptr_jal_f = common dso_local global i8* null, align 8
@.str.4 = private unnamed_addr constant [13 x i8] c"Working? %d\0A\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @f(i32*) #0 {
  %2 = alloca i32*, align 8
  ; int* ptr_reg8
  %3 = alloca i8*, align 8
  ; unsigned char* reg31
  %4 = alloca [5 x i8], align 1
  ; unsigned char reg9[SIZE_CALL]
  %5 = alloca i32, align 4
  ; int i
  %6 = alloca i32, align 4
  ; int j
  %7 = alloca i8*, align 8
  ; unsigned char* ret_addr
  %8 = alloca i8*, align 8
  ; unsigned char* call_addr
  %9 = alloca i64, align 8
  ; long int i_ret_addr
  %10 = alloca i8, align 1
  ; (47번 줄 for문 안에 변수) char ch
  store i32* %0, i32** %2, align 8
  %11 = load i32*, i32** %2, align 8
  ; %11 = *ptr_reg8
  store i32 42, i32* %11, align 4
  ; *ptr_reg8 = 42
  %12 = bitcast i32** %2 to i8*
  ; (unsigned char*)&ptr_reg8
  %13 = getelementptr inbounds i8, i8* %12, i64 8
  %14 = getelementptr inbounds i8, i8* %13, i64 71
  ; (unsigned char*)&ptr_reg8 + 8 + 71
  store i8* %14, i8** %3, align 8
  ; reg31 = (unsigned char*)&ptr_reg8 + 8 + 71
  store i64 0, i64* %9, align 8
  ; i_ret_addr = 0

  ;%16라벨부터 %56라벨 전까지
  ; 46 - 59번째 줄 까지의 for문 
  ; 해당되는 부분이다.
  store i32 8, i32* %5, align 4
  ; for(i=8; 초기화 부분
  br label %15

15:                                               ; preds = %53, %1
  %16 = load i32, i32* %5, align 4
  %17 = icmp sgt i32 %16, 0
  ; for(i=8; i>0; 조건부분
  br i1 %17, label %18, label %56

18:                                               ; preds = %15
  %19 = load i8*, i8** %3, align 8
  ; %19 = reg31
  %20 = load i32, i32* %5, align 4
  ; %20 = i
  %21 = sext i32 %20 to i64
  %22 = getelementptr inbounds i8, i8* %19, i64 %21
  %23 = load i8, i8* %22, align 1
  ; reg31[i]
  store i8 %23, i8* %10, align 1
  ; char ch = reg31[i];
  %24 = load i8, i8* %10, align 1
  ; %24 = ch
  %25 = sext i8 %24 to i32
  %26 = and i32 %25, 240
  ; (ch & 0xf0)
  %27 = lshr i32 %26, 4
  ; (ch & 0xf0)) >> 4
  %28 = load i8, i8* %10, align 1
  ; %28 = ch
  %29 = sext i8 %28 to i32
  %30 = and i32 %29, 15
  ; ch & 0x0f                                  
  %31 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.1, i64 0, i64 0), i32 %27, i32 %30)
  %32 = load i64, i64* %9, align 8
  ; %32 = i_ret_addr
  %33 = load i8, i8* %10, align 1
  ; %33 = ch
  %34 = sext i8 %33 to i32
  %35 = and i32 %34, 240
  ; (unsigned) (ch & 0xf0)
  %36 = lshr i32 %35, 4
  ; ((unsigned) (ch & 0xf0) >> 4
  %37 = zext i32 %36 to i64
  %38 = or i64 %32, %37
  store i64 %38, i64* %9, align 8
  ;  i_ret_addr = i_ret_addr | ((unsigned) (ch & 0xf0) >> 4)
  %39 = load i64, i64* %9, align 8
  ; %39 = i_ret_addr
  %40 = shl i64 %39, 4
  ; i_ret_addr << 4
  store i64 %40, i64* %9, align 8
  ; i_ret_addr = i_ret_addr << 4
  %41 = load i64, i64* %9, align 8
  ; %41 = i_ret_addr
  %42 = load i8, i8* %10, align 1
  %43 = sext i8 %42 to i32
  %44 = and i32 %43, 15
  ; (ch & 0x0f)
  %45 = sext i32 %44 to i64
  %46 = or i64 %41, %45
  store i64 %46, i64* %9, align 8
  ; i_ret_addr = i_ret_addr | (ch & 0x0f)
  %47 = load i32, i32* %5, align 4
  ; %47 = i
  %48 = icmp sgt i32 %47, 1
  ; if (i > 1)
  br i1 %48, label %49, label %52

49:                                               ; preds = %18
  %50 = load i64, i64* %9, align 8
  ; %5- = i_ret_addr
  %51 = shl i64 %50, 4
  ; i_ret_addr << 4
  store i64 %51, i64* %9, align 8
  ;  i_ret_addr = i_ret_addr << 4
  br label %52

52:                                               ; preds = %49, %18
  br label %53

53:                                               ; preds = %52
  %54 = load i32, i32* %5, align 4
  ; %54 = i
  %55 = add nsw i32 %54, -1
  store i32 %55, i32* %5, align 4
  ; for(i=8; i>0 ;i--) 
  br label %15

56:                                               ; preds = %15
  %57 = load i64, i64* %9, align 8
  ; %57 = i_ret_addr
  %58 = inttoptr i64 %57 to i8*
  ; (unsigned char*)i_ret_addr
  store i8* %58, i8** %7, align 8
  ; ret_addr = (unsigned char*)i_ret_addr
  %59 = load i8*, i8** %7, align 8
  ; %59 = ret_addr
  %60 = getelementptr inbounds i8, i8* %59, i64 -5
  ; ret_addr - 5
  store i8* %60, i8** %8, align 8
  ; call_addr = ret_addr - 5
  %61 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.2, i64 0, i64 0), i8* getelementptr inbounds (i8, i8* bitcast (i32 ()* @main to i8*), i64 49))
  ; printf("\nmain: %p\n", (unsigned char*)main + 44 + 5)
  %62 = load i8*, i8** %7, align 8
  %63 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.3, i64 0, i64 0), i8* %62)
  ; printf("ret_addr: %p\n", (unsigned char*)ret_addr)

  ;%64라벨 부터 %79라벨 전까지
  ; for(i=0; i<SIZE_CALL; i++) reg9[i] = call_addr[i];
  ; 해당 부분
  store i32 0, i32* %5, align 4
  ; for(i=0 초기화 부분
  br label %64

64:                                               ; preds = %76, %56
  %65 = load i32, i32* %5, align 4
  %66 = icmp slt i32 %65, 5
  ; for(i=0; i<SIZE_CALL; 조건부분
  br i1 %66, label %67, label %79

67:                                               ; preds = %64
  %68 = load i8*, i8** %8, align 8
  ; %68 = call_addr
  %69 = load i32, i32* %5, align 4
  ; %69 = i
  %70 = sext i32 %69 to i64
  %71 = getelementptr inbounds i8, i8* %68, i64 %70
  %72 = load i8, i8* %71, align 1
  ; %72 = call_addr[i]
  %73 = load i32, i32* %5, align 4
  %74 = sext i32 %73 to i64
  %75 = getelementptr inbounds [5 x i8], [5 x i8]* %4, i64 0, i64 %74
  ; %75 = reg9[i]
  store i8 %72, i8* %75, align 1
  ; reg9[i] = call_addr[i]
  br label %76

76:                                               ; preds = %67
  %77 = load i32, i32* %5, align 4
  %78 = add nsw i32 %77, 1
  store i32 %78, i32* %5, align 4
  ; for(i=0; i<SIZE_CALL; i++
  br label %64

;%79라벨부터 %103라벨까지
; 85-92까지의 for문
; 해당 내용 
79:                                               ; preds = %64
  store i32 0, i32* %5, align 4
  ; for(i=0 초기화 부분
  br label %80

80:                                               ; preds = %100, %79
  %81 = load i32, i32* %5, align 4
  %82 = icmp slt i32 %81, 5
  ; for(i=0; i<SIZE_CALL; 조건부분
  br i1 %82, label %83, label %103

83:                                               ; preds = %80
  %84 = load i32, i32* %5, align 4
  ; %54 = i
  %85 = sext i32 %84 to i64
  %86 = getelementptr inbounds [5 x i8], [5 x i8]* %4, i64 0, i64 %85
  %87 = load i8, i8* %86, align 1
  ; reg9[i]
  %88 = zext i8 %87 to i32
  %89 = load i8*, i8** @ptr_jal_f, align 8
  %90 = load i32, i32* %5, align 4
  %91 = sext i32 %90 to i64
  %92 = getelementptr inbounds i8, i8* %89, i64 %91
  ; ptr_jal_f[i]
  %93 = load i8, i8* %92, align 1
  %94 = zext i8 %93 to i32
  %95 = icmp ne i32 %88, %94
  ; if (reg9[i] != ptr_jal_f[i])
  br i1 %95, label %96, label %99

96:                                               ; preds = %83
  %97 = load i32*, i32** %2, align 8
  ; %97 = *ptr_reg8
  %98 = load i32, i32* %97, align 4
  call void @halt(i32 %98)
  ; halt( *ptr_reg8 )
  br label %99

99:                                               ; preds = %96, %83
  br label %100

100:                                              ; preds = %99
  %101 = load i32, i32* %5, align 4
  %102 = add nsw i32 %101, 1
  store i32 %102, i32* %5, align 4
  ; for(i=0; i<SIZE_CALL; i++
  br label %80

103:                                              ; preds = %80
  ret void
}

declare dso_local i32 @printf(i8*, ...) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @halt(i32) #0 {
  %2 = alloca i32, align 4
  ; %2 = reg8
  store i32 %0, i32* %2, align 4
  %3 = load i32, i32* %2, align 4
  %4 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str.4, i64 0, i64 0), i32 %3)
  ; printf("Working? %d\n", reg8)
  call void @exit(i32 0) #5
  ; exit(0)
  unreachable
}

; Function Attrs: noreturn nounwind
declare dso_local void @exit(i32) #2

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 {
  %1 = alloca i32, align 4
  ; reg8
  %2 = alloca i32, align 4
  ; ptr_jal_f
  store i32 0, i32* %1, align 4
  store i8* getelementptr inbounds (i8, i8* bitcast (i32 ()* @main to i8*), i64 44), i8** @ptr_jal_f, align 8
  ; ptr_jal_f = (unsigned char*)main + 44
  br label %3

;addr
3:                                                ; preds = %0
  call void @f(i32* %2)
  ; f( &reg8 )
  store i32 0, i32* %2, align 4
  ; reg8 = 0
  %4 = load i32, i32* %2, align 4
  call void @halt(i32 %4)
  ; halt( reg8 )
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
  call void @exit(i32 1) #5
  unreachable

12:                                               ; preds = %1
  ret void
}

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
  %16 = call i32 @mprotect(i8* %13, i64 %15, i32 7) #7
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

declare dso_local i64 @write(i32, i8*, i64) #1

; Function Attrs: nounwind readonly
declare dso_local i64 @strlen(i8*) #3

; Function Attrs: nounwind
declare dso_local i32 @mprotect(i8*, i64, i32) #4

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { noreturn nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind readonly "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { noreturn nounwind }
attributes #6 = { nounwind readonly }
attributes #7 = { nounwind }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 9.0.0-2~ubuntu18.04.2 (tags/RELEASE_900/final)"}



clang-9 -c -emit-llvm -S -target x86_64-pc-linux-gnu smc2.c
