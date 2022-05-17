s1 segment stack
    dw 100h dup(?)
top label word
s1 ends

s2 segment
string1 db 'abcdff'
len1 db $-string1
string2 db 'abcdff'
len2 db $-string2
result1 db 'MATCH',0dh,0ah,24h
result2 db 'NO MATCH',0dh,0ah,24h
s2 ends

s3 segment
assume ss:s1,ds:s2,cs:s3
main proc far
    mov ax,s1
    mov ss,ax
    mov ax,s2
    mov ds,ax
    mov es,ax
    lea sp,top
    lea si,string1
    lea di,string2
    mov bl,len1
    ;mov bh,len2
    cmp bl,len2
    jne l1
    xor cx,cx
    mov cl,len1
    inc cl
    cld
    repe cmpsb
    cmp cx,0
    jne l1
    lea dx,result1
    jmp l2
l1: lea dx,result2
l2: mov ah,9
    int 21h
    mov ah,4ch
    int 21h
main endp
s3 ends
end main