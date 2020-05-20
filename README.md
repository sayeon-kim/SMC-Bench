# SMC Bench

### : A Benchmark for Self - Modifying Code



#### MIPS Code



##### The Opcode modification

```assembly
	.text
main:
	beq $2, $4, modify

target: 
	move $2, $4
halt:	
	j halt

modify: 
	lw $9, new
	sw $9, target
	j target

new:	
	addi $2, $2, 1

```



##### Control flow **modification**

```assembly
	.text
	j main	
halt:	
	j halt

main:	
	la $9, end  
	lw $8, 0($9)
    	addi $8, $8, -1
    	addi $8, $8, -2
    	sw $8, 0($9)
end:
	j dead
	
dead:

```



##### Unbounded code rewriting

```assembly
	.data
num:	
	.byte 8
	
	.text
main:	
	lw $4, num 
 	lw $9, key 
   	li $8, 1   
   	li $2, 1   
      
loop:
	beq $8, $4, halt  
    	addi $8, $8, 1    
    	add $10, $9, $2   
      
key:
	addi $2, $2, 0
    	sw $10, key    	 
    	j loop		     
      
halt: 
	j halt
```



**Runtime Code Generation**

```assembly
	.data              
vec1:   
	.word 22, 0, 25
vec2:   
	.word 7, 429, 6
result: 
	.word 0
        
    	.text              
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

#Generated code of vector dot product
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



##### Runtime Code Checking

```assembly
	.text
main:	
	jal f	 	
   	move $2, $8 
    	j halt		
        
f:	
	li $8, 42
    	lw $9, -4($31) 
    	lw $10, addr   
    	bne $9, $10, halt
    	jr $31

halt :
	j halt

addr:	
	jal f
```



##### Multilevel Runtime Code Generation

```assembly
	.text
main: 
	la $9, gen        # get the target addr
    	li $8, 0xac880000 # load Ec(sw $8,0($4))
    	sw $8, 0($9)      # store to gen
    	li $8, 0x00800008 # load Ec(jr $4)
    	sw $8, 4($9)      # store to gen+4
    	la $4, ggen       # $4 = ggen
    	la $9, main       # $9 = main
    	li $8, 0x01200008 # load Ec(jr $9) to $8
    	j gen             # jump to target
      
gen: 
	nop               # to be generated
    	nop               # to be generated
      
ggen: 
	nop               # to be generated
```



**Self-mutating code block**

```assembly
	.text
main:
	la $8, g
	lw $9, 0($8)	
	addi $10, $9, 4	
	sw $10, g	
	lw $11, h	
	
g:	
	sw $9, 0($8)

h:	
	j dead		
	sw $11, h	
	j main		
	
dead:
	j dead
```



##### Mutual Modifying Modules

```assembly
	.text
main:
	j alter
	sw $8, alter
alter: 
	lw $8, main
    	li $9, 0
    	sw $9, main
    	j main
```



##### Self Modifying Code

```assembly
	.text
main:
	la $8, loop
	la $9, new
	move $10, $9
	
loop:
	lw $11, 0($8)
	sw $11, 0($9)
	addi $8, $8, 4 
	addi $9, $9, 4 
	bne $8, $10, loop
	move $10, $9
new:
```



**Speciﬁcation - Mutual Modiﬁcation**

```assembly
main: 
	la $10, body

body:
	lw $8, 12($10)		
    	lw $9, 16($10)
    	sw $9, 12($10)                     
    	addi $2,$2, 21       
    	addi $2,$2, 21   
    	sw $8, 16($10)        
    	lw $9, 8($10)        
    	lw $8, 20($10)        
    	sw $9, 20($10)        
    	sw $8, 8($10)         
    	j body             
```



 **encrypt.s: Code and speciﬁcation**

```assembly
main: 
	la $8, pg
    	la $9, pgend
    	li $10, 0xffffffff
      
xor1:
	lw $11, 0($8)
    	xor $11, $11, $10 # $11에 xor 한 값 저장
    	sw $11, 0($8) # xor 결과값을 pg에 넣는다.
    	addi $8, $8, 4
    	blt $8, $9, xor1	# blt = branch on less than

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
```

