section .data

section .text

global _start

_start:
    mov eax, gen        ; eax <- load address of gen
    mov ebx, 0x8048095  ; ebx <- load address of 0x8048095(halt)
    mov edx, [ebx]
    mov [eax], edx      ; eax <- store instruction of ebx(mov ecx, ebx) 
    mov ebx, 0x8048097 ; ebx <- load address of 0x8048097(halt+2)
    add eax, 4          ; eax <- load address of (gen+4)
    mov edx, [ebx] 
    mov [eax], edx      ; eax <- store instruction of ebx(jmp ecx)
    mov ecx, ggen       ; ecx <- load address of ggen
    mov eax, _start     ; eax <- load address of _start
    mov ebx, 0x8048099  ; ebx <- load address of 0x8048099(halt+4)
    mov edx, [ebx]
    mov ebx, edx
    jmp gen             ; jump gen

gen:
    nop
    nop
    nop
    nop
ggen:
    nop
    nop

halt:
    mov [ecx], ebx
    jmp ecx
    jmp eax

; edx is instruction of ebx
