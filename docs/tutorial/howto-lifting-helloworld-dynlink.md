#### Features

Mcsema Commit Version : f8ade494accf887f9d03b6bed901fef8ace5e255

Remill Commit Version : 86a6424d58cca6504a93bf7dc4363f14be9e216f

#### hello.c

```c
#include <stdio.h>

int main(){
    printf("Hello World\n");
    return 0;
}
```

#### compile

``` bash
clang-9 hello.c -o hello
```

#### make cfg

```bash 
mcsema-disass --disassembler /opt/ida-7.1/idat64 --os linux --arch amd64 --output hello.cfg --binary hello --entrypoint main --log_file hello.log
```

여기까지 해서. cfg 파일이 만들어졌습니다.

#### Lifting Error

```bash
mcsema-lift-9.0 --os linux --arch amd64 --cfg hello.cfg --output hello.bc

E20200526 01:37:26.774528  2604 Function.cpp:353] Cannot find target of instruction at 4003ec; the static target 4003f0 is not associated with a lifted subroutine, and it does not have a known call target.
```

```objdump
objdump hello -d

#~ some codes ~#
00000000004003e0 <.plt>:
  4003e0:       ff 35 22 0c 20 00       pushq  0x200c22(%rip)        # 601008 <_GLOBAL_OFFSET_TABLE_+0x8>
  4003e6:       ff 25 24 0c 20 00       jmpq   *0x200c24(%rip)        # 601010 <_GLOBAL_OFFSET_TABLE_+0x10>
  4003ec:       0f 1f 40 00             nopl   0x0(%rax)

00000000004003f0 <printf@plt>:
  4003f0:       ff 25 22 0c 20 00       jmpq   *0x200c22(%rip)        # 601018 <printf@GLIBC_2.2.5>
  4003f6:       68 00 00 00 00          pushq  $0x0
  4003fb:       e9 e0 ff ff ff          jmpq   4003e0 <.plt>
```

이곳에서.

printf 콜 하는 부분에서 error 가 나옵니다.

4003f0 is not associated with a lifted subroutine, and it does not have a known call target.

이 부분을 어떻게 해결하면 좋을까요?

보아하니. external function? 에 대한 링킹? 이 잘되지 않은 것 같습니다?



#### Error 분석?

ll 파일 내부로 들어가서 살펴보니, prtinf 에 대한 declare가 되어 있지 않습니다.

```bash
llvm-dis-9 hello.bc -o hello.ll
```

이후에 문제의 printf 와 관련된 코드들을 살펴보면?

#### hello.ll

```bash
#line 58
# Hello World Data를 가지고 있는 segment
@seg_4005a0__rodata = internal constant %seg_4005a0__rodata_type <{ [4 x i8] c"\01\00\02\00", [13 x i8] c"Hello World\0A\00" }>

#line 61
@seg_601000__got_plt = internal global %seg_601000__got_plt_type <{ [24 x i8] c" \0E`\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00", i64 ptrtoint (i64 (i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)* @printf to i64) }>

#line 91
#printf 함수? 문제의 부분으로 보인다..
; Function Attrs: noinline
declare !remill.function.type !1273 extern_weak x86_64_sysvcc i64 @printf(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64) #3

######
####### 실행되는 line 에서 printf
#line 231
store i64 add (i64 ptrtoint (%seg_4005a0__rodata_type* @seg_4005a0__rodata to i64), i64 4), i64* %6, align 8, !tbaa !1278

#line 240
%49 = tail call fastcc %struct.Memory* @ext_601040_printf(%struct.State* nonnull %0, %struct.Memory* %2)

#line 921
define internal fastcc %struct.Memory* @ext_601040_printf(%struct.State*, %struct.Memory*) unnamed_addr #8 {
  %3 = tail call %struct.Memory* @__remill_function_call(%struct.State* %0, i64 ptrtoint (i64 (i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)* @printf to i64), %struct.Memory* %1)
  ret %struct.Memory* %3
}
```

#### github Q&A

https://github.com/lifting-bits/mcsema/issues/660