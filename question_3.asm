org 0x7c00
jmp _start

_start:
    xor ax, ax 
    xor bx, bx
    xor cx, cx 
    xor dx, dx 

    ;tela
    mov ah, 0
    mov bh, 12h
    int 10h

    mov ah, 0xb
    mov bh, 0
    mov bl, 1h
    int 10h

    ;X
    call getchar
    call endl

    ;Y
    xor ax, ax
    call getchar
    call endl

    ;W
    xor ax, ax
    call getchar
    call endl

    ;Z
    xor ax, ax
    call getchar
    call endl

    xor cx, cx
    call solve

    call done

done:
    jmp $
    
getchar:
    mov ah, 0x0
    int 16h

    call putchar
    
    sub ax, '0'

    stosb
    inc si
    
    ret

putchar:
    mov ah, 0x0e
    int 10h
    ret

endl:
    mov ax, 0x0a
    call putchar
    mov ax, 0x0d
    call putchar
    ret

solve:
    ;(x*y) + (z*w) - (x/z)+(w/y),
    ret
times 510 - ($ - $$) db 0
dw 0xaa55