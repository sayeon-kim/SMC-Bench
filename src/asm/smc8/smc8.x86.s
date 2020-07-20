section .text
global _start

_start:
    jmp alter           ; jmp alter
    mov [alter], ax
    
alter:
    mov ax, [_start]    ; ax <- load instruction of _start (jmp alter)
    mov bl, 0x90        ; bl <- load instruction of nop
    mov [_start], bl    ; store address of 'nop' in _start
    mov [_start+1], bl
    jmp _start          ; jmp _start

;_start:
;   nop
;   mov [alter], ax
;alter:
;   jmp alter
