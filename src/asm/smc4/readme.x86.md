```asm
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

-----------------------------------------------
< result code >

gen: 
	sw $8,0($4)              # to be generated
	jr $4               # to be generated
  
ggen: 
	jr $9   
```


step 0.

$9 = gen

step1.

$8 ← load instruction  '0xac880000 ' (sw $8,0($4))

step2.

 'sw $8,0($4)' is stored to gen

step3.

$8 ← load instruction  '0xac880008 ' (jr $4)

step4.

'jr $4' is stored to gen+4

step5.

 $4 = ggen

step6.

$9 = main

step7.

$8 ← load addr  ' 0x01200008 ' (jr $9)

step8.

jmp gen

step9.

nop is changed 'sw $8,0($4)'

so, ggen($4)  ← load instruction  'jr $9'

step10.

nop is changed  'jr $4'

so, jmp ggen($4)

step11.

nop is changed  'rj $9'

so, jmp main

This process is repeated.