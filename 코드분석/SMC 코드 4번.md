# SMC 코드 4번

#### Runtime Code Checking



```assembly
		.text
main:	jal f	 	#다음 실행할 명령어 주소(move $2, $8)를 $ra에 저장하고 f로 분기
        move $2, $8 
        j halt		
        
f:		li $8, 42
        lw $9, -4($31) #$31은 $ra와 같다. $ra에는 move $2 $8의 메모리주소가 있었는데 -4하면
        			   #jal f의 메모리 주소가 되고 lw이므로 jal f에 대한 기계 명령어이다.
        lw $10, addr   #$10은 addr의 명령어 주소에 대한 기계어를 저장한다. (jal f)
        bne $9, $10, halt
        jr $31

halt :	j halt

addr:	jal f
```



맨처음 main에서 jal f를 하면 $ra 레지스터에 move $2, $8에 해당하는 명령어 주소를 저장하고 f로 분기한다.

MIPS에서 $ra 레지스터는 $31레지스터와 같다.



f에서 $9에 $31 - 4 만큼의 명령어 주소에 대한 word를 가져오는데 $31은 아까 저장했던 $ra와 같은 레지스터고

명령어 주소는 32bit기때문에 4byte씩 떨어져있다.

아까 $ra에는 jal f를 하면서 move $2, $8의 명령어 주소를 넣어놨었고, 즉 lw $9, -4($31) 의 의미는 move $2, $8 전 명령어 주소에 해당하는 기계어에 해당된다. 즉 jal f에 대한 기계어 이다.

그럼 $9에 jal f에 대한 기계어 명령어 가들어가고,

$10에는 addr메모리 주소에 있는 기계어 명령이 들어가는데 addr에 또한 jal f가 있으므로,

둘다 같은 기계어 명령어 이므로 $9와 $10은 같은 값을 가지게 된다.

그러므로 bne $9, $10 halt를 했을때 halt가 되지않는다. 두 레지스터 값은 같기때문에

그래서 정상적으로 jr $31을 하게되면 move $2, $8의 명령어를 실행하게 되고 j halt를 하게된다.



$9와 $10이 다르면 halt한다.

```assembly
bne $9, $10, halt
```



내 생각에 이 코드는 Self modifing Code는 아닌것 같다. 

