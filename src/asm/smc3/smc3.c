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
    //overwriting 전의 계산되는 vectorr값
    int origin[3] = {1, 2, 3};
    //overwriting 할 vector값
    int vec[3] = {10, 11, 13};

	void *origin1_instruction = (void *)main + 209; //num += origin[0]
	void *origin2_instruction = (void *)main + 252; //num += origin[1]
	void *origin3_instruction = (void *)main + 295; //num += origin[2]

	void *vec_instruction = (void *)main + 323; //num += vec[0]

	void *vec_index = (void *)main + 325; //num += vec[0]의 vec[0]

	void *vec1_index = (void *)main + 46; //vec[0]
	void *vec2_index = (void *)main + 53; //vec[1]
	void *vec3_index = (void *)main + 60; //vec[2]

	get_permission(main);
	int num = 0;
	
TARGET:
	//vec[0]을 num += vec[0]의 vec[0]에 overwriting
	memcpy(vec_index, vec1_index, 1);
	//vec[0]이 update된 num += vec[0] 명령어를 원래 있던 num += vec[0] 명령어에 overwriting
	memcpy(origin1_instruction, vec_instruction, 3);
    num += origin[0];

	//vec[1]을 num += vec[0]의 vec[0]에 overwriting
	memcpy(vec_index, vec2_index, 1);
	//vec[1]이 update된 num += vec[1] 명령어를 원래 있던 num += vec[0] 명령어에 overwriting
	memcpy(origin2_instruction, vec_instruction, 3);
    num += origin[1];

	//vec[2]을 num += vec[0]의 vec[0]에 overwriting
	memcpy(vec_index, vec3_index, 1);
	//vec[2]이 update된 num += vec[2] 명령어를 원래 있던 num += vec[0] 명령어에 overwriting
	memcpy(origin3_instruction, vec_instruction, 3);
    num += origin[2];

	printf("%d\n", num);
//overwriting 할 index update 이전의 vector
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