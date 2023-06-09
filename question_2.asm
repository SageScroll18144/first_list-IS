org 0x7c00
jmp _start

hello db "funciona por favor", 0
buffer db 16

_start:
    xor ax, ax
    xor dx, dx
    mov ds, ax
    mov es, ax

    mov ah, 0
    mov bh, 12h
    int 10h

    mov ah, 0xb
    mov bh, 0
    mov bl, 1h
    int 10h

    xor ax, ax
    call gets

    xor ax, ax
    call gets
    
    mov si, hello

    call print_str

    jmp done

getchar:
    mov ah, 0x0
    int 16h
    ret

gets:
    xor ax, ax

    call getchar
    call putchar
    
    cmp al, 0x0d
    je .done

    ;push ax
    jmp gets

    .done:
        call endl
        ret
    
putchar:
    mov ah, 0x0e
    int 10h
    ret

endl:
    mov ax, 0x0a
    call putchar
    ; mov ax, 0x0d
    ; call putchar
    ret

print_str:
    lodsb ; carrega uma letra em si
    cmp al, 0
    je .done

    mov ah, 0x0e
    mov bh, 0
    mov bl, 0xf
    int 10h

    jmp print_str

    .done:
        ret

done:
    jmp $

times 510 - ($ - $$) db 0
dw 0xaa55
