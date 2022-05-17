;把ax中存放的16位二进制数k看作是8个二进制的“四分之一字节”。试编写程序，要求数一下值为3（即11B）
;的四分之一字节数，并将该数在终端上显示出来

s1 segment stack
dw 30h dup(?)
top label word
s1 ends

s2 segment
k dw 5333h;输入的数据
s2 ends

s3 segment
assume ss:s1,ds:s2,cs:s3
main proc far
mov ax,s1
mov ss,ax
mov ax,s2
mov ds,ax
lea sp,top

mov ax,k
xor dx,dx;dx作为计数器，记录四分之一字节个数
mov cx,8
l1:push cx
mov cl,2
rol ax,cl
mov bx,ax
and bx,3;屏蔽前六位数
cmp bx,3
jnz l2
inc dl;为方便后续直接输出直接自增dl
l2:pop cx
loop l1
add dl,30h
mov ah,2
int 21h
mov ah,4ch
int 21h
main endp
s3 ends
end main