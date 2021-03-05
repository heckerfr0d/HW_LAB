section .data
msg1: db 'First Number: '
msg1_l: equ $-msg1
msg2: db 'Second Number: '
msg2_l: equ $-msg2
msg3: db 'The GCD is: '
msg3_l: equ $-msg3

section .bss
num: resw 1
temp: resb 1
n1: resw 1
n2: resw 1
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
    mov bx, word[n2]

    loop:
        mov dx, 0
        div bx
        cmp dx, 0
        je end
        mov ax, bx
        mov bx, dx
        jmp loop
    end:
        mov word[num], bx
        call print_num

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

print_num:
    mov byte[count], 0
    pusha
    get_no:
        cmp word[num], 0
        je print_no
        inc byte[count]
        mov dx, 0
        mov ax, word[num]
        mov bx, 10
        div bx
        push dx
        mov word[num], ax
        jmp get_no
    print_no:
        cmp byte[count], 0
        je end_print
        dec byte[count]
        pop dx
        mov byte[temp], dl
        add byte[temp], 30h
        mov eax, 4
        mov ebx, 1
        mov ecx, temp
        mov edx, 1
        int 80h
        jmp print_no
    end_print:
        mov eax, 4
        mov ebx, 1
        mov ecx, 10
        mov edx, 1
        int 80h
        popa
        ret