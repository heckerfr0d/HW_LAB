; printing 0 to that number
section .data
msg1: db 'Enter a number',10
l1: equ $-msg1

section .bss
d1: resb 1
d2: resb 1
num: resw 1
sum: resw 1
counter: resw 1
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

	mov eax, 3
	mov ebx, 0
	mov ecx, d1
	mov edx, 1
	int 80h

	mov eax, 3
	mov ebx, 0
	mov ecx, d2
	mov edx, 2
	int 80h

	sub byte[d1], 30h
    sub byte[d2], 30h
    mov al, byte[d1]
    mov bl, 10
    mov ah, 0
    mul bl
    mov bl, byte[d2]
    mov bh, 0
	add ax, bx

    mov word[num], ax
	mov word[sum], 0
	mov byte[counter], 0

	for:
        mov ax, word[counter]
        mov bl, 2
        div bl
        cmp ah, 0
        jne no
        mov ax, word[counter]
        add word[sum], ax
        no:
		add byte[counter], 1
		mov ax, word[counter]
		cmp ax, word[num]
		jna for

    call print_num

	mov eax, 1
	mov ebx, 0
	int 80h

print_num:
    mov byte[count], 0
    pusha
    get_no:
        cmp word[sum], 0
        je print_no
        inc byte[count]
        mov dx, 0
        mov ax, word[sum]
        mov bx, 10
        div bx
        push dx
        mov word[sum], ax
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
    end_print:
        mov eax, 4
        mov ebx, 1
        mov ecx, 10
        mov edx, 1
        int 80h
        popa
        ret