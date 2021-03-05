section .data
msg1: db "n = "
size1: equ $-msg1
msg3: db "query : "
size3: equ $-msg3
msg_found: db "Element found at position : "
size_found: equ $-msg_found
msg_not: db "Element not found"
size_not: equ $-msg_not

section .bss
array: resw 50 ;Array to store 50 elements of 1 word each.
n: resw 1
q: resw 1
num: resw 1
count: resb 1
temp: resb 1

section .text
global _start
_start:
;Printing the message to enter the number
    mov eax, 4
    mov ebx, 1
    mov ecx, msg1
    mov edx, size1
    int 80h
;Reading the number
    call read_num
    mov ax, word[num]
    mov word[n], ax

    mov ebx, array
    mov eax, 0
    call read_array

;Reading the number to be searched :.....
    mov eax, 4
    mov ebx, 1
    mov ecx, msg3
    mov edx, size3
    int 80h

;Reading the number
    call read_num
    mov ax, word[num]
    mov word[q], ax

    mov ebx, array
    mov ecx, 0

search:
    mov ax , word[ebx+2*ecx]
    mov word[num], cx
    cmp ax, word[q]
    je found
    add ecx, 1
    cmp cx, word[n]
    jb search

    mov eax, 4
    mov ebx, 1
    mov ecx, msg_not
    mov edx, size_not
    int 80h

exit:
    mov eax, 1
    mov ebx, 0
    int 80h

found:
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_found
    mov edx, size_found
    int 80h
    add word[num], 1
    call print_num
    jmp exit

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