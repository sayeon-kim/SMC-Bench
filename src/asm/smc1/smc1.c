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
	void *first_instruction = (void *)main + 61;
	void *second_instruction = (void *)main + 90; 
	get_permission(main);
	int num = 0;
	
MODIFIED:
	memcpy(first_instruction, second_instruction, 4);

TARGET:
    num = 0;
	printf("%d\n", num);
    num = 1;
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
