.data
playerTurnInst:		.asciiz "\nPlease enter a number between 1 and 7 (inclusive)"
playerTurn: 		.asciiz "\nPlayer's turn: "

illegalColumnMsg: 	.asciiz "\n\nIllegal column number. Try again\n\n"

.text

.globl player

# All the code for the player inputs
player:
	# store original $a0 and return to stack (to preserve it)
	addi    $sp, $sp, -8
    	sw      $a0, ($sp)
    	sw	$ra, 4($sp)
    	
prompt:
    	# print the prompts and take the input
	li      $v0, 4
    	la    	$a0, playerTurnInst
    	syscall
    	li      $v0, 4
    	la    	$a0, playerTurn
    	syscall
    	li	$v0, 5		# get user input and save it to $v0
    	syscall
    	
    	# range of inputs should be from 0 to 6 and the prompt asked for 1 to 7 for simplisty
    	# therefore, subtract 1 by default to reduce range by 1
    	addi 	$v0, $v0, -1
    	
    	# jump to inputCheck to check for valid input
    	# Note: the input is stored in $v0
    	jal inputCheck
    	
    	# take the valid input and return using $s7
    	move 	$s7, $v0
    	
    	j done
    	
inputCheck:
	# check if within (0, 6) using "globals" stored is $s0, $s1
	sle 	$t0, $v0, $s1	# bool inRange = (input <= 6)
	sge	$t1, $v0, $s0	# bool inRange = (input >= 0)
	
	beq	$t0, $zero, invalid
	beq	$t1, $zero, invalid
	
	jr $ra
	
invalid:
	li      $v0, 4
    	la    	$a0, illegalColumnMsg
    	syscall
    	
    	j prompt
    	
done:
	# restore variables from stack
	lw      $a0, ($sp)
    	lw	$ra, 4($sp)
    	addi    $sp, $sp, 8
    	
    	# return back to main
    	jr $ra
