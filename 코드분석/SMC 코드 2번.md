# SMC 2번

#### Control flow modification

la는 주소를 불러오는거고,

lw는 포인터를 불러오는거 같다. 

두개는 연산에서 차이를 보임. 포인터 - 1은 adress - 32bit와 같으니까 그런거 같다.

```assembly
	.text
		j main	
halt:	j halt

main:	la $9, end  ; Load address of .word 'end' into $9
        lw $8, 0($9); Load pointer from address in $9+0,
        			; this loads the pointer stored in 'end' which is the address of
        			; 'j dead'
        addi $8, $8, -1
        addi $8, $8, -2
        sw $8, 0($9)
end:	j dead

dead:


```



코드를 봤을때 드는 생각은 dead로 분기했을때 유효한 명령어가 없기때문에 프로그램이 비정상 종료될것이라는것을 알 수 있다.



```assembly
la $9, end
```

해당 코드에서 $9에 end의 메모리 주소를 저장한다.



```assembly
lw $8, 0($9)
```

end의 메모리주소는 0x00400020인데  여기서 0을 더한 명령어코드를 lw에 저장한다.

즉 j dead에 대한 명령어가 $8에 저장됨.  j dead명령어는 0x081000009인데

이 기계어를 분석해보면 맨뒤값이 명령어의 순서에 해당함.

즉 0x081000009는 10번째 명령어로 분기하라는 명령어이고, 여기서 3을뺀뒤보면 7번째 명령어로 분기하라는 명령어의 기계어 코드가 생김 (0x81000006) 6번째 명령어는  아래에서 보다시피 addi $8 $8 -2이고, 여기서 2를 또 빼므로 4번째 명령어로 가라고하는 (0x81000004)가 생기게 되고, 여기서 또 3을빼면 결국 프로그램의 종료 명령어인 j halt로 이동하게된다.

![image-20200511161904969](C:\Users\User\AppData\Roaming\Typora\typora-user-images\image-20200511161904969.png)


![image-20200511161927982](C:\Users\User\AppData\Roaming\Typora\typora-user-images\image-20200511161927982.png)

![image-20200511161941544](C:\Users\User\AppData\Roaming\Typora\typora-user-images\image-20200511161941544.png)

![image-20200511161956237](C:\Users\User\AppData\Roaming\Typora\typora-user-images\image-20200511161956237.png)