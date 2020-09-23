# SMC 코드 4번

#### Multilevel runtime code generation

```assembly
.text

main: 
	la $9, gen        # get the target addr
    li $8, 0xac880000 # load Ec(sw $8,0($4))
    sw $8, 0($9)      # store to gen
    li $8, 0x00800008 # load Ec(jr $4)
    sw $8, 4($9)      # store to gen+4
    la $4, ggen       # $4 = ggen
    la $9, main       # $9 = main
    li $8, 0x01200008 # load Ec(jr $9) to $8
    j gen             # jump to target
      
gen: 
	nop               # to be generated
    nop               # to be generated
      
ggen: 
	nop               # to be generated
```



먼저 gen의 addr가 $9에 load 된다. l$8에  0xac880000 값인  (sw $8,0($4)) 값이 load 된다. 그리고 그 값을 gen에 store 한다. l$8에 0xac880008 값인 (jr $4) 을  load 한다. 그리고 그 값을 $9인 gen 에 +4 한곳에 store 한다.
$4에 ggen addr를 저장 후-> $9에 main의 addr 저장한다. 그리고 $8의 값에 0x01200008 인 (jr $9)값 을 load 한다. gen의 위치로 jump 한다.

$8를 $4에 저장후 $4로 분기한다. 즉 , 앞에서 $4에 ggen 의 addr 를 저장했기 때문에,  ggen으로 분기 한다. 이때, $9에 main의 addr가 들어가있기에 이 프로그램은 다시 쭉 반복하고 다시 ggen 에서 main을 찾아 가는 순으로 반복 되어진다.


### C Program 동작 확인
```shell
git clone https://github.com/JNU-SoftwareLAB/SMC-Bench.git	#Bench Project Clone
cd ./SMC-Bench/src/asm/smc4
gcc smc4.c -o result 		                				#gcc compile
gdb ./result                                                #gdb execute
b *main+110                                                 #break
disass main                                                 #disass후 modifing 이전의 main의 memory 상태 확인.  (main+259 ~ main+302)
c
disass main                                                 #disass후 modifing 이후의 main의 memory 상태 확인. (main+266 ~ main+305)
```