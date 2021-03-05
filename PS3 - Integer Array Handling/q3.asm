section .data
msg: db 'n = '
msg_l: equ $-msg
msg_sum: db 'sum = '
sum_l: equ $-msg_sum
msg_avg: db 10, 'avg = '
avg_l: equ $-msg_avg

section .bss
nod: resb 1
num: resw 1
sum: resw 1
avg: resw 1
temp: resb 1
counter: resw 1
num1: resw 1
num2: resw 1
n: resd 1
array: resw 50
matrix: resw 1
count: resb 1

section .text

global _start
_start:
    mov eax,  4
    mov ebx,  1
    mov ecx,  msg
    mov edx,  msg_l
    int 80h

    call read_num
    mov cx, word[num]
    mov word[n], cx

    mov ebx, array
    mov eax, 0
    call read_array
    mov ebx, array
    mov eax, 0
    mov dx, 0
    loop1:
        mov cx, word[ebx+2*eax]
        add dx, cx
        inc eax
        cmp eax, dword[n]
        jb loop1
        mov ax, dx
        mov word[sum], dx
        mov bx, word[n]
        mov dx, 0
        div bx
        mov word[avg], ax

        mov eax,  4
        mov ebx,  1
        mov ecx,  msg_sum
        mov edx,  sum_l
        int 80h

        mov ax, word[sum]
        mov word[num], ax
        call print_num

        mov eax,  4
        mov ebx,  1
        mov ecx,  msg_avg
        mov edx,  avg_l
        int 80h

        mov ax, word[avg]
        mov word[num], ax
        call print_num

    exit:
        mov eax, 1
        mov ebx, 0
        int 80h

read_num:
    pusha
    mov word[num],  0
    loop_read:
        mov eax,  3
        mov ebx,  0
        mov ecx,  temp
        mov edx,  1
        int 80h
        cmp byte[temp],  10
        je end_read
        mov ax,  word[num]
        mov bx,  10
        mul bx
        mov bl,  byte[temp]
        sub bl,  30h
        mov bh,  0
        add ax,  bx
        mov word[num],  ax
        jmp loop_read
    end_read:
        popa
        ret

read_array:
    pusha
    read_loop:
        cmp eax, dword[n]
        je end
        call read_num
        mov cx,  word[num]
        mov word[ebx+2*eax],  cx
        inc eax
        jmp read_loop
    end:
        popa
        ret

print_num:
    mov byte[count],  0
    pusha
    get_no:
        cmp word[num],  0
        je print_no
        inc byte[count]
        mov dx,  0
        mov ax,  word[num]
        mov bx,  10
        div bx
        push dx
        mov word[num],  ax
        jmp get_no
    print_no:
        cmp byte[count],  0
        je end_print
        dec byte[count]
        pop dx
        mov byte[temp],  dl
        add byte[temp],  30h
        mov eax,  4
        mov ebx,  1
        mov ecx,  temp
        mov edx,  1
        int 80h
        jmp print_no
    end_print:
        mov eax,  4
        mov ebx,  1
        mov ecx,  10
        mov edx,  1
        int 80h
        popa
        ret