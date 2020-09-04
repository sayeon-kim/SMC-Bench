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
	get_permission(main);
START:
	printf("NOP");
	printf("NOP");
	goto ALTER;
START2:
	printf("NOPE\n");
	memcpy(main + 131, "\x8c", 1);
ALTER:
	printf("Alter\n");
	memcpy(main + 16, "\xbf\x00\x00\x00\x00\xe8\xbc\xfe\xff\xff", 10);
	goto START2;
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
