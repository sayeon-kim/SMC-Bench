#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <stdlib.h>
#include <errno.h>
#include <sys/mman.h>

#define SIZE_MAIN   31
#define SIZE_GOTO_ALTER  26
#define SIZE_ALTER  64

int change_page_permissions_of_address(void *addr);
void get_permission(void *foo_addr);

char *err_string = "Error while changing page permissions of foo()\n";

int main(void)
{
        char instr8[SIZE_ALTER];           // $8
        char instr9[SIZE_MAIN];           // $9
        char instr_j_alter[SIZE_GOTO_ALTER];      // 
        int i;
        int num;  // goto alter 다음 코드에 넣을 dummy 코드를 위해 도입

        unsigned char* ptr_goto_alter;
        unsigned char* ptr_main;
        unsigned char* ptr_alter;

	get_permission(main);


        // Initialize
        num = 1;

        ptr_goto_alter = (unsigned char*)main + 192; // 180
        ptr_main = (unsigned char*)main + 194; // 182
        ptr_alter = (unsigned char*)main + 288; // 273

        // goto alter ~ 마지막 num*+2
        for(i=0; i<SIZE_GOTO_ALTER; i++) instr_j_alter[i] = ptr_goto_alter[i];  
        // nop
        for(; i<SIZE_MAIN; i++) instr_j_alter[i] = '\x90';         

goto_alter:
        goto alter;

main_start:
        // j alter

        // goto alter 부터 마지막 문장 num++까지가 SIZE_MAIN 바이트!!!
        // goto alter;

        // dummy code to be overrwritten
        num *= 2;   // 6 bytes
        num *= 2;   // 6 bytes
        num *= 2;   // 6 bytes
        num *= 2;   // 6 bytes
        num++;      // 7 bytes

        // sw $8, alter
        for(i=0; i<SIZE_ALTER; i++) ptr_alter[i] = instr8[i];

alter:
        // lw $8, main
        for(i=0; i<SIZE_MAIN; i++) instr8[i] = ptr_goto_alter[i];

        /* for(i=0; i<SIZE_MAIN; i++) { */
        /*   printf("%x%x ", ((unsigned) (instr8[i] & 0xf0)) >> 4, instr8[i] & 0x0f ); */
        /*  } */
        /* printf("\n"); */

        instr8[1] = '\xfe';  // jmp to 자기 자신!  eb fe !!

        // li $9, 0
        for(i=0; i<SIZE_MAIN; i++) instr9[i] = '\x90';    // 0x90: x86 NOP instruction

        // sw $9, main
        for(i=0; i<SIZE_MAIN; i++) ptr_main[i] = instr9[i];

        goto main_start;
}


////////////////////////////////
// Permission related functions
////////////////////////////////

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
