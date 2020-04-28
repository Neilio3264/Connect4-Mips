.data
tieMsg:			.asciiz "The game ends in a tie.\n"

playerWinMsg:		.asciiz "\n\nPlayer 1 wins!\n"

compWinMsg:		.asciiz "\n\nComputer wins!\n"

.text

.globl checkWin

# All the code for the checking
checkWin:
	addi    $sp, $sp, -8
    	sw	$ra, 0($sp)
    	sw	$s6, 4($sp)

# Check if they player won vertically. Determines which row to start at
# then check from that one -> down
checkVert:
	li	$t0, 0
	li	$t2, 4
	li	$t3, 4
	
	slt	$t2, $t2, $s6
	bne	$t2, $zero, checkHor

	li	$t2, 1
	beq	$t2, $s6, checkRowOneV

	li      $t2, 2
        beq     $t2, $s6, checkRowTwoV

	li      $t2, 3
        beq     $t2, $s6, checkRowThreeV

	j	checkHor

checkRowOneV:
	la      $a0, row1
        add     $a0, $a0, $s5

        lb      $t1, 0($a0)

	bne	$a2, $t1, checkHor

	addi	$t0, $t0, 1	

checkRowTwoV:

	la      $a0, row2
        add     $a0, $a0, $s5

        lb      $t1, 0($a0)

        bne     $a2, $t1, checkHor

        addi    $t0, $t0, 1

checkRowThreeV:
	la      $a0, row3
        add     $a0, $a0, $s5

        lb      $t1, 0($a0)

        bne     $a2, $t1, checkHor

        addi    $t0, $t0, 1

	
	la      $a0, row4
        add     $a0, $a0, $s5

        lb      $t1, 0($a0)

        bne     $a2, $t1, checkHor

        addi    $t0, $t0, 1

	beq	$t0, $t3, winGame


	la      $a0, row5
        add     $a0, $a0, $s5

        lb      $t1, 0($a0)

        bne     $a2, $t1, checkHor

        addi    $t0, $t0, 1

        beq     $t0, $t3, winGame


	la      $a0, row6
        add     $a0, $a0, $s5

        lb      $t1, 0($a0)

        bne     $a2, $t1, checkHor

        addi    $t0, $t0, 1

        beq     $t0, $t3, winGame

	j	checkHor

# Gets the address for a row
getAddress:
	li	$t2, 1
	beq	$t2, $s6, getRow1
	
	li      $t2, 2
        beq     $t2, $s6, getRow2

	li      $t2, 3
        beq     $t2, $s6, getRow3

	li      $t2, 4
        beq     $t2, $s6, getRow4

	li      $t2, 5
        beq     $t2, $s6, getRow5

	li      $t2, 6
        beq     $t2, $s6, getRow6

	j	checkTie


getRow1:
	la	$a0, row1
	jr	$ra

getRow2:

	la	$a0, row2
	jr	$ra

getRow3:
	
	la	$a0, row3
	jr	$ra

getRow4:

	la	$a0, row4
	jr	$ra

getRow5:

	la	$a0, row5
	jr	$ra

getRow6:

	la	$a0, row6
	jr	$ra

# Checks if they player won horizontally
checkHor:
	jal	getAddress

	add	$a0, $a0, $s5

	li	$t0, 1		# for count
	move	$a3, $a0
	li	$t5, 4
	li	$t2, 15
	move	$t1, $s5

# Counts tokens to the right of the placed token
checkHorRight:
	slt	$t3, $t1, $t2
	beq	$t3, $zero, checkHorLeft
	addi	$a3, $a3, 2

	lb      $t6, 0($a3)

        bne     $a2, $t6, checkHorLeft

	addi	$t0, $t0, 1
	slt	$t6, $t0, $t5
	beq	$t6, $zero, winGame
	
	addi	$t1, $t1, 2

	j	checkHorRight
	
# Counts to the left of the placed token
checkHorLeft:
	li	$t0, 1		# for count
	move	$t1, $s5
	move	$a3, $a0
	li	$t2, 2

