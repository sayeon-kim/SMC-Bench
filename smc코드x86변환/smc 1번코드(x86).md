# smc 1번코드(x86)

### MIPS코드

```assembly
	.text
main:	
	beq $2, $4, modify
target: 
	move $2, $4
halt:	
	j halt
modify: 
	lw $9, new
	sw $9, target
	j target
new:	
	addi $2, $2, 1
```

### x86코드

```assembly
section .data
section .text
global _start

_start:
    cmp eax, edx		; beq $2, $4, modify
    jz modify
target:
    mov eax, edx     	; move $2, $4
halt:
    hlt					; j halt
modify:
    mov ebx, [new]      ; lw $9, new
    mov [target], ebx	; sw $9, target
    jmp target        	; j target
new:
    add eax, 1        	; addi $2, $2, 1
```

</br>

eax == $2, edx == $4

cmp와 분기 명령어는 항상 세트로 움직인다.

cmp eax, edx : eax == edx 이면 특정레지스터에 0 저장

jz modify : 저장된 특정 레지스터 값이 0이면 modify로 분기. 아니면 다음 줄로 이동

```assembly
_start:
    cmp eax, edx
    jz modify
```

</br>

ebx == $9

new : new 분기의 주소

[new] : new분기의 주소가 가리키는 값

mov ebx, [new] : new분기의 주소가 가리키는 값 즉, add eax, 1이라는  명령어를 ebx레지스터에 저장

mov [target], ebx : add eax, 1이라는 명령어를 target분기의 주소가 가리키는 값에 저장

```assembly
target:				->	target:
    mov eax, edx			add eax, 1
```

jmp target : target 분기로 이동

```assembly
modify:
    mov ebx, [new]      
    mov [target], ebx	
    jmp target        	
```

</br>

eax = eax + 1

```assembly
target:
    add eax, 1
```

</br>
hlt : halt(정지)

```assembly
halt:
    hlt
```

</br>

</br>

target 분기의 명령어 mov eax, edx-> add eax, 1 overwriting하는 코드