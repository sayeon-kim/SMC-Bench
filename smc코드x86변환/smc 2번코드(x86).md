# smc 2번코드(x86)

### MIPS코드

```assembly
	.text
	
	j main	
halt:	
	j halt
main:	
	la $9, end  
    lw $8, 0($9)
    addi $8, $8, -1
    addi $8, $8, -2
    sw $8, 0($9)
end:	
	j dead
dead:
```

### x86코드

```assembly
section .data
section .text
global _start

	jmp _start	; j main
halt:
   	hlt		; j halt
_start:
    mov eax, end	; la $9, end
	mov ebx, [eax]	; lw $8, 0($9)
	sub ebx, 1	; addi $8, $8, -1
	sub ebx, 2	; addi $8, $8, -2
	mov [eax], ebx	; sw $8, 0($9)
End:
	jmp dead	; j dead
Dead:
```

</br>

_start분기로 이동

```assembly
jmp _start
```

</br>

eax = $9, ebx = $8

mov eax, end : end분기의 주소를 eax에 저장

mov ebx, [eax] : end분기의 주소가 가리키는 명령어를 ebx에 저장

sub ebx, 1 : ebx = end분기의 주소가 가리키는 명령어 - 1

sub ebx, 2 : ebx = ebx - 2

mov [eax], ebx : ebx값을 end분기의 주소가 가리키는 값에 저장

jmp dead 명령어 : 10번째 명령어로 분기

[eax] : jmp dead 명령어 -3 : 7번째 명령어로 분기 -> mov ebx, [eax]

3을 또 빼면 4번째 명령어로 분기 

```assembly
_start:
    	mov eax, end; la $9, end
	mov ebx, [eax]	; lw $8, 0($9)
	sub ebx, 1	; addi $8, $8, -1
	sub ebx, 2	; addi $8, $8, -2
	mov [eax], ebx	; sw $8, 0($9)
```

</br>

4번째 명령어

```assembly
halt:
	hlt
```

</br>

</br>

end 분기의 명령어 jmp dead에 뺄셈으로분기 방향을 정해주는 overwriting코드