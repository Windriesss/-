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
    push ax
    push es
    push dx
    push di
    push si

    ;设置显存位置
    mov ax,0B800H
    mov es,ax
    mov ax,160
    mul dh
    mov dh,0
    add ax,dx
    add ax,dx
    mov di,ax
    ;设置字符串长度
    mov ah,cl;设置字符串样式
    s: ;写入显存
        cmp byte ptr [si],0 ;遇到0,结束
        je s_end

        mov al,[si]
        mov es:[di],ax
        inc si
        add di,2
        jmp s
    s_end:
    pop si
    pop di
    pop dx
    pop es
    pop ax
    iret
do0_end: nop

codesg ends

end start