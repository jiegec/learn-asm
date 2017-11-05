bits 16
org 0x7c00

start:
    call clearScreen
    mov ax, 0x0000
    mov ds, ax

    mov ax, 0xb800
    mov es, ax

    cld
    mov si, text
    mov di, 0
    mov cx, len
    rep movsw

    mov bx, [number]
    mov si, 10
digit:
    mov ax, bx
    xor dx, dx
    div si
    mov bx, ax
    mov al, dl
    add al, '0'
    mov ah, 0x06
    mov [es:di], ax
    add di, 2
    cmp bx, 0
    jg digit

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

text db 'H',0x02,'e',0x02,'l',0x02,'l',0x02,'o',0x02,' ',0x02,'C',0x02,'S',0x02,'T',0x02,' ',0x02
len equ ($ - text) / 2
number dw 27 ; will be printed in reverse form
times 510 - ($ - $$) db 0
dw 0xaa55
