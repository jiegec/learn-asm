cmake_minimum_required(VERSION 3.8)
project(learn_asm C CXX)

enable_language(ASM_NASM)
set(CMAKE_ASM_NASM_LINK_EXECUTABLE "ld <FLAGS> <CMAKE_ASM_NASM_LINK_FLAGS> <LINK_FLAGS> <OBJECTS>  -o <TARGET> <LINK_LIBRARIES>")
set(CAN_USE_ASSEMBLER TRUE)
set(CMAKE_EXE_LINKER_FLAGS "-lc -arch x86_64")

add_executable(print print.nasm)
