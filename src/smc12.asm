	.text
main: 
	la $8, pg
     	la $9, pgend
	li $10, 0xffffffff
      
xor1: 
	lw $11, 0($8)
      	xor $11, $11, $10 # $11�� xor �� �� ����
      	sw $11, 0($8) # xor ������� pg�� �ִ´�.
      	addi $8, $8, 4
      	blt $8, $9, xor1	# blt = branch1 on less than

decr: 
	la $8, pg
      	la $9, pgend
      	la $10, 0xffffffff

xor2: 
	lw $11, 0($8)
      	xor $11, $11, $10
      	sw $11, 0($8)
      	addi $8, $8, 4
      	blt $8, $9, xor2
     	j pg
      
halt: 
	j halt

pg:   
	li $2, 1
     	li $3, 2
     	add $2, $2, $3
     	j halt
      
pgend: