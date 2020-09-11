#include <stdio.h>

int main(){
	int a = 4;
	int b = 9;
	int c;

	c = a+b;

	hello(c);

	return 0;
}

void hello(int number){
	printf("Hello World! x %d", number;
}

// clang -O0  -S -emit-llvm test.c -o test.ll