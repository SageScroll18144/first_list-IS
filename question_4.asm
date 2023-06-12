org 0x7c00
jmp 0x0000:_start

_start:
	xor ax, ax
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

    call getinput
    call endl

    ;a gente tem a soma total em cx
    call solve
    call putchar

	jmp done
	
getinput:
    mov ah, 0x0
    int 16h

    cmp al, 0x0d
    je .done

    cmp al, '-'
    je .continue

    sub ax, '0'
    add cx, ax
    add ax, '0'
    ret

    call putchar

    jmp getinput

    .continue:
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
    
    cmp cx, 10
    jb .min_nine

    mov ax, cx
    mov cx, 10

    div cx

    xor cl, cl
    add cl, al
    add cl, ah

    mov ax, cx

    ret
    .min_nine:
        mov ax, cx
        ret 

done:
    jmp $

times 510 - ($ - $$) db 0
dw 0xaa55
