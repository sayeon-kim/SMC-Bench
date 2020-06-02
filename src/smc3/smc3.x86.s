section .data
	num db 8
section .text
global _start

_start:
	mov ebp, num 	; num
	mov ecx, 1 	; counter
	mov edx, 1 	; accumulator
loop:
	cmp ecx, [ebp]	; num==counter
	jz halt
	add ecx, 1	; inc counter
	mov al, [key+2]
	mov bl, dl
	add al, dl
key:
	add edx, 0	; Fibonacci number 1, 1, 2, 3, 5, 8, 13
	mov al, bl
	mov [key+2], al

	jmp loop
halt:			; exit
	mov eax, 1
	xor ebx, ebx
	int 0x80


