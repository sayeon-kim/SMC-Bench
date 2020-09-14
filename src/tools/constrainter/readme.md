# Static Pointer Analysis

## Dependency

- [nlohmann/json package](https://github.com/nlohmann/json)
- LLVM 10.0

# Constraint

```c++
/**
 * Constraint Type.
 * 1 => operand1 ∈ [[ operand2 ]]
 * 2 => [[ operand1 ]] ⊆ [[ operand2 ]]
 * 3 => for each c in [[ operand1 ]], c ∈ [[ operand2 ]]
 */
class Constraint{
  public:
    int Type;
    Operand* operand1;
    Operand* operand2;
    Operand* operand3;
    Operand* operand4;
  public:
    Constraint();
    Constraint(int Type, Operand* operand1=nullptr, Operand* operand2=nullptr, Operand* operand3=nullptr, Operand* operand4=nullptr);
    bool operator<(const Constraint& e) const;
};
 ```

 # Operand
 ```c++
 /**
  * Operand Type.
  * Token => std::string("Token")
  * Variable => std::string("Variable")
  */
 class Operand{
  public:
    std::string Type;
    std::string name;
  public:
    Operand();
    bool operator<(const Operand& e) const;
    virtual std::string toString();
};
 ```

# Instruction List

- Number of Instructions :  67 (llvm/include/llvm/IR/Instruction.def)

## Instructions related to Static Pointer Analysis
- numbers : 8

Opcode               | Instruction | Syntax | Constration | Remarks
:------:             | :---------: | :----: | :---------: | :-----:
31 | Alloca         | <result\> = alloca <type\> | alloca-i ∈ [[ result ]]] | Allocates memory on stack frame
32 | Load           | <result\> = load <ty\>, <ty\>* <pointer\> | 　for each c in [[pointer]], => [[c]]　⊆　[[result]]   | Read data from pointer
33 | Store          | store <ty\> <value\>, <ty\>* <pointer\> | for each c in [[value]] => [[c]] ⊆ [[pointer]] | Store data to pointer
34 | GetElementPtr  | <result\> = getelementptr <ty1\> <ty1\>* <ptrval\>{ <tyN\> <idx\>}*|  ptrval ∈ [[ result ]] | Get pointer pointing all elements. Tag(cell) or Pointer?
48 | IntToPtr       |<result\> = <ty\> <value\> to <ty2\> | if value is const　=>　value ∈ [[result]], <br> if value is var => [[value]] ⊆ [[result]] | Intger Value Cast Into Pointer
49 | BitCast        | <result\> = <ty\> <value\> to <ty2\>| value ∈ [[result]] | Same bit width, just change type.
56 | Call           | <result\> = call <ty\>\|<fnty> <fnptrval\> (<function args\>) | if ty or fnptrval is pointer type =><br>fnptrval(function args) ∈ [[result]] ?| Function Call <br> 09.12 spa_10.txt 312번째 줄. (잘 준비.)
64 | ExtractValue   | <result\> = extractvalue <aggregate type\> <val\>, <idx\>{, <idx\>}*| [[val]] ⊆ [[result]]   | get a value from aggregate data type by index. (cf. getelement ptr)

## I don't know
- numbers : 14

