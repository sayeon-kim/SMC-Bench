# SMC 코드 7번

#### Self Growing Code

```assembly
	.text
main:
	la $8, loop
	la $9, new
	move $10, $9
	
loop:
	lw $11, 0($8)
	sw $11, 0($9)
	addi $8, $8, 4 #8번 레지스터에서는 loop에 대한 주소가 들어있다.
	addi $9, $9, 4 #9번 레지스터에는 loop에 대한 명령어가 들어있다.
	bne $8, $10, loop
	move $10, $9
new:
```

### C Program 동작 확인
```shell
git clone https://github.com/JNU-SoftwareLAB/SMC-Bench.git	#Bench Project Clone
cd ./SMC-Bench/src/asm/smc7
gcc smc7.c -o result 		                				#gcc compile
./result

## Self growing code는 특성상 프로그램의 크기가 계속 커지게 되므로 보호되는 메모리 구역을 침범하게 된다. SegFault가 발생하지만 gdb로 확인시 SMC동작이 제대로 되는것을 확인할 수 있다.
gdb ./result
b *main+108
disass main,+200 											#Self-Growing Code 동작 확인 가능 ( get_permission 함수 메모리 구역 내에 main과 똑같은 Binary코드 발견)
```



```assembly
lw $11, 0($8)
```

이 명령어를 통해서 loop의 명령어를 가져오고



```assembly
sw $11, 0($9)
```

이 명령어를 통해서 new에 loop의 명령어를 저장한다.



즉 $8에는 loop의 코드에서 어디를 복사할것인지 $9에는 어디에 저장할것인지에 대한 레지스터다.

$8이 한칸씩 증가하면서 new에 도달하게되면 

```assembly
move $10, $9
```

해당 명령어를 실행해서 $10에 새로운 기준을 담아주게 된다. 그리고 아까 만들었던 new라는 코드를 실행하고 이게 new가 또 new를 만들고 이러한 과정이 계속 반복된다.

