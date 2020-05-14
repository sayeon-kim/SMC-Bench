	.text
main: la $9, gen        # get the target addr
      li $8, 0xac880000 # load Ec(sw $8,0($4))
      sw $8, 0($9)      # store to gen
      li $8, 0x00800008 # load Ec(jr $4)
      sw $8, 4($9)      # store to gen+4
      la $4, ggen       # $4 = ggen
      la $9, main       # $9 = main
      li $8, 0x01200008 # load Ec(jr $9) to $8
      j gen             # jump to target
      
gen:  nop               # to be generated
      nop               # to be generated
      
ggen: nop               # to be generated