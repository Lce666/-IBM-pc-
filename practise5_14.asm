;首地址为TABLE的数组中按递增次序存放这100H个16位补码数，
;试编写程序吧出现次数最多的数及其出现的次数分别存放于ax和cx中

;注意这里递增次序需要好好利用，即相同的数必然是相邻排列的，当碰到不同的数时即可重新记录出现次数
;补码数不需要特别注意，因为比较是只有相等和不等的关系，次数也都为正数
;个人调试发现的问题，可能代码结构会导致，如果最后一个数跟前一个数一样，eg：1,2,3,3,3。
;会导致程序陷入死循环，debug也验证这个问题（已修复）
;假如有相同次数的两个数，则取更大的那个
;注意这里的栈空间要给大一点，因为每个重复的数都要入栈，虽然我们只取最后的栈顶元素
s1 segment stack
dw 100h dup(?)
top label word
s1 ends

s2 segment
TABLE1 dw 1,2,2,2,2,2,3,3,3,3;测试数据，本来应该是100h个数据
count dw ($-TABLE1)/2
string db 0dh,0ah,24h;无实际意义，只是为了输出程序的美观
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


mov bx,1;设置初始次数
mov dx,1
mov di,count
add di,count
mov cx,count
dec cx
l1:mov ax,TABLE1[si];先把第一个数当做哨兵
cmp si,di
je l4
cmp ax,TABLE1[si+2]
jnz l2
inc bx
cmp dx,bx;dx则作为出现次数最多的数的出现次数记录器
ja l3
push ax
mov dx,bx;如果当前次数大于已知最大次数则覆盖记录
l3:add si,2;此处循环是相同数的情况
loop l1
l2:mov bx,1;此处循环是碰到下一个不同数的情况
add si,2
loop l1

l4:mov cx,dx
pop ax;因为只有次数比前一个哨兵更多才能进栈，所以栈顶的元素即为出现次数最多的数

;输出程序，直观调试
mov dl,al
add dl,30h
mov ah,2
int 21h
lea dx,string
mov ah,9
int 21h
mov dl,cl
add dl,30h
mov ah,2
int 21h

mov ah,4ch
int 21h
main endp
s3 ends
end main
;让我来解释一下为何会出现死循环而我是如何避免的
;首先为什么会出现死循环，因为我采用的是先循环相同数的情况，假如最后一个数跟前一个相同时
;虽然最后一次循环时，第一个loop会放行，但是不相同数还有一层循环
;而loop的实际操作有两步，先cx-1，再判断cx是否为零，也就是说当上一次相同数循环已经把cx置为0
;但是接下来的loop再将cx减一变成0ffffh，又不为零，导致死循环，所以两层loop要尤其关注这种状况
;而我的解决方法仅仅是在开头判断当前数是否为最后一个数（实际上指针已经跑到最后一个数的下一个位置
;但是因为没有对内存进行任何操作，仅仅是确认位置所以没有问题
