bits 16

start:
    call clearScreen

    mov ax, 0x07c0
    mov ds, ax
    mov ax, 0xb800
    mov es, ax

    mov si, text
    mov di, 0
    mov cx, len

print1:
    mov al, [si]
    mov [es:di], al
    inc di
    mov byte [es:di], 0x07
    inc di
    inc si
    loop print1

    mov ax, 0
    mov cx, 100
sum:
    add ax, cx
    loop sum

    xor cx, cx
    mov ss, cx
    mov sp, cx

    mov bx, 10
digit:
    inc cx
    xor dx, dx
    div bx
    or dl, 0x30
    push dx
    cmp ax, 0
    jne digit

print2:
    pop dx
    mov [es:di], dl
    inc di
    mov byte [es:di], 0x07
    inc di
    loop print2

    jmp near $

clearScreen:
    pusha

    mov ax, 0x0700
    mov bh, 0x07
    mov cx, 0x0000
    mov dx, 0x184f
    int 0x10
    
    popa
    ret

text db "1+2+...+100="
len equ $ - text
times 510 - ($ - $$) db 0
dw 0xaa55
