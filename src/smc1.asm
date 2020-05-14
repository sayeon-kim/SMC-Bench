	.text
main:	beq $2, $4, modify

target: move $2, $4
halt:	j halt

modify: lw $9, new
	sw $9, target
	j target

new:	 addi $2, $2, 1
