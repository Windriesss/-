assume cs:codesg

data segment
    db '1975','1976','1977','1978','1979','1980','1981','1982','1983'
    db '1984','1985','1986','1987','1988','1989','1990','1991','1992'
    db '1993','1994','1995'
    ;年份
    
    dd 16,22,382,1356,2390,8000,16000,24486,50065,97479,140417,197514
    dd 345980,590827,803530,1183000,1843000,2759000,3753000,4649000,5937000
    ;总收入

    dw 3,7,9,13,28,38,130,220,476,778,1001,1442,2258,2793,4037,5635,8226
    dw 11542,14430,15257,17800
    ;雇员人数
data ends

table segment
    db 21 dup ('year summ ne ?? ')
table ends

codesg segment
start:
    mov ax,data
    mov ds,ax

    mov ax,table
    mov es,ax

    mov si,0
    mov bx,0
    mov di,0

    mov cx,21
    s0:
    ;年份[bx]-[bx+3] 
    ;总收入 [bx+84]-[bx+84+3]
    ;雇员数 [di].168
    ;表:
    ;   年份es:si - es:si+3
    ;   收入es:si+5 - es:si+8
    ;   雇员es:[si].10 - es:[si].11
    ;   人均收入es:[si].13 - es:[si].14
    
    ;年份
    mov ax,[bx]
    mov es:[si],ax
    mov ax,[bx].2
    mov es:[si].2,ax
    ;总收入
    mov dx,[bx].86
    mov es:[si].5,dx
    mov ax,[bx].84
    mov es:[si].7,ax
    ;人均收入
    div word ptr ds:[di].168
    mov es:[si].13,ax
    ;雇员数
    mov ax,ds:[di].168
    mov es:[si].10,ax

    add si,16
    add bx,4
    add di,2
    loop s0

    mov ax,4c00h
    int 21h

codesg ends

end start
