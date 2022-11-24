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
    mov word ptr es:[0*4],200h
    mov word ptr es:[0*4+2],0
    

    mov ax,4c00h
    int 21h

do0:
    jmp do0_start
    db 'divide error!'
do0_start:
    ;设置ds:si指向字符串
    mov ax,cs
    mov ds,ax
    mov si,203h
    ;设置显存位置
    mov ax,0B800H
    mov es,ax
    mov di,12*160+36*2
    ;设置字符串长度
    mov cx,offset do0_start - offset do0 - 3
    mov ah,00100100B;设置字符串样式
    s: ;写入显存
        mov al,[si]
        mov es:[di],ax
        inc si
        add di,2
        loop s
    mov ax,4c00h
    int 21h
do0_end: nop

codesg ends

end start