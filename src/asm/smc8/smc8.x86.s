section .text
global _start

_start:
    mov eax, body           ; eax <- load address of body

body:
    mov ebx, [eax + 12]      ; ebx <- load instruction [eax + 12] (add esi, 10)
    nop
    mov ecx, [eax + 16]     ; ecx <- load instruction [eax + 16] (add esi, 10)
    nop
    mov [eax + 12], ecx      ; allocate instruction of ecx in pointer of eax + 12
    nop
    add esi, 10             ; add esi = esi + 10
    nop
    add esi, 10             ; add esi = esi + 10
    nop
    mov [eax + 16], ebx     ; allocate instruction of ebx in pointer of eax + 16
    nop
    mov ecx, [eax + 8]      ; ecx <- load instruction [eax + 8] (mov [eax + 12], ecx)
    nop
    mov ebx, [eax + 20]     ; ebx <- load instruction [eax + 20] (mov [eax + 16], ebx)
    nop
    mov [eax + 20], ecx     ; allocate instruction of ecx in pointer of eax + 20
    nop
    mov [eax + 8], ebx      ; allocate instruction of ebx in pointer of ebx + 8
    nop
    add edx, 1
    cmp edx, 2
    jnz body                ; jmp body
    mov eax, 1
    mov ebx, 0
    int 0x80
