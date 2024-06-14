.text
##########################  PHYSICS    ##########################
# Uppon calling PHYSICS, it is assumed that the address of the  #
# current map is already stored on CURRENT_MAP. This label will	#
#    store the current map's address, so it is a "pointer" to   #
#    another "pointer". Remember that when loading the map's	#
#   address (load address of CURRENT_MAP, then load word from	# 
#      CURRENT_MAP: this will be the current map's address)	    #
#################################################################
#   -----------     registers used     -----------  #
#	a0 = MOVE_X/MOVE_Y address (located on main.s)		#
#	a1 = CURRENT_MAP address (located on main.s)		#
#	a2 = current map's address (located on matrix.data)	#
#   a3 = PLYR_POS
#   a4 = Move_X/Y in tile format
#   a6 = player offset (t4)
#   a7 = player x on matrix 
#   s10 = what to add to map matrix (-1, 0 or 1)
#   s11 = ra storage
#   t5,t3 = Temporary Registers

PHYSICS:
    la a0, MOVE_X	       # Loads address of MOVE_X
    lb t0, 0(a0)	       # Loads information from MOVE_X
    la a1, CURRENT_MAP     # Loads CURRENT_MAP's address
    lw a2, 0(a1) 	       # a2 has the current map's address 
    la a3, PLYR_POS        # Loads Player Position
    
    bnez t0, MOVE_PLAYER_X # If there's X movement, go to MOVE_PLAYER_X
        lh t1, 0(a3)  # Loads Player's X related to screen
        sh t1, 2(a3)  # Stores Player's X related to screen on old X
        lbu t1, 8(a3)  # Loads Player's X related to screen
        sb t1, 9(a3)  # Stores Player's X related to screen on old X
        j CHECK_MOVE_Y         # Otherwise, go check Y movement
    
    MOVE_PLAYER_X:
        slli a4, t0, 2  # Multiplies the value stored on MOVE_X by 4. a0 will store the movement of the player (+/- 4 pixels)
        
        lb a6, 6(a3)	# Loads Player's X offset
        add a6,a6,a4	# Adds the X Movement to the Player's Offset
        
        lbu a7, 8(a3)	# Loads Player's X on Matrix
        sb a7, 9(a3)	# Stores Plater's X on Matrix on the Old X
        
        li s10, 0
        bge a6,zero,SKIP_LEFT_X
       	# If a6 < 0, Player is moving to the left tile
        addi a7, a7, -1		  # Player's X on matrix -= 1 (goes to the left)
        addi a6,a6,tile_size  # Offset gets corrected (relative to new X on matrix coordinate)
        li s10, -1
        
        SKIP_LEFT_X:
            li t3, tile_size
            blt a6,t3, SKIP_RIGHT_X
            # If a6 >= 16, Player is moving to the right tile
            addi a7,a7, 1	 # Player's X on matrix += 1 (goes to the right)
            sub a6,a6,t3	 # Offset gets corrected (relative to new X on matrix coordinate)
            li s10, 1
        SKIP_RIGHT_X:
    
    #### debugging ####
    #    mv t0,a0
    #    mv t1,a7   
    #    mv a0, a7
    #    li a7,1
    #    ecall
    #    
    #    la a0, DEBUG
    #    li a7, 4
    #    ecall
    #    
    #    mv a0,t0
    #    mv a7,t1 
        
        # Checking collision
        mv s11, ra
        
        call CHECK_HORIZONTAL_COLLISION
        
        mv ra, s11
        mv t0,a0
        mv t1,a7   
        mv a0, a4
        li a7,1
        ecall
        
        la a0, DEBUG
        li a7, 4
        ecall
        
        mv a0,t0
        mv a7,t1 
        # After checking collision
        
#################
        bnez a4, CAN_MOVE_X 
            j Fixed_X_Map
        CAN_MOVE_X:
###############        
      



        sb a6, 6(a3)    # Stores new X offset
        sb a7, 8(a3)    # Stores new X coordinate on matrix

        lh t2, 0(a3)    # Loads Player's Current X
        add t5, a4, t2  # t5 = Player's current X + Movement of Player on X axis
    
        lbu t0, 0(a2)   # loads first byte to check what type of map it is (0 - Fixed, 1 - Horizontal, 2 - Vertical)
        li t3, 1        # Loads 1 and 
        bne t3, t0, Fixed_X_Map # compares with the result
        j Horizontal_Map
        
        Fixed_X_Map:
            # If the map has a fixed X on matrix, that is, the screen won't follow the player, the player will move related to the screen
            sh t2,2(a3) # Stores original X on old X related to screen
            sh t5,0(a3) # Stores new X on current X related to screen
            j CHECK_MOVE_Y
    
        Horizontal_Map:
            lbu t0, 6(a1)    # Loads Map's X postition on Matrix
            lbu t1, 8(a1)    # Loads Map's X offset
                        
            li t3, left_hor_border      # loads left_border = 120 
            blt t3, t5, NOT_LEFT_BORDER_PASS  # if new player position on screen doesn't pass the left border, go to NOT_LEFT_BORDER_PASS
          		  # Otherwise, if new player position on screen passes left border, check if it is on left corner of the map
                  add t4,t0,t1     # Will be 0 if Map's X offset and X position are 0
          		  beqz t4, Fixed_X_Map  # If on leftmost part of the map, map won't move
                    j MOVE_SCREEN_X     # otherwise, move the map left

        NOT_LEFT_BORDER_PASS:   # Checking if passed the Right Horizontal Border
            li t3, right_hor_border #loads right_border = 180 
            bge t3,t5,Fixed_X_Map   # if new player position on screen doesn't pass the right border, go to Fixed_X_Map
                lbu t1, 1(a2)    # Loads Map matrix width
                li t3, m_screen_width # Loads Map screen width related to matrix
                sub t1,t1,t3    # t1 = Map Matrix Width - Screen Matrix Width (t1 = Map's X when it's on rightmost part of the map)
                beq t0,t1, Fixed_X_Map  # If on rightmost part of the map, map won't move
                # otherwise, move the map right
        
        MOVE_SCREEN_X:
            li t3, 2       # t3 = 2 (map will be rendered again)
            sb t3, 5(a1)   # Stores t3 on CURRENT_MAP's rendering byte

            sh t2,2(a3)    # Stores player's original X on old X related to screen
    
            lbu t0, 6(a1)  # Loads Map X postition on Matrix
            add t0,t0,s10  # adds to the X -1, 0 or 1 (moves map horizontally)
            sb t0, 6(a1)   # Stores Map X postition on Matrix
            sb a6, 8(a1)   # Stores Map new X offset that is equal to player's X offset
            
            j CHECK_MOVE_Y
      
      
CHECK_MOVE_Y:
# COLLISION Y
    # lb a0, 2(t0)
    # be
    #bnez t0, MOVE_PLAYER_Y # If there's Y movement, go to MOVE_PLAYER_Y
        lbu t1, 4(a3)  # Loads Player's Y related to screen
        sb t1, 5(a3)  # Stores Player's Y related to screen on old Y
        lbu t1, 10(a3)  # Loads Player's Y related to screen
        sb t1, 11(a3)  # Stores Player's Y related to screen on old Y
        j END_PHYSICS

    END_PHYSICS:
        ret
