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
	li tp, 0        # Map won't be dislocated
	
	call RENDER_MAP
	END_SCENE_RENDER:
# Procedure finished: Loading Registers from Stack	
	lw ra, 0(sp)
    addi sp,sp,4
# End of Stack Operations
    ret

########################    SWITCH MAP PREP   #########################
#              Setup for switching map for the first time             #
#                                                                     #
#    --------------       argument registers        --------------    #
#      a0 = FrameA_B address                                          #	
#                                                                     #
#    --------------         registers used          --------------    #
#      t0 = temporary operations                                      #  
#      t1 = NEXT_MAP address                                          # 
#      t2 = next door's number                                        # 
#                                                                     #
#######################################################################

SWITCH_MAP_PREP:
	la t1, NEXT_MAP  # Gets NEXT_MAP address
	la t5, CURRENT_MAP  # Gets CURRENT_MAP address
	lbu t2,2(a0)     # Gets next map's number
	sb t2,4(t1)      # and stores it in NEXT_MAP
	lbu t3,3(a0)     # Gets next map's door number
	sb t3,9(t1)      # and stores it in NEXT_MAP
	li t0,3          # Size of door address
	mul t3,t3,t0     # t3 has the number of bytes to be skipped after finding door address
	addi t3,t3,1     # t3 has the number of bytes to be skipped after finding door address and skiping number of doors byte
	# Comparing maps
#mv s8,a0
##mv s7,a7
#mv a0,t2
#li a7,1
#ecall
#la a0, DEBUG
#li a7,4
#ecall
#mv a7,s7
#mv a0,s8



	li t0, 1 
    bne t0, t2, SKIP_NEXT_MAP1 
		la t0, Map1   # If next map is Map1
		sw t0,0(t1)   # Store it into NEXT_MAP
		la t2,Doors1  # Gets Doors1 address 
    	j CONTINUE_SWITCH_MAP_PREP
    SKIP_NEXT_MAP1:
        li t0, 2 
        bne t0, t2, SKIP_NEXT_MAP2 
			la t0, Map2   # If next map is Map2
			sw t0,0(t1)   # Store it into NEXT_MAP
			la t2,Doors2  # Gets Doors2 address 
			j CONTINUE_SWITCH_MAP_PREP

    SKIP_NEXT_MAP2:
        li t0, 3 
        bne t0, t2, SKIP_NEXT_MAP3 
			la t0, Map3   # If next map is Map3
			sw t0,0(t1)   # Store it into NEXT_MAP
			la t2,Doors3  # Gets Doors3 address 
			j CONTINUE_SWITCH_MAP_PREP

    SKIP_NEXT_MAP3:
        li t0, 4  
        bne t0, t2, SKIP_NEXT_MAP4 
			la t0, Map4   # If next map is Map4
			sw t0,0(t1)   # Store it into NEXT_MAP
			la t2,Doors4  # Gets Doors4 address 
			j CONTINUE_SWITCH_MAP_PREP
    
    SKIP_NEXT_MAP4:
        li t0, 5 
        bne t0, t2, SKIP_NEXT_MAP5 
			la t0, Map5   # If next map is Map5
			sw t0,0(t1)   # Store it into NEXT_MAP
			la t2,Doors5  # Gets Doors5 address 
			j CONTINUE_SWITCH_MAP_PREP
    
    SKIP_NEXT_MAP5:
        li t0, 6
        bne t0, t2, SKIP_NEXT_MAP6
			la t0, Map6   # If next map is Map6
			sw t0,0(t1)   # Store it into NEXT_MAP
			la t2,Doors6  # Gets Doors6 address 
			j CONTINUE_SWITCH_MAP_PREP

    SKIP_NEXT_MAP6:
		li t0, 7 
		bne t0, t2, SKIP_NEXT_MAP7 
			la t0, Map7   # If next map is Map7
			sw t0,0(t1)   # Store it into NEXT_MAP
			la t2,Doors7  # Gets Doors7 address 
			j CONTINUE_SWITCH_MAP_PREP

	SKIP_NEXT_MAP7:
	# It will only go here if there's an error, so it'll return to right after the collision check on MOVE_PLAYER_X from PHISICS
		addi sp,sp,-32  # Restoring unchanged
		li a0,0         # Player won't be able to move
		j ERROR_ON_SWITCH

