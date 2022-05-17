;数据段中已经定义了一个有n个字数据的数组M,试编写程序求出绝对值最大的数，
;并把它放在数据段的M+2n单元，并将该数的偏移地址存放在M+2（n+1）单元中
;注意是字数组
s1 segment stack
dw 30h dup(?)
top label word
s1 ends

s2 segment
M dw 1,-5,4
count dw ($-M)/2
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
mov bx,0;绝对值最小的数为零，作为哨兵
mov cx,count
l1:mov ax,M[si]
cmp ax,0
jg l2
neg ax
l2:cmp bx,ax
ja l3
mov bx,ax
push si
l3:add si,2
loop l1
mov di,count
add di,di
add di,di
mov M[di],bx
mov di,count
add di,di
add di,2
pop ax
mov M[di],ax
;此处不方便输出，所以可以通过debug调试来看各寄存器的值来判断
;ax最后的值为偏移地址，bx则为绝对值最大的数

mov ah,4ch
int 21h
main endp
s3 ends
end main