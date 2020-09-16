// read ll file and return constrations for pointer analysis by json.
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

using namespace llvm;
using namespace std;

void printOperandName(Instruction* I){
  int counter = 0;
  for( auto K = I->op_begin(); K != I->op_end(); K++){
    counter++;
    I->getName();
    Use& OP = *K;
    if(OP->getName() == "")continue;
    outs() << I->getOpcodeName() << ": "<< counter << "th operand.: "<< OP->getName() << "\n";
  }
}

int main(){
  LLVMContext context;
  SMDiagnostic error;
  unique_ptr<Module> module = parseIRFile("test.ll", error, context);
  if(!module)
  {
    errs() << "Can't read file\n";
    return 1;
  }
  


  // loop Function
  for (auto F = module->begin(); F != module->end(); F++)
  {
    // loop Basicblock
    for (auto B = F->begin(); B != F->end(); B++)
    {
      // loop Instruction
      for (auto I = B->begin(); I != B->end(); I++)
      {
        printOperandName(&*I);
      }
    }
  }

  return 0;
}