#### smc2.x86.s

```
section .data
section .text
global _start

_start:
	mov eax, [work]	; eax <- [work] ("jmp halt")
	mov [end], eax
end:
	jmp gohome	; j dead
gohome:
	mov eax, 1
	int 0x80
work:
	jmp halt
halt:
	jmp halt
```

#### 어셈블링, 링킹, 실행

```bash
nasm -felf32 smc2.x86.s && ld -m elf_i386 --omgaics smc2.x86.o -o smc2.x86 && ./smc2.x86
```

본래라면 gohome 으로 가서 정상 종료가 되겠지만.

jmp gohome 의 명령어를 jmp halt로 명령어를 바꿔서

jmp halt => jmp halt 계속해서 무한루프가 돌게 됩니다.