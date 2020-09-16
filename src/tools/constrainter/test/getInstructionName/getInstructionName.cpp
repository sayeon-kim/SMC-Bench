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

using namespace llvm;
using namespace std;

void printInstructionName(Instruction* I){
  outs() << I->getName() << "\n";
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
        printInstructionName(&*I);
      }
    }
  }

  return 0;
}