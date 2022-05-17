;编写程序将一个包含20个数据的数组M分成两个数组正数数组
;正数数组p和负数数组N，并分别把这两个数组中数据的个数显示出来
s1 segment stack
dw 30h dup(?)
top label word
s1 ends

s2 segment
arrayM db 1,-2,3,4,5,6,7,8,9,-1,-2,-3,-4,-5,-6,-7,-8,-9,7,7
arrayP db 20h dup(?)
arrayN db 20h dup(?)
lenP db 'postive array num is:',24h
lenN db 'negetive array num is:',24h
len1 dw ?
len2 dw ?
break db 0dh,0ah,24h
s2 ends

s3 segment
assume ss:s1,ds:s2,cs:s3
main proc far
mov ax,s1
mov ss,ax
mov ax,s2
mov ds,ax
lea sp,top
mov cx,20
mov bx,0
mov si,0
mov di,0
l1:mov dl,arrayM[bx]
cmp dl,0
jl l2
mov arrayP[si],dl
inc si
mov len1,si
jmp l3
l2:mov arrayN[di],dl
inc di
mov len2,di
l3:inc bx
loop l1

lea dx,lenP
mov ah,9
int 21h
mov cx,len1
xor si,si
l4:mov dl,arrayP[si]
add dl,30h
mov ah,2
int 21h
inc si
loop l4

lea dx,break
mov ah,9
int 21h

lea dx,lenN
mov ah,9
int 21h
mov cx,len2
xor di,di
l5:mov dl,'-'
mov ah,2
int 21h
mov dl,arrayN[di]
neg dl
add dl,30h
mov ah,2
int 21h
inc di
loop l5

mov ah,4ch
int 21h
main endp
s3 ends
end main