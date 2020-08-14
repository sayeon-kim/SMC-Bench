section .text
global _start
_start:
	call f		; jal f
	mov ebx, edi	; move $2, $8	
	jmp halt		; j halt
  
f:
	mov edi, 42	
	mov ebp, [esp]	
	mov cl, [ebp-5]	
	mov esi, addr		; esi <- addr of addr
	mov dl, [esi]
	cmp cl, dl	
	jne halt
	ret			
  
halt:
	mov eax, 1
	int 0x80		; j halt
  
addr:
	call f

;13번째 코드를 보면 ecx == esi 로 같아야되는데 16bit 포인터를 이용한 상대점프를 사용하므로 
;_start분기의 jmp f명령어와 addr분기의 jmp f명령어의 맨 앞 1바이트만 가지고 와서 비교한다.
;ecx == esi 이므로 ret에 해당하는 esp주소로 분기된다.

;nasm -felf32 smc4.x86.s && ld -m elf_i386 --omagic smc4.x86.o -o smc4.x86 && ./smc4.x86
;objdump smc4.x86 -d
;gdb smc4.x86
