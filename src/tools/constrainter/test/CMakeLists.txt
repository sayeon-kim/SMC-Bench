cmake_minimum_required(VERSION 3.4.3)

list(APPEND TEST
  "getInstructionName"
  "getOperandName"
  "printConstraints"
  "cubicSolver"
  "cubicSolver2"
)

foreach(item ${TEST})
  add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/${item})
endforeach()

add_custom_target(cubicSolverTestFile ALL
  COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/test1.ll ${CMAKE_CURRENT_BINARY_DIR}/test1.ll
  COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/test2.ll ${CMAKE_CURRENT_BINARY_DIR}/test2.ll
  COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/test3.ll ${CMAKE_CURRENT_BINARY_DIR}/test3.ll
  COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/test4.ll ${CMAKE_CURRENT_BINARY_DIR}/test4.ll
)