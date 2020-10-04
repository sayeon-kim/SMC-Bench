#ifndef SMC_CUBICENGINE
#define SMC_CUBICENGINE

#include <string>
#include <set>
#include <vector>
#include <Analysis.h>
#include <cstdint>

// using analysis::Operand = analysis::analysis::Operand;
using namespace analysis;
using namespace std;

class Node;

class CubicEngine
{
public:
  set<analysis::Operand>* Variables;
  set<analysis::Operand>* Tokens;
  map<analysis::Operand, int>* tokenIndex;
  set<Node*>* Nodes;
  int tokenNumber;
  int indexNumber;
  // vector<string> functionName;

public:
  CubicEngine();
  void init(set<analysis::Operand>* tokens, set<analysis::Operand>* variables);
  Node* makeNode(analysis::Operand variable);
  // void add1Constraint();
  // void add2Constraint();
  // void add3Constraint();  
  // void add4Constraint();
  void run();
  // void printSolution();
  // void clear();
};

class Node
{
public:
  string name;
  vector<uint8_t>* bit_vector;
  set<Node*>* edges;

public:
  Node(analysis::Operand variable);
  bool operator<(const Node& rhs) const;
  bool checkNode(analysis::Operand variable, CubicEngine cubic);
  // int update();
};

Node* getOrPutNode(analysis::Operand variable, CubicEngine cubic);
int getTokenIndex(analysis::Operand token, CubicEngine cubic);

#endif // Header Guard.