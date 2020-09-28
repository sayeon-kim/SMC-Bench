section .text
global _start

_start:
    jmp alter
    mov [alter], ax         ; [alter](mov ax, [_start]) <- load instruction [ax] (jmp alter)
	
    
alter:
    mov ax, [_start]        ; ax <- load instruction [_start] (jmp alter)
    mov bl, 0x90            ; bl <- load instruction [0x90] (nop)
    mov [_start], bl        
    mov [_start+1], bl      ; instruction [_start] (jmp alter) is changed (nop)
    mov [re_start], bl    
    mov [re_start+1], bl    ; instuction [re_start] (jmp halt) is changed (nop)

re_start:
    jmp halt                ; jmp halt가 실행될것 같지만 alter분기에서 nop으로 변경되어 실행되지 않는다.
    jmp _start              

halt:
    nop