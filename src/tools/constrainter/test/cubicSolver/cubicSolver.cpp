#include <iostream>
#include "CubicSolver.hpp"
#include "Analysis.h"
#include <map>
#include <vector>
#include <tuple>

int main(int argc, char **argv)
{
  // argv[1] is filename.
  // Constraint about Module
  auto moduleConstraints = analysis::run(argv[1]);
  
  // Cublic Solver
  
  
  // // cubic_answer.init(vec1, vec2)

  // // Constraints on Function
  for(auto FC = moduleConstraints->begin(); FC != moduleConstraints->end(); FC++)
  {
    // FC -> first => (string) Function name
    auto function_name = FC->first;
    // FC -> second => (set<constraint>) Iterator of Constraints at a Function.
    auto constraints_iter = std::get<0>(FC->second);
    auto tokens_function = std::get<1>(FC->second);

    CubicSolver<analysis::Operand, analysis::Operand> cubic;
    cubic.setFunctionName(function_name);

    std::cout << "Tokens.\n";
    for(auto temp = tokens_function->begin(); temp != tokens_function->end(); temp++)
    {
      auto temp_value = *temp;
      std::cout << temp_value.toString();
    }
    std::cout << "\n@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@\n";
    cubic.print();

    // print Constraints
    std::cout << "Print Constraints:\n";
    for(auto constraints = constraints_iter->begin(); constraints != constraints_iter->end(); constraints++)
    {
      auto constraint = *constraints;
      std::cout << constraint.toString();
    }

    // Insert each Constraint into Cubic Engine
    for(auto constraints = constraints_iter->begin(); constraints != constraints_iter->end(); constraints++)
    {
      // a Constraint.
      auto constraint = *constraints;

      // Ander Algorithm Type 1,2,3,4
      switch(constraint.Type){
        case 1:
        {
          // 
          cubic.addConstantConstraint(constraint.operand1, constraint.operand2);
          break;
        }
        case 2:
        {
          cubic.addSubsetConstraint
          (constraint.operand1, constraint.operand2);
          break;
        }
        case 3:
        {
          /** for each c in [[ operand1 ]], c ∈ [[ operand2 ]]] */
          cubic.add3thConstraint(constraint.operand1, constraint.operand2);
          break;
        }
        case 4:
        {
          /** for each c in [[ operand1 ]], c ∈ [[ operand2 ]]] */
          cubic.add4thConstraint(constraint.operand1, constraint.operand2);
        }
        default :{
          // Not Defined Type.
        }
      };
    }
    cubic.print();
  }

  return 0;
}