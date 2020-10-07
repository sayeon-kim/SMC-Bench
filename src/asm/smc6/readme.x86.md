
```asm
section .text
global _start

_start:
    jmp alter
    mov [alter], ax         ; [alter](mov ax, [_start]) <- load instruction [ax] (jmp alter)
	
    
alter:
    mov ax, [_start]        ; ax <- load instruction [_start] (jmp alter)
    mov bl, 0x90            ; bl <- load instruction [0x90] (nop)
    mov [_start], bl        
    mov [_start+1], bl      ; instruction [_start] (jmp alter) is changed (nop)
    mov [re_start], bl    
    mov [re_start+1], bl    ; instuction [re_start] (jmp halt) is changed (nop)

re_start:
    jmp halt                ; jmp halt가 실행될것 같지만 alter분기에서 nop으로 변경되어 실행되지 않는다.
    jmp _start              

halt:
    nop

-------------------------------------------------------------------------
smc가 적용된 code 

_start:
    nop
    mov [alter], ax         ; [alter](mov ax, [_start]) <- load instruction [ax] (jmp alter)
	
    
alter:
    mov ax, [_start]        ; ax <- load instruction [_start] (jmp alter)
    mov bl, 0x90            ; bl <- load instruction [0x90] (nop)
    mov [_start], bl        
    mov [_start+1], bl      ; instruction [_start] (jmp alter) is changed (nop)
    mov [re_start], bl    
    mov [re_start+1], bl    ; instuction [re_start] (jmp halt) is changed (nop)

re_start:
    nop                ; jmp halt가 실행될것 같지만 alter분기에서 nop으로 변경되어 실행되지 않는다.
    jmp _start              

halt:
    nop

```

요약하자면, 

re_start 분기를 추가로 만들어서 

프로그램이 jmp halt로 인해 

halt분기로 이동하여 

무한루프를 돌지 않고 

종료될 것으로 여기도록 하였습니다. 

하지만 jmp halt부분도 alter분기에서 

nop명령어로 변경하였기에 

밑에있던 jmp _start를 통해 원래 코드처럼 _start분기로 돌아가게 됩니다.




step 1. 

    Jump alter

step 2.

    ax <- load instruction [_start] (jmp alter)

step 3. 

    bl <- load instruction [0x90] (nop)

step 4.

    ;instruction [_start] (jmp alter) is changed (nop)

step 5.

    instuction [re_start] (jmp halt) is changed (nop)

step 6.

    [re_start] (jmp halt) value is changed (nop)

    so skip this instruction(jmp halt)

step 7.

    jmp _start

step 8.

    (jmp alter) is changed (nop)

    so skip this instrucntion

step 9.

    ( mov ax, [_start] ) is changed (jmp alter) 

step 10.

    alter:

    jmp alter

    so, This part is repeated.