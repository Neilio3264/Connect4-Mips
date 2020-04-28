.data

prompt1:	.asciiz  "  /$$$$$$                                                      /$$           /$$   /$$"
prompt2:	.asciiz "\n /$$__  $$                                                    | $$          | $$  | $$"
prompt3:	.asciiz "\n| $$  \__/  /$$$$$$  /$$$$$$$  /$$$$$$$   /$$$$$$   /$$$$$$$ /$$$$$$        | $$  | $$"
prompt4:	.asciiz "\n| $$       /$$__  $$| $$__  $$| $$__  $$ /$$__  $$ /$$_____/|_  $$_/        | $$$$$$$$"
prompt5:	.asciiz "\n| $$      | $$  \ $$| $$  \ $$| $$  \ $$| $$$$$$$$| $$        | $$          |_____  $$"
prompt6:	.asciiz "\n| $$    $$| $$  | $$| $$  | $$| $$  | $$| $$_____/| $$        | $$ /$$            | $$"
prompt7:	.asciiz "\n|  $$$$$$/|  $$$$$$/| $$  | $$| $$  | $$|  $$$$$$$|  $$$$$$$  |  $$$$/            | $$"
prompt8:	.asciiz "\n \______/  \______/ |__/  |__/|__/  |__/ \_______/ \_______/   \___/              |__/\n\n"


row1:		.asciiz "\n|_|_|_|_|_|_|_|"
row2:		.asciiz "\n|_|_|_|_|_|_|_|"
row3:		.asciiz "\n|_|_|_|_|_|_|_|"
row4:		.asciiz "\n|_|_|_|_|_|_|_|"
row5:		.asciiz "\n|_|_|_|_|_|_|_|"
row6:		.asciiz "\n|_|_|_|_|_|_|_|"


# Note: row 6 is the bottom of the board

.text

.globl main
.globl place
.globl loop
.globl print
.globl endGame
.globl row1
.globl row2
.globl row3
.globl row4
.globl row5
.globl row6

main:
	# save a few values as "globals"
	li	$s0, 0		# represents the bottom value of valid input range
	li	$s1, 6		# represents the top value of valid input range
	li	$s2, 0		# used to count the number of filled positions


	# Output the welcome sequence
	jal welcome
	
	jal print
	
loop:
	# player prompt
	jal player
	
	li $a1, 1	# indicates player
	jal place
	
	jal print
	
	j loop
	
place:    	
	# use $t0 to find the correct column
	# Note: remember that each row begins with \n
	# Note: assume |_ as one position. So need to skip 2 spots for a single index
	li	$t0, 2		# initialize to 1 for byte representation
	mult	$t0, $s7
	mflo	$t0	
	
	addi	$t0, $t0, 2	# to skip two bytes for \n and first |
	
	move 	$s5, $t0	# move correct placement position for later use
	
	# now check each row to find placement spot
	
	## row6 ##
	li	$s6, 6
	la	$a0, row6
	add	$a0, $a0, $s5	# find the exact location of the byte in question
	lb	$t0, 0($a0)
	
	# $a0 has the address of byte and $a1 has which player
	beq	$t0, '_', placeGrid
	
	## row5 ##
	li	$s6, 5
	la	$a0, row5
	add	$a0, $a0, $s5	# find the exact location of the byte in question
	lb	$t0, 0($a0)
	
	# $a0 has the address of byte and $a1 has which player
	beq	$t0, '_', placeGrid
	
	## row4 ##
	li	$s6, 4
	la	$a0, row4
	add	$a0, $a0, $s5	# find the exact location of the byte in question
	lb	$t0, 0($a0)
	
	# $a0 has the address of byte and $a1 has which player
	beq	$t0, '_', placeGrid
	
	## row3 ##
	li	$s6, 3
	la	$a0, row3
	add	$a0, $a0, $s5	# find the exact location of the byte in question
	lb	$t0, 0($a0)
	
	# $a0 has the address of byte and $a1 has which player
	beq	$t0, '_', placeGrid
	
	## row2 ##
	li	$s6, 2
	la	$a0, row2
	add	$a0, $a0, $s5	# find the exact location of the byte in question
	lb	$t0, 0($a0)
	
	# $a0 has the address of byte and $a1 has which player
	beq	$t0, '_', placeGrid
	
	## row1 ##
	li	$s6, 1
	la	$a0, row1
	add	$a0, $a0, $s5	# find the exact location of the byte in question
	lb	$t0, 0($a0)
	
	# $a0 has the address of byte and $a1 has which player
	beq	$t0, '_', placeGrid
	
	j columnFull
    	
