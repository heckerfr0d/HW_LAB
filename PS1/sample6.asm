;Adding two 2-digit numbers
section .data
msg1 : db 'Enter first number: '
l1 : equ $-msg1
msg3 : db 'Enter second number: '
l3 : equ $-msg3
msg5 : db ' ', 10
l5 : equ $-msg5
section .bss
d1 : resb 1
d2 : resb 1
d3 : resb 1
d4 : resw 1
n1 : resb 1
n2 : resb 1
ans1 : resb 1
ans2 : resb 1
ans3 : resb 1
ans4 : resw 1
junk : resb 1
junk1 : resb 1
junk2 : resb 1
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
	mov edx, 1
	int 80h

	mov eax, 3
	mov ebx, 0
	mov ecx, junk1
	mov edx, 1
	int 80h

	;First number calculation

	
	mov al, byte[d1]
	sub al, 30h
	mov bl, 10
	mov ah, 0
	mul bl
	mov bx, word[d2]
	sub bx, 30h
	add ax, bx
	mov [n1], ax

	
	mov eax, 4
	mov ebx, 1
	mov ecx, msg3
	mov edx, l3
	int 80h

	mov eax, 3
	mov ebx, 0
	mov ecx, d3
	mov edx, 1
	int 80h

	mov eax, 3
	mov ebx, 0
	mov ecx, d4
	mov edx, 1
	int 80h
	
	
	;Second number calculation

	mov al, byte[d3]
	sub al, 30h
	mov bl, 10
	mov ah, 0
	mul bl
	mov bx, word[d4]
	sub bx, 30h
	add ax, bx
	
	;Adding both the numbers

	add ax,word[n1]

	;Added and stored in n1

	mov bl, 100
	mov ah, 0
	div bl
	add al, 30h
	mov [ans4], ah
	mov [ans1], al
	mov ax, word[ans4]
	mov bl, 10
	;mov ah, 0
	div bl
	add al, 30h
	add ah, 30h
	mov [ans2], al
	mov [ans3], ah
	
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

	mov eax, 4
	mov ebx, 1
	mov ecx, ans3
	mov edx, 1
	int 80h

	mov eax, 4
	mov ebx, 1
	mov ecx, msg5
	mov edx, l5
	int 80h

	mov eax, 1
	mov ebx, 0
	int 80h

























































