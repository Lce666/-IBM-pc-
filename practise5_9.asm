;试编写程序，要求从键盘接受一个四位的十六进制数，并在终端上显示与它等值的二进制数
;注意！！输入的数据因为是十六进制数所以要考虑大小写字母和数字的输入区别
;而且输入的是字符的ASCII码，还要对数据进行处理
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

mov bx,0
mov cx,4
l1:push cx
mov ah,1
int 21h
mov cl,4
rol bx,cl

cmp al,30h;输入的为数字的情况
jb l1
cmp al,39h
jbe l2

cmp al,41h;输入为大写字母
jb l1
cmp al,5ah
jbe l3

cmp al,61h;输入为小写字母
jb l1
cmp al,7ah
jbe l4

l2:sub al,30h
jmp l6

l3:sub al,37h
jmp l6

l4:sub al,57h


l6:add bl,al
pop cx
loop l1

mov cx,16
l5:
xor dx,dx
rol bx,1
adc dl,30h
mov ah,2
int 21h
loop l5
mov ah,4ch
int 21h
main endp
s3 ends
end main