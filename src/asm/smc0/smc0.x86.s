section .text
global _start
_start:
	mov ah, 0xb8
	mov [_modified], ah
	mov ah, 0x01
	mov [_modified+1], ah
	mov ah, 0x00
	mov [_modified+2], ah
	mov ah, 0x00
	mov [_modified+3], ah
	mov ah, 0x00
	mov [_modified+4], ah ; mov eax, 1 : 0x b8 01 00 00 00

	mov ah, 0xbb
	mov [_modified+5], ah
	mov ah, 0xe7
	mov [_modified+6], ah
	mov ah, 0x03
	mov [_modified+7], ah
	mov ah, 0x00
	mov [_modified+8], ah
	mov ah, 0x00
	mov [_modified+9], ah ; mov ebx, 999 : 0x bb e7 03 00 00

	mov ah, 0xcd
	mov [_modified+10], ah
	mov ah, 0x80
	mov [_modified+11], ah ; int 0x80 : 0x cd 80

_break:
	nop;

_modified:
;mov eax, 1
	nop ;
	nop ;
	nop ;
	nop ;
	nop ;
;mov ebx, 999
	nop ;
	nop ;
	nop ;
	nop ;
	nop ;
;int 0x80
	nop;
	nop;

;https://chromium.googlesource.com/chromiumos/docs/+/master/constants/syscalls.md#x86-32_bit
; echo "section .text" > test.x86.s && echo "_start:" >> test.x86.s &&  echo "mov eax, 1" >> test.x86.s && nasm -felf32 test.x86.s -o test.o && objdump -d test.o
; nasm -felf32 smc0.x86.s -o smc0.x86.o && objdump -d smc0.x86.o
; ld -m elf_i386 smc0.x86.o -o smc0.x86.out --omagic
; gdb smc0.x86.out

;echo "section .text" > test.x86.s && echo "_start:" >> test.x86.s &&  echo "mov eax, 1" >> test.x86.s && nasm -felf32 test.x86.s -o test.o && objdump -d test.o

;nasm -felf32 smc0.x86.s -o smc0.x86.o && objdump -d smc0.x86.o && ld -m elf_i386 smc0.x86.o -o smc0.x86.out --omagic && gdb smc0.x86.out

;readelf -S smc0.x86.o
;xxd -p -s 0x130 -l 0x70 smc0.x86.o

;b4b8882563000000b401882564000000b400882565000000b400882566000000b400882567000000b4bb882568000000b4e7882569000000b40388256a000000b40088256b000000b40088256c000000b4cd88256d000000b48088256e000000eb019090909090909090909090909090
