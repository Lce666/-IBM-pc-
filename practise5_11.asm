;从键盘输入一系列以$为结束符的字符串，然后对其中的非数字字符计数，并显示出计数结果
s1 segment stack
dw 30h dup(?)
top label word
s1 ends

s2 segment
string db 0dh,0ah,24h;回车为了输出美观，非必需
s2 ends

s3 segment
assume ss:s1,ds:s2,cs:s3
main proc far
mov ax,s1
mov ss,ax
mov ax,s2
mov ds,ax
lea sp,top

mov dx,30h;dl作为计数器
l1:mov ah,1
int 21h
cmp al,'$'
je printf
cmp al,30h
jb l2
cmp al,40h
jb l3
l2:inc dl
l3:jmp l1

printf:push dx
lea dx,string
mov ah,9
int 21h
pop dx
mov ah,2
int 21h
mov ah,4ch
int 21h
main endp
s3 ends
end main