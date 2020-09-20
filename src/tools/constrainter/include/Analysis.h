// test Analysis

#ifndef SMC_ANALYSIS
#define SMC_ANALYSIS

#include <string>
#include <set>
#include <memory>
#include <fstream>
#include <iostream>
#include <memory>

#include <llvm/IR/Module.h>
#include <llvm/IRReader/IRReader.h>
#include <llvm/IR/LLVMContext.h>
#include <llvm/Support/SourceMgr.h>
#include <llvm/Support/MemoryBuffer.h>
#include <llvm/Support/raw_ostream.h>
#include <llvm/IR/Use.h>
#include "llvm/IR/Function.h"

namespace analysis {

static int alloca_number = 0 ;

//===----------------------------------------------------------------------===//
// Operands
//===----------------------------------------------------------------------===//
// Operand
// Operand is Interface for expression.
class Operand{
  public:
    static std::set<Operand>* Tokens;
    static std::set<Operand>* Variables;
    std::string Type;
    std::string name;
    std::set<Operand>* tokens = nullptr;
  public:
    Operand();
    Operand(const Operand& rhs);
    ~Operand();
    bool operator<(const Operand& e) const;
    std::string toString();
};


// enum OperatorCode{
//   in=0,
//   subseteq
// };

// //===----------------------------------------------------------------------===//
// // Constraint
// //===----------------------------------------------------------------------===//
// /**
//  * Constraint Type.
//  * 1 => operand1 ∈ [[ operand2 ]]
//  * 2 => [[ operand1 ]] ⊆ [[ operand2 ]]
//  * 3 => for each c in [[ operand1 ]], c ∈ [[ operand2 ]]
//  * 
//  */
class Constraint{
  public:
    static std::set<Constraint>* Constraints;
    int Type;
    std::string instruction;
    Operand* operand1;
    Operand* operand2;
    Operand* operand3;
    Operand* operand4;
  public:
    Constraint();
    Constraint(const Constraint& rhs);
    Constraint(int Type, std::string instruction, Operand* operand1,
                           Operand* operand2, Operand* operand3, Operand* operand4);
    ~Constraint();
    bool operator<(const Constraint& e) const;

    std::string toString();
}; // class Constraint

// //===----------------------------------------------------------------------===//
// // Functions
// //===----------------------------------------------------------------------===//

// /**
//  * tokens is a set, so No reason to check it is unique or not
//  */
Operand* makeToken(std::string name);

/**
 * variables is a set, so No reason to check it is unique or not
 */
Operand* makeVariable(std::string name);

/**
 * constraints is a set, so No reason to check it is unique or not
 */
Constraint* makeConstraint(int Type, std::string instruction,Operand* operand1=nullptr,
                           Operand* operand2=nullptr, Operand* operand3=nullptr,
                           Operand* operand4=nullptr);

void makeLLVMConstraint(llvm::Instruction* I);

std::unique_ptr<llvm::Module> readModule(std::string file_name);

std::set<Constraint>* run(std::string file_name);

void clear();

void giveName(llvm::Function &F);

std::string idToString(int id);

std::string operandToString(int id);

} // namespace analysis

#endif // Header Gaurd