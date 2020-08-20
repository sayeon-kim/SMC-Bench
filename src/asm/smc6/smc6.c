#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <stdlib.h>
#include <errno.h>
#include <sys/mman.h>

int change_page_permissions_of_address(void *addr);
void get_permission(void *main);
void foo();
void modify();

char *start_string = "start\n";
char smc_string[] = "Self Modifing Code\n";
char add[] = "restart";

int main(void)
{
	get_permission(main);
	goto FOO;

MODIFY:
	modify();
	memcpy(modify, smc_string, sizeof(smc_string) - 1);

FOO:
	printf("It's foo() \n");
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

