section .data
exit_string db "Exit Program,", 0x0d, 0x0a
exit_string_len equ $ - exit_string
smc_string db "This code is modified", 0x0d, 0x0a
smc_string_len equ $ - smc_string

;sys_nanosleep use struct timespec
;timespec structure has two members
timeval:
	tv_sec dd 1 ; 32 bit seconds
	tv_nsec dd 0 ; 32 bit nanoseconds

section .text
global _start

_start:
	jmp modify
modify:
	;write 7byte instructions to target.
	mov eax, [new] ; eax <- (new+0, new+1, new+2, new+3)
	mov [target], eax ; eax(new+0, new+1, new+2, new+3) -> target(target+0, target+1, target+2, target+3)
	mov eax, [new+3] ; eax <- (new+3, new+4, new+5, new+6)
	mov [target+3], eax ; eax(new+3, new+4, new+5, new+6) -> target+3(target+3, target+4, target+5, target+6)
	
	jmp target
new:
	mov eax, halt ; 5byte instruction
	jmp eax    	  ; 2byte instruction, absolute jump.
halt:
	mov eax, 4 ; eax <- 4, syscall number (print)
	mov ebx, 1 ; ebx <- 1, syscall argument1 (stdout)
	mov ecx, smc_string ; ecx <- smc_string, syscall argument2 (string ptr)
	mov edx, smc_string_len ; edx <- smc_string_len, syscall argument3 (string len)
	int 0x80; ; syscall

	mov eax, 162; eax <- 162, syscall number (sleep)
	mov ebx, timeval ; ebx <- 1, syscall argument1 (sleep second)
	mov ecx, 1000 ; ecx <- 0, syscall argument2 (sleep nanosecond)
	int 0x80; syscall

	jmp halt ; infinity loop
target:
	nop ;place holder
	nop
	nop
	nop
	nop
	nop
	nop
exit:
	mov eax, 4 ; eax <- 4, syscall number (print) But, never execute.
	mov ebx, 1 ; ebx <- 1, syscall argument1 (stdout) But, never execute.
	mov ecx, exit_string ; ecx <- exit_string, syscall argument2 (string ptr) But, never execute.
	mov edx, exit_string_len ; edx <- exit_string_len, syscall argument3 (string len) But, never execute.
	int 0x80; ; syscall But, never execute.
	mov eax, 1 ; eax <- 1, syscall number (exit) But, never execute.
	mov ebx, 0 ; ebx <- 0, syscall argument1 (return value) But, never execute.
	int 0x80; syscall But, never execute.

;nasm -felf32 smc1.x86.s -o smc1.x86.o
;ld -m elf_i386 smc1.x86.o -o smc1.x86.out