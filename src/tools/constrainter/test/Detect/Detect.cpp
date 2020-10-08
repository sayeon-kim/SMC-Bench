// Logic
// 1. Get All Variables can point address.
//    And Check that variables, is pointer type or not. 
//    -> 
//    Use, analysis::getAnswerVariables, analysis::getVariables.
// 2. Track All instructions using the pointerVariable.
//    And If there is instruction like write something, then print that
//    instruction -> getUnderlyingObjects
//    Here. 
//    ->
//    Use, analysis::findFunctionByName, analysis::findInstructionByName
// 

#include "Analysis.h"
#include "CubicSolver.hpp"

#include <iostream>
#include <map>
#include <vector>
#include <tuple>
#include <set>
#include <string>

#include "llvm/IR/Instruction.h"
#include "llvm/IR/DebugLoc.h"
#include "llvm/IR/DebugInfoMetadata.h"
#include "llvm/Passes/StandardInstrumentations.h"

using namespace std;
using namespace analysis;

void printInstructions(vector<llvm::Instruction*>* instructions)
{
  
  for(auto iter = instructions->begin(); iter != instructions->end(); iter++)
  {
    auto instruction = *iter;
    auto debuginfo = instruction->getDebugLoc();

    cout << "It can be critical instruction: ";
    cout << (string)instruction->getOpcodeName() << " ";

    if(debuginfo)
    {
      cout << "in line: " << debuginfo.getLine();
      cout << "\n";
    }
    else
    {
      // print operands
      for(auto oIter = instruction->op_begin(); oIter != instruction->op_end();
          oIter++)
      {
        auto operand = &*oIter->get();
        if(operand->hasName()){
          cout << (string)operand->getName() <<", ";
        } else{
          cout << "noNameOperand" <<", ";
        }
      }

      cout << "\n";
    }
    // cout << instruction->getDebugLoc().getLine();
  }
}

int main(int argc, char **argv)
{ 
  llvm::LLVMContext context;
  llvm::SMDiagnostic error;
  unique_ptr<llvm::Module> module = readModule(argv[1], error, context);

  // Variables.
  auto variables = getVariables(module.get());

  for(auto iter = variables->begin(); iter != variables->end(); iter++)
  {
    // loop function.

    // Answers.
    vector<llvm::Instruction*> criticialInstructions;

    string function_name = get<0>(*iter);
    llvm::Function *function_object = findFunctionByName(module.get(),
                                                         function_name);
 
    if(function_object == nullptr) continue;

    set<Operand> variables = get<1>(*iter);

    // Test code
    string h = function_object->getName();
    cout << h << "\n";

    for(auto iter2 = variables.begin(); iter2 != variables.end(); iter2++)
    {
      // Variables Iterating 

      auto variable = findVariableByName(function_object, iter2->name);
      
      if (variable == nullptr) continue;
      if (!variable->getType()->isPointerTy()) continue;

      auto usedInstructions = trackVariable(function_object, variable);

      for(auto uIter = usedInstructions.begin(); uIter != usedInstructions.end(); uIter++)
      {
        auto doubtInstruction = *uIter;
        // usedInstruction loop.
        switch(doubtInstruction->getOpcode())
        {
          case llvm::Instruction::Store :
          {
            criticialInstructions.push_back(doubtInstruction);
            break;
          }
          case llvm::Instruction::Call :
          {
            criticialInstructions.push_back(doubtInstruction);
            break;
          }
          default :
          {
            // maybe add in future.
          }
        }
      } // instruction using a variable loop.
    } // analysis Variable loop

    printInstructions(&criticialInstructions);

  } // analysis Function loop

  return 0;
} // main.