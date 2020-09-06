; ModuleID = 'smc8.c'
source_filename = "smc8.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [48 x i8] c"Error while changing page permissions of foo()\0A\00", align 1
@err_string = dso_local global i8* getelementptr inbounds ([48 x i8], [48 x i8]* @.str, i32 0, i32 0), align 8
@.str.1 = private unnamed_addr constant [4 x i8] c"NOP\00", align 1
@.str.2 = private unnamed_addr constant [6 x i8] c"NOPE\0A\00", align 1
@.str.3 = private unnamed_addr constant [2 x i8] c"\8C\00", align 1
@.str.4 = private unnamed_addr constant [7 x i8] c"Alter\0A\00", align 1
@.str.5 = private unnamed_addr constant [11 x i8] c"\BF\00\00\00\00\E8\BC\FE\FF\FF\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 {
  %1 = alloca i32, align 4
  store i32 0, i32* %1, align 4
  call void @get_permission(i8* bitcast (i32 ()* @main to i8*))
  br label %2

2:                                                ; preds = %0
  %3 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.1, i64 0, i64 0))
  %4 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.1, i64 0, i64 0))
  br label %7

5:                                                ; preds = %7
  %6 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.2, i64 0, i64 0))
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 getelementptr (i8, i8* bitcast (i32 ()* @main to i8*), i64 131), i8* align 1 getelementptr inbounds ([2 x i8], [2 x i8]* @.str.3, i64 0, i64 0), i64 1, i1 false)
  br label %7

7:                                                ; preds = %5, %2
  %8 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.4, i64 0, i64 0))
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 getelementptr (i8, i8* bitcast (i32 ()* @main to i8*), i64 16), i8* align 1 getelementptr inbounds ([11 x i8], [11 x i8]* @.str.5, i64 0, i64 0), i64 10, i1 false)
  br label %5
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

declare dso_local i32 @printf(i8*, ...) #1

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture writeonly, i8* nocapture readonly, i64, i1 immarg) #2

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

declare dso_local i64 @write(i32, i8*, i64) #1

; Function Attrs: nounwind readonly
declare dso_local i64 @strlen(i8*) #3

; Function Attrs: noreturn nounwind
declare dso_local void @exit(i32) #4

; Function Attrs: nounwind
declare dso_local i32 @mprotect(i8*, i64, i32) #5

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { argmemonly nounwind }
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
