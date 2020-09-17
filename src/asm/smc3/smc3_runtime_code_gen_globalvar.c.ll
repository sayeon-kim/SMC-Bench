; ModuleID = 'smc3_runtime_code_gen_globalvar.c'
source_filename = "smc3_runtime_code_gen_globalvar.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@vec1 = dso_local global [3 x i32] [i32 22, i32 0, i32 25], align 4
@vec2 = dso_local global [3 x i32] [i32 7, i32 429, i32 6], align 4
@result = dso_local global i32 0, align 4
@innerprod_reg2 = dso_local global i32 0, align 4
@.str = private unnamed_addr constant [48 x i8] c"Error while changing page permissions of foo()\0A\00", align 1
@err_string = dso_local global i8* getelementptr inbounds ([48 x i8], [48 x i8]* @.str, i32 0, i32 0), align 8
@.str.1 = private unnamed_addr constant [5 x i8] c"%d \0A\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i8*, align 8
  %3 = alloca i8*, align 8
  %4 = alloca i8*, align 8
  %5 = alloca i8*, align 8
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  store i32 0, i32* %1, align 4
  call void @get_permission(i8* bitcast (i32 ()* @gen to i8*))
  br label %13

13:                                               ; preds = %0
  store i32 3, i32* %6, align 4
  store i32 0, i32* %7, align 4
  store i8* getelementptr inbounds (i8, i8* bitcast (i32 ()* @gen to i8*), i64 4), i8** %2, align 8
  store i8* getelementptr inbounds (i8, i8* bitcast (i32 ()* @main to i8*), i64 418), i8** %3, align 8
  store i32 0, i32* %10, align 4
  br label %14

14:                                               ; preds = %27, %13
  %15 = load i32, i32* %10, align 4
  %16 = icmp slt i32 %15, 10
  br i1 %16, label %17, label %30

17:                                               ; preds = %14
  %18 = load i8*, i8** %3, align 8
  %19 = load i32, i32* %10, align 4
  %20 = sext i32 %19 to i64
  %21 = getelementptr inbounds i8, i8* %18, i64 %20
  %22 = load i8, i8* %21, align 1
  %23 = load i8*, i8** %2, align 8
  %24 = load i32, i32* %10, align 4
  %25 = sext i32 %24 to i64
  %26 = getelementptr inbounds i8, i8* %23, i64 %25
  store i8 %22, i8* %26, align 1
  br label %27

27:                                               ; preds = %17
  %28 = load i32, i32* %10, align 4
  %29 = add nsw i32 %28, 1
  store i32 %29, i32* %10, align 4
  br label %14

30:                                               ; preds = %14
  %31 = load i8*, i8** %2, align 8
  %32 = getelementptr inbounds i8, i8* %31, i64 10
  store i8* %32, i8** %2, align 8
  br label %33

33:                                               ; preds = %90, %30
  %34 = load i32, i32* %7, align 4
  %35 = load i32, i32* %6, align 4
  %36 = icmp eq i32 %34, %35
  br i1 %36, label %37, label %38

37:                                               ; preds = %33
  br label %93

38:                                               ; preds = %33
  %39 = load i32, i32* %7, align 4
  %40 = sext i32 %39 to i64
  %41 = getelementptr inbounds [3 x i32], [3 x i32]* @vec1, i64 0, i64 %40
  %42 = load i32, i32* %41, align 4
  store i32 %42, i32* %8, align 4
  %43 = load i32, i32* %8, align 4
  %44 = icmp eq i32 %43, 0
  br i1 %44, label %45, label %46

45:                                               ; preds = %38
  br label %90

46:                                               ; preds = %38
  %47 = load i8*, i8** %3, align 8
  %48 = getelementptr inbounds i8, i8* %47, i64 10
  store i8* %48, i8** %5, align 8
  store i32 0, i32* %11, align 4
  br label %49

49:                                               ; preds = %62, %46
  %50 = load i32, i32* %11, align 4
  %51 = icmp slt i32 %50, 29
  br i1 %51, label %52, label %65

