; ModuleID = 'smc7.c'
source_filename = "smc7.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [48 x i8] c"Error while changing page permissions of foo()\0A\00", align 1
@err_string = dso_local global i8* getelementptr inbounds ([48 x i8], [48 x i8]* @.str, i32 0, i32 0), align 8
@ptr_h = common dso_local global i8* null, align 8
@ptr_g = common dso_local global i8* null, align 8
@.str.1 = private unnamed_addr constant [16 x i8] c"Num Value : %d\0A\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca [54 x i8], align 16
  %3 = alloca [54 x i8], align 16
  %4 = alloca [54 x i8], align 16
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  store i32 0, i32* %1, align 4
  store i32 1, i32* %6, align 4
  call void @get_permission(i8* bitcast (i32 ()* @main to i8*))
  br label %7

7:                                                ; preds = %128, %0
  store i8* getelementptr inbounds (i8, i8* bitcast (i32 ()* @main to i8*), i64 398), i8** @ptr_h, align 8
  store i8* getelementptr inbounds (i8, i8* bitcast (i32 ()* @main to i8*), i64 343), i8** @ptr_g, align 8
  store i32 0, i32* %5, align 4
  br label %8

8:                                                ; preds = %20, %7
  %9 = load i32, i32* %5, align 4
  %10 = icmp slt i32 %9, 54
  br i1 %10, label %11, label %23

11:                                               ; preds = %8
  %12 = load i8*, i8** @ptr_g, align 8
  %13 = load i32, i32* %5, align 4
  %14 = sext i32 %13 to i64
  %15 = getelementptr inbounds i8, i8* %12, i64 %14
  %16 = load i8, i8* %15, align 1
  %17 = load i32, i32* %5, align 4
  %18 = sext i32 %17 to i64
  %19 = getelementptr inbounds [54 x i8], [54 x i8]* %2, i64 0, i64 %18
  store i8 %16, i8* %19, align 1
  br label %20

20:                                               ; preds = %11
  %21 = load i32, i32* %5, align 4
  %22 = add nsw i32 %21, 1
  store i32 %22, i32* %5, align 4
  br label %8

23:                                               ; preds = %8
  store i32 0, i32* %5, align 4
  br label %24

24:                                               ; preds = %35, %23
  %25 = load i32, i32* %5, align 4
  %26 = icmp slt i32 %25, 54
  br i1 %26, label %27, label %38

27:                                               ; preds = %24
  %28 = load i32, i32* %5, align 4
  %29 = sext i32 %28 to i64
  %30 = getelementptr inbounds [54 x i8], [54 x i8]* %2, i64 0, i64 %29
  %31 = load i8, i8* %30, align 1
  %32 = load i32, i32* %5, align 4
  %33 = sext i32 %32 to i64
  %34 = getelementptr inbounds [54 x i8], [54 x i8]* %3, i64 0, i64 %33
  store i8 %31, i8* %34, align 1
  br label %35

35:                                               ; preds = %27
  %36 = load i32, i32* %5, align 4
  %37 = add nsw i32 %36, 1
  store i32 %37, i32* %5, align 4
  br label %24

38:                                               ; preds = %24
  %39 = getelementptr inbounds [54 x i8], [54 x i8]* %3, i64 0, i64 21
  %40 = load i8, i8* %39, align 1
  %41 = sext i8 %40 to i32
  %42 = add nsw i32 %41, 8
  %43 = trunc i32 %42 to i8
  %44 = getelementptr inbounds [54 x i8], [54 x i8]* %3, i64 0, i64 21
  store i8 %43, i8* %44, align 1
  store i32 0, i32* %5, align 4
  br label %45

45:                                               ; preds = %57, %38
  %46 = load i32, i32* %5, align 4
  %47 = icmp slt i32 %46, 54
  br i1 %47, label %48, label %60

48:                                               ; preds = %45
  %49 = load i32, i32* %5, align 4
  %50 = sext i32 %49 to i64
  %51 = getelementptr inbounds [54 x i8], [54 x i8]* %3, i64 0, i64 %50
  %52 = load i8, i8* %51, align 1
  %53 = load i8*, i8** @ptr_g, align 8
  %54 = load i32, i32* %5, align 4
  %55 = sext i32 %54 to i64
  %56 = getelementptr inbounds i8, i8* %53, i64 %55
  store i8 %52, i8* %56, align 1
  br label %57

57:                                               ; preds = %48
  %58 = load i32, i32* %5, align 4
  %59 = add nsw i32 %58, 1
  store i32 %59, i32* %5, align 4
  br label %45

60:                                               ; preds = %45
  store i32 0, i32* %5, align 4
  br label %61

61:                                               ; preds = %73, %60
  %62 = load i32, i32* %5, align 4
  %63 = icmp slt i32 %62, 54
  br i1 %63, label %64, label %76

