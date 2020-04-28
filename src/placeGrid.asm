.data
playerSym:	.asciiz "X"
compSym:	.asciiz	"O"

full:		.asciiz "\n\nColumn is full. Try again.\n"

.text

.globl placeGrid
.globl columnFull

# All the code for the player inputs
placeGrid:
	beq $a1, $zero, placeComp
	
placePlayer:
	# load playerSym
	la $t3, playerSym
	lb $t3, ($t3)
	
	# store X in correct position
	sb $t3, ($a0)
	
	# check if this is the win
	move $a2, $t3	# move the Sym as an argument
	j checkWin

placeComp:
	la $t3, compSym
	lb $t3, ($t3)
	
	# store X in correct position
	sb $t3, ($a0)
	
	move $a2, $t3	# move the Sym as an argument
	j checkWin
	
columnFull:
    	beq	$a1, 0, computer	# don't inform player that computer needs to rechoose
    	
    	li      $v0, 4
    	la    	$a0, full
    	syscall
	
	j loop
