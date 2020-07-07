#include <stdio.h>
#include <sys/mman.h>

int change_page_permissions_of_address(void *addr);
void testing();

int main()
{
	void *modifing_addr = (void *)testing;
	if (change_page_permissions_of_address(modifing_addr) == -1)
	{
		printf("Error!");
	}
	testing();
}

void testing()
{
	__asm__(
		"test_start:					\n\t"
		"   jmp test_modify				\n\t"
		"test_modify:					\n\t"
		"   movl test_new, %eax			\n\t"
		"   movl %eax, (test_target)	\n\t"
		"   jmp test_target				\n\t"
		"test_new:						\n\t"
		"   jmp test_halt-16			\n\t"
		"	nop							\n\t"
		"	nop							\n\t"
		"test_halt:						\n\t"
		"   movl $1, %eax				\n\t"
		"   movl $1, %ebx				\n\t"
		"   int $0x80					\n\t"
		"test_target :					\n\t"
		"	nop							\n\t"
		"	nop							\n\t"
		"	nop							\n\t"
		"	nop							\n\t"
		"test_exit : 					\n\t"
		"	movl $1, %eax				\n\t"
		"	movl $0, %ebx				\n\t"
		"   int $0x80					\n\t");
}

int change_page_permissions_of_address(void *addr)
{
	// Move the pointer to the page boundary
	int page_size = 4096;
	addr -= (unsigned long)addr % page_size;

	if (mprotect(addr, page_size, PROT_READ | PROT_WRITE | PROT_EXEC) == -1)
	{
		return -1;
	}

	return 0;
}