52:                                               ; preds = %49
  %53 = load i8*, i8** %5, align 8
  %54 = load i32, i32* %11, align 4
  %55 = sext i32 %54 to i64
  %56 = getelementptr inbounds i8, i8* %53, i64 %55
  %57 = load i8, i8* %56, align 1
  %58 = load i8*, i8** %2, align 8
  %59 = load i32, i32* %11, align 4
  %60 = sext i32 %59 to i64
  %61 = getelementptr inbounds i8, i8* %58, i64 %60
  store i8 %57, i8* %61, align 1
  br label %62

62:                                               ; preds = %52
  %63 = load i32, i32* %11, align 4
  %64 = add nsw i32 %63, 1
  store i32 %64, i32* %11, align 4
  br label %49

65:                                               ; preds = %49
  %66 = load i32, i32* %7, align 4
  %67 = mul nsw i32 %66, 4
  %68 = sub nsw i32 %67, 51
  %69 = trunc i32 %68 to i8
  %70 = zext i8 %69 to i32
  %71 = load i8*, i8** %2, align 8
  %72 = getelementptr inbounds i8, i8* %71, i64 2
  %73 = load i8, i8* %72, align 1
  %74 = zext i8 %73 to i32
  %75 = add nsw i32 %74, %70
  %76 = trunc i32 %75 to i8
  store i8 %76, i8* %72, align 1
  %77 = load i32, i32* %7, align 4
  %78 = mul nsw i32 %77, 4
  %79 = sub nsw i32 %78, 51
  %80 = trunc i32 %79 to i8
  %81 = zext i8 %80 to i32
  %82 = load i8*, i8** %2, align 8
  %83 = getelementptr inbounds i8, i8* %82, i64 8
  %84 = load i8, i8* %83, align 1
  %85 = zext i8 %84 to i32
  %86 = add nsw i32 %85, %81
  %87 = trunc i32 %86 to i8
  store i8 %87, i8* %83, align 1
  %88 = load i8*, i8** %2, align 8
  %89 = getelementptr inbounds i8, i8* %88, i64 29
  store i8* %89, i8** %2, align 8
  br label %90

90:                                               ; preds = %65, %45
  %91 = load i32, i32* %7, align 4
  %92 = add nsw i32 %91, 1
  store i32 %92, i32* %7, align 4
  br label %33

93:                                               ; preds = %37
  %94 = load i8*, i8** %3, align 8
  %95 = getelementptr inbounds i8, i8* %94, i64 10
  %96 = getelementptr inbounds i8, i8* %95, i64 29
  store i8* %96, i8** %4, align 8
  store i32 0, i32* %12, align 4
  br label %97

97:                                               ; preds = %110, %93
  %98 = load i32, i32* %12, align 4
  %99 = icmp slt i32 %98, 8
  br i1 %99, label %100, label %113

100:                                              ; preds = %97
  %101 = load i8*, i8** %4, align 8
  %102 = load i32, i32* %12, align 4
  %103 = sext i32 %102 to i64
  %104 = getelementptr inbounds i8, i8* %101, i64 %103
  %105 = load i8, i8* %104, align 1
  %106 = load i8*, i8** %2, align 8
  %107 = load i32, i32* %12, align 4
  %108 = sext i32 %107 to i64
  %109 = getelementptr inbounds i8, i8* %106, i64 %108
  store i8 %105, i8* %109, align 1
  br label %110

110:                                              ; preds = %100
  %111 = load i32, i32* %12, align 4
  %112 = add nsw i32 %111, 1
  store i32 %112, i32* %12, align 4
  br label %97

113:                                              ; preds = %97
  %114 = call i32 @gen()
  store i32 %114, i32* @innerprod_reg2, align 4
  %115 = load i32, i32* @innerprod_reg2, align 4
  store i32 %115, i32* @result, align 4
  %116 = load i32, i32* @result, align 4
  %117 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.1, i64 0, i64 0), i32 %116)
  br label %118

