.text

.globl computer

computer:
	# generate a random number. number is now stored in $a0
	li $a1, 6
	li $v0, 42
	syscall
	
	move 	$s7, $a0	# $s7 is register used to indicate which column
	
	li 	$a1, 0		# indicates computer turn
	
	j 	place