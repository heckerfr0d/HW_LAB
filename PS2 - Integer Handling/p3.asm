section .data
msg1: db 'First Number: '
msg1_l: equ $-msg1
msg2: db 'Second Number: '
msg2_l: equ $-msg2
yes: db 'First is a multiple of second', 10
yes_l: equ $-yes
no: db 'First is not a multiple of second', 10
no_l: equ $-no

section .bss
num: resw 1
n1: resw 1
n2: resw 1
temp: resb 1

section .text

global _start:
    _start:
        mov eax, 4
        mov ebx, 1
        mov ecx, msg1
        mov edx, msg1_l
        int 80h

        call read_num
        mov cx, word[num]
        mov word[n1], cx

        mov eax, 4
        mov ebx, 1
        mov ecx, msg2
        mov edx, msg2_l
        int 80h

        call read_num
        mov cx, word[num]
        mov word[n2], cx

        mov ax, word[n1]
        mov dx, 0
        div cx
        cmp dx, 0
        je multiple
        else:
            mov eax, 4
            mov ebx, 1
            mov ecx, no
            mov edx, no_l
            int 80h

    exit:
        mov eax, 1
        mov ebx, 0
        int 80h
    
        multiple:
            mov eax, 4
            mov ebx, 1
            mov ecx, yes
            mov edx, yes_l
            int 80h
            jmp exit

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
