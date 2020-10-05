# SMC1

## Unbounded Code Rewriting

```assembly
section .data
    num db 8

section .text
global _init
_init:
    mov ebp, num  ; num
    mov ecx, 1 	  ; counter
    mov edx, 1 	  ; accumulator

loop:
    cmp ecx, [ebp]   ; compare num and counter
    jz halt          ; if num and counter equal then jump halt.
    add ecx, 1       ; else, counter add 1.
    mov bl, dl       ; save constant operand of add instruction to bl register.(Store Fn into bl.)

key:
    add edx, 0       ; Store next Fibonacci number to edx(Fn + Fn-1 = Fn+1)
    mov al, bl       ; store Fn fibonachi value into al.
    mov [key+2], al  ; update constant operand of add instruction. in add(edx, constant), (Fn). next instruction, Fn+2 = Fn+1 + Fn. and, now is edx Fn+1.
    jmp loop

halt:   ; exit
    mov eax, 1
    xor ebx, ebx
    int 0x80
```

### description

SMC1 is a fibonacci sequence program using self modyfing.

This program rewrite constant operand of add instruction.

#### Step 1. _init

- mov ebp num
- mov ecx, 1
- mov edx, 1

ebp is number of sequence. (n in F1,F2,F3, ... Fn)

ecx is counter.

edx is accumulator of result.

#### Step 2. loop

- cmp ecx, [ebp]

- jz halt

compare n and num and if they are equal then halt else continue.

- add ecx, 1
- mov bl, dl

increase counter.

store Fn into bl.

#### Step 3. key

- add edx, 0

This instruction will be rewritten continually.

- mov al, bl

Store Fn into al

- mov [key+2], al

Store Fn into constant operand of add instruction.


### C Program 동작 확인

```shell
git clone https://github.com/JNU-SoftwareLAB/SMC-Bench.git	#Bench Project Clone
cd ./SMC-Bench/src/asm/smc1
gcc smc1.c -o result 							#gcc compile
./result									#execute
															
# fib(8) = 34가 출력된다면 SMC 정상 작동
```