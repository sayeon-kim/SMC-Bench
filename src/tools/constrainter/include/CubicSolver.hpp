#pragma once
using namespace std;
#include <string>
#include <set>
#include <map>
#include <bitset>
#include <algorithm>
#include <list>
#include <vector>
#include <list>


template <typename V, typename T, bool cycleElimination = true>
class CubicSolver {
public:
  const static int bitsetLength = 100;
public:
  std::string functionName; 

public:
  class Node {
  public:
    Node();
    std::set<V> succ;
    std::set<V> pred;
    std::bitset<bitsetLength> tokenSol;
    std::map<int, std::set<std::pair<V, V>>> conditionals;
    std::set<V> vars;
    bool operator<(const Node& other);
    bool operator==(const Node& other);
    bool operator!=(const Node& other);
    set<int> getAllTokenInt();
    std::set<T> tokens;
    

  public: 
    // TEST FUNCTION
    void print();
  
  
  }; // inner class Node

  int lastTknId = -1;

  std::map<V, Node*> varToNode;
  std::map<T, int> tokenToInt;
  std::map<int, T> intToToken;
  std::map<T, V> tokenToVariable;

public:
  void init(set<pair<T,V>>* tokensAndVariables);
  void setFunctionName(std::string function_name);
  // Token t ∈ Variable x
  void addConstantConstraint(T t, V x);
  // Variable x ⊆ Variable y
  void addSubsetConstraint(V x, V y);
  // if token t ∈ Variable x, then Variablze y ⊆ Variable z
  void addConditionalConstraint(T t, V x, V y, V z);
  //for each Token c in Variable x, Variable y ⊆ Variable c
  void add3thConstraint(V x, V y);
  //for each Token c in Variable x, Variable c ⊆ Variable y
  void add4thConstraint(V x, V y);

  list<T> getAllTokens();
  set<Node*> getAllNodes();
  map<V, std::set<T>> getSolution();

  // TEST FUNCTION
  void print();

private:
  int nextTokenId();
  int getTokenInt(T& x);
  Node* getOrPutNode(V& x);
  std::list<Node*> detectPath(Node* from, Node* to);
  std::list<Node*> detectPathRec(set<Node*>& visited, Node* current, Node* from, Node* to);
  void collapseCycle(std::list<Node*> cycle);
  void addAndPropagateBits(std::bitset<bitsetLength> s, V x);
}; // class CubicSolver

template<typename V, typename T, bool cycleElimination>
inline void CubicSolver<V, T, cycleElimination>::init(set<pair<T,V>>* tokensAndVariables){
  for(auto iter = tokensAndVariables->begin(); iter != tokensAndVariables->end(); iter++){
    T t = iter->first;
    V v = iter->second;
    getTokenInt(t);
    getOrPutNode(v);
    tokenToVariable[t] = v;
  }
}

template<typename V, typename T, bool cycleElimination>
inline void CubicSolver<V, T, cycleElimination>::setFunctionName(std::string function_name)
{
  this->functionName = function_name;
}

template<typename V, typename T, bool cycleElimination>
inline CubicSolver<V, T, cycleElimination>::Node::Node()
{
}

template<typename V, typename T, bool cycleElimination>
inline set<int> CubicSolver<V, T, cycleElimination>::Node::getAllTokenInt(){
  
  set<int> tokens;
  std::string tokenSolString = tokenSol.to_string();
  reverse(tokenSolString.begin(), tokenSolString.end());
  
  for (int i = 0; i < (int)tokenSolString.length(); i++) {
    if (tokenSolString[i] == '1') {
      tokens.insert(i);
    }
  }
  return tokens;
}

template<typename V, typename T, bool cycleElimination>
inline bool CubicSolver<V, T, cycleElimination>::Node::operator<(const Node& other)
{
  return this < &other;
}

template<typename V, typename T, bool cycleElimination>
inline bool CubicSolver<V, T, cycleElimination>::Node::operator==(const Node& other)
{
  return this == &other;
}

template<typename V, typename T, bool cycleElimination>
inline bool CubicSolver<V, T, cycleElimination>::Node::operator!=(const Node& other)
{
  return !(this->operator==(other));
}

