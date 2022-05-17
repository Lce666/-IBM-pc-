;试编制一个汇编程序，求出首地址为DATA的100D字数组中的最小偶数，并把它存放在AX中
s1 segment stack
dw 30h dup(?)
top label word
s1 ends

s2 segment
DATA dw 1,3,6,8
count dw ($-DATA)/2
string db 'All num is odd',0dh,0ah,24h;要考虑全为奇数的情况
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
mov bx,65535

l1:mov ax, DATA[si]
test ax,1;查看是否为奇数
jnz l2;注意！！       zf=1时，即当前数为偶数，test的结果为0
cmp bx,ax;bx作为最小偶数的哨兵
jb l2
mov bx,ax                                                  
l2:add si,2;注意！！  是字数组所以不能直接自增1
loop l1
cmp bx,65535
jnz l3
lea dx,string
mov ah,9
int 21h
jmp l5
l3: mov ax,bx;已经把最小偶数放入ax寄存器中

l4:mov dl,bl;本段只用于直观输出结果方便调试
add dl,30h
mov ah,2
int 21h

l5:mov ah,4ch
int 21h
main endp
s3 ends
end main