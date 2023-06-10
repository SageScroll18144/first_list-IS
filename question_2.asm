org 0x7c00
jmp _start

buffer times 64 db 0

_start:
    mov si, buffer
    xor ax, ax 
    xor bx, bx
    xor cx, cx 
    xor dx, dx 
    
    call getstring
    call endl
    call letter
    call endl 
    xor si, si
    call print_count2
    call bar
    call print_count
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
        
print_count:
    mov al, cl
    mov ah, 0x0e
    add al, '0'
    int 10h
    ret
    
print_count2:
    lodsb
    cmp al, bl
    je .count 
    cmp al, 0
    je .print
    
    jmp print_count2
    
    .count:
        inc dx
        jmp print_count2
    
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
    
    
    


