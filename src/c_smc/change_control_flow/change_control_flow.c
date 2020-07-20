#include <stdio.h>
#include <string.h>
#include <sys/mman.h>
#include <unistd.h>
#include <stdint.h>

int getMemoryPermission(void *addr){
	// Move the pointer to the page boundary
	int page_size = getpagesize();
	addr -= (unsigned long)addr % page_size;

	if (mprotect(addr, page_size, PROT_READ | PROT_WRITE | PROT_EXEC) == -1)
	{
		return -1;
	}

	return 0;
}

void smcInit(void *addr){
	if(getMemoryPermission(addr)==-1){printf("Faield!\n");}
}


int main(void) {
	smcInit(main);
	void *modify_addr = &&modify;
	uint32_t main_addr = (uint32_t)main;
	uint32_t deadblock_addr = (uint32_t)&&deadblock;
	printf("offset : %02x\n", deadblock_addr-main_addr);
	// uint8_t code[] = {'\x90'};
	// uint8_t code[] = {'\xff','\x24', '\x25', deadblock_addr, deadblock_addr>>8, deadblock_addr>>16, deadblock_addr>>24};
	uint8_t code[] = {'\xe9','\x00', '\x00', '\x00', '\x00'};

	for(int i=0; i<7; i++){
		printf("%02x ", code[i]);
	}
	printf("\n");
	printf("%p\n", deadblock_addr);

	memcpy(modify_addr, code, sizeof(code));
	printf("%d\n",sizeof(code));

__asm__("break:\n"
		"nop"
		);

modify:
	__asm__ __volatile__("modify:\njmp end\nnop\nnop");

deadblock:
	__asm__ __volatile__(
	"xor %eax, %eax\n"
    "deadblock:\n"
    "nop\n"
    "nop\n"
    "nop\n"
    "nop\n"
    "nop\n"
    "nop\n"
    "nop\n"
	"nop\n"
	"nop\n"
	"nop\n"
	"nop\n"
	"nop\n"
	"nop\n"
	"nop\n"
	"nop\n"
	"nop\n"
	"nop\n"
	);
    printf("SELF MODYFING CODE.\n");

end:
	__asm__ __volatile__(
	"end:\n"
	"xor %eax, %eax"
	);
	printf("It works.\n");

return 0;
}