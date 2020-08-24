; ModuleID = 'c_smc1.c'
source_filename = "c_smc1.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@__const.main.mcode = private unnamed_addr constant [5 x i8] c"\E9\00\00\00\00", align 1
@.str = private unnamed_addr constant [16 x i8] c"Start Modyfing.\00", align 1
@.str.1 = private unnamed_addr constant [21 x i8] c"Here is Dead Block.\0A\00", align 1
@.str.2 = private unnamed_addr constant [47 x i8] c"'jmp end' is relative 5bytes jmp instruction.\0A\00", align 1
@.str.3 = private unnamed_addr constant [18 x i8] c"code is modifed.\0A\00", align 1
@.str.4 = private unnamed_addr constant [14 x i8] c"Not Modifed.\0A\00", align 1
@.str.5 = private unnamed_addr constant [9 x i8] c"Faield!\0A\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca [5 x i8], align 1
  store i32 0, i32* %1, align 4
  call void @smcInit(i8* bitcast (i32 ()* @main to i8*))
  %3 = bitcast [5 x i8]* %2 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %3, i8* align 1 getelementptr inbounds ([5 x i8], [5 x i8]* @__const.main.mcode, i32 0, i32 0), i64 5, i1 false)
  %4 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str, i64 0, i64 0))
  %5 = getelementptr inbounds [5 x i8], [5 x i8]* %2, i64 0, i64 0
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 blockaddress(@main, %6), i8* align 1 %5, i64 5, i1 false)
  br label %6

6:                                                ; preds = %0, %14
  call void asm sideeffect "_branch:\0Ajmp _end", "~{dirflag},~{fpsr},~{flags}"() #5, !srcloc !2
  br label %7

7:                                                ; preds = %6
  call void asm sideeffect "_deadblock:", "~{dirflag},~{fpsr},~{flags}"() #5, !srcloc !3
  %8 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([21 x i8], [21 x i8]* @.str.1, i64 0, i64 0))
  %9 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([47 x i8], [47 x i8]* @.str.2, i64 0, i64 0))
  %10 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([18 x i8], [18 x i8]* @.str.3, i64 0, i64 0))
  call void asm sideeffect "jmp _return", "~{dirflag},~{fpsr},~{flags}"() #5, !srcloc !4
  br label %11

11:                                               ; preds = %7
  call void asm sideeffect "_end:", "~{dirflag},~{fpsr},~{flags}"() #5, !srcloc !5
  %12 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.4, i64 0, i64 0))
  br label %13

13:                                               ; preds = %11
  call void asm sideeffect "_return:", "~{dirflag},~{fpsr},~{flags}"() #5, !srcloc !6
  ret i32 0

14:                                               ; No predecessors!
  indirectbr i8* undef, [label %6]
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @smcInit(i8*) #0 {
  %2 = alloca i8*, align 8
  store i8* %0, i8** %2, align 8
  %3 = load i8*, i8** %2, align 8
  %4 = call i32 @getMemoryPermission(i8* %3)
  %5 = icmp eq i32 %4, -1
  br i1 %5, label %6, label %8

6:                                                ; preds = %1
  %7 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.5, i64 0, i64 0))
  br label %8

8:                                                ; preds = %6, %1
  ret void
}

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture writeonly, i8* nocapture readonly, i64, i1 immarg) #1

declare dso_local i32 @printf(i8*, ...) #2

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @getMemoryPermission(i8*) #0 {
  %2 = alloca i32, align 4
  %3 = alloca i8*, align 8
  %4 = alloca i32, align 4
  store i8* %0, i8** %3, align 8
  %5 = call i32 @getpagesize() #6
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
  %17 = call i32 @mprotect(i8* %14, i64 %16, i32 7) #5
  %18 = icmp eq i32 %17, -1
  br i1 %18, label %19, label %20

19:                                               ; preds = %1
  store i32 -1, i32* %2, align 4
  br label %21

20:                                               ; preds = %1
  store i32 0, i32* %2, align 4
  br label %21

21:                                               ; preds = %20, %19
  %22 = load i32, i32* %2, align 4
  ret i32 %22
}

; Function Attrs: nounwind readnone
declare dso_local i32 @getpagesize() #3

; Function Attrs: nounwind
declare dso_local i32 @mprotect(i8*, i64, i32) #4

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { argmemonly nounwind }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind readnone "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { nounwind }
attributes #6 = { nounwind readnone }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 9.0.0-2~ubuntu18.04.2 (tags/RELEASE_900/final)"}
!2 = !{i32 352, i32 367}
!3 = !{i32 415}
!4 = !{i32 578}
!5 = !{i32 625}
!6 = !{i32 695}
