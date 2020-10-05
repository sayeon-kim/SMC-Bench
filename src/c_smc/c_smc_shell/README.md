# C로 작성한 SMC 코드 예제 

### C_SMC_SHELL

###### 각 함수에 대한 설명

```c
change_page_permissions_of_address(void *address); //메모리 보호 수준에 대해 권한을 얻음. 내부적으로 mprotect syscall을 사용하여 해당 메모리에 대해 READ, WRITE, EXECUTE 권한을 전부 얻는다. (단 요청은 페이지 단위 1024Byte)

foo() //Code를 Modifing하기 위해 작성한 함수. STDOUT에 String을 출력한다.

puts(const char* str) // STDOUT에 문자열을 출력한다.

modify(void *foo_addr) //  memcpy함수로 특정 메모리의 위치부터 size만큼의 메모리를 dest에 복사한다.

char shellcode[] =
	"\x48\x31\xd2"							   // xor    %rdx, %rdx
	"\x48\x31\xc0"							   // xor    %rax, %rax
	"\x48\xbb\x2f\x62\x69\x6e\x2f\x73\x68\x00" // mov    $0x68732f6e69622f2f, %rbx
	"\x53"									   // push   %rbx
	"\x48\x89\xe7"							   // mov    %rsp, %rdi
	"\x50"									   // push   %rax
	"\x57"									   // push   %rdi
	"\x48\x89\xe6"							   // mov    %rsp, %rsi
	"\xb0\x3b"								   // mov    $0x3b, %al
	"\x0f\x05";								   // syscall

//위의 코드는 쉘을 실행시키는 머신코드이다.
```


###### 실행 과정

1. foo함수의 메모리 주소를 변수에 저장한다.

2. 변형하기전 foo함수를 실행해보고, foo함수에 대해 메모리 (Write, READ, EXECUTE)권한을 얻는다.

3. memcpy로 아까 Shellcode를 foo에 복사한다.

4. 변형 후 foo함수를 실행한다.


```c
char shellcode[] =
    "\x48\x31\xd2"							   // xor    %rdx, %rdx
	"\x48\x31\xc0"							   // xor    %rax, %rax
	"\x48\xbb\x2f\x62\x69\x6e\x2f\x73\x68\x00" // mov    $0x68732f6e69622f2f, %rbx
	"\x53"									   // push   %rbx
	"\x48\x89\xe7"							   // mov    %rsp, %rdi
	"\x50"									   // push   %rax
	"\x57"									   // push   %rdi
	"\x48\x89\xe6"							   // mov    %rsp, %rsi
	"\xb0\x3b"								   // mov    $0x3b, %al
	"\x0f\x05";								   // syscall

/*
 * 쉘을 실행시키는 머신코드로 해당 코드를 foo에 복사하고, 그 이후 foo를 실행하면 쉘이 실행된다.
*/

/*
 * memcpy(foo_addr, shellcode, sizeof(shellcode) - 1);
 * foo_addr에 shellcode를 복사한다. 사이즈에서 -1을 하는 이유는 null문자를 제거하기 위함이다.
*/

```


