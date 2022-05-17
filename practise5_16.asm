;在首地址为DATA的字数组中，存放了100H个16位补码数，试编写程序，求出它们的平均值放在ax寄存器中
;并求出数组中有多少个数小于此平均值，将结果放在bx寄存器中
;有符号数的加法需要符号扩展，而不是跟零比较然后选择分支加减，因为是补码，最高位是符号位
;16位补码的加法则需要用cwd进行符号扩展，有符号除法也是一样
;因为计算机特有属性（即整数除法，丢弃小数点后的数据），除法都是向下取整，并非日常中的四舍五入
s1 segment stack
dw 30h dup(?)
top label word
s1 ends

s2 segment
DATA dw -1,-6,-5,-8,-7,9,-10
count dw ($-DATA)/2
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

mov si,0
mov cx,count
dec cx
mov ax,DATA[si]
add si,2
l1:mov bx,DATA[si];计算总和
cwd
add ax,bx
adc dx,0
add si,2
loop l1
mov bx,count;算平均数
cwd
idiv bx

mov cx,count
mov si,0
mov bx,0
l3:mov dx,DATA[si];数有几个数小于平均数
cmp dx,ax
jge l4
inc bx
l4:add si,2
loop l3

;输出程序， 用于直观观察结果，与本程序无关，仅用于调试方便
mov cx,ax
cmp ax,0
jge l2
mov dl,'-'
mov ah,2
int 21h
neg cx
l2:mov dl,cl
add dl,30h
mov ah,2
int 21h
lea dx,string
mov ah,9
int 21h
mov dl,bl
add dl,30h
mov ah,2
int 21h

mov ah,4ch
int 21h
main endp
s3 ends
end main