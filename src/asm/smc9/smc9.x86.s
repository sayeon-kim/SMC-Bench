section .text
global _start

_start:
    mov eax, pg             ; eax <- load address of pg
    mov ebx, pgend          ; ebx <- load address of pgend
    mov ecx, 0xffffffff     ; ecx <- assign value of 0xffffffff

xor1:
    mov edx, [eax]          ; store instruction that pointed by eax in edx
    xor edx, ecx            ; xor edx, ecx, and store result value in edx
    mov [eax], edx          ; store instruction in edx where eax points
    add eax, 4              ; add 4 to eax
    cmp eax, ebx            ; compare eax and ebx so if eax is less than ebx
    jl xor1                 ; loop xor1
                            ; so code of xor1 converts pg code to xor form
decr:
    mov eax, pg             ; eax <- reload address of pg
    mov ebx, pgend          ; ebx <- reload address of pg
    mov ecx, 0xffffffff     ; ecx <- reassign value of 0xffffffff

xor2:
    mov edx, [eax]          ; store instruction that pointed by eax in edx
    xor edx, ecx            ; xor edx, ecx, and store result value in edx
    mov [eax], edx          ; store instruction in edx where eax points
    add eax, 4              ; add 4 to eax
    cmp eax, ebx            ; compare eax and ebx so if eax is less than ebx
    jl xor2                 ; jmp xor2
    jmp pg                  ; else jmp pg

halt:
    jmp halt                ; when program get here, the program ended

pg:
    add esi, 10             ; meaningless code
    nop
    add edi, 10             ; meaningless code
    nop
    jmp halt
    nop
    nop

pgend:

