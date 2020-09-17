#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <stdlib.h>
#include <errno.h>
#include <sys/mman.h>

#define GEN_OFFSET 483
#define TPL_OFFSET 462

#define SIZE_TPL_INIT_INST 7  
#define SIZE_TPL_BODY_INST 12
#define SIZE_TPL_END_INST 2

#define TPL_END_JUMP_ADDR_OFFSET 1

#define TPL_VEC1_INDEX 2
#define TPL_VEC2_INDEX 5

int change_page_permissions_of_address(void *addr);
void get_permission(void* foo_addr);
int gen();

char* err_string = "Error while changing page permissions of foo()\n";

int main(void){
    int innerprod_reg2;
    int vec1[] = {22, 0, 25};
    int vec2[] = {7, 429, 6};

    int result = 0;

    unsigned char*  ptr_gen_reg9;
    unsigned char*  ptr_tpl_reg11;

    unsigned char*  ptr_tpl_end;
    unsigned char*  ptr_tpl_body;

    int             vec_length_reg4;       //$4
    int             vec_index_reg8;        //$8, counter

    // initialize
    get_permission(main);

start:
    //li $4, 3
    vec_length_reg4 = 3;

    //li $8, 0
    vec_index_reg8 = 0;

    //la $9, gen
    ptr_gen_reg9 = (unsigned char*)main + GEN_OFFSET;

    //la $11, tpl
    ptr_tpl_reg11 = (unsigned char*)main + TPL_OFFSET;

    //lw $12, 0($11)
    //sw $12, 0($9)
    for(int i = 0; i < SIZE_TPL_INIT_INST; i++) ptr_gen_reg9[i] = ptr_tpl_reg11[i];


    //addi $9, $9, 4
    ptr_gen_reg9 = ptr_gen_reg9 + SIZE_TPL_INIT_INST;

loop:
    //beq $8, $4, post
    if(vec_index_reg8 == vec_length_reg4) goto post;
    
    //lw $12, (0, 4, 8)$11
    //sw $12, (0, 4, 8)$11
    ptr_tpl_body = ptr_tpl_reg11 + SIZE_TPL_INIT_INST;
    for(int i = 0; i < SIZE_TPL_BODY_INST; i++) ptr_gen_reg9[i] = ptr_tpl_body[i];

    //add $12, $12, $13
    //add $12, $12, $10
    ptr_gen_reg9[TPL_VEC1_INDEX] += (unsigned char)(vec_index_reg8 * 4);
    ptr_gen_reg9[TPL_VEC2_INDEX] += (unsigned char)(vec_index_reg8 * 4);


    //addi $9, $9, 16
    ptr_gen_reg9 += SIZE_TPL_BODY_INST;

next:
    // addi $8, $8, 1
    vec_index_reg8++;
    // j loop
    goto loop;

post:
    //lw $12, 20($11)
    //sw $12, 0($9)
    ptr_tpl_end = ptr_tpl_reg11 + SIZE_TPL_INIT_INST + SIZE_TPL_BODY_INST;
    for (int i=0; i<SIZE_TPL_END_INST; i++) {
        ptr_gen_reg9[i] = ptr_tpl_end[i];
        if(i == TPL_END_JUMP_ADDR_OFFSET) ptr_gen_reg9[i] -= 45;
    }

    //jal gen
    goto gen;

after_call_gen:
    result = innerprod_reg2;

    printf("%d \n", result);    

tpl:
    innerprod_reg2 = 0;
    innerprod_reg2 = innerprod_reg2 + vec1[0] * vec2[0];
    goto after_call_gen;

gen:
    // get_permission 코드 위에 오버라이팅!!
    goto after_call_gen;
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
