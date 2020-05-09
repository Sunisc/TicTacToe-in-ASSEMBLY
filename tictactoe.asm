.data 0x10010000
values:		.word 0,0,0, 0,0,0, 0,0,0 #array of values for the tic tac toe
moves: 		.word 0 #number of values in the array
turn: 		.word 2 #1 is O and 2 is X
wintext: 	.asciiz "Somebody won"

.text 0x00400000
main:
#	li $t1, 4
#	lw $t0, values($t1)
    lui     $sp, 0x1001         # Initialize stack pointer to the 64th location above start of data
    ori     $sp, $sp, 0x0100    # top of the stack will be the word at address [0x100100fc - 0x100100ff]
                                #   because $sp is decremented first.

    addi    $fp, $sp, -4        # Set $fp to the start of main's stack frame
    
    
# listen to key input, depending on certain keys put the char on the screen, and also update the values array    
key_loop:
	#check if there are already 9 moves made	
	li	$t0, 0
	lw	$t1, moves($t0)
	beq	$t1, 9, draw
	
	jal 	get_key
	li    	$a0, 75
    	jal    	pause
	beq	$v0, $0, key_loop
		
key1: 
	bne 	$v0, 1, key2 	#jump if not the right key
	
	#load the turn value
	li	$s0, 0		#use this to load the turn value
	lw	$a0, turn($s0)	#the turn value is the character offset in the bitmap memory
	
	##call the putchar to put it on the screen
	li	$a1, 2
	li	$a2, 2
	jal	putChar_atXY
	
	#reload again if the value was potentially lost?
	li	$s0, 0
	lw	$a0, turn($s0)
	
	#save the character value in the array
	li	$t0, 0
	sw	$a0, values($t0)
	
	#increment the move number
	jal	increment
	
	#check for the win condition here, if this is true then the game ends so yah
	jal	checkWin
	
	#reload again if the value was potentially lost?
	li	$s0, 0
	lw 	$a0, turn($s0)
	
	#change the turn to the new character
	beq	$a0, 2, subtractone
	beq	$a0, 1, addone
		
key2:
	bne	$v0, 2, key3

	#load the turn value
	li	$s0, 0		#use this to load the turn value
	lw	$a0, turn($s0)	#the turn value is the character offset in the bitmap memory
	
	##call the putchar to put it on the screen
	li	$a1, 4
	li	$a2, 2
	jal	putChar_atXY
	
	#reload again if the value was potentially lost?
	li	$s0, 0
	lw	$a0, turn($s0)
	
	#save the character value in the array
	li	$t0, 4
	sw	$a0, values($t0)
	
	#increment the move number
	jal	increment
	
	#check for the win condition here, if this is true then the game ends so yah
	jal	checkWin		
	
	#reload again if the value was potentially lost?
	li	$s0, 0
	lw 	$a0, turn($s0)
	
	#change the turn to the new character
	beq	$a0, 2, subtractone
	beq	$a0, 1, addone
key3:
	bne 	$v0, 3, key4
	
	#load the turn value
	li	$s0, 0		#use this to load the turn value
	lw	$a0, turn($s0)	#the turn value is the character offset in the bitmap memory
	
	##call the putchar to put it on the screen
	li	$a1, 6
	li	$a2, 2
	jal	putChar_atXY
	
	#reload again if the value was potentially lost?
	li	$s0, 0
	lw	$a0, turn($s0)
	
	#save the character value in the array
	li	$t0, 8
	sw	$a0, values($t0)
	
	#increment the move number
	jal	increment	

	#check for the win condition here, if this is true then the game ends so yah
	jal	checkWin
			
	#reload again if the value was potentially lost?
	li	$s0, 0
	lw 	$a0, turn($s0)
	
	#change the turn to the new character
	beq	$a0, 2, subtractone
	beq	$a0, 1, addone
key4:
	bne 	$v0, 4, key5
	
	#load the turn value
	li	$s0, 0		#use this to load the turn value
	lw	$a0, turn($s0)	#the turn value is the character offset in the bitmap memory
	
	##call the putchar to put it on the screen
	li	$a1, 2
	li	$a2, 4
	jal	putChar_atXY
	
	#reload again if the value was potentially lost?
	li	$s0, 0
	lw	$a0, turn($s0)
	
	#save the character value in the array
	li	$t0, 12
	sw	$a0, values($t0)
	
	#increment the move number
	jal	increment
	
	#check for the win condition here, if this is true then the game ends so yah
	jal	checkWin
	
	#reload again if the value was potentially lost?
	li	$s0, 0
	lw 	$a0, turn($s0)
	
	#change the turn to the new character
	beq	$a0, 2, subtractone
	beq	$a0, 1, addone
