#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <stdlib.h>
#include <errno.h>
#include <sys/mman.h>

#define MAX(A, B) ((A) > (B)) ? (A) : (B)

#define START 23
#define GEN 259
#define GGEN 305

#define SIZE_OF_SW 44
#define SIZE_OF_JR 2
#define SIZE_OF_JMPQ 5

int change_page_permissions_of_address(void *addr);
void get_permission(void* foo_addr);

char* err_string = "Error while changing page permissions of foo()\n";

// for (i = 0; i < SIZE_OF_JMPQ; i++) ptr_reg4[i] = reg8[i];
unsigned char   store_instruction[SIZE_OF_SW] = {
    "\xc7\x45\xa8\x00\x00\x00\x00"      //mov DWORD PTR[rbp-0x58], 0x0
    "\xeb\x1d"                          //jmp 0x885
    "\x8b\x45\xa8"                      //mov eax, DWORD PTR [rbp-0x58]
    "\x48\x63\xd0"                      //movsxd rdx,eax
    "\x48\x8b\x45\xb8"                  //mov rax, QWORD PTR [rbp-0x48]
    "\x48\x01\xc2"                      //add rdx, rax
    "\x8b\x45\xa8"                      //mov eax, DWORD PTR [rbp-0x58]
    "\x48\x98"                          //cdqe
    "\x0f\xb6\x44\x05\xc0"              //movzx eax, BYTE PTR [rbp+rax*1-0x40]
    "\x88\x02"                          //mov BYTE PTR [rdx],al
    "\x83\x45\xa8\x01"                  //add DWORD PTR [rbp-0x58],0x1
    "\x83\x7d\xa8\x04"                  //cmp DWORD PTR [rbp-0x58],0x2b
    "\x7e\xdd"                          //jle 0x868
};

unsigned char   jr_instruction[SIZE_OF_JR] = {
    "\xeb\x00"                          // 다음명령어로 점프
};

int main(void){

unsigned char*  ptr_reg9;
unsigned char*  ptr_reg4;

unsigned char   reg8[MAX(SIZE_OF_SW, SIZE_OF_JR)];

int             i;
int             dummy;


start:
    get_permission(main);
    // la $9, gen
    ptr_reg9 = (unsigned char*)main + GEN;
    
    // li $8, 0xac880000 (sw $8, 0($4))
    memcpy(reg8, store_instruction, SIZE_OF_SW);

    // sw $8, 0($9)
    for(i = 0; i < SIZE_OF_SW; i++) ptr_reg9[i] = reg8[i];
    
    // li $8, 0xac800008 (jr $4)
    memcpy(reg8, jr_instruction, SIZE_OF_JR);
    
    // sw $8, 4($9)
    for(i =  0; i < SIZE_OF_JR; i++) (ptr_reg9 + SIZE_OF_SW)[i] = reg8[i];

    // la $4, ggen
    ptr_reg4 = (unsigned char*)main + GGEN;

    // la $9, main
    ptr_reg9 = (unsigned char*)main + START;

    // li $8, 0x01200008 (jr $9)
    memcpy(reg8, "\xe9\x38\xff\xff\xff", SIZE_OF_JMPQ);
    
    // j gen
    goto gen;

gen:
    dummy++;
    dummy++;
    dummy++;
    dummy++;
    dummy++;
    dummy++;
    dummy++;
    dummy++;
    dummy++;
    dummy++;
    dummy*=2;
    dummy*=2;
ggen:
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
