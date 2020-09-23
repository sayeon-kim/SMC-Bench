# SMC 코드 9번

 #### encrypt.s: Code and speciﬁcation

```asm
main: la $8, pg
      la $9, pgend
      li $10, 0xffffffff
      
xor1: lw $11, 0($8)
      xor $11, $11, $10 # $11에 xor 한 값 저장
      sw $11, 0($8) # xor 결과값을 pg에 넣는다.
      addi $8, $8, 4
      blt $8, $9, xor1	# blt = branch on less than

decr: la $8, pg
      la $9, pgend
      la $10, 0xffffffff

xor2: lw $11, 0($8)
      xor $11, $11, $10
      sw $11, 0($8)
      addi $8, $8, 4
      blt $8, $9, xor2
      j pg
      

halt: j halt

pg:   li $2, 1
      li $3, 2
      add $2, $2, $3
      j halt
      
pgend:
```

### C Program 동작 확인
```shell
git clone https://github.com/JNU-SoftwareLAB/SMC-Bench.git	#Bench Project Clone
cd ./SMC-Bench/src/asm/smc9
gcc smc9.c -o result 		                			#gcc compile
./result

## foo함수가 정상적으로 작동하면 SMC 정상 작동
```


```asm
lw $11, 0($8)
```

이 명령어를 통해 pg의 포인터를 가져온다.

```asm
sw $11, 0($8)
```

을 통해  pg의 값(pg:   li $2, 1)이 변화되는것을 볼 수 있다.

![image-20200514124643169](C:\Users\SWlab\AppData\Roaming\Typora\typora-user-images\image-20200514124643169.png)

반복으로 한번 더하면 ( li $3, 2) 의 부분이 변화된다.

![image-20200514124804521](C:\Users\SWlab\AppData\Roaming\Typora\typora-user-images\image-20200514124804521.png)

이런식으로 나머지 pg 라벨에 있는 명령어들이  모두 변하게 된다.

 

```asm
blt $8, $9, xor1
```

blt = s, t, label 이면 branch if s<t 인 경우 label로 분기하라는 명령어이다.

이 명령어에 따라 xor1의 문을 반복하다가 false가 되면 빠져나온다.

```asm
xor2: 
	sw $11, 0($8)
```

에서, pg의 값에 다시 $11의  즉, pg의 값이 원상복귀된다.

![image-20200514125355730](C:\Users\SWlab\AppData\Roaming\Typora\typora-user-images\image-20200514125355730.png)

이렇게 또 blt가 false 값이 나올때 까지 반복하며, pg 라벨에 있떤 명령어들을 복귀 시킨다.

그리고 나머지 명령어들을 실행하고 종료한다.

