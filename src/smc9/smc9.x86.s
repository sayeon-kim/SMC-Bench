section .data
section .text

global _start

_start:
    mov eax, loop ; eax <- addr of loop
    mov ebx, new
    mov ecx, new   
    mov esi, 2
loop:
    mov edx, [eax] ; edx <- instruction of loop, but not worked
    mov [ebx], edx ; [ebx] <- store instruction of loop in pointer of ebx
    add eax, esi ; eax += 2, instruction length is 2byte
    add ebx, esi ; ebx += 2
    cmp eax, ecx ; comparison about eax and ebx
    jne loop ; if not equal, than jump to the loop.
    mov ecx, ebx ; if equal, all code is copied in new label, but not worked
new:
  
  ;�ڵ���� ����Ǳ�� �ϳ�, ��� ����Ǵٺ��ϱ� segmentation fault�� �߻��մϴ�.