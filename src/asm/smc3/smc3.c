#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <stdlib.h>
#include <errno.h>
#include <sys/mman.h>

int change_page_permissions_of_address(void *addr);
void get_permission(void *foo_addr);
char *err_string = "Error while changing page permissions of foo()\n";

int default1[3] = {0, 0, 0}; 
int default2[3] = {0, 0, 0};
//vec1, vec2 계산 명령어와 같은 양식의 default 명령어를 위한 vector

int vec1[3] = {22, 0, 25};
int vec2[3] = {7, 429, 6};

int main(void)
{
	void *origin1_instruction = (void *)main + 401; 
    void *origin2_instruction = (void *)main + 407; 
    void *origin3_instruction = (void *)main + 413; 
    void *origin4_instruction = (void *)main + 416; 
    void *origin5_instruction = (void *)main + 422; 
    void *origin6_instruction = (void *)main + 428; 
    void *origin7_instruction = (void *)main + 434; 
    void *origin8_instruction = (void *)main + 437; 
    void *modified1_instruction = (void *)main + 468; 
    void *modified2_instruction = (void *)main + 474; 
    void *modified3_instruction = (void *)main + 480; 
    void *modified4_instruction = (void *)main + 483; 
    void *modified5_instruction = (void *)main + 489; 
    void *modified6_instruction = (void *)main + 495; 
    void *modified7_instruction = (void *)main + 501; 
    void *modified8_instruction = (void *)main + 504; 

	get_permission(main);
	int num = 0;
	
MODIFIED:
	memcpy(origin1_instruction, modified1_instruction, 6);
    memcpy(origin2_instruction, modified2_instruction, 6);
    memcpy(origin3_instruction, modified3_instruction, 3);
    memcpy(origin4_instruction, modified4_instruction, 6);
    memcpy(origin5_instruction, modified5_instruction, 6);
    memcpy(origin6_instruction, modified6_instruction, 6);
    memcpy(origin7_instruction, modified7_instruction, 6);
    memcpy(origin8_instruction, modified8_instruction, 3);

TARGET:
    num += default1[0] * default2[0];
    num += default1[1] * default2[1];
	printf("%d\n", num);
    num += vec1[0] * vec2[0];
    num += vec1[2] * vec2[2];
}
// modifying 시 num = 22 * 7 + 25 * 6, 아니면 num = 0 출력

void get_permission(void *foo_addr)
{
	if (change_page_permissions_of_address(foo_addr) == -1)
	{
		write(STDERR_FILENO, err_string, strlen(err_string) + 1);
		exit(1);
	}
}

int change_page_permissions_of_address(void *addr)
{

	int page_size = 4096;

	addr -= (unsigned long)addr % page_size;

	if (mprotect(addr, page_size, PROT_READ | PROT_WRITE | PROT_EXEC) == -1)
	{
		return -1;
	}
	return 0;
}

//clang-9 smc5.c -c -emit-llvm -S -target x86_64-pc-linux-gnu