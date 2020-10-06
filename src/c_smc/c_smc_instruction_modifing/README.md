# C로 작성한 SMC 코드 예제 

### C_SMC_Instruction_Modifing

###### 각 함수에 대한 설명

```c
change_page_permissions_of_address(void *address); //메모리 보호 수준에 대해 권한을 얻음. 내부적으로 mprotect syscall을 사용하여 해당 메모리에 대해 READ, WRITE, EXECUTE 권한을 전부 얻는다. (단 요청은 페이지 단위 1024Byte)

memcpy(void *dest, void *src, int size); // memcpy함수로 특정 메모리의 위치부터 size만큼의 메모리를 dest에 복사한다.
```


###### 실행 과정

1. num = 0을 가르키는 메모리의 주소와, num = 1을 가르키는 메모리의 주소를 변수에 저장한다.

2. main 함수가 존재하는 메모리에 대해 읽기, 쓰기, 실행권한을 얻는다.

3. num = 1의 명령어를 num = 0에 해당하는 메모리에 overwriting한다.

4. num을 print해본다.

```c

void *first_instruction = (void *)main + 61; //num = 0 을 가리킴
void *second_instruction = (void *)main + 90; //num = 1 을 가리킴

/*
 * num = 0을 가르키는 명령어와 num = 1을 가르키는 명령어의 주소를 각 포인터에 저장한다. (gdb 또는 objdump의 d옵션을 통해   코드영역의 메모리 확인가능)
*/

memcpy(first_instruction, second_instruction, 4);
/*
 * num = 0의 명령어를 num = 1이라는 명령어로 대체한다.
 * 그 후 printf를 하면 1이 출력된다.
*/

```
