section .data
msg_large: db 'largest = '
large_l: equ $-msg_large
msg_small: db 10, 'smallest = '
small_l: equ $-msg_small
zero: db '0'
zero_l: equ $-zero

section .bss
num: resw 1
large: resw 1
small: resw 1
temp: resb 1
counter: resw 1
n: resd 1
array: resw 50
count: resb 1

section .text

global _start
_start:
    mov word[large], 0
    mov word[small], 128

    mov ebx, array
    mov eax, 0
    call read_array1

    mov eax,  4
    mov ebx,  1
    mov ecx,  msg_large
    mov edx,  large_l
    int 80h

    mov ax, word[large]
    mov word[num], ax
    call print_num

    mov eax,  4
    mov ebx,  1
    mov ecx,  msg_small
    mov edx,  small_l
    int 80h

    mov ax, word[small]
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

read_array1:
    pusha
    read_loop:
        cmp eax, 10
        je end
        call read_num
        mov cx,  word[num]
        mov word[ebx+2*eax],  cx
        cmp word[large], cx
        ja skipl
        mov word[large], cx
    skipl:
        cmp word[small], cx
        jb skips
        mov word[small], cx
    skips:
        inc eax
        jmp read_loop
    end:
        popa
        ret

print_num:
    cmp word[num], 0
    je print0
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
    print0:
        mov eax,  4
        mov ebx,  1
        mov ecx,  zero
        mov edx,  zero_l
        int 80h
        jmp end_print