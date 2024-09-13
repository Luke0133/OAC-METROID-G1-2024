######## INPUT ###########################
# Uso de Registradores temporarios
INPUT_CHECK:
    li t1,KDMMIO_ADDRESS  	  # KDMMIO Address
    lw t0, 0(t1)	      # Reads the Keyboard Control bit
    andi t0, t0, 0x0001	  # Masks the least significant bit

    la a0, PLYR_STATUS      # Loads Player Status
    la a2, PLYR_POS # Loads Player Pos
    bnez t0, CONTINUE_CHECK # if an input is detected, continue checking
    j NO_INPUT 		    # otherwise no input was detected 
    
    CONTINUE_CHECK:
    lb t3, 4(a0) # loads ball mode
  
    la t0, PLYR_INPUT # Loads PLYR_INPUT address
    lbu t2,0(t0)      # gets its value
    bnez t2, DONT_UPDATE_PLYR_INPUT  # If it isn't 0, don't update it
        li t2, 1      # Otherwise, there's input
        sb t2, 0(t0)  # store it
    DONT_UPDATE_PLYR_INPUT:

    lw t0, 4(t1)   # Reads key value

    li t1, 'w'	   # Loads ascii value of 'w' key
    bne t0, t1, CHECK_INPUT.A
    j INPUT.W	# If 'w' key was pressed
    
    CHECK_INPUT.A:
    li t1, 'a'	# Loads ascii value of 'a' key
    bne t0,t1, CHECK_INPUT.S
    j INPUT.A	# If 'a' key was pressed

    CHECK_INPUT.S:
    li t1, 's'	# Loads ascii value of 's' key
    bne t0, t1, CHECK_INPUT.D
    j INPUT.S	# If 's' key was pressed

    CHECK_INPUT.D:
    li t1, 'd'	# Loads ascii value of 'd' key
    bne t0,t1, CHECK_INPUT.SPACE
    j INPUT.D	# If 'd' key was pressed
    
    CHECK_INPUT.SPACE:
    li t1, 32	  # Loads ascii value of space key
    bne t0,t1, CHECK_INPUT.K
    j INPUT.SPACE # If space key was pressed

    CHECK_INPUT.K:
    li t1, 'k'	  # Loads ascii value of 'k' key
    bne t0,t1, CHECK_INPUT.J
    j INPUT.K # If 'k' key was pressed
 
    CHECK_INPUT.J:
    li t1, 'j'	  # Loads ascii value of 'j' key
    bne t0,t1, CHECK_INPUT.1
    j INPUT.J # If 'j' key was pressed

    # CHEAT INPUTS:
    CHECK_INPUT.1:
    li t1, '1'
    bne t0,t1, CHECK_INPUT.2
    j INPUT.1

    CHECK_INPUT.2:
    li t1, '2'
    bne t0,t1, CHECK_INPUT.3
    j INPUT.2

    CHECK_INPUT.3:
    li t1, '3'
    bne t0,t1, CHECK_INPUT.4
    j INPUT.3

    CHECK_INPUT.4:
    li t1, '4'
    bne t0,t1, CHECK_INPUT.5
    j INPUT.4

    CHECK_INPUT.5:
    li t1, '5'
    bne t0,t1, CHECK_INPUT.6
    j INPUT.5

    CHECK_INPUT.6:
    li t1, '6'
    bne t0,t1, CHECK_INPUT.7
    j INPUT.6

    CHECK_INPUT.7:
    li t1, '7'
    bne t0,t1, CHECK_INPUT.O
    j INPUT.7

    CHECK_INPUT.O:
    li t1, 'o'
    bne t0,t1, CHECK_INPUT.DEL
    j INPUT.O

    CHECK_INPUT.DEL:
    li t1, 127	# Loads ascii value of del key
    bne t0,t1, NO_INPUT
    j INPUT.DEL 	# If del key was pressed

    NO_INPUT:
        la t0, PLYR_INPUT
        li t2, 0   # There isn't input
        sb t2, 0(t0) 

        la a0, PLYR_STATUS      # Loads Player Status
        li t1, 0        # Loads vertical direction (0 = normal)
        sb t1, 2(a0)    # Stores new direction on PLYR_STATUS

        sb t1, 5(a0)                  
	    sb zero, 6(a0)  # Stores new direction on MOVE_X
        j END_INPUT_CHECK 

    INPUT.W:  # Looking Up
        beqz t3, W.NOT_MORPH_BALL # t3 != 0 ? BALL = OFF : BALL = ON (If on ball mode, deactivate it)
        j OUT_OF_MORPH_BALL
        
        W.NOT_MORPH_BALL:
        li t1, 1      # Loads vertical direction (1 = up)
        sb t1, 2(a0)  # Stores new direction on PLYR_STATUS
	    j END_INPUT_CHECK
	
    INPUT.A: # Moves player left
        li t1, -1     # Loads direction for MOVE_X (-1 = left)
        sb t1, 6(a0)  # Stores new direction on MOVE_X
        j END_INPUT_CHECK    
	
    INPUT.S:
        lbu t1, -1(a2) # Loads player's abilities
        lb t2, 7(a0)  # Loads direction on MOVE_Y
        slt t1, zero, t1 # t1 > 0 ? t1=1 : t1=0 --> if t1 = 1 or 2 (morph ball ability aquired) then go into morph ball
        
        bnez t2, SkipMorphBallTransformation
        beqz t1, SkipMorphBallTransformation  
        bnez t3, SkipMorphBallTransformation
            j INTO_MORPH_BALL
        SkipMorphBallTransformation:
        j END_INPUT_CHECK

    INPUT.D:          # Moves player right
        li t1, 1      # Loads direction for MOVE_X (1 = right)
        sb t1, 6(a0)  # Stores new direction on MOVE_X
        j END_INPUT_CHECK 
	
    INPUT.SPACE:
        beqz t3, SPACE.NOT_MORPH_BALL
        j OUT_OF_MORPH_BALL
        SPACE.NOT_MORPH_BALL:
            lb t1, 7(a0)  # Loads current direction on MOVE_Y
            beqz t1, CAN_JUMP
            j END_INPUT_CHECK
            CAN_JUMP:
                li t1, 1     # Loads ground position (1 = freefall)
                sb t1, 3(a0) # Stores new direction on PLYR_STATUS
        
                li t1, -1      # Loads direction for MOVE_Y (-1 = up)
                sb t1, 7(a0)   # Stores new direction on MOVE_Y
                
                # USES FLOATING POINT OPERATIONS
                fmv.s fs2,fs1  # Sets fs2 (player's Y speed) to -9 
	            j END_INPUT_CHECK
	
    INPUT.K: # Shoots
        beqz t3, K.SHOOT
        j END_INPUT_CHECK
        K.SHOOT:    
            li t1, 1     # Loads attacking status (1 = attacking)
            sb t1, 5(a0) # Stores new attack status on PLYR_STATUS
            #j END_INPUT_CHECK
            j BEAM_SPAWN

    INPUT.J:   # Switches to missile mode (if available)
        la t0, PLYR_INFO_2    # Loads address to PLYR_INFO_2
        lbu t2,1(t0)          # Loads missile cooldown
        bnez t2,SKIP_ENABLE_MISSILE  # If cooldown != 0, don't enable byte
            lbu t1,0(t0)          # Loads missile enable byte
            xori t1,t1,1          # Switches its value
            sb t1,0(t0)           # and stores it back
        SKIP_ENABLE_MISSILE:
            xori t2,t2,1      # Switches cooldown value
            sb t2,1(t0)       # and stores it back
        j END_INPUT_CHECK 
    
    INPUT.1: # Change to map 1
        la t0 MAP_INFO
        li t1, 1
        sb t1, 0(t0)
        li t1, 4
        sb t1, 1(t0)

        li t1,0
        sb t1,1(a0)

        j SETUP

    INPUT.2: # Change to map 2
        la t0 MAP_INFO
        li t1, 2
        sb t1, 0(t0)
        li t1, 4
        sb t1, 1(t0)

        li t1,0
        sb t1,1(a0)

        j SETUP

    INPUT.3: # Change to map 3
        la t0 MAP_INFO
        li t1, 3
        sb t1, 0(t0)
        li t1, 4
        sb t1, 1(t0)

        li t1,0
        sb t1,1(a0)

        j SETUP

    INPUT.4: # Change to map 4
        la t0 MAP_INFO
        li t1, 4
        sb t1, 0(t0)
        li t1, 4
        sb t1, 1(t0)

        li t1,0
        sb t1,1(a0)

        j SETUP

    INPUT.5: # Change to map 5
        la t0 MAP_INFO
        li t1, 5
        sb t1, 0(t0)
        li t1, 4
        sb t1, 1(t0)

        li t1,1
        sb t1,1(a0)

        j SETUP

    INPUT.6: # Change to map 6
        la t0 MAP_INFO
        li t1, 6
        sb t1, 0(t0)
        li t1, 4
        sb t1, 1(t0)

        li t1,1
        sb t1,1(a0)

        j SETUP

    INPUT.7: # Change to map 7
        la t0 MAP_INFO
        li t1, 7
        sb t1, 0(t0)
        li t1, 4
        sb t1, 1(t0)

        li t1,1
        sb t1,1(a0)

        j SETUP

    INPUT.O:
        li a0, 0    # open doors
        # li a1, 0  # won't be needed, since a0 = 0
        j CHANGE_DOORS_STATE


    INPUT.DEL: # Kills Player
        li a0,2
        li a1,10
        j DAMAGE_PLAYER
        j END_INPUT_CHECK

	END_INPUT_CHECK:
		ret	