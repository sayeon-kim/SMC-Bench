// read ll file and return constrations for pointer analysis by json.
#include <iostream>
#include <Analysis.h>
#include <map>
#include <tuple>

int main(int argc, char **argv)
{
  auto k = analysis::run(argv[1]);
  for(auto item = k->begin(); item != k->end(); item++)
  {    
    // print function name
    std::cout << item->first << "\n";
    auto t2 = item->second;
    auto t = std::get<0>(t2);
    for(auto i = t->begin(); i != t->end(); i++)
    {
      auto constraint = *i;
      std::cout << constraint.toString();
    }
  }
  return 0;
}