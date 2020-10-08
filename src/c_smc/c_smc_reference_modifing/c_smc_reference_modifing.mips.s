	.data
exit_string:	.asciiz "\n Exit Program.\n"
smc_string:		.asciiz "\n This code is modified\n"
	.text
main:	
	j modify
modify: 
	lw $t1, new ;1 $t1 <- new (j halt)
	sw $t1, target ;2 $t1(j halt) -> target
	j target ;3 j target
new:	
	j halt
halt:	
	li	$v0, 4 ;5 $v0 <- 4, for syscall.
	la	$a0, smc_string ;6 $a0 <- smc_string, argument1(string ptr)
	syscall ;7 print
	li	$v0, 32 ;8 $v0 <- 32, for syscall.
	li $a0, 1000 #9 $a0 <- 1000, argument1(sleep time)
	syscall #10 sleep 1 second.
	j halt #11 jmp halt
target: 
	nop #4 j halt
exit:
	li $v0, 4 # never execute.
	la $a0, exit_string # never execute.
	syscall # never execute.
	li $v0, 10 # never execute.
	syscall # never execute.