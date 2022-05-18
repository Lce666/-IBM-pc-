s1 segment stack
dw 100h dup(?)
top label word
s1 ends

s2 segment
GRADE dw 1,10,2,77,77,8,99,100
RANK dw 8h dup(0)
count dw ($-RANK)/2
enter dw 0dh,0ah,24h
s2 ends

s3 segment
assume ss:s1,ds:s2,cs:s3
main proc far
    mov ax,s1
    mov ss,ax
    mov ax,s2
    mov ds,ax
    lea sp,top
    mov si,0
    mov cx,count
    l1:push cx
    mov ax,GRADE[si]
    mov di,0
    mov cx,count 
    mov dx,1

    l2:mov bx,GRADE[di] ;内循环，为了比较每个数和当前数的大小来计算排名
    cmp bx,ax
    jbe l3
    inc dx
    l3:add di,2
    loop l2

    mov RANK[si],dx
    add si,2
    pop cx
    loop l1

    lea dx,enter
    mov ah,9
    int 21h

    mov cx,count    ;展示RANK数组元素，实际程序不需要
    mov si,0        ;只是为了直观查看结果
    print:mov dx,RANK[si]
    add dl,30h
    mov ah,2
    int 21h
    add si,2
    loop print
;（需完善）输出时假如学生成绩超过9个则需要用考虑输出字符形式

    mov ah,4ch
    int 21h
main endp
s3 ends
    end main