	.data
num:	.byte 8
	.text
main:	lw $4, num # Set Argument
     	lw $9, key # $9 = Ec(add $2 $2 0)
     	li $8, 1   # counter
     	li $2, 1   # accumulator
      
loop:	beq $8, $4, halt  # check if done
     	addi $8, $8, 1    # inc counter
     	add $10, $9, $2   # new instr to put
key: 	addi $2, $2, 0
     	sw $10, key    	     # store new instr
     	j loop		     # next round

halt: j halt