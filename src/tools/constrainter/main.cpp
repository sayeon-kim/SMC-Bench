// read ll file and return constrations for pointer analysis by json.

#include <nlohmann/json.hpp>
#include <Analysis.h>

#include <string>
#include <fstream>
#include <iostream>
#include <memory>
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

Operand makeToken(string name){
  Operand t = Operand();
  t.Type = "Token";
  t.name = name;
  return t;
}

Operand makeVariable(string name){
  Operand v = Operand();
  v.Type = "Variable";
  v.name = name;
  return v;
}

int alloca_number = 0;

std::set<Operand*>* tokens = new std::set<Operand*>();
std::set<Operand*>* variables = new std::set<Operand*>();
std::set<Constration*>* contraint = new std::set<Constration*>();

void makeContraint(int Instruction){
  switch(Instruction){
    case Instruction::Alloca :
    {

      alloca_number += 1;
    }
    case Instruction::Load : 
    {

    }
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
=======
    case Instruction::Store :{

    }
>>>>>>> db475d8fb4741f390df6ca6e57acd1d9a19a648b
=======
    case Instruction::Store :{

    }
>>>>>>> a42c536a733b5bf75ee1665d5b974af9850452e5
=======
    case Instruction::Store :{

    }
>>>>>>> 92b8741bcf7755fdef7dbb6c446b4bdd3d9c47ad
    case Instruction::GetElementPtr : 
    {

    }
    case Instruction::IntToPtr : 
    {

    }
    case Instruction::BitCast : 
    {

    }
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
    case Instruction::AddrSpaceCast : 
    {

    }
=======
>>>>>>> db475d8fb4741f390df6ca6e57acd1d9a19a648b
=======
>>>>>>> a42c536a733b5bf75ee1665d5b974af9850452e5
=======
>>>>>>> 92b8741bcf7755fdef7dbb6c446b4bdd3d9c47ad
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
        makeContraint(InstructionCode);
        // loop Operands
        for (auto O = I->op_begin(); O != I->op_end(); O++)
        {
        }
      }
    }
  }

  return 0;
}