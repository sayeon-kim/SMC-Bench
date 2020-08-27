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
	unsigned char *modify_1 =( unsigned char *)malloc(sizeof(char) * 4);
	void *instruction1 = (void *)main + 142 ;
	void *instruction2 = (void *)main + 151 ;	
	get_permission(main);
	int origin=0 ;
	int modifing=1 ;	
	goto MAIN;
MODIFY:
	memcpy(modify_1, instruction1, 4);
	memcpy(instruction1, instruction2, 4);
	memcpy(instruction2, modify_1, 4);
MAIN:
	
	origin += 0;
	modifing += 1;
	printf("%d\n",origin);
	printf("%d\n",modifing);
	goto MODIFY;
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

