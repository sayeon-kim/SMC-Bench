section .data
section .text
global _start

_start:
    jmp alter	        ;j alter
    mov [alter], ebx  ;sw $8, alter
alter:
    mov eax, [_start] ; lw $8, _start
    mov ebx, [modify] ; li $9, 0
    mov [_start], ebx ; sw $9, _start
    jmp _start

modify :
    mov ebx, 0x0
    
    
   
