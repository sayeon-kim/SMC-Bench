# smc 코드 8번

**Mutual-modifying Modules - mutual modification**

```asm
	.text
main:  j alter
	sw $8, alter
alter: lw $8, main
       li $9, 0
       sw $9, main
       j main

```



먼저 alter로 분기한다.

$8에 main 의 포인터를 load 한다. 그리고 $9에 0을 immediate load한다.

$9의 값을 main에 store 한다.

이때 main 부분의 code 값이 바뀐것을 볼 수 있다.

다시 main으로 분기한다. 

```asm
main:  j alter
	sw $8, alter
```

이때, 이미 main의 첫번째 부분이  ( j alter)가 아닌 아무 문장이 없으므로, 아까 j분기로 건너뛰게 되었던, ( sw $8, alter ) 문장이 실행된다.

 ( sw $8, alter ) 문장이 실행된 결과로 이렇게 바뀌게 된다.  그리고 프로그램이 끝나게 된다.


