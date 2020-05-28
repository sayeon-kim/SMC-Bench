;Effective Addresses
;https://nasm.us/doc/nasmdoc3.html#section-3.3
section .data
var1:
db 0x01, 0x00, 0x00, 0x00
var2:
db 0x02,  0x00, 0x00, 0x00
section .text
global _start

_start:
	mov eax, [var1]
	mov ebx, [var1+4]
	; mov ax,[wordvar+1]
	; mov ax,[es:wordvar+bx]
	jmp halt
halt:
	jmp halt

;eax에 var1에 저장되어 있는 값을 가져옵니다.
;nasm -felf32 loadData.s && ld -m elf_i386 --omagic loadData.o -o loadData && gdb loadData