s1 segment stack
dw 100h dup(?)
top label word
s1 ends

s2 segment
num dw 4567h
MEM dw 4h dup(0)
s2 ends

s3 segment
assume ss:s1,ds:s2,cs:s3
main proc far
    mov ax,s1
    mov ss,ax
    mov ax,s2
    mov ds,ax
    lea sp,top
    mov bx,num
    mov cx,4
    mov si,0
    l1: push cx
    mov dx,bx
    and dx,0fh
    add dx,30h
    mov MEM[si],dx
    add si,2
    mov cl,4
    ror bx,cl
    pop cx
    loop l1

    ;输出语句，本程序不需要，只是为了方便查看结果
    mov cx,4
    mov si,0
    print:mov dx,MEM[si]
    mov ah,2
    int 21h
    add si,2
    loop print
    mov ah,4ch
    int 21h
    main endp
s3 ends
end main