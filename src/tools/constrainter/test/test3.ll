define dso_local i32 @main() {
  entry:
    ; alloca instructions
    %alloca_ins1 = alloca i8
    %alloca_ins2 = alloca i8

    store i8 1, i8* %alloca_ins1
    store i8 2, i8* %alloca_ins2
    
    %load_ins1 = load i8, i8* %alloca_ins1 ; 1
    %load_ins2 = load i8, i8* %alloca_ins2 ; 1
    
    %x = add i8 %load_ins1, 2 ; 3
    %y = add i8 %load_ins1, 6 ; 7
    %z = add i8 %x, %load_ins2 ; 10

    store i8 %x, i8* %alloca_ins1
    store i8 %load_ins2, i8* %alloca_ins1;
      
    ret i32 0
}