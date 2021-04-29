 .data
    msg1: .asciiz "String : "
    msg2: .asciiz "largest word: "
    msg3: .asciiz "smallest word: "
    nl: .asciiz "\n"

    string: .space 64

 .text

    .globl main
	main:

    li $v0, 4
    la $a0, msg1
    syscall

    li $v0, 8
    la $a0, string
    li $a1, 64
    syscall

    la $a0, string
    li $t1, 0
    li $t2, 0
    li $t3, 100
    li $s4, ' '
    li $s5, 10

    loop:
        lb $t0, 0($a0)
        addi    $a0, $a0, 1
        beqz    $t0, out
        addi    $t1, $t1, 1
        beq		$t0, $s4, skip	# if $t0 == $t1 then target
        beq		$t0, $s5, skip	# if $t0 == $t1 then target
        j loop
    skip:
        bgt $t2, $t1, skip2
        move $t2, $t1
        move $t5, $a0
        sub $t5, $t5, $t2
    skip2:
        bgt $t1, $t3, skip3
        move $t3, $t1
        move $t6, $a0
        sub $t6, $t6, $t3
    skip3:
        li $t1, 0
        j loop
    out:
        add		$t7, $t5, $t2		# $t7 = $51 + $t2
        sb		$zero, 0($t7)		# 

        li $v0, 4
        la $a0, msg2
        syscall

        li $v0, 4
        move $a0, $t5
        syscall
        li $v0, 4

        la $a0, nl
        syscall

        add		$t7, $t6, $t3		# $t7 = $51 + $t2
        sb		$zero, 0($t7)		# 

        li $v0, 4
        la $a0, msg3
        syscall

        li $v0, 4
        move $a0, $t6
        syscall
    exit:
    li $v0, 4
    la $a0, nl
    syscall
    li $v0, 10
    syscall

