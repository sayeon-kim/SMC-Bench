# SMC 코드 1번

Unbounded code rewriting

```assembly
	.data
num:	.byte 8
	.text
main:	
	lw $4, num # Set Argument
     	lw $9, key # $9 = Ec(add $2 $2 0)
     	li $8, 1   # counter
     	li $2, 1   # accumulator
      
loop:	
	beq $8, $4, halt  # check if done
     	addi $8, $8, 1    # inc counter
     	add $10, $9, $2   # new instr to put
      
key: 	
	addi $2, $2, 0
     	sw $10, key    	     # store new instr
     	j loop		     # next round
      
halt: 	
	j halt
```



Fibonacci를 계산하는 Self Modifing Code이다.

addi $2 $2 0  		=> 이게 한 word인데		기계어로 0x20420000 이다.

addi $2 $2 5		  => 이건 기계어로 0x20420005이다.	즉 맨뒤의 값이 immediate값이 된다.

```assembly
lw $9, key
```

여기서 key에 해당하는 포인터를 가져오고, 이값이 맨처음에는 0x20420000인데

$9에는 그럼 0x20420000이 저장되고 해당 주소에 $2를 더한다. $2는 누산기로써, Fibonacci를 계산하기 위한 레지스터이다.

그럼 기계어 명령은 점차적으로

0x20420000 -> 0x20420001 -> 0x20420001 -> 0x20420002 -> 0x20420003 -> 0x20420005 -> 0x20420008

이런식으로 진행된다. 맨뒤의 값이 피보나치 수열이 됨.

