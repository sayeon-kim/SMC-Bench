	.text
main:
	la $8, loop
	la $9, new
	move $10, $9
	
loop:
	lw $11, 0($8)
	sw $11, 0($9)
	addi $8, $8, 4 #8번 레지스터에서는 loop에 대한 주소가 들어있다.
	addi $9, $9, 4 #9번 레지스터에는 loop에 대한 명령어가 들어있다.
	bne $8, $10, loop
	move $10, $9
new:
	lw $11, 0($8)
	sw $11, 0($9)
	addi $8, $8, 4 #8번 레지스터에서는 loop에 대한 주소가 들어있다.