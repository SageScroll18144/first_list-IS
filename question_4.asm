org 0x7c00
jmp 0x0000:_start

_start:
	xor ax, ax
    xor cx, cx
   	xor dx, dx

    ;tela
    

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
    
    cmp cx, 10
    jb .min_nine

    mov ax, cx
    mov cx, 10

    div cx

    xor cx, cx
    add cx, ax
    add cx, dx

    mov ax, cx
    add ax, '0'

    ret

    .min_nine:
        mov ax, cx
        add ax, '0'
        ret 

done:
    jmp $

times 510 - ($ - $$) db 0
dw 0xaa55
