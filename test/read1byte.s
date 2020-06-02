;Effective Addresses
;https://nasm.us/doc/nasmdoc3.html#section-3.3
section .data
var1:
db 0x00, 0x01, 0x02, 0x03, 0x04
var2:
db 0x05,  0x06, 0x07, 0x08, 0x09
section .text
global _start

_start:
	mov al, [var1]
	mov al, [var1+1]
	mov al, [var1+2]
	mov al, [var1+3]
	mov al, [var1+4]
	mov al, [var1+5]
	mov al, [var1+6]
	mov al, [var1+7]
	mov al, [var1+8]
	mov al, [var1+9]
	; mov ebx, [var1+4]
	; mov ax,[wordvar+1]
	; mov ax,[es:wordvar+bx]
	jmp halt
halt:
	jmp halt

;1byte 씩 읽습니다.
;nasm -felf32 read1byte.s && ld -m elf_i386 --omagic read1byte.o -o read1byte && gdb read1byte
