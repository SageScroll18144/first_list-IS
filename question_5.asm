org 0x7c00
jmp 0x0000:_start

ans db "Como eh facil trocar a cor", 0

_start:
    xor ax, ax
    xor cx, cx
    xor si, si
    mov ds, ax
    
    mov ah, 0
    mov al, 12h
    int 10h

    xor ax, ax
    xor cx, cx
    xor si, si


    mov bl, 0xf
    call getinput
    call endl

    call solve
    
    xor dx, dx
    mov dx, ax
    add cx, '0'

    ;texto
    mov si, ans
    call print_str

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

    cmp cx, 2
    je .dez

    .not_dez:
        xor ax, ax
        mov ax, bx
        ret

    .dez:
        imul bx, 10
        add ax, bx
        ret
        
print_str:
    lodsb ; carrega uma letra em si
    cmp al, 0
    je .done

    mov ah, 0eh
    mov bh, 0
    mov bl, dl
    int 10h
    jmp print_str

    .done:
        ret

done:
    jmp $

times 510 - ($ - $$) db 0
dw 0xaa55