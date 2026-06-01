## Write an 8086 assembly language program to copy 5 bytes of data from one memory location to another within the Data Segment.
```Assembly
data segment
x db 10h, 20h, 30h, 40h, 50h
y db 5 dup (?)
ends

code segment
assume ds:data, cs:code
mov ax, data
mov ds, ax
mov si, offset x
mov di, offset y
mov cx, 5
dtod:
        mov al, [si]
        mov [di], al
        inc si
        inc di
        loop dtod
ends
end
```
