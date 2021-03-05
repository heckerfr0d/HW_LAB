;Comparing Two one digit numbers
section .data
msg1 : db 'Enter first number: '
l1 : equ $-msg1
msg2 : db 'Enter second number: '
l2 : equ $-msg2

section .bss
d1 : resb 1
d2 : resb 1
junk : resb 1

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
	mov ecx, junk
	mov edx, 1
	int 80h

	mov eax, 4
	mov ebx, 1
	mov ecx, msg2
	mov edx, l2
	int 80h

	mov eax, 3
	mov ebx, 0
	mov ecx, d2
	mov edx, 1
	int 80h

	sub byte[d1], 30h
	sub byte[d2], 30h

	mov al, byte[d1]
	cmp al, byte[d2]
	ja if

	else :
		add byte[d2], 30h
		mov eax, 4
		mov ebx, 1
		mov ecx, d2
		mov edx, 1
		int 80h

		jmp L

	if:
		add byte[d1], 30h
		mov eax, 4
		mov ebx, 1
		mov ecx, d1
		mov edx, 1
		int 80h
	L:

	mov eax, 1
	mov ebx, 0
	int 80h



























