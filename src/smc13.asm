	.text
main: 
	la $8, g
      	lw $9, 0($8)
      	addi $10, $9, 4
      	sw $10, g
      	lw $11, h	# $11에 h의 포인터를 기억해 둔다. 나중에 다시 원상 복귀하려고,
     
g:    
	sw $9, 0($8)

h:   
	j dead
      	sw $11, h
      	j main
      
dead: 