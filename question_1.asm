org 0x7c00
jmp 0x0000:_start

hello db "Felipe Santos eaw", 0

_start:
    xor ax, ax
    mov ds, ax
    mov es, ax

    mov si, hello

    call print_str

    jmp done

print_str:
    lodsb ; carrega uma letra em si
    cmp al, 0
    je .done

    mov ah, 0eh
    int 10h
    jmp print_str

    .done:
        ret
done:
    jmp $

times 510 - ($ - $$) db 0
dw 0xaa55