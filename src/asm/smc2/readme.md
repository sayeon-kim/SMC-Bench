# SMC 코드 2번

#### Runtime Code Checking



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

맨처음 main에서 jal f를 하면 $ra 레지스터에 move $2, $8에 해당하는
명령어 주소를 저장하고 f로 분기한다.

MIPS에서 $ra 레지스터는 $31레지스터와 같다.


f에서 lw $9, -4(421) 명령어를 실행하면, $9에 $31 - 4 만큼의 명령어
 주소에 대한 word를 가져오는데 이 word는 jal f 명령어이다. 왜냐하면,
 $31은 f를 호출할 때 저장했던 $ra 레지스터이고, 각 MIPS 명령어의
 크기는 4바이트이기 때문이다.

또한 lw $10, addr 명령어를 실행하면, 해당 주소의 명령어, jal f를 가져온다.

bne $9, $10, halt로 $9와 $10에 각각 저장해놓은 명령어를 비교한다. 이
점이 Runtime code checking의 특징으로 원하는 호출자가 f를 호출하였는지
확인하는 한 가지 방법으로 활용할 수 있다.

이 경우 둘다 같은 기계어 명령어 jr $31을 통해 main으로 다시 리턴한다. 

만일 두 레지스터 값이 다르다면 halt로 바로 이동한다. 

