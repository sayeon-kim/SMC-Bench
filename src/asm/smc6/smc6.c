#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <stdlib.h>
#include <errno.h>
#include <sys/mman.h>

int change_page_permissions_of_address(void *addr);
void get_permission(void *foo_addr);
void foo();

int num =1;
char *start_string = "start\n";
								   
int main(void)
{
	void *instruction = (void *)main + 169;
	void *instruction2 = (void *)main + 138;
	get_permission(main);
	goto START;

MODIFY:
	memcpy(instruction, instruction2, sizeof(instruction2) - 1);
	goto GEN;

START:
	printf("It's main \n");
	goto MODIFY;

GEN:
	num+=2;
	printf("num is %d\n", num);
	num-=1;
	goto START;

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

