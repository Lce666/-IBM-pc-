;试编写汇编程序，对键盘输入的小写字母用大写字母显示出来
s1 segment stack
dw 30h dup(?)
top label word
s1 ends

s2 segment 
s2 ends

s3 segment
assume ss:s1,ds:s2,cs:s3
main proc far
	mov ax,s1
	mov ss,ax
	mov ax,s2
	mov ds,ax
	lea sp,top
l1: mov ah,1
	int 21h
	cmp al,0dh
	je exit
	cmp al,61h;考虑输入的有效性，即输入要小写字母
	jb l1
	cmp al,7ah
	ja l1
	sub al,20h
	mov dl,al
	mov ah,2
	int 21h
	jmp l1
exit: mov ah,4ch
	int 21h
	main endp
s3 ends
end main
