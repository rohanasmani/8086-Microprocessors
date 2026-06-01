data segment
x db 10h, 20h, 30h, 40h, 50h
ends

extra segment
y db 5 dup (?)
ends

code segment
assume ds:data, cs:code, es:extra
mov ax, data
mov ds, ax
mov ax, extra
mov es, ax
mov si, offset x
mov di, offset y
mov cx, 5
dtod:
        mov al, [si]
        mov es:[di], al
        inc si
        inc di
        loop dtod
ends
end
