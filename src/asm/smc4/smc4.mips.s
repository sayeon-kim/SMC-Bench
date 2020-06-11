	.text
main:	jal f	 	#다음 실행할 명령어 주소(move $2, $8)를 $ra에 저장하고 f로 분기
	move $2, $8
	j halt
	
f:	li $8, 42
	lw $9, -4($31)
	lw $10, addr
	bne $9, $10, halt
	jr $31

halt :	j halt

addr:	jal f