checkHorLeftLoop:
	slt     $t3, $t1, $t2
        beq     $t3, $zero, checkTie
        addi    $a3, $a3, -2

        lb      $t6, 0($a3)

        bne     $s2, $t6, checkDiagUpRight

        addi    $t0, $t0, 1
        slt     $t6, $t0, $t5
        beq     $t6, $zero, winGame
        
        addi	$t1, $t1, -2

        j       checkHorLeftLoop
        
checkDiagUpRight:
	li	$t0, 1		# for count
	li	$t2, 16
	move	$t1, $s5
	
checkDiagUpRightLoop:
	slt     $t3, $t1, $t2
        bne     $t3, $zero, checkDiagUpLeft
        
        addi	$s6, $s6, -1
        
        jal	getAddress
        
        add	$a0, $a0, $t1
        
        addi	$a0, $a0, 2

	lb      $t6, 0($a0)

        bne     $a2, $t6, checkDiagUpLeft

	addi	$t0, $t0, 1
	slt	$t6, $t0, $t5
	beq	$t6, $zero, winGame
	
	addi	$t1, $t1, 2

	j	checkDiagUpRightLoop
	
checkDiagUpLeft:
	lw	$s6, 4($sp)

	li	$t0, 1		# for count
	li	$t2, 2
	move	$t1, $s5
	
checkDiagUpLeftLoop:
	slt     $t3, $t1, $t2
        beq     $t3, $zero, checkDiagDownRight
        
        addi	$s6, $s6, -1
        
        jal	getAddress
        
        add	$a0, $a0, $t1
        
        addi	$a0, $a0, -2

	lb      $t6, 0($a0)

        bne     $a2, $t6, checkDiagDownRight

	addi	$t0, $t0, 1
	slt	$t6, $t0, $t5
	beq	$t6, $zero, winGame
	
	addi	$t1, $t1, -2

	j	checkDiagUpLeftLoop
	
checkDiagDownRight:
	lw	$s6, 4($sp)
	
	li	$t0, 1		# for count
	li	$t2, 16
	move	$t1, $s5
	
checkDiagDownRightLoop:
	slt     $t3, $t1, $t2
        bne     $t3, $zero, checkDiagDownLeft
        
        addi	$s6, $s6, 1
        
        jal	getAddress
        
        add	$a0, $a0, $t1
        
        addi	$a0, $a0, 2

	lb      $t6, 0($a0)

        bne     $a2, $t6, checkDiagDownLeft

	addi	$t0, $t0, 1
	slt	$t6, $t0, $t5
	beq	$t6, $zero, winGame
	
	addi	$t1, $t1, 2

	j	checkDiagDownRightLoop
        
checkDiagDownLeft:
	lw	$s6, 4($sp)
	
	li	$t0, 1		# for count
	li	$t2, 2
	move	$t1, $s5
	
checkDiagDownLeftLoop:
	slt     $t3, $t1, $t2
        beq     $t3, $zero, checkTie
        
        addi	$s6, $s6, 1
        
        jal	getAddress
        
        add	$a0, $a0, $t1
        
        addi	$a0, $a0, -2

	lb      $t6, 0($a0)

        bne     $a2, $t6, checkTie

	addi	$t0, $t0, 1
	slt	$t6, $t0, $t5
	beq	$t6, $zero, winGame
	
	addi	$t1, $t1, -2

	j	checkDiagDownLeftLoop
	

# Checks if a tie occured	
checkTie:
	addi	$s2, $s2, 1
	li	$t0, 42
	beq	$s2, $t0, tieGame
	
	beq	$a1, 1, computer
	
	lw	$ra, ($sp)
	
	addi	$sp, $sp, 8
	
	jr	$ra

# Used to determine if a player won the game
winGame:
	beq	$a1,1, playerWin
	j	compWin

playerWin:
	jal	print

	li      $v0, 4
        la      $a0, playerWinMsg
        syscall

	j	endGame

compWin:
	jal	print

        li      $v0, 4
        la      $a0, compWinMsg
        syscall

        j       endGame

tieGame:
	jal	print
	
	li      $v0, 4
        la      $a0, tieMsg
        syscall