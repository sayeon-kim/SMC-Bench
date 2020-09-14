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

