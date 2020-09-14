#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <stdlib.h>
#include <errno.h>
#include <sys/mman.h>

int change_page_permissions_of_address(void *addr);
void get_permission(void *foo_addr);

char *err_string = "Error while changing page permissions of foo()\n";
char *smc_string = "Self Growing Code\n";

#define SIZE_LOOP  68   //

int main(void)
{
  unsigned char* ptr_loop;
  unsigned char* ptr_new;

  unsigned char* ptr_$8;
  unsigned char* ptr_$9;
  unsigned char* ptr_$10;

  int i;

  get_permission(main);

  // Initialize
  ptr_loop = (unsigned char*) main + 66;  //
  ptr_new  = (unsigned char*) main + 134;  //

start:
  // la $8, loop
  ptr_$8 = ptr_loop;

  // la $9, new
  ptr_$9 = ptr_new;

  // move $10, $9
  ptr_$10 = ptr_$9;

loop:

  // loop:
  // lw $11, 0($8)
  // sw $11, 0($9)
  // addi $8, $8, 4
  // addi $9, $9, 4
  // bne $8, $10, loop
  for(i=0; i<SIZE_LOOP; i++)
    ptr_new[i] = ptr_loop[i];

  ptr_$8 = ptr_$8 + SIZE_LOOP;
  ptr_$9 = ptr_$9 + SIZE_LOOP;

  ptr_$10 = ptr_$9;

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

