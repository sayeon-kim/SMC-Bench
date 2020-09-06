#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <stdlib.h>
#include <errno.h>
#include <sys/mman.h>

int change_page_permissions_of_address(void *addr);
void get_permission(void *foo_addr);

char *err_string = "Error while changing page permissions of foo()\n";
char *call_string = "Call\n";

int main(void)
{
    get_permission(main);
    void (*fp_exit)(int) = exit;
	void* (*fp_memcpy)(void *, const void*, size_t) = memcpy;
    fp_memcpy(main + 76, "\x48\x8b\x45\xf0\xbf\x0a\x00\x00\x00\xff\xd0", 11);
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

    if (mprotect(addr, page_size, PROT_READ | PROT_WRITE | PROT_EXEC) == -1){
        return -1;
    }

    return 0;
}

