######## INPUT ###########################
# Uso de Registradores temporarios
INPUT_CHECK:
    li t1,KDMMIO_ADDRESS  	  # KDMMIO Address
    lw t0, 0(t1)	      # Reads the Keyboard Control bit
    andi t0, t0, 0x0001	  # Masks the least significant bit

    la a0, PLYR_STATUS      # Loads Player Status
    bnez t0, CONTINUE_CHECK # if an input is detected, continue checking
    j NO_INPUT 		    # otherwise no input was detected 
    
    CONTINUE_CHECK:
    la t0, PLYR_INPUT
    li t2, 1   # There is input
    sb t2, 0(t0) 

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
    bne t0,t1, CHECK_INPUT.1
    j INPUT.K # If 'k' key was pressed

    CHECK_INPUT.1:
    li t1, '1'
    bne t0,t1, CHECK_INPUT.2
    j INPUT.1

    CHECK_INPUT.2:
    li t1, '2'
    bne t0,t1, CHECK_INPUT.DEL
    j INPUT.2

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
######## NAO DESATIVAR ATAQUE AQUI
        sb t1, 5(a0)            
######## VER SE VAI ALTERAR AQUI O MOVE_Y        
	    sb zero, 6(a0)  # Stores new direction on MOVE_X
     #   ret
        j END_INPUT_CHECK 

    INPUT.W:  # Looking Up
        li t1, 1      # Loads vertical direction (1 = up)
        sb t1, 2(a0)  # Stores new direction on PLYR_STATUS
	    j END_INPUT_CHECK
	
    INPUT.A: # Moves player left
#        li t1, 1      # Loads direction (1 = left)
#        sb t1, 1(a0)  # Stores new direction on PLYR_STATUS

        li t1, -1     # Loads direction for MOVE_X (-1 = left)
        sb t1, 6(a0)  # Stores new direction on MOVE_X
        j END_INPUT_CHECK    
	
    INPUT.S:
        la t0, PLYR_INFO
        lbu t1, 1(t0)
        slt t1, zero, t1 # t1 > 0 ? t1=1 : t1=0 --> if t1 = 1 or 2 (morph ball ability aquired) then go into morph ball
        beqz t1, SkipMorphBallTransformation  
            li t1, 1      # Loads morph ball mode (1 = enabled)
            sb t1, 4(a0)  # Stores new direction on PLYR_STATUS
#           ANIMATION FOR GOING INTO MORPH BALL
        SkipMorphBallTransformation:
        j END_INPUT_CHECK
    INPUT.D:          # Moves player right
#        li t1, 0      # Loads direction (0 = right)
#        sb t1, 1(a0)  # Stores new direction on PLYR_STATUS

        li t1, 1      # Loads direction for MOVE_X (1 = right)
        sb t1, 6(a0)  # Stores new direction on MOVE_X
        j END_INPUT_CHECK 
	
    INPUT.SPACE:

        lb t1, 7(a0)  # Loads current direction on MOVE_Y
        beqz t1, CAN_JUMP
        j END_INPUT_CHECK
        CAN_JUMP:
        li t1, 1     # Loads vertical direction (1 = freefall)
        sb t1, 3(a0) # Stores new direction on PLYR_STATUS
        
        li t1, -1      # Loads direction for MOVE_Y (-1 = up)
        sb t1, 7(a0)  # Stores new direction on MOVE_Y

	    j END_INPUT_CHECK
	
    INPUT.K: # Shoots
        li t1, 1     # Loads attacking status (1 = attacking)
        sb t1, 5(a0) # Stores new attack status on PLYR_STATUS
        j END_INPUT_CHECK
        #j BEAM_OPERATIONS
    
    INPUT.1: # Change to map 1
        la t0 MAP_INFO
        li t1, 1
        sb t1, 0(t0)
        li t1, 4
        sb t1, 1(t0)

        j SETUP

    INPUT.2: # Change to map 2
        la t0 MAP_INFO
        li t1, 2
        sb t1, 0(t0)
        li t1, 4
        sb t1, 1(t0)

        j SETUP

    INPUT.DEL: # Kills Player
        #call KILL_PLYR
        j END_INPUT_CHECK

	END_INPUT_CHECK:
		ret	

#BEAM_OPERATIONS: 
#    la t1, BEAMS # loads plyrs_status attacking
#    li t4, BEAMS_NUMBER # max counter of number beams
#    li t3, 0

#    CHECK_BEAM_LOOP:
#        lb t2, 0(t1) #loads if beam_1 is active
#        beqz t2, RESET_BEAM_LOOP
#        li t2, 1
#        sb t2, 0(t1)
#        j SET_BEAM_POSITION

#        RESET_BEAM_LOOP:
#        addi t3, t3, 1
#        addi t1, t1, 16
#        beq t3,t4, END_BEAM_LOOP 
#        j CHECK_BEAM_LOOP
#
#        END_BEAM_LOOP:
#           j END_BEAM_OPERATIONS
#
#    SET_BEAM_POSITION:
#        lb t2, 1(a0) # Loads PLYRS horizontal direction
#        beqz t2, SET_BEAM_LEFT
#        li t5, 1
#        beq t2, t5, SET_BEAM_RIGHT
#        li t5, 2
#        beq t2, t5, SET_BEAM_UP
#         
#
#    SET_BEAM_LEFT:
#       la t0, PLYR_POS
#       lh t2, 0(t0) # loads player current x direction        
#       sh t2, 2(t1) # stores player direction in beams initial position
#       lb t2, 4(t0) # loads player current y direction  
#       sb t2, 8(t1) # stores player direction in beams initial position
#       li t2, 0 # left
#       sb t2, 1(t1) # store beam's direction
#       j END_BEAM_OPERATIONS

#    SET_BEAM_RIGHT:
#       la t0, PLYR_POS
#       lh t2, 0(t0) # loads player current x direction        
#       sh t2, 2(t1) # stores player direction in beams initial position
#       lb t2, 4(t0) # loads player current y direction  
#       sb t2, 8(t1) # stores player direction in beams initial position
#       li t2, 1 # right
#       sb t2, 1(t1) # store beam's direction
#       j END_BEAM_OPERATIONS

#    SET_BEAM_UP:
#       la t0, PLYR_POS
#       lh t2, 0(t0) # loads player current x direction        
#       sh t2, 2(t1) # stores player direction in beams initial position
#       lb t2, 4(t0) # loads player current y direction   
#       sb t2, 8(t1) # stores player direction in beams initial position
#       li t2, 2 # up
#       sb t2, 1(t1) # store beam's direction
#
#    END_BEAM_OPERATIONS:
#       ret
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#