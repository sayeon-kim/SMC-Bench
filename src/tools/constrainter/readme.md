---
Author: Yu JaeIL
Date: 2020-09-23
---

# Consraints
Instruction|Constraint|Syntax|
---|---|---|
alloca | result ∈ [[result] | <result\> = alloca <type\>
load | c ∈ [[pointer]] => [[c]] ⊆ [[result]] | <result\> = load [volatile] <ty\>, <ty\>* <pointer\>
store | c ∈ [[pointer]] => [[value]] ⊆ [[c]] | store [volatile] <ty\> <value\>, <ty\>* <pointer\>
getelementptr | ptrval ∈ [[result]] | <result\> = getelementptr <ty\>, <ty\>* <ptrval\> {, <ty\> idx}*
inttoptr | [[value]] ⊆ [[result]]  | <result\> = inttoptr <ty\> <value\> to <ty2\>
bitcast | [[value]] ⊆ [[result]]  | <result\> = bitcast <ty\> <value\> to <ty2\>
phi | [[val1]] ⊆ [[result]], [[val2]] ⊆ [[result]], ...| <result\> = phi <ty\> [ <val0\>, <label0\>], ...
call | [[return_ty_1]] ⊆ [[result]] | <result\> = call <ty\> <fnty\> <fnptrval\>(<function args\>)
select | [[val1]] ⊆ [[result]], [[val2]] ⊆ [[result]] | <result\> = select selty <cond\>, <ty\> <val1\>, <ty\> <val2\>
extractvalue | [[val]] ⊆ [[result]] | <result\> = extractvalue <aggregate type\> <val\>, <idx\>{, <idx\>}*
