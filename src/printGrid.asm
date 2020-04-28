.text

.globl printGrid

# take each row which are stored in $t registers respectively
printGrid:
	# store original $a0 to stack (to preserve it)
	addi    $sp, $sp, -4
    	sw      $a0, ($sp)
    	# output row1 from t1
    	li      $v0, 4
    	move    $a0, $t1
    	syscall
    	# output row2 from t2
    	move    $a0, $t2
    	syscall
    	# output row3 from t3
    	move    $a0, $t3
    	syscall
    	# output row4 from t4
    	move    $a0, $t4
    	syscall
    	# output row5 from t5
    	move    $a0, $t5
    	syscall
    	# output row6 from t6
    	move    $a0, $t6
    	syscall
    	
    	# restore $a0 from stack
    	lw      $a0, ($sp)
    	addi    $sp, $sp, 4

    	# return from function
    	jr      $ra
