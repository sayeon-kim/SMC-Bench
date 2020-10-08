; ModuleID = 'smc2.c'
source_filename = "smc2.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct._IO_FILE = type { i32, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, %struct._IO_marker*, %struct._IO_FILE*, i32, i32, i64, i16, i8, [1 x i8], i8*, i64, i8*, i8*, i8*, i8*, i64, i32, [20 x i8] }
%struct._IO_marker = type { %struct._IO_marker*, %struct._IO_FILE*, i32 }

@stderr = external global %struct._IO_FILE*, align 8
@.str = private unnamed_addr constant [52 x i8] c"Error while changing page permissions of foo(): %s\0A\00", align 1
@.str.1 = private unnamed_addr constant [12 x i8] c"Calling foo\00", align 1
@main.shellcode = private unnamed_addr constant [30 x i8] c"H1\D2H1\C0H\BB/bin/sh\00SH\89\E7PWH\89\E6\B0;\0F\05\00", align 16
@.str.2 = private unnamed_addr constant [7 x i8] c"i: %d\0A\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i8*, align 8
  %3 = alloca [30 x i8], align 16
  store i32 0, i32* %1, align 4
  store i8* bitcast (void ()* @foo to i8*), i8** %2, align 8
  %4 = load i8*, i8** %2, align 8
  %5 = call i32 @change_page_permissions_of_address(i8* %4)
  %6 = icmp eq i32 %5, -1
  br i1 %6, label %7, label %13

; <label>:7:                                      ; preds = %0
  %8 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %9 = call i32* @__errno_location() #5
  %10 = load i32, i32* %9, align 4
  %11 = call i8* @strerror(i32 %10) #6
  %12 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %8, i8* getelementptr inbounds ([52 x i8], [52 x i8]* @.str, i32 0, i32 0), i8* %11)
  store i32 1, i32* %1, align 4
  br label %19

; <label>:13:                                     ; preds = %0
  %14 = call i32 @puts(i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.1, i32 0, i32 0))
  call void @foo()
  %15 = bitcast [30 x i8]* %3 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %15, i8* getelementptr inbounds ([30 x i8], [30 x i8]* @main.shellcode, i32 0, i32 0), i64 30, i32 16, i1 false)
  %16 = load i8*, i8** %2, align 8
  %17 = getelementptr inbounds [30 x i8], [30 x i8]* %3, i32 0, i32 0
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %16, i8* %17, i64 29, i32 1, i1 false)
  %18 = call i32 @puts(i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.1, i32 0, i32 0))
  call void @foo()
  store i32 0, i32* %1, align 4
  br label %19

; <label>:19:                                     ; preds = %13, %7
  %20 = load i32, i32* %1, align 4
  ret i32 %20
}

; Function Attrs: noinline nounwind optnone uwtable
define void @foo() #0 {
  %1 = alloca i32, align 4
  store i32 0, i32* %1, align 4
  %2 = load i32, i32* %1, align 4
  %3 = add nsw i32 %2, 1
  store i32 %3, i32* %1, align 4
  %4 = load i32, i32* %1, align 4
  %5 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.2, i32 0, i32 0), i32 %4)
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define i32 @change_page_permissions_of_address(i8*) #0 {
  %2 = alloca i32, align 4
  %3 = alloca i8*, align 8
  %4 = alloca i32, align 4
  store i8* %0, i8** %3, align 8
  %5 = call i32 @getpagesize() #5
  store i32 %5, i32* %4, align 4
  %6 = load i8*, i8** %3, align 8
  %7 = ptrtoint i8* %6 to i64
  %8 = load i32, i32* %4, align 4
  %9 = sext i32 %8 to i64
  %10 = urem i64 %7, %9
  %11 = load i8*, i8** %3, align 8
  %12 = sub i64 0, %10
  %13 = getelementptr i8, i8* %11, i64 %12
  store i8* %13, i8** %3, align 8
  %14 = load i8*, i8** %3, align 8
  %15 = load i32, i32* %4, align 4
  %16 = sext i32 %15 to i64
  %17 = call i32 @mprotect(i8* %14, i64 %16, i32 7) #6
  %18 = icmp eq i32 %17, -1
  br i1 %18, label %19, label %20

; <label>:19:                                     ; preds = %1
  store i32 -1, i32* %2, align 4
  br label %21

; <label>:20:                                     ; preds = %1
  store i32 0, i32* %2, align 4
  br label %21

; <label>:21:                                     ; preds = %20, %19
  %22 = load i32, i32* %2, align 4
  ret i32 %22
}

declare i32 @fprintf(%struct._IO_FILE*, i8*, ...) #1

; Function Attrs: nounwind
declare i8* @strerror(i32) #2

; Function Attrs: nounwind readnone
declare i32* @__errno_location() #3

declare i32 @puts(i8*) #1

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture writeonly, i8* nocapture readonly, i64, i32, i1) #4

declare i32 @printf(i8*, ...) #1

; Function Attrs: nounwind readnone
declare i32 @getpagesize() #3

; Function Attrs: nounwind
declare i32 @mprotect(i8*, i64, i32) #2

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind readnone "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { argmemonly nounwind }
attributes #5 = { nounwind readnone }
attributes #6 = { nounwind }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 6.0.0-1ubuntu2 (tags/RELEASE_600/final)"}