print:
########## Stack ############
	# store original return to stack (to preserve it)
	addi    $sp, $sp, -4
    	sw      $ra, ($sp)
########## Stack ############
	# save all the row variables to temporary registers
	la $t1, row1
	la $t2, row2
	la $t3, row3
	la $t4, row4
	la $t5, row5
	la $t6, row6

	# call printGrid which is stored in printGrid.asm
	jal printGrid
	
########## Stack ############	
	# restore variables from stack
	lw      $ra, ($sp)
    	addi    $sp, $sp, 4
########## Stack ############
	
	jr $ra
	
######### terminate program ###########
endGame:
	li $v0, 10
	syscall
	







welcome:
	sw $ra, ($sp)

	###intro
	#f4
	li $a0, 65
	jal playGuitar

	jal waitFourTick
	#f4
	li $a0, 65
	jal playGuitar
	
	jal waitFourTick
	#f4
	li $a0, 65
	jal playGuitar

	jal waitFourTick
	#f4
	li $a0, 65
	jal playGuitar
	
	jal waitFourTick
	
connect4:
	li $v0, 4
	la $a0, prompt1
	syscall
	
	la $a0, prompt2
	syscall
	
	la $a0, prompt3
	syscall
	
	la $a0, prompt4
	syscall
	
	la $a0, prompt5
	syscall
	
	la $a0, prompt6
	syscall
	
	la $a0, prompt7
	syscall
	
	la $a0, prompt8
	syscall
	
