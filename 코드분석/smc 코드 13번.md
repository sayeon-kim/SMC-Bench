# smc 코드 13번

 **Code Obfuscation**

```asm
	.text

main: la $8, g
      lw $9, 0($8)
      addi $10, $9, 4
      sw $10, g
      lw $11, h	# $11에 h의 포인터를 기억해 둔다. 나중에 다시 원상 복귀하려고,
      
g:    sw $9, 0($8)

h:    j dead
      sw $11, h
      j main
      
dead: 
```



```asm
  addi $10, $9, 4
  sw $10, g
```

$10에 g에 4를 더한 값을 저장한다.

![image-20200514130333942](C:\Users\SWlab\AppData\Roaming\Typora\typora-user-images\image-20200514130333942.png)



```asm
g:    sw $9, 0($8)
```

이부분이 바뀌고 실행되면 아래와 같은 결과가 나오는데 이류를 모르겠다.

 ![image-20200514131007999](C:\Users\SWlab\AppData\Roaming\Typora\typora-user-images\image-20200514131007999.png)

```asm
g:    sw $9, 0($8)

h:    j dead
```

결국 이 두 명령어 부분이 잠시 사라졌다가 나타나면서 j dead 라는 분기 명령어가 실행되지 않고 

j main  명령어로 인해 프로그램이 무한루프를 돌게 된다.

```asm

```

