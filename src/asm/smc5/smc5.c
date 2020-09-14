#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <stdlib.h>
#include <errno.h>
#include <sys/mman.h>

int change_page_permissions_of_address(void *addr);
void get_permission(void *main);
char *err_string = "Error while changing page permissions of foo()\n";


int main(void)
{
	get_permission(main);
 	unsigned char *temp_instruction = (unsigned char *)malloc(sizeof(char) * 5);
	void *exit_code_position = (void *)main + 105;
	memcpy(temp_instruction, exit_code_position, 5);

START:
	memcpy(exit_code_position, "\x90\x90\x90\x90\x90", 5);
	
MAIN:
	printf("Not Printed this string");
 	memcpy(exit_code_position, temp_instruction, 5);
 	goto START;
}


void get_permission(void *main)
{
	if (change_page_permissions_of_address(main) == -1)
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

