DATA SEGMENT
    MSG1 DB 'ENTER FIRST DIGIT:$'
    MSG2 DB 'ENTER SECOND DIGIT:$'
    RES  DB 'RESULT:$'
DATA ENDS

CODE SEGMENT
ASSUME CS:CODE, DS:DATA

START:
    MOV AX, DATA
    MOV DS, AX

; ---- First digit ----
    MOV AH, 09
    MOV DX, OFFSET MSG1
    INT 21H

    MOV AH, 01
    INT 21H
    SUB AL, 30H        ; ASCII → number
    MOV BL, AL

; ---- Second digit ----
    MOV AH, 09
    MOV DX, OFFSET MSG2
    INT 21H

    MOV AH, 01
    INT 21H
    SUB AL, 30H

; ---- Addition ----
    ADD AL, BL

; ---- Convert to ASCII ----
    ADD AL, 30H

; ---- Display result ----
    MOV AH, 09
    MOV DX, OFFSET RES
    INT 21H

    MOV DL, AL
    MOV AH, 02
    INT 21H

; ---- Exit ----
    MOV AH, 4CH
    INT 21H

CODE ENDS
END START
