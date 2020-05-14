# SMC 코드 1번

#### The opcode modification

#### MIPS 코드

```assembly
	.text
main:	beq $2, $4, modify

target: move $2, $4
halt:	j halt

modify: lw $9, new
		sw $9, target
		j target

new:	 addi $2, $2, 1
```

위의 코드에서 변형되는 코드는 target이다.

target은 move $2, $4 라는 명령어를 가진 코드인데, 해당 명령어를 new(addi $2, $2, 1) 로 뒤집어 씌운다.



#### 실행 결과

![변경전](C:\Users\User\Desktop\변경전.png)

여기위에서 0x00400004에 해당하는 주소에는 addu $2, $0, $4가 존재하는데(이게 아마 move함수를 의미하는것 같다.) 위의 주소에 addi에 해당하는 명령어 코드를 집어넣는다.

![image-20200510225936032](C:\Users\User\AppData\Roaming\Typora\typora-user-images\image-20200510225936032.png)

그 결과 0x00400004에 해당하는 주소에 addu $2, $0, $4가 사라지고 addi $2, $2, 0x000000001이 생겼다.