.text
##########################  PHYSICS    ##########################

#################################################################


PHYSICS:
    la t0, MOVE_X
    lb a0, 0(t0)
    bnez t0, MOVE_PLAYER_X # If there's X movement, go to MOVE_PLAYER_X
    j CHECK_MOVE_Y         # Otherwise, go check Y movement
    
    MOVE_PLAYER_X:
      # PRIMEIRO  
        la t0, PLYR_POS # Loads Player Positon
        slli a0, a0, 2  # multiply by two to pixelize
        lh t1, 0(t0)    # Loads Player's Current X
        add t1, a0, t1  # Player's X + Move on x
        
        la a1, CURRENT_MAP # Loads Current Map Address
        lw t0, 0(a1) #loads map number
        lb t0, 0(t0) #load to check if it is vertical or horizontal
        li t2, 1 
        bne t2, t0, Fixed_X_Map
        j Horizontal_Map
        Fixed_X_Map:

        Horizontal_Map:
            
            
        beq 
        la t1, PLYR_MATRIX
            
    CHECK_MOVE_Y:
        # lb a0, 2(t0)
        # be
        j END_PHYSICS

    END_PHYSICS:
        ret
