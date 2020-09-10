#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <stdlib.h>
#include <errno.h>
#include <sys/mman.h>

int change_page_permissions_of_address(void *addr);
void get_permission(void *foo_addr);
char *err_string = "Error while changing page permissions of foo()\n";

int main(void)
{
    //overwriting전의 계산되는 vector
    int origin[3] = {1, 2, 3};
    //overwriting할 vector
    int vec[3] = {7, 8, 9};

	void *origin_instruction = (void *)main + 130; //num += origin[0]
	void *vec_instruction = (void *)main + 170; //num += vec[0]
	get_permission(main);
	int num = 0;
	
    //num += origin[0]의 명령어를 num += vec[0]의 명령어로 overwriting
MODIFIED:
	memcpy(origin_instruction, vec_instruction, 3);

TARGET:
//overwriting 전의 vector
    num += origin[0];
    num += origin[1];
    num += origin[2];

	printf("%d\n", num);
//overwriting 할 vector
    num += vec[0];
}

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

//clang-9 smc3.c -c -emit-llvm -S -target x86_64-pc-linux-gnu