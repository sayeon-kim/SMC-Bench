; test code for Anderson's algorithm
; store instructions
; *X1 = X2
; For each c \in Cells,
; c \in [[X1]]  =>  [[X2]] \subseteq [[c]]


define dso_local i32 @main() {
  entry:
    ; alloca instructions
    %alloca_ins1 = alloca i8
    store i8 1, i8* %alloca_ins1
    
    %load_ins1 = load i8, i8* %alloca_ins1 ; 1
    %x = add i8 %load_ins1, 2
    %y = add i8 %load_ins1, 3
    %z = add i8 %load_ins1, 4

    store i8 %x, i8* %alloca_ins1
    store i8 %y, i8* %alloca_ins1
    store i8 %z, i8* %alloca_ins1
      


    ret i32 0
}