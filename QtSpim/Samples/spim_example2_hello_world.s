# "Hello World" in MIPS assembly
# From: http://labs.cs.upt.ro/labs/so2/html/resources/nachos-doc/mipsf.html
	
	
	.text

	
	.globl	main
	

main:
	
	li	$v0,4		# Code for syscall: print_string
	la	$a0, msg	# Pointer to string (load the address of msg)
	syscall
	li	$v0,10		# Code for syscall: exit
	syscall

	
	.data

	
msg:	.asciiz	"Hello World!\n"