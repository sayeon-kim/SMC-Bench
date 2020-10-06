# C로 작성한 SMC 코드 예제 

### C_SMC_42

###### 각 함수에 대한 설명

```c
change_page_permissions_of_address(void *address); //메모리 보호 수준에 대해 권한을 얻음. 내부적으로 mprotect syscall을 사용하여 해당 메모리에 대해 READ, WRITE, EXECUTE 권한을 전부 얻는다. (단 요청은 페이지 단위 1024Byte)

foo() //Code를 Modifing하기 위해 작성한 함수.

```


###### 실행 과정

1. foo 함수가 존재하는 메모리에 대해 읽기, 쓰기, 실행권한을 얻는다.

2. 변형하기전 foo()함수 호출

3. foo 함수 변형

4. 변형 후 foo()함수 호출



```c
unsigned char *instruction = (unsigned char *)foo_addr + 18;
*instruction = 0x2A;

/*
 * 해당 부분은 foo함수의 i++ 명령어에서 특정 Byte의 위치에 대한 메모리 주소를 *instruction에 저장하는것이다.
 * 그 부분은 "addi reg, 1" 이라는 명령어에서 1을 가르키고 있으며 해당 부분을 "0x2A(42)" 로 변형한다.
*/
```


