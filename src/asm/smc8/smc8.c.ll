; ModuleID = 'smc8_mutual_modification.c'
source_filename = "smc8_mutual_modification.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [48 x i8] c"Error while changing page permissions of foo()\0A\00", align 1
@err_string = dso_local global i8* getelementptr inbounds ([48 x i8], [48 x i8]* @.str, i32 0, i32 0), align 8

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 {
  %1 = alloca i32, align 4    
  %2 = alloca i8*, align 8    ; unsigned char* 	ptr_body_reg10
  %3 = alloca [78 x i8], align 16   ; unsigned char 	reg8[SIZE_OF_SW]
  %4 = alloca [78 x i8], align 16   ; unsigned char 	reg9[SIZE_OF_SW]
  %5 = alloca i32, align 4    ; int	reg2
  %6 = alloca i32, align 4    ; int dummy
  %7 = alloca i32, align 4    ; int i
  store i32 0, i32* %1, align 4
  call void @get_permission(i8* bitcast (i32 ()* @main to i8*))
  store i32 0, i32* %5, align 4   ; reg2 <- 0
  br label %8

; start:
; ptr_body_reg10 = (unsigned char*)main + BODY
8:                                                ; preds = %0
  store i8* getelementptr inbounds (i8, i8* bitcast (i32 ()* @main to i8*), i64 62), i8** %2, align 8
  br label %9
  
; body:
; i <- 0
9:                                                ; preds = %159, %8
  store i32 0, i32* %7, align 4   
  br label %10

; i < SIZE_OF_ADD
10:                                               ; preds = %24, %9
  %11 = load i32, i32* %7, align 4
  %12 = icmp slt i32 %11, 7   
  br i1 %12, label %13, label %27

; reg8[i] = (ptr_body_reg10 + OFFSET_12)[i]
13:                                               ; preds = %10
  %14 = load i8*, i8** %2, align 8
  %15 = getelementptr inbounds i8, i8* %14, i64 279
  %16 = getelementptr inbounds i8, i8* %15, i64 -62
  %17 = load i32, i32* %7, align 4
  %18 = sext i32 %17 to i64
  %19 = getelementptr inbounds i8, i8* %16, i64 %18
  %20 = load i8, i8* %19, align 1
  %21 = load i32, i32* %7, align 4
  %22 = sext i32 %21 to i64
  %23 = getelementptr inbounds [78 x i8], [78 x i8]* %3, i64 0, i64 %22
  store i8 %20, i8* %23, align 1
  br label %24

; i++
24:                                               ; preds = %13
  %25 = load i32, i32* %7, align 4
  %26 = add nsw i32 %25, 1    
  store i32 %26, i32* %7, align 4
  br label %10

; i <- 0
27:                                               ; preds = %10
  store i32 0, i32* %7, align 4
  br label %28

; i < SIZE_OF_ADD
28:                                               ; preds = %42, %27
  %29 = load i32, i32* %7, align 4
  %30 = icmp slt i32 %29, 7
  br i1 %30, label %31, label %45

; reg9[i] = (ptr_body_reg10 + OFFSET_16)[i]
31:                                               ; preds = %28
  %32 = load i8*, i8** %2, align 8
  %33 = getelementptr inbounds i8, i8* %32, i64 286
  %34 = getelementptr inbounds i8, i8* %33, i64 -62
  %35 = load i32, i32* %7, align 4
  %36 = sext i32 %35 to i64
  %37 = getelementptr inbounds i8, i8* %34, i64 %36
  %38 = load i8, i8* %37, align 1
  %39 = load i32, i32* %7, align 4
  %40 = sext i32 %39 to i64
  %41 = getelementptr inbounds [78 x i8], [78 x i8]* %4, i64 0, i64 %40
  store i8 %38, i8* %41, align 1
  br label %42

; i++
42:                                               ; preds = %31
  %43 = load i32, i32* %7, align 4
  %44 = add nsw i32 %43, 1
  store i32 %44, i32* %7, align 4
  br label %28

; i <- 0
45:                                               ; preds = %28
  store i32 0, i32* %7, align 4
  br label %46

; i < SIZE_OF_ADD
46:                                               ; preds = %60, %45
  %47 = load i32, i32* %7, align 4
  %48 = icmp slt i32 %47, 7
  br i1 %48, label %49, label %63

; (ptr_body_reg10 + OFFSET_12)[i] = reg9[i]
49:                                               ; preds = %46
  %50 = load i32, i32* %7, align 4
  %51 = sext i32 %50 to i64
  %52 = getelementptr inbounds [78 x i8], [78 x i8]* %4, i64 0, i64 %51
  %53 = load i8, i8* %52, align 1
  %54 = load i8*, i8** %2, align 8
  %55 = getelementptr inbounds i8, i8* %54, i64 279
  %56 = getelementptr inbounds i8, i8* %55, i64 -62
  %57 = load i32, i32* %7, align 4
  %58 = sext i32 %57 to i64
  %59 = getelementptr inbounds i8, i8* %56, i64 %58
  store i8 %53, i8* %59, align 1
  br label %60

; i++
60:                                               ; preds = %49
  %61 = load i32, i32* %7, align 4
  %62 = add nsw i32 %61, 1
  store i32 %62, i32* %7, align 4
  br label %46

63:                                               ; preds = %46
  store i32 0, i32* %6, align 4   ; dummy <- 0
  %64 = load i32, i32* %5, align 4
  %65 = add nsw i32 %64, 21   
  store i32 %65, i32* %5, align 4   ; reg2 += 21
  %66 = load i32, i32* %5, align 4
  %67 = add nsw i32 %66, 21   
  store i32 %67, i32* %5, align 4   ; reg2 += 21
  store i32 0, i32* %7, align 4   ; i <- 0
  br label %68

; i < SIZE_OF_ADD
68:                                               ; preds = %82, %63
  %69 = load i32, i32* %7, align 4
  %70 = icmp slt i32 %69, 7
  br i1 %70, label %71, label %85

; (ptr_body_reg10 + OFFSET_16)[i] = reg8[i]
71:                                               ; preds = %68
  %72 = load i32, i32* %7, align 4
  %73 = sext i32 %72 to i64
  %74 = getelementptr inbounds [78 x i8], [78 x i8]* %3, i64 0, i64 %73
  %75 = load i8, i8* %74, align 1
  %76 = load i8*, i8** %2, align 8
  %77 = getelementptr inbounds i8, i8* %76, i64 286
  %78 = getelementptr inbounds i8, i8* %77, i64 -62
  %79 = load i32, i32* %7, align 4
  %80 = sext i32 %79 to i64
  %81 = getelementptr inbounds i8, i8* %78, i64 %80
  store i8 %75, i8* %81, align 1
  br label %82

; i++
82:                                               ; preds = %71
  %83 = load i32, i32* %7, align 4
  %84 = add nsw i32 %83, 1
  store i32 %84, i32* %7, align 4
  br label %68

85:                                               ; preds = %68
  %86 = load i32, i32* %6, align 4
  %87 = add nsw i32 %86, 1
  store i32 %87, i32* %6, align 4   ; dummy++
  store i32 0, i32* %7, align 4   ; i <- 0
  br label %88

; i < SIZE_OF_SW
88:                                               ; preds = %102, %85
  %89 = load i32, i32* %7, align 4
  %90 = icmp slt i32 %89, 78
  br i1 %90, label %91, label %105

; reg9[i] = (ptr_body_reg10 + OFFSET_8)[i]
91:                                               ; preds = %88
  %92 = load i8*, i8** %2, align 8
  %93 = getelementptr inbounds i8, i8* %92, i64 201
  %94 = getelementptr inbounds i8, i8* %93, i64 -62
  %95 = load i32, i32* %7, align 4
  %96 = sext i32 %95 to i64
  %97 = getelementptr inbounds i8, i8* %94, i64 %96
  %98 = load i8, i8* %97, align 1
  %99 = load i32, i32* %7, align 4
  %100 = sext i32 %99 to i64
  %101 = getelementptr inbounds [78 x i8], [78 x i8]* %4, i64 0, i64 %100
  store i8 %98, i8* %101, align 1
  br label %102

; i++
102:                                              ; preds = %91
  %103 = load i32, i32* %7, align 4
  %104 = add nsw i32 %103, 1
  store i32 %104, i32* %7, align 4
  br label %88

; i <- 0
105:                                              ; preds = %88
  store i32 0, i32* %7, align 4
  br label %106

; i < SIZE_OF_SW
106:                                              ; preds = %120, %105
  %107 = load i32, i32* %7, align 4
  %108 = icmp slt i32 %107, 78
  br i1 %108, label %109, label %123

; reg8[i] = (ptr_body_reg10 + OFFSET_20)[i]
109:                                              ; preds = %106
  %110 = load i8*, i8** %2, align 8
  %111 = getelementptr inbounds i8, i8* %110, i64 293
  %112 = getelementptr inbounds i8, i8* %111, i64 -62
  %113 = load i32, i32* %7, align 4
  %114 = sext i32 %113 to i64
  %115 = getelementptr inbounds i8, i8* %112, i64 %114
  %116 = load i8, i8* %115, align 1
  %117 = load i32, i32* %7, align 4
  %118 = sext i32 %117 to i64
  %119 = getelementptr inbounds [78 x i8], [78 x i8]* %3, i64 0, i64 %118
  store i8 %116, i8* %119, align 1
  br label %120

; i++
120:                                              ; preds = %109
  %121 = load i32, i32* %7, align 4
  %122 = add nsw i32 %121, 1
  store i32 %122, i32* %7, align 4
  br label %106

; i <- 0
123:                                              ; preds = %106
  store i32 0, i32* %7, align 4
  br label %124

; i < SIZE_OF_SW
124:                                              ; preds = %138, %123
  %125 = load i32, i32* %7, align 4
  %126 = icmp slt i32 %125, 78
  br i1 %126, label %127, label %141

; (ptr_body_reg10 + OFFSET_20)[i] = reg9[i]
127:                                              ; preds = %124
  %128 = load i32, i32* %7, align 4
  %129 = sext i32 %128 to i64
  %130 = getelementptr inbounds [78 x i8], [78 x i8]* %4, i64 0, i64 %129
  %131 = load i8, i8* %130, align 1
  %132 = load i8*, i8** %2, align 8
  %133 = getelementptr inbounds i8, i8* %132, i64 293
  %134 = getelementptr inbounds i8, i8* %133, i64 -62
  %135 = load i32, i32* %7, align 4
  %136 = sext i32 %135 to i64
  %137 = getelementptr inbounds i8, i8* %134, i64 %136
  store i8 %131, i8* %137, align 1
  br label %138

; i++
138:                                              ; preds = %127
  %139 = load i32, i32* %7, align 4
  %140 = add nsw i32 %139, 1
  store i32 %140, i32* %7, align 4
  br label %124

; i <- 0
141:                                              ; preds = %124
  store i32 0, i32* %7, align 4
  br label %142

; i < SIZE_OF_SW
142:                                              ; preds = %156, %141
  %143 = load i32, i32* %7, align 4
  %144 = icmp slt i32 %143, 78
  br i1 %144, label %145, label %159

; (ptr_body_reg10 + OFFSET_8)[i] = reg8[i]
145:                                              ; preds = %142
  %146 = load i32, i32* %7, align 4
  %147 = sext i32 %146 to i64
  %148 = getelementptr inbounds [78 x i8], [78 x i8]* %3, i64 0, i64 %147
  %149 = load i8, i8* %148, align 1
  %150 = load i8*, i8** %2, align 8
  %151 = getelementptr inbounds i8, i8* %150, i64 201
  %152 = getelementptr inbounds i8, i8* %151, i64 -62
  %153 = load i32, i32* %7, align 4
  %154 = sext i32 %153 to i64
  %155 = getelementptr inbounds i8, i8* %152, i64 %154
  store i8 %149, i8* %155, align 1
  br label %156
; i++
156:                                              ; preds = %145
  %157 = load i32, i32* %7, align 4
  %158 = add nsw i32 %157, 1
  store i32 %158, i32* %7, align 4
  br label %142

; goto body;
159:                                              ; preds = %142
  br label %9
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






clang-9 -c -emit-llvm -S -target x86_64-pc-linux-gnu smc8_mutual_modification.c 
