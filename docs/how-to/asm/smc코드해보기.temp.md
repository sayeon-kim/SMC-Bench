#### smc1.x86.s

```assembly
section .data
section .text
global _start

_start:
	;[addr, addr+len-1].  addr must be aligned to a page boundary.
	mov eax, 125 ;mprotect syscall number
	mov ebx, _start ; *addr
	mov ecx, 0x10000 ;page interval.
	mov edx, 7 ; rwx permission
	int 0x80
    jmp modify
target:
    mov eax, edx     	; move $2, $4
halt:
	mov ebx, 1
	mov eax, 1
	int 0x80
modify:
    mov ebx, [new]      ; lw $9, new
    mov [target], ebx	; sw $9, target
    jmp target        	; j target
new:
    mov ebx, 0        	; addi $2, $2, 1
```

#### 어셈블링, 링킹, 실행

```bash
nasm -felf32 smc1.x86.s && ld -m elf_i386 smc1.x86.o -o smc1.x86 && ./smc1.x86
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
 8048060:       b8 7d 00 00 00          mov    $0x7d,%eax
 8048065:       bb 60 80 04 08          mov    $0x8048060,%ebx
 804806a:       b9 00 00 01 00          mov    $0x10000,%ecx
 804806f:       ba 07 00 00 00          mov    $0x7,%edx
 8048074:       cd 80                   int    $0x80
 8048076:       eb 0e                   jmp    8048086 <modify>

08048078 <target>:
 8048078:       89 d0                   mov    %edx,%eax

0804807a <halt>:
 804807a:       bb 01 00 00 00          mov    $0x1,%ebx
 804807f:       b8 01 00 00 00          mov    $0x1,%eax
 8048084:       cd 80                   int    $0x80

08048086 <modify>:
 8048086:       8b 1d 94 80 04 08       mov    0x8048094,%ebx
 804808c:       89 1d 78 80 04 08       mov    %ebx,0x8048078
 8048092:       eb e4                   jmp    8048078 <target>

08048094 <new>:
 8048094:       bb 00 00 00 00          mov    $0x0,%ebx
```



#### gdb로 분석

#### gdb 실행

```bash
gdb smc1.x86
```

#### mprotect가 잘 호출되었는가?

```bash
b _start
b modify
c
info registers
# 이 때의 eax 값이 0 이어야 mprotect가 정상종료 된 것...
```



#### Segment Permission

pmap 명령어를 통해서, 해당 메모리의 권한을 확인할 수 있습니다..

```bash
pmap <pid>
#또는
cat /proc/<pid>/maps
```

Linux에서는 mprotect 라는 syscall을 지원을 해 줍니다.(WIndows 에서는 또 다른 함수가 있는 것 같습니다.. 일단은 Linux 환경에서 먼저.)

```bash
root@SWLAB:/home/work# pmap 22030
22030:   /home/work/smc1
0000000008048000      4K r-x-- smc1
00000000f7ff9000     12K r----   [ anon ]
00000000f7ffc000      8K r-x--   [ anon ]
00000000fffdd000    132K rwx--   [ stack ]
```

r x 권한만 있고, write 권한이 없어서 잘 안되는걸 확인할 수 있습니다.

mprotect 를 사용해서 write 권한을 줘야 합니다.

#### elf32에서 mprotect 사용하기

```assembly
_mprotect:
    mov eax, 125
    mov ebx, 0 ; 권한을 바꿔줄 address의 시작지점.
    mov ecx, 0 ; 권한을 바꿔줄 address의 interval 값. [ebx, ebx+ecx-1] 의 메모리 범위에 적용.
    move edx, 0x1; 권한. PROT_READ 0x04 PROT_WRITE 0x02 PROTE_EXEC 0x01 비트플래그.
```

이 때에 address는 page boundary 값이 되어야 합니다. http://man7.org/linux/man-pages/man2/mprotect.2.html

#### pageSize

```bash
getconf PAGE_SIZE
4096
```

위의 명령어를 사용하면 PAGE_SIZE를 알 수 있습니다.





#### 현재 문제점

mprotect 가 정상적으로 작동하지가 않습니다.

gdb로 확인해보니. eax 값이 0이 되는게 아니라 -22 로 에러가 났다고 말합니다.

어떻게 해야할까요?

```bash
Starting program: /home/work/smc1.x86 

Breakpoint 1, 0x08048060 in _start ()
(gdb) c
Continuing.

Breakpoint 2, 0x08048086 in modify ()
(gdb) info registers 
eax            0xffffffea       -22
ecx            0x10000  65536
edx            0x7      7
ebx            0x8048060        134512736
esp            0xffffd3a0       0xffffd3a0
ebp            0x0      0x0
esi            0x0      0
edi            0x0      0
eip            0x8048086        0x8048086 <modify>
eflags         0x202    [ IF ]
cs             0x23     35
ss             0x2b     43
ds             0x2b     43
es             0x2b     43
fs             0x0      0
gs             0x0      0
```



#### Conclusion

https://stackoverflow.com/questions/61816941/allocate-writable-memory-in-the-text-section

이곳에 가면. ld 명령을 할 때 옵션값을 넣어준다고 합니다.

```bash
root@SWLAB:/home/work# pmap 23230

23230:   /home/work/zsmc1.x86
0000000008048000      4K rwx-- zsmc1.x86
00000000f7ff9000     12K r----   [ anon ]
00000000f7ffc000      8K r-x--   [ anon ]
00000000fffdd000    132K rwx--   [ stack ]
```

ld --omagic 명령어를 사용한 후에, pamp 명령어를 통해서 확인해보니 rwx 로 write 권한이 생겼음을 확인할 수 있습니다.



새로나온 최종적인 실행 명령어.

```bash
nasm -felf32 smc1.x86.s && ld -m elf_i386 --omagic smc1.x86.o -o smc1.x86 && ./smc1.x86
```

