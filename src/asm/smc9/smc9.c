#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <stdlib.h>
#include <errno.h>
#include <sys/mman.h>

int change_page_permissions_of_address(void *addr);
void get_permission(void *foo_addr);
void foo();

char *err_string = "Error while changing page permissions of foo()\n";
char *smc_string = "Self Growing Code\n";

int main(void)
{

    void *foo_addr = (void *)foo;

    get_permission(foo_addr);
    foo((unsigned char *)foo_addr + 55, (unsigned char *)foo_addr);

    return 0;
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

void foo(unsigned char *dest, unsigned char *src)
{
    for (int i = 0; i < 55; i++)
    {
        *dest = *src;
        dest++;
        src++;
    }
}