CONTINUE_SWITCH_MAP_PREP:
	addi sp,sp,32    # Freeing stack since it won't return to Physics

	lbu t4,1(t0)     # Gets next map's width

	add t2,t3,t2     # t2 has the address of destination door
	lbu t0,1(t2)     # Gets door's Y
	addi t0,t0,-5    # Gets screen's matrix top left Y
	sb t0,7(t1)      # Stores Y on NEXT_MAP

	li t0,8          # X Offset for map
	sb t0,8(t5)      # storing X offset for map
	sb zero,5(t1)    # Number of iterations
	lbu t3,0(a0)     # Loads door frame's current X position
	beqz t3, SWITCH_TOWARDS_LEFT  # If door frame is on the left (t3 = 0), next map is on the left
	# Otherwise, next map is on the right
		sb zero,10(t5)    # Stores 0 in the X dislocation for current map
		sb zero,11(t5)    # Stores switch direction (next map is on the right)
		sb zero,6(t1)     # Stores furthest X to the left of next map (0) on NEXT_MAP
		li t0, m_screen_width # Gets screen width in tiles (20)
		sb t0,8(t1)           # and stores it in X dislocation for the next map 
		j SWITCH_MAP
	SWITCH_TOWARDS_LEFT:
		li t0 1        # Direction is loaded by t0
		sb t0,11(t5)   # and stored (next map is on the left)
		sb t0,10(t5)   # Stores 1 in the X dislocation for current map
		sb t4,6(t1)    # and stores it on NEXT_MAP
		sb zero,8(t1)  # Stores 0 in the X dislocation for next map 

	    # j SWITCH_MAP  # Commented because SWITCH_MAP is right bellow


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

