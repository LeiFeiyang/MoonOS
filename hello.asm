; hello-os
; TAB=4
    ORG     0x7c00

    JMP     entry
    DB      0x90

entry:
    MOV     AX,0
    MOV     SS,AX
    MOV     SP,0x7c00
    MOV     DS,AX
    MOV     ES,AX

    MOV     SI,msg

putloop:
    MOV     AL,[SI]
    ADD     SI,1
    CMP     AL,0

    JE      fin
    MOV     AH,0x0e
    MOV     BX,15
    INT     0x10
    JMP     putloop

fin:
    HLT
    JMP     fin

msg:
    DB      0x0a, 0x0a
    DB      "hello, world"
    DB      0x0a
    DB      0

    RESB	0x1fe-($-$$)
	DB	0x55, 0xaa
