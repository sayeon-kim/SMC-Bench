# SMC 코드 3번

#### Runtime Code Generation

원소의 길이가 3인 두 개의 벡터 vec1과 vec2의 내적을 구하는 코드를 생성하는 프로그램
(주어진 데이터에 맞춘 코드를 생성함으로써 빠르게 내적을 구하는 코드)

```assembly
	.data                  # Data declaration section
vec1:   .word 22, 0, 25        # 첫번째 벡터 (각 원소의 크기는 4 byets)
vec2:   .word 7, 429, 6        # 두번째 벡터 (각 원소의 크기는 4 bytes)
result: .word 0

    	.text                  # Code section

main:
	li $4, 3                                    # 벡터 크기 size(3)를 $4에 로딩
        li $8, 0                                    # 카운터 counter($8) = 0, 1, ..., size-1

        la $9, gen                                  # gen의 주소를 읽어 $9에 저장
        la $11, tpl                                 # tpl의 주소를 읽어 $11에 저장

        lw $12, 0($11)	                            # tpl의 첫번째 명령어 (li $2, 0)을 읽어서
        sw $12, 0($9)                               # gen의 첫번째에 복사!
                                                    # (참고) 마지막 명령어 처리하는 부분과 비교!

        addi $9, $9, 4                              # $9를 gen의 두번째 명령어 주소를 가리킴

loop:
	beq $8, $4, post                            # if (counter == size) post로 분기
                                                    # else if (counter < size) 코드 생성

                                                    # [REMIND]
                                                    #     counter($8)  = 0, 1, ..., size-1   (cf. size=3)
                                                    #     $9  = gen + ???
                                                    #     $11 = tpl

        li $13, 4                                   # $13 = counter($8) * 4
        mul $13, $13, $8                            #  (참고: mul $13, 4, $8 !!!)

                                                    # 벡터 값이0이냐에 따라 코드 생성 여부 결정
        lw $10, vec1($13)                           #    현재 벡터 값 vec1($13)를 읽어 $10에 읽어오기
        beqz $10, next                              # 현재 벡터 값 $10 == 0:
                                                    #      코드를 생성하지 않고 다음 next로 분기

                                                    # 현재 벡터 값 $10 != 0:
                                                    #      내적합 구하는 코드를 생성

                                                    # [1] lw $13, counter*4($4) 
        lw $12, 4($11)                              #     - lw $13, 0($4)을 읽어
        add $12, $12, $13                           #     - lw $13, counter*4($4)을 만든 다음
        sw $12, 0($9)                               #     - gen+1번째 명령어에 저장

                                                    # [2] li $12, vec1[counter]
        lw $12, 8($11)                              #     - li $12, 0을 읽어
        add $12, $12, $10                           #     - li $12, vec1[counter]을 만든 다음
        sw $12, 4($9)                               #     - gen+2번째 명령어에 저장

                                                    # [3] mul $12, $12, $13
        lw $12, 12($11)	                            #     - gen+3번째 명령어에 저장
        sw $12, 8($9)

        lw $12, 16($11)	                            # [4] add $2, $2, $12
        sw $12, 12($9)                              #     - gen+4번째 명령어에 저장

        addi $9, $9, 16                             # 다음 벡터 원소에 대해 생성할  코드 블록 주소를 $9에 설정

next:
	addi $8, $8, 1                               # counter($8) = counter + 1
        j loop                                       # loop로 돌아감

post:
	lw $12, 20($11)                              # tpl의 마지막 명령어(jr $31)을 읽어서
        sw $12, 0($9)                                # gen의 마지막에 복사!

        la $4, vec2                                  # $4에 vec2의 주소를 가져옴! 나중에 내적 구할 때 사용.

        jal gen                                      # gen에 생성한 코드를 호출한다
        sw $2, result                                # 리턴하면 $2에 들어있는 내적합을 result에 저장한다.

        j main                                       # (종료를 위한 무한 반복 dummy code)

tpl:
                                                     # gen 블록의 첫번째 명령어로 그대로 복사
	li $2, 0                                     #  (참고) 내적의 누적합: $2

                                                     # 벡터의 i번째 원소에 대해 일부 명령어를 수정하여 복사
                                                     #   i=0, 1, 2, ..., size-1

        lw $13, 0($4)                                # ==> lw $13, i*4($4)         (참고) i*4($4) == vec2[i] !!
        li $12, 0                                    # ==> li $12, vec1[i]
        mul $12, $12, $13                            # ==> mul $12, $12, $13
        add $2, $2, $12                              # ==> add $2, $2, $12

        jr $31	                                     # gen 블록의 마지막 명령어로 그대로 복사

gen:	                                             # gen 라벨 다음 코드는 위 프로그램을
                                                     # 실행하면 만들어짐


	li $2, 0           # int gen(int *v)         # 내적의 누적합 = 0 

	lw $13, 0($4)      # {                       # 내적의 누적합 = 0 + vec1[0] * vec2[0] = 0 + 22*7
	li $12, 22         # int res = 0;
	mul $12, $12, $13  # res += 22 * v[0];
	add $2, $2, $12    # res += 25 * v[2];

                                                     # 내적의 누적합 = 0 + vec1[0] * vec2[0] 
                                                     #                 +  vec1[1] * vec2[1] = 0 + 22*7 + 0*429
                                                     #  코드가 생성되지 않음
                                                     #  왜냐하면 vec1[1]이 0이기 때문에 곱하기를 해봐야 결과는 0이므로 영항이 없음.

	lw $13, 8($4)      # return res;             # 내적의 누적합 = 0 + vec1[0] * vec2[0]
                                                     #                 + vec1[1] * vec2[1]
                                                     #                 +  vec1[2] * vec2[2] = 0 + 22*7 + 0*429 + 25*6
	li $12, 25         # }
	mul $12, $12, $13
	add $2, $2, $12

	jr $31
```

### C Program 동작 확인
```shell
git clone https://github.com/JNU-SoftwareLAB/SMC-Bench.git	#Bench Project Clone
cd ./SMC-Bench/src/asm/smc3
gcc smc3.c -o result 						#gcc compile
./result > result.log						#execute
## Ctrl + C 를 눌러 프로그램 종료
## result.log의 첫번째줄의 결과 확인  304가 출력되면 SMC 정상 작동

```