; printing 0 to that number
section .data
msg1 : db 'Enter a number',10
l1 : equ $-msg1

section .bss
d1 : resb 1
counter : resb 1

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
	sub byte[d1], 30h
	mov byte[counter], 0

	for:
		add byte[counter], 30h
		mov eax, 4
		mov ebx, 1
		mov ecx, counter
		mov edx, 1
		int 80h
		sub byte[counter], 30h
		add byte[counter], 1
		mov al, byte[counter]
		cmp al, byte[d1]
		jna for

	mov eax, 1
	mov ebx, 0
	int 80h