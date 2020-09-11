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
    public:
        Operand();
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