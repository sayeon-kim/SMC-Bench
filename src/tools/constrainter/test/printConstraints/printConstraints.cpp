// read ll file and return constrations for pointer analysis by json.
#include <iostream>
#include <Analysis.h>
#include <map>
#include <tuple>

using namespace std;

int main(int argc, char **argv)
{
  auto k = analysis::run(argv[1]);
  for(auto item = k->begin(); item != k->end(); item++)
  {    
    // print function name
    cout << std::get<0>(*item) << "\n";
    auto t = get<1>(*item);

    for(auto i = t->begin(); i != t->end(); i++)
    {
      auto constraint = *i;
      std::cout << constraint.toString();
    }
    cout << "\n";
  }
  return 0;
}