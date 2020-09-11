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
int main();
void f(int*);
void halt(int);

unsigned char* ptr_jal_f;

void f(int* ptr_reg8) {
  unsigned char* reg31;   // $31 or $ra
  unsigned char reg9[SIZE_CALL];
  int i;
  int j;
  unsigned char* ret_addr;
  unsigned char* call_addr;
  long int i_ret_addr;  // 포인터 변수에 bit 연산자를 적용할 수 없어 int 변수를 도입!

  // li $8, 42
  *ptr_reg8 = 42;

  // lw $9, -4($31)
  reg31 = (unsigned char*)&ptr_reg8 + 8 + 71;  // hard-coding: 스택 리턴 주소의 주소

  ///////////////////////////////////////////////////////////////
  // 포인터 변수 ret_addr을 계산해야하는데                     //
  // C언어에서 ret_addr에 bit 연산을 적용할 수 없어            //
  // 먼저 i_ret_addr에 주소를 int로 계산한 다음                //
  // ret_addr로 주소를 옮김!                                   //
  ///////////////////////////////////////////////////////////////
  i_ret_addr = 0;

  for(i=8; i>0 ;i--) {
    char ch = reg31[i];

    printf("%x%x ", ((unsigned) (ch & 0xf0)) >> 4, ch & 0x0f );

    i_ret_addr = i_ret_addr | ((unsigned) (ch & 0xf0) >> 4);
    i_ret_addr = i_ret_addr << 4;

    i_ret_addr = i_ret_addr | (ch & 0x0f);

    if (i > 1) {
      i_ret_addr = i_ret_addr << 4;
    }
  }
  ///////////////////////////////////////////////////////////////

  ret_addr = (unsigned char*)i_ret_addr;
  call_addr = ret_addr - 5; // callq의 크기가 5 bytes

  printf("\nmain: %p\n", (unsigned char*)main + 44 + 5);
  printf("ret_addr: %p\n", (unsigned char*)ret_addr);

/*   reg31 = (unsigned char*)&ptr_reg8;  // hard-coding: 스택 리턴 주소의 주소 */

/* for(j=0; j<=80; j++) { printf("-%d(%p) ", j, reg31); */

/*   for(i=8; i>0 ;i--) { */
/*     char ch = reg31[i]; */
/*     printf("%x%x ", ((unsigned) (ch & 0xf0)) >> 4, ch & 0x0f ); */
/*   } */

/*   printf("\n"); */

/*   reg31 = reg31 + 1; */
/* } */

  for(i=0; i<SIZE_CALL; i++) reg9[i] = call_addr[i];

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
