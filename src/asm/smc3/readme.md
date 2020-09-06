# SMC 코드 3번

#### Runtime Code Generation

```assembly
	.data                  # Data declaration section
vec1:   .word 22, 0, 25
vec2:   .word 7, 429, 6
result: .word 0
        
    	.text                  # Code section
main:   
	li $4, 3           
        li $8, 0           
        la $9, gen         
        la $11, tpl        
        lw $12, 0($11)	   
        sw $12, 0($9)      
        addi $9, $9, 4     

loop:   
	beq $8, $4, post   
        li $13, 4	   
        mul $13, $13, $8   
        lw $10, vec1($13)  
        beqz $10, next     
        lw $12, 4($11)	   
        add $12, $12, $13  
        sw $12, 0($9)	   
        lw $12, 8($11)     
        add $12, $12, $10  
        sw $12, 4($9)	   
        lw $12, 12($11)	   
        sw $12, 8($9) 	   
        lw $12, 16($11)	   
        sw $12, 12($9)	   
        addi $9, $9, 16    

next:   
	addi $8, $8, 1
        j loop

post:   
	lw $12, 20($11)
        sw $12, 0($9)
        la $4, vec2
        jal gen

        sw $2, result
        j main

tpl:    
	li $2, 0
        lw $13, 0($4)
        li $12, 0
        mul $12, $12, $13
        add $2, $2, $12
        jr $31	

gen:	
	li $2, 0           # int gen(int *v)
	lw $13, 0($4)      # {
	li $12, 22         # int res = 0;
	mul $12, $12, $13  # res += 22 * v[0];
	add $2, $2, $12    # res += 25 * v[2];
	lw $13, 8($4)      # return res;
	li $12, 25         # }
	mul $12, $12, $13
	add $2, $2, $12
	jr $31
```

