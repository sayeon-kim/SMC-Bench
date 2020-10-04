// test Analysis

#include "Analysis.h"

#include <string>
#include <set>
#include <memory>
#include <fstream>
#include <iostream>
#include <memory>
#include <map>
#include <tuple>

#include <llvm/IR/Module.h>
#include <llvm/IRReader/IRReader.h>
#include <llvm/IR/LLVMContext.h>
#include <llvm/Support/SourceMgr.h>
#include <llvm/Support/MemoryBuffer.h>
#include <llvm/Support/raw_ostream.h>
#include <llvm/IR/Use.h>
#include "llvm/IR/Function.h"

using namespace std;
namespace analysis {
//===----------------------------------------------------------------------===//
// Operands
//===----------------------------------------------------------------------===//
// Operand
// Operand is Interface for expression.
Operand::Operand(){}

std::set<Operand>* Operand::Tokens = new std::set<Operand>();
std::set<Operand>* Operand::Variables = new std::set<Operand>();
std::set<pair<Operand,Operand>>* Operand::TokensAndVariables = new std::set<pair<Operand, Operand>>();

Operand::Operand(const Operand& rhs)
{
  this->Type = rhs.Type;
  this->name = rhs.name;
  if(rhs.tokens != NULL){
    tokens = new set<Operand>(*rhs.tokens);
  }
}

Operand::~Operand()
{
  if(tokens != NULL){
    delete tokens;
  }
}

bool Operand::operator<(const Operand& e) const
    {
      if( !(this->Type.compare(e.Type) == 0) ) return this->Type < e.Type;
      else return this->name < e.name;
    }

bool Operand::operator!=(const Operand& e) const
    { 
      if(this->Type.compare(e.Type) == false)return true;
      if(this->name.compare(e.name) == false)return true;
      return false;
    }

Operand& Operand::operator=(const Operand& e){
  delete tokens;
  this->Type = e.Type;
  this->name = e.name;

  if(e.tokens != NULL){
    this->tokens = new set<Operand>(*e.tokens);
  }

  return *this;
}
    

std::string Operand::toString() const
{
  if( (this->Type.compare("Token") == 0) ){
    return this->name;	
  }
  return "[[ " + this->name + " ]]";
}
//===----------------------------------------------------------------------===//
// Constraint
//===----------------------------------------------------------------------===//
/**
 * Constraint Type.
 * 1 => operand1 ∈ [[ operand2 ]]
 * 2 => [[ operand1 ]] ⊆ [[ operand2 ]]
 * 3 => for each c in [[ operand1 ]], c ∈ [[ operand2 ]]
 * 
 */
// std::set<Operand>* Constraint::Operands = nullptr;

Constraint::Constraint(){}

Constraint::~Constraint(){}

std::set<Constraint>* Constraint::Constraints = new std::set<Constraint>();

Constraint::Constraint(const Constraint& rhs)
{
  this->Type = rhs.Type;
  this->instruction = rhs.instruction;
  auto k = &*rhs.operand1;
  // this->operand1 = new Operand(&*rhs.operand1);
  this->operand1 = rhs.operand1;
  this->operand2 = rhs.operand2;
  this->operand3 = rhs.operand3;
  this->operand4 = rhs.operand4;
}

Constraint::Constraint(int Type, std::string instruction, Operand* operand1,
                      Operand* operand2, Operand* operand3, Operand* operand4)
{
  this->Type = Type;
  this->instruction = instruction;
  this->operand1 = operand1;
  this->operand2 = operand2;
  this->operand3 = operand3;
  this->operand4 = operand4;
}

bool Constraint::operator<(const Constraint& e) const{
  // if( !(this->Type == e.Type) ) return false;
  // if( !(this->operand1 == e.operand1) ) return false;
  // if( !(this->operand2 == e.operand2) ) return false;
  // if( !(this->operand3 == e.operand3) ) return false;
  // if( !(this->operand4 == e.operand4) ) return false;
  return true;
};

std::string Constraint::toString()
{
  std::string result = "";
  result += "Instruction: " + this->instruction + ", ";
  result += "Constraint-Type: " + std::to_string(this->Type) +",\t";
  switch(this->Type){
    case 1 :
    {
      result += this->operand1->toString();
      result += " ∈ ";
      result += this->operand2->toString();
      break;
    }
    case 2 :
    {
      result += this->operand1->toString();
      result += " ⊆ ";
      result += this->operand2->toString();
      break;
    }
    case 3 :
    {
      result += "for each c in ";
      result += this->operand1->toString() +", ";
            result += this->operand2->toString();
      result += " ⊆ [[ c ]]";
      break;
    }
    case 4 :
    {
      result += "for each c in ";
      result += this->operand1->toString() +", ";
      result += "[[ c ]] ⊆ ";
      result += this->operand2->toString();
      break;
    }
  }
  return result + "\n";
}


// //===----------------------------------------------------------------------===//
// // Functions
// //===----------------------------------------------------------------------===//

// /**
//  * tokens is a set, so No reason to check it is unique or not
//  */
Operand* makeToken(std::string name)
{
  Operand* t = new Operand();
  t->Type = "Token";
  t->name = name;
  Operand::Tokens->insert(*t);

  
  //Tokens map variable
  Operand* v = makeVariable(name);
  Operand::TokensAndVariables->insert({*t,*v});
  return t;
}

/**
 * variables is a set, so No reason to check it is unique or not
 */
Operand* makeVariable(std::string name) 
{
  Operand* v = new Operand();
  std::set<Operand>* tokensOfV = new std::set<Operand>();
  v->Type = "Variable";
  v->name = name;
  v->tokens = tokensOfV;
  Operand::Variables->insert(*v);
  return v;
}

/**
 * constraints is a set, so No reason to check it is unique or not
 */
Constraint* makeConstraint(int Type, std::string instruction,Operand* operand1,
                           Operand* operand2, Operand* operand3, Operand* operand4)
{
  Constraint* c = new Constraint(Type, instruction, operand1, operand2, operand3,
                                 operand4);
  Constraint::Constraints->insert(*c);
  return c;
}

void makeLLVMConstraint(llvm::Instruction* I)
{
  int opCode = I->getOpcode();
  switch(opCode){
    case llvm::Instruction::Alloca :
    {
      /** 
       * Only make once token.
       * Only make once variable.
       * So don't need to think more that token or variable is unique or not.
       */
      // std::string name = "alloca-" + std::to_string(alloca_number);
      std::string token_name = I->getName();
      std::string variable_name = I->getName();
      Operand *t = makeToken(token_name);
      Operand *v = makeVariable(variable_name);

      /** result ∈ [[ result ]]] */
      analysis::makeConstraint(1, "Alloca", t, v);

      alloca_number += 1;
      break;
    }
    case llvm::Instruction::Load : 
    {
      llvm::Use& instruction_op = *I->op_begin();
      std::string pointer_name = instruction_op->getName();
      std::string result_name = I->getName();

      Operand *v_pointer = makeVariable(pointer_name);
      Operand *v_result = makeVariable(result_name);

      /** for each c in [[ pointer ]], c ∈ [[ result ]]] */
      makeConstraint(4, "Load", v_pointer, v_result);
      break;
    }
    case llvm::Instruction::Store : 
    {
      auto K = I->op_begin();
      llvm::Use& value_operand = *K;
      K++;
      llvm::Use& pointer_operand = *K;

      std::string value_name = value_operand->getName();
      if(value_name.compare("")==0)value_name = "Constnat-Value";
      std::string pointer_name = pointer_operand->getName();
      
      Operand *v_value = makeVariable(value_name);
      Operand *v_pointer = makeVariable(pointer_name);
      
      /** for each c in [[ pointer ]], [[ value ]] ⊆ [[ c ]]] */
      makeConstraint(3, "Store", v_pointer, v_value);
      break;
    }
    case llvm::Instruction::GetElementPtr : 
    {
      auto K = I->op_begin();
      llvm::Use& ptrval_operand = *K;

      std::string result_name = I->getName();
      std::string ptrval_name = ptrval_operand->getName();

      Operand *v_result = makeVariable(result_name);
      Operand *t_ptrval = makeToken(ptrval_name);

      /** ptrval ∈ [[ result ]] */
      makeConstraint(1, "GetElementPtr", t_ptrval, v_result);
      break;
    }
    case llvm::Instruction::IntToPtr : 
    {
      auto K = I->op_begin();
      llvm::Use& value_operand = *K;

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
    case llvm::Instruction::BitCast : 
    {
      auto K = I->op_begin();
      llvm::Use& value_operand = *K;

      std::string result_name = I->getName();
      std::string value_name = value_operand->getName();
      if(value_name.compare("")==0)value_name = "Constnat-Value";

      Operand* v_result = makeVariable(result_name);
      Operand* t_value = makeToken(value_name);

      makeConstraint(1, "BitCast", t_value, v_result);
      break;
    }
    case llvm::Instruction::PHI:
    {
      std::string result_name = I->getName();
      Operand* v_result = makeVariable(result_name);
      for(auto K = I->op_begin(); K!=I->op_end(); K++){
        llvm::Use& value_operand = *K;
        std::string value_name = value_operand->getName();
        
        if(value_name.compare("")==0)value_name = "Constnat-Value";
        Operand* v_value = makeVariable(value_name);

        makeConstraint(2, "PHI", v_value, v_result);
      }
      break;
    }
    case llvm::Instruction::Call : 
    {
      // Todo.
      // ????
      // if return type is pointer then add result \in [[ result ]]
    }
    case llvm::Instruction::Select :
    {
      std::string result_name = I->getName();
      Operand* v_result = makeVariable(result_name);

      auto K = I->op_begin();
      if(K != I->op_end()) K++;

      for(K; K!=I->op_end(); K++)
      {
        llvm::Use& value_operand = *K;
        std::string value_name = value_operand->getName();
        
        if(value_name.compare("")==0)value_name = "Constnat-Value";
        Operand* v_value = makeVariable(value_name);

        makeConstraint(2, "Select", v_value, v_result);
      }
      break;
    }
    case llvm::Instruction::ExtractValue : 
    {
      auto K = I->op_begin();
      llvm::Use& value_operand = *K;

      std::string result_name = I->getName();
      std::string value_name = value_operand->getName();

      Operand* v_result = makeVariable(result_name);
      Operand* v_value = makeVariable(value_name);

      makeConstraint(2, "ExtractValue", v_value, v_result);
      break;
    }
    case llvm::Instruction::InsertValue:
    {
      break;
    }
    default:
    {

    }
  }
}

std::unique_ptr<llvm::Module> readModule(std::string file_name, 
                            llvm::SMDiagnostic error, llvm::LLVMContext& context)
{
  std::unique_ptr<llvm::Module> module = 
                                  llvm::parseIRFile(file_name, error, context);
  if(!module)
  {
    llvm::errs() << "Can't read file\n";
    return nullptr;
  }
  return module;
}

void clear()
{
  alloca_number = 1;
  Operand::Tokens->clear();
  Operand::Variables->clear();
  Operand::TokensAndVariables->clear();
  Constraint::Constraints->clear();
}

void giveName(llvm::Function &F){
	// Clear Tokens, Variables, Constrations
	int counter = 0;
	if (F.hasName()) {

		for (auto I = F.begin(); I != F.end(); I++){
			llvm::BasicBlock* BB = &*I;
			if (BB->getName() == ""){
				BB->setName( "%"+ std::to_string(counter));
				counter++;
			};
			
			for(auto J = BB->begin(); J != BB->end(); J++){
				llvm::Instruction* II = &*J;
				if(!(II->getType()->isVoidTy())){
					II->setName("%" + std::to_string(counter));
					counter++;
				}
			}

		}

	}
}

std::string idToString(int id){
	switch(id){
		case 0: return "VoidTy";
						break;
		case 1: return "HalfTy";
						break;
		case 2: return "FloatTy";
						break;
		case 3: return "DoubleTy";
						break;
		case 4: return "X86_FP80Ty";
						break;
		case 5: return "FP128Ty";
						break;
		case 6: return "PPC_FP128Ty";
						break;
		case 7: return "LabelTy";
						break;
		case 8: return "MetadataTy";
						break;
		case 9: return "X86_MMXTy";
						break;
		case 10: return "TokenTy";
						break;
		case 11: return "IntegerTy";
						break;
		case 12: return "FunctionTy";
						break;
		case 13: return "StructTy";
						break;
		case 14: return "ArrayTy";
						break;
		case 15: return "PointerTy";
						break;
		case 16: return "VectorTy";
	}
	return "Unknown Type";
}

std::string operandToString(int id)
{
	switch(id){
		case 0: return "∈";
		case 1: return "⊆";
	}
	return "Not Defined Operation.";
}

vector<tuple<string, set<Constraint>*, set<Operand>*, set<Operand>*, set<pair<Operand,Operand>>*>>* run(string file_name)
{
  llvm::LLVMContext context;
  llvm::SMDiagnostic error;
  vector<tuple<string, set<Constraint>*, set<Operand>*, set<Operand>*, set<pair<Operand,Operand>>*>>*
  result = new vector<tuple<string, set<Constraint>*, set<Operand>*, set<Operand>*, set<pair<Operand,Operand>>*>>();
  unique_ptr<llvm::Module> module = readModule(file_name, error, context);
  for (auto F = module->begin(); F != module->end(); F++) 
  {

    for (auto B = F->begin(); B != F->end(); B++)
    {
      // Basic Blocks
      std::string block_name = B->getName();

      for(auto I = B->begin(); I != B->end(); I++)
      {
        makeLLVMConstraint(&*I);
      }
    }
    string function_name = F->getName();
    set<Constraint>* save_constraints = new std::set<Constraint>(*Constraint::Constraints);
    set<Operand>* save_tokens = new std::set<Operand>(*Operand::Tokens);
    set<Operand>* save_variables = new std::set<Operand>(*Operand::Variables);
    set<pair<Operand,Operand>>* tokens_variables = new set<pair<Operand,Operand>>(*Operand::TokensAndVariables);
    auto k = make_tuple(function_name, save_constraints, save_tokens, save_variables, tokens_variables);
    result->push_back(k);
    clear();
  }    
  return result;
}

} // namespace analysis
