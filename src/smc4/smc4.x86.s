_start:
	mov edx, _start		; edx <- addr of _start
	add edx, 10		; edx += 10 (mov eax, ebx 명령어주소)
	jmp f			; jal f <- 0x804806e
	mov eax, ebx		
	jmp halt		; j halt
  
f:
	mov ebx, 42		
	mov ecx, [edx-2]	; ecx <- 0x8048068 (_start의 세번째 명령어 jmp f)
	mov esi, addr		; esi <- addr of addr
	mov esp, [esi+8]	; esp <- 0x8048093 (addr의 세번째 명령어 jmp f)
	cmp ecx, esp		;if not equal, then jump to the halt//ecx == esp
	jne halt
	jmp [edx]			; [edx] = [0x0804806a] (mov eax, ebx/_start 4번째 명령어)
  
halt:
	mov eax, 1
	int 0x80		; j halt
  
addr:
	mov edx, _start		; edx <- addr of _start
	add edx, 10		; edx += 10 (mov eax, ebx 명령어주소)
	jmp f			; jal f <- 0x804806e
