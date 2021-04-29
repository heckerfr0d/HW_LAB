 .data
    msg1: .asciiz "String1: "
    msg3: .asciiz "String2: "
    msg2: .asciiz "string1 + string2: "
    string1: .space 64
    nl: .byte 10

    .globl main
 .text

	main:

    li $v0, 4
    la $a0, msg1
    syscall

    li $v0, 8
    la $a0, string1
    li $a1, 32
    syscall
    loop:
        lb $t1, 0($a0)
        beq $t1, 10, out
        addi $a0, $a0, 1
        j loop
    out:
        move $s1, $a0
    li $v0, 4
    la $a0, msg3
    syscall

    li $v0, 8
    move $a0, $s1
    li $a1, 32
    syscall

    li $v0, 4
    la $a0, msg2
    syscall

    li $v0, 4
    la $a0, string1
    syscall
    exit:
    li $v0, 10
    syscall

