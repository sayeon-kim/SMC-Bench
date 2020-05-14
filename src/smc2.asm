	.text
	j main	
halt:	j halt

main:	la $9, end
	lw $8, 0($9)
	addi $8, $8, -1
	addi $8, $8, -2
	sw $8, 0($9)
end:	j dead

dead:	
	