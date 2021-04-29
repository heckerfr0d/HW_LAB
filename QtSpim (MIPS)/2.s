.data  
    msg: .asciiz "n1: "
    msg2: .asciiz "n2: "
    msg3: .asciiz "Twin primes!"
    msg4: .asciiz "Not twin primes!"
    space: .byte ' '
    nl: .byte 10

.text

    main:

    li $v0, 4
    la $a0, msg
    syscall

    li $v0, 5
    syscall
    move $s0, $v0

    li $v0, 4
    la $a0, msg2
    syscall

    li $v0, 5
    syscall
    move $s1, $v0

    sub $t3, $s1, $s0
    abs $t3, $t3

    bne $t3, 2, nott

    jal check_prime
    move $s0, $s1
    jal check_prime

    li $v0, 4
    la $a0, msg3
    syscall
    j exit

    nott:
        li $v0, 4
        la $a0, msg4
        syscall
    exit:
        li $v0, 4
        la $a0, nl
        syscall
        li $v0, 10
        syscall

check_prime:
    li $t2, 2
    prime_loop:
        beq $t2, $s0, exit_prime_loop
        div $s0, $t2
        mfhi $t1
        beq $t1, $zero, nott
        addi $t2, $t2, 1
        j prime_loop

    exit_prime_loop:
        jr $ra