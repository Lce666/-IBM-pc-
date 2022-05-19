;从键盘输入一系列字符（以回车符结束），并按字母、数字及其其他字符分类计数，最后显示出这三类的计数结果
s1 segment stack
dw 30h dup(?)
top label word
s1 ends

s2 segment
string1 db 'letter',24h
string2 db 'number',24h
string3 db 'others',24h
enter db 0dh,0ah,24h
s2 ends

s3 segment
assume ss:s1,ds:s2,cs:s3
main proc far
mov ax,s1
mov ss,ax
mov ax,s2
mov ds,ax
lea sp,top

mov bx,0;字母的计数器
mov dx,0;数字的计数器
mov cx,0;其他字符的计数器

l1:mov ah,1
int 21h
cmp al,0dh
je printf
cmp al,2fh
ja l2
inc cx
jmp l1
l2:cmp al,39h
ja l3
inc dx
jmp l1
l3:cmp al,40h
ja l4
inc cx
jmp l1
l4:cmp al,5ah
ja l5
inc bx
jmp l1
l5:cmp al,60h
ja l6
inc cx
jmp l1
l6:cmp al,7ah
ja l7
inc bx
jmp l1
l7:inc cx
jmp l1

printf:push dx;dx进栈保存一下
lea dx,string1
mov ah,9
int 21h
mov dx,bx
add dx,30h
mov ah,2
int 21h

lea dx,enter
mov ah,9
int 21h

lea dx,string2
mov ah,9
int 21h
pop dx
add dx,30h
mov ah,2
int 21h

lea dx,enter
mov ah,9
int 21h

lea dx,string3
mov ah,9
int 21h
mov dx,cx
add dx,30h
mov ah,2
int 21h

mov ah,4ch
int 21h
main endp
s3 ends
end main