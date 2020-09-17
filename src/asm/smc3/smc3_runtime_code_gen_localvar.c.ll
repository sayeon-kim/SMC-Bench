; ModuleID = 'smc3_runtime_code_gen_localvar.c'
source_filename = "smc3_runtime_code_gen_localvar.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@arr = dso_local global [10 x i32] [i32 1, i32 2, i32 3, i32 4, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0], align 16
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
  %15 = alloca i32, align 4
  %16 = alloca i32, align 4
  %17 = alloca i32, align 4
  store i32 0, i32* %1, align 4
  %18 = bitcast [3 x i32]* %3 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %18, i8* align 4 bitcast ([3 x i32]* @__const.main.vec1 to i8*), i64 12, i1 false)
  %19 = bitcast [3 x i32]* %4 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %19, i8* align 4 bitcast ([3 x i32]* @__const.main.vec2 to i8*), i64 12, i1 false)
  store i32 0, i32* %5, align 4
  call void @get_permission(i8* bitcast (i32 ()* @main to i8*))
  store i32 0, i32* %14, align 4
  br label %20

20:                                               ; preds = %141, %0
  store i32 3, i32* %10, align 4
  store i32 0, i32* %11, align 4
  store i8* getelementptr inbounds (i8, i8* bitcast (i32 ()* @main to i8*), i64 521), i8** %6, align 8
  store i8* getelementptr inbounds (i8, i8* bitcast (i32 ()* @main to i8*), i64 500), i8** %7, align 8
  store i32 0, i32* %15, align 4
  br label %21

21:                                               ; preds = %34, %20
  %22 = load i32, i32* %15, align 4
  %23 = icmp slt i32 %22, 7
  br i1 %23, label %24, label %37

24:                                               ; preds = %21
  %25 = load i8*, i8** %7, align 8
  %26 = load i32, i32* %15, align 4
  %27 = sext i32 %26 to i64
  %28 = getelementptr inbounds i8, i8* %25, i64 %27
  %29 = load i8, i8* %28, align 1
  %30 = load i8*, i8** %6, align 8
  %31 = load i32, i32* %15, align 4
  %32 = sext i32 %31 to i64
  %33 = getelementptr inbounds i8, i8* %30, i64 %32
  store i8 %29, i8* %33, align 1
  br label %34

34:                                               ; preds = %24
  %35 = load i32, i32* %15, align 4
  %36 = add nsw i32 %35, 1
  store i32 %36, i32* %15, align 4
  br label %21

37:                                               ; preds = %21
  %38 = load i8*, i8** %6, align 8
  %39 = getelementptr inbounds i8, i8* %38, i64 7
  store i8* %39, i8** %6, align 8
  br label %40

40:                                               ; preds = %97, %37
  %41 = load i32, i32* %11, align 4
  %42 = load i32, i32* %10, align 4
  %43 = icmp eq i32 %41, %42
  br i1 %43, label %44, label %45

44:                                               ; preds = %40
  br label %100

45:                                               ; preds = %40
  %46 = load i32, i32* %11, align 4
  %47 = sext i32 %46 to i64
  %48 = getelementptr inbounds [3 x i32], [3 x i32]* %3, i64 0, i64 %47
  %49 = load i32, i32* %48, align 4
  store i32 %49, i32* %12, align 4
  %50 = load i32, i32* %12, align 4
  %51 = icmp eq i32 %50, 0
  br i1 %51, label %52, label %53

52:                                               ; preds = %45
  br label %97

53:                                               ; preds = %45
  %54 = load i32, i32* %14, align 4
  %55 = add nsw i32 %54, 1
  store i32 %55, i32* %14, align 4
  %56 = load i8*, i8** %7, align 8
  %57 = getelementptr inbounds i8, i8* %56, i64 7
  store i8* %57, i8** %9, align 8
  store i32 0, i32* %16, align 4
  br label %58

58:                                               ; preds = %71, %53
  %59 = load i32, i32* %16, align 4
  %60 = icmp slt i32 %59, 12
  br i1 %60, label %61, label %74

61:                                               ; preds = %58
  %62 = load i8*, i8** %9, align 8
  %63 = load i32, i32* %16, align 4
  %64 = sext i32 %63 to i64
  %65 = getelementptr inbounds i8, i8* %62, i64 %64
  %66 = load i8, i8* %65, align 1
  %67 = load i8*, i8** %6, align 8
  %68 = load i32, i32* %16, align 4
  %69 = sext i32 %68 to i64
  %70 = getelementptr inbounds i8, i8* %67, i64 %69
  store i8 %66, i8* %70, align 1
  br label %71

