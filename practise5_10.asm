;设有一段英文，其字符变量名为ENG，并以$字符结束。试编写程序，查对单词SUN在该文中的出现次数
;并以格式“SUN XXXX”显示出次数
s1 segment stack
dw 30h dup(?)
top label word
s1 ends

s2 segment
ENG db 'hello SUN,mySUN ,f***,SUN you dick',24h
len1 dw $-ENG-3
string db 'SUN',24h
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
mov cx,len1
xor bl,bl;bl作为SUN个数计数器
l1:mov ah,ENG[si]
cmp ah,'$';先要判断是否结束
je l5
cmp ah,'S'
jnz l2
mov ah,ENG[si+1]
cmp ah,'U'
jnz l3
mov ah,ENG[si+2]
cmp ah,'N'
jnz l4
inc bl

l4:add si,3
sub cx,2
loop l1
l2:inc si
loop l1
l3:add si,2
dec cx
loop l1

l5:lea dx,string
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