# SMC 코드 2번

#### Runtime Code Checking



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

### C Program 동작 확인

```shell
git clone https://github.com/JNU-SoftwareLAB/SMC-Bench.git	#Bench Project Clone
cd ./SMC-Bench/src/asm/smc2
gcc smc2.c -o result 						#gcc compile
./result						        #execute

## Working? 42 => Code Checking 결과 일치하지 않기때문에 Halt 함수 호출 
## Working? 0 => Code Checking 결과 이상 없음. 정상 종료

```

