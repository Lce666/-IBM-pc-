;已知数组A包含15个互不相等的整数，数组B包含20个互不相等的整数
;试编写程序，把既在A中又在B中出现的整数存放于数组C中
;本题就是很简单的双指针问题
s1 segment stack
dw 30h dup(?)
top label word
s1 ends

s2 segment
arrayA dw 1,2,3,4,7;测试数据只有少量具有代表性的，便于调试
lenA dw ($-arrayA)/2
arrayB dw 2,3,5,6,7
lenB dw ($-arrayB)/2
arrayC dw 10h dup(?)
s2 ends

s3 segment
assume ss:s1,ds:s2,cs:s3
main proc far
mov ax,s1
mov ss,ax
mov ax,s2
mov ds,ax
lea sp,top

xor si,si
xor di,di
xor bx,bx
mov cx,lenA;养成习惯，最好不要直接输入意义不明的立即数，而是用变量储存，这样方便理解
l1:mov ax,arrayA[si]
push cx
mov cx,lenB
l2:mov dx,arrayB[di]
cmp ax,dx
je l3
add di,2
loop l2
l4:xor di,di
add si,2
pop cx
loop l1
l3:cmp cx,0;此处的判断是否数组A已经遍历完成，避免死循环（因为下面有个jmp无条件跳转，即使cx已经为零也会死循环）
je l6
mov arrayC[bx],ax
add bx,2
jmp l4

;输出程序，用于测试
l6:mov cx,bx
shr cx,1
xor si,si
l5:mov dl,byte ptr arrayC[si]
add dl,30h
mov ah,2
int 21h
add si,2
loop l5

mov ah,4ch
int 21h
main endp
s3 ends
end main