; test code for Anderson's algorithm
; store. 추가되는 값이, pointer의 모든 token의 variable에 대하여 추가된다.
; load. 불러와지는 값이, pointer의 모든 token의 variable 값을 가진다.


; alloca, 1, alloca_ins1 ∈ [[alloca_ins1]]
; alloca, 1, alloca_ins1 ∈ [[alloca_ins2]]

; store, 3, [[1]] ⊆ [[alloca_ins1]]
; store, 3, [[2]] ⊆ [[alloca_ins2]]

; load, 4, [[1]] ⊆ [[load_ins1]], [[alloca_ins1]] ⊆ [[load_ins1]]
; load, 4, [[2]] ⊆ [[load_ins2]], [[alloca_ins2]] ⊆ [[load_ins2]]

; store, 3, [[x]] ⊆ [[1]], [[x]] ⊆ [[alloca_ins1]]
; store, 3, [[y]] ⊆ [[1]], [[y]] ⊆ [[alloca_ins1]]
; store, 3, [[z]] ⊆ [[1]], [[z]] ⊆ [[alloca_ins1]]

; store, 3, [[load_ins2]] ⊆ [[alloca_ins1]], [[2]] ⊆ [[alloca_ins1]]

; Result
; [[alloca_ins1]] = { alloca_ins1, alloca_ins2, [[1]], [[2]] }
; [[x]] = { alloca_ins1 }
; [[y]] = { alloca_ins1 }
; [[z]] = { alloca_ins1 }
; [[1]] = ?
; [[2]] = ?

; Todo.
; 1. 상수 (1) 같은건 어떻게 처리할지?
; 2. alloca_ins1 ∈ [[alloca_ins1]] 가 정말 맞는지?
; 3. Token이 없이, Variable 만 있는건 어떻게 해야하는지.

define dso_local i32 @main() {
  entry:
    ; alloca instructions
    %alloca_ins1 = alloca i8
    %alloca_ins2 = alloca i8
    store i8 1, i8* %alloca_ins1
    store i8 2, i8* %alloca_ins2
    
    %load_ins1 = load i8, i8* %alloca_ins1 ; 1
    %load_ins2 = load i8, i8* %alloca_ins2 ; 1
    
    %x = add i8 %load_ins1, 2
    %y = add i8 %load_ins1, 3
    %z = add i8 %load_ins1, 4

    store i8 %x, i8* %alloca_ins1
    store i8 %y, i8* %alloca_ins1
    store i8 %z, i8* %alloca_ins1

    store i8 %load_ins2, i8* %alloca_ins1;
      
    ret i32 0
}