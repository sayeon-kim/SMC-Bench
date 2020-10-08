cmake_minimum_required(VERSION 3.4.3)

list(APPEND TEST
  "getInstructionName"
  "getOperandName"
  "printConstraints"
  "cubicSolver"
  "cubicSolver2"
  "Detect"
)

foreach(item ${TEST})
  add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/${item})
endforeach()

add_custom_target(cubicSolverTestFile ALL
  COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/test1.ll ${CMAKE_CURRENT_BINARY_DIR}/test1.ll
  COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/test2.ll ${CMAKE_CURRENT_BINARY_DIR}/test2.ll
  COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/test3.ll ${CMAKE_CURRENT_BINARY_DIR}/test3.ll
  COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/smc1.c.ll ${CMAKE_CURRENT_BINARY_DIR}/smc1.c.ll
  COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/smc2.c.ll ${CMAKE_CURRENT_BINARY_DIR}/smc2.c.ll
  COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/smc3.c.ll ${CMAKE_CURRENT_BINARY_DIR}/smc3.c.ll
  COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/smc4.c.ll ${CMAKE_CURRENT_BINARY_DIR}/smc4.c.ll
  COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/smc5.c.ll ${CMAKE_CURRENT_BINARY_DIR}/smc5.c.ll
  COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/smc6.c.ll ${CMAKE_CURRENT_BINARY_DIR}/smc6.c.ll
  COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/smc7.c.ll ${CMAKE_CURRENT_BINARY_DIR}/smc7.c.ll
  COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/smc8.c.ll ${CMAKE_CURRENT_BINARY_DIR}/smc8.c.ll
  COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/smc9.c.ll ${CMAKE_CURRENT_BINARY_DIR}/smc9.c.ll
  COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/c_smc_42.ll ${CMAKE_CURRENT_BINARY_DIR}/c_smc_42.ll
  COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/c_smc_instruction_modifing.ll ${CMAKE_CURRENT_BINARY_DIR}/c_smc_instruction_modifing.ll
  COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/c_smc_reference_modifing.c.ll ${CMAKE_CURRENT_BINARY_DIR}/c_smc_reference_modifing.c.ll
  COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/c_smc_shell.ll ${CMAKE_CURRENT_BINARY_DIR}/c_smc_shell.ll
)