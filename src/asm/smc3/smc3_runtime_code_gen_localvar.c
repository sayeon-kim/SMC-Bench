#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <stdlib.h>
#include <errno.h>
#include <sys/mman.h>


#define GEN_OFFSET 521 // 983 - 77a
#define TPL_OFFSET 500 // 939 - 77a

#define SIZE_TPL_INIT_INST 7  
#define SIZE_TPL_BODY_INST 12
#define SIZE_TPL_END_INST 2

#define TPL_END_JUMP_ADDR_OFFSET 1 // eb cf (jmp  ...)

#define TPL_VEC1_INDEX 2
#define TPL_VEC2_INDEX 2

int change_page_permissions_of_address(void *addr);
void get_permission(void* foo_addr);
int gen();

int arr[10] = {1,2,3,4};

//.data section

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

    int             vec_length_reg4;     //$4
    int             vec_index_reg8;        //$8, counter
    int             vec1_value_reg10;
    int             offset_gen;

    int nonzero;

    // initialize
    get_permission(main);

    nonzero = 0;

start:
    //li $4, 3
    vec_length_reg4 = 3;

    //li $8, 0
    vec_index_reg8 = 0;

    //la $9, gen
    ptr_gen_reg9 = (unsigned char*)main + GEN_OFFSET;

    //la $11, tpl
    ptr_tpl_reg11 = (unsigned char*)main + TPL_OFFSET;

    //lw $12, 0($11)    // 1. TPL 블록의 초기화 코드를 복사
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

    nonzero++;

    //lw $12, 4($11)    // 2. TPL 블록의 몸체 코드를 복사
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
    ptr_gen_reg9[TPL_VEC1_INDEX] += (unsigned char)(vec_index_reg8 * 4);
    ptr_gen_reg9[TPL_VEC2_INDEX] += (unsigned char)(vec_index_reg8 * 4);


    // addi $9, $9, 16
    ptr_gen_reg9 += SIZE_TPL_BODY_INST;


next:
    // addi $8, $8, 1    (counter)
    vec_index_reg8++;

    // j loop
    goto loop;

post:

    // lw $12, 20($11)   // 3. TPL 블록의 리턴 코드를 복사
    // sw $12, 0($9)
    ptr_tpl_end = 
      ptr_tpl_reg11 + SIZE_TPL_INIT_INST + SIZE_TPL_BODY_INST;

    for (int i=0; i<SIZE_TPL_END_INST; i++) {
      ptr_gen_reg9[i] = ptr_tpl_end[i];
    }

    // [주의] vector 크기가 커지면 jump 상대 주소가 overflow 날 수 있음!!
    ptr_gen_reg9[TPL_END_JUMP_ADDR_OFFSET] -= nonzero * 20; 

    // la $4, vec2
    //   - vec2를 가리키는 reg4를 직접 도입할 필요가 없음.
    //   - 대신 배열 vec2 이름을 직접 사용함

    // jal gen
    goto gen;

after_call_gen:
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
    innerprod_reg2 = innerprod_reg2 + vec1[1] * vec2[1];
// vec1[0], vec2[0]:
// 940:	8b 55 e0             	mov    -0x20(%rbp),%edx
// 943:	8b 45 ec             	mov    -0x14(%rbp),%eax

// vec1[1], vec2[1]:
// 940:	8b 55 e4             	mov    -0x1c(%rbp),%edx
// 943:	8b 45 f0             	mov    -0x10(%rbp),%eax

    // jr $31
    // return innerprod_reg2;
    goto after_call_gen;

//   0x000055555555494c <main+466>:	eb cf	jmp    0x55555555491d <main+419>
//   0x000055555555496d <get_permission+29>:	eb cf	jmp    0x55555555493e <main+452>
//   452 - 419 + 7 = 40 = 20 * 2 

gen:
    // get_permission 코드 위에 오버라이팅!!
    goto start;
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
