#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <stdlib.h>
#include <errno.h>
#include <sys/mman.h>

int change_page_permissions_of_address(void *addr);
void foo();
void get_permission(void *foo_addr);
char *err_string = "Error while changing page permissions of foo()\n";

int main(void)
{
	get_permission(foo);

	unsigned char *foo_code = (unsigned char *)malloc(sizeof(unsigned char) * 55);
	memcpy(foo_code, foo, 55);
	for (int i = 0; i < 55; i++)
	{
		foo_code[i] = foo_code[i] ^ -1;
	}
	memcpy(foo, foo_code, 55);

	for (int i = 0; i < 55; i++)
	{
		foo_code[i] = foo_code[i] ^ -1;
	}
	memcpy(foo, foo_code, 55);

	foo();
}

void foo()
{
	int num = 0;
	printf("This is Foo Function\n");
	num += 10;
	printf("num = %d\n", num);
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
