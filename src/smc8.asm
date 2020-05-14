	.text
main: 
	j alter
	sw $8, alter
	
alter: 
	lw $8, main
       	li $9, 0
       	sw $9, main
       	j main