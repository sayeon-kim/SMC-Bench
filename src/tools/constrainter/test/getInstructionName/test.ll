; Test ll fILE

target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

define dso_local i32 @main() {
  entry:
    %first_var = alloca i32;
    %second_var = alloca i32; 
  ret i32 0
}