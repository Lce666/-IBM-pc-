;将 AX 寄存器中的 16 位数分成 4 组，每组 4 位，
;然后把这四组数分别放在 AL、 BL、
;CL 和 DL 中

s1 segment stack
dw 30h dup(?)
top label word
s1 ends

s2 segment 
num dw 1234h
s2 ends

s3 segment
assume ss:s1,ds:s2,cs:s3
main proc far
    mov ax,s1
    mov ss,ax
    mov ax,s2
    mov ds,ax
    lea sp,top
    mov ax,num
    mov dx,ax
    and dx,0fh
    mov cl,4
    shr ax,cl
    mov si,ax
    and si,0fh
    shr ax,cl
    mov bx,ax
    and bx,0fh
    shr ax,cl
    mov cx,si
    mov ah,4ch
    int 21h
main endp
s3 ends
end main