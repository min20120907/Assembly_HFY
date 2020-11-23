    .data
output: 
    .asciiz "The Result of fact(10) is "
    .text
main:

    li $v0, 4       # load prompt as ascii mode
    la $a0, output  # load string 
    syscall         # print it out

    li $a1, 10		# give a value 10 to argument
    jal fact		# call the procedure fact
    add $a0, $v1, $zero # set print value as $v1 (the result)
    li $v0, 1       # change mode to print_integer
    syscall         # print it out integer
    li $v0, 10      # exit the serial console
    syscall         # execute it out
    jr $ra			# return 0

fact:
    addi $sp, $sp, -8	# save return for 2 items
    sw $ra, 4($sp)		# save return address $ra
    sw $a1, 0($sp)		# save argument n
    slti $t0, $a1, 1	# test for n<1
    beq $t0, $zero, L1	# if n>=1, go to L1
    addi $v1, $zero, 1	# if n<1, return 1 ($v1 = 1)
    addi $sp, $sp, 8	# adjust $sp ro pop 2 items from stack ($ra, $a0)
    jr $ra			# return to caller

L1:
    addi $a1, $a1, -1	# if n >= 1: argument get (n-1)
    jal fact		# return to the caller

fact_return:
    lw $a1, 0($sp)		# return form jal: restore argument n
    lw $ra, 4($sp)		# restore the return address $ra
    addi $sp, $sp, 8	# adjust $sp to pop 4 items from stack ($ra, $a0)
    mul $v1, $a1, $v1	# return (n*fact(n-1))
    jr $ra	 		# return to the caller

