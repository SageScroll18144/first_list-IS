org 0x7c00
jmp _start

_start:
    xor ax, ax
    xor cx, cx
    xor dx, dx
    xor si, si

    call getinput
    call endl

    call solve
    
    xor si, si
    xor bx, bx
    mov bx, ax
    
    xor cx, cx
    xor ax, ax
    mov ax, 1
    mov dx, 1
    call fib

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

    cmp cx, 2
    jne .not_dez
    
    lodsb

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
        
fib:
    inc cl
    
    cmp cl, bl
    je .prep
    
    xor si, si
    mov si, ax
    
    add ax, dx 
    
    mov dx, si
    
    jmp fib
    
    .prep:
        xor ax, ax
        mov ax, dx
        jmp .mod11
    
        .mod11:
            cmp ax, 10
            jb .done
            
            cmp ax, 10
            je .dez
            
            sub ax, 11
            jmp .mod11
            
            .dez:
                xor ax, ax
                mov ax, '1'
                call putchar
                mov ax, '0'
                call putchar
                ret
                
                .done:
                    add ax, '0'
                    call putchar
                    ret
    
done:
    jmp $
    
times 510 - ($ - $$) db 0
dw 0xaa55






