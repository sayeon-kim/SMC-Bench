	.text
main: 
	la $8, g
      	lw $9, 0($8)
      	addi $10, $9, 4
      	sw $10, g
      	lw $11, h	# $11�� h�� �����͸� ����� �д�. ���߿� �ٽ� ���� �����Ϸ���,
     
g:    
	sw $9, 0($8)

h:   
	j dead
      	sw $11, h
      	j main
      
dead: 