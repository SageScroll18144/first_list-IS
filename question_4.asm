org 0x7c00
jmp _start

_start:
	xor ax, ax
    xor cx, cx
   	xor dx, dx

    ;tela
    mov ah, 0x00
    mov bh, 12h 
    int 10h

    mov ah, 0xb 
    mov bh, 0
    mov bl, 1h
    int 10h

    call getinput
    call endl

    ;a gente tem a soma total em cx
    xor ax, ax
    mov ax, cx
    
    call solve
    add al, '0'
    call putchar

	jmp done
	
getinput:
    mov ah, 0x00
    int 16h

    cmp al, 0x0d
    je .done

    cmp al, '-'
    je .continue

    sub al, '0'
    add cl, al
    add al, '0'

    call putchar

    jmp getinput

    .continue:
        call putchar
        jmp getinput
    .done:
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
    cmp ax, 10 
    jb .min_nine
    
    inc dx
    sub ax, 10

    jmp solve
    
    .min_nine:
        add ax, dx
        xor dx, dx
        
        cmp ax, 9
        ja solve

        ret 

done:
    jmp $

times 510 - ($ - $$) db 0
dw 0xaa55

