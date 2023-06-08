org 0x7c00
jmp _start

hello db "Felipe Santos eaw", 0
buffer db 16

_start:
    xor ax, ax
    mov ds, ax
    mov es, ax

    call getchar

    mov si, ax

    call print_str

    mov si, hello

    call print_str

    jmp $

getchar:
    mov ah, 0x00
    int 16h
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
done:
    jmp $

times 510 - ($ - $$) db 0
dw 0xaa55