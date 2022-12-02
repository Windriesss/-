assume cs:codesg

codesg segment
start:
    ;把中断函数写到0000:200中
    ;ds:si指向源地址
    mov ax,cs
    mov ds,ax
    mov si,offset do0
    ;es:di指向目的地址
    mov ax,0000h
    mov es,ax
    mov di,200h
    ;设置复制长度
    mov cx,offset do0_end - offset do0
    cld;设置传输方向为正
    rep movsb

    ;设置中断向量表
    mov ax,0
    mov es,ax
    mov word ptr es:[4*7cH],200h
    mov word ptr es:[4*7cH+2],0

    mov ax,4c00h
    int 21h

do0:
    push bp
    dec cx
    mov bp,sp
    jcxz do0_ret
    add [bp+2],bx
do0_ret:
    pop bp
    iret
do0_end:

codesg ends

end start