assume cs:codesg

data segment
    db 'welcome to masm!',0
data ends

stack segment
    dd 20 dup(0)
stack ends

codesg segment
start:
    ;================通用代码===================
    mov ax,data
    mov ds,ax
    
    mov ax,0B800H
    mov es,ax

    mov ax,stack
    mov ss,ax
    mov ax,80
    mov sp,ax
    ;===========================================
    
    mov ax,4240H
    mov dx,000FH
    mov cx,0AH
    call divdw

    mov ax,4c00h
    int 21h

    divdw:
    push di

    push ax
    mov ax,dx
    mov dx,0
    div cx
    mov di,ax;高16位商
    ;余数已经在dx里了
    pop ax
    div cx
    mov cx,dx;余数
    mov dx,di;高16位商

    pop di
    ret
    
codesg ends

end start