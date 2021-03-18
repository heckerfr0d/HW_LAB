section .data
    msg1 : db 'String1 : '
    l1 : equ $-msg1
    msg3 : db 'String2 : '
    l3 : equ $-msg3
    msg2 : db 'The strings are equal',10
    l2 : equ $-msg2
    msg4 : db 'The strings differ at position '
    l4 : equ $-msg4

section .bss
    string1 : resb 100
    string2 : resb 100
    c : resb 1
    count: resb 1
    temp: resb 1
    num: resw 1

section .text

    global _start:
	_start:

    mov eax, 4
    mov ebx, 1
    mov ecx, msg1
    mov edx, l1
    int 80h

    cld
    mov edi, string1
    call read_str

    mov eax, 4
    mov ebx, 1
    mov ecx, msg3
    mov edx, l3
    int 80h

    mov edi, string2
    call read_str

    mov esi, string1
    mov edi, string2
    loop:
        cmpsb
        jne no
        cmp byte[esi-1], 0
        je out
        jmp loop
    out:
        mov eax, 4
        mov ebx, 1
        mov ecx, msg2
        mov edx, l2
        int 80h
    exit:
    mov eax, 1
    mov ebx, 0
    int 80h
no:
    sub esi, string1
    mov word[num], si
    mov eax, 4
    mov ebx, 1
    mov ecx, msg4
    mov edx, l4
    int 80h
    call print_num
    jmp exit

read_str:
    pusha
    rstr_loop:
        mov eax, 3
        mov ebx, 0
        mov ecx, c
        mov edx, 1
        int 80h
        mov al, byte[c]
        cmp al, 0Ah
        je exit_rstr
        stosb
        jmp rstr_loop

    exit_rstr:
    mov byte[edi], 0
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