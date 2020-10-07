section .text
global _start



_start:
    nop ; gdb point
    mov eax, loop   ; eax <- addr of loop
    mov ebx, new
    mov ecx, new
    mov esi, 2
    mov edi, 4
    mov ebp, 0
loop:
    mov edx, [eax]  ; edx <- instruction of loop
    mov [ebx], edx  ; [ebx] <- store instruction of loop in pointer of ebx
    add eax, esi    ; eax += 2, instruction length is 2byte
    add ebx, esi    ; ebx += 2
    cmp eax, ecx    ; comparison about eax and ecx
    jne loop        ; if not equal, than jump to the loop.
    mov ecx, ebx    ; if equal, all code is copied in new label
    add ebp, esi
    cmp ebp, edi
    je halt         ;halt is relative address, so if we repeat 2 times code, we need to subtract value 
    
new:
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop

halt:
    mov eax, 1
    int 0x80
    

;nasm -felf32 smc7.x86.s && ld -m elf_i386 --omagic smc7.x86.o -o smc7.x86 && ./smc7.x86
