; Adding Two one digit numbers
section .data
msg1 : db 'Enter first digit: '
l1 : equ $-msg1
msg2 : db 'Enter second digit: '
l2 : equ $-msg2

section .bss
d1 : resb 1
d2 : resb 1
ans1 : resb 1
ans2 : resb 1
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
	mov ax, word[d1]
	add ax, word[d2]

	mov bl, 10
	mov ah, 0
	div bl

	mov byte[ans1], al
	mov byte[ans2], ah
	add byte[ans1], 30h
	add byte[ans2], 30h

	mov eax, 4
	mov ebx, 1
	mov ecx, ans1
	mov edx, 1
	int 80h

	mov eax, 4
	mov ebx, 1
	mov ecx, ans2
	mov edx, 1
	int 80h

	mov eax, 1
	mov ebx, 0
	int 80h

















