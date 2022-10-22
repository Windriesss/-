assume cs:codesg

data segment
    db 'welcome to masm!'
    db 01110001B;
    db 00100100B;
    db 00000010B;
data ends

stack segment
    dd 0
stack ends

codesg segment
start:
    mov ax,data
    mov ds,ax
    
    mov ax,0B800H
    mov es,ax

    mov ax,stack
    mov ss,ax
    mov ax,4
    mov sp,ax
    
    mov cx,3;控制样式
    s:
    mov di,cx
    mov ah,ds:[16+di-1];样式
    
    mov si,0;个数
    mov bx,0;偏移地址
    mov cx,16
        s0:
        mov al,[si] ;字母
        mov es:[1920+80][bx],ax
        add bx,2
        inc si
        loop s0

        mov ax,es
        add ax,000aH
        mov es,ax
        mov cx,di
    loop s

    mov ax,4c00h
    int 21h

codesg ends

end start
