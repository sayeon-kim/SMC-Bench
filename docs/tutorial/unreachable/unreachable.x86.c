#include <stdio.h>

int main(void) {
	__asm__ __volatile__("jmp end\n"
    "deadblock:\n"
    "nop\n"
    "nop\n"
    "nop\n"
    "nop\n"
    "end:"
);
	printf("IT works.\n");
	return 0;
}