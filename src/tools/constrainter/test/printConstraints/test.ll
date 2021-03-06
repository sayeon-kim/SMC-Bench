; Test ll fILE

target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct1 = type { i1, i8, i16, i32, i64}
%struct2 = type { %struct1 }
%struct3 = type { %struct1, %struct2 }
%struct4 = type { %struct1, %struct2, %struct3 }

define dso_local void @functionTest() {
  entry:
    %alloca_ins1 = alloca i8
    %alloca_ins2 = alloca i16
    ret void
}

define dso_local void @functionTest2() {
  entry:
    %alloca_ins1 = alloca i8
    %alloca_ins2 = alloca i16
    ret void
}

define dso_local i32 @main() {
  entry:
    ; alloca instructions
    %alloca_ins1 = alloca i8
    %alloca_ins2 = alloca i16
    %alloca_ins3 = alloca i32
    ret i32 0
}