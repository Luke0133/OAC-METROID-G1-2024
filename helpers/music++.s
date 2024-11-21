.text

RESET_MUSIC:
	# Reseting Bristar OST
	la t0,Brinstar
	sb zero,(t0)

	la t0,Brinstar_Lead_0
	sh zero,2(t0)	
	sw zero,4(t0)
	addi t1, t0, 12	# Gets next note address
	sw t1,8(t0)
	
	la t0,Brinstar_Lead_1
	sh zero,2(t0)	
	sw zero,4(t0)
	addi t1, t0, 12	# Gets next note address
	sw t1,8(t0)

	la t0,Brinstar_Bass
	sh zero,2(t0)	
	sw zero,4(t0)
	addi t1, t0, 12	# Gets next note address
	sw t1,8(t0)

	# Reseting KIRBO OST
	la t0,KIRBO
	sb zero,(t0)

	la t0,KIRBO_Track1_Voice0_SIZE
	sh zero,2(t0)	
	sw zero,4(t0)
	addi t1, t0, 12	# Gets next note address
	sw t1,8(t0)
	
	la t0,KIRBO_Track1_Voice1_SIZE
	sh zero,2(t0)	
	sw zero,4(t0)
	addi t1, t0, 12	# Gets next note address
	sw t1,8(t0)

	la t0,KIRBO_Track1_Voice2_SIZE
	sh zero,2(t0)	
	sw zero,4(t0)
	addi t1, t0, 12	# Gets next note address
	sw t1,8(t0)

	la t0,KIRBO_Track3_Voice0_SIZE
	sh zero,2(t0)	
	sw zero,4(t0)
	addi t1, t0, 12	# Gets next note address
	sw t1,8(t0)

	la t0,KIRBO_Track3_Voice1_SIZE
	sh zero,2(t0)	
	sw zero,4(t0)
	addi t1, t0, 12	# Gets next note address
	sw t1,8(t0)

	la t0,KIRBO_Track3_Voice2_SIZE
	sh zero,2(t0)	
	sw zero,4(t0)
	addi t1, t0, 12	# Gets next note address
	sw t1,8(t0)

	la t0,KIRBO_Track3_Voice3_SIZE
	sh zero,2(t0)	
	sw zero,4(t0)
	addi t1, t0, 12	# Gets next note address
	sw t1,8(t0)

	la t0,KIRBO_Track4_Voice0_SIZE
	sh zero,2(t0)	
	sw zero,4(t0)
	addi t1, t0, 12	# Gets next note address
	sw t1,8(t0)

	la t0,KIRBO_Track5_Voice0_SIZE
	sh zero,2(t0)	
	sw zero,4(t0)
	addi t1, t0, 12	# Gets next note address
	sw t1,8(t0)

	la t0,KIRBO_Track6_Voice0_SIZE
	sh zero,2(t0)	
	sw zero,4(t0)
	addi t1, t0, 12	# Gets next note address
	sw t1,8(t0)

	la t0,KIRBO_Track6_Voice1_SIZE
	sh zero,2(t0)	
	sw zero,4(t0)
	addi t1, t0, 12	# Gets next note address
	sw t1,8(t0)

	la t0,KIRBO_Track7_Voice0_SIZE
	sh zero,2(t0)	
	sw zero,4(t0)
	addi t1, t0, 12	# Gets next note address
	sw t1,8(t0)

	la t0,KIRBO_Track7_Voice1_SIZE
	sh zero,2(t0)	
	sw zero,4(t0)
	addi t1, t0, 12	# Gets next note address
	sw t1,8(t0)

	la t0,KIRBO_Track8_Voice0_SIZE
	sh zero,2(t0)	
	sw zero,4(t0)
	addi t1, t0, 12	# Gets next note address
	sw t1,8(t0)

	la t0,KIRBO_Track8_Voice1_SIZE
	sh zero,2(t0)	
	sw zero,4(t0)
	addi t1, t0, 12	# Gets next note address
	sw t1,8(t0)

	ret
	
SET_SOUNDTRACK:	
	la t0, CURRENT_SOUNDTRACK
	lw t1,0(t0)

	la t2, Brinstar
	bne t1,t2,SET_NOT_BRINSTAR    # If current music isn't Brinstar
	# Otherwise, set to play Brinstar
		li t1,1
		sb t1,0(t2)
		j END_SET_SOUNDTRACK

	SET_NOT_BRINSTAR:

	la t2, KIRBO
	bne t1,t2,SET_NOT_KIRBO       # If current music isn't KIRBO
	# Otherwise, set to play KIRBO
		li t1,1
		sb t1,0(t2)
		j END_SET_SOUNDTRACK

	SET_NOT_KIRBO:

	END_SET_SOUNDTRACK: ret


