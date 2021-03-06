# SMC 5번

#### Self-mutating Code Block

```assembly
	.text
main:
	la $8, g	# g의 주소
	lw $9, 0($8)	# 9번레지스터에 g의 명령어 저장
	addi $10, $9, 4	# $10번 레지스터에 g의 명령어 + 4를 저장한다. (sw $9, 4($8))
	sw $10, g	# g의 명령어를 sw $9 4($8)로 바꿈
	lw $11, h	# h명령어(j dead)를 11번 레지스터에 저장함.
	
g:	
	sw $9, 0($8)

h:	
	j dead		# 실제로는 j dead가 수행되지않고, sw $9, 4($8)이 수행됨.
	sw $11, h	# h명령어를 다시 복구시킴.
	j main		# 이과정 계속 반복. 이 코드는 중간에 j dead가 있어서 dead가 실행될것 처럼 보이지만 절				   # 대 실행되지않고 프로그램은 무한루프가 돌게됨.
	
dead:
	j dead
```

$8 레지스터에 g의 주소를 저장하고, $9 레지스터에, g의 명령어를 저장한다.
addi $10, $9, 4는 $10 레지스터에 sw $9, 4($8) 을 저장하는것과 같은 의미다.
g에서 해당 명령어를 실행하면 g의 다음주소인 h의 j dead가 $9에 저장된 명령어로 바뀌게 된다.

### C Program 동작 확인
```shell
git clone https://github.com/JNU-SoftwareLAB/SMC-Bench.git	#Bench Project Clone
cd ./SMC-Bench/src/asm/smc5
gcc smc5.c -o result 		                				      #gcc compile
./result

## Number Value : 1 이 무한루프로 출력된다면 SMC 정상작동
```


실행 과정

```
main:
   $8  <- g
   $9  <- "sw $9, 0($8)"
   $10 <- "sw $9, 4($8)"

   g = sw $9, 4($8)     // 원래 코드 g: sw $9, 0($8)

   $11 <- "j dead"

g:
 
   h = sw $9, 0($8)     // 원래 코드 h: j dead 

h:
   g = sw $9, 0($8)     // 원래 코드 g: sw $9, 4($8)

   h = j dead           // 원래 코드 h: sw $9, 0($8)

   j main
```


C 프로그램을 작성할 때 고려할 사항

- ptr_g와 ptr_h를 지역변수로 선언하지 않고 전역변수로 선언한 이유는 명령어 수정이 용이하기 때문이다.

```
   unsigned char* ptr_g;
   unsigned char* ptr_h;
```

ptr_g를 전역변수로 선언할 때 0x20085a(%rip)로 참조하고, ptr_h는 (0x20085a + 8(%rip)을 참조하면 된다.
```
 7bf:	48 89 05 5a 08 20 00 	mov    %rax,0x20085a(%rip)        # 201020 <ptr_g>
```

그런데 ptr_g를 지역변수로 선언하면 -0xd8(%rbp)로 참조하는데, ptr_h를 참조할 수 있는 방법이 상대적으로 어렵다.
```
 8ca:	c7 85 28 ff ff ff 00 	movl   $0x0,-0xd8(%rbp)
```

이런 이유로 전역변수를 사용하였다.
