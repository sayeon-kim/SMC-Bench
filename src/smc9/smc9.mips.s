	.text
main:
	la $8, loop
	la $9, new
	move $10, $9
	
loop:
	lw $11, 0($8)
	sw $11, 0($9)
	addi $8, $8, 4 #8�� �������Ϳ����� loop�� ���� �ּҰ� ����ִ�.
	addi $9, $9, 4 #9�� �������Ϳ��� loop�� ���� ���ɾ ����ִ�.
	bne $8, $10, loop
	move $10, $9
new: