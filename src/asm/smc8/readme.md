# SMC 코드 8번

#### Polymorphic Code - Mutual Modiﬁcation

```asm
main: la $10, body	#load $10에  body주소 즉, 0x20420003이 들어간다

body: lw $8, 12($10) 	# $10에 12가 더해진 즉, 3줄 다음인 (addi $2,$2, 21) 								0x20420015가 $8에 load
      lw $9, 16($10)   	# $10에 16가 더해진 즉, 4줄 다음인  두번째(addi $2,$2, 21) 							0x20420015가 $9에 load
      sw $9, 12($10)                     
      addi $2,$2, 21       
      addi $2,$2, 21   
      sw $8, 16($10)        
      lw $9, 8($10)        
      lw $8, 20($10)        
      sw $9, 20($10)        
      sw $8, 8($10)         
      j body  
                   

```





전체적으로 이 코드는 $8과 $9에 서로 포인터를 저장해서 덮어 씌운후 다시 body 문을 돌면서 원래대로 보여지는 코드이다.

$9에는 body+2번째 줄을, $8에는 body + 5번째 줄을  load 한후

바꿔서 sw 한 후에 반복하는 과정에 다시 바뀌어 원래 자리애 sw 된다.



#### SMC8_Mutual_Modification Written As C 동작 확인 방법

해당 코드는 GCC Compiler에서 작동하도록 작성되었습니다.

해당 코드를 컴파일 한 뒤,  gdb 디버거로 Self-Modifing 동작을 확인할 수 있습니다.

1. body 부분에 break를 걸기 (break *main+62)
2. c (continue)명령과 disass main으로 코드의 동작을 확인합니다.
3. gdb상에서 main + 279의 이전에 해당하는 명령어가 계속 바뀌는 것을 확인할 수 있습니다. (mov -> add -> mov -> add)




