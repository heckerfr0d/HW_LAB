section .data
    msg1 : db 'Enter a string : '
    l1 : equ $-msg1
    msg2 : db 'The string is a palindrome', 10
    l2 : equ $-msg2
    msg3 : db 'The string is not a palindrome', 10
    l3 : equ $-msg3
    space : db ' '

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

    mov esi, string
    dec edi
    compare:
        lodsb
        cmp al, byte[edi]
        jne not
        cmp edi, string
        je pal
        dec edi
        jmp compare

    pal:
        mov eax, 4
        mov ebx, 1
        mov ecx, msg2
        mov edx, l2
        int 80h
        jmp exit
    not:
        mov eax, 4
        mov ebx, 1
        mov ecx, msg3
        mov edx, l3
        int 80h
    exit:
    mov eax, 1
    mov ebx, 0
    int 80h

read_str:
    ; pusha
    cld
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
    ; popa
    ret

