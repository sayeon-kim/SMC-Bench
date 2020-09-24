section .text
global _start

_start:
	nop
	mov esi, 0		; count = 0
	mov eax, g		; eax <- load address of g
	mov ebx, [eax]	; ebx <- load instruction of g (mov [eax], ebx)
	add eax, 7     ; eax <- load address of h
	mov edx, [h]	; edx <- load instruction of h (jmp dead)
g:
	mov [eax], ebx	;
	nop
	nop
	sub eax, 7   ; eax <- load address of g
h:
	jmp dead
	nop
	nop
	mov [h], edx
	add esi, 1		; count += 1
	cmp esi, 2		; if(count == 2) jmp dead:
	je dead
	mov edi, _start	; edi <- load address of _start
	add edi, 6		; edi <- load address of _start + 6 (mov eax, g)
	jmp edi      ; jmp _start

dead:
	mov eax, 1
	int 0x80
  
  
;g:
; mov [eax], ebx	;
; nop
; nop
;h:
; mov [eax], ebx	;
; nop
; nop

;nasm -felf32 smc5.x86.s && ld -m elf_i386 --omagic smc5.x86.o -o smc5.x86 && ./smc5.x86