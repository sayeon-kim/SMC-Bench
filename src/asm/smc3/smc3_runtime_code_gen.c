#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <stdlib.h>
#include <errno.h>
#include <sys/mman.h>


#define GEN 30
#define TPL 40
#define SIZE_OF_TPL 10
#define SIZE_OF_LW 20

int change_page_permissions_of_address(void *addr);
void get_permission(void* foo_addr);

char* err_string = "Error while changing page permissions of foo()\n";

//.data section
int vec1[] = {22, 0, 25};
int vec2[] = {7, 429, 6};
int result;

int main(void){

    unsigned char*  ptr_gen_reg9;
    unsigned char*  ptr_tpl_reg11;
    unsigned char   reg12[SIZE_OF_TPL];
    unsigned char   reg13[SIZE_OF_LW];

    int             vec_length;     //$4
    int             vec_idx;        //$8
    int             vec_position;
    int             vec1_value;

start:
    //li $4, 3
    vec_length = 3;

    //li $8, 0
    vec_idx = 0;

    //la $9, gen
    ptr_gen_reg9 = main + GEN;

    //la $11, tpl
    ptr_tpl_reg11 = main + TPL;

    //lw $12, 0($11)
    for(int i = 0; i < SIZE_OF_TPL; i++)
    //sw $12, 0($9)      
    //addi $9, $9, 4     

loop:
    //beq $8, $4, post
    if(vec_idx == vec_length) goto post;

    // li $13, 4
    // mul $13, $13, $8
    // lw $10, vec1($13)
    vec1_value = vec1[vec_idx];
    
    // beqz $10, next
    if(vec1_value == 0) goto next;
    



next:
    vec_idx++;
    goto loop;

post:
    gen();

tpl:
    result = 0;
    result = result + vec1[0];
    result = result + vec2[0];
}


void gen (){
    int dummy = 0;
    dummy = 1;
    dummy = 1;
    dummy = 1;
    dummy = 1;
    dummy = 1;
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
