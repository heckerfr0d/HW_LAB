
# HW LAB

Just Balcony Things 🙂

## Functions

### Integers

```asm
read_num:
    pusha
    mov word[num],  0
    loop_read:
        mov eax,  3
        mov ebx,  0
        mov ecx,  temp
        mov edx,  1
        int 80h
        cmp byte[temp],  10
        je end_read
        mov ax,  word[num]
        mov bx,  10
        mul bx
        mov bl,  byte[temp]
        sub bl,  30h
        mov bh,  0
        add ax,  bx
        mov word[num],  ax
        jmp loop_read
    end_read:
        popa
        ret
```

```asm
read_array:
    pusha
    read_loop:
        cmp eax, dword[n]
        je end
        call read_num
        mov cx,  word[num]
        mov word[ebx+2*eax],  cx
        inc eax
        jmp read_loop
    end:
        popa
        ret
```

```asm
print_num:
    mov byte[count],  0
    pusha
    get_no:
        cmp word[num],  0
        je print_no
        inc byte[count]
        mov dx,  0
        mov ax,  word[num]
        mov bx,  10
        div bx
        push dx
        mov word[num],  ax
        jmp get_no
    print_no:
        cmp byte[count],  0
        je end_print
        dec byte[count]
        pop dx
        mov byte[temp],  dl
        add byte[temp],  30h
        mov eax,  4
        mov ebx,  1
        mov ecx,  temp
        mov edx,  1
        int 80h
        jmp print_no
    end_print:
        mov eax,  4
        mov ebx,  1
        mov ecx,  10
        mov edx,  1
        int 80h
        popa
        ret
```

```asm
print array:
    pusha
    print_loop:
        cmp eax,dword[n]
        je end_print1
        mov cx,word[ebx+2*eax]
        mov word[num],cx
        call print_num
        inc eax
        jmp print_loop
    end_print1:
        popa
        ret
```

```asm
; finds the frequency of num in array of size n
get_freq:
    pusha
    mov ebx, array
    mov ecx, 0
    mov dx, 0
    loopf:
        mov ax, word[ebx+2*ecx]
        cmp word[num], ax
        jne nof
        inc dx
    nof:
        inc ecx
        cmp ecx, dword[n]
        jb loopf
    mov word[freq], dx
    popa
    ret
```

```asm
;read and find smallest and largest in array
read_array1:
    pusha
    read_loop:
        cmp eax, 10
        je end
        call read_num
        mov cx,  word[num]
        mov word[ebx+2*eax],  cx
        cmp word[large], cx
        ja skipl
        mov word[large], cx
    skipl:
        cmp word[small], cx
        jb skips
        mov word[small], cx
    skips:
        inc eax
        jmp read_loop
    end:
        popa
        ret
```

```asm
; search for q in array of size n
search:
    pusha
    mov ebx, array
    mov ecx, 0
    search_loop:
        mov ax , word[ebx+2*ecx]
        cmp ax, word[q]
        je found
        inc ecx
        cmp ecx, dword[n]
        jb search_loop
    mov word[num], 0
    jmp end_search
    found:
        mov word[num], 1
    end_search:
        popa
        ret
```

### Strings

```asm
read_str:
    pusha
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
    popa
    ret
```

```asm
; read string and store address of each word in variable in ebx and count of words in nw
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
```

```asm
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
```

```asm
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
```

```asm
; compares 2 words in esi, edi and sets l=1 if esi>edi
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
```

```asm
checks if substring in edi is in string in esi
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
```
