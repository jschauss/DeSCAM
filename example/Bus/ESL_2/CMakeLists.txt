cmake_minimum_required(VERSION 2.8)
project(Bus C CXX)

set(CMAKE_CXX_FLAGS  "${CMAKE_CXX_FLAGS} -std=c++11 ${LLVM_CXX_FLAGS} ")
set (CMAKE_MODULE_LINKER_FLAGS "-L/usr/lib -L/usr/local/lib   -rt -dl -tinfo -pthread -z")


include_directories(${CMAKE_SOURCE_DIR}/include)
link_directories(${CMAKE_SOURCE_DIR}/lib)
include_directories(${CMAKE_SOURCE_DIR}/example/Interfaces_new/)

include_directories(Interfaces_new)

FILE(GLOB R_SRC *.cpp *.hpp *.h)

add_executable(Bus_2 ${R_SRC})
target_link_libraries(Bus_2 systemc)


