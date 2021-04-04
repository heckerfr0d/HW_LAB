section .data
    msg1 : db 'String : '
    l1 : equ $-msg1
    msg2 : db 'Output : '
    l2 : equ $-msg2
    zero: db '0'
    space: db ' '
    nl: db 10

section .bss
    string : resb 200
    string1: resb 200
    c : resb 1
    count: resb 1
    temp: resb 1

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

    mov eax, 4
    mov ebx, 1
    mov ecx, msg2
    mov edx, l2
    int 80h

    mov al, 32

    loop:
        std
        cmp edi, string
        je exit
        scasb
        je skip
        jmp loop
    skip:
        mov esi, edi
        add esi, 2
        call print_word
        jmp loop

    exit:
    mov esi, edi
    call print_word
    mov eax, 1
    mov ebx, 0
    int 80h

read_str:
    ; pusha
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

print_word:
    pusha
    cld
    pstr_loop:
        lodsb
        cmp al, 32
        je exit_pstr
        cmp al, 0
        je exit_pstr
        mov byte[c], al
        call print_char
        jmp pstr_loop
    exit_pstr:
        mov eax, 4
        mov ebx, 1
        mov ecx, space
        mov edx, 1
        int 80h
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