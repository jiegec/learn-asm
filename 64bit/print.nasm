bits 64
extern _printf
default rel

section .rodata
    fmt db "a = %ld, fmt = %s, len = %d, f = %f", 0x0A, 0
    len equ $-fmt
    a dq 5
    f dd 3.1415926

section .bss
    flttmp resq 1

section .text
global _main
_main:
    push rbp

    fld	dword [f]
    fstp qword [flttmp]

    mov rdi, fmt
    mov rsi, [a]
    mov rdx, fmt
    mov rcx, len
    movq xmm0, qword [flttmp]
    mov rax, 1
    call _printf

    pop rbp

    mov rax, 0
    ret


