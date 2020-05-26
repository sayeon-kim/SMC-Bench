section .data
section .text
global _start

_start:
	mov eax, [work]	; eax <- [work] ("jmp halt")
	mov [end], eax
end:
	jmp gohome	; j dead
gohome:
	mov eax, 1
	int 0x80
work:
	jmp halt
halt:
	jmp halt
	;nasm -felf32 smc2.x86.s && ld -m elf_i386 --omgaics smc2.x86.o -o smc2.x86 && ./smc2.x86