key5:
	bne 	$v0, 5, key6
	
	#load the turn value
	li	$s0, 0		#use this to load the turn value
	lw	$a0, turn($s0)	#the turn value is the character offset in the bitmap memory
	
	##call the putchar to put it on the screen
	li	$a1, 4
	li	$a2, 4
	jal	putChar_atXY
	
	#reload again if the value was potentially lost?
	li	$s0, 0
	lw	$a0, turn($s0)
	
	#save the character value in the array
	li	$t0, 16
	sw	$a0, values($t0)
	
	#increment the move number
	jal	increment
	
	#check for the win condition here, if this is true then the game ends so yah
	jal	checkWin
	
	#reload again if the value was potentially lost?
	li	$s0, 0
	lw 	$a0, turn($s0)
	
	#change the turn to the new character
	beq	$a0, 2, subtractone
	beq	$a0, 1, addone
key6:
	bne 	$v0, 6, key7
	
	#load the turn value
	li	$s0, 0		#use this to load the turn value
	lw	$a0, turn($s0)	#the turn value is the character offset in the bitmap memory
	
	##call the putchar to put it on the screen
	li	$a1, 6
	li	$a2, 4
	jal	putChar_atXY
	
	#reload again if the value was potentially lost?
	li	$s0, 0
	lw	$a0, turn($s0)
	
	#save the character value in the array
	li	$t0, 20
	sw	$a0, values($t0)
	
	#increment the move number
	jal	increment
	
	#check for the win condition here, if this is true then the game ends so yah
	jal	checkWin
	
	#reload again if the value was potentially lost?
	li	$s0, 0
	lw 	$a0, turn($s0)

	#change the turn to the new character
	beq	$a0, 2, subtractone
	beq	$a0, 1, addone
key7:
	bne 	$v0, 7, key8
	
	#load the turn value
	li	$s0, 0		#use this to load the turn value
	lw	$a0, turn($s0)	#the turn value is the character offset in the bitmap memory
	
	##call the putchar to put it on the screen
	li	$a1, 2
	li	$a2, 6
	jal	putChar_atXY
	
	#reload again if the value was potentially lost?
	li	$s0, 0
	lw	$a0, turn($s0)
	
	#save the character value in the array
	li	$t0, 24
	sw	$a0, values($t0)
	
	#increment the move number
	jal	increment
	
	#check for the win condition here, if this is true then the game ends so yah
	jal	checkWin
	
	#reload again if the value was potentially lost?
	li	$s0, 0
	lw 	$a0, turn($s0)
	
	#change the turn to the new character
	beq	$a0, 2, subtractone
	beq	$a0, 1, addone
key8:
	bne 	$v0, 8, key9
	
	#load the turn value
	li	$s0, 0		#use this to load the turn value
	lw	$a0, turn($s0)	#the turn value is the character offset in the bitmap memory
	
	##call the putchar to put it on the screen
	li	$a1, 4
	li	$a2, 6
	jal	putChar_atXY
	
	#reload again if the value was potentially lost?
	li	$s0, 0
	lw	$a0, turn($s0)
	
	#save the character value in the array
	li	$t0, 28
	sw	$a0, values($t0)
	
	#increment the move number
	jal	increment
	
	#check for the win condition here, if this is true then the game ends so yah
	jal	checkWin
	
	#reload again if the value was potentially lost?
	li	$s0, 0
	lw 	$a0, turn($s0)
	
	#change the turn to the new character
	beq	$a0, 2, subtractone
	beq	$a0, 1, addone
