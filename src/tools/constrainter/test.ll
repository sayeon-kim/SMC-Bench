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

define dso_local i32 @main() {
  entry:
    ; alloca instructions
    %alloca_ins1 = alloca i8
    %alloca_ins2 = alloca i16
    %alloca_ins3 = alloca i32
    %alloca_ins4 = alloca i64
    %alloca_ins5 = alloca i64

    %alloca_struct1 = alloca %struct1
    %alloca_struct2 = alloca %struct2
    %alloca_struct3 = alloca %struct3
    %alloca_struct4 = alloca %struct4

    ; store instructions1
    store i8 1, i8* %alloca_ins1
    store i16 2, i16* %alloca_ins2
    store i32 3, i32* %alloca_ins3
    store i64 4, i64* %alloca_ins4

    ; store instruction2

    
    ; load instructions
    %load_ins1 = load i8, i8* %alloca_ins1
    %load_ins2 = load i16, i16* %alloca_ins2
    %load_ins3 = load i32, i32* %alloca_ins3
    %load_ins4 = load i64, i64* %alloca_ins4
    %load_ins5 = load %struct1, %struct1* %alloca_struct1
    %load_ins6 = load %struct2, %struct2* %alloca_struct2

    ; GetElementPtr instructions
    %GEP_ins1 = getelementptr %struct1, %struct1* %alloca_struct1, i32 0, i32 1 ; struct1->i16
    %GEP_ins2 = getelementptr %struct2, %struct2* %alloca_struct2, i32 0, i32 0, i32 2 ; struct2->struct1->i16
    %GEP_ins3 = getelementptr %struct3, %struct3* %alloca_struct3, i32 0, i32 1, i32 0, i32 3 ; struct3->struct2->struct1->i32
    %GEP_ins4 = getelementptr %struct4, %struct4* %alloca_struct4, i32 0, i32 2, i32 1, i32 0, i32 4 ; struct4->struct3->struct2->struct1->i64

    ; IntToPtr Instructions 1
    %ITP_ins1 = inttoptr i8 1 to i16*
    %ITP_ins2 = inttoptr i16 2 to i32*

    ; IntToPtr Instructions 2
    %ITP_ins3 = inttoptr i32 %load_ins3 to i16*
    %ITP_ins4 = inttoptr i64 %load_ins4 to i32*

    ; BitCast Instructions
    %bitcast_ins1 = bitcast i32 8 to float
    %bitcast_ins2 = bitcast i32* %ITP_ins2 to i32*
    %bitcast_ins3 = bitcast i32 %load_ins3 to float
    %bitcast_ins4 = bitcast i32* %alloca_ins3 to i8*

    ; ExtractValue Instructions
    %extractvalue_ins1 = extractvalue %struct1 %load_ins5, 0
    %extractvalue_ins2 = extractvalue %struct2 %load_ins6, 0, 1
    br label %loop

  ; PHI Instructions
  loop:
    %indvar = phi i32 [0, %entry ], [ %nextindvar, %loop]
    %nextindvar = add i32 %indvar, 1
    br label %next
  
  next:
    ; Select Instructions
    %select_ins1 = select i1 true, i64* %alloca_ins4, i64* %alloca_ins5
    %select_ins2 = select i1 false, i64 1234, i64 123
    ret i32 0
}