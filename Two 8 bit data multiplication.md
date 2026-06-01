## Write an assembly language program that multiply two 8-bit numbers X and Y defined in data segment and places the result at memory location Z in extra segment. 
### Program
```Assembly
DATA SEGMENT
    X DB 05H
    Y DB 03H
DATA ENDS

EXTRA SEGMENT
    Z DW ?
EXTRA ENDS

CODE SEGMENT
ASSUME CS:CODE, DS:DATA, ES:EXTRA

START:
    MOV AX, DATA
    MOV DS, AX

    MOV AX, EXTRA
    MOV ES, AX

    MOV AL, X
    MOV BL, Y
    MUL BL          ; AX = AL × BL

    MOV ES:Z, AX    ; store result in ES

    MOV AH, 4CH
    INT 21H
CODE ENDS
```
END START
