.text

##########################   MAP_OPERATIONS   ##########################
#########################################################################

MAP_MOVE_RENDER:
#	li a0,1000
#	li a7,32
#	ecall
	la t0, CURRENT_MAP  # Loads CURRENT_MAP's address
	lbu t1, 5(t0)       # Loads on t1 the CURRENT_MAP's rendering byte
	li t2,3
	blt t1,t2 CHECK_MAP_MOVE_RENDER_1 
		ret
	CHECK_MAP_MOVE_RENDER_1:
		lbu t2, 6(t0)       # Loads on t2 the CURRENT_MAP's X on matrix
		li t3,255
		blt t2,t3, CHECK_MAP_MOVE_RENDER_2 
			ret
	CHECK_MAP_MOVE_RENDER_2:
		bnez t1, START_MAP_MOVE_RENDER # If map is allowed to render (t1 = 1)
			ret                        # If map can't be rendered (t1 = 0)
	       

	
START_MAP_MOVE_RENDER:
# Storing Registers on Stack
	addi sp,sp,-4
    sw ra, 0(sp)
# End of Stack Operations
#	li a0,1000
#	li a7,32
#	ecall
	
	addi t1,t1,-1 # subtracting 1 from t1 so that if t1 = 2 -> t1 = 1 (will be rendered once more)
                  #                           and if t1 = 1 -> t1 = 0 (won't be rendered again)	
	sb t1,5(t0)	  # Stores the new CURRENT_MAP's rendering byte
	
    lw a0, 0(t0) 	# a0 has the Map Address
    
    lbu a1, 6(t0)   # Loads current X on Map (starting X on Matrix (top left))
    lbu a2, 7(t0)   # Loads current Y on Map (starting Y on Matrix (top left))	

    la t0, PLYR_POS # Loads Player Position
    
    lbu t1, 0(a0)   # Loads first byte to check what type of map it is (0 - Fixed, 1 - Horizontal, 2 - Vertical)
    bnez t1, Not_Fixed_Map   # Checks if map is fixed
	   	li a3, 0	         # X offset (0, 4, 8, 12) -- Ignores Player's Offset for rendering Map
	    li a4, 0	         # Y offset (0, 4, 8, 12) -- Ignores Player's Offset for rendering Map
	    j CONTINUE_MAP_MOVE_RENDER	  
	Not_Fixed_Map:
	li t2, 1                        # t2 = 1 - Horizontal map
	bne t1, t2, Not_Horizontal_Map  # Checks if map is horizontal
	   	lbu a3, 6(t0)	            # Loads player's X offset (0, 4, 8, 12)
	    li a4, 0                    # Y offset (0, 4, 8, 12) -- Ignores Player's Offset for rendering Map	
	    j CONTINUE_MAP_MOVE_RENDER
	Not_Horizontal_Map:
	li t2, 2                     # t2 = 2 - Vertical map
	bne t1, t2,Not_Vertical_Map  # Checks if map is vertical
		li a3, 0                 # X offset (0, 4, 8, 12) -- Ignores Player's Offset for rendering Map
	    lbu a4, 7(t0)            # Loads player's Y offset (0, 4, 8, 12)
	    j CONTINUE_MAP_MOVE_RENDER
    Not_Vertical_Map: # If no map is detected (Error)
    	j END_MAP_MOVE_RENDER
    CONTINUE_MAP_MOVE_RENDER:
    li a6, m_screen_width	# Screen Width = 20
    li a7, m_screen_height	# Screen Height = 15
    li t3, 0		# Starting X for rendering (top left, related to Matrix)
    li t2, 0		# Starting Y for rendering (top left, related to Matrix)
	call RENDER_MAP
	END_MAP_MOVE_RENDER:
# Procedure finished: Loading Registers from Stack	
	lw ra, 0(sp)
    addi sp,sp,4
# End of Stack Operations
    ret