71:                                               ; preds = %61
  %72 = load i32, i32* %16, align 4
  %73 = add nsw i32 %72, 1
  store i32 %73, i32* %16, align 4
  br label %58

74:                                               ; preds = %58
  %75 = load i32, i32* %11, align 4
  %76 = mul nsw i32 %75, 4
  %77 = trunc i32 %76 to i8
  %78 = zext i8 %77 to i32
  %79 = load i8*, i8** %6, align 8
  %80 = getelementptr inbounds i8, i8* %79, i64 2
  %81 = load i8, i8* %80, align 1
  %82 = zext i8 %81 to i32
  %83 = add nsw i32 %82, %78
  %84 = trunc i32 %83 to i8
  store i8 %84, i8* %80, align 1
  %85 = load i32, i32* %11, align 4
  %86 = mul nsw i32 %85, 4
  %87 = trunc i32 %86 to i8
  %88 = zext i8 %87 to i32
  %89 = load i8*, i8** %6, align 8
  %90 = getelementptr inbounds i8, i8* %89, i64 2
  %91 = load i8, i8* %90, align 1
  %92 = zext i8 %91 to i32
  %93 = add nsw i32 %92, %88
  %94 = trunc i32 %93 to i8
  store i8 %94, i8* %90, align 1
  %95 = load i8*, i8** %6, align 8
  %96 = getelementptr inbounds i8, i8* %95, i64 12
  store i8* %96, i8** %6, align 8
  br label %97

97:                                               ; preds = %74, %52
  %98 = load i32, i32* %11, align 4
  %99 = add nsw i32 %98, 1
  store i32 %99, i32* %11, align 4
  br label %40

100:                                              ; preds = %44
  %101 = load i8*, i8** %7, align 8
  %102 = getelementptr inbounds i8, i8* %101, i64 7
  %103 = getelementptr inbounds i8, i8* %102, i64 12
  store i8* %103, i8** %8, align 8
  store i32 0, i32* %17, align 4
  br label %104

104:                                              ; preds = %117, %100
  %105 = load i32, i32* %17, align 4
  %106 = icmp slt i32 %105, 2
  br i1 %106, label %107, label %120

107:                                              ; preds = %104
  %108 = load i8*, i8** %8, align 8
  %109 = load i32, i32* %17, align 4
  %110 = sext i32 %109 to i64
  %111 = getelementptr inbounds i8, i8* %108, i64 %110
  %112 = load i8, i8* %111, align 1
  %113 = load i8*, i8** %6, align 8
  %114 = load i32, i32* %17, align 4
  %115 = sext i32 %114 to i64
  %116 = getelementptr inbounds i8, i8* %113, i64 %115
  store i8 %112, i8* %116, align 1
  br label %117

117:                                              ; preds = %107
  %118 = load i32, i32* %17, align 4
  %119 = add nsw i32 %118, 1
  store i32 %119, i32* %17, align 4
  br label %104

120:                                              ; preds = %104
  %121 = load i32, i32* %14, align 4
  %122 = mul nsw i32 %121, 20
  %123 = load i8*, i8** %6, align 8
  %124 = getelementptr inbounds i8, i8* %123, i64 1
  %125 = load i8, i8* %124, align 1
  %126 = zext i8 %125 to i32
  %127 = sub nsw i32 %126, %122
  %128 = trunc i32 %127 to i8
  store i8 %128, i8* %124, align 1
  br label %141

129:                                              ; preds = %133
  %130 = load i32, i32* %2, align 4
  store i32 %130, i32* %5, align 4
  %131 = load i32, i32* %5, align 4
  %132 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.1, i64 0, i64 0), i32 %131)
  br label %133

133:                                              ; preds = %129
  store i32 0, i32* %2, align 4
  %134 = load i32, i32* %2, align 4
  %135 = getelementptr inbounds [3 x i32], [3 x i32]* %3, i64 0, i64 1
  %136 = load i32, i32* %135, align 4
  %137 = getelementptr inbounds [3 x i32], [3 x i32]* %4, i64 0, i64 1
  %138 = load i32, i32* %137, align 4
  %139 = mul nsw i32 %136, %138
  %140 = add nsw i32 %134, %139
  store i32 %140, i32* %2, align 4
  br label %129

141:                                              ; preds = %120
  br label %20
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





 clang-9 -c -emit-llvm -S -target x86_64-pc-linux-gnu smc3_runtime_code_gen_localvar.c 
