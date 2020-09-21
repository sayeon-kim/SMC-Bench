#include <iostream>
#include "CubicSolver.hpp"
#include "Analysis.h"
#include <map>
#include <vector>

int main(int argc, char **argv)
{
  // argv[1] is filename.
  auto moduleConstraints = analysis::run(argv[1]);
  // Cublic Solver
  std::vector<CubicSolver<analysis::Operand, analysis::Operand>> cubic_answer;
  
  // Constraints on Function
  for(auto FC = moduleConstraints->begin(); FC != moduleConstraints->end(); FC++)
  {
    CubicSolver<analysis::Operand, analysis::Operand> cubic;
    cubic.setFunctionName(FC->first);
    
    for(auto constraints = FC->second->begin(); constraints != FC->second->end(); constraints++)
    {
      auto constraint = *constraints;
      switch(constraint.Type){
        case 1:
        {
          cubic.addConstantConstraint(constraint.operand1, constraint.operand2);
          break;
        }
        case 2:
        {
          cubic.addSubsetConstraint(constraint.operand1, constraint.operand2);
          break;
        }
        case 3:
        {
          break;
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