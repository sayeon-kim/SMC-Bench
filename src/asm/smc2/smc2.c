#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <stdlib.h>
#include <errno.h>
#include <sys/mman.h>

#define SIZE_CALL 5  // callq 7ea <F> : e8 f0 fe ff ff


int change_page_permissions_of_address(void *addr);
void get_permission(void* foo_addr);

char* err_string = "Error while changing page permissions of foo()\n";

//
void f(int*);
void halt(int);

unsigned char* ptr_jal_f;

void f(int* ptr_reg8) {
  unsigned char* reg31;   // $31 or $ra
  unsigned char reg9[SIZE_CALL];
  int i;

  // li $8, 42
  *ptr_reg8 = 42;

  // lw $9, -4($31)
  reg31 = (unsigned char*)&ptr_reg8 - 16;  // hard-coding: 스택 리턴 주소의 주소

  for(i=0; i<SIZE_CALL; i++) reg9[i] = reg31[i];

  // bne $9, $10, halt
  for(i=0; i<SIZE_CALL; i++) {
    if (reg9[i] != ptr_jal_f[i])
      halt( *ptr_reg8 );
  }

  // jr $31
  return;
}

void halt(int reg8) {
    printf("Working? %d\n", reg8);
    exit(0);
}

int main(void){
    int reg8;

    // Initialize
    ptr_jal_f = (unsigned char*)main + 44;  // hard-coding: addr의 주소

    // SMC2

addr:
    // jal f
    f( &reg8 );

    // move $2, $8
    reg8 = 0;

    // j halt
    halt( reg8 );

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
