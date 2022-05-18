;设在A,B和C单元中分别存放着三个数，若三个数都不是0，则求出三数之和并放在D单元中
;若其中有个数为0，则把其他两个单元也清零
s1 segment stack
dw 30h dup(?)
top label word
s1 ends

s2 segment
A db 9
B db 1
C1 db 5;C是汇编的保留字，所以需要写成C1
D dw ?
s2 ends

s3 segment
assume ss:s1,ds:s2,cs:s3
main proc far
mov ax,s1
mov ss,ax
mov ax,s2
mov ds,ax
lea sp,top

mov al,A
cmp al,0
je l1
mov bl,B
cmp bl,0
je l1
mov cl,C1
cmp cl,0
jne l2
l1:mov A,0
mov B,0
mov C1,0
jmp l4

l2:add al,bl;防止溢出
adc ah,0
add al,cl
adc ah,0
mov D,ax

;输出模块，仅用于调试
l4:mov si,0
mov cx,3
l3:mov dl,A[si]
add dl,30h
mov ah,2
int 21h
inc si
loop l3

mov ah,4ch
int 21h
main endp
s3 ends
end main
