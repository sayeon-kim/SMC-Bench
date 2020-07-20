; $4 => (eax 그냥 3)
; $8 => (ecx 카운터)
; $9 => (edi 복사작업시 목적지 주소 gen을 가리킴)
; $10 => (esi 가져온 벡터의 값)
; $11 => (ebx tp의 주소)
; $12 => (edx 복사작업시 소스 주소)
; $13 => (ebp 벡터의 인덱스)

section .text
_vec1 dd 22, 0, 25
_vec2 dd 7, 429, 6
result dd 0

global _start

_start:
   mov eax, 3     
   mov ecx, 0     
   mov edi, gen   
   mov ebx, tpl   

   mov edx, [ebx]       ; edx <- tpl 1st instruction
   mov [edi], edx       ; gen 1st instruction <- tpl 1st instruction overwriting
   mov [edi+1], word 0  ; 00 00 
   mov [edi+3], word 0 

   add edi, 5           ; edi <- 2nd instruction

loop:
   cmp eax, ecx         ; loop cycle count 3
   je post
   mov ebp, 4
   imul ebp, ecx        ; vec index           

   mov esi, dword [_vec1+ebp]  
   cmp esi, 0           ; if vec's value 0 -> jmp next //vec1 2nd value
   je next

   mov dx, [ebx+5]      ; gen 2nd instruction <- tpl 2nd instruction overwriting
   mov [edi], dx
   mov edx, ebp         
   mov [edi+2], dl      

   mov dx, [ebx+8]      ; gen 3rd instruction <- tpl 3rd instruction overwriting       
   mov [edi+3], dx             

   mov dl, [ebx+10]     ; gen 4th instruction <- tpl 4th instruction overwriting
   mov [edi+5], dl       
   mov edx, esi
   mov [edi+6], dl       
   mov [edi+7], byte 0
   mov [edi+8], word 0      

   mov edx, [ebx+15]    ; gen 5th instruction <- tpl 5th instruction overwriting
   mov [edi+10], edx     

   mov dx, [ebx+19]     ; gen 6th instruction <- tpl 6th instruction overwriting
   mov [edi+14], dx

   add edi, 16

next:
   add ecx, 1
   jmp loop

post:
   mov dx, [ebx+21]     ; gen 7th instruction <- tpl 7th instruction overwriting         
   mov [edi], dx 
   
   mov esi, _vec2      
   mov esp, post        
   add esp, 21          ; esp <- post 7th instruction (mov [result], eax)
   jmp gen                       

   mov [result], eax    

   mov eax, 1           ; exit
   xor ebx, ebx
   int 0x80
  
tpl:
   mov eax, 0
   add esi, 0
   mov ebp, [esi]
   mov edx, 0

   imul edx, ebp   
   nop
   add eax, edx
   jmp esp              ; jmp post
   nop

gen:
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   
   ; tpl 명령어에 vec1, vec2의 원소를 부여하면서 비어있는 gen 분기에 writing
   ; loop문 3번 반복될 때까지 작업 수행
   ; vec1, vec2의 첫번째 원소끼리 세번째 원소끼리 곱하고 둘을 더해서 result 값에 입력 후 종료
