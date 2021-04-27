	.data
prompt:	.asciiz "n : "
space: .asciiz	" "
nl: .asciiz "\n"
	.globl	main
	
	.text
main:

	# initialize 
	li	$s0, 10
	li  $t0, 0
    li  $t1, 1
    li  $t2, 0
	# prompt for input
	li	$v0, 4
	la	$a0, prompt
	syscall

	# read in the value
	li	$v0, 5
	syscall
	move 	$s0, $v0

	
loop:	
	# print loop value
	li	$v0, 1
	move	$a0, $t0
	syscall

	# print space
	li	$v0, 4
	la	$a0, space
	syscall

    add  $t2, $t0, $t1
    move $t0, $t1
    move $t1, $t2
	# decrement loop value and branch if not negative
	addi	$s0, $s0, -1
	bgez	$s0, loop

	li $v0, 4
    la $a0, nl
    syscall
	li	$v0, 10
	syscall