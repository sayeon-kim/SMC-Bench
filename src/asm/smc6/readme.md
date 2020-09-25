# smc 코드 6번

#### Mutual-modifying Modules - Mutual modification

```asm
	.text
main:  j alter
	sw $8, alter
alter: lw $8, main
       li $9, 0
       sw $9, main
       j main

```

Step 1.
- Jump Alter

Step 2.

- Load value of main into $8
- $8 = 'j alter'

Step 3.

- Load value 0 into $9

Step 4.

- Store value of $9 into main

- So ' j alter ' -> 'nop'

Step 5.

- Jump main

Step 6.

- NOP. then execute next instruction(Step 7)

Step 7.

- Store value of $8 into alter

- So The result like this.

```asm
	.text
main:  
	nop
	sw $8, alter
alter: 
	jp alter
	li $9, 0
	sw $9, main
	j main
```

Step 8.

- JMP TO SELF.

- INFINITY LOOP.


### C Program 동작 확인
```shell
git clone https://github.com/JNU-SoftwareLAB/SMC-Bench.git	#Bench Project Clone
cd ./SMC-Bench/src/asm/smc6
gcc smc6.c -o result 		                				      #gcc compile
./result

## 무한루프시 SMC 정상 작동
```


실행 과정

```
  $8 <- "j alter"
  $9 <- 0       // MIPS에서 nop 명령어

  alter := "j alter"
```
위 실행 후 alter에서 무한 루프를 수행한다.


