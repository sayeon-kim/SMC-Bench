_start:
	mov edi, _start		; edi <- addr of _start
	add edi, 10		; edi += 10 (mov eax, ebx instruction address)
	jmp f			; jal f <- 0x88048071
	mov eax, ebx		
	jmp halt		; j halt
  
f:
	mov ebx, 42		
	mov cl, [edi-2]	; ecx <- 0x8048068 (3rd instruction of _start jmp f)
	mov esi, addr		; esi <- addr of addr
	mov dl, [esi+8]	; esp <- 0x8048093 (3rd instruction of addr jmp f)
	cmp cl, dl		;if not equal, then jump to the halt
	jne halt
	jmp edi			; [edx] = [0x0804806a] (mov eax, ebx/_start 4th instruction)
  
halt:
	mov eax, 1
	int 0x80		; j halt
  
addr:
	mov edi, _start		; edi <- addr of _start
	add edi, 10		; edi += 10 (mov eax, ebx instruction address)
	jmp f			; jal f <- 0x88048071

;13번째 코드를 보면 ecx == esp 로 같아야되는데 16bit 포인터를 이용한 상대점프를 사용하므로 
;_start분기의 jmp f명령어와 addr분기의 jmp f명령어의 맨 앞 1바이트만 가지고 와서 비교한다.
;ecx == esp 이므로 jmp edi로 넘어간다.
