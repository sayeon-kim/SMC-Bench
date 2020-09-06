; ModuleID = 'smc5.c'
source_filename = "smc5.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [48 x i8] c"Error while changing page permissions of foo()\0A\00", align 1
@err_string = dso_local global i8* getelementptr inbounds ([48 x i8], [48 x i8]* @.str, i32 0, i32 0), align 8
@default1 = dso_local global [3 x i32] zeroinitializer, align 4
@default2 = dso_local global [3 x i32] zeroinitializer, align 4
@vec1 = dso_local global [3 x i32] [i32 22, i32 0, i32 25], align 4
@vec2 = dso_local global [3 x i32] [i32 7, i32 429, i32 6], align 4
@.str.1 = private unnamed_addr constant [4 x i8] c"%d\0A\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 {
  %1 = alloca i8*, align 8
  %2 = alloca i8*, align 8
  %3 = alloca i8*, align 8
  %4 = alloca i8*, align 8
  %5 = alloca i8*, align 8
  %6 = alloca i8*, align 8
  %7 = alloca i8*, align 8
  %8 = alloca i8*, align 8
  %9 = alloca i8*, align 8
  %10 = alloca i8*, align 8
  %11 = alloca i8*, align 8
  %12 = alloca i8*, align 8
  %13 = alloca i8*, align 8
  %14 = alloca i8*, align 8
  %15 = alloca i8*, align 8
  %16 = alloca i8*, align 8
  %17 = alloca i32, align 4
  store i8* getelementptr (i8, i8* bitcast (i32 ()* @main to i8*), i64 401), i8** %1, align 8
  store i8* getelementptr (i8, i8* bitcast (i32 ()* @main to i8*), i64 407), i8** %2, align 8
  store i8* getelementptr (i8, i8* bitcast (i32 ()* @main to i8*), i64 413), i8** %3, align 8
  store i8* getelementptr (i8, i8* bitcast (i32 ()* @main to i8*), i64 416), i8** %4, align 8
  store i8* getelementptr (i8, i8* bitcast (i32 ()* @main to i8*), i64 422), i8** %5, align 8
  store i8* getelementptr (i8, i8* bitcast (i32 ()* @main to i8*), i64 428), i8** %6, align 8
  store i8* getelementptr (i8, i8* bitcast (i32 ()* @main to i8*), i64 434), i8** %7, align 8
  store i8* getelementptr (i8, i8* bitcast (i32 ()* @main to i8*), i64 437), i8** %8, align 8
  store i8* getelementptr (i8, i8* bitcast (i32 ()* @main to i8*), i64 468), i8** %9, align 8
  store i8* getelementptr (i8, i8* bitcast (i32 ()* @main to i8*), i64 474), i8** %10, align 8
  store i8* getelementptr (i8, i8* bitcast (i32 ()* @main to i8*), i64 480), i8** %11, align 8
  store i8* getelementptr (i8, i8* bitcast (i32 ()* @main to i8*), i64 483), i8** %12, align 8
  store i8* getelementptr (i8, i8* bitcast (i32 ()* @main to i8*), i64 489), i8** %13, align 8
  store i8* getelementptr (i8, i8* bitcast (i32 ()* @main to i8*), i64 495), i8** %14, align 8
  store i8* getelementptr (i8, i8* bitcast (i32 ()* @main to i8*), i64 501), i8** %15, align 8
  store i8* getelementptr (i8, i8* bitcast (i32 ()* @main to i8*), i64 504), i8** %16, align 8
  call void @get_permission(i8* bitcast (i32 ()* @main to i8*))
  store i32 0, i32* %17, align 4
  br label %18

18:                                               ; preds = %0
  %19 = load i8*, i8** %1, align 8
  %20 = load i8*, i8** %9, align 8
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %19, i8* align 1 %20, i64 6, i1 false)
  %21 = load i8*, i8** %2, align 8
  %22 = load i8*, i8** %10, align 8
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %21, i8* align 1 %22, i64 6, i1 false)
  %23 = load i8*, i8** %3, align 8
  %24 = load i8*, i8** %11, align 8
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %23, i8* align 1 %24, i64 3, i1 false)
  %25 = load i8*, i8** %4, align 8
  %26 = load i8*, i8** %12, align 8
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %25, i8* align 1 %26, i64 6, i1 false)
  %27 = load i8*, i8** %5, align 8
  %28 = load i8*, i8** %13, align 8
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %27, i8* align 1 %28, i64 6, i1 false)
  %29 = load i8*, i8** %6, align 8
  %30 = load i8*, i8** %14, align 8
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %29, i8* align 1 %30, i64 6, i1 false)
  %31 = load i8*, i8** %7, align 8
  %32 = load i8*, i8** %15, align 8
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %31, i8* align 1 %32, i64 6, i1 false)
  %33 = load i8*, i8** %8, align 8
  %34 = load i8*, i8** %16, align 8
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %33, i8* align 1 %34, i64 3, i1 false)
  br label %35

35:                                               ; preds = %18
  %36 = load i32, i32* getelementptr inbounds ([3 x i32], [3 x i32]* @default1, i64 0, i64 0), align 4
  %37 = load i32, i32* getelementptr inbounds ([3 x i32], [3 x i32]* @default2, i64 0, i64 0), align 4
  %38 = mul nsw i32 %36, %37
  %39 = load i32, i32* %17, align 4
  %40 = add nsw i32 %39, %38
  store i32 %40, i32* %17, align 4
  %41 = load i32, i32* getelementptr inbounds ([3 x i32], [3 x i32]* @default1, i64 0, i64 1), align 4
  %42 = load i32, i32* getelementptr inbounds ([3 x i32], [3 x i32]* @default2, i64 0, i64 1), align 4
  %43 = mul nsw i32 %41, %42
  %44 = load i32, i32* %17, align 4
  %45 = add nsw i32 %44, %43
  store i32 %45, i32* %17, align 4
  %46 = load i32, i32* %17, align 4
  %47 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.1, i64 0, i64 0), i32 %46)
  %48 = load i32, i32* getelementptr inbounds ([3 x i32], [3 x i32]* @vec1, i64 0, i64 0), align 4
  %49 = load i32, i32* getelementptr inbounds ([3 x i32], [3 x i32]* @vec2, i64 0, i64 0), align 4
  %50 = mul nsw i32 %48, %49
  %51 = load i32, i32* %17, align 4
  %52 = add nsw i32 %51, %50
  store i32 %52, i32* %17, align 4
  %53 = load i32, i32* getelementptr inbounds ([3 x i32], [3 x i32]* @vec1, i64 0, i64 2), align 4
  %54 = load i32, i32* getelementptr inbounds ([3 x i32], [3 x i32]* @vec2, i64 0, i64 2), align 4
  %55 = mul nsw i32 %53, %54
  %56 = load i32, i32* %17, align 4
  %57 = add nsw i32 %56, %55
  store i32 %57, i32* %17, align 4
  ret i32 0
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

declare dso_local i32 @printf(i8*, ...) #2

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
