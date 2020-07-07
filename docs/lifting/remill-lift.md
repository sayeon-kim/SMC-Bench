# remill-lift usage

## Example 1

```cpp
//function.c
int add (int a, int b){
return a+b;
}

int main(){
    return 0;
}
```

```bash
readelf -S function.o
[Nr] Name              Type             Address           Offset
[ 2] .text             PROGBITS         0000000000000000  00000040

readelf -s function.o
Num:    Value          Size Type    Bind   Vis      Ndx Name
3: 0000000000000000    18 FUNC    GLOBAL DEFAULT    2 add
4: 0000000000000020    15 FUNC    GLOBAL DEFAULT    2 main

xxd -p -s 0x40 -l 0x18 function.o
554889e5897dfc8975f88b45fc0345f85dc3662e0f1f8400
xxd -p -s 0x60 -l 0x15 function.o
554889e531c0c745fc000000005dc300636c616e67

remill-lift-9.0 --os linux --arch amd64 --bytes 554889e5897dfc8975f88b45fc0345f85dc3662e0f1f8400 --ir_out add.ll
remill-lift-9.0 --os linux --arch amd64 --bytes 554889e531c0c745fc000000005dc300636c616e67 --ir_out main.ll
```

## Example 2 
```asm
;smc1.x86.s
	.data
exit_string:	.asciiz "\n Exit Program.\n"
smc_string:		.asciiz "\n This code is modified\n"
	.text
main:	
	j modify
modify: 
	lw $t1, new ;1 $t1 <- new (j halt)
	sw $t1, target ;2 $t1(j halt) -> target
	j target ;3 j target
new:	
	j halt
halt:	
	li	$v0, 4 ;5 $v0 <- 4, for syscall.
	la	$a0, smc_string ;6 $a0 <- smc_string, argument1(string ptr)
	syscall ;7 print
	li	$v0, 32 ;8 $v0 <- 32, for syscall.
	li $a0, 1000 ;9 $a0 <- 1000, argument1(sleep time)
	syscall ;10 sleep 1 second.
	j halt ;11 jmp halt
target: 
	nop;4 j halt
exit:
	li $v0, 4 ; never execute.
	la $a0, exit_string ; never execute.
	syscall ; never execute.
	li $v0, 10 ; never execute.
	syscall ; never execute.

;nasm -felf32 hello.x86.s -o smc1.x86.o
```

```bash
readelf -S smc1.x86.o
[Nr] Name              Type            Addr     Off    Size   ES Flg Lk Inf Al
[ 2] .text             PROGBITS        00000000 000190 000070 00  AX  0   0 16

readelf -s smc1.x86.o
11: 00000002     0 NOTYPE  LOCAL  DEFAULT    2 modify
12: 00000018     0 NOTYPE  LOCAL  DEFAULT    2 new
13: 0000001f     0 NOTYPE  LOCAL  DEFAULT    2 halt
14: 00000048     0 NOTYPE  LOCAL  DELT    2 target
15: 0000004e     0 NOTYPE  LOCAL  DEFAULT    2 exit
16: 00000000     0 NOTYPE  GLOBAL DEFAULT    2 _start

xxd -p -s 0x190 -l 0x70 smc1.x86.o
eb00a118000000a348000000a11b000000a34b000000eb30b81f000000ff
e0b804000000bb01000000b90f000000ba17000000cd80b8a2000000bb26
000000b9e8030000cd80ebd7909090909090b804000000bb01000000b900
000000ba0f000000cd80b801000000bb00000000cd80

remill-lift-9.0 --os linux --arch x86 --bytes eb00a118000000a348000000a11b000000a34b000000eb30b81f000000ff
e0b804000000bb01000000b90f000000ba17000000cd80b8a2000000bb26
000000b9e8030000cd80 --ir_out smc1.x86.ll
```