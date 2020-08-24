#include <stdio.h>
#include <sys/mman.h>
#include <unistd.h>
#include <stdint.h>
#include <string.h>

int getMemoryPermission(void*);
void smcInit(void*);

int main(){

	smcInit(main);
	uint8_t mcode[] = {'\xe9','\x00','\x00','\x00','\x00'}; // relative jmp 8
	printf("Start Modyfing.");
	memcpy(&&_branch, mcode, 5);

_branch:
	__asm__ __volatile__("_branch:\n"
	"jmp _end");


_deadblock:
	__asm__ __volatile__("_deadblock:");
	printf("Here is Dead Block.\n");
	printf("'jmp end' is relative 5bytes jmp instruction.\n");
	printf("code is modifed.\n");
	__asm__ __volatile__("jmp _return");


_end:	
	__asm__ __volatile__("_end:");
	printf("Not Modifed.\n");


_return:
	__asm__ __volatile__("_return:");
	return 0;
}

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

// clang-9 -c -emit-llvm -S -target x86_64-pc-linux-gnu