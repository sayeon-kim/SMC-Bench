#include <stdio.h>
#include <unistd.h>
#include <errno.h>
#include <string.h>
#include <sys/mman.h>

void foo(void);
int change_page_permissions_of_address(void *addr);

int main(void)
{
	void *foo_addr = (void *)foo;

	if (change_page_permissions_of_address(foo_addr) == -1)
	{
		fprintf(stderr, "Error while changing page permissions of foo(): %s\n", strerror(errno));
		return 1;
	}

	puts("Calling foo...");
	foo();

	unsigned char *instruction = (unsigned char *)foo_addr + 18;
	*instruction = 0x2A;

	puts("Calling foo...");
	foo();

	return 0;
}

void foo(void)
{
	int i = 0;
	i++;
	printf("i: %d\n", i);
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

// clang-9 -c -emit-llvm -S -target i386-pc-linux-gnu