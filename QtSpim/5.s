 .data
    msg1: .asciiz "String : "
    msg2: .asciiz "Find : "
    msg3: .asciiz "Replace : "
    msg4: .asciiz "Output : "

    string: .space 100
    find: .space 100
    replace: .space 100
    space: .byte ' '
    nl: .byte 10

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

    li $v0, 4
    la $a0, msg2
    syscall

    li $v0, 8
    la $a0, find
    li $a1, 32
    syscall
  
    li $v0, 4
    la $a0, msg3
    syscall

    li $v0, 8
    la $a0, replace
    li $a1, 32
    syscall

    li $v0, 4
    la $a0, msg4
    syscall

    la $s0, string
    la $s1, find
    li $s7, ' '
    li $s6, 10

    loop:
        lb $t0, 0($s0)
        beq $t0, $s6, exit
        beq $t0, $zero, exit
        bne $t0, $s7, skip
        addi $s0, $s0, 1
        j loop
    skip:
        la $s1, find
        li $s2, 0
        move $s3, $s0
        jal comp_word
        bnez $s2, found
        move $s0, $s3
        jal print_word
        j loop
    found:
        move $s3, $s0
        la $s0, replace
        jal print_word
        move $s0, $s3
        li $v0, 11
        move $a0, $s7
        syscall
        j loop

    exit:
        li $v0, 4
        la $a0, nl
        syscall
        li $v0, 10
        syscall


comp_word:
    comp_loop:
        lb $t2, 0($s0)
        lb $t1, 0($s1)
        bne $t2, $t1, check_end
        addi $s0, $s0, 1
        addi $s1, $s1, 1
        j comp_loop
    check_end:
        bne    $t1, $s6, notf
        li $s2, 1
        jr		$ra					# jump to $ra

    notf:
        jr		$ra					# jump to $ra
        

print_word:
    lb $t3, 0($s0)
    addi $s0, $s0, 1
    beq $t3, $s6, out
    beq $t3, 10, out
    li $v0, 11
    move $a0, $t3
    syscall
    beq $t3, $s7, out
    beq $t3, $zero, out
    j print_word
    out:
    jr		$ra					# jump to $ra
    