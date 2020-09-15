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