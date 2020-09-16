cmake_minimum_required(VERSION 3.4.3)

SET(CMAKE_CXX_STANDARD 17)
SET(CMAKE_CXX_FLAGS "-Wall -fno-rtti -O0")

find_package(LLVM REQUIRED CONFIG)
project(Constraint)

include_directories("${PROJECT_SOURCE_DIR}")
include_directories("${PROJECT_SOURCE_DIR}/include")
include_directories("${LLVM_INCLUDE_DIRS}")

# add_definition(${LLVM_DEFINITIONS})
list(APPEND CMAKE_MODULE_PATH "${LLVM_CMAKE_DIR}")
include(AddLLVM)

message(STATUS "LLVM VERSION : ${LLVM_PACKAGE_VERSION}")
message(STATUS "Using LLVMConfig.cmake in: ${LLVM_DIR}")


set(LLVM_LINK_COMPONENTS
  Core
  Support
  IRReader
)

add_llvm_executable(Constraint
  main.cpp
  include/Analysis.cpp
)

add_subdirectory(${PROJECT_SOURCE_DIR}/test)