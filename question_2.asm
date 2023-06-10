org 0x7c00
jmp _start

denominador db 0
numerador db 0

_start:
    xor ax, ax
    xor dx, dx
    xor cx, cx
    mov ds, ax
    mov es, ax
    mov si, ax

    mov ah, 0
    mov bh, 12h
    int 10h

    mov ah, 0xb
    mov bh, 0
    mov bl, 1h
    int 10h
    
    mov dx, '0'

    xor ax, ax
    call gets

    xor ax, ax
    call getchar
    call endl
    
    xor si, si
    ;call check

    mov ax, '0'
    add ax, 0
    call putchar

    mov al, '/'
    call putchar

    ;mov ax, '0'
    mov ax, dx
    ;add ax, si
    call putchar

    jmp done

getchar:
    mov ah, 0x0
    int 16h
    call putchar
    ret

gets:
    call getchar
    
    cmp al, 0x0d
    je .done
    
    inc dx
    
    stosb
    inc si

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
    mov ax, 0x0d
    call putchar
    ret

counter:
    lodsb
    
    cmp al, 0
    je .done

    cmp al, 's' ; 'A' depois muda para o registrador
    je .cnt_char

    inc dx

    jmp counter

    .done:
        ret

    .cnt_char:
        inc cx
        ret

check:
    lodsb
    cmp al, 0
    je .done

    call putchar

    jmp check

    .done:
        call endl
        ret

done:
    jmp $

times 510 - ($ - $$) db 0
dw 0xaa55
