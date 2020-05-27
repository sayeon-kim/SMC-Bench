#### smc1.x86.s

```assembly
section .data
section .text
global _start

_start:
    jmp modify
halt:
	mov eax, 1
	int 0x80
modify:
    mov ebx, [new]      ; ebx <- [new] (lw ebx, new)
    mov [target], ebx	; ebx -> [target] (sw ebx, target)
    jmp target        	; eip <- target
target:
    mov eax, 1     	; eax <- 1
	jmp halt
new:
    mov ebx, 0        	; ebx <- 0
```

#### 어셈블링, 링킹, 실행

```bash
nasm -felf32 smc1.x86.s && ld -m elf_i386 --omagic smc1.x86.o -o smc1.x86 && ./smc1.x86
```

#### 분석하기

```bash
objdump smc1.x86 -d
```

#### objdump file

```bash
smc1.x86:     file format elf32-i386


Disassembly of section .text:

08048060 <_start>:
 8048060:       eb 07                   jmp    8048069 <modify>

08048062 <halt>:
 8048062:       b8 01 00 00 00          mov    $0x1,%eax
 8048067:       cd 80                   int    $0x80

08048069 <modify>:
 8048069:       8b 1d 7e 80 04 08       mov    0x804807e,%ebx
 804806f:       89 1d 77 80 04 08       mov    %ebx,0x8048077
 8048075:       eb 00                   jmp    8048077 <target>

08048077 <target>:
 8048077:       bb 01 00 00 00          mov    $0x1,%ebx
 804807c:       eb e4                   jmp    8048062 <halt>

0804807e <new>:
 804807e:       bb 00 00 00 00          mov    $0x0,%ebx
```

#### gdb로 분석

#### gdb 실행

```bash
gdb smc1.x86
```

#### 1

```bash
(gdb) b _start
Breakpoint 1 at 0x8048060
r
Starting program: /home/work/smc1.x86

(gdb) disassemble target
Dump of assembler code for function target:
   0x0804807c <+0>:     mov    $0x1,%ebx
   0x08048081 <+5>:     jmp    0x8048062 <halt>
End of assembler dump.
```

처음 시작할 때에. target의 0x0804807c 는 mov ebx, 1입니다.

이후에 jump로 halt로 넘어가, sys_exit 을 합니다.

본래의 프로그램은 i.e sys_exit(1) 을 합니다.

#### 2

```bash
(gdb) disassemble _start
Dump of assembler code for function _start:
=> 0x08048060 <+0>:     jmp    0x804806e <modify>
End of assembler dump.
```

#### 3

```bash
(gdb) ni
0x0804806e in modify ()

Dump of assembler code for function modify:
=> 0x0804806e <+0>:     mov    0x8048083,%ebx
   0x08048074 <+6>:     mov    %ebx,0x804807c
   0x0804807a <+12>:    jmp    0x804807c <target>
End of assembler dump.

(gdb) ni
0x08048074 in modify ()
(gdb) disassemble modify
Dump of assembler code for function modify:
   0x0804806e <+0>:     mov    0x8048083,%ebx
=> 0x08048074 <+6>:     mov    %ebx,0x804807c
   0x0804807a <+12>:    jmp    0x804807c <target>

(gdb) ni
0x0804807a in modify ()
(gdb) disassemble modify
Dump of assembler code for function modify:
   0x0804806e <+0>:     mov    0x8048083,%ebx
   0x08048074 <+6>:     mov    %ebx,0x804807c
=> 0x0804807a <+12>:    jmp    0x804807c <target>

(gdb) ni
0x0804807c in target ()
```

modify<+0>에서 ebx에 new의 명령어를 불러와서.

modify<+6>에서 target<+0>에 ebx의 값을 write 합니다.

#### 4

```bash
(gdb) disassemble target
Dump of assembler code for function target:
=> 0x08048077 <+0>:     mov    $0x0,%ebx
   0x0804807c <+5>:     jmp    0x8048062 <halt>
```

target에 write를 한 다음에 다시 disassemble을 해서 확인해보니, 명령어가 변해있는 것을 확인할 수 있습니다.

i.e sys_exit(1)을 합니다.

#### 5

```bash
(gdb) ni
0x0804807c in target ()
(gdb) disassemble target
Dump of assembler code for function target:
   0x08048077 <+0>:     mov    $0x0,%ebx
=> 0x0804807c <+5>:     jmp    0x8048062 <halt>

(gdb) disassemble halt
Dump of assembler code for function halt:
=> 0x08048062 <+0>:     mov    $0x1,%eax
   0x08048067 <+5>:     int    $0x80
   
(gdb) ni
0x08048067 in halt ()

(gdb) disassemble halt
Dump of assembler code for function halt:
   0x08048062 <+0>:     mov    $0x1,%eax
=> 0x08048067 <+5>:     int    $0x80

(gdb) ni
[Inferior 1 (process 31690) exited normally]
```

시스템 종료.



#### conclusion

smc처럼, code를 변경하여 실행하기 위해서는 Memory Protection의 제한을 상정해야 합니다.

Linux 에서는 READ, WRITE, EXECUTABLE 세가지 메모리 권한이 있습니다.

1. writable 한 메모리 영역에만 코드를 재작성할 수 있습니다.
2. executable 한 영역의 코드만 실행될 수 있습니다.

linking을 할 때에 옵션을 --omagic 을 주었기 때문에, .text 세그먼트의 모든 메모리영역이 rwx 권한을 가짐으로 가능한 코드였습니다.