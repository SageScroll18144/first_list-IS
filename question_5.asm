org 0x7c00
jmp 0x0000:_start

_start:
    xor ax, ax
    xor cx, cx
    xor si, si

    call getinput
    call endl

    call solve

    ;tela
    mov ah, 0
    mov bh, 13h
    int 10h

    mov dx, ax

    mov ah, dh
    mov bh, 0
    mov bl, 1h
    int 10h

    jmp done

getinput:
    mov ah, 0x0
    int 16h

    cmp al, 0x0d
    je .done

    inc cx

    sub ax, '0'
    stosb
    add ax, '0'

    call putchar

    jmp getinput

    .done:
        ret
endl:
    mov ax, 0x0a
    call putchar
    mov ax, 0x0d
    call putchar
    ret

putchar:
    mov ah, 0x0e
    int 10h
    ret

solve:
    xor si, si
    xor bx, bx
    
    lodsb
    mov bx, ax

    lodsb

    cmp cx, 2
    jne .not_dez

    .not_dez:
        xor ax, ax
        mov ax, bx
        ret

    imul bx, 10
    add ax, bx
    ret

done:
    jmp $

times 510 - ($ - $$) db 0
dw 0xaa55