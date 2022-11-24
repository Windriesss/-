assume cs:codesg

data segment
    db 'welcome to masm!',0
data ends

stack segment
    dd 20 dup(0)
stack ends

codesg segment
start:
    mov ax,data
    mov ds,ax
    
    mov ax,0B800H
    mov es,ax

    mov ax,stack
    mov ss,ax
    mov ax,80
    mov sp,ax
    
    mov dh,4;行偏移
    mov dl,3;列偏移
    mov cl,2;样式
    mov si,0
    call show_str

    mov ax,4c00h
    int 21h

    ;dh,行号
    ;dl,列号
    ;cl,样式
    show_str:
        push ax;乘法运算
        push dx;字母+样式
        push di;总偏移
        push si;字母下标
        push cx
        
        mov al,dh;/计算行偏移
        mov ah,160
        mul ah
        mov di,ax;行偏移值存到di中
        mov dh,0
        add di,dx;列偏移加到di中,每多一列，多偏移2个字节
        add di,dx;
        
        mov dh,cl;样式
        mov ch,0
        write_str:
        mov cl,[si]
        jcxz write_str_end
        mov dl,cl
        mov es:[di],dx
        inc si;字符串偏移地址
        add di,2;显存偏移地址
        loop write_str

        write_str_end:
        pop cx
        pop si
        pop di
        pop dx
        pop ax
        ret

codesg ends

end start