template<typename V, typename T, bool cycleElimination>
inline void CubicSolver<V, T, cycleElimination>::Node::print()
{
  cout << "현재 노드의 주소" << ' ' << this << '\n';
  std::cout << "현재 노드가 가지고 있는 변수들 : ";
  for_each(vars.begin(), vars.end(), [](V v) {
    std::cout << v.toString() << " ";
    });
  std::cout << '\n';

  std::cout << "현재 노드가 가지고 있는 토큰들 : ";
  for_each(tokens.begin(), tokens.end(), [](T t){
    std:: cout << t.toString() << " ";
  });
  std::cout << '\n';


  std::cout << "현재 노드가 가리키는 변수 : ";
  for_each(succ.begin(), succ.end(), [](V v) {
    std::cout << v.toString() << " ";
    });
  std::cout << '\n';

  std::cout << "토큰이 가지고 있는 제약조건들\n";
  for_each(conditionals.begin(), conditionals.end(), [](const std::pair<int, std::set<std::pair<V, V>>>& conditional) {
    int Key = conditional.first;
    
    std::set<std::pair<V, V>> condition = conditional.second;

    std::cout << "TOKEN " << Key << ": 가지고 있는 제약 조건들\n";
    for_each(condition.begin(), condition.end(), [](const std::pair<V, V>& temp) {
      std::cout << temp.first.toString() << " -> " << temp.second.toString() << '\n';

      });
    });
  cout << '\n';
}

template<typename V, typename T, bool cycleElimination>
inline int CubicSolver<V, T, cycleElimination>::nextTokenId()
{
  lastTknId += 1;
  return lastTknId;
}

template<typename V, typename T, bool cycleElimination>
inline int CubicSolver<V, T, cycleElimination>::getTokenInt(T& x)
{
  if (tokenToInt.find(x) == tokenToInt.end()) {
     tokenToInt[x] = nextTokenId();
    intToToken[lastTknId] = x;
   }  
  return tokenToInt[x];
}

template<typename V, typename T, bool cycleElimination>
inline typename CubicSolver<V,T,cycleElimination>::Node* CubicSolver<V, T, cycleElimination>::getOrPutNode(V& x)
{
  if (varToNode.find(x) == varToNode.end()) {
    CubicSolver<V, T, cycleElimination>::Node* newNode = new CubicSolver<V,T,cycleElimination>::Node();
    newNode->vars.insert(x);
    varToNode[x] = newNode;
   }
   
  return varToNode[x];
}

template<typename V, typename T, bool cycleElimination>
inline std::list<typename CubicSolver<V,T,cycleElimination>::Node*> CubicSolver<V, T, cycleElimination>::detectPath(Node* from, Node* to)
{
  set<Node*> visited;
  return detectPathRec(visited, from, from, to);
}

template<typename V, typename T, bool cycleElimination>
inline std::list<typename CubicSolver<V,T,cycleElimination>::Node*> CubicSolver<V, T, cycleElimination>::detectPathRec(set<Node*>& visited, Node* current, Node* from, Node* to)
{	
  if (current == to) {
    return list<Node*>(1, current);
  }
  else {
    visited.insert(current);
    list<Node*> toReturn;
    set<Node*> s;
    set<Node*> candidate;

    transform(current->succ.begin(), current->succ.end(), inserter(s, s.begin()), [&](V v) {
      return varToNode[v];
    });
    
    copy_if(s.begin(), s.end(), inserter(candidate, candidate.begin()), [&](Node* node) {
      return visited.find(node) == visited.end();
      });
    
    bool find = false;
    for_each(candidate.begin(), candidate.end(), [&](Node* node) {
      if (!find) {
        std::list<Node*> cycleVisited = detectPathRec(visited, node, from, to);
        if (!cycleVisited.empty()) {
          find = true;
          cycleVisited.push_back(current);
          for_each(cycleVisited.begin(), cycleVisited.end(), [&](Node* node) {
            toReturn.push_back(node);
            });
        }
      }
      });
    return toReturn;
  }
}

template<typename V, typename T, bool cycleElimination>
inline void CubicSolver<V, T, cycleElimination>::collapseCycle(std::list<Node*> cycle)
{	
  if (cycle.empty())return;
  Node* first = cycle.front();

  for_each(cycle.rbegin(), cycle.rend(), [&](Node* oldNode) {
    first->succ.insert(oldNode->succ.begin(), oldNode->succ.end());


    for_each(oldNode->conditionals.begin(), oldNode->conditionals.end(), [&](const pair<int, set<pair<V, V>>>& condition) {
      int key = condition.first;
      set<pair<V, V>> s = condition.second;
      first->conditionals[key].insert(oldNode->conditionals[key].begin(), oldNode->conditionals[key].end());
      });

    first->tokenSol |= oldNode->tokenSol;
    
    for_each(oldNode->vars.begin(), oldNode->vars.end(), [&](V v) {
      varToNode[v] = first;
      first->vars.insert(v);
      });
    });
    
}

