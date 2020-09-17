; ModuleID = 'smc3_test.c'
source_filename = "smc3_test.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [48 x i8] c"Error while changing page permissions of foo()\0A\00", align 1
@err_string = dso_local global i8* getelementptr inbounds ([48 x i8], [48 x i8]* @.str, i32 0, i32 0), align 8
@__const.main.vec1 = private unnamed_addr constant [3 x i32] [i32 22, i32 0, i32 25], align 4
@__const.main.vec2 = private unnamed_addr constant [3 x i32] [i32 7, i32 429, i32 6], align 4
@.str.1 = private unnamed_addr constant [5 x i8] c"%d \0A\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca [3 x i32], align 4
  %4 = alloca [3 x i32], align 4
  %5 = alloca i32, align 4
  %6 = alloca i8*, align 8
  %7 = alloca i8*, align 8
  %8 = alloca i8*, align 8
  %9 = alloca i8*, align 8
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  %13 = alloca i32, align 4
  %14 = alloca i32, align 4
  store i32 0, i32* %1, align 4
  %15 = bitcast [3 x i32]* %3 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %15, i8* align 4 bitcast ([3 x i32]* @__const.main.vec1 to i8*), i64 12, i1 false)
  %16 = bitcast [3 x i32]* %4 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %16, i8* align 4 bitcast ([3 x i32]* @__const.main.vec2 to i8*), i64 12, i1 false)
  store i32 0, i32* %5, align 4
  call void @get_permission(i8* bitcast (i32 ()* @main to i8*))
  br label %17

17:                                               ; preds = %0
  store i32 3, i32* %10, align 4
  store i32 0, i32* %11, align 4
  store i8* getelementptr inbounds (i8, i8* bitcast (i32 ()* @main to i8*), i64 483), i8** %6, align 8
  store i8* getelementptr inbounds (i8, i8* bitcast (i32 ()* @main to i8*), i64 462), i8** %7, align 8
  store i32 0, i32* %12, align 4
  br label %18

18:                                               ; preds = %31, %17
  %19 = load i32, i32* %12, align 4
  %20 = icmp slt i32 %19, 7
  br i1 %20, label %21, label %34

21:                                               ; preds = %18
  %22 = load i8*, i8** %7, align 8
  %23 = load i32, i32* %12, align 4
  %24 = sext i32 %23 to i64
  %25 = getelementptr inbounds i8, i8* %22, i64 %24
  %26 = load i8, i8* %25, align 1
  %27 = load i8*, i8** %6, align 8
  %28 = load i32, i32* %12, align 4
  %29 = sext i32 %28 to i64
  %30 = getelementptr inbounds i8, i8* %27, i64 %29
  store i8 %26, i8* %30, align 1
  br label %31

31:                                               ; preds = %21
  %32 = load i32, i32* %12, align 4
  %33 = add nsw i32 %32, 1
  store i32 %33, i32* %12, align 4
  br label %18

34:                                               ; preds = %18
  %35 = load i8*, i8** %6, align 8
  %36 = getelementptr inbounds i8, i8* %35, i64 7
  store i8* %36, i8** %6, align 8
  br label %37

37:                                               ; preds = %84, %34
  %38 = load i32, i32* %11, align 4
  %39 = load i32, i32* %10, align 4
  %40 = icmp eq i32 %38, %39
  br i1 %40, label %41, label %42

41:                                               ; preds = %37
  br label %87

42:                                               ; preds = %37
  %43 = load i8*, i8** %7, align 8
  %44 = getelementptr inbounds i8, i8* %43, i64 7
  store i8* %44, i8** %9, align 8
  store i32 0, i32* %13, align 4
  br label %45

45:                                               ; preds = %58, %42
  %46 = load i32, i32* %13, align 4
  %47 = icmp slt i32 %46, 12
  br i1 %47, label %48, label %61

48:                                               ; preds = %45
  %49 = load i8*, i8** %9, align 8
  %50 = load i32, i32* %13, align 4
  %51 = sext i32 %50 to i64
  %52 = getelementptr inbounds i8, i8* %49, i64 %51
  %53 = load i8, i8* %52, align 1
  %54 = load i8*, i8** %6, align 8
  %55 = load i32, i32* %13, align 4
  %56 = sext i32 %55 to i64
  %57 = getelementptr inbounds i8, i8* %54, i64 %56
  store i8 %53, i8* %57, align 1
  br label %58

58:                                               ; preds = %48
  %59 = load i32, i32* %13, align 4
  %60 = add nsw i32 %59, 1
  store i32 %60, i32* %13, align 4
  br label %45

