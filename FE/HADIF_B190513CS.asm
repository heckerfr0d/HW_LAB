section .data
    msg1 : db 'String : '
    l1 : equ $-msg1
    msg2 : db 'Output : '
    l2 : equ $-msg2
    zero: db '0'
    num: dw 0

section .bss
    string : resb 200
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

        mov esi, string
        mov eax, 4
        mov ebx, 1
        mov ecx, msg2
        mov edx, l2
        int 80h
        call print_str
    exit:
        mov eax, 1
        mov ebx, 0
        int 80h

read_str:
    pusha
    mov ecx, 0
    rstr_loop:
        push ecx
        mov eax, 3
        mov ebx, 0
        mov ecx, c
        mov edx, 1
        int 80h
        pop ecx
        mov al, byte[c]
        cmp al, 0Ah
        je exit_rstr
        cmp al, '('
        jne skipop
        inc ecx
    skipop:
        cmp al, ')'
        jne skipcl
        dec ecx
    skipcl:
        cmp ecx, 0
        jl skips
        stosb
        jmp rstr_loop
    skips:
        inc ecx
        jmp rstr_loop

    exit_rstr:
    mov al, ')'
    add_loop:
        cmp ecx, 0
        je term
        stosb
        dec ecx
        jmp add_loop
    term:
    mov byte[edi], 0
    popa
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