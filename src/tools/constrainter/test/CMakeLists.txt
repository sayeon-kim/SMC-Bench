cmake_minimum_required(VERSION 3.4.3)

list(APPEND TEST
  "getInstructionName"
  "getOperandName"
)

foreach(item ${TEST})
  add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/${item})
endforeach()