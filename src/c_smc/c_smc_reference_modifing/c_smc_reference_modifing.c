#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <stdlib.h>
#include <errno.h>
#include <sys/mman.h>

int change_page_permissions_of_address(void *addr);
void foo();
void modify();

char* exit_string = "EXIT\n";
char* smc_string = "SMC\n";
char* err_string = "Error while changing page permissions of foo()\n";

int main(void){
    
    void *foo_addr = (void *)foo;
    
    foo();
    modify(foo_addr);
    foo();
    
    return 0;
}

void modify(void* foo_addr) {
    if(change_page_permissions_of_address(foo_addr) == -1) {
        write(STDERR_FILENO, err_string, strlen(err_string) + 1);
        exit(1);
    }
    
    unsigned char* instruction = (unsigned char*)foo_addr + 11;
    *instruction += 8;
}

void foo() {
    char *str = exit_string; 
    write(STDOUT_FILENO, str, strlen(str) + 1);
}

int change_page_permissions_of_address(void *addr){
    
    int page_size = 4096;

    addr -= (unsigned long)addr % page_size;

    if(mprotect(addr, page_size, PROT_READ | PROT_WRITE | PROT_EXEC) == -1){
        return -1;
    }

    return 0;
}
