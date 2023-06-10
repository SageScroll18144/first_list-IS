org 0x7c00
jmp _start

buffer times 64 db 0

_start:
    mov si, buffer
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
    
    call getstring
    call endl

    call letter
    call endl 

    xor si, si
    call numerator

    call bar

    call denominator
    call done
    
getstring:
    call getchar
    call putchar

    cmp al, 0x0d
    je .done
    
    inc cx
    stosb
    
    jmp getstring
    
    .done:
        ret
            
endl: 
    mov ax, 0x0a
    call putchar
    
    mov ax, 0x0d
    call putchar
    
    ret
        
letter:
    call getchar
    call putchar
    
    mov bl, al
    ret
        
denominator:
    mov al, cl
    mov ah, 0x0e
    add al, '0'
    int 10h
    ret
    
numerator:
    lodsb
    cmp al, bl
    je .count 
    cmp al, 0
    je .print
    
    jmp numerator
    
    .count:
        inc dx
        jmp numerator
    
    .print:
        mov al, dl
        mov ah, 0x0e
        add al, '0'
        int 10h
        ret
        
bar:
    mov ah, 0x0e
    mov al, '/'
    int 10h
    ret
    
putchar:
    mov ah, 0x0e
    int 10h 
    ret
    
getchar:
    mov ah, 0x00 
    int 16h
    ret
    
done:
    jmp $
    
times 510 - ($ - $$) db 0
dw 0xaa55
    
    
    


