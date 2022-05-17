;试编写一程序，要求能从键盘接收一个个位数 N，然后响铃 N 次(响铃的 ASCII 码为 07)。
s1 segment stack
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
    mov ah,1
    int 21h
    xor cx,cx
    mov cl,al
    l1:mov ah,7
    int 21h
    loop l1
    mov ah,4ch
    int 21h
main endp
s3 ends
end main