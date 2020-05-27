section .data
section .text

global _start

_start:
	mov eax, [halt]	; eax <- [work] ("jmp halt")
	mov [end], eax

end: 
	jmp gohome	; j dead

gohome:
	mov eax, 1
	int 0x80

halt:
	jmp halt
	;nasm -felf32 smc2.x86.s && ld -m elf_i386 --omgaics smc2.x86.o -o smc2.x86 && ./smc2.x86
