section .text
global _start

_start:
    jmp alter
	mov eax,1
	int 0x80
    
alter:
    mov ax, [_start] 
     mov bl, 0x90     
     mov [_start], bl    
     mov [_start+1], bl
     jmp _start      