#include "Analysis.h"
#include "CubicSolver.hpp"

#include <iostream>
#include <map>
#include <vector>
#include <tuple>

using namespace std;
using namespace analysis;

int main(int argc, char **argv)
{
  // argv[1] is filename.
  // Constraint about Module
  llvm::LLVMContext context;
  llvm::SMDiagnostic error;
  unique_ptr<llvm::Module> module = readModule(argv[1], error, context);

  auto moduleConstraints = analysis::run(module.get());

  // Cublic Solver
  
  // // cubic_answer.init(vec1, vec2)

  // // Constraints on Function
  for(auto FC = moduleConstraints->begin(); FC != moduleConstraints->end(); FC++)
  {
    auto function_name = get<0>(*FC);
    auto constraints = get<1>(*FC);
    auto tokens = get<2>(*FC);
    auto variables = get<3>(*FC);
    auto tokenAndVariables = get<4>(*FC);

    // Cubic Solver
    CubicSolver<analysis::Operand, analysis::Operand> cubic;
    cubic.init(tokenAndVariables);
    cubic.setFunctionName(function_name);

    
    // cubic.init(tokens, variables);
    // cout << "=======================\n";
    // cout << "Tokens.\n";
    // for(auto temp = tokens->begin(); temp != tokens->end(); temp++)
    // {
    //   auto temp_value = *temp;
    //   cout << temp_value.toString() << ", ";
    // }
    // cout << "\n=======================\n";

    // print Constraints
    cout << "=======================\n";
    cout << "Print Constraints:\n";
    for(auto iter = constraints->begin(); iter != constraints->end(); iter++)
    {
      auto constraint = *iter;
      cout << constraint.toString();
    }
    cout << "=======================\n";
    // Insert each Constraint into Cubic Engine
    for(auto iter = constraints->begin(); iter != constraints->end(); iter++)
    {
      // a Constraint.
      auto constraint = *iter;

      //Ander Algorithm Type 1,2,3,4
      switch(constraint.Type){
        case 1:
        {
          cubic.addConstantConstraint(*constraint.operand1, *constraint.operand2);
          break;
        }
        case 2:
        {
          cubic.addSubsetConstraint(*constraint.operand1, *constraint.operand2);
          break;
        }
        case 3:
        {
          /** for each c in [[ operand1 ]], c ∈ [[ operand2 ]]] */
          cubic.add3thConstraint(*constraint.operand1, *constraint.operand2);
          break;
        }
        case 4:
        {
          /** for each c in [[ operand1 ]], c ∈ [[ operand2 ]]] */
          cubic.add4thConstraint(*constraint.operand1, *constraint.operand2);
        }
        default :{
          // Not Defined Type.
        }
      };
    }
    cubic.print();

    // auto nodes = cubic.getAllNodes();

    // for(auto nodeIter = nodes.begin(); nodeIter != nodes.end(); nodeIter++){
    //   CubicSolver<Operand,Operand>::Node* node = *nodeIter;
    //   node->print();
    // }
  } // loop module

  return 0;
} // main