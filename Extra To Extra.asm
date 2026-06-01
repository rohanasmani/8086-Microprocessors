extra segment
x db 10h, 20h, 30h, 40h, 50h
y db 5 dup (?)
ends

code segment
assume cs:code, es:extra
mov ax, extra
mov es, ax
mov si, offset x
mov di, offset y
mov cx, 5
dtod:
        mov al, es:[si]
        mov es:[di], al
        inc si
        inc di
        loop dtod
ends
end
