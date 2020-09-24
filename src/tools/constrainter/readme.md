---
Author: Yu JaeIL
Date: 2020-09-23
---

# Consraints
Instruction|Constraint|Syntax| type |
---|---|---| --- |
alloca | result ∈ [[result] | <result\> = alloca <type\> | 1
load | c ∈ [[pointer]] => [[c]] ⊆ [[result]] | <result\> = load [volatile] <ty\>, <ty\>* <pointer\> | 4
store | c ∈ [[pointer]] => [[value]] ⊆ [[c]] | store [volatile] <ty\> <value\>, <ty\>* <pointer\> | 3
getelementptr | ptrval ∈ [[result]] | <result\> = getelementptr <ty\>, <ty\>* <ptrval\> {, <ty\> idx}* | 1
inttoptr | [[value]] ⊆ [[result]]  | <result\> = inttoptr <ty\> <value\> to <ty2\> | 2
bitcast | [[value]] ⊆ [[result]]  | <result\> = bitcast <ty\> <value\> to <ty2\> | 2
phi | [[val1]] ⊆ [[result]], [[val2]] ⊆ [[result]], ...| <result\> = phi <ty\> [ <val0\>, <label0\>], ... | 2
call | [[return_ty_1]] ⊆ [[result]] | <result\> = call <ty\> <fnty\> <fnptrval\>(<function args\>) | 2
select | [[val1]] ⊆ [[result]], [[val2]] ⊆ [[result]] | <result\> = select selty <cond\>, <ty\> <val1\>, <ty\> <val2\> | 2
extractvalue | [[val]] ⊆ [[result]] | <result\> = extractvalue <aggregate type\> <val\>, <idx\>{, <idx\>}* | 2
