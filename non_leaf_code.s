main:
li $a0, 10		# give a value 10 to argument
jal fact		# call the procedure fact
syscall		  # return 0
jr $ra			# return 0

fact:
addi $sp, $sp, -8	# save return for 2 items
sw $ra, 4($sp)		# save return address $ra
sw $a0, 0($sp)		# save argument n
slti $t0, $a0, 1	# test for n<1
beq $t0, $zero, L1	# if n>=1, go to L1
addi $v0, $zero, 1	# if n<1, return 1 ($v0 = 1)
addi $sp, $sp, 8	# adjust $sp ro pop 2 items from stack ($ra, $a0)
jr $ra			# return to caller

L1:
addi $a0, $a0, -1	# if n >= 1: argument get (n-1)
jal fact		# return to the caller

fact_return:
lw $a0, 0($sp)		# return form jal: restore argument n
lw $ra, 4($sp)		# restore the return address $ra
addi $sp, $sp, 8	# adjust $sp to pop 4 items from stack ($ra, $a0)
mul $v0, $a0, $v0	# return (n*fact(n-1))
jr $ra	 		# return to the caller

