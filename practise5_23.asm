s1 segment stack
dw 30h dup(?)
top label word
s1 ends

s2 segment
A dw 3
B dw 5
string db 0dh,0ah,24h
s2 ends

s3 segment
assume ss:s1,ds:s2,cs:s3
main proc far
mov ax,s1
mov ss,ax
mov ax,s2
mov ds,ax
lea sp,top

mov ax,A
mov bx,B
test ax,1
jz l1;跳转至偶数处理
test bx,1
jz l2;a奇b偶
inc ax;a奇b奇
inc bx
jmp l3
l1:test bx,1
jz l2;a偶b偶
xchg ax,bx;a偶b奇
l3:mov A,ax
mov B,bx

;输出模块，仅用于调试
l2:mov dx,ax
add dl,30h
mov ah,2
int 21h
lea dx,string
mov ah,9
int 21h
mov dx,bx
add dl,30h
mov ah,2
int 21h

mov ah,4ch
int 21h
main endp
s3 ends
end main
