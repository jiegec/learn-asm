bits 32
extern _printf
default rel
global _main

section .data
    fmt db "a = %d, fmt = %s, len = %d, f = %f", 0x0A, 0
    len equ $-fmt
    a dd 5
    f dd 3.1415926

section .bss

section .text
_main:
    push ebp
    mov ebp, esp
    and esp, 0xFFFFFFF0

    sub esp, 32
    mov eax, [f]
    mov [esp+16], eax
    mov [esp+12], dword len
    mov [esp+8], dword fmt
    mov eax, [a]
    mov [esp+4], eax
    mov [esp], dword fmt
    call _printf
    add esp, 32

    mov esp, ebp
    pop ebp

    mov eax, 0
    ret


