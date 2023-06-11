org 0x7c00
jmp 0x0000:_start

_start:
	xor ax, ax
    xor cx, cx
   	xor dx, dx

	jmp done
	

done:
    jmp $

times 510 - ($ - $$) db 0
dw 0xaa55