#MUDAR OFFSET 4
SWITCH_MAP:
	# Loop for switching map
	csrr a0,3073
    sub a0, a0, s1 #  # a0 = current time - last frame's time
    li t0, frame_rate_switch	# Loads frame rate (time (in ms) per frame)
    bltu a0,t0, SWITCH_MAP  # While a0 < minimum time for a frame, keep looping 
	
	la t1, NEXT_MAP         # Gets NEXT_MAP address
	lbu t1,5(t1)            # Gets number of iterations so far
	li a6, m_screen_width 	# Screen Width = 20     # width (Related to Matrix) of rendering area
	bge t1,a6,END_OF_SWITCH_MAP

	xori s0,s0,1			# inverts frame value
	# Rendering Current Map
	           
	la t0, CURRENT_MAP      # Gets CURRENT_MAP address
	lw a0,0(t0)	            # Loads Current Map's address
	lbu a1, 6(t0)           # Loads current X on Map (starting X on Matrix (top left))
	add a1,a1,t1            # Changes X
	lbu a2, 7(t0)           # Loads current Y on Map (starting Y on Matrix (top left))	
	lbu a3, 8(t0)           # Loads current X offset on Map
	li a4,0                 # Y offset will always be 0 during transition
	mv a5,s0	            # Current frame
	addi t1,t1,1            # For altering width
	#sub a6,a6,t1            # Rendering width = screen width - number of iterations - 1
	li a7, m_screen_height	# Screen Height = 15    # height (Related to Matrix) of rendering area
	li t3, 0	            # Starting X for rendering (top left, related to Matrix)
	li t2, 0	            # Starting Y for rendering (top left, related to Matrix)
	lbu tp,10(t0)           # X dislocation related to CURRENT_MAP

	call RENDER_MAP

	# Rendering Next Map
	la t0, CURRENT_MAP      # Gets CURRENT_MAP address
	la t1, NEXT_MAP         # Gets NEXT_MAP address
	lbu t4,5(t1)            # Gets number of iterations so far
	
	lw a0,0(t1)	            # Loads Next Map's address
	lbu a1, 6(t1)           # Loads current X on Map (starting X on Matrix (top left))
	lbu a2, 7(t1)           # Loads current Y on Map (starting Y on Matrix (top left))	
	lbu a3, 8(t0)           # Loads current X offset on Map
	li a4,0                 # Y offset will always be 0 during transition
	mv a5,s0	            # Current frame
	li t2,7
	slt t2,t2,a3
	add a6,t4,t2            # Screen Width = 20    (Number of iterations + 1)
	li a7, m_screen_height	# Screen Height = 15    # height (Related to Matrix) of rendering area
	li t3, 0	            # Starting X for rendering (top left, related to Matrix)
	li t2, 0	            # Starting Y for rendering (top left, related to Matrix)
	lbu tp,8(t1)           # X dislocation related to CURRENT_MAP
	sub tp,tp,t4

	call RENDER_MAP

	# Finishing Loop Operations
	li t0,0xFF200604		# carrega em t0 o endereco de troca de frame
	sw s0,0(t0)

	la t0, CURRENT_MAP      # Gets CURRENT_MAP address	
	la t1, NEXT_MAP         # Gets NEXT_MAP address
	lbu t2, 8(t0)           # Loads current X offset 
	beqz t2, SWITCH_MAP_CHANGE_OFFSET_TO_8
		li t2,0         # Otherwise, offset was set to 8 and it switches back to 0, completing an iteration
		sb t2, 8(t0)    # Stores new X offset 
		lbu t2,5(t1)    # Gets number of iterations so far
		addi t2,t2,1    # t2++
		sb t2,5(t1)     # Stores new iteration

		csrr s1,3073    # new time is stored in s1, in order to be compared later		
		j SWITCH_MAP
	SWITCH_MAP_CHANGE_OFFSET_TO_8:	
		li t2,8         # Sets X offset to
		sb t2, 8(t0)    # Stores new X offset

		csrr s1,3073    # new time is stored in s1, in order to be compared later		
		j SWITCH_MAP


	j SWITCH_MAP

END_OF_SWITCH_MAP:
	la t0,CURRENT_MAP
	la t1,NEXT_MAP
	lw t2,0(t1)        # Loads next map's address
	sw t2,0(t0)        # and stores it on CURRENT_MAP
	lbu t2,4(t1)       # Loads next map's number
	sb t2,4(t0)        # and stores it on CURRENT_MAP
	lbu t2,6(t1)       # Loads next map's X
	sb t2,6(t0)        # and stores it on CURRENT_MAP
	lbu t2,7(t1)       # Loads next map's Y
	sb t2,7(t0)        # and stores it on CURRENT_MAP
	sb zero,8(t0)      # Sets CURRENT_MAP's X offset to 0
	sb zero,9(t0)      # Sets CURRENT_MAP's Y offset to 0

	la t0, PLYR_POS
            li t1, resetmap7plyrXscreen
            sh t1, 0(t0)   # Stores new player's X related to the screen
            li t1, resetmap7plyrYscreen
            sb t1, 4(t0)   # Stores new player's Y related to the screen

            li t1, resetmap7plyrXoff    
            sb t1, 6(t0)   # Stores new player's X offset
            li t1, resetmap7plyrYoff
            sb t1, 7(t0)   # Stores new player's Y offset

            li t1, resetmap7plyrX
            sb t1, 8(t0)   # Stores new player's X related to the matrix
            li t1, resetmap7plyrY
            sb t1, 10(t0)  # Stores new player's Y related to the matrix



	j SETUP

	