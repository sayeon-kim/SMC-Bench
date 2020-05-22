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
    cmp eax, edx	; beq $2, $4, modify
    jz modify
target:
    mov eax, edx     	; move $2, $4
halt:
    hlt			; j halt
modify:
    mov ebx, [new]      ; lw $9, new
    mov [target], ebx	; sw $9, target
    jmp target        	; j target
new:
    add eax, 1        	; addi $2, $2, 1
```

</br>

eax == $2, edx == $4 (eax는 누산기, 리턴값, 저장공간, edx는 eax보조역할)

$2=> 함수로부터 반환한 값을 저장하는 레지스터 ($2~$3)

$4=> 함수 인수 저장용 레지스터 ($4~$7)

cmp와 분기 명령어는 항상 세트로 움직인다.

cmp eax, edx : eax == edx 이면 특정레지스터에 0 저장

jz modify : 저장된 특정 레지스터 값이 0이면 modify로 분기. 아니면 다음 줄로 이동

```assembly
_start:
    cmp eax, edx
    jz modify
```

</br>

ebx == $9 (ebx가 주소 지정시 사용된다고 해서 사용했음??)

$9=> 어셈블리나 어셈블리 언어에서 값을 임시로 저장할때 사용하는 레지스터 ($8~$15, $24~$25)

new : new 분기의 주소

[new] : new분기의 주소가 가리키는 값

mov ebx, [new] : new분기의 주소가 가리키는 값 즉, add eax, 1이라는  명령어를 ebx레지스터에 저장

mov [target], ebx : add eax, 1이라는 명령어를 target분기의 주소가 가리키는 값에 저장

```assembly
target:			->	target:
    mov eax, edx		add eax, 1
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


<br><br>
modify의 mov [target], ebx 에서 segmentation fault 발생
![image](https://user-images.githubusercontent.com/37640219/82619275-7ab03700-9c10-11ea-9da2-c884ed7b4b28.png)