118:                                              ; preds = %113
  store i32 0, i32* @innerprod_reg2, align 4
  %119 = load i32, i32* @innerprod_reg2, align 4
  %120 = load i32, i32* getelementptr inbounds ([3 x i32], [3 x i32]* @vec1, i64 0, i64 0), align 4
  %121 = load i32, i32* getelementptr inbounds ([3 x i32], [3 x i32]* @vec2, i64 0, i64 0), align 4
  %122 = mul nsw i32 %120, %121
  %123 = add nsw i32 %119, %122
  store i32 %123, i32* @innerprod_reg2, align 4
  %124 = load i32, i32* @innerprod_reg2, align 4
  ret i32 %124
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
  %9 = call i64 @strlen(i8* %8) #5
  %10 = add i64 %9, 1
  %11 = call i64 @write(i32 2, i8* %7, i64 %10)
  call void @exit(i32 1) #6
  unreachable

12:                                               ; preds = %1
  ret void
}

declare dso_local i32 @printf(i8*, ...) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @gen() #0 {
  %1 = alloca i32, align 4
  store i32 0, i32* %1, align 4
  %2 = load i32, i32* %1, align 4
  %3 = add nsw i32 %2, 2
  store i32 %3, i32* %1, align 4
  %4 = load i32, i32* %1, align 4
  %5 = add nsw i32 %4, 2
  store i32 %5, i32* %1, align 4
  %6 = load i32, i32* %1, align 4
  %7 = add nsw i32 %6, 2
  store i32 %7, i32* %1, align 4
  %8 = load i32, i32* %1, align 4
  %9 = add nsw i32 %8, 2
  store i32 %9, i32* %1, align 4
  %10 = load i32, i32* %1, align 4
  %11 = add nsw i32 %10, 2
  store i32 %11, i32* %1, align 4
  %12 = load i32, i32* %1, align 4
  %13 = add nsw i32 %12, 2
  store i32 %13, i32* %1, align 4
  %14 = load i32, i32* %1, align 4
  %15 = add nsw i32 %14, 2
  store i32 %15, i32* %1, align 4
  %16 = load i32, i32* %1, align 4
  %17 = add nsw i32 %16, 2
  store i32 %17, i32* %1, align 4
  %18 = load i32, i32* %1, align 4
  %19 = add nsw i32 %18, 2
  store i32 %19, i32* %1, align 4
  %20 = load i32, i32* %1, align 4
  %21 = add nsw i32 %20, 2
  store i32 %21, i32* %1, align 4
  %22 = load i32, i32* %1, align 4
  %23 = add nsw i32 %22, 2
  store i32 %23, i32* %1, align 4
  %24 = load i32, i32* %1, align 4
  %25 = add nsw i32 %24, 2
  store i32 %25, i32* %1, align 4
  %26 = load i32, i32* %1, align 4
  %27 = add nsw i32 %26, 2
  store i32 %27, i32* %1, align 4
  %28 = load i32, i32* %1, align 4
  %29 = add nsw i32 %28, 2
  store i32 %29, i32* %1, align 4
  %30 = load i32, i32* %1, align 4
  %31 = add nsw i32 %30, 2
  store i32 %31, i32* %1, align 4
  %32 = load i32, i32* %1, align 4
  %33 = add nsw i32 %32, 2
  store i32 %33, i32* %1, align 4
  %34 = load i32, i32* %1, align 4
  %35 = add nsw i32 %34, 2
  store i32 %35, i32* %1, align 4
  %36 = load i32, i32* %1, align 4
  %37 = add nsw i32 %36, 2
  store i32 %37, i32* %1, align 4
  %38 = load i32, i32* %1, align 4
  %39 = add nsw i32 %38, 2
  store i32 %39, i32* %1, align 4
  %40 = load i32, i32* %1, align 4
  %41 = add nsw i32 %40, 2
  store i32 %41, i32* %1, align 4
  %42 = load i32, i32* %1, align 4
  %43 = add nsw i32 %42, 2
  store i32 %43, i32* %1, align 4
  %44 = load i32, i32* %1, align 4
  %45 = add nsw i32 %44, 2
  store i32 %45, i32* %1, align 4
  %46 = load i32, i32* %1, align 4
  %47 = add nsw i32 %46, 2
  store i32 %47, i32* %1, align 4
  %48 = load i32, i32* %1, align 4
  %49 = add nsw i32 %48, 2
  store i32 %49, i32* %1, align 4
  %50 = load i32, i32* %1, align 4
  %51 = add nsw i32 %50, 2
  store i32 %51, i32* %1, align 4
  %52 = load i32, i32* %1, align 4
  %53 = add nsw i32 %52, 2
  store i32 %53, i32* %1, align 4
  %54 = load i32, i32* %1, align 4
  %55 = add nsw i32 %54, 2
  store i32 %55, i32* %1, align 4
  %56 = load i32, i32* %1, align 4
  %57 = add nsw i32 %56, 2
  store i32 %57, i32* %1, align 4
  %58 = load i32, i32* %1, align 4
  %59 = add nsw i32 %58, 2
  store i32 %59, i32* %1, align 4
  %60 = load i32, i32* %1, align 4
  %61 = add nsw i32 %60, 2
  store i32 %61, i32* %1, align 4
  %62 = load i32, i32* %1, align 4
  %63 = add nsw i32 %62, 2
  store i32 %63, i32* %1, align 4
  %64 = load i32, i32* %1, align 4
  %65 = add nsw i32 %64, 2
  store i32 %65, i32* %1, align 4
  %66 = load i32, i32* %1, align 4
  %67 = add nsw i32 %66, 2
  store i32 %67, i32* %1, align 4
  %68 = load i32, i32* %1, align 4
  %69 = add nsw i32 %68, 2
  store i32 %69, i32* %1, align 4
  %70 = load i32, i32* %1, align 4
  %71 = add nsw i32 %70, 2
  store i32 %71, i32* %1, align 4
  %72 = load i32, i32* %1, align 4
  %73 = add nsw i32 %72, 2
  store i32 %73, i32* %1, align 4
  %74 = load i32, i32* %1, align 4
  %75 = add nsw i32 %74, 2
  store i32 %75, i32* %1, align 4
  %76 = load i32, i32* %1, align 4
  %77 = add nsw i32 %76, 2
  store i32 %77, i32* %1, align 4
  %78 = load i32, i32* %1, align 4
  %79 = add nsw i32 %78, 2
  store i32 %79, i32* %1, align 4
  %80 = load i32, i32* %1, align 4
  %81 = add nsw i32 %80, 2
  store i32 %81, i32* %1, align 4
  %82 = load i32, i32* %1, align 4
  %83 = add nsw i32 %82, 2
  store i32 %83, i32* %1, align 4
  %84 = load i32, i32* %1, align 4
  %85 = add nsw i32 %84, 2
  store i32 %85, i32* %1, align 4
  %86 = load i32, i32* %1, align 4
  %87 = add nsw i32 %86, 2
  store i32 %87, i32* %1, align 4
  %88 = load i32, i32* %1, align 4
  %89 = add nsw i32 %88, 2
  store i32 %89, i32* %1, align 4
  %90 = load i32, i32* %1, align 4
  %91 = add nsw i32 %90, 2
  store i32 %91, i32* %1, align 4
  %92 = load i32, i32* %1, align 4
  ret i32 %92
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
declare dso_local i64 @strlen(i8*) #2

; Function Attrs: noreturn nounwind
declare dso_local void @exit(i32) #3

; Function Attrs: nounwind
declare dso_local i32 @mprotect(i8*, i64, i32) #4

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readonly "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { noreturn nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { nounwind readonly }
attributes #6 = { noreturn nounwind }
attributes #7 = { nounwind }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 9.0.0-2~ubuntu18.04.2 (tags/RELEASE_900/final)"}







clang-9 -c -emit-llvm -S -target x86_64-pc-linux-gnu smc3_runtime_code_gen_globalvar.c
