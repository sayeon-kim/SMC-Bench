section .data
section .text
global _start

_start:
    jmp modify
halt:
	mov eax, 1
	int 0x80
modify:
    mov ebx, [new]      ; lw $9, new
    mov [target], ebx	; sw $9, target
    jmp target        	; j target
target:
    mov ebx, 1     	; move $2, 1
	jmp halt
new:
    mov ebx, 0        	; addi $2, $2, 1
