cmake_minimum_required(VERSION 3.8)
project(learn_asm C CXX)

set(CMAKE_ASM_NASM_LINK_EXECUTABLE "ld <FLAGS> <CMAKE_ASM_NASM_LINK_FLAGS> <LINK_FLAGS> <OBJECTS> -o <TARGET> <LINK_LIBRARIES>")
set(CAN_USE_ASSEMBLER TRUE)

add_subdirectory(32bit)
add_subdirectory(64bit)

set(CMAKE_CXX_STANDARD 17)
add_executable(jit jit.cpp)
