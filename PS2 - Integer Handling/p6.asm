section .data
msg1: db 'Number: '
msg1_l: equ $-msg1
msg2: db 10,'Prime'
msg2_l: equ $-msg2
msg3: db 10,'not Prime'
msg3_l: equ $-msg3

section .bss
num: resw 1
temp: resb 1
count: resb 1

section .text
global _start:
_start:
    mov eax, 4
    mov ebx, 1
    mov ecx, msg1
    mov edx, msg1_l
    int 80h

    call read_num

    mov cx, 2
    loop:
        mov ax, word[num]
        cmp cx, ax
        je prime
        mov dx, 0
        div cx
        cmp dx, 0
        je not
        inc cx
        jmp loop
    not:
        mov eax, 4
        mov ebx, 1
        mov ecx, msg3
        mov edx, msg3_l
        int 80h
        jmp exit
    prime:
        mov eax, 4
        mov ebx, 1
        mov ecx, msg2
        mov edx, msg2_l
        int 80h
    exit:
        mov eax, 1
        mov ebx, 0
        int 80h

read_num:
    pusha
    mov word[num], 0
    loop_read:
        mov eax, 3
        mov ebx, 0
        mov ecx, temp
        mov edx, 1
        int 80h
        cmp byte[temp], 10
        je end_read
        mov ax, word[num]
        mov bx, 10
        mul bx
        mov bl, byte[temp]
        sub bl, 30h
        mov bh, 0
        add ax, bx
        mov word[num], ax
        jmp loop_read
    end_read:
        popa
        ret
