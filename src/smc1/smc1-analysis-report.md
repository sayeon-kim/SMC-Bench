# SMC 코드 1번

#### The opcode modification

#### MIPS 코드

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

위의 코드에서 변형되는 코드는 target이다.

target은 move $2, $4 라는 명령어를 가진 코드인데, 해당 명령어를 new(addi $2, $2, 1)로 overwriting 한다.
