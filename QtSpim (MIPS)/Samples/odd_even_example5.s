.text 
.globl	main
	
# The label 'main' represents the starting point
main:

        j loop

loop:
        la $a0, prompt
        li $v0, 4
        syscall

        # Read in value
        li $v0, 5
        syscall

        # If number is negative, exit program.
        slt $t0, $v0, $zero
        bne $t0, $zero, exit

        # Call even_or_odd on value
        add $a0, $v0, $zero
        jal even_or_odd
        j loop

even_or_odd:
        addi $t0, $zero, 2 # Set divisor to 2
        div $a0, $t0
        mfhi $t0           # Save remainder
        beq $t0, $zero, even
        j odd

even:
        la $a0, even_msg        
        li $v0, 4
        syscall
        j return
odd:
        la $a0, odd_msg
        li $v0, 4
        syscall
        j return

return:
        lw $t0, 0($sp)  
        addi $sp, $sp, 4
        jr $ra

exit:
        la $a0, goodbye 
        li $v0, 4
        syscall

        li $v0, 10
        syscall
.data
        prompt: .asciiz "\nEnter a integer: "
        even_msg: .asciiz "\nThe number is even.\n"
        odd_msg: .asciiz "\nThe number is odd.\n"
        goodbye: .asciiz "\nGoodbye!\n"
