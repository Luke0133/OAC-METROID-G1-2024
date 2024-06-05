.text
##########################  PHYSICS    ##########################
# Uppon calling PHYSICS, it is assumed that the address of the  #
# current map is already stored on CURRENT_MAP. This label will	#
#    store the current map's address, so it is a "pointer" to   #
#    another "pointer". Remember that when loading the map's	#
#   address (load address of CURRENT_MAP, then load word from	# 
#      CURRENT_MAP: this will be the current map's address)	#
#################################################################
#   -----------           registers used           -----------  #
#	a0 = MOVE_X/MOVE_Y address (located on main.s)		#
#	a1 = CURRENT_MAP address (located on main.s)		#
#	a2 = current map's address (located on matrix.data)	#
# a3 = PLYR_POS
# a4 = Move_X/Y in tile format
# t5,t6 = Temporary Registers

PHYSICS:
    la a0, MOVE_X	   # Loads address of MOVE_X
    lb t0, 0(a0)	   # Loads information from MOVE_X
    la a1, CURRENT_MAP # Loads CURRENT_MAP's address
    lw a2, 0(a1) 	   # a2 has the current map's address 
    la a3, PLYR_POS  # Loads Player Position
    bnez t0, MOVE_PLAYER_X # If there's X movement, go to MOVE_PLAYER_X
    j CHECK_MOVE_Y         # Otherwise, go check Y movement
    
    MOVE_PLAYER_X:
      	slli a4, t0, 2  # Multiplies the value stored on MOVE_X by 4. a0 will store the movement of the player (+/- 4 pixels)
        
        lb t3, 6(a3)	# Loads Player's X offset
        add t3,t3,a4	# Adds the X Movement to the Player's Offset
        
        lb t4, 8(a3)	# Loads Player's X on Matrix
        sb t4, 9(a3)	# Stores Plater's X on Matrix on the Old X
        
        li a7, 0
        bge t3,zero,SKIP_LEFT_X
       	# If t3 < 0, Player is moving to the left tile
        addi t4,t4, -1		# Player's X on matrix -= 1 (goes to the left)
        addi t3,t3,tile_size	# Offset gets corrected (relative to new X on matrix coordinate)
        li a7, -1
        
        SKIP_LEFT_X:
          li t6, tile_size
          blt t3,t6, SKIP_RIGHT_X
          # If t3 >= 16, Player is moving to the right tile
          addi t4,t4, 1	# Player's X on matrix += 1 (goes to the right)
          sub t3,t3,t6	# Offset gets corrected (relative to new X on matrix coordinate)
          li a7, 1
        SKIP_RIGHT_X:
          # Otherwise, the player is still on the same tile


###### PARA COLIS�OOOO
  #      slt t5,a4,zero			# t5 = 1 if a4 < 0, otherwise, t5 = 0
   #     slli t5,t5,tile_size_shift 	# t5 = tile_size if t0 <0, otherwise, t5 = 0
    #    sub t5,t5,t3			# t5 = tile_size - X offset, otherwise t5 = X offset
  #      li t6, standing_front_hitbox	# Offset 
   #     bge t6,t5,SkipColisionCheck
   #	j colisao?
   	SkipColisionCheck: 


    
###### DPS DE CHECAR COLIS�O

        sb t3, 6(a3)    # Stores new X offset
        sb t4, 8(a3)    # Stores new X coordinate on matrix

        lh t2, 0(a3)    # Loads Player's Current X
        add t5, a4, t2  # t5 = Player's current X + Movement of Player on X axis

        lb t0, 0(a2) 	  	# loads first byte to check what type of map it is (0 - Fixed, 1 - Horizontal, 2 - Vertical)
        li t6, 1 		# Loads 1 and 
        bne t6, t0, Fixed_X_Map # compares with the result
        j Horizontal_Map
        
        Fixed_X_Map:
          # If the map has a fixed X on matrix, that is, the screen won't follow the player, the player will move related to the screen
          sh t2,2(a3) # Stores original X on old X related to screen
          sh t5,0(a3) # Stores new X on current X related to screen
          j CHECK_MOVE_Y
          
        Horizontal_Map:
          lb t0, 4(a1)  # Loads Map X postition on Matrix
          li t6, left_hor_border #loads left_border = 120 
          blt t6, t5, NOT_LEFT_BORDER_PASS # if new player position on screen doesn't pass the left border, go to NOT_LEFT_BORDER_PASS
            beqz t0, Fixed_X_Map  # If on leftmost part of the map, ignore the left 
            # border and render as if map had fixed X on matrix
            j MOVE_SCREEN_X

          NOT_LEFT_BORDER_PASS:   # Checking if passed the Right Horizontal Border
          li t6, right_hor_border #loads right_border = 180 
          bge t6,t5,Fixed_X_Map   # if new player position on screen doesn't pass the right border, go to Fixed_X_Map
            lb t1, 1(a2)          # Loads Map matrix width
            li t6, m_screen_width # Loads Map screen width related to matrix
            sub t1,t1,t6          # t1 = Map Matrix Width - Screen Matrix Width
            beq t0,t1, Fixed_X_Map  # If on rightmost part of the map, ignore the right 
            # border and render as if map had fixed X on matrix
          
          MOVE_SCREEN_X:
            sh t2,2(a3) # Stores original X on old X related to screen
            
            lb t0, 4(a1)  # Loads Map X postition on Matrix
            add t0,t0,a7  # adds to the X -1, 0 or 1
            sb t0, 4(a1)  # Stores new Map X postition on Matrix
            
            
    CHECK_MOVE_Y:
        # lb a0, 2(t0)
        # be
        j END_PHYSICS

    END_PHYSICS:
        ret
