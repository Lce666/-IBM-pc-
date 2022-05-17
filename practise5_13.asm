;在string到string+99单元存放一个字符串，试编制一个程序测试该字符串是否存在数字。
;如有，则把cl的第五位置为1，否则将该位置为0
;关键处有两个：1.第五位置是哪个位置，2.如何把cl对应位置置1
s1 segment stack
dw 30h dup(?)
top label word
s1 ends

s2 segment
STRING db '1'
len dw $-STRING
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
mov cx,len
l1:mov al,STRING[si]
cmp al,30h
jb l2
cmp al,39h
ja l2
or bl,20h;or是将某几位置为1，而and是屏蔽某几位
jmp l3
l2:inc si
loop l1
and bl,0dfh
l3:mov cl,bl;此处因为cx作为循环计数器，所以先更改bl的值，再将其赋值给cl达到同样效果


;输出cl各位数，与程序无关，只是为了展示的直观性,且输出程序中给cx赋值会扰乱结果
;虽然可以直接输出cl第五位，但是数据有点单薄，i prefer show all
mov cx,8
l4:mov dx,30h
rol bl,1
adc dl,0
mov ah,2
int 21h
loop l4

mov ah,4ch
int 21h
main endp
s3 ends
end main