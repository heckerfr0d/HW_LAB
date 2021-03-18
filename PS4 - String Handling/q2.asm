section .data
    msg1 : db 'Enter a string : '
    l1 : equ $-msg1
    msg2 : db 'The string reversed: '
    l2 : equ $-msg2

section .bss
    string : resb 200
    c : resb 1

section .text

    global _start:
	_start:

    mov eax, 4
    mov ebx, 1
    mov ecx, msg1
    mov edx, l1
    int 80h

    cld
    mov edi, string
    call read_str
    dec edi
    mov esi, string
    copy:
        cmp esi, edi
        jnb out
        mov al, byte[esi]
        mov cl, byte[edi]
        mov byte[edi], al
        mov byte[esi], cl
        dec edi
        inc esi
        jmp copy
    out:
        mov eax, 4
        mov ebx, 1
        mov ecx, msg2
        mov edx, l2
        int 80h
    cld
    mov esi, string
    call print_str
    exit:
    mov eax, 1
    mov ebx, 0
    int 80h

read_str:
    ;pusha
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
    ;popa
    ret

print_str:
    pusha
    pstr_loop:
        lodsb
        cmp al, 0
        je exit_pstr
        mov byte[c], al
        call print_char
        jmp pstr_loop
    exit_pstr:
    popa
    ret

print_char:
    pusha
    mov eax, 4
    mov ebx, 1
    mov ecx, c
    mov edx, 1
    int 80h
    popa
    ret
