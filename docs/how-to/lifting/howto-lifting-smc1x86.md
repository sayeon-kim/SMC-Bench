#### Features

Mcsema Commit Version : f8ade494accf887f9d03b6bed901fef8ace5e255

Remill Commit Version : 86a6424d58cca6504a93bf7dc4363f14be9e216f

#### smc1.x86.s

```c
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

#### assemble

``` bash
nasm -felf32 smc1.x86.s && ld -m elf_i386 smc1.x86.o -o smc1.x86 && ./smc1.x86
```

#### make cfg

```bash 
mcsema-disass --disassembler /opt/ida-7.1/idat64 --os linux --arch x86 --output smc1.x86.cfg --binary smc1.x86 --entrypoint _start --log_file x86.log
```

여기에서. entrypoint의 option을 _start 라는 labe로 줘도 괜찮은지?



오류는 없지만, function이 존재하지가 않습니다.

=> 실행할 수가 없습니다. lli로.