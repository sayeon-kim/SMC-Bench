

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
	mov edx, _start		; edx에 _start첫번째 명령어주소를 넣어줌
	add edx, 12		; edx = edx + 12 (_start의 4번째 명령어주소)
	jmp f			; jal f
	mov eax, ebx		; move $2, $8
	jmp halt		; j halt
f:
	mov ebx, 42		; li $8, 42
	mov ecx, [edx-4]	; lw $9, -4($31)
	mov esi, addr		; lw $10, addr
	mov esp, [esi+8]	; addr의 세번째 명령어
	cmp ecx, esp		; bne $9, $10, halt
	jne halt
	jmp [edx]			; jr $31
halt:
	hlt			; j halt
addr:
	mov edx, _start		; edx에 _start분기를 넣어줌
	add edx, 12		; edx = edx + 12 (_start의 4번째 명령어주소)
	jmp f			; jal f
```

<br>

### 코드설명

```assembly
_start:
	mov edx, _start		; edx에 _start첫번째 명령어주소를 넣어줌
	add edx, 12		; edx = edx + 12 (_start의 4번째 명령어주소)
	jmp f			; jal f
```

 edx에 _start의 4번째 명령어 주소저장($31 == $ra) 후 f분기로 점프

<br>

```assembly
f:
	mov ebx, 42		; li $8, 42
	mov ecx, [edx-4]	; lw $9, -4($31)
	mov esi, addr		; lw $10, addr
	mov esp, [esi+8]	; addr의 세번째 명령어
	cmp ecx, esp		; bne $9, $10, halt
	jne halt
	jmp edx			; jr $31
```

mov ecx, [edx-4] : _start의 세번째 명령어 저장

mov esi, addr : esi에 addr 첫번째 명령어 주소 저장

mov esp, [esi+8] : esi에 addr 세번째 명령어 저장

cmp ecx, esp : _start의세번째 명령어와 addr 세번째 명령어 다르면 halt로 분기(jal f 로 같아)

jmp edx : edx가 가리키는 주소로 분기(mov eax, ebx)

<br>

```assembly
mov eax, ebx		; move $2, $8
jmp halt		; j halt
```
mov eax, ebx : eax에 ebx 저장

jmp halt : halt로 분기 후 종료

<br>

세그먼트오류

<img src="C:\Users\spide\AppData\Roaming\Typora\typora-user-images\image-20200529012007044.png" alt="image-20200529012007044" style="zoom:100%;" />