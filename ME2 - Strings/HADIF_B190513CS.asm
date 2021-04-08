section .data
    msg1 : db 'String : '
    l1 : equ $-msg1
    msg2 : db 'Output : '
    l2 : equ $-msg2
    nl: db 10
    num: db 0
    numup: db 0

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

    mov eax, 4
    mov ebx, 1
    mov ecx, msg2
    mov edx, l2
    int 80h

    mov esi, string
    loop:
        cmp esi, edi
        jnb exit
        cmp byte[esi], '0'
        setnc bl
        cmp byte[esi], '9'+1
        setc bh
        and bl, bh
        mov byte[num], bl
        cmp byte[esi], 'A'
        setnc bl
        cmp byte[esi], 'Z'+1
        setc bh
        and bl, bh
        or bl, byte[num]
        mov byte[numup], bl
        cmp byte[esi], 'a'
        setnc bl
        cmp byte[esi], 'z'+1
        setc bh
        and bl, bh
        or bl, byte[numup]
        cmp bl, 0
        je incl

        cmp byte[edi], '0'
        setnc bl
        cmp byte[edi], '9'+1
        setc bh
        and bl, bh
        mov byte[num], bl
        cmp byte[edi], 'A'
        setnc bl
        cmp byte[edi], 'Z'+1
        setc bh
        and bl, bh
        or bl, byte[num]
        mov byte[numup], bl
        cmp byte[edi], 'a'
        setnc bl
        cmp byte[edi], 'z'+1
        setc bh
        and bl, bh
        or bl, byte[numup]
        cmp bl, 0
        je decr

        mov al, byte[esi]
        mov ah, byte[edi]
        mov byte[edi], al
        mov byte[esi], ah
        inc esi
        dec edi
        jmp loop
    incl:
        inc esi
        jmp loop
    decr:
        dec edi
        jmp loop

    exit:
        mov esi, string
        call print_str
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

print_str:
    pusha
    cld
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