; $4 => (eax 그냥 3)
; $8 => (ecx 카운터)
; $9 => (edi 복사작업시 목적지 주소 gen을 가리킴)
; $10 => (esi 가져온 벡터의 값)
; $11 => (ebx tp의 주소)
; $12 => (edx 복사작업시 소스 주소)
; $13 => (ebp 벡터의 인덱스)

section .data
section .text
_vec1 dd 22, 0, 25
_vec2 dd 7, 429, 6
result dd 0

global _start

_start:
   mov eax, 3     ; $4
   mov ecx, 0     ; $8
   mov edi, gen   ; $9
   mov ebx, tpl   ; $11

   mov edx, [ebx] ; lw $12, 0($11)	
   mov [edi], edx ; sw $12, 0($9) ;★ 첫 번째 명령어 생성
   ;mov [edi+1], word 0
   ;mov [edi+3], word 0 

   ;mov esi, dword [_vec1-4]  ; 2byte씩 꺼내오기 위해 미리저장해놓음
   add edi, 5     ; mov명령이므로 5 뒤에 넣어줌

loop:
   cmp eax, ecx
   je post
   mov ebp, 4
   imul ebp, ecx 

   mov esi, dword [_vec1+ebp]  ; lw $10, vec1($13) 
   cmp esi, 0
   je next

   mov edx, [ebx+5]         ; edx <- tpl 두번째 명령어
   add edx, ebp             ; edx <- tpl 두번째 명령어 + ebp
   mov [edi], edx           ; gen 두번째 명령어 <- edx overwriting
  
   mov edx, [ebx+7]         ; edx <- tpl 세번째 명령어
   add edx, esi             ; edx <- tpl 세번째 명령어 + vec1 첫번째 원소(22)
   mov [edi+2], edx         ; gen 세번째 명령어 <- tpl 세번째 명령어 + vec1 첫번째 원소(22)
  
   mov edx, [ebx+12]        ; edx <- tpl 네번째 명령어
   mov [edi+7], edx         ; gen 네번째 명령어 <- tpl 네번째 명령어
   
   mov edx, [ebx+16]        ; edx <- tpl 다섯번째 명령어
   mov [edi+10], edx        ; gen 다섯번째 명령어 <- tpl 다섯번째 명령어

   add edi, 17              ; edi <- 

next:
   add ecx, 1
   jmp loop

post:
   mov edx, [ebx+18]				; lw $12, 20($11)
   mov [edi], edx				   ; sw $12, 0($9)
   mov esi, dword [_vec2] 			; la $4, vec2            						
   jmp gen                    	

   mov [result], esp				; sw $2, result
   jmp _start
  
tpl:
   mov esp, 0
   mov ebp, [eax]
   mov edx, 0
   imul edx, ebp
   add esp, edx
   jmp [esp]                  

gen:
   mov esp, 0					; li $2, 0           
   mov ebp, [eax]				; lw $13, 0($4)      
   mov edx, 22					; li $12, 22
   imul edx, ebp				; mul $12, $12, $13
   add esp, edx					; add $2, $2, $12
   mov ebp, [eax+8]				; lw $13, 8($4)
   mov edx, 25					; li $12, 25
   imul edx, ebp				; mul $12, $12, $13
   add esp, edx					; add $2, $2, $12
   jmp [esp]					; jr $31
