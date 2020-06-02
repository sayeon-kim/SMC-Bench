section .text

global _start


_start:
    mov eax, body

body:
    mov ebx, [eax + 9]      
    mov ecx, [eax + 12]
    mov [eax + 9], ecx
    add esi, 10
    add esi, 10
    mov [eax + 12], ebx
    mov ecx, [eax + 6]
    mov ebx, [eax + 15]
    mov [eax + 15], ecx
    mov [eax + 6], ebx
    jmp body

;코드 작성중 아직 완성 x 