SWITCH_SOUNDTRACK:	
	addi sp,sp,-4
	sw ra,0(sp)
# End of Stack Operations
	call RESET_MUSIC      # Resets Music 
# Procedure finished: Loading Registers from Stack
	lw ra,0(sp)
	addi sp,sp,4

	la t0, CURRENT_SOUNDTRACK
	lw t1, 0(t0)

	la t2, Brinstar
	bne t1,t2,SWITCH_NOT_BRINSTAR    # If current soundtrack isn't Brinstar
	# Otherwise, change music to KIRBO   -->> In this case, there are only two soundtracks
		la t2, KIRBO
		sw t2,0(t0)
		li t1,1
		sb t1,0(t2)
		j END_SWITCH_SOUNDTRACK

	SWITCH_NOT_BRINSTAR:

	la t2, KIRBO
	bne t1,t2,SWITCH_NOT_KIRBO
	# Otherwise, change music to Brinstar   -->> In this case, there are only two soundtracks
		la t2, Brinstar
		sw t2,0(t0)
		li t1,1
		sb t1,0(t2)
		j END_SWITCH_SOUNDTRACK

	SWITCH_NOT_KIRBO:

	END_SWITCH_SOUNDTRACK: ret


SETUP_MUSIC:   # Not used in Music ++
	ret

PLAY_SOUND:
#ebreak
	la t0,Brinstar
	lbu t0,0(t0)

	beqz t0, SKIP_PLAY_BRINSTAR
	# Storing Registers on Stack
		addi sp,sp,-4
		sw ra,0(sp)
	# End of Stack Operations

		la a0,Brinstar_Lead_0
		call PLAY_MUSIC
		
		la a0,Brinstar_Lead_1
		call PLAY_MUSIC

		la a0,Brinstar_Bass
		call PLAY_MUSIC
		

		beqz a7,FINISH_PLAY_BRINSTAR
			call RESET_MUSIC
			li t1,1	
			la t0,Brinstar
			sb t1,0(t0)	
		FINISH_PLAY_BRINSTAR:

	# Procedure finished: Loading Registers from Stack
        lw ra,0(sp)
        addi sp,sp,4
    # End of Stack Operations   
	SKIP_PLAY_BRINSTAR:


	la t0,KIRBO
	lbu t0,0(t0)

	beqz t0, SKIP_PLAY_KIRBO
	# Storing Registers on Stack
		addi sp,sp,-4
		sw ra,0(sp)
	# End of Stack Operations

		la a0,KIRBO_Track1_Voice0_SIZE
		call PLAY_MUSIC
		
		la a0,KIRBO_Track1_Voice1_SIZE
		call PLAY_MUSIC

		la a0,KIRBO_Track1_Voice2_SIZE
		call PLAY_MUSIC
		
		

		la a0,KIRBO_Track3_Voice0_SIZE
		call PLAY_MUSIC

		la a0,KIRBO_Track3_Voice1_SIZE
		call PLAY_MUSIC

		la a0,KIRBO_Track3_Voice2_SIZE
		call PLAY_MUSIC

		la a0,KIRBO_Track3_Voice3_SIZE
		call PLAY_MUSIC

		la a0,KIRBO_Track4_Voice0_SIZE
		call PLAY_MUSIC

		la a0,KIRBO_Track5_Voice0_SIZE
		call PLAY_MUSIC

		la a0,KIRBO_Track6_Voice0_SIZE
		call PLAY_MUSIC

		la a0,KIRBO_Track6_Voice1_SIZE
		call PLAY_MUSIC

		la a0,KIRBO_Track7_Voice0_SIZE
		call PLAY_MUSIC

		la a0,KIRBO_Track7_Voice1_SIZE
		call PLAY_MUSIC

		la a0,KIRBO_Track8_Voice0_SIZE
		call PLAY_MUSIC

		la a0,KIRBO_Track8_Voice1_SIZE
		call PLAY_MUSIC

		beqz a7,FINISH_PLAY_KIRBO
			call RESET_MUSIC
			li t1,1	
			la t0,KIRBO
			sb t1,0(t0)	
		FINISH_PLAY_KIRBO:

	# Procedure finished: Loading Registers from Stack
        lw ra,0(sp)
        addi sp,sp,4
    # End of Stack Operations   
	SKIP_PLAY_KIRBO:

	ret


