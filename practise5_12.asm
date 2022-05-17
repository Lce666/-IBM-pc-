;有一个首地址为MEM的100D字数组，试编制程序删除数组中所有为零的项，
;并将后续项向前压缩，最后将数组剩余部分补上零
s1 segment stack
dw 30h dup(?)
top label word
s1 ends

s2 segment
MEM dw 1,0,2,0,0,3,4,5,0,0;此处只是为了测试所以设置了几个特殊的排列
len dw ($-MEM)/2
s2 ends

s3 segment
assume ss:s1,ds:s2,cs:s3
main proc far
mov ax,s1
mov ss,ax
mov ax,s2
mov ds,ax
lea sp,top

;实际上我使用的是冒泡排序
mov cx,len
dec cx;因为只需遍历99次
l1:mov di,cx;此处di的作用其实类似于用栈把cx的值保存起来，避免内循环扰乱cx的值
mov si,0
l2:mov ax,MEM[si]
cmp ax,0
jnz l3
xchg ax,MEM[si+2];因为是字数组
mov MEM[si],ax
l3:add si,2
loop l2
mov cx,di
loop l1

;此处只是输出功能与本程序无关，为直观看结果而已
mov cx,len
dec cx
mov si,0
l4:mov dl,byte ptr MEM[si]
add dl,30h
mov ah,2
int 21h
add si,2
loop l4

mov ah,4ch
int 21h
main endp
s3 ends
end main
