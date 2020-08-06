section .text
global _start

_start:
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
	jmp _start      ; jmp _start

dead:
	jmp dead
  
  
;g:
; mov [eax], ebx	;
; nop
; nop
;h:
; mov [eax], ebx	;
; nop
; nop
