section .data
    msg1 : db 'String : '
    l1 : equ $-msg1
    msg2 : db 'largest word: '
    l2 : equ $-msg2
    msg3 : db 'smallest word: '
    l3 : equ $-msg3
    zero: db '0'
    nl: db 10
    num: dw 1
    len: dw 1
    mlen: dw 0
    slen: dw 1000

section .bss
    string : resb 200
    c : resb 1
    large: resd 1
    small: resd 1
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

    mov edi, string
    mov al, 32

    loop:
        cmp byte[edi], 0
        je out
        scasb
        je skip
        inc word[len]
        jmp loop
    skip:
        mov bx, word[len]
        mov word[len], 1
        cmp bx, word[mlen]
        jna skip2
        mov word[mlen], bx
        mov dword[large], edi
        sub word[large], bx
    skip2:
        cmp bx, word[slen]
        jnb skip3
        mov word[slen], bx
        mov dword[small], edi
        sub word[small], bx
    skip3:
        jmp loop
    out:
        mov eax, 4
        mov ebx, 1
        mov ecx, msg2
        mov edx, l2
        int 80h
        mov eax, 4
        mov ebx, 1
        mov ecx, dword[large]
        movzx edx, word[mlen]
        int 80h

        mov eax, 4
        mov ebx, 1
        mov ecx, nl
        mov edx, 1
        int 80h

        mov eax, 4
        mov ebx, 1
        mov ecx, msg3
        mov edx, l3
        int 80h
        mov eax, 4
        mov ebx, 1
        mov ecx, dword[small]
        movzx edx, word[slen]
        int 80h
    exit:
    mov eax, 1
    mov ebx, 0
    int 80h

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
    mov byte[edi], 32
    inc edi
    mov byte[edi], 0
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