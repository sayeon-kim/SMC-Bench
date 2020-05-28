# smc 5번코드(x86)

### MIPS코드

```assembly
	.data                  # Data declaration section
vec1:   .word 22, 0, 25
vec2:   .word 7, 429, 6
result: .word 0
        
    	.text                  # Code section
main:   
li $4, 3           
    li $8, 0           
    la $9, gen         
    la $11, tpl        
    lw $12, 0($11)	   
    sw $12, 0($9)      
    addi $9, $9, 4     

loop:   
beq $8, $4, post   
    li $13, 4	   
    mul $13, $13, $8   
    lw $10, vec1($13)  
    beqz $10, next     
    lw $12, 4($11)	   
    add $12, $12, $13  
    sw $12, 0($9)	   
    lw $12, 8($11)     
    add $12, $12, $10  
    sw $12, 4($9)	   
    lw $12, 12($11)	   
    sw $12, 8($9) 	   
    lw $12, 16($11)	   
    sw $12, 12($9)	   
    addi $9, $9, 16    

next:   
addi $8, $8, 1
    j loop

post:   
lw $12, 20($11)
    sw $12, 0($9)
    la $4, vec2
    jal gen

    sw $2, result
    j main

tpl:    
li $2, 0
    lw $13, 0($4)
    li $12, 0
    mul $12, $12, $13
    add $2, $2, $12
    jr $31	

gen:	
	li $2, 0           # int gen(int *v)
	lw $13, 0($4)      # {
	li $12, 22         # int res = 0;
	mul $12, $12, $13  # res += 22 * v[0];
	add $2, $2, $12    # res += 25 * v[2];
	lw $13, 8($4)      # return res;
	li $12, 25         # }
	mul $12, $12, $13
	add $2, $2, $12
	jr $31
```

<br>

### x86코드

```assembly
; $4 => (eax 그냥 3)
; $8 => (ecx 카운터)
; $9 => (edi 복사작업시 목적지 주소 gen을 가리킴)
; $10 => (edx 가져온 벡터의 값)
; $11 => (ebx tpl의 주소)
; $12 => (esi 복사작업시 소스 주소)
; $13 => (ebp 벡터의 인덱스)
; $31 => (esp $31)
section .data
section .text
_vec1 dw 22, 0, 25
_vec2 dw 7, 429, 6
result dw 0

global _start

_start:
   mov eax, 3     				; li $4, 3
   mov ecx, 0     				; li $8, 0
   mov edi, gen  				; la $9, gen
   mov ebx, tpl   				; la $11, tpl

   mov esi, [edx] 				; lw $12, 0($11)   
   mov edx, [esi] 				; sw $12, 0($9) 
   mov [edi], edx 				 

   mov edx, dword [_vec1-0x2]  			; 2byte씩 꺼내오기 위해 미리저장해놓음 ???
   add edi, 4					; addi $9, $9, 4 	

loop:
   cmp eax, ecx					; beq $8, $4, post 
   je post
   mov ebp, 4					; li $13, 4
   imul ebp, [eax]				;mul $13, $13, $8

   mov edx, dword [_vec1+0x2] 			; lw $10, vec1($13) 
   cmp edx, 0					; beqz $10, next
   je next

   mov esi, [ebx+0x4]         			; lw $12, 4($11)    
   add esi, ebp					; add $12, $12, $13 
   mov [edi], esi				; sw $12, 0($9)

   mov esi, [ebx+0x8]				; lw $12, 8($11)
   add esi, [edx]				; add $12, $12, $10
   mov [edi+0x4], esi         			; sw $12, 4($9) 

   mov esi, [ebx+0x11]				; lw $12, 16($11)
   mov [edi+0x8], esi         			; sw $12, 8($9) 

   mov esi, [ebx+0x16]				; lw $12, 16($11)
   mov [edi+0x12], esi				; sw $12, 12($9)
   add edi, 16					; addi $9, $9, 16

next:
   add ecx, 1					; addi $8, $8, 1
   jmp loop					; j loop

post:
   mov esi, [ebx+0x20]				; lw $12, 20($11)
   mov edi, [esi]				; sw $12, 0($9)
   mov edx, dword [_vec2] 			; la $4, vec2
   ;mov esp, [eip]             			; jal gen(점프하기 전 스택포인터에 주소 저장?)???
   mov esp, [edi+0x4]				; jal gen(gen 두번째 명령어 $31에 저장)
   jmp gen                    	

   mov [result], eax				; sw $2, result
   jmp _start					; j main

tpl:
   mov edx, 0					; li $2, 0
   mov ebp, [eax]				; lw $13, 0($4)
   mov esi, 0					; li $12, 0
   imul esi, [ebp]				; mul $12, $12, $13
   add edx, esi 				; add $2, $2, $12
   jmp [esp]                  			; jr $31

gen:
   mov edx, 0					; li $2, 0           
   mov ebp, [eax]				; lw $13, 0($4)      
   mov esi, 22					; li $12, 22
   imul esi, ebp				; mul $12, $12, $13
   add edx, esi					; add $2, $2, $12
   mov ebp, [eax+0x8]				; lw $13, 8($4)
   mov esi, 25					; li $12, 25
   imul esi, ebp				; mul $12, $12, $13
   add edx, esi					; add $2, $2, $12
   jmp [esp]					; jr $31
```

<br>

### 코드설명

```assembly
_vec1 dw 22, 0, 25
_vec2 dw 7, 429, 6
```

벡터선언

<br>

```assembly
mov edx, dword [_vec1+0x2]
```

벡터를 레지스터에 저장

<br>

```assembly
mov esi, [edx] 				; lw $12, 0($11)
mov edx, [esi] 				; sw $12, 0($9) 
mov [edi], edx 				 
```

mov [edi], [edx] 불가능

edx에 tpl분기의 첫번째 명령어를 저장

gen첫번째 명령어에 tpl첫번째 명령어를 overwriting

<br>

```assembly
mov esi, [edx] 				; lw $12, 0($11)
```

esi에 gen 두번째 명령어 주소 저장

<br>

세그먼트오류

![image-20200529012203663](C:\Users\spide\AppData\Roaming\Typora\typora-user-images\image-20200529012203663.png)