Opcode               | Instruction | Syntax | Constration | Remarks
:------:             | :---------: | :----: | :---------: | :-----:
6  | Resume      | resume <type\> <value\> | ? | Exception Handling Instruction
7  | Unreachable |                         | ? | Exception Handling Instruction
8  | CleanupRet  |                         | ? | Exception Handling Instruction
9  | CatchRet    |                         | ? | Exception Handling Instruction
10 | CatchSwitch |                         | ? |Exception Handling Instruction
36 | AtomicCmpXchg, AtomicCmpXchgInst | ? | ? | ?
37 | AtomicRMW      | ? | ? | ?
55 | PHI            | <result> = phi <ty\> [ <val0\>, <label0\>, ... <valK\>, <labelK\>], | [[val0]] ⊆ ... , [[valK]] ⊆ [[result]]  | SSA Instruction  보수적으로.
57 | Select         | <result\> = select selty <cond\>, <ty1\> <val1\>, <ty2\> <val2\> | [[val1] ⊆ [[result]], [[val2]]⊆ [[result]] | selty is i1 or < N x i1> => if true result <= value1, else result <= val2
60 | VAArg          | <resultval\> = va_arg <va_list*\> <arglist\>, <argty\> | ? | it is used to access arguments passed through the variable argument
63 | ShuffleVector  | | ? | make a new vector from two input vector.
65 | InsertValue    | <result\> = insertvalue <aggregate type\> <val\>, <ty\> <elt\>, <idx\>{, <idx\>}*| ? | insert value into aggregate type (cf. insertelement) 09.12 해야함.
66 | LandingPad     | | ? | Exception Handling Instruction
67 | Freeze         | | ? | ?

---
---
---
---

## Terminator Instructions
Opcode               | Instruction | Syntax | Constration | Remarks
:------:             | :---------: | :----: | :---------: | :-----:
1      | ret         |             | None   | return
2      | Br          |             | None   | branch another block            
3      | Switch      |             | None   | 
4      | IndirectBr  |             | None   |             
5      | Invoke      | %retval = invokew <ty\>\|<fnty\> <fnptrval\>(<function args\>) to label <normal label\> unwind label <exception label\> | ?      | Exception Handling Instruction
6  | Resume      | resume <type\> <value\> | ? | Exception Handling Instruction
7  | Unreachable |                         | ? | Exception Handling Instruction
8  | CleanupRet  |                         | ? | Exception Handling Instruction
9  | CatchRet    |                         | ? | Exception Handling Instruction
10 | CatchSwitch |                         | ? |Exception Handling Instruction
11 | CallBr      |                         | None  | goto

## Standard unary operators...
Opcode              | Instruction | Syntax | Constration | Remarks
:------:            | :---------: | :----: | :---------: | :-----:
12 | FNeg           | <result\> = fneg [fast-math flags]* <ty\> <op1\> | None | Float Instruction

## Standard binary operators...
Opcode              | Instruction | Syntax | Constration | Remarks
:------:            | :---------: | :----: | :---------: | :-----:
13 | Add            | | None | Integer Instruction
14 | FAdd           | | None | Float Instruction
15 | Sub            | | None | Integer Instruction
16 | FSub           | | None | Float Instruction
17 | Mul            | | None | Integer Instruction
18 | FMul           | | None | Float Instruction
19 | UDiv           | | None | Integer Instruction
20 | SDiv           | | None | Integer Instruction
21 | FDiv           | | None | Float Instruction
22 | URem           | | None | Integer Instruction
23 | SRem           | | None | Integer Instruction
24 | FRem           | | None | Float Instruction

## Logical operators...(Integer operands)
Opcode              | Instruction | Syntax | Constration | Remarks
:------:            | :---------: | :----: | :---------: | :-----:
25 | Shl            | | None | Integer Instruction
26 | LShr           | | None | Integer Instruction
27 | AShr           | | None | Integer Instruction
28 | And            | | None | Integer Instruction
29 | Or             | | None | Integer Instruction
30 | Xor            | | None | Integer Instruction

## Memory operators...
Opcode              | Instruction | Syntax | Constration | Remarks
:------:            | :---------: | :----: | :--------:  | :-----:
31 | Alloca         | <result\> = alloca <type\> | alloca-i ∈ [[ result ]]] | Allocates memory on stack frame
32 | Load           | <result\> = load <ty\>, <ty\>* <pointer\> | if ty is pointer type => [[result]] ⊆ [[pointer]] | Read data from pointer
33 | Store          | store <ty\> <value\>, <ty\>* <pointer\> | for each c in [[value]] => [[c]] ⊆ [[pointer]] | Store data to pointer
34 | GetElementPtr  | <result\> = getelementptr <ty1\> <ty1\>* <ptrval\>{ <tyN\> <idx\>}*|  ptrval{[tyN_idx]}+ ∈ [[ result ]] | Get pointer pointing a index element
35 | Fence          | | None | happens-before edge instruction
36 | AtomicCmpXchg, AtomicCmpXchgInst | ? | ? | ?
37 | AtomicRMW      | ? | ? | ?

