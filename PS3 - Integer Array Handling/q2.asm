section .data
msg: db 'n = '
msg_l: equ $-msg
msg_7: db 'multiples of 7: '
seven_l: equ $-msg_7
sep: db ','
sep_l: equ $-sep
endc: db 8, '.'
endc_l: equ $-endc

section .bss
num: resw 1
seven: resw 1
temp: resb 1
counter: resw 1
n: resd 1
array: resw 50
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

    mov eax,  4
    mov ebx,  1
    mov ecx,  msg_7
    mov edx,  seven_l
    int 80h

    mov ebx, array
    mov ecx, 0
    mov dx, 0
    loop1:
        mov ax, word[ebx+2*ecx]
        mov word[num], ax
        mov byte[temp], 7
        div byte[temp]
        cmp ah, 0
        jne continue
        call print_num
    continue:
        inc ecx
        cmp ecx, dword[n]
        jb loop1

        mov eax,  4
        mov ebx,  1
        mov ecx,  endc
        mov edx,  endc_l
        int 80h

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
        mov ecx,  sep
        mov edx,  sep_l
        int 80h
        popa
        ret