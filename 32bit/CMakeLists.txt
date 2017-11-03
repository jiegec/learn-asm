cmake_minimum_required(VERSION 3.8)

set(CMAKE_C_SIZEOF_DATA_PTR 4)
enable_language(ASM_NASM)
set(CMAKE_EXE_LINKER_FLAGS "-lc -arch i386")

add_executable(print32 print.nasm)