## Cast operators...
Opcode              | Instruction | Syntax | Constration | Remarks
:------            | :--------- | :---- | :--------- | :-----
38 | Trunc          | | None | Truncates Integer Type
39 | ZExt           | | None | Integer type Instruction
40 | SExt           | | None | Integer Type Instruction
41 | FPToUI         | | None | Flot Type Instruction 
42 | FPToSI         | | None | Flot Type Instruction
43 | UIToFP         | | None | Get Flot Type Instruction
44 | SIToFP         | | None | Get Flot Type Instruction
45 | FPTrunc        | | None | Get Flot Type Instruction 
46 | FPExt          | | None | Get Flot Type Instruction
47 | PtrToInt       | | None | Get Integer Type Instruction
48 | IntToPtr       |<result\> = <ty\> <value\> to <ty2\> | value ∈ [[result]] | Intger Value Cast Into Pointer
49 | BitCast        | <result\> = <ty\> <value\> to <ty2\>| if ty2 is pointer => value ∈ [[result]] | Same bit width, just change type.
50 | AddrSpaceCast  | <result\> = addrespacecast <pty\> <ptrval\> to <pty2\> | for [[ptrval]] each memory cell e => m_e ∈ [[result]] | change address space of pointer. n to m. default is addresspace(0)* 09.12 이런 명령어들은 로그로 출력.

Opcode              | Instruction | Syntax | Constration | Remarks
:------:            | :---------: | :----: | :---------: | :-----:
51 | CleanupPad     |  | ? | Exception Handling Instruction
52 | CatchPad       | | ? | Exception Handling Instruction

## Other operators...
Opcode              | Instruction | Syntax | Constration | Remarks
:------:            | :---------: | :----: | :---------: | :-----:
53 | ICmp           | | None | Integer Compare Instruction
54 | FCmp           | | None | Float Compare Instruction
55 | PHI            | | ? | SSA Instruction 
56 | Call           | <result\> = call <ty\>\|<fnty> <fnptrval\> (<function args\>) | if ty or fnptrval is pointer type =><br>fnptrval(function args) ∈ [[result]] ?| Function Call
57 | Select         | <result\> = select selty <cond\>, <ty1\> <val1\>, <ty2\> <val2\> | ? | selty is i1 or < N x i1> => if true result <= value1, else result <= val2
58 | UserOp1        | | None | Interanl Instruction
59 | UserOp2        | | None | Internal Instruction
60 | VAArg          | <resultval\> = va_arg <va_list*\> <arglist\>, <argty\> | ? | it is used to access arguments passed through the variable argument
61 | ExtractElement | | None | return sclar type from vector
62 | InsertElement  | | None | insert sclar type into vector
63 | ShuffleVector  | | ? | make a new vector from two input vector.
64 | ExtractValue   | <result\> = extractvalue <aggregate type\> <val\>, <idx\>{, <idx\>}*| [[val]] ⊆ [[result]]   | get a value from aggregate data type by index. (cf. getelement ptr)
65 | InsertValue    | <result\> = insertvalue <aggregate type\> <val\>, <ty\> <elt\>, <idx\>{, <idx\>}*| ? | insert value into aggregate type (cf. insertelement)
66 | LandingPad     | | ? | Exception Handling Instruction
67 | Freeze         | | ? | ?

---
---
---
---

## Things to think

#### ? Instructions [ ]
- 
-
- 
- 

#### Global Variables [ ]
#### Loop [ ]
#### Function [ ]
#### Vector of Pointer [ ]