; Test ll fILE

target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.Test = type { [20 x i8], i32, [100 x i8] }

define dso_local i32 @main() {
  entry:
    %first_var = alloca i32
    %block_var = alloca %struct.Test

    %index_var = getelementptr inbounds %struct.Test, %struct.Test* %block_var, i32 0, i32 0 ; [20 x i8]
    %char_var = getelementptr inbounds [20 x i8], [20 x i8]* %index_var, i32 0, i8 0
    
    store i32 1, i32* %first_var
    %load_var = load i32, i32* %first_var

  ret i32 0
}