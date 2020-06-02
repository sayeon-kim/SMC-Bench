section .data

section .text

global _start

_start:
    jmp alter
    mov [alter], ax
    
alter:
    mov ax, [_start]    ; eax <- load instruction of _start (jmp alter)
    mov bl, 0x90        ; al <- load instruction of nop
    mov [_start], bl    ; store address of nop in _start
    mov [_start+1], bl
    jmp _start          ; jmp _start

    
   
