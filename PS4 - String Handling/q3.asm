section .data
    msg1 : db 'String1 : '
    l1 : equ $-msg1
    msg3 : db 'String2 : '
    l3 : equ $-msg3
    msg2 : db 'string1 + string2: '
    l2 : equ $-msg2
    strlen: dw 0

section .bss
    string1 : resb 200
    string2 : resb 100
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
    mov edi, string1
    call read_str

    mov eax, 4
    mov ebx, 1
    mov ecx, msg3
    mov edx, l3
    int 80h

    ; mov edi, string2
    call read_str

    mov eax, 4
    mov ebx, 1
    mov ecx, msg2
    mov edx, l2
    int 80h

    mov esi, string1
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
        inc word[strlen]
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