61:                                               ; preds = %45
  %62 = load i32, i32* %11, align 4
  %63 = mul nsw i32 %62, 4
  %64 = trunc i32 %63 to i8
  %65 = zext i8 %64 to i32
  %66 = load i8*, i8** %6, align 8
  %67 = getelementptr inbounds i8, i8* %66, i64 2
  %68 = load i8, i8* %67, align 1
  %69 = zext i8 %68 to i32
  %70 = add nsw i32 %69, %65
  %71 = trunc i32 %70 to i8
  store i8 %71, i8* %67, align 1
  %72 = load i32, i32* %11, align 4
  %73 = mul nsw i32 %72, 4
  %74 = trunc i32 %73 to i8
  %75 = zext i8 %74 to i32
  %76 = load i8*, i8** %6, align 8
  %77 = getelementptr inbounds i8, i8* %76, i64 5
  %78 = load i8, i8* %77, align 1
  %79 = zext i8 %78 to i32
  %80 = add nsw i32 %79, %75
  %81 = trunc i32 %80 to i8
  store i8 %81, i8* %77, align 1
  %82 = load i8*, i8** %6, align 8
  %83 = getelementptr inbounds i8, i8* %82, i64 12
  store i8* %83, i8** %6, align 8
  br label %84

84:                                               ; preds = %61
  %85 = load i32, i32* %11, align 4
  %86 = add nsw i32 %85, 1
  store i32 %86, i32* %11, align 4
  br label %37

87:                                               ; preds = %41
  %88 = load i8*, i8** %7, align 8
  %89 = getelementptr inbounds i8, i8* %88, i64 7
  %90 = getelementptr inbounds i8, i8* %89, i64 12
  store i8* %90, i8** %8, align 8
  store i32 0, i32* %14, align 4
  br label %91

91:                                               ; preds = %116, %87
  %92 = load i32, i32* %14, align 4
  %93 = icmp slt i32 %92, 2
  br i1 %93, label %94, label %119

94:                                               ; preds = %91
  %95 = load i8*, i8** %8, align 8
  %96 = load i32, i32* %14, align 4
  %97 = sext i32 %96 to i64
  %98 = getelementptr inbounds i8, i8* %95, i64 %97
  %99 = load i8, i8* %98, align 1
  %100 = load i8*, i8** %6, align 8
  %101 = load i32, i32* %14, align 4
  %102 = sext i32 %101 to i64
  %103 = getelementptr inbounds i8, i8* %100, i64 %102
  store i8 %99, i8* %103, align 1
  %104 = load i32, i32* %14, align 4
  %105 = icmp eq i32 %104, 1
  br i1 %105, label %106, label %115

106:                                              ; preds = %94
  %107 = load i8*, i8** %6, align 8
  %108 = load i32, i32* %14, align 4
  %109 = sext i32 %108 to i64
  %110 = getelementptr inbounds i8, i8* %107, i64 %109
  %111 = load i8, i8* %110, align 1
  %112 = zext i8 %111 to i32
  %113 = sub nsw i32 %112, 45
  %114 = trunc i32 %113 to i8
  store i8 %114, i8* %110, align 1
  br label %115

115:                                              ; preds = %106, %94
  br label %116

116:                                              ; preds = %115
  %117 = load i32, i32* %14, align 4
  %118 = add nsw i32 %117, 1
  store i32 %118, i32* %14, align 4
  br label %91

119:                                              ; preds = %91
  br label %132

120:                                              ; preds = %132, %124
  %121 = load i32, i32* %2, align 4
  store i32 %121, i32* %5, align 4
  %122 = load i32, i32* %5, align 4
  %123 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.1, i64 0, i64 0), i32 %122)
  br label %124

124:                                              ; preds = %120
  store i32 0, i32* %2, align 4
  %125 = load i32, i32* %2, align 4
  %126 = getelementptr inbounds [3 x i32], [3 x i32]* %3, i64 0, i64 0
  %127 = load i32, i32* %126, align 4
  %128 = getelementptr inbounds [3 x i32], [3 x i32]* %4, i64 0, i64 0
  %129 = load i32, i32* %128, align 4
  %130 = mul nsw i32 %127, %129
  %131 = add nsw i32 %125, %130
  store i32 %131, i32* %2, align 4
  br label %120

132:                                              ; preds = %119
  br label %120
}

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture writeonly, i8* nocapture readonly, i64, i1 immarg) #1

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





clang-9 -c -emit-llvm -S -target x86_64-pc-linux-gnu smc3.c
