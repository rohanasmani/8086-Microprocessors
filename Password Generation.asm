DATA SEGMENT
    MSG     DB 'ENTER PASSWORD:$'
    CORRECT DB 'CORRECT PASSWORD$'
    WRONG   DB 'WRONG PASSWORD$'
    PASS    DB 20 DUP(?)        ; user input buffer
DATA ENDS

EXTRA SEGMENT
    STORE   DB 'HELLO'          ; correct password
EXTRA ENDS

CODE SEGMENT
ASSUME CS:CODE, DS:DATA, ES:EXTRA

START:
    MOV AX, DATA
    MOV DS, AX

    MOV AX, EXTRA
    MOV ES, AX

; ---- Display message ----
    MOV AH, 09H
    MOV DX, OFFSET MSG
    INT 21H

    MOV SI, OFFSET PASS   ; pointer for input
    MOV CX, 0             ; length counter

INPUT:
    MOV AH, 08H           ; input without echo
    INT 21H

    CMP AL, 13            ; ENTER key?
    JE CHECK

    CMP AL, 08H           ; BACKSPACE?
    JE BACKSPACE

; ---- Store character ----
    MOV [SI], AL
    INC SI
    INC CX

; ---- Display '*' ----
    MOV DL, '*'
    MOV AH, 02H
    INT 21H
    JMP INPUT

; ---- Handle Backspace ----
BACKSPACE:
    CMP CX, 0
    JE INPUT              ; nothing to delete

    DEC SI
    DEC CX

    ; erase '*' from screen
    MOV DL, 08H           ; move cursor back
    MOV AH, 02H
    INT 21H

    MOV DL, ' '
    INT 21H

    MOV DL, 08H
    INT 21H

    JMP INPUT

; ---- Compare passwords ----
CHECK:
    MOV SI, OFFSET PASS
    MOV DI, OFFSET STORE

    MOV BX, CX            ; user length
    MOV CX, 5             ; stored password length

    CMP BX, CX
    JNE WRONG_LABEL       ; length mismatch

    CLD
    REPE CMPSB

    JNZ WRONG_LABEL

; ---- Correct ----
RIGHT_LABEL:
    MOV AH, 09H
    MOV DX, OFFSET CORRECT
    INT 21H
    JMP EXIT

; ---- Wrong ----
WRONG_LABEL:
    MOV AH, 09H
    MOV DX, OFFSET WRONG
    INT 21H

EXIT:
    MOV AH, 4CH
    INT 21H

CODE ENDS
END START
