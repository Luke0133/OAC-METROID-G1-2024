######## INPUT ###########################
# Uso de Registradores temporarios
INPUT_CHECK:
    li t1,0xFF200000  	    # KDMMIO Address
    lw t0, 0(t1)	    # Reads the Keyboard Control bit
    andi t0, t0, 0x0001	    # Masks the least significant bit
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
    bne t0,t1, CHECK_INPUT.DEL
    j INPUT.K # If 'k' key was pressed
    
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
	    sh zero, 6(a0)  # Stores new direction on MOVE_X
     #   ret
        j END_INPUT_CHECK 

    INPUT.W:  # Looking Up
        li t1, 1      # Loads vertical direction (1 = up)
        sb t1, 2(a0)  # Stores new direction on PLYR_STATUS
	    j END_INPUT_CHECK
	
    INPUT.A: # Moves player left
        li t1, 1      # Loads direction (1 = left)
        sb t1, 1(a0)  # Stores new direction on PLYR_STATUS

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
        li t1, 0      # Loads direction (0 = right)
        sb t1, 1(a0)  # Stores new direction on PLYR_STATUS

        li t1, 1      # Loads direction for MOVE_X (1 = right)
        sb t1, 6(a0)  # Stores new direction on MOVE_X
        j END_INPUT_CHECK 
	
    INPUT.SPACE:
        li t1, 1     # Loads vertical direction (1 = freefall)
        sb t1, 3(a0) # Stores new direction on PLYR_STATUS
        
        li t1, -1      # Loads direction for MOVE_Y (-1 = up)
        sb t1, 7(a0)  # Stores new direction on MOVE_Y
	    j END_INPUT_CHECK
	
    INPUT.K: # Shoots
        li t1, 1     # Loads attacking status (1 = attacking)
        sb t1, 5(a0) # Stores new attack status on PLYR_STATUS
        j END_INPUT_CHECK
    
    INPUT.DEL: # Kills Player
        #call KILL_PLYR
        j END_INPUT_CHECK

#    INPUT.P: #for testing
 #       la t0, PLYR_STATUS
#        lb t1, 0(t0)
#        addi t1,zero,1
#        sb t1, 0(t0)
#        j END_INPUT_CHECK

	END_INPUT_CHECK:
#    la a1, PLYR_STATUS      # Loads Player Status
#    lbu a0, 0(a1)
#    li a7, 1
#    ecall
#    lbu a0, 1(a1)
#    ecall
#    lbu a0, 2(a1)
#    ecall
#    lbu a0, 3(a1)
#    ecall
#    lbu a0, 4(a1)
   # ecall
  #  lbu a0, 5(a1)
 #   ecall
#   la a0, DEBUG
  #  li a7, 4
  #  ecall
      
		ret	
