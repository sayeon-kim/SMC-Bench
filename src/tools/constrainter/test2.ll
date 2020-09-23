; test code for Anderson's algorithm
; store instructions
; *X1 = X2
; For each c \in Cells,
; c \in [[X1]]  =>  [[X2]] \subseteq [[c]]




; alloca_ins1 ∈ [[alloca_ins1]]
; [[1]] ⊆ [[alloca_ins1]]

; [[alloca_ins1]] ⊆ [[load_ins1]]
; [[1]] ⊆ [[x]], [[alloca_ins1]] ⊆ [[x]]
; [[1]] ⊆ [[y]], [[alloca_ins1]] ⊆ [[y]]
; [[1]] ⊆ [[y]], [[alloca_ins1]] ⊆ [[y]]

; [[x]] ⊆ [[1]], [[x]] ⊆ [[alloca_ins1]]
; [[y]] ⊆ [[1]], [[y]] ⊆ [[alloca_ins1]]
; [[z]] ⊆ [[1]], [[z]] ⊆ [[alloca_ins1]]

; Result
; [[alloca_ins1]] = { alloca_ins1 }
; [[x]] = { alloca_ins1 }
; [[y]] = { alloca_ins1 }
; [[z]] = { alloca_ins1 }
; [[1]] = ?

; Todo.
; 1. 상수 (1) 같은건 어떻게 처리할지?
; 2. alloca_ins1 ∈ [[alloca_ins1]] 가 정말 맞는지?
; 3. Token이 없이, Variable 만 있는건 어떻게 해야하는지.


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