introMusic:
	#g4
	li $a0, 67
	jal playPiano
	#3t
	jal waitThreeTick
	#a sharp 4
	li $a0, 70
	jal playPiano
	#3t
	jal waitThreeTick
	#d5
	li $a0, 74
	jal playPiano
	#2t
	jal waitTwoTick
	#c5
	li $a0, 72
	jal playPiano
	#2t
	jal waitTwoTick
	#a sharp 4
	li $a0, 70
	jal playPiano
	#2t
	jal waitTwoTick
	#g4
	li $a0, 67
	jal playPiano
	#4t
	jal waitFourTick

	#32
	#g4-p
	li $a0, 67
	jal playPiano
	#g3-g
	li $a0, 55
	jal playGuitar
	#g4-g
	li $a0, 67
	jal playGuitar
	#4t
	jal waitFourTick
	#a sharp 4 - g
	li $a0, 70
	jal playGuitar
	#a sharp 3 - g
	li $a0, 58
	jal playGuitar
	#2t
	jal waitTwoTick
	#f4 - p
	li $a0, 65
	jal playPiano
	#2t
	jal waitTwoTick
	#g4 - g
	li $a0, 67
	jal playGuitar
	#g3 - g
	li $a0, 55
	jal playGuitar
	#2t
	jal waitTwoTick
	#c4 - g
	li $a0, 60
	jal playGuitar
	#c5 - g
	li $a0, 72
	jal playGuitar
	#2t
	jal waitTwoTick
	#d4 - p
	li $a0, 62
	jal playPiano
	#a sharp 4 - g
	li $a0, 70
	jal playGuitar
	#a sharp 3 - g
	li $a0, 58
	jal playGuitar
	#2t
	jal waitTwoTick
	#e4 - p
	li $a0, 64
	jal playPiano
	#g3 - g
	li $a0, 55
	jal playGuitar
	#g4 - p
	li $a0, 67
	jal playPiano
	#2t
	jal waitTwoTick
	#48
	#d4 - p
	li $a0, 62
	jal playPiano
	#g4 - g
	li $a0, 67
	jal playGuitar
	#g3 - g
	li $a0, 55
	jal playGuitar
	#2t
	jal waitTwoTick
	#c4 - p
	li $a0, 60
	jal playPiano
	#2t
	jal waitTwoTick
	#a sharp 4 - g
	li $a0, 70
	jal playGuitar
	#a sharp 3 - g
	li $a0, 58
	jal playGuitar
	#4t
	jal waitFourTick
	#g4 - g
	li $a0, 67
	jal playGuitar
	#g3 - g
	li $a0, 55
	jal playGuitar
	#2t
	jal waitTwoTick

	#c5 - p
	li $a0, 72
	jal playPiano
	#c4 - p
	li $a0, 60 
	jal playPiano
	#c5 - g
	li $a0, 72
	jal playGuitar
	#c4 - g
	li $a0, 60 
	jal playGuitar
	#2t
	jal waitTwoTick
	#f4 - g
	li $a0, 65
	jal playGuitar
	#f3 - g
	li $a0, 53
	jal playGuitar
	#2t
	jal waitTwoTick
	#c5 - p
	li $a0, 72
	jal playPiano
	#c4 - p
	li $a0, 60
	jal playPiano
	#f sharp 4 - g
	li $a0, 66
	jal playGuitar
	#f sharp 3 - g
	li $a0, 54
	jal playGuitar
	#2t
	jal waitTwoTick
	###64
	#g4 - g
	li $a0, 67
	jal playGuitar
	#g3 - g
	li $a0, 55
	jal playGuitar
	#2t
	jal waitTwoTick
	#c5 - p
	li $a0, 72
	jal playPiano
	#c4 - p
	li $a0, 60
	jal playPiano
	#2t
	jal waitTwoTick
	#a sharp 4 - g
	li $a0, 70
	jal playGuitar
	#a sharp 3 - g
	li $a0, 58
	jal playGuitar
	#2t
	jal waitTwoTick
	#c5 - p
	li $a0, 72
	jal playPiano
	#c4 - p
	li $a0, 60
	jal playPiano
	#2t
	jal waitTwoTick
	#g4 - g
	li $a0, 67
	jal playGuitar
	#g3 - g
	li $a0, 55
	jal playGuitar
	#2t
	jal waitTwoTick
	#c5 - p
	li $a0, 72
	jal playPiano
	#c4 - p
	li $a0, 60
	jal playPiano
	#c5 - g
	li $a0, 72
	jal playGuitar
	#c4 - g
	li $a0, 60
	jal playGuitar
	#2t
	jal waitTwoTick
	#a sharp 4 - g
	li $a0, 70
	jal playGuitar
	#a sharp 3 - g
	li $a0, 58
	jal playGuitar
	#2t
	jal waitTwoTick

	#c5 - p
	li $a0, 72
	jal playPiano
	#c4 - p
	li $a0, 60
	jal playPiano
	#g4 - g
	li $a0, 67
	jal playGuitar
	#g3 - g
	li $a0, 55
	jal playGuitar
	#80
	#2t
	jal waitTwoTick
	
done:
	lw $ra, ($sp)
	jr $ra
	
#####
#   waitOneTick
#
#   waits 1 tick
#####
waitOneTick:
	li $a0, 100
	li $v0, 32
	syscall

	jr $ra

#####
#   waitTwoTick
#
#   waits 2 ticks
#####
waitTwoTick:
	li $a0, 200
	li $v0, 32
	syscall

	jr $ra

#####
#   waitThreeTick
#
#   waits 3 ticks
#####
waitThreeTick:
	li $a0, 300
	li $v0, 32
	syscall

	jr $ra

#####
#   waitFourTick
#
#   waits 3 ticks
#####
waitFourTick:
	li $a0, 400
	li $v0, 32
	syscall

	jr $ra

#####
#   playPiano
#
#   plays the pitch in piano
#####
playPiano:
	li $v0, 31
	li $a1, 200
	li $a2, 2
	li $a3, 50
	syscall

	jr $ra

#####
#   playGuitar
#
#   plays the pitch in guitar
#####
playGuitar:
	li $v0, 31
	li $a1, 200
	li $a2, 32
	li $a3, 50
	syscall

	jr $ra
