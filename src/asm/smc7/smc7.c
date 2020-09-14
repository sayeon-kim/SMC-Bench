#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <stdlib.h>
#include <errno.h>
#include <sys/mman.h>

#define LOOP 49
#define NEW 112

int change_page_permissions_of_address(void *addr);
void get_permission(void *foo_addr);

char *err_string = "Error while changing page permissions of foo()\n";
char *smc_string = "Self Growing Code\n";

#define SIZE_LOOP  63   //

int main(void)
{
  unsigned char* ptr_loop;
  unsigned char* ptr_new;

  int i;
  int offset;

  get_permission(main);

start:
  // Initialize
  offset = 0;
  ptr_loop = (unsigned char*) main + LOOP;  //
  ptr_new  = (unsigned char*) main + NEW;  //

loop:

  // loop:
  // lw $11, 0($8)
  // sw $11, 0($9)
  // addi $8, $8, 4
  // addi $9, $9, 4
  // bne $8, $10, loop
  for(i=0; i<SIZE_LOOP; i++)
    (ptr_new + offset)[i] = ptr_loop[i];
  
  offset += SIZE_LOOP;

new:
  
  return 0;

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

