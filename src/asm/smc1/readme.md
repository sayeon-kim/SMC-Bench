# SMC 코드 1번

### Unbounded Code Rewriting

```assembly
	.data
num:	.byte 8
	.text
main:	
	lw $4, num # Set Argument
     	lw $9, key # $9 = Ec(add $2 $2 0)
     	li $8, 1   # counter
     	li $2, 1   # accumulator
      
loop:	
	beq $8, $4, halt  # check if done
     	addi $8, $8, 1    # inc counter
     	add $10, $9, $2   # new instr to put
      
key: 	
	addi $2, $2, 0
     	sw $10, key    	     # store new instr
     	j loop		     # next round
      
halt: 	
	j halt
```



### 실행 과정

```
key:  addi $2 $2 0

      $4 <- 8
      $9 <- "addi $2 $2 0"
      $8 <- 1
      $2 <- 1      // fib 1 = 1

loop: 
      $8  <- 2
      $10 <- "addi $2 $2 1"
key:
      $2  <- 1     // fib 2 = 1

      key :=  addi $2 $2 1


loop: 
      $8  <- 3
      $10 <- "addi $2 $2 1"
key:
      $2  <- 2     // fib 3 = 2

      key :=  addi $2 $2 1


loop: 
      $8  <- 4
      $10 <- "addi $2 $2 2"
key:
      $2  <- 3     // fib 4 = 3

     key :=  addi $2 $2 2


loop: 
      $8  <- 5
      $10 <- "addi $2 $2 3"
key:
      $2  <- 5     // fib 5 = 5

     key :=  addi $2 $2 3


loop: 
      $8  <- 6
      $10 <- "addi $2 $2 5"
key:
      $2  <- 8     // fib 6 = 8

      key := addi $2 $2 5


loop: 
      $8  <- 7
      $10 <- "addi $2 $2 8"
key:
      $2  <- 13     // fib 7 = 13

      key := addi $2 $2 8


loop: 
      $8  <- 8
      $10 <- "addi $2 $2 13"
key:
      $2  <- 21     // fib 8 = 21

      key := addi $2 $2 13


halt: j halt

```



### C Program 동작 확인

```shell
git clone https://github.com/JNU-SoftwareLAB/SMC-Bench.git	#Bench Project Clone
cd ./SMC-Bench/src/asm/smc1
gcc smc1.c -o result 							#gcc compile
./result									#execute
															
# fib(8) = 34가 출력된다면 SMC 정상 작동
```