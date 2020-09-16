// test Analysis

#include <string>
#include <set>
#include <memory>
#include "llvm/IR/Function.h"
#include <nlohmann/json.hpp>

using json = nlohmann::json;

namespace analysis {

class Operand{
  public:
    std::string Type;
    std::string name;
    std::set<Operand>* tokens = nullptr;
  public:
    Operand();
    bool operator<(const Operand& e) const;
    virtual std::string toString();
};

class Token : public Operand{
  public:
    static std::set<Token>* Tokens;
    std::string name;
  public:
    Token();
    
    Token(std::string tokenName);
    bool operator<(const Token& e) const;
    json toJson();
    std::string toString();
};

class Variable : public Operand{
  public:
    static std::set<Variable>* Variables;
    std::set<Token>* tokens;
    std::string name;

  public:
    Variable(std::string variableName);
    Variable();
    ~Variable();
    std::set<Token>* getTokens();
    bool operator<(const Variable& e) const;
    std::string toString();
    std::string toStringTokens();
};

enum OperatorCode{
  in=0,
  subseteq
  };

/**
 * Constraint Type.
 * 1 => operand1 ∈ [[ operand2 ]]
 * 2 => [[ operand1 ]] ⊆ [[ operand2 ]]
 * 3 => for each c in [[ operand1 ]], c ∈ [[ operand2 ]]
 * 
 */
class Constraint{
  public:
    int Type;
    std::string instruction;
    Operand* operand1;
    Operand* operand2;
    Operand* operand3;
    Operand* operand4;
  public:
    Constraint();
    Constraint(int Type, std::string instruction, Operand* operand1=nullptr, Operand* operand2=nullptr, Operand* operand3=nullptr, Operand* operand4=nullptr);
    bool operator<(const Constraint& e) const;
    std::string toString();
};

/// Constration
class Constration{
  public:
    std::string Type;
    bool condition;
    static std::set<Constration*> Constrations;
  public:
    Constration();
    virtual std::string toString();
    virtual bool update();
};

class ConsBinomial : public Constration{
  public:
    Operand* left_operand;
    Operand* right_operand;
    OperatorCode op;

  public:
    ConsBinomial(Operand* left_operand, Operand* right_operand, OperatorCode op, bool condition=true);
    bool update();
    bool update(bool condition);
    std::string toString();
};

class ConsIf : public Constration {
  public:
    Operand* if_left_operand;
    Operand* if_right_operand;
    Constration* cons;
    OperatorCode if_op;
  public:
    ConsIf(Operand* if_left_operand, Operand* if_right_operand, OperatorCode if_op, Constration* cons, bool condition = true);
    bool checkCondition();
    bool update();
    std::string toString();
};

void run();
void clear();
void giveName(llvm::Function &F);

std::string idToString(int id);
std::string operandToString(int id);
std::set<Token>* getTokens();
std::set<Variable>* getVariables();
bool checkToken(std::string check_string);

} // namespace