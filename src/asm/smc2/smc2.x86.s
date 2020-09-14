section .text
global _start
_start:
	nop
	mov eax, 0x804806c
	call eax		; jal f
	mov ebx, edi	; move $2, $8	
	jmp halt		; j halt
  
f:
	mov edi, 42	
	mov ebp, [esp]	
	mov cx, [ebp-2]	
	mov esi, addr		; esi <- addr of addr
	mov dx, [esi+5]
	cmp cx, dx	
	jne halt
	ret			
  
halt:
	mov eax, 1
	int 0x80		; j halt
  
addr:
	mov eax, 0x804806c
	call eax

;gdb 명령어가 들어가는 nop을 _start 분기 첫번째에 생성하였다. break를 _start분기에 걸기를 추천한다.
;절대주소를 이용하여 call f를 실행하였다.
;call f 명령어는 2바이트 크기를 가지므로 _start의 call eax 2바이트, addr의 call eax 2바이트를 각각 cx, dx에 넣어 비교한다.
;cx == dx 이므로 ret에 해당하는 esp주소로 분기된다.

;nasm -felf32 smc4.x86.s && ld -m elf_i386 --omagic smc4.x86.o -o smc4.x86 && ./smc4.x86
;objdump smc4.x86 -d
;gdb smc4.x86
