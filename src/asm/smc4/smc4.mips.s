	.text
main:	jal f	 	#���� ������ ��ɾ� �ּ�(move $2, $8)�� $ra�� �����ϰ� f�� �б�
	move $2, $8
	j halt
	
f:	li $8, 42
	lw $9, -4($31)
	lw $10, addr
	bne $9, $10, halt
	jr $31

halt :	j halt

addr:	jal f