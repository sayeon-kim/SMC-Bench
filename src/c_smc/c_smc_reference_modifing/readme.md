# C로 작성한 SMC 코드 예제 

### C_SMC_Reference_Modifing

###### 각 함수에 대한 설명

```c
change_page_permissions_of_address(void *address); //메모리 보호 수준에 대해 권한을 얻음. 내부적으로 mprotect syscall을 사용하여 해당 메모리에 대해 READ, WRITE, EXECUTE 권한을 전부 얻는다. (단 요청은 페이지 단위 1024Byte)

foo() //Code를 Modifing하기 위해 작성한 함수. STDOUT에 String을 출력한다.

modify(void *foo_addr) // 메모리 영역을 인자로 받아서 change_page_permission함수롤 호출하고 인자로 받은 메모리 영역을 변형한다.

```


###### 실행 과정

1. foo함수의 메모리 주소를 변수에 저장한다.

2. 변형하기전 foo()함수 호출

3. modify(foo_addr)로 foo함수의 메모리 주소를 인자로 넘기고 foo함수를 변형한다.

4. foo함수 내부에서 전역변수의 메모리 주소를 변형하고, 출력한다.

5. 변형후 foo() 함수 호출



```c
char* exit_string = "EXIT\n";
char* smc_string = "SMC\n";
char* err_string = "Error while changing page permissions of foo()\n";

/*
 * 위의 3변수는 전역변수로써 메모리 영역이 서로 붙어있다. 포인터의 크기는 8Byte이므로 8Byte 간격으로 포인터 전역변수가 존재한다.
*/

void modify(void * foo_addr){
    ......
    unsigned char* instruction = (unsigned char*)foo_addr + 11;
    *instruction += 8;
}

/*
 * foo_addr + 11은 exit_string의 메모리 주소이다. 해당 메모리 주소에 8을 더해 exit_string의 다음 전역변수인 smc_string을 가르키게 한다.
*/

```


