

# smc 4번코드(x86)

### MIPS코드

```assembly
	.text
main:	
	jal f	
    move $2, $8 
    j halt		
        
f:	
	li $8, 42
    lw $9, -4($31)
    lw $10, addr  
    bne $9, $10, halt
    jr $31

halt :	
	j halt

addr:	
	jal f
```

<br>

### x86코드

```assembly
section .data
section .text
global _start

_start:
	mov edi, _start		; edi에 _start분기를 넣어줌
	add edi, 16			; edi = edi + 16 (_start의 4번째 명령어)
	mov edx, edi		; edx = edi
	jmp f				; jal f
	mov eax, ebx		; move $2, $8
	jmp halt			; j halt
f:
	mov ebx, 42			; li $8, 42
	mov ecx, [edx-4]	; lw $9, -4($31)
	mov esi, addr		; lw $10, addr
	mov esp, [esi]
	cmp ecx, esp		; bne $9, $10, halt
	jne halt
	jmp edx				; jr $31
halt:
	hlt					; j halt
addr:
	mov edi, _start		; edi에 _start분기를 넣어줌
	add edi, 16			; edi = edi + 16 (_start의 4번째 명령어)
	mov edx, edi		; edx = edi
	jmp f				; jal f
```

<br>

### 코드설명

```assembly
_start:
	mov edi, _start		; edi에 _start분기를 넣어줌
	add edi, 16			; edi = edi + 16 (_start의 4번째 명령어)
	mov edx, edi		; edx = edi
	jmp f				; jal f
```

mov edx, edi : edx에 _start의 5번째 명령어 저장($31 == $ra)

<br>

```assembly
f:
	mov ebx, 42			; li $8, 42
	mov ecx, [edx-4]	; lw $9, -4($31)
	mov esi, addr		; lw $10, addr
	mov esp, [esi]
	cmp ecx, esp		; bne $9, $10, halt
	jne halt
	jmp edx				; jr $31
```

mov ecx, [edx-4] : _start의 4번째 명령어 저장

mov esi, addr : esi에 addr 첫 명령어 주소 저장

mov esp, [esi] : esi에 addr 첫 명령어 저장

cmp ecx, esp : _start의 3번째 명령어와 addr 첫번째 명령어 다르면 halt로 분기(jal f 로 같아)

jmp edx : edx가 가리키는 주소로 분기(mov eax, ebx)

<br>

```assembly
mov eax, ebx		; move $2, $8
jmp halt			; j halt
```
mov eax, ebx : eax에 ebx 저장

jmp halt : halt로 분기 후 종료

