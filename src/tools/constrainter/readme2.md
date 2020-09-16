# Instruction

Update 사항.

1. call은 아무리 생각해도 모르겠습니다.
2. 기존 8개의 명령어 중에서, BitCast 명령어는 Integer to Pointer 타입은 안됩니다.(ll 파일로 테스트 해본 결과 그렇습니다.) Pointer to Pointer 만 되는 것 같습니다. 

예)
temp = bitcast i64 64 to i64*;

에러)error: invalid cast opcode for cast from 'i64' to 'i64*'
