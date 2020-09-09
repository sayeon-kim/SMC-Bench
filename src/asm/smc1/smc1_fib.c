#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <stdlib.h>
#include <errno.h>
#include <sys/mman.h>

#define NUM 8       // fib(8) !!!


int change_page_permissions_of_address(void *addr);
void get_permission(void* foo_addr);

char* err_string = "Error while changing page permissions of foo()\n";

int main(void){
    // code ptr to key
    unsigned char* ptr_key = (unsigned char*)main + 107;  // objdump로 확인!!!

    int cnt;
    unsigned char instr9[4];
    unsigned char instr10[4];
    int index;
    unsigned char fib_index;

    // initialize
    get_permission(main);

    // SMC1

    // lw $4, num
    cnt = NUM;

    // lw $9, key
    memcpy( instr9, ptr_key, 4);

    // li $8, 1
    index = 1;

    // li $2, 1
    fib_index  = 1;

loop:
    // beq $8, $4, halt
    if (index == cnt) goto halt;

    // addi $8, $8, 1
    index = index + 1;

    // add $10, $9, $2
    memcpy( instr10, instr9, 4);
    instr10[3] = instr10[3] + fib_index  - 1;  // difference!!

key:
    // addi $2, $2, 0 
    fib_index = fib_index + 1;   // difference!!

    // sw $10, key
    memcpy(ptr_key, instr10, 4);

    // for debugging
    // printf("fib(%d)=%d\n", index, fib_index);

    // j loop
    goto loop;

halt:
    printf("fib(%d)=%d\n", cnt, fib_index);

    return 0;
}


///////////////////////////////
// Permission-related functions
///////////////////////////////

void get_permission(void* foo_addr) {
    if(change_page_permissions_of_address(foo_addr) == -1) {
        write(STDERR_FILENO, err_string, strlen(err_string) + 1);
        exit(1);
    }    
}

int change_page_permissions_of_address(void *addr){
    
    int page_size = 4096;

    addr -= (unsigned long)addr % page_size;

    if(mprotect(addr, page_size, PROT_READ | PROT_WRITE | PROT_EXEC) == -1){
        return -1;
    }

    return 0;
}
