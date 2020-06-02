section .text

global _start

_start:
    mov eax, body           ; eax <- load address of body

;명령어 길이가 3byte이기 때문에 nop을 추가해서 4byte로 만들어줌.
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
    jmp body                ; jmp body