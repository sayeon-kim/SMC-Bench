// read ll file and return constrations for pointer analysis by json.

#include <nlohmann/json.hpp>
#include <Analysis.h>

#include <string>
#include <fstream>
#include <iostream>
#include <memory>
#include <string>
#include <set>

#include <llvm/IR/Module.h>
#include <llvm/IRReader/IRReader.h>
#include <llvm/IR/LLVMContext.h>
#include <llvm/Support/SourceMgr.h>
#include <llvm/Support/MemoryBuffer.h>
#include <llvm/Support/raw_ostream.h>
#include <llvm/IR/Use.h>

using json = nlohmann::json;
using namespace analysis;
using namespace std;
using namespace llvm;

int alloca_number = 0;

std::set<Operand>* tokens = new std::set<Operand>();
std::set<Operand>* variables = new std::set<Operand>();
std::set<Constraint>* constraints = new std::set<Constraint>();

/**
 * tokens is a set, so No reason to check it is unique or not
 */
Operand* makeToken(string name)
{
  Operand* t = new Operand();
  t->Type = "Token";
  t->name = name;
  tokens->insert(*t);
  return t;
}

/**
 * variables is a set, so No reason to check it is unique or not
 */
Operand* makeVariable(string name) 
{
  Operand* v = new Operand();
  std::set<Operand>* tokensOfV = new set<Operand>();
  v->Type = "Variable";
  v->name = name;
  v->tokens = tokensOfV;
  variables->insert(*v);
  return v;
}

/**
 * constraints is a set, so No reason to check it is unique or not
 */
Constraint* makeConstraint(int Type, std::string instruction, Operand* operand1=nullptr,
                           Operand* operand2=nullptr, Operand* operand3=nullptr, Operand* operand4=nullptr)
{
  Constraint* c = new Constraint(Type, instruction, operand1, operand2, operand3, operand4);
  constraints->insert(*c);
  return c;
}



void makeLLVMConstraint(llvm::Instruction* I)
{
  int opCode = I->getOpcode();
  switch(opCode){
    case Instruction::Alloca :
    {
      /** 
       * Only make once token.
       * Only make once variable.
       * So don't need to think more that token or variable is unique or not.
       */
      std::string name = "alloca-" + std::to_string(alloca_number);
      std::string result_name = I->getName();
      Operand *t = makeToken(name);
      Operand *v = makeVariable(result_name);

      /** alloca-i ∈ [[ result ]]] */
      makeConstraint(1, "Alloca", t, v);

      alloca_number += 1;
      break;
    }
    case Instruction::Load : 
    {
      Use& instruction_op = *I->op_begin();
      std::string pointer_name = instruction_op->getName();
      std::string result_name = I->getName();

      Operand *v_pointer = makeVariable(pointer_name);
      Operand *v_result = makeVariable(result_name);

      /** for each c in [[ pointer ]], c ∈ [[ result ]]] */
      makeConstraint(3, "Load", v_pointer, v_result);
      break;
    }
    case Instruction::Store : 
    {
      auto K = I->op_begin();
      Use& value_operand = *K;
      K++;
      Use& pointer_operand = *K;

      std::string value_name = value_operand->getName();
      if(value_name.compare("")==0)value_name = "Constnat-Value";
      std::string pointer_name = pointer_operand->getName();
      
      Operand *v_value = makeVariable(value_name);
      Operand *v_pointer = makeVariable(pointer_name);
      
      /** for each c in [[ value ]], c ∈ [[ pointer ]]] */
      makeConstraint(3, "Store", v_value, v_pointer);
      break;
    }
    case Instruction::GetElementPtr : 
    {
      auto K = I->op_begin();
      Use& ptrval_operand = *K;

      std::string result_name = I->getName();
      std::string ptrval_name = ptrval_operand->getName();

      Operand *v_result = makeVariable(result_name);
      Operand *t_ptrval = makeToken(ptrval_name);

      /** ptrval ∈ [[ result ]] */
      makeConstraint(1, "GetElementPtr", t_ptrval, v_result);
      break;
    }
    case Instruction::IntToPtr : 
    {
      auto K = I->op_begin();
      Use& value_operand = *K;

      std::string result_name = I->getName();
      std::string value_name = value_operand->getName();

      /**
       * if value is const, then value ∈ [[ result ]]
       * if value is var, then [[ value ]] ⊆  [[ result ]] 
       */
      Operand* v_result = makeVariable(result_name);
      if(result_name.compare("")==0){
        Operand* t_value = makeToken(result_name);
        makeConstraint(1, "IntToPtr", t_value, v_result);
      } else {
        Operand* v_value = makeVariable(result_name);
        makeConstraint(2, "IntToPtr", v_value, v_result);
      }
      break;
    }
    case Instruction::BitCast : 
    {
      auto K = I->op_begin();
      Use& value_operand = *K;

      std::string result_name = I->getName();
      std::string value_name = value_operand->getName();
      if(value_name.compare("")==0)value_name = "Constnat-Value";

      Operand* v_result = makeVariable(result_name);
      Operand* t_value = makeToken(value_name);

      makeConstraint(1, "BitCast", t_value, v_result);
      break;
    }
    case Instruction::PHI:
    {
      std::string result_name = I->getName();
      Operand* v_result = makeVariable(result_name);
      for(auto K = I->op_begin(); K!=I->op_end(); K++){
        Use& value_operand = *K;
        std::string value_name = value_operand->getName();
        
        if(value_name.compare("")==0)value_name = "Constnat-Value";
        Operand* v_value = makeVariable(value_name);

        makeConstraint(2, "PHI", v_value, v_result);
      }
      break;
    }
    case Instruction::Call : 
    {
      // Todo.
      // ????
      // if return type is pointer then add result \in [[ result ]]
    }
    case Instruction::Select :
    {
      break;
    }
    case Instruction::ExtractValue : 
    {
      auto K = I->op_begin();
      Use& value_operand = *K;

      std::string result_name = I->getName();
      std::string value_name = value_operand->getName();

      Operand* v_result = makeVariable(result_name);
      Operand* v_value = makeVariable(value_name);

      makeConstraint(2, "ExtractValue", v_value, v_result);
      break;
    }
    case Instruction::InsertValue:
    {
      break;
    }
    default:
    {

    }
  }
}

int main(int argc, char **argv)
{
  LLVMContext context;
  SMDiagnostic error;
  unique_ptr<Module> module = parseIRFile(argv[1], error, context);
  // outs() << " 뭐라고 말을 좀 해봐. \n";
  if(!module)
  {
    errs() << "Can't read file\n";
    return 1;
  }
  // module -> dump();

  // loop Function
  for (auto F = module->begin(); F != module->end(); F++)
  {
    outs() << "Analysis Function : " << F->getName() << "\n";
    // loop Basicblock
    for (auto B = F->begin(); B != F->end(); B++)
    {
      // loop Instruction
      for (auto I = B->begin(); I != B->end(); I++)
      {
        makeLLVMConstraint(&*I);
      }
    }
  }

  for(auto CC = constraints->begin(); CC != constraints->end(); CC++){
    Constraint cons = *CC;
    outs() << cons.toString();
  }

  return 0;
}