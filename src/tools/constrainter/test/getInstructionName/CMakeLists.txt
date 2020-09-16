cmake_minimum_required(VERSION 3.4.3)

set(LLVM_LINK_COMPONENTS
  Core
  Support
  IRReader
)

add_llvm_executable(getInstructionName
  getInstructionName.cpp
)

add_custom_target(testFile ALL
  COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/test.ll ${CMAKE_CURRENT_BINARY_DIR}/test.ll
)