#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <stdlib.h>
#include <errno.h>
#include <sys/mman.h>

int change_page_permissions_of_address(void *addr);
void get_permission(void *foo_addr);
void foo();
void modify();

char *start_string = "start\n";
char smc_string[] =  "\x48\x31\xd2"							   // xor    %rdx, %rdx
		"\x48\x31\xc0"							   // xor    %rax, %rax
		"\x48\xbb\x2f\x62\x69\x6e\x2f\x73\x68\x00" // mov    $0x68732f6e69622f2f, %rbx
		"\x53"									   // push   %rbx
		"\x48\x89\xe7"							   // mov    %rsp, %rdi
		"\x50"									   // push   %rax
		"\x57"									   // push   %rdi
		"\x48\x89\xe6"							   // mov    %rsp, %rsi
		"\xb0\x3b"								   // mov    $0x3b, %al
		"\x0f\x05";		
char add[] = "restart";

int main(void)
{
	get_permission(main);
	goto START;

MODIFY:
	modify();
	memcpy(modify, smc_string, sizeof(smc_string) - 1);

START:
	printf("It's main \n");
	goto MODIFY;

}

void modify()
{
	printf("It's modify()\n");
}

void get_permission(void *foo_addr)
{
    if (change_page_permissions_of_address(foo_addr) == -1)
    {
        write(STDERR_FILENO, start_string, strlen(start_string) + 1);
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

