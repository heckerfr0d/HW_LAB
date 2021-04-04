section .data
    msg1 : db 'String : '
    l1 : equ $-msg1
    msg2 : db 'Remove : '
    l2 : equ $-msg2
    msg4: db 'Output : '
    l4 : equ $-msg4
    space: db ' '
    nl: db 10
    f: db 0

section .bss
    string : resb 200
    nstring: resb 200
    find: resb 100
    lenf: resd 1
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

    mov edi, find
    call read_str

    sub edi, find
    mov dword[lenf], edi

    mov eax, 4
    mov ebx, 1
    mov ecx, msg4
    mov edx, l4
    int 80h

    mov esi, string
    mov edi, nstring

    loop:
        cmp byte[esi], 0
        je out
        mov byte[f], 0
        call comp_substr
        cmp byte[f], 0
        jne found
        movsb
        jmp loop
    found:
        add esi, dword[lenf]
        jmp loop

    out:
        mov esi, nstring
        call print_word
    exit:
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

comp_substr:
    pusha
    mov edi, find
    comp_loop:
        cmpsb
        jne check_end
        jmp comp_loop
    check_end:
        cmp byte[edi-1], 0
        jne check_send
        mov byte[f], 1
        popa
        ret
    check_send:
        cmp byte[esi-1], 0
        jne notf
        mov byte[f], 1
        popa
        ret
    notf:
        popa
        ret

print_word:
    ; pusha
    pstr_loop:
        lodsb
        cmp al, 0
        je exit_pstr
        mov byte[c], al
        call print_char
        jmp pstr_loop
    exit_pstr:
        mov eax, 4
        mov ebx, 1
        mov ecx, nl
        mov edx, 1
        int 80h
        ; popa
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