section .text
global _start

copy1: ;7bytes
	mov eax, ggen
	jmp eax
copy2: ;7bytes
	mov eax, _start
	jmp eax

_start:
	mov eax, [copy1]
	mov ebx, [copy1+3]
	mov [gen], eax
	mov [gen+3], ebx
	mov eax, [copy2]
	mov ebx, [copy2+3]
	mov [ggen], eax
	mov [ggen+3], ebx
	jmp gen
 
gen:
	nop
	nop
	nop
	nop
	nop
	nop
	nop
ggen:
	nop
	nop
	nop
	nop
	nop
	nop
	nop

; edx is instruction of ebx