64:                                               ; preds = %61
  %65 = load i8*, i8** @ptr_h, align 8
  %66 = load i32, i32* %5, align 4
  %67 = sext i32 %66 to i64
  %68 = getelementptr inbounds i8, i8* %65, i64 %67
  %69 = load i8, i8* %68, align 1
  %70 = load i32, i32* %5, align 4
  %71 = sext i32 %70 to i64
  %72 = getelementptr inbounds [54 x i8], [54 x i8]* %4, i64 0, i64 %71
  store i8 %69, i8* %72, align 1
  br label %73

73:                                               ; preds = %64
  %74 = load i32, i32* %5, align 4
  %75 = add nsw i32 %74, 1
  store i32 %75, i32* %5, align 4
  br label %61

76:                                               ; preds = %61
  br label %77

77:                                               ; preds = %76
  store i32 0, i32* %5, align 4
  br label %78

78:                                               ; preds = %90, %77
  %79 = load i32, i32* %5, align 4
  %80 = icmp slt i32 %79, 54
  br i1 %80, label %81, label %93

81:                                               ; preds = %78
  %82 = load i32, i32* %5, align 4
  %83 = sext i32 %82 to i64
  %84 = getelementptr inbounds [54 x i8], [54 x i8]* %2, i64 0, i64 %83
  %85 = load i8, i8* %84, align 1
  %86 = load i8*, i8** @ptr_g, align 8
  %87 = load i32, i32* %5, align 4
  %88 = sext i32 %87 to i64
  %89 = getelementptr inbounds i8, i8* %86, i64 %88
  store i8 %85, i8* %89, align 1
  br label %90

90:                                               ; preds = %81
  %91 = load i32, i32* %5, align 4
  %92 = add nsw i32 %91, 1
  store i32 %92, i32* %5, align 4
  br label %78

93:                                               ; preds = %78
  br label %94

94:                                               ; preds = %93
  %95 = load i32, i32* %6, align 4
  %96 = mul nsw i32 %95, 2
  store i32 %96, i32* %6, align 4
  %97 = load i32, i32* %6, align 4
  %98 = mul nsw i32 %97, 2
  store i32 %98, i32* %6, align 4
  %99 = load i32, i32* %6, align 4
  %100 = mul nsw i32 %99, 2
  store i32 %100, i32* %6, align 4
  %101 = load i32, i32* %6, align 4
  %102 = mul nsw i32 %101, 2
  store i32 %102, i32* %6, align 4
  %103 = load i32, i32* %6, align 4
  %104 = mul nsw i32 %103, 2
  store i32 %104, i32* %6, align 4
  %105 = load i32, i32* %6, align 4
  %106 = mul nsw i32 %105, 2
  store i32 %106, i32* %6, align 4
  %107 = load i32, i32* %6, align 4
  %108 = mul nsw i32 %107, 2
  store i32 %108, i32* %6, align 4
  %109 = load i32, i32* %6, align 4
  %110 = mul nsw i32 %109, 2
  store i32 %110, i32* %6, align 4
  %111 = load i32, i32* %6, align 4
  %112 = mul nsw i32 %111, 2
  store i32 %112, i32* %6, align 4
  store i32 0, i32* %5, align 4
  br label %113

113:                                              ; preds = %125, %94
  %114 = load i32, i32* %5, align 4
  %115 = icmp slt i32 %114, 54
  br i1 %115, label %116, label %128

116:                                              ; preds = %113
  %117 = load i32, i32* %5, align 4
  %118 = sext i32 %117 to i64
  %119 = getelementptr inbounds [54 x i8], [54 x i8]* %4, i64 0, i64 %118
  %120 = load i8, i8* %119, align 1
  %121 = load i8*, i8** @ptr_h, align 8
  %122 = load i32, i32* %5, align 4
  %123 = sext i32 %122 to i64
  %124 = getelementptr inbounds i8, i8* %121, i64 %123
  store i8 %120, i8* %124, align 1
  br label %125

125:                                              ; preds = %116
  %126 = load i32, i32* %5, align 4
  %127 = add nsw i32 %126, 1
  store i32 %127, i32* %5, align 4
  br label %113

128:                                              ; preds = %113
  %129 = load i32, i32* %6, align 4
  %130 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.1, i64 0, i64 0), i32 %129)
  %131 = load i8*, i8** @ptr_g, align 8
  %132 = getelementptr inbounds i8, i8* %131, i64 21
  %133 = load i8, i8* %132, align 1
  %134 = zext i8 %133 to i32
  %135 = add nsw i32 %134, -8
  %136 = trunc i32 %135 to i8
  %137 = load i8*, i8** @ptr_g, align 8
  %138 = getelementptr inbounds i8, i8* %137, i64 21
  store i8 %136, i8* %138, align 1
  br label %7

139:                                              ; No predecessors!
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
