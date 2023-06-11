org 0x7c00
jmp _start

odd db "eh impar", 0
even db "eh par", 0

_start:
    xor ax, ax 
    xor bx, bx
    xor cx, cx 
    xor dx, dx 
    xor si, si

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

    ;Z
    xor ax, ax
    call getchar
    call endl

    ;W
    xor ax, ax
    call getchar
    call endl

    xor si, si
    call solve

    call done

done:
    jmp $
    
getchar:
    mov ah, 0x0
    int 16h

    sub ax, '0'
    stosb
    add ax, '0'

    call putchar
        
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
    xor si, si
    
    lodsb
    mov cx, ax
    
    lodsb
    imul cx, ax

    lodsb
    mov bx, ax

    lodsb
    imul bx, bx

    add cx, bx

    ;até aqui foram os dois primeiros literais

    xor si, si

    lodsb
    mov bx, ax

    lodsb
    lodsb

    ;trocar ax por bx
    xchg bx, ax

    idiv bx

    sub cx, ax
    ;até o terceiro literal

    xor si, si

    lodsb
    lodsb

    mov bx, ax

    lodsb
    lodsb

    idiv bx

    add cx, bx

    and cx, 1
    
    cmp cx, 1
    je .odd

    cmp cx, 1
    jne .even
    

    .odd:
        mov si, odd
        call print_str
        ret

    .even:
        mov si, even
        call print_str
        ret

print_str:
    lodsb ; carrega uma letra em si
    cmp al, 0
    je .done

    mov ah, 0eh
    int 10h
    jmp print_str

    .done:
        ret

teste:
    lodsb
    
    cmp al, 0
    je .done

    add ax, '0' 
    call putchar

    jmp teste
    
    .done:
        ret

times 510 - ($ - $$) db 0
dw 0xaa55