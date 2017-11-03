cmake_minimum_required(VERSION 3.8)

set(CMAKE_C_SIZEOF_DATA_PTR 8)
enable_language(ASM_NASM)
set(CMAKE_EXE_LINKER_FLAGS "-lc -arch x86_64")

add_executable(print64 print.nasm)