template<typename V, typename T, bool cycleElimination>
inline void CubicSolver<V, T, cycleElimination>::addAndPropagateBits
                                                (std::bitset<bitsetLength> s, V x)
{ 
  Node* node = getOrPutNode(x);
  bitset<bitsetLength> old = node->tokenSol;
  bitset<bitsetLength> newTokens = (old | s);

  if (newTokens != old) {
    node->tokenSol |= s;
    bitset<bitsetLength>* diff = new bitset<bitsetLength>(newTokens & ~(old));
    string diff_string = diff->to_string();
    reverse(diff_string.begin(), diff_string.end());
    set<int> diff_set;

    for (int i = 0; i < (int)diff_string.length(); i++) {
      if (diff_string[i] == '1')diff_set.insert(i);
    }

    for_each(diff_set.begin(), diff_set.end(), [&](int key) {
      set<pair<V, V>> condition = node->conditionals[key];
      for_each(condition.begin(), condition.end(), [&](const std::pair<V, V>& constraint) {
        addSubsetConstraint(constraint.first, constraint.second);
        });
      }); 

    for_each(diff_set.begin(), diff_set.end(), [&](int key) {
      for (auto it = node->conditionals.begin(); it != node->conditionals.end(); it++) {
      }
      node->conditionals.erase(key);
      });

    for_each(node->succ.begin(), node->succ.end(), [&](V v) {
      addAndPropagateBits(newTokens, v);
      });
  }
  node = NULL;
 }


template<typename V, typename T, bool cycleElimination>
inline void CubicSolver<V, T, cycleElimination>::addConstantConstraint(T t, V x)
{
  std::bitset<bitsetLength> bs;
  int tokenInt = getTokenInt(t);
  bs.set(tokenInt, 1);
  addAndPropagateBits(bs, x);
}

template<typename V, typename T, bool cycleElimination>
inline void CubicSolver<V, T, cycleElimination>::addSubsetConstraint(V x, V y)
{
  Node* nx = getOrPutNode(x);
  Node* ny = getOrPutNode(y);
  if (nx != ny) {
    nx->succ.insert(y);
    addAndPropagateBits(nx->tokenSol, y);

    if (cycleElimination) {
      collapseCycle(detectPath(ny, nx));
    }
  }
}

template<typename V, typename T, bool cycleElimination>
inline void CubicSolver<V, T, cycleElimination>::addConditionalConstraint(T t, V x,
                                                                          V y, V z)
{
  Node* xn = getOrPutNode(x);
  int tokenInt = getTokenInt(t);

  if (xn->tokenSol[tokenInt]) {
    addSubsetConstraint(y, z);
  }
  else if (y != z) {
    xn->conditionals[tokenInt].insert({ y,z });
  }
}

template<typename V, typename T, bool cycleElimination>
inline void CubicSolver<V, T, cycleElimination>::add3thConstraint(V x, V y){
  Node* nodex = getOrPutNode(x);
  getOrPutNode(y);
  // Analysis.h -> 토큰이름하고, 변수이름이 같은지.
  // 

  string tokenSolStr = nodex->tokenSol.to_string();
  reverse(tokenSolStr.begin(), tokenSolStr.end());
  for(int i = 0; i < (int)tokenSolStr.length(); i++){
    if(i > lastTknId)break;
    T t = intToToken[i];
    V v = tokenToVariable[t];
    addConditionalConstraint(t,x,y,v);
  }
}

template<typename V, typename T, bool cycleElimination>
inline void CubicSolver<V, T, cycleElimination>::add4thConstraint(V x, V y){
  Node* nodex = getOrPutNode(x);
  getOrPutNode(y);
  string tokenSolStr = nodex->tokenSol.to_string();
  reverse(tokenSolStr.begin(), tokenSolStr.end());

  for(int i = 0; i < (int)tokenSolStr.length(); i++){
    if(i > lastTknId)break;
      T t = intToToken[i];
      V v = tokenToVariable[t];
      addConditionalConstraint(t,x,v,y);
    
  }
}

template<typename V, typename T, bool cycleElimination>
inline list<T> CubicSolver<V, T, cycleElimination>::getAllTokens(){
  list<T> tokens;

	for_each(tokenToInt.begin(), tokenToInt.end(), [&] (const std::pair<T, int>& t)
  {
    tokens.push_back(t.first);
  });

  return tokens;
}

