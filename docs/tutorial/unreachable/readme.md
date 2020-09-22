# Description

컴파일러 선에서 알 수 있는 Unreachable Code 들이 컴파일 과정중에서 소실되는 문제가 있습니다.

최적화 옵션인 -O0 를 사용하더라도 이 문제는 해결되지 않으므로, Unreachable Code가 사라지지 않게 하기 위해서 컴파일러가 이 코드가 Unreachable Code인지 아닌지 알 수 없게 하는 트릭을 사용해야 합니다.

```c
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
```

```c
#include <stdio.h>

int main(void) {
	goto end;
	__asm__ __volatile__(
    "deadblock:\n"
    "nop\n"
    "nop\n"
    "nop\n"
    "nop\n"
);
    end:
	printf("IT works.\n");
	return 0;
}
```

두 코드는 의미론적으로는 같지만, C 컴파일러 입장에서 전자의 경우는 해당 코드가 Unreachable Code인지 아닌지 알 수 없으므로(아마도, 최적화 수행과정에서 반영되지 않은 부분이므로. 적어도 clang-9 에서는.) deadblock이 소실되지 않습니다.
