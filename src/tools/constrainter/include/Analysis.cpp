// // File Descriptions

#include<Analysis.h>
#include <set>
#include <string>
#include <iostream>
#include <cstddef>

#include "llvm/IR/Function.h"
#include "llvm/IR/BasicBlock.h"
#include "llvm/IR/Instruction.h"

#include <nlohmann/json.hpp>

using json = nlohmann::json;

namespace analysis{

//===----------------------------------------------------------------------===//
// Operands
//===----------------------------------------------------------------------===//
// Operand
// Operand is Interface for expression.
Operand::Operand(){}

std::string Operand::toString(){
	return "Operand";
}

// Token
// Token is operand of expression. it represent a memory cell.
std::set<Token>* Token::Tokens = new std::set<Token>();

Token::Token(std::string tokenName){
	this->Type = "Token";
	this->name = tokenName;
	Token::Tokens->insert(*this);
}

bool Token::operator<(const Token& e) const {
	return this->name > e.name;
}

std::string Token::toString(){
	return this->name;
}

json Token::toJson(){
	json j;
	j["Type"] = this->Type;
	j["name"] = this->name;
	return j;
}



// Variable
// Variable is operand of expression. it represent a set of token.

std::set<Variable>* Variable::Variables = new std::set<Variable>();

Variable::Variable(std::string varName){
	this->Type = "Variable";
	this->name = varName;
	this->tokens = new std::set<Token>();
	Variables->insert(*this);
}

Variable::~Variable(){
}

bool Variable::operator<(const Variable& e) const {
	return this->name > e.name;
}

std::set<Token>* Variable::getTokens(){
	return this->tokens;
}

std::string Variable::toString(){
	return this->name;
}
std::string Variable::toStringTokens(){
	std::string buffer = "";
	buffer += this->toString() + "= { ";
	for( Token i : *(this->getTokens())){
		buffer+= i.toString() + ", ";
	}	
	buffer += " }";
	return buffer;
}

//===----------------------------------------------------------------------===//
// Constrations
//===----------------------------------------------------------------------===//
// Constration
// Constration is interface for expression.
std::set<Constration*> Constration::Constrations = std::set<Constration*>();

Constration::Constration(){}

std::string Constration::toString(){
	return "Constration";
}

bool Constration::update(){
	return false;
}

// ConsBinomial
// ConsBinomial express Binomial operation.

ConsBinomial::ConsBinomial(Operand* left_operand, Operand* right_operand,
 						  OperatorCode op, bool condition){
	this->left_operand = left_operand;
	this->right_operand = right_operand;
	this->op = op;
	this->condition = condition;
	Constration::Constrations.insert(this);
}

bool ConsBinomial::update(){
	// Check Condition
	if (!(this->condition)) return false;
	// Check whether defined operation or not.
	// Token ∈ Variable
	if( !(*left_operand).Type.compare("Token")
		&& !(*right_operand).Type.compare("Variable") && op == OperatorCode::in) {
		// Type Upcasting.
		Token* left_token = static_cast<Token*>(left_operand);
		Variable* right_variable = static_cast<Variable*>(right_operand);

		std::set<Token>* right_variable_tokens = right_variable->getTokens();

		std::size_t length_before = right_variable_tokens->size();

		right_variable_tokens->insert(*left_token);

		std::size_t length_after = right_variable_tokens->size();

		if(length_before != length_after){ return true;}
		return false;
	}
	// Variable1 ⊆ Variable2
	else if( !(*left_operand).Type.compare("Variable") 
					&& !(*right_operand).Type.compare("Variable") 
					&& op == OperatorCode::subseteq) {
		// Type Upcasting.
		Variable* left_variable = static_cast<Variable*>(left_operand);
		Variable* right_variable = static_cast<Variable*>(right_operand);
		std::set<Token>* left_variable_tokens = left_variable->getTokens();
		std::set<Token>* right_variable_tokens = right_variable->getTokens();
		
		int length_before = right_variable_tokens->size();
		for(auto& i : *left_variable_tokens){
			right_variable_tokens->insert(i);
		}

		int length_after = right_variable_tokens->size();

		if(length_before != length_after){ return true;}
		else{ return false; }
	}
	// add more Operation.

	// Not Defined Operation.
	std::cout << "Not defined Operations" << "\n";
	// throw this;
}

std::string ConsBinomial::toString(){
	return this->left_operand->toString() + "\t" + operandToString(this->op) 
			+ "\t" + this->right_operand->toString();
}

// ConsIf
// ConsIf express if condtional binomial constration.
// todo Think more. but now it is okay. it works.
ConsIf::ConsIf(Operand* if_left_operand, Operand* if_right_operand, 
			   OperatorCode if_op, Constration* cons, bool condition){
	this->if_left_operand = if_left_operand;
	this->if_right_operand = if_right_operand;
	this->if_op = if_op;
	this->cons = cons;
	this->condition = condition;

	Constration::Constrations.insert(this);
}

bool ConsIf::checkCondition(){
	// Token ∈ Variable
	if( !if_left_operand->Type.compare("Token")
		&& !if_right_operand->Type.compare("Variable") && if_op == OperatorCode::in) {
		// Down Casting
		Token* if_left_token = static_cast<Token*>(if_left_operand);
		Variable* if_right_variable = static_cast<Variable*>(if_right_operand);
		std::set<Token>* if_right_variable_tokens = if_right_variable->getTokens();

		// Check
		auto answer = if_right_variable_tokens->find(*if_left_token);
		if ( answer != if_right_variable_tokens->end()) return true;
		return false;
	}
	// Variable1 ⊆ Variable2
	else if (!if_left_operand->Type.compare("Variable") 
					&& !if_right_operand->Type.compare("Variable") 
					&& if_op == OperatorCode::subseteq) {
		// Down Casting
		Variable* if_left_variable = static_cast<Variable*>(if_left_operand);
		Variable* if_right_variable = static_cast<Variable*>(if_right_operand);
		std::set<Token>* if_right_variable_tokens = if_right_variable->getTokens();
		std::set<Token>* if_left_variable_tokens = if_left_variable->getTokens();

		// Have to Fix.
		bool condition = false;
		for( auto i : *if_left_variable_tokens){
			for( auto j : *if_right_variable_tokens){
				if(i.toString() == j.toString()){ condition = true;}
			}
			if(condition == false)return false;
			condition = false;
		}
		// Check
		return true;
	}
	
	std::cout << "Not Defined Condition" << "\n";
	// throw this;
}

bool ConsIf::update(){
	// Have to Fix
	if(this->checkCondition()){
		this->cons->condition = true;
		bool updateResult = this->cons->update();
		this->cons->condition = false;
		return updateResult;
	}
	return false;
}

std::string ConsIf::toString(){
	return "If: " + if_left_operand->toString() + "\t" + operandToString(this->if_op) 
	+ "\t" + if_right_operand->toString() + "\n\tThen: " + cons->toString();
}

//===----------------------------------------------------------------------===//
// Functions
//===----------------------------------------------------------------------===//
// getToekns return a set registered all of Tokens
std::set<Token>* getTokens(){
	return Token::Tokens;
}

// getVariables return a set registered all of Variables
std::set<Variable>* getVariables(){
	return Variable::Variables;
}

// run update every constrations till Nothing changed.
void run(){
	int runCondition;

	do{
		runCondition = 0;
		for( auto i : Constration::Constrations){
			runCondition += i->update();
		}
	} while(runCondition);

}

// delete every token, variable, constration at global scope.
void clear(){
	Token::Tokens->clear();
	Variable::Variables->clear();
	Constration::Constrations.clear();
}

std::string operandToString(int id){
	switch(id){
		case 0: return "∈";
		case 1: return "⊆";
	}
	return "Not Defined Operation.";
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

bool checkToken(std::string check_string){
	auto search = Token::Tokens->find(check_string);
	if(search != Token::Tokens->end()){
		return true;
	}
	return false;
}

bool checkVariable(std::string check_string){
	auto search = Variable::Variables->find(check_string);
	if(search != Variable::Variables-> end()){
		return true;
	}
	return false;
}

} // namespace