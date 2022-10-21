assume cs:codesg,ds:datasg,ss:stacksg

datasg segment
    db '1. display      '
    db '2. brows        '
    db '3. replace      '
    db '4. modify       '
datasg ends

stacksg segment
    dw 0,0,0,0,0,0,0,0
stacksg ends

codesg segment
start:
    mov ax,datasg
    mov ds,ax
    mov ax,stacksg
    mov ss,ax
    mov sp,16
    mov bx,0

    mov cx,4
    
    s:      
        push cx
        mov cx,4
        s0: 
            mov si,cx
            mov al,[bx+si+2]
            and al,11011111b
            mov [bx+si+2],al
        loop s0

        pop cx
        add bx,16
    loop s

    mov ax,4c00h
    int 21h

codesg ends

end start
