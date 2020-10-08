section .data
    num db 8

section .text
global _init
_init:
    mov ebp, num  ; num
    mov ecx, 1 	  ; counter
    mov edx, 1 	  ; accumulator

loop:
    cmp ecx, [ebp]   ; compare num and counter
    jz halt          ; if num and counter equal then jump halt.
    add ecx, 1       ; else, counter add 1.
    mov bl, dl       ; save constant operand of add instruction to bl register.(Store Fn into bl.)

key:
    add edx, 0       ; Store next Fibonacci number to edx(Fn + Fn-1 = Fn+1)
    mov al, bl       ; store Fn fibonachi value into al.
    mov [key+2], al  ; update constant operand of add instruction. in add(edx, constant), (Fn). next instruction, Fn+2 = Fn+1 + Fn. and, now is edx Fn+1.
    jmp loop

halt:   ; exit
    mov eax, 1
    xor ebx, ebx
    int 0x80

; nasm -felf32 smc1.x86.s -o smc1.x86.o
; ld -m elf_i386 --omagic smc1.x86.o -o smc1.x86
; gdb ./smc1.x86
; b halt
; r
; info registers