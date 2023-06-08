org 0x7c00
jmp _start

hello db "funciona por favor", 0
buffer db 16

_start:
    xor ax, ax
    xor dx, dx
    mov ds, ax
    mov es, ax

    mov ah, 0
    mov bh, 12h
    int 10h

    mov ah, 0xb
    mov bh, 0
    mov bl, 1h
    int 10h

    xor ax, ax

    call getchar
    call putchar
    ; mov si, ax

    ; call print_str
    
    mov si, hello

    call print_str

    jmp done

getchar:
    mov ah, 0x00
    ;mov dx, 0x0
    int 16h
    ret

putchar:
  mov ah, 0x0e
  int 10h
  ret

print_str:
    lodsb ; carrega uma letra em si
    cmp al, 0
    je .done

    mov ah, 0eh
    mov bh, 0
    mov bl, 0xf
    int 10h

    jmp print_str

    .done:
        ret
done:
    jmp $

times 510 - ($ - $$) db 0
dw 0xaa55
