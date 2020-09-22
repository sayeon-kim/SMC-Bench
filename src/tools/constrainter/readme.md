---
Author: Yu JaeIL
Date: 2020-09-21
---

# Instruction

Below 10 instructions can effect pointer or can be effected.

---
## **alloca**
- Reference: [alloca](https://llvm.org/docs/LangRef.html#alloca-instruction)
**syntax**
```
<result> = alloca <type>
```
**Andersn's Algorithm**
```c
result = alloc
```
**constraint**
```
alloca_i ∈ [[result]]
```
**example**
```llvm
%alloca_ins1 = alloca i32 ; alloca_ins1 type is i32*
%alloca_ins2 = alloca i64, align 4 ; alloca_ins2type is i64*
```
```
alloca-1 ∈ [[alloca_ins1]]
alloca-2 ∈ [[alloca_ins2]]
```

---
## **load**
- Reference: [load](https://llvm.org/docs/LangRef.html#load-instruction)
**syntax**
```
<result> = load [volatile] <ty>, <ty>* <pointer>
```
**Anderson's Algorithm**
```c
result = *pointer
```
**constraint**
```
For each c ∈ [[All Tokens]], 
  c ∈ [[pointer]] => [[c]] ⊆ [[result]]
```
**example**
```llvm
%alloca_ins1 = alloca i32
%load_ins1 = load i32, i32* %alloca_ins1
```
```
alloca-1 ∈ [[alloca_ins1]]
[[alloca-1]] ⊆ [[load_ins1]]
```

---
## **store**
- Reference: [store](https://llvm.org/docs/LangRef.html#store-instruction)

**syntax**
```
store [volatile] <ty> <value>, <ty>* <pointer>
```
**Anderson's Algorithm**
```c
*pointer = value
```
**constraint**
```
For each c in [[All tokens]],
  c in [[pointer]] => [[value]] ⊆ [[c]]
```

**example**
```llvm
%alloca_ins1 = alloca i32
%alloca_ins2 = alloca i32
store i32 16, i32* %alloca_ins1
%load_ins1 = load i32, i32* %alloca_ins1
store i32 %load_ins1, i32* %alloca_ins2
```
```
alloca-1 ∈ [[alloca_ins1]]
alloca-2 ∈ [[alloca_ins2]]
[[Constant value]] ⊆ [[alloca_ins1]] 
[[alloca-1]] ⊆ [[load_ins1]]
[[load_ins1]] ⊆ [[alloca-2]]
```

---
## **getelementptr**
- Reference: [getelementptr](https://llvm.org/docs/LangRef.html#getelementptr-instruction)

**syntax**
```
<result> = getelementptr <ty>, <ty>* <ptrval> {, <ty> idx}*
```
**Anderson's Algorithm**
```c
result = &ptrval
```
**constraint**
```
ptrval ∈ [[result]]
```

**example**
```llvm
%struct1 = type { i1, i8, i16, i32, i64}
%alloca_struct1 = alloca %struct1
%GEP_ins1 = %getelementptr %struct1, %struct1* %alloca_struct1, i32 0, i32 0
```
```
alloca-1 ∈ [[alloca_struct1]]
alloca_struct1 ∈ [[GEP_ins1]]
```

---
## **inttoptr**
- Reference: [inttoptr](https://llvm.org/docs/LangRef.html#inttoptr-to-instruction)

**syntax**
```
<result> = inttoptr <ty> <value> to <ty2>
```
**Anderson's Algorithm**
```c
result = value
```

**constraint**
```
[[value]] ⊆ [[result]] 
```
**example**
```llvm
%alloca_ins1 = alloca i32
store i32 1, i32* %alloca_ins1
%load_ins1 = load i32, i32* %alloca_ins1
%ITP_ins1 = inttoptr i8 1 to i16*
%ITP_ins2 = inttoptr i32 %load_ins1 to i16*
```

```
alloca-1 ∈ [[alloca_ins1]]
[[]] ⊆ [[alloca-1]]
[[]] ⊆ [[load_ins1]], [[alloca-1]] ⊆ [[load_ins1]]
[[]] ⊆ [ITP_ins1]
[[load_ins1]] ⊆ [[ITP_ins2]]
```

---
## **bitcast**
- Reference: [bitcast](https://llvm.org/docs/LangRef.html#bitcast-to-instruction)

- When ever ty is pointer type, ty2 can be pointer type.

**syntax**
```
<result> = bitcast <ty> <value> to <ty2>
```
**Anderson's Algorithm**
```c
result = value
```
**constraint**
```
[[value]] ⊆ [[result]] 
```
**example**
```llvm
%bitcast_ins1 = bitcast i32 8 to float
%bitcast_ins2 = bitcast i32* %ITP_ins2 to i32*
```

```
[[]] ⊆ [[bitcast_ins1]]
[[ITP_ins2]] ⊆ [[bitcast_ins2]]
```

---
## **phi**
- Reference: [phi](https://llvm.org/docs/LangRef.html#phi-instruction)

**syntax**
```
<result> = phi <ty> [ <val0>, <label0>], ...
```
**Anderson's Algorithm**
```c
label0:
  result = val0 // when result is where in block label0..
label1:
  result = val1 // when result is where in block label1..
```
**constraint**
```
[[val1]] ⊆ [[result]], [[val2]] ⊆ [[result]], ...
```
**example**
```llvm
loop:
  %indvar = phi i32 [0, %entry ], [ %nextindvar, %loop]
  %nextindvar = add i32 %indvar, 1
  br label %next
```

```
[[]] ⊆ [[indvar]], [[nextindvar]] ⊆ [[indvar]]
```

---
## **call**
- Reference [call](https://llvm.org/docs/LangRef.html#call-instruction)

**syntax**
```
<result> = call <ty>|<fnty> <fnptrval>(<function args>)
```
**Anderson's Algorithm**
```
result = return_ty
```
**constraint**
```
[[return_ty_1]] ⊆ [[result]]
```

**example**
```llvm
call void @functionTest() ; call_ins1
%call_ins2 = call i32 @functionTestSecond()
```

```
[[]] ⊆ [[call_ins2]]
```

---
## **select**
- Reference [select](https://llvm.org/docs/LangRef.html#select-instruction)

**syntax**
```
<result> = select selty <cond>, <ty> <val1>, <ty> <val2> 
selty is either i1 or {<N x i1>}
```
**Anderson's Algorithm**
```
if(cond){
  result = val1
} else {
  result = val2
}
```
**constraint**
```
[[val1]] ⊆ [[result]], [[val2]] ⊆ [[result]] 
```
**example**
```
%select_ins1 = select i1 true, i64* %alloca_ins4, i64* %alloca_ins5
%select_ins2 = select i1 false, i64 1234, i64 123
```

```
```

---
## **extractvalue**
- Reference [extractvalue](https://llvm.org/docs/LangRef.html#extractvalue-instruction)

**syntax**
```
<result> = extractvalue <aggregate type> <val>, <idx>{, <idx>}*
```
**Anderson's Algorithm**
```
result = val[idx]
```
**constraint**
```
[[val]] ⊆ [[result]]
```
**example**
```llvm
%extractvalue_ins1 = extractvalue %struct1 %load_ins1, 0
%extractvalue_ins2 = extractvalue %struct2 %load_ins2, 0, 1
```

```
[[load_ins1]] ⊆ [[extractvalue_ins1]]
[[load_ins2]] ⊆ [[extractvalue_ins2]]
```