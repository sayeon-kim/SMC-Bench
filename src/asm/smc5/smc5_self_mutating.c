#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <stdlib.h>
#include <errno.h>
#include <sys/mman.h>

#define OFFSET_G 427
#define OFFSET_H 482
#define SIZE_G   65        // g: 라벨 명령어의 크기
#define SIZE_H   54

int change_page_permissions_of_address(void *addr);
void get_permission(void *main);
char *err_string = "Error while changing page permissions of foo()\n";

unsigned char* ptr_g;
unsigned char* ptr_h;

int main(void)
{     // $8
        char instr9[SIZE_G];           // $9
        char instr10[SIZE_G];          // $10
        char instr11[SIZE_G];          // $11
        
        int i;
        int num = 1;
        
        // Initialize
	get_permission(main);

        // SMC 5
start:
        ptr_h = (unsigned char*)main + OFFSET_H;

        // la $8, g
        ptr_g = (unsigned char*)main + OFFSET_G;

        memset(instr9, '\x90', SIZE_G);
        memset(instr10, '\x90', SIZE_G);
        memset(instr11, '\x90', SIZE_G);

        // lw $9, 0($8)
        for (i=0; i< SIZE_G; i++) instr9[i] = ptr_g[i];

        // addi $10, $9, 4
        for (i=0; i < SIZE_G; i++) instr10[i] = instr9[i];
        instr10[21] = instr10[21] + 8;

        // sw $10, g
        for(i=0; i < SIZE_G; i++) ptr_g[i] = instr10[i];
        
        // lw $11, h
        for(i=0; i < SIZE_H; i++) instr11[i] = ptr_h[i];
g:
        // sw $9, 0($8)
        for (i=0; i < SIZE_H; i++) ptr_g[i] = instr9[i];  // for루프의 크기가 SIZE_G !!

h:
        num *= 2; // 6Byte Instruction
        num *= 2;
        num *= 2;
        num *= 2;
        num *= 2;
        num *= 2;
        num *= 2;
        num *= 2;
        num *= 2; // so size of all instructions is 54byte

        // sw $11, h
        for (i=0; i< SIZE_H; i++) ptr_h[i] = instr11[i];

        //j main
        printf("Num Value : %d\n", num);

        //Difference
        ptr_g[21] = ptr_g[21] - 8;
        
        goto start;

dead:
         return 0;
}


///////////////////////////////
// Permission-related function
///////////////////////////////

void get_permission(void *main)
{
	if (change_page_permissions_of_address(main) == -1)
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