template<typename V, typename T, bool cycleElimination>
inline set<typename CubicSolver<V,T,cycleElimination>::Node*> CubicSolver<V, T, cycleElimination>::getAllNodes(){
  set<Node*> nodes;
  

  for(auto nodeiterater = varToNode.begin(); nodeiterater != varToNode.end(); nodeiterater++){
    V v = nodeiterater->first;
    Node* node = nodeiterater->second;
    
    set<int> tokenInts = node->getAllTokenInt();
    for(auto tokenintIter = tokenInts.begin(); tokenintIter != tokenInts.end();tokenintIter++){
      node->tokens.insert(intToToken[*tokenintIter]);
    }

    for(auto succIter = node->succ.begin(); succIter != node->succ.end(); succIter++){
      Node* succNode = varToNode[*succIter];
      if(node == succNode)continue;
      succNode->pred.insert(v);
    }

    nodes.insert(node);
  }

  return nodes;
}

template<typename V, typename T, bool cycleElimination>
inline map<V, std::set<T>> CubicSolver<V, T, cycleElimination>::getSolution()
{
  map<V, std::set<T>> ret;
  for_each(varToNode.begin(), varToNode.end(), [&](const pair<V, Node*>& t) {
    V key = t.first;
    Node* node = t.second;
    string tokenSol_str = node->tokenSol.to_string();
    reverse(tokenSol_str.begin(), tokenSol_str.end());
    ret[key]=set<T>();
    for (int i = 0; i < (int)tokenSol_str.length(); i++) {
      if (tokenSol_str[i] == '1') {
        ret[key].insert(intToToken[i]);
      }
    }
    });
  return ret;
}

/*
 * Print All tokens.
 * Print All Variables.
 * Print Solution.
 */
template<typename V, typename T, bool cycleElimination>
inline void CubicSolver<V, T, cycleElimination>::print()
{	
  map<V,set<T>> variables = this->getSolution();
  set<Node*> nodes = this->getAllNodes();
  auto tokens = this->getAllTokens();

  // for(auto it = nodes.begin(); it != nodes.end(); it++){
  //   (*it)->print();
  // }

  // print Function name.
  std::cout << "Function: " << this->functionName << "\n";
  
  // print All tokens.
  std::cout << "All Tokens = " << "{ ";
  for(auto token = tokens.begin(); token != tokens.end(); token++)
  {
    std::cout << (*token).toString() << ", ";
  }
    std::cout << "}\n";

  // print All Variables.
  std::cout << "All Variables = " << "{ ";
  for(auto var = varToNode.begin(); var != varToNode.end(); var++)
  {
    auto variable = var->first;
    std::cout << variable.toString() << ", ";
  }
  std::cout << "}\n";

  // print Solutions of Variables.
  std::cout << "Solution:\n";
  for(auto var = variables.begin(); var != variables.end(); var++)
  {
    auto variable = var->first;
    Node* node = varToNode[variable];
    std::cout << "\t" << variable.toString() << "= { ";
    
    set<T> tokenSet = var->second;
    set<V> variableSet = node->pred;

    if(tokenSet.empty()){
      cout << "?";
    }
    else{
      for (auto it = tokenSet.begin(); it != tokenSet.end(); it++) {
       cout << (*it).toString() << ", ";
      }
      for (auto it = variableSet.begin(); it != variableSet.end(); it++) {
       cout << (*it).toString() << ", ";
      }
    }
    cout << " }" << "\n";
  }
  std::cout << "====================\n";
}
 // end of cubicSolver::print()

// old print
// template<typename V, typename T, bool cycleElimination>
// inline void CubicSolver<V, T, cycleElimination>::print()
// {	
//   cout << "CubicSolver객체의 상세정보" << '\n';
//   for_each(varToNode.begin(), varToNode.end(), [](const pair<V*, Node*>& temp) 
//   {
//     V* key = temp.first;
//     Node* node = temp.second;
//     std::cout << "변수" << key << "가 속해있는 노드에 대한 설명 " << '\n';
//     node->print();
//     std::cout << '\n';
//     });

//   map<V*,set<T*>> temp = this->oetSolution();
//   for (auto it = temp.begin(); it != temp.end(); it++) {
//     cout << "변수" << (it->first) << "은 토큰 : ";
//     set<T*> s = it->second;

//     for (auto iit = s.begin(); iit != s.end(); iit++) {
//       cout << *iit << " ";
//     }
//     cout << "을 가지고 있다" << "\n";
//   }
  
// }