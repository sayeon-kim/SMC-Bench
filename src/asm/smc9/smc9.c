#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <stdlib.h>
#include <errno.h>
#include <sys/mman.h>

int change_page_permissions_of_address(void *addr);
void* _memcpy(void *dest, const void *src, size_t n);
void get_permission(void *foo_addr);
void foo();

char *err_string = "Error while changing page permissions of foo()\n";
char *smc_string = "Self Growing Code\n";

int main(void)
{
    get_permission(foo);

    int (*fp_printf)(const char*, ...);
    void* (*fp_memcpy)(void *, const void* , size_t );
    
    fp_memcpy = memcpy;
    fp_printf = printf;

    foo(fp_memcpy, fp_printf);
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

void foo(void* (*fp_memcpy)(void *, const void*, size_t), int (*fp_printf)(const char*, ...)) {
    int num = 89;
    fp_memcpy(foo + num, foo + 23, 66);
    fp_printf("%d\n", num);
    num += 66;
}