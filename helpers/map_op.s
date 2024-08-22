.text

##########################     MAP MOVE RENDER     ########################
#   Will prepare for rendering map based on whether it should be or not   #
#   -------------------------------------------------------------------   #
#    It takes no arguments and uses only temporary registers (t0 - t3)    #
#           and a0 (in order to send information of normal map            #
#                       rendering to SCENE RENDER)                        #
###########################################################################

MAP_MOVE_RENDER:
	la t0, CURRENT_MAP  # Loads CURRENT_MAP's address
	lbu t1, 5(t0)       # Loads on t1 the CURRENT_MAP's rendering byte
	li t2,3				# Loads number 3 -- related to "switch map" operation
	blt t1,t2 CHECK_MAP_MOVE_RENDER_1 # If the rendering byte is 0, 1 or 2
		ret				# If the rendering byte isn't <= 2
	CHECK_MAP_MOVE_RENDER_1:
		beqz t1, END_MAP_MOVE_RENDER # If the rendering byte is 0
		# If map is allowed to render (t1 = 1)
			li a0, 0	   # in order to render map normally
			addi t1,t1,-1  # subtracting 1 from t1 so that if t1 = 2 -> t1 = 1 (will be rendered 
						   # once more) and if t1 = 1 -> t1 = 0 (won't be rendered again)	
			sb t1,5(t0)	   # Stores the new CURRENT_MAP's rendering byte
			j SCENE_RENDER # Starts scene rendering procedure
	END_MAP_MOVE_RENDER:
		# If map can't be rendered (t1 = 0)
		ret               
	       

##########################    SCENE RENDER    #########################
#        Will render map based on player position and map type        #
#                   (horizontal, vertical or fixed)                   #
#    --------------       argument registers        --------------    #
#      a0 = 0 - renders map normally; 1 - renders trail*              #	
# ------------------------------------------------------------------- #
#    * When a0 = 1, then 4 more arguments are needed in order to      #
#    render a sprite's trail:                                         #
#      a5 = frame for rendering (oposite of current frame)            #
#      a6 = width (Related to Matrix) of rendering area               #
#      a7 = height (Related to Matrix) of rendering area              #
#      t2 = line where rendering will begin (Y related to Matrix)     #
#      t3 = column where rendering will begin (X related to Matrix)   #     
#######################################################################
	
SCENE_RENDER:
# Storing Registers on Stack
    addi sp,sp,-4
    sw ra, 0(sp)
# End of Stack Operations
	bnez a0, SKIP_SCENE_RENDER_ARGUMENTS # If a0 = 1, the arguments bellow have already been set
	# Otherwise (a0 = 0) set the arguments for a rendering the whole screen
		mv a5,s0	# Current frame
		li a6, m_screen_width	# Screen Width = 20
		li a7, m_screen_height	# Screen Height = 15
		li t3, 0	# Starting X for rendering (top left, related to Matrix)
		li t2, 0	# Starting Y for rendering (top left, related to Matrix)
	SKIP_SCENE_RENDER_ARGUMENTS:
	
    la t0, CURRENT_MAP  # Loads CURRENT_MAP's address
    lw a0, 0(t0) 	# a0 now has the Map Address
    
    lbu a1, 6(t0)   # Loads current X on Map (starting X on Matrix (top left))
    lbu a2, 7(t0)   # Loads current Y on Map (starting Y on Matrix (top left))	
    lbu a3, 8(t0)   # Loads current X offset on Map
    lbu a4, 9(t0)   # Loads current Y offset on Map
	
	call RENDER_MAP
	END_SCENE_RENDER:
# Procedure finished: Loading Registers from Stack	
	lw ra, 0(sp)
    addi sp,sp,4
# End of Stack Operations
    ret

##########################    SWITCH MAP    ###########################
#    Will go from one map to another after, based on the door frame   #
#                                                                     #
#    --------------       argument registers        --------------    #
#      a0 = FrameA_B address                                          #	
#                                                                     #
#    --------------         registers used          --------------    #
#	   a1 = CURRENT_MAP address (located on main.s)		              #
#	   a2 = current map's address (located on matrix.data)	          #
#      a3 = PLYR_POS                                                  #
#      a4 = Move_X/Y in tile format                                   #
#      a6 = player offset (t4)                                        #
#      a7 = player x on matrix                                        #
#      t0 -- t5 = Temporary Registers                                 #  
#                                                                     #
#######################################################################

SWITCH_MAP:
	la a1,CURRENT_MAP
	lw a2,0(a1)
	lbu a3
	SWITCH_LOOP:

		
		addi sp,sp,-32
		sw a7,28(sp)
		sw a6,24(sp)
		sw a4,20(sp)
		sw a3,16(sp)
		sw a2,12(sp)
		sw a1,8(sp)
		sw a0,4(sp)
		sw ra,0(sp)
		
		lbu a1, 6(t0)   # Loads current X on Map (starting X on Matrix (top left))
		lbu a2, 7(t0)   # Loads current Y on Map (starting Y on Matrix (top left))	
		lbu a3, 8(t0)   # Loads current X offset on Map
		lbu a4, 9(t0)   # Loads current Y offset on Map
		mv a5,s0	# Current frame
		li a6, m_screen_width	# Screen Width = 20     # width (Related to Matrix) of rendering area  # CHANGE
		li a7, m_screen_height	# Screen Height = 15    # height (Related to Matrix) of rendering area
		li t3, 0	# Starting X for rendering (top left, related to Matrix)     # CHANGE
		li t2, 0	# Starting Y for rendering (top left, related to Matrix)     # CHANGE

		call RENDER_MAP

	# Procedure finished: Loading Registers from Stack
		lw a7,28(sp)
		lw a6,24(sp)
		lw a4,20(sp)
		lw a3,16(sp)
		lw a2,12(sp)
		lw a1,8(sp)
		lw a0,4(sp)
		lw ra,0(sp)
		addi sp,sp,32

	j SETUP

	