###################### PLAY MUSIC ######################
#   Arguments
#
#  a0 = Music address
#
#################################################################
PLAY_MUSIC:	
	li a2,0      # Instrument
	li a3,50     # Volume

	lw t0,4(a0)  # Loads time last note played
	beqz t0,START_PLAY_MUSIC   # If zero, play music
	# Otherwise, check current time
		li a7,0
		csrr t1, 3073		        # current time
		bltu t1, t0, END_PLAY_MUSIC	# if current time hasn't surpassed time estipulated by previous note, don't play note 

START_PLAY_MUSIC:	
	lw t0,8(a0)  # Loads current note's address
	lw t2,0(t0)	 # Loads note and duration

	andi t1,t2,0x0000FFFF     # Masks lower half as the note
	srli t2,t2,16             # Moves t1 16 bits to the right (note duration half)

	#lh t1,0(t0)	 # Loads note
	#lh t2,2(t0)	 # Loads duration



	beqz t1, MUSIC_REST  # If note is 0, it's a rest

	mv t3, a0    # Saves a0

	mv a0, t1		# a0 = note
	mv a1, t2		# a1 = duration
	li a7, 31		# play note syscall
	ecall

	mv a0, t3    # Restores it back

MUSIC_REST:	
	csrr t3, 3073	# current time
	add t3, t3, t2	# current time + note duration = next note time
	sw t3, 4(a0)	# save next note time

	lhu t3,2(a0) # Current note
	lhu t1,0(a0) # Total number of notes
	addi t3,t3,1
	sh t3,2(a0)  # Stores it back
	blt t3,t1,CONTINUE_PLAYING
	# Otherwise, reset loop             
		sh zero,2(a0)
		addi t1,a0,12
		sw t1,8(a0)
		li a7,1              # Returns 1 
			
		j END_PLAY_MUSIC
	CONTINUE_PLAYING:
		addi t0, t0, 4	# Gets next note address
		sw t0, 8(a0)	# Saves it

		li a7,0              # Returns 0

END_PLAY_MUSIC:		ret



PLAY_ITEM_GET:
	# Storing Registers on Stack
		addi sp,sp,-4
		sw ra,0(sp)
	# End of Stack Operations
	

	la t0,Item_Get_0
	sh zero,2(t0)	
	sw zero,4(t0)
	addi t1, t0, 12	# Gets next note address
	sw t1,8(t0)
	
	la t0,Item_Get_1
	sh zero,2(t0)	
	sw zero,4(t0)
	addi t1, t0, 12	# Gets next note address
	sw t1,8(t0)

	la t0,Item_Get_2
	sh zero,2(t0)	
	sw zero,4(t0)
	addi t1, t0, 12	# Gets next note address
	sw t1,8(t0)

	la t0,Item_Get_3
	sh zero,2(t0)	
	sw zero,4(t0)
	addi t1, t0, 12	# Gets next note address
	sw t1,8(t0)

	la t0,Item_Get_4
	sh zero,2(t0)	
	sw zero,4(t0)
	addi t1, t0, 12	# Gets next note address
	sw t1,8(t0)

	la t0,Item_Get_5
	sh zero,2(t0)	
	sw zero,4(t0)
	addi t1, t0, 12	# Gets next note address
	sw t1,8(t0)

	ITEM_GET_LOOP:
		la a0,Item_Get_0
		call PLAY_MUSIC

		la a0,Item_Get_1
		call PLAY_MUSIC

		la a0,Item_Get_2
		call PLAY_MUSIC

		la a0,Item_Get_3
		call PLAY_MUSIC

		la a0,Item_Get_4
		call PLAY_MUSIC	

		la a0,Item_Get_5
		call PLAY_MUSIC	

	beqz a7,ITEM_GET_LOOP

	call RESET_MUSIC

	csrr t1,3073                       # Gets current time for loop
	ITEM_DELAY_LOOP:
	    csrr t0,3073                 # Gets current time
	    sub t0, t0, t1               # t0 = current time - last frame's time
	    li t2, power_up_delay        # Loads power_up_delay
	    bltu t0,t2, ITEM_DELAY_LOOP  # While t0 < minimum time for a frame, keep looping

	call SET_SOUNDTRACK     # Sets soundtrack to play again 

	# Procedure finished: Loading Registers from Stack
	lw ra,0(sp)
	addi sp,sp,4
    # End of Stack Operations 
	ret
