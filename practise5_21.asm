;试编写程序，要求比较数组ARRAY中的三个16位补码数，并根据比较结果在终端上显示如下信息：
;1.如果三个数都不相等则显示0；
;2.如果三个数有两个相等则显示1
;3.如果三个数都相等则显示2
;很简单的三分支问题，如果一下子无法想象出来可以试试画流程图,注意是16位数
s1 segment stack
dw 30h dup(?)
top label word
s1 ends

s2 segment
ARRAY dw -1,2,3
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
xor dx,dx
mov ax,ARRAY[si]
add si,2
mov bx,ARRAY[si]
add si,2
mov cx,ARRAY[si]
cmp ax,bx
jne l1
inc dx
l1:cmp ax,cx
jne l2
inc dx
l2:cmp bx,cx
jne l3
inc dx
l3:cmp dx,3;假如只有两个数相等则三个分支只能满足一条，即dx只自增一次，而三个数不等，dx为0都直接满足要求
jne l4
mov dx,2;但是假如三个数都相等则dx自增了三次需要特殊处理
l4:add dl,30h
mov ah,2
int 21h
mov ah,4ch
int 21h
main endp
s3 ends
end main
