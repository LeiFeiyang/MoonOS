; hello-os
; TAB=4
    ORG     0x7c00

    JMP     entry

entry:
    MOV     AX,0
    MOV     SS,AX
    MOV     SP,0x7c00
    MOV     DS,AX
    MOV     ES,AX

start:
    MOV     SI,msg
pfstart:
    MOV     AL,[SI]
    ADD     SI,1
    CMP     AL,0

    JE      load
    MOV     AH,0x0e
    MOV     BX,15
    INT     0x10
    JMP     pfstart

load:
    MOV     AX,0x0820
    MOV     ES,AX
    MOV     CH,0    ;柱面0
    MOV     DH,0    ;磁头0
    MOV     CL,2    ;扇区2， 扇区1是启动区

    MOV     SI,0
retry:
    MOV     AH,0x02 ;AH=0x02 : 读入磁盘
    MOV     AL,1    ;1个扇区
    MOV     BX,0
    MOV     DL,0x00 ;A驱动器
    INT     0x13    ;调用磁盘BIOS
    JNC     fin     ;无错跳转fin
    ADD     SI,1    ;出错，累加
    CMP     SI,5    ;
    JAE     error   ;SI >= 5则跳转ERROR
    ; MOV     AH,0x00
    ; MOV     DL,0x00
    ; INT     0x13    ;重置驱动器
    JMP     retry




error:
        MOV     SI,errmsg
pferror:
    MOV     AL,[SI]
    ADD     SI,1
    CMP     AL,0

    JE      fin
    MOV     AH,0x0e
    MOV     BX,15
    INT     0x10
    JMP     pferror

fin:
    HLT
    JMP     fin

msg:
    DB      0x0a, 0x0a
    DB      "Initializing..."
    DB      0x0a
    DB      0

errmsg:
    DB      0x0a, 0x0a
    DB      "Error..."
    DB      0x0a
    DB      0

    RESB	0x1fe-($-$$)
	DB	0x55, 0xaa
