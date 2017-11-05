bits 16
org 0x7c00

boot:
    call clearScreen

    mov ax, 0xb800
    mov es, ax

    mov byte [es:0x00], 'H'
    mov byte [es:0x01], 0x07
    mov byte [es:0x02], 'e'
    mov byte [es:0x03], 0x07
    mov byte [es:0x04], 'l'
    mov byte [es:0x05], 0x07
    mov byte [es:0x06], 'l'
    mov byte [es:0x07], 0x07
    mov byte [es:0x08], 'o'
    mov byte [es:0x09], 0x07
    mov byte [es:0x0A], ' '
    mov byte [es:0x0B], 0x07
    mov byte [es:0x0C], 'w'
    mov byte [es:0x0D], 0x07
    mov byte [es:0x0E], 'o'
    mov byte [es:0x0F], 0x07
    mov byte [es:0x10], 'r'
    mov byte [es:0x11], 0x07
    mov byte [es:0x12], 'l'
    mov byte [es:0x13], 0x07
    mov byte [es:0x14], 'd'
    mov byte [es:0x15], 0x07

loop:
    jmp near loop

clearScreen:
    pusha

    mov ax, 0x0700  ; function 07, AL=0 means scroll whole window
    mov bh, 0x07    ; character attribute = white on black
    mov cx, 0x0000  ; row = 0, col = 0
    mov dx, 0x184f  ; row = 24 (0x18), col = 79 (0x4f)
    int 0x10        ; call BIOS video interrupt

    popa
    ret
    
    hello db "Hello world!", 0
    times 510-($-$$) db 0
    db 0x55, 0xaa
