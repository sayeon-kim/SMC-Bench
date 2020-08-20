#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <stdlib.h>
#include <errno.h>
#include <sys/mman.h>

int change_page_permissions_of_address(void *addr);
void get_permission(void *foo_addr);
void do_something();
void alter();
char *err_string = "Error while changing page permissions of foo()\n";

int main(void)
{
	unsigned char *temp_instrutcion = (unsigned char *)malloc(sizeof(char) * 4);
	void *first_instruction = (void *)main + 101;
	void *second_instruction = (void *)main + 127;
	get_permission(main);
	int num = 0;
	goto MAIN;
BODY:
	memcpy(temp_instrutcion, first_instruction, 4);
	memcpy(first_instruction, second_instruction, 4);
	memcpy(second_instruction, temp_instrutcion, 4);
MAIN:
	num += 5;
	printf("%d\n", num);
	num -= 5;
	goto BODY;
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
