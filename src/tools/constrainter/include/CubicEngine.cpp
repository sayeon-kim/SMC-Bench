#include "CubicEngine.h"

#include <Analysis.h>
#include <map>
#include <set>

using namespace std;
using namespace analysis;

CubicEngine::CubicEngine(){}

// First.
// 모든 Token 들과, 모든 Variable 들이 먼저 들어와야 한다.
void CubicEngine::init(set<analysis::Operand>* tokens, set<analysis::Operand>* variables)
{
  // this->Tokens = tokens;
  // this->Variables = variables;
  // this->tokenNumber = this->Tokens->size();
  // this->tokenIndex = new map<analysis::Operand, int>();
  // this->Nodes = new set<Node*>();
  // this->indexNumber = 0;

  // auto iter = this->Tokens->begin();
  // for(int i = 0; i < this->tokenNumber; i++){
  //   auto token = *iter;
  //   this->tokenIndex->insert(pair<Operand, int>(token, i));

  //   iter++;
  // }
  // BitVector 만들고.
  // Node 업데이트 하는 방식을 만들어야 합니다.
}

Node* CubicEngine::makeNode(analysis::Operand variable)
{
  Node* node = new Node(variable);
  this->Nodes->insert(node);

  return node;
}

Node::Node(analysis::Operand variable)
{
  this->name = variable.name;
}

void CubicEngine::run()
{
  int condition = 0;
  int condition2 = 0;
  while(true)
  {
    if(condition < 1 && condition2 > 1)
    for(auto iter = this->Nodes->begin(); iter != this->Nodes->end(); iter++)
    {
      // condition += (*iter)->update();
    }

    if(condition < 1 ){
      condition2 += 1;
    } else {
      condition = 0;
      condition2 = 0;
    }

  }
}

bool Node::operator<(const Node& rhs) const
{
  if( this->name.compare(rhs.name) == 0)
  return false;
  else return true;
}

bool Node::checkNode(analysis::Operand variable, CubicEngine cubic)
{
    for(auto iter = cubic.Nodes->begin(); iter != cubic.Nodes->end(); iter++)
    {
      auto node = *iter;
      if(node->name.compare(variable.name) == 0)
      {
        return true;
      }
    }
    return false;
}

Node* getOrPutNode(analysis::Operand variable, CubicEngine cubic)
{
  for(auto iter = cubic.Nodes->begin(); iter != cubic.Nodes->end(); iter++){
    auto node = *iter;
    if(node->name.compare(variable.name) == 0){
      return node;
    }
  }
  return cubic.makeNode(variable);
}

int getTokenIndex(analysis::Operand token, CubicEngine cubic)
{
  auto iter = cubic.tokenIndex->find(token);
  if(iter == cubic.tokenIndex->end()){
    return -1;
  }
  else return iter->second;
}

// 노드 업데이트 하는 방법...
// edge 들만 업데이트 하면 된다.
// 그 이전에 규약식에서 token에 해당하는 비트백터만 업데이트 하고..