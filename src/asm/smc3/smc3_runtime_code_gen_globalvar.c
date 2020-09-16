#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <stdlib.h>
#include <errno.h>
#include <sys/mman.h>


#define GEN_OFFSET 4
#define TPL_OFFSET 418 // 420  // 91e - 77a

#define SIZE_TPL_INIT_INST 10
#define SIZE_TPL_BODY_INST 29
#define SIZE_TPL_END_INST 8

#define TPL_VEC1_INDEX 2
#define TPL_VEC2_INDEX 8

int change_page_permissions_of_address(void *addr);
void get_permission(void* foo_addr);
int gen();

//.data section
int vec1[] = {22, 0, 25};
int vec2[] = {7, 429, 6};

int result = 0;
int innerprod_reg2 = 0;

char* err_string = "Error while changing page permissions of foo()\n";

int main(void){

    unsigned char*  ptr_gen_reg9;
    unsigned char*  ptr_tpl_reg11;

    unsigned char*  ptr_tpl_end;
    unsigned char* ptr_tpl_body;

    int             vec_length_reg4;     //$4
    int             vec_index_reg8;        //$8, counter
    int             vec1_value_reg10;
    int             offset_gen;

    // initialize
    get_permission(gen);

start:
    //li $4, 3
    vec_length_reg4 = 3;

    //li $8, 0
    vec_index_reg8 = 0;

    //la $9, gen
    ptr_gen_reg9 = (unsigned char*)gen + GEN_OFFSET;

    //la $11, tpl
    ptr_tpl_reg11 = (unsigned char*)main + TPL_OFFSET;

    //lw $12, 0($11)
    //sw $12, 0($9)
    for(int i = 0; i < SIZE_TPL_INIT_INST; i++)
      ptr_gen_reg9[i] = ptr_tpl_reg11[i] ;


    //addi $9, $9, 4
    ptr_gen_reg9 = ptr_gen_reg9 + SIZE_TPL_INIT_INST;

loop:
    //beq $8, $4, post
    if(vec_index_reg8 == vec_length_reg4) goto post;

    // li $13, 4
    // mul $13, $13, $8
    // lw $10, vec1($13)
    vec1_value_reg10 = vec1[vec_index_reg8];

    // beqz $10, next
    if(vec1_value_reg10 == 0) goto next;

    //lw $12, 4($11)
    //add $12, $12, $13
    //sw $12, 0($9)

    //lw $12, 8($11)
    //add $12, $12, $10
    //sw $12, 4($9)

    // lw $12, 12($11)
    // sw $12, 12($9)

    // lw $12, 16($110
    // sw $12, 12($9)

    ptr_tpl_body = ptr_tpl_reg11 + SIZE_TPL_INIT_INST;

    for(int i = 0; i < SIZE_TPL_BODY_INST; i++) {
      ptr_gen_reg9[i] = ptr_tpl_body[i];
    }

    // tpl의 인덱스 0을 counter(vec_index_reg8)로 바꾸기
    // - lw $13, 0($4)
    // - li $12, 0
    ptr_gen_reg9[TPL_VEC1_INDEX] += (unsigned char)(vec_index_reg8 * 4 - 51);
    ptr_gen_reg9[TPL_VEC2_INDEX] += (unsigned char)(vec_index_reg8 * 4 - 51);


    // addi $9, $9, 16
    ptr_gen_reg9 += SIZE_TPL_BODY_INST;


next:
    // addi $8, $8, 1    (counter)
    vec_index_reg8++;

    // j loop
    goto loop;

post:

    // lw $12, 20($11)
    // sw $12, 0($9)
    ptr_tpl_end = 
      ptr_tpl_reg11 + SIZE_TPL_INIT_INST + SIZE_TPL_BODY_INST;

    for (int i=0; i<SIZE_TPL_END_INST; i++) {
      ptr_gen_reg9[i] = ptr_tpl_end[i];
    }

    // la $4, vec2
    //   - vec2를 가리키는 reg4를 직접 도입할 필요가 없음.
    //   - 대신 배열 vec2 이름을 직접 사용함

    // jal gen
    innerprod_reg2 = gen();

    // sw $2, result
    result = innerprod_reg2;

    // j main
    printf("%d \n", result);

    // [주의]
    //   이후 tpl 코드를 실행하는데 의미없는 실행이고,
    //   main을 종료하기 위함.

tpl:
    // li $2, 0
    innerprod_reg2 = 0;

    // lw $13, 0($4)
    // li $12, 0
    // mul $12, $12, $13
    // add $2, $2, $12
    innerprod_reg2 = innerprod_reg2 + vec1[0] * vec2[0];

    // jr $31
    return innerprod_reg2;
}


int gen (){
    int dummy = 0;
    dummy += 2;
    dummy += 2;
    dummy += 2;
    dummy += 2;
    dummy += 2;
    dummy += 2;
    dummy += 2;
    dummy += 2;
    dummy += 2;
    dummy += 2;
    dummy += 2;
    dummy += 2;
    dummy += 2;
    dummy += 2;
    dummy += 2;
    dummy += 2;
    dummy += 2;
    dummy += 2;
    dummy += 2;
    dummy += 2;
    dummy += 2;
    dummy += 2;
    dummy += 2;
    dummy += 2;
    dummy += 2;
    dummy += 2;
    dummy += 2;
    dummy += 2;
    dummy += 2;
    dummy += 2;
    dummy += 2;
    dummy += 2;
    dummy += 2;
    dummy += 2;
    dummy += 2;
    dummy += 2;
    dummy += 2;
    dummy += 2;
    dummy += 2;
    dummy += 2;
    dummy += 2;
    dummy += 2;
    dummy += 2;
    dummy += 2;
    dummy += 2;
    return dummy;
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
