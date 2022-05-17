;5.2 编写程序，从键盘接收一个小写字母，然后找出它的前导字符和后续字符，再按顺序显
;示这三个字符。



s1 segment  stack
dw 30h dup(?)
top label word
s1 ends

s2 segment
s2 ends

s3 segment
assume ss:s1,ds:s2,cs:s3
main proc far
    mov ax,s1
    mov ss,ax
    mov ax,s2
    mov ds,ax
    lea sp,top
    l1:mov ah,1
    int 21h
    cmp al,61h
    jb l1
    cmp al,7ah
    ja l1
    mov cx,3
    dec al
    mov dl,al
    l2:mov ah,2
    int 21h
    inc dl
    loop l2
    mov ah,4ch
    int 21h
    main endp
s3 ends
end main