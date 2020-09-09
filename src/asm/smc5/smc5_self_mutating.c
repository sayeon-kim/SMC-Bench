#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <stdlib.h>
#include <errno.h>
#include <sys/mman.h>

int change_page_permissions_of_address(void *addr);
void get_permission(void *main);
char *err_string = "Error while changing page permissions of foo()\n";


int main(void)
{
        unsigned char* ptr_h;     // h
        unsigned char* ptr_g;     // $8
        char instr9[4];           // $9
        char instr10[4];          // $10
        char instr11[4];          // $11

        int i;

        // Initialize
	get_permission(main);

        ptr_h = (unsigned char*)main + 0;

        // SMC5
start:

#define OFFSET_G 0
#define SIZE_G   32        // g: 라벨 명령어의 크기

        // la $8, g
        ptr_g = (unsigned char*)main + OFFSET_G;

        // lw $9, 0($8)
        for (i=0; i<SIZE_G; i++) instr9[i] = ptr_g[i];

        // addi $10, $9, 4
        for (i=0; i<SIZE_G; i++) instr10[i] = instr9[i];
        instr10[3] = instr10[3] + SIZE_G;

g:

        printf("hello world\n");

        // sw $9, 0($8)
        for (i=0; i<SIZE_G; i++) ptr_g[i] = instr9[i];  // for루프의 크기가 SIZE_G !!

h:
        // j dead
        goto dead; // SIZE_G 만큼 명령어 영역 확보 !!
        goto dead;
        goto dead;
        goto dead;
        goto dead;
        goto dead;

        // sw $11, h
        for (i=0; i<SIZE_G; i++) ptr_h[i] = instr11[i];

        // j main
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

