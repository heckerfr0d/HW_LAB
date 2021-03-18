section .data
    msg1 : db 'String : '
    l1 : equ $-msg1
    msg2 : db 'n(vowels) =  '
    l2 : equ $-msg2
    msga : db 'n(a) =  '
    la : equ $-msga
    msge : db 'n(e) =  '
    le : equ $-msge
    msgi : db 'n(i) =  '
    li : equ $-msgi
    msgo : db 'n(o) =  '
    lo : equ $-msgo
    msgu : db 'n(u) =  '
    lu : equ $-msgu
    zero: db '0'
    nl: db 10
    num: dw 0
    a: dw 0
    e: dw 0
    i: dw 0
    o: dw 0
    u: dw 0
    v: dw 0

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
    loop:
        cmp byte[esi], 0
        je out
        lodsb
        cmp al, 'a'
        jne skipa
        inc word[a]
        inc word[v]
    skipa:
        cmp al, 'e'
        jne skipe
        inc word[e]
        inc word[v]
    skipe:
        cmp al, 'i'
        jne skipi
        inc word[i]
        inc word[v]
    skipi:
        cmp al, 'o'
        jne skipo
        inc word[o]
        inc word[v]
    skipo:
        cmp al, 'u'
        jne skipu
        inc word[u]
        inc word[v]
    skipu:
        jmp loop
    out:
        mov ax, word[v]
        mov word[num], ax
        mov eax, 4
        mov ebx, 1
        mov ecx, msg2
        mov edx, l2
        int 80h
        call print_num

        mov ax, word[a]
        mov word[num], ax
        mov eax, 4
        mov ebx, 1
        mov ecx, msga
        mov edx, la
        int 80h
        call print_num
        
        mov ax, word[e]
        mov word[num], ax
        mov eax, 4
        mov ebx, 1
        mov ecx, msge
        mov edx, le
        int 80h
        call print_num

        mov ax, word[i]
        mov word[num], ax
        mov eax, 4
        mov ebx, 1
        mov ecx, msgi
        mov edx, li
        int 80h
        call print_num

        mov ax, word[o]
        mov word[num], ax
        mov eax, 4
        mov ebx, 1
        mov ecx, msgo
        mov edx, lo
        int 80h
        call print_num

        mov ax, word[u]
        mov word[num], ax
        mov eax, 4
        mov ebx, 1
        mov ecx, msgu
        mov edx, lu
        int 80h
        call print_num
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
    mov byte[edi], 0
    popa
    ret

print_num:
    cmp word[num], 0
    je print0
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
    print0:
        mov eax, 4
        mov ebx, 1
        mov ecx, zero
        mov edx, 1
        int 80h
    end_print:
        mov eax, 4
        mov ebx, 1
        mov ecx, nl
        mov edx, 1
        int 80h
        popa
        ret
