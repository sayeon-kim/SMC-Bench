section .text
global _start

halt:
    jmp halt; halt <- 0x8048060

_start:
    mov eax, loop ; eax <- addr of loop
    mov ebx, new
    mov ecx, new
    mov esi, 4
    mov edi, 20
    mov ebp, 0
loop:
    mov edx, [eax] ; edx <- instruction of loop
    mov [ebx], edx ; [ebx] <- store instruction of loop in pointer of ebx
    add eax, esi ; eax += 4, instruction length is 2byte 2�پ� ����
    add ebx, esi ; ebx += 4
    cmp eax, ecx ; comparison about eax and ecx
    jne loop ; if not equal, than jump to the loop.
    mov ecx, ebx ; if equal, all code is copied in new label
    add ebp, esi
    cmp ebp, edi
    je halt-100 ;halt is relative address, so if we repeat 5 times code, we need to subtract value 
new: