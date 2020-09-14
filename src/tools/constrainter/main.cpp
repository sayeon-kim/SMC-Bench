// read ll file and return constrations for pointer analysis by json.

#include <nlohmann/json.hpp>
#include <Analysis.h>

#include <string>
#include <fstream>
#include <iostream>
#include <memory>

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

void makeConstration(int Instruction){
  switch(Instruction){
    case 0:{}
    default:{}
  }
}

int main(){
  LLVMContext context;
  SMDiagnostic error;
  unique_ptr<Module> module = parseIRFile("test.ll", error, context);
  if(!module){
    errs() << "Can't read file\n";
    return 1;
  }
  // module -> dump();

  // loop Function
  for (auto F = module->begin(); F != module->end(); F++){
    // loop Basicblock
    for (auto B = F->begin(); B != F->end(); B++){
      // loop Instruction
      for (auto I = B->begin(); I != B->end(); I++){
        int InstructionCode = I->getOpcode();
        makeConstration(InstructionCode);
        // loop Operands
        for (auto O = I->op_begin(); O != I->op_end(); O++){
        }
      }
    }
  }

  return 0;
}

// cmake . -B./dest
// cmake --build ./dest
// ./dest/Constrainter