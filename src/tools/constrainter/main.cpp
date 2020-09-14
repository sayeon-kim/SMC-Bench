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

using json = nlohmann::json;
using namespace analysis;
using namespace std;
using namespace llvm;

int alloca_number = 0;

std::set<Operand*>* tokens = new std::set<Operand*>();
std::set<Operand*>* variables = new std::set<Operand*>();
std::set<Constraint*>* contraints = new std::set<Constraint*>();

Operand* makeToken(string name){
  Operand t = Operand();
  t.Type = "Token";
  t.name = name;
  tokens->insert(&t);
  return &t;
}

Operand* makeVariable(string name){
  Operand v = Operand();
  v.Type = "Variable";
  v.name = name;
  variables->insert(&v);
  return &v;
}

Constraint* makeConstraint(int Type, Operand* operand1=nullptr, Operand* operand2=nullptr, Operand* operand3=nullptr, Operand* operand4=nullptr){
  Constraint c = Constraint(Type, operand1, operand2, operand3, operand4);
  contraints->insert(&c);
  return &c;
}



void makeLLVMContraint(llvm::Instruction* I){
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

      makeConstraint(1, t, v);

      alloca_number += 1;
      break;
    }
    case Instruction::Load : 
    {

    }
    case Instruction::Store :{

    }
    case Instruction::GetElementPtr : 
    {

    }
    case Instruction::IntToPtr : 
    {

    }
    case Instruction::BitCast : 
    {

    }
    case Instruction::AddrSpaceCast : 
    {

    }
    case Instruction::Call : 
    {

    }
    case Instruction::ExtractValue : 
    {

    }
    default:
    {

    }
  }
}

int main(){
  LLVMContext context;
  SMDiagnostic error;
  unique_ptr<Module> module = parseIRFile("HelloWorld.ll", error, context);
  if(!module)
  {
    errs() << "Can't read file\n";
    return 1;
  }
  // module -> dump();

  // loop Function
  for (auto F = module->begin(); F != module->end(); F++)
  {
    // loop Basicblock
    for (auto B = F->begin(); B != F->end(); B++)
    {
      // loop Instruction
      for (auto I = B->begin(); I != B->end(); I++)
      {
        int InstructionCode = I->getOpcode();
        

        // loop Operands
        for (auto O = I->op_begin(); O != I->op_end(); O++)
        {
        }
      }
    }
  }

  return 0;
}