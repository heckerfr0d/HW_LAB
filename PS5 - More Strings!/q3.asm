section .data
    msg1 : db 'String : '
    l1 : equ $-msg1
    msg4: db 'Output : '
    l4 : equ $-msg4
    space: db ' '
    nl: db 10
    words: times 50 dd 0
    nw: dd 0
    l: db 0

section .bss
    string : resb 200
    find: resb 100
    replace: resb 100
    c : resb 1
    count: resb 1
    temp: resb 1
    t1: resd 1
    t2: resd 2

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
    mov ebx, words
    call read_words

    mov eax, 4
    mov ebx, 1
    mov ecx, msg4
    mov edx, l4
    int 80h

    mov ebx, words
    mov ecx, 0
    dec word[nw]
    loop:
        cmp ecx, dword[nw]
        jnb out
        mov edx, 0
        inc ecx
        in_loop:
            cmp edx, dword[nw]
            jnb loop
            mov esi, dword[ebx+4*edx]
            mov edi, dword[ebx+4*edx+4]
            mov byte[l], 0
            call comp_words
            cmp byte[l], 0
            je skip
            mov dword[ebx+4*edx], edi
            mov dword[ebx+4*edx+4], esi
            skip:
            inc edx
            jmp in_loop
        jmp loop
    out:
    printl:
        cmp dword[ebx], 0
        je exit
        mov esi, dword[ebx]
        call print_word
        add ebx, 4
        jmp printl
    exit:
    mov eax, 1
    mov ebx, 0
    int 80h

read_words:
    pusha
    rstr_loop:
        mov dword[ebx], edi
        inc dword[nw]
        rwrd_loop:
            push ebx
            mov eax, 3
            mov ebx, 0
            mov ecx, c
            mov edx, 1
            int 80h
            pop ebx
            mov al, byte[c]
            cmp al, 32
            je exit_rwrd
            cmp al, 10
            je exit_rstr
            stosb
            jmp rwrd_loop
        exit_rwrd:
        cmp al, 0Ah
        je exit_rstr
        stosb
        add ebx, 4
        jmp rstr_loop

    exit_rstr:
    mov byte[edi], 0
    popa
    ret

comp_words:
    pusha
    comp_loop:
        cmp byte[esi], 32
        je end_cmp
        cmp byte[edi], 32
        je end_cmp
        cmpsb
        je comp_loop
        jb end_cmp
        mov byte[l], 1
    end_cmp:
        popa
        ret

print_word:
    pusha
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