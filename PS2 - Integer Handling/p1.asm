section .data
msg1 : db 'First Number: '
msg1_l: equ $-msg1
msg2 : db 'Second Number: '
msg2_l: equ $-msg2
msg3 : db 'Third Number: '
msg3_l: equ $-msg3

section .bss
a1: resb 1
a2: resb 1
n1: resb 1
junk1: resb 1
b1: resb 1
b2: resb 1
n2: resb 1
junk2: resb 1
c1: resb 1
c2: resb 1
n3: resb 1

section .text

global main:
    main:
    mov eax, 4
    mov ebx, 1
    mov ecx, msg1
    mov edx, msg1_l
    int 80h

    mov eax, 3
    mov ebx, 0
    mov ecx, a1
    mov edx, 1
    int 80h

    mov eax, 3
    mov ebx, 0
    mov ecx, a2
    mov edx, 1
    int 80h

    mov eax, 3
    mov ebx, 0
    mov ecx, junk1
    mov edx, 1
    int 80h

    mov al, byte[a1]
    sub al, 30h
    mov bl, 10
    mov ah, 0
    mul bl
    mov bx, word[a2]
    sub bx, 30h
    add ax, bx
    mov [n1], ax

    mov eax, 4
    mov ebx, 1
    mov ecx, msg2
    mov edx, msg2_l
    int 80h

    mov eax, 3
    mov ebx, 0
    mov ecx, b1
    mov edx, 1
    int 80h

    mov eax, 3
    mov ebx, 0
    mov ecx, b2
    mov edx, 1
    int 80h

    mov eax, 3
    mov ebx, 0
    mov ecx, junk2
    mov edx, 1
    int 80h

    mov al, byte[b1]
    sub al, 30h
    mov ah, 0
    mov bl, 10
    mul bl
    mov bx, word[b2]
    sub bx, 30h
    add ax, bx
    mov [n2], ax

    mov eax, 4
    mov ebx, 1
    mov ecx, msg3
    mov edx, msg3_l
    int 80h

    mov eax, 3
    mov ebx, 0
    mov ecx, c1
    mov edx, 1
    int 80h

    mov eax, 3
    mov ebx, 0
    mov ecx, c2
    mov edx, 1
    int 80h

    mov al, byte[c1]
    sub al, 30h
    mov ah, 0
    mov bl, 10
    mul bl
    mov bx, word[c2]
    sub bx, 30h
    add ax, bx
    mov [n3], ax

    mov ax, word[n1]
    cmp ax, word[n2]
    ja if1

    else1:
        mov ax, word[n2]
        cmp ax, word[n3]
        jna b
        else2:
            mov ax, word[n1]
            cmp ax, word[n3]
            jna c
        else3:
            jmp a

    if1:
        mov ax, word[n2]
        cmp ax, word[n3]
        ja b
        else4:
            mov ax, word[n1]
            cmp ax, word[n3]
            ja c
        else5:
            jmp a

    a:
        mov eax, 4
        mov ebx, 1
        mov ecx, a1
        mov edx, 1
        int 80h

        mov eax, 4
        mov ebx, 1
        mov ecx, a2
        mov edx, 1
        int 80h
        jmp exit

    b:
        mov eax, 4
        mov ebx, 1
        mov ecx, b1
        mov edx, 1
        int 80h

        mov eax, 4
        mov ebx, 1
        mov ecx, b2
        mov edx, 1
        int 80h
        jmp exit

    c:
        mov eax, 4
        mov ebx, 1
        mov ecx, c1
        mov edx, 1
        int 80h

        mov eax, 4
        mov ebx, 1
        mov ecx, c2
        mov edx, 1
        int 80h
        jmp exit

    exit:
        mov eax, 1
        mov ebx, 0
        int 80h
