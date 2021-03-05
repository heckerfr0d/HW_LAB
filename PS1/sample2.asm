section .data
msg1 :db 'Enter your name : ',
l1 : equ $-msg1

section .bss
name : resb 1
l : resb 1

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
	mov ecx, name
	mov edx, l
	int 80h

	mov eax, 4
	mov ebx, 1
	mov ecx, name
	mov edx, l
	int 80h

	mov eax, 1
	mov ebx, 0
	int 80h