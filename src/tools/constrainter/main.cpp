// read ll file and return constrations for pointer analysis by json.
#include <string>
#include <Analysis.h>

int main(int argc, char **argv)
{
  analysis::run(argv[1]);
  return 0;
}