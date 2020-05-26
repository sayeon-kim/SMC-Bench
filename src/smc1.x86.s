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