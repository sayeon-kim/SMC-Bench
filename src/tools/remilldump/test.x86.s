section .text
global _start
_start:
	mov eax, 1111
	push eax
	mov eax, 2222
	push eax
	mov eax, 3333
	push eax
	mov eax, 4444
	push eax
	mov eax, 5555
	push eax 
	mov eax, 6666
	push eax 
	mov eax, 7777
	push eax 
	mov eax, 8888
	push eax 
	mov eax, 9999
	push eax 

; nasm -felf32 test.x86.s -o test.x86.o