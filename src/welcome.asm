.data
prompt1:	.asciiz  "________/\\\\\\\\\___________________________________________________________________________________________________________/\\\____        "
prompt2:	.asciiz "\n _____/\\\////////__________________________________________________________________________________________________________/\\\\\____       "
prompt3:	.asciiz "\n  ___/\\\/______________________________________________________________________________________/\\\_______________________/\\\/\\\____      "
prompt4:	.asciiz "\n   __/\\\_________________/\\\\\_____/\\/\\\\\\____/\\/\\\\\\_______/\\\\\\\\______/\\\\\\\\__/\\\\\\\\\\\________________/\\\/\/\\\____     "
prompt5:	.asciiz "\n    _\/\\\_______________/\\\///\\\__\/\\\////\\\__\/\\\////\\\____/\\\/////\\\___/\\\//////__\////\\\////_______________/\\\/__\/\\\____    "
prompt6:	.asciiz "\n     _\//\\\_____________/\\\__\//\\\_\/\\\__\//\\\_\/\\\__\//\\\__/\\\\\\\\\\\___/\\\____________\/\\\_________________/\\\\\\\\\\\\\\\\_   "
prompt7:	.asciiz "\n      __\///\\\__________\//\\\__/\\\__\/\\\___\/\\\_\/\\\___\/\\\_\//\\///////___\//\\\___________\/\\\_/\\____________\///////////\\\//__  "
prompt8:	.asciiz "\n       ____\////\\\\\\\\\__\///\\\\\/___\/\\\___\/\\\_\/\\\___\/\\\__\//\\\\\\\\\\__\///\\\\\\\\____\//\\\\\_______________________\/\\\____ "
prompt9:	.asciiz "\n        _______\/////////_____\/////_____\///____\///__\///____\///____\//////////_____\////////______\/////________________________\///_____"

.globl welcome

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
	
	la $a0, prompt9
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