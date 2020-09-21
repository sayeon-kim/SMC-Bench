#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <stdlib.h>
#include <errno.h>
#include <sys/mman.h>

#define BODY 62
#define SIZE_OF_ADD 7
#define SIZE_OF_SW 78
#define OFFSET_8 201-BODY
#define OFFSET_12 279-BODY
#define OFFSET_16 286-BODY
#define OFFSET_20 293-BODY

int change_page_permissions_of_address(void *addr);
void get_permission(void *foo_addr);
char *err_string = "Error while changing page permissions of foo()\n";

int main(void)
{
	unsigned char* 	ptr_body_reg10;
	unsigned char 	reg8[SIZE_OF_SW];
	unsigned char 	reg9[SIZE_OF_SW];
	int				reg2;
	int				dummy;
	int				i;

	//initalize
	get_permission(main);
	reg2 = 0;

start:
	// la $10, body
	ptr_body_reg10 = (unsigned char*)main + BODY;

body:
	// lw $8, 12($10)
	for (i = 0; i < SIZE_OF_ADD; i++) reg8[i] = (ptr_body_reg10 + OFFSET_12)[i]; // SIZE 71
    
	// lw $9, 16($10)
	for (i = 0; i < SIZE_OF_ADD; i++) reg9[i] = (ptr_body_reg10 + OFFSET_16)[i]; // SIZE 68
    
	// OFFSET 8 (OFFSET 20과 Byte길이를 맞춰줄 필요성이 있다.)
	// sw $9, 12($10)
	for (i = 0; i < SIZE_OF_ADD; i++) (ptr_body_reg10 + OFFSET_12)[i] = reg9[i]; // SIZE 68
    dummy = 0;																	 // SIZE 10
	// OFFSET 12
	// addi $2,$2, 21
	reg2 += 21;
    
	// OFFSET 16
	// addi $2,$2, 21   
	reg2 += 21;
    
	// OFFSET 20
	// sw $8, 16($10)        
	for(i = 0; i < SIZE_OF_ADD; i++) (ptr_body_reg10 + OFFSET_16)[i] = reg8[i]; // SIZE 71
	dummy++;																	// SIZE 7
    
	// lw $9, 8($10)        
	for(i = 0; i < SIZE_OF_SW; i++) reg9[i] = (ptr_body_reg10 + OFFSET_8)[i]; // SIZE 68
    
	// lw $8, 20($10)
	for(i = 0; i < SIZE_OF_SW; i++) reg8[i] = (ptr_body_reg10 + OFFSET_20)[i]; // SIZE 71

    // sw $9, 20($10)
	for(i = 0; i < SIZE_OF_SW; i++) (ptr_body_reg10 + OFFSET_20)[i] = reg9[i]; // SIZE 68

    // sw $8, 8($10)
	for(i = 0; i < SIZE_OF_SW; i++) (ptr_body_reg10 + OFFSET_8)[i] = reg8[i]; // SIZE 71

    // j body  
	goto body;
}




// Permission related function
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