key9:
	bne 	$v0, 9, key_loop
	
	#load the turn value
	li	$s0, 0		#use this to load the turn value
	lw	$a0, turn($s0)	#the turn value is the character offset in the bitmap memory
	
	##call the putchar to put it on the screen
	li	$a1, 6
	li	$a2, 6
	jal	putChar_atXY
	
	#reload again if the value was potentially lost?
	li	$s0, 0
	lw	$a0, turn($s0)
	
	#save the character value in the array
	li	$t0, 32
	sw	$a0, values($t0)
	
	#increment the move number
	jal	increment
	
	#check for the win condition here, if this is true then the game ends so yah
	jal	checkWin		
	
	#reload again if the value was potentially lost?
	li	$s0, 0
	lw 	$a0, turn($s0)
	
	#change the turn to the new character
	beq	$a0, 2, subtractone
	beq	$a0, 1, addone
	
subtractone:
	li	$s0, 0
	lw	$a0, turn($s0)
	addi	$a0, $a0, -1
	sw	$a0, turn($s0)
	j 	key_loop
addone:
	li	$s0, 0
	lw	$a0, turn($s0)
	addi	$a0, $a0, 1
	sw	$a0, turn($s0)
	j 	key_loop

increment:
	#increment the move number
	lw	$t2, moves($zero)
	addi	$t2, $t2, 1
	sw	$t2, moves($zero)
	jr	$ra
	
checkWin:
	#load the value of the turn
	li	$s0, 0
	lw 	$a0, turn($s0)

	#Row 1
	li	$t0, 0
	lw	$t1, values($t0)
	li	$t0, 4
	lw	$t2, values($t0)
	li	$t0, 8
	lw	$t3, values($t0)
	and 	$s6, $t1, $t2
	and	$s6, $s6, $t3
	bne 	$s6, $zero, Won
	
	#Row 2
	li	$t0, 12
	lw	$t1, values($t0)
	li	$t0, 16
	lw	$t2, values($t0)
	li	$t0, 20
	lw	$t3, values($t0)
	and 	$s6, $t1, $t2
	and 	$s6, $s6, $t3
	bne 	$s6, $zero, Won
	
	#Row 3
	li	$t0, 24
	lw	$t1, values($t0)
	li	$t0, 28
	lw	$t2, values($t0)
	li	$t0, 32
	lw	$t3, values($t0)
	and 	$s6, $t1, $t2
	and 	$s6, $s6, $t3
	bne 	$s6, $zero, Won

	#Col 1
	li	$t0, 0
	lw	$t1, values($t0)
	li	$t0, 12
	lw	$t2, values($t0)
	li	$t0, 24
	lw	$t3, values($t0)
	and 	$s6, $t1, $t2
	and 	$s6, $s6, $t3
	bne 	$s6, $zero, Won
	
	#Col 2
	li	$t0, 4
	lw	$t1, values($t0)
	li	$t0, 16
	lw	$t2, values($t0)
	li	$t0, 28
	lw	$t3, values($t0)
	and 	$s6, $t1, $t2
	and 	$s6, $s6, $t3
	bne 	$s6, $zero, Won
	
	#Col 3
	li	$t0, 8
	lw	$t1, values($t0)
	li	$t0, 20
	lw	$t2, values($t0)
	li	$t0, 32
	lw	$t3, values($t0)
	and 	$s6, $t1, $t2
	and 	$s6, $s6, $t3
	bne 	$s6, $zero, Won
	
	#Diag LR
	li	$t0, 0
	lw	$t1, values($t0)
	li	$t0, 16
	lw	$t2, values($t0)
	li	$t0, 32
	lw	$t3, values($t0)
	and 	$s6, $t1, $t2
	and 	$s6, $s6, $t3
	bne 	$s6, $zero, Won
		
	#Diag RL
	li	$t0, 8
	lw	$t1, values($t0)
	li	$t0, 16
	lw	$t2, values($t0)
	li	$t0, 24
	lw	$t3, values($t0)
	and 	$s6, $t1, $t2
	and 	$s6, $s6, $t3
	bne 	$s6, $zero, Won
	
	jr	$ra
	
draw:
	li	$a0, 1
	li 	$a1, 1
	li 	$a2, 1
	jal	putChar_atXY
	
	li	$a0, 2
	li 	$a1, 3
	li 	$a2, 1
	jal	putChar_atXY
	
	j end
	
#puts the winning chracter as won
Won: 
	li 	$a1, 1
	li 	$a2, 1
	jal	putChar_atXY
	
	sll	$a0, $a0, 8
	jal	put_sound		# create sound with that as period
	li	$a0, 100		# pause for 1/4 second
	jal	pause
	jal	sound_off
	
end:
	j end
	
.include "procs_board.asm"
