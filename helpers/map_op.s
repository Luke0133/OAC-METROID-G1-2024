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
	li t1,2
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

########################      CHANGE MAP      #########################
#                      Setup for switching map                        #
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

CHANGE_MAP:
	la t1, NEXT_MAP  # Gets NEXT_MAP address
	la t5, CURRENT_MAP  # Gets CURRENT_MAP address
	lbu t2,2(a0)     # Gets next map's number
	sb t2,4(t1)      # and stores it in NEXT_MAP
	lbu t3,3(a0)     # Gets next map's door number
	sb t3,9(t1)      # and stores it in NEXT_MAP
	slli t3,t3,2     # t3 has the number of bytes to be skipped after finding door address
	addi t3,t3,1     # t3 has the number of bytes to be skipped after finding door address and skiping number of doors byte
	
	# Comparing maps
	li t0, 1 
    bne t0, t2, SKIP_NEXT_MAP1 
		la t0, Map1   # If next map is Map1
		sw t0,0(t1)   # Store it into NEXT_MAP
		la t2,Doors1  # Gets Doors1 address 

		la t4,Zoomers_Next   # Zoomers address
		la tp,Zoomers1       # Loads Zoomers1 address for Map 1
		sw tp,0(t4)          # and stores it

		la t4,Rippers_Next   # Rippers address
		sw zero,0(t4)   # Stores 0 to it (no rippers)

		la t4,Blocks_Next    # Blocks address
		sw zero,0(t4)        # there are no blocks in this map

    	j CONTINUE_CHANGE_MAP
    SKIP_NEXT_MAP1:
        li t0, 2 
        bne t0, t2, SKIP_NEXT_MAP2 
			la t0, Map2   # If next map is Map2
			sw t0,0(t1)   # Store it into NEXT_MAP
			
			la t4,Zoomers_Next   # Zoomers address
			la tp,Zoomers2       # Loads Zoomers2 address for Map 2
			sw tp,0(t4)          # and stores it

			la t4,Rippers_Next   # Rippers address
			la tp,Rippers2       # Loads Rippers2 address for Map 2
			sw tp,0(t4)          # and stores it

			la t4,Blocks_Next    # Blocks address
			la tp,Blocks2   # Loads Blocks2 address for Map 2
			sw tp,0(t4)     # and stores it

			la t2,Doors2  # Gets Doors2 address 
			j CONTINUE_CHANGE_MAP

    SKIP_NEXT_MAP2:
        li t0, 3 
        bne t0, t2, SKIP_NEXT_MAP3 
			la t0, Map3   # If next map is Map3
			sw t0,0(t1)   # Store it into NEXT_MAP
			la t2,Doors3  # Gets Doors3 address 

			la t4,Zoomers_Next   # Zoomers address
			la tp,Zoomers3       # Loads Zoomers3 address for Map 3
			sw tp,0(t4)          # and stores it

			la t4,Rippers_Next   # Rippers address
			sw zero,0(t4)   # Stores 0 to it (no rippers)

			la t4,Blocks_Next    # Blocks address
			sw zero,0(t4)        # there are no blocks in this map

			j CONTINUE_CHANGE_MAP

    SKIP_NEXT_MAP3:
        li t0, 4  
        bne t0, t2, SKIP_NEXT_MAP4 
			la t0, Map4   # If next map is Map4
			sw t0,0(t1)   # Store it into NEXT_MAP
			la t2,Doors4  # Gets Doors4 address  

			la t4,Zoomers_Next   # Zoomers address
			la tp,Zoomers4       # Loads Zoomers4 address for Map 4
			sw tp,0(t4)          # and stores it

			la t4,Rippers_Next   # Rippers address
			la tp,Rippers4       # Loads Rippers4 address for Map 4
			sw tp,0(t4)          # and stores it

			la t4,Blocks_Next    # Blocks address
			sw zero,0(t4)        # there are no blocks in this map
			
			j CONTINUE_CHANGE_MAP
    
    SKIP_NEXT_MAP4:
        li t0, 5 
        bne t0, t2, SKIP_NEXT_MAP5 
			la t0, Map5   # If next map is Map5
			sw t0,0(t1)   # Store it into NEXT_MAP
			la t2,Doors5  # Gets Doors5 address  

			la t4,Zoomers_Next   # Zoomers address
			la tp,Zoomers5       # Loads Zoomers5 address for Map 5
			sw tp,0(t4)          # and stores it

			la t4,Rippers_Next   # Rippers address
			sw zero,0(t4)   # Stores 0 to it (no rippers)

			la t4,Blocks_Next    # Blocks address
			sw zero,0(t4)        # there are no blocks in this map
			
			j CONTINUE_CHANGE_MAP
    
    SKIP_NEXT_MAP5:
        li t0, 6
        bne t0, t2, SKIP_NEXT_MAP6
			la t0, Map6   # If next map is Map6
			sw t0,0(t1)   # Store it into NEXT_MAP
			la t2,Doors6  # Gets Doors6 address  

			la t4,Zoomers_Next   # Zoomers address
			sw zero,0(t4)          # and stores it

			la t4,Rippers_Next   # Rippers address
			sw zero,0(t4)   # Stores 0 to it (no rippers)

			la t4,Blocks_Next    # Blocks address
			sw zero,0(t4)        # there are no blocks in this map
			
			j CONTINUE_CHANGE_MAP

    SKIP_NEXT_MAP6:
		li t0, 7 
		bne t0, t2, SKIP_NEXT_MAP7 
			la t0, Map7   # If next map is Map7
			sw t0,0(t1)   # Store it into NEXT_MAP
			la t2,Doors7  # Gets Doors7 address 

			la t4,Zoomers_Next   # Zoomers address
			sw zero,0(t4)          # and stores it

			la t4,Rippers_Next   # Rippers address
			sw zero,0(t4)   # Stores 0 to it (no rippers)

			la t4,Blocks_Next    # Blocks address
			sw zero,0(t4)        # there are no blocks in this map
			 
			j CONTINUE_CHANGE_MAP

	SKIP_NEXT_MAP7:
	# It will only go here if there's an error, so it'll return to right after the collision check on MOVE_PLAYER_X from PHISICS
		addi sp,sp,-32  # Restoring unchanged
		li a0,0         # Player won't be able to move
		j ERROR_ON_SWITCH

CONTINUE_CHANGE_MAP:
	addi sp,sp,32    # Freeing stack since it won't return to Physics

	lbu t4,1(t0)     # Gets next map's width

	la t0, Doors_Next # Gets Next Doors	address
	sw t2,0(t0)       # and stores t2 (the DoorsA address) in it

	add t2,t3,t2     # t2 has the address of destination door (DoorsA)
	lbu t0,1(t2)     # Gets door's Y
	addi t0,t0,-5    # Gets screen's matrix top left Y
	sb t0,7(t1)      # Stores Y on NEXT_MAP

	sb zero,5(t1)    # Number of iterations
	lbu t3,0(a0)     # Loads door frame's current X position
	beqz t3, SWITCH_TOWARDS_LEFT  # If door frame is on the left (t3 = 0), next map is on the left
	# Otherwise, next map is on the right
		sb zero,10(t5)    # Stores 0 in the X dislocation for current map
		sb zero,11(t5)    # Stores switch direction (next map is on the right)
		sb zero,6(t1)     # Stores furthest X to the left of next map (0) on NEXT_MAP
		li t0, m_screen_width # Gets screen width in tiles (20)
		sb t0,8(t1)           # and stores it in X dislocation for the next map 
		j ENTER_DOOR_ANIMATION_PREP
	SWITCH_TOWARDS_LEFT:
		li t0 1        # Direction is loaded by t0
		sb t0,11(t5)   # and stored (next map is on the left)
		sb t0,10(t5)   # Stores 1 in the X dislocation for current map
		addi t4,t4,-1  # Subtracts 1 from map's width
		sb t4,6(t1)    # and stores the result as the X on NEXT_MAP
		sb zero,8(t1)  # Stores 0 in the X dislocation for next map 

	    # j ENTER_DOOR_ANIMATION_PREP  # Commented because ENTER_DOOR_ANIMATION_PREP is right bellow


###########      ENTER DOOR ANIMATION      ###########
#    Preparatiosn for switching map with player's    #
#            animation for entering door             #
#                                                    #
#    ----------     registers used     ----------    #
#      t0 - t3 --> temporary operations              #  
#      a0,a1   --> used as arguments                 #
#                                                    #
######################################################

ENTER_DOOR_ANIMATION_PREP:
# Sets Player's input to 0
	la t0, PLYR_INPUT
	li t2, 0   # There isn't input
	sb t2, 0(t0) 

	la t0, PLYR_STATUS      # Loads Player Status
	li t1, 0        # Loads vertical direction (0 = normal)
	sb t1, 2(t0)    # Stores new direction on PLYR_STATUS

	sb t1, 5(t0)                  
	sb zero, 6(t0)  # Stores new direction on MOVE_X
	
	xori s0,s0,1   # Switches frame value (register)										
	li a0, 1       # Rendering player's trail operation
	li a1, 0       # Rendering full player (a1 doesn't really matter when a0 = 1)
	call RENDER_PLAYER

ENTER_DOOR_ANIMATION:
	call PLAY_SOUND
	# Frame loop for ENTER DOOR ANIMATION
	csrr t0,3073                       # Gets current time
    sub t0, t0, s1                     # t0 = current time - last frame's time
    li t1, frame_rate                  # Loads frame rate (time (in ms) per frame)
    bltu t0,t1, ENTER_DOOR_ANIMATION  # While t0 < minimum time for a frame, keep looping 

	xori s0,s0,1		    # Switches frame value (register)
	# 1st vertical movement check
	la t0, MOVE_Y  # Loads MOVE_Y
	lb t0,0(t0)    # and gets its value 
	beqz t0,ENTER_DOOR_ANIMATION_MOVE_PLAYER # If player is on the ground, go to ENTER_DOOR_ANIMATION_MOVE_PLAYER
	# Otherwise, wait for jump animation to complete
		call PHYSICS            # Physics operations
		call UPDATE_STATUS      # Updates player's sprite status

		li a0, 0     # Rendering player operation
		li a1, 0     # Rendering full player
		call RENDER_PLAYER
		j CONTINUE_ENTER_DOOR_ANIMATION
	ENTER_DOOR_ANIMATION_MOVE_PLAYER:
		la t0, CURRENT_MAP   # Loads CURRENT_MAP's address
		la t1, PLYR_POS   # Loads PLYR_POS's address
		lbu t2,11(t0)        # Loads switch direction
		beqz t2, ENTER_DOOR_ANIMATION_NEXT_ON_RIGHT # If next map is on the right, go to ENTER_DOOR_ANIMATION_NEXT_ON_RIGHT
		# Otherwise, next map is on the left and player should move left
			lh t0,0(t1)   # Gets player's current X related to screen
			sh t0,2(t1)   # Stores it on old X

			addi t0,t0,-4  # Adds 4 to player's X
			sh t0,0(t1)   # Stores new X

			la t0, MOVE_X  # Loads MOVE_X
			li t1,-1       # Loads direction (left)
			sb t1,0(t0)    # Stores on MOVE_X
			call UPDATE_STATUS      # Updates player's sprite status

			li a0, 0     # Rendering player operation
			li a1, 2     # Rendering player's 16 rightmost pixels
			call RENDER_PLAYER
			j CONTINUE_ENTER_DOOR_ANIMATION
		ENTER_DOOR_ANIMATION_NEXT_ON_RIGHT:
		# Next map is on the right and player should move right
			lh t0,0(t1)   # Gets player's current X related to screen
			sh t0,2(t1)   # Stores it on old X

			addi t0,t0,4  # Adds 4 to player's X
			sh t0,0(t1)   # Stores new X

			la t0, MOVE_X  # Loads MOVE_X
			li t1,1        # Loads direction (right)
			sb t1,0(t0)    # Stores on MOVE_X
			call UPDATE_STATUS      # Updates player's sprite status

			li a0, 0     # Rendering player operation
			li a1, 1     # Rendering player's 16 leftmost pixels
			call RENDER_PLAYER
			# j CONTINUE_ENTER_DOOR_ANIMATION
	CONTINUE_ENTER_DOOR_ANIMATION:
	call RENDER_DOOR_FRAMES	

	# Switching Frame on Bitmap Display											
	li t0,0xFF200604	# Loads Bitmap Display address
	sw s0,0(t0)         # Stores new frame value (from s0) on Bitmap Display

	li a0, 1     # Rendering player's trail operation
	li a1, 0     # Rendering full player (a1 doesn't really matter when a0 = 1)
	call RENDER_PLAYER

	call RENDER_UI
	#call MUSIC.PLAY

	# 2nd vertical movement check 
	la t0, MOVE_Y  # Loads MOVE_Y
	lb t0,0(t0)    # and gets its value 
	bnez t0,CONTINUE_ENTER_DOOR_ANIMATION_2 # If player is on the ground, go to CONTINUE_ENTER_DOOR_ANIMATION_2
		la t0, CURRENT_MAP   # Loads CURRENT_MAP's address
		la t1, PLYR_POS      # Loads PLYR_POS's address		
		lb t2,10(t1)         # Gets player's current Y related to matrix
		sb t2,11(t1)         # Stores it on old Y related to matrix
		lbu t2,11(t0)        # Loads switch direction
		beqz t2, ENTER_DOOR_ANIMATION_NEXT_ON_RIGHT_2 # If next map is on the right, go to ENTER_DOOR_ANIMATION_NEXT_ON_RIGHT_2
		# Otherwise, next map is on the left and player should move left
			lh t2,0(t1)           # Gets player's current X related to screen
			bnez,t2,CONTINUE_ENTER_DOOR_ANIMATION_2  # If player's current X = !0, continue loop
			# Otherwise, player's current X = 0, so continue to SWITCH_MAP_PREP
				li t1,4           # X Offset for map
				sb t1,8(t0)       # storing X offset for map
				j SWITCH_MAP_PREP 
		ENTER_DOOR_ANIMATION_NEXT_ON_RIGHT_2:
		# Next map is on the right and player should move right
			lh t3,0(t1)           # Gets player's current X related to screen
			li t1,screen_width    # Loads 320
			li t2,tile_size       # Loads 16
			sub t1,t1,t2          # t1 = 304	
			bne t1,t3,CONTINUE_ENTER_DOOR_ANIMATION_2  # If player's current X != 304, continue loop
			# Otherwise, player's current X = 304, so continue to SWITCH_MAP_PREP
				li t1,12          # X Offset for map
				sb t1,8(t0)       # storing X offset for map
				j SWITCH_MAP_PREP  
	CONTINUE_ENTER_DOOR_ANIMATION_2:
		csrr s1,3073    # new time is stored in s1, in order to be compared later		

		j ENTER_DOOR_ANIMATION	# Returns to beginning of loop

##########################    SWITCH MAP    ###########################
#         Loop that will take player from one map to another          #
#                                                                     #
#    --------------         registers used          --------------    #
#	   a1 -- a7,tp = registers for arguments                          #  
#      t0 -- t5    = temporary registers                              #
#                                                                     #
#######################################################################

	#  la t3,Doors      # Loads doors address
	#  lw t3,0(t3)      # and gets Current Map's doors address
	#  addi t3,t3,1     #
	#  mul a1,a1,3      # Multiplies a1 by 3 (number of bytes per door)
SWITCH_MAP_PREP:
	li a0,1   # Close doors
	li a1,1   # Close them fast    :)
	call CHANGE_DOORS_STATE

	la t1,NEXT_MAP
	li t2,1
	sb t2,10(t1)      # Loads render Next Map's

	call RESET_ENEMIES
	
	la t1,NEXT_MAP
	sb zero,10(t1)      # Loads render Next Map's

	# Setting rendering byte to 3 (switch map through door)
	la t0,CURRENT_MAP
	li t2,3
	sb t2,5(t0)

SWITCH_MAP:
	call PLAY_SOUND
	# Frame loop for SWITCH MAP
	csrr t0,3073
    sub t0, t0, s1 #  # a0 = current time - last frame's time
    li t1, frame_rate       # Loads frame rate (time (in ms) per frame)
    bltu t0,t1, SWITCH_MAP  # While a0 < minimum time for a frame, keep looping 
	
	# After waiting for loop
	xori s0,s0,1			# inverts frame value

	# Checking if loop should continue, while loading some info for rendering current map
	la t1, NEXT_MAP         # Gets NEXT_MAP address
	sb zero,10(t1)          # Stores 0 on Render Next Map Door (in order to render doors properly)
	lbu t1,5(t1)            # Gets number of iterations so far
	li a6, m_screen_width 	# Screen Width = 20     # width (Related to Matrix) of rendering area
	bge t1,a6,END_OF_SWITCH_MAP
	
	# SWITCH_MAP_CURRENT:   # Rendering Current Map  
		# Loading info for rendering
		la t0, CURRENT_MAP      # Gets CURRENT_MAP address
		lw a0,0(t0)	            # Loads Current Map's address
		lbu a2, 7(t0)           # Loads current Y on Map (starting Y on Matrix (top left))	
		lbu a3, 8(t0)           # Loads current X offset on Map
		li a4,0                 # Y offset will always be 0 during transition
		mv a5,s0	            # Current frame
		li a7, m_screen_height	# Screen Height = 15    # height (Related to Matrix) of rendering area
		li t3, 0	            # Starting X for rendering (top left, related to Matrix)
		li t2, 0	            # Starting Y for rendering (top left, related to Matrix)
		# Checking direction of switch
		lbu a1, 6(t0)           # Loads current X on Map (starting X on Matrix (top left))
		lbu tp,10(t0)           # X dislocation related to CURRENT_MAP
		lbu t4,11(t0)           # Loads switch direction
		beqz t4, SWITCH_MAP_CURRENT_ON_LEFT  # If next map is on the right, current map is on the left
		# Otherwise, current map is on the right
			li t4,3             # Loads 3 for holding comparision
			slt t4,t4,a3        # Sets t4 to 1 if X offset isn't 0 (in this case, if X offset < 4, X offset = 0)
			sub a6,a6,t1       # Screen Width = Number of iterations (X offset = 0) or Number of iterations + 1 (X offset != 0)
			add tp,tp,t1        # Gets dislocation by adding the number of iterations from it
			call RENDER_MAP
			j SWITCH_MAP_NEXT
		SWITCH_MAP_CURRENT_ON_LEFT:
			add a1,a1,t1            # Changes X
			# tp will be 0 on this case
			call RENDER_MAP
			# j SWITCH_MAP_NEXT
	
	SWITCH_MAP_NEXT:        # Rendering Next Map
		la t0, CURRENT_MAP      # Gets CURRENT_MAP address
		la t1, NEXT_MAP         # Gets NEXT_MAP address
		li t2,1                 # Loads 1 in order to render Next Map's Door
		sb t2,10(t1)            # Stores 1 on Render Next Map Door
		
		lw a0,0(t1)	            # Loads Next Map's address
		lbu a2, 7(t1)           # Loads current Y on Map (starting Y on Matrix (top left))	
		lbu a3, 8(t0)           # Loads current X offset on Map
		li a4,0                 # Y offset will always be 0 during transition
		mv a5,s0	            # Current frame
		li a7, m_screen_height	# Screen Height = 15    # height (Related to Matrix) of rendering area
		li t3, 0	            # Starting X for rendering (top left, related to Matrix)
		li t2, 0	            # Starting Y for rendering (top left, related to Matrix)

		# Checking direction of switch
		lbu a1, 6(t1)           # Loads current X on Map (starting X on Matrix (top left))
		lbu tp,8(t1)            # X dislocation related to CURRENT_MAP
		lbu t4,11(t0)           # Loads switch direction
		lbu t5,5(t1)            # Gets number of iterations so far		
		beqz t4, SWITCH_MAP_NEXT_ON_RIGHT  # If next map is on the right
		# Otherwise, next map is on the left
			sub a1,a1,t5        # Changes X
			li t4,20            # Loads 3 for holding comparision
			slt t4,t5,t4        # Sets t4 to 1 if number of iterations is less than 19
			add a6,t5,t4        # Screen Width = Number of iterations (if it's equal to 19) or Number of iterations + 1 (if it's < 19)
			# tp will be 0 on this case
			call RENDER_MAP
			j SWITCH_MAP_CONTINUE
		SWITCH_MAP_NEXT_ON_RIGHT:
			li t4,3             # Loads 3 for holding comparision
			slt t4,t4,a3        # Sets t4 to 1 if X offset isn't 0 (in this case, if X offset < 4, X offset = 0)
			add a6,t5,t4        # Screen Width = Number of iterations (X offset = 0) or Number of iterations + 1 (X offset != 0)
			lbu tp,8(t1)        # X dislocation related to CURRENT_MAP
			sub tp,tp,t5        # Gets dislocation by subtracting the number of iterations from it
			call RENDER_MAP
			# j SWITCH_MAP_CONTINUE

	SWITCH_MAP_CONTINUE:
	call UPDATE_DOORS       # Updates doors
	
	# Finishing Loop Operations
	li t0,0xFF200604		# carrega em t0 o endereco de troca de frame
	sw s0,0(t0)

	call RENDER_UI

	#call MUSIC.PLAY

	la t0, CURRENT_MAP      # Gets CURRENT_MAP address	
	la t1, NEXT_MAP         # Gets NEXT_MAP address
	lbu t3,11(t0)           # Loads switch direction
	lbu t2, 8(t0)           # Loads current X offset 

	beqz t3, SWITCH_MAP_OFFSET_RIGHT # If next map is on the right
	# Otherwise, if next map is on the left
		addi t2,t2,-4   # decrease offset by 4 
		# If offset isn't less than zero, end offset operations
		bge t2, zero, SWITCH_MAP_AFTER_OFFSET_OPERATION
		# Otherwise, complete iteration
			addi t2,t2,tile_size # Corrects negative offset by adding 16
			j SWITCH_MAP_ITERATE # iterates procedure 
	SWITCH_MAP_OFFSET_RIGHT: 	
		addi t2,t2,4      # increase offset by 4 
		li t3,tile_size   # loads 16 for operations
		# If offset isn't greater than 16, end offset operations
		blt t2, t3, SWITCH_MAP_AFTER_OFFSET_OPERATION 
		# Otherwise, complete iteration
			sub t2,t2,t3           # Corrects offset by subtracting 16
			#j SWITCH_MAP_ITERATE  # iterates procedure 
	SWITCH_MAP_ITERATE:
		lbu t3,5(t1)    # Gets number of iterations so far
		addi t3,t3,1    # t2++
		sb t3,5(t1)     # Stores new iteration
	SWITCH_MAP_AFTER_OFFSET_OPERATION:
		sb t2, 8(t0)    # Stores new X offset
		csrr s1,3073    # new time is stored in s1, in order to be compared later
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

	lbu t3,11(t0)  # Loads switch direction
	beqz t3,END_OF_SWITCH_MAP_SKIP_CHANGE_MAP_POSITION # If next map was on the right, player will be on the left door
	# Otherwise, player will be on the right side of the map
		lw t3,0(t0)    # Gets current map's address
		lbu t3,1(t3)   # and takes its width
		li t4,m_screen_width  # t4 = 20
		sub t4,t3,t4          # t4 = Current Map's X position
		sb t4,6(t0)           # Stores map's X
	END_OF_SWITCH_MAP_SKIP_CHANGE_MAP_POSITION:
		j SETUP

###########      LEAVE DOOR ANIMATION      ###########
#      After switching map, player will have an      #
#            animation for leavving door             #
#                                                    #
#    ----------     registers used     ----------    #
#      t0 - t3 --> temporary operations              #  
#      a0,a1   --> used as arguments                 #
#                                                    #
######################################################

LEAVE_DOOR_ANIMATION_PREP:
	# Setting rendering byte to 2
	la t0,CURRENT_MAP
	li t2,2            # Loads 3 (switch map through door)
	sb t2,5(t0)

	# Opening door
	la t1,NEXT_MAP
	lbu t1,9(t1)     # loads "next door"'s number
	slli t1,t1,2     # multiplies it by 4
	la a0, Doors     # Gets Doors address
	lw a0,0(a0)      # gets current map's doors address
	addi a0,a0,1     # skips number of doors
	add a0,a0,t1     # and adds t1 to get the correct door's address
	li t2,1             # Loads 1 (opening/closing)
    sb t2,2(a0)         # and stores it on door's state byte    
    li t2,opening_door  # Gets new counter (related to opening door -- negative, in order to open)
    sb t2,3(a0)         # and stores it on door's counter byte
    
	# Getting player's positions
	la t2, PLYR_POS
	# Making player's Y related to matrix
	lbu t4,7(t0)                # Loads map's Y
	addi t3,t4,door_Y_distance  # adds 6 to it to get Player's new Y related to matrix
	sb t3, 10(t2)               # and stores it 
	sb t3, 11(t2)               # as well as on old Y
	# Making player's Y related to screen
	sub t3,t3,t4                # Gets player's matrix Y related to map's matrix Y 
	slli t3,t3,tile_size_shift  # Multiplies t3 by 16 to get Player's new Y related to screen
	sb t3, 4(t2)                # and stores it

	# Making player's starting X related to matrix
	lbu t3,11(t0)  # Loads switch direction
	beqz t3,LEAVE_DOOR_ANIMATION_PREP_PLAYER_LEFT_DOOR # If next map was on the right, player will be on the left door
	# Otherwise, player will be on the right side of the map
		lw t3,0(t0)    # Gets current map's address
		lbu t3,1(t3)   # and takes its width
		addi t3,t3,-1         # Subtracts 1 from width to get Player's new X related to matrix (because coordinate starts on 0)
		j LEAVE_DOOR_ANIMATION_PREP_PLAYER_POS
	LEAVE_DOOR_ANIMATION_PREP_PLAYER_LEFT_DOOR:
		li t3,0               # Player's new X related to matrix
	LEAVE_DOOR_ANIMATION_PREP_PLAYER_POS:
		sb t3, 8(t2)      # Stores new player's X related to the matrix
		sb t3, 9(t2)      # as well as on player's old X related to the matrix
	# Making player's starting X related to screen
		lbu t4,6(t0)                # Loads map's X
		sub t3,t3,t4                # Gets player's matrix X related to map's matrix X 
		slli t3,t3,tile_size_shift  # Multiplies t3 by 16 to get Player's new X related to screen
		sh t3, 0(t2)   # Stores new player's X related to the screen
	# Setting player's offsets 
		li t3, 0       # For player's offset
		sb t3, 6(t2)   # Stores new player's X offset
		sb t3, 7(t2)   # Stores new player's Y offset
		# j LEAVE_DOOR_ANIMATION

LEAVE_DOOR_ANIMATION:
	call PLAY_SOUND
	# Frame loop for LEAVE DOOR ANIMATION
	csrr t0,3073                       # Gets current time
    sub t0, t0, s1                     # t0 = current time - last frame's time
    li t1, frame_rate                  # Loads frame rate (time (in ms) per frame)
    bltu t0,t1, LEAVE_DOOR_ANIMATION   # While t0 < minimum time for a frame, keep looping 

	xori s0,s0,1		    # Switches frame value (register)
	
	call UPDATE_DOORS       # Updates doors
	call MAP_MOVE_RENDER    # Renders map when necessary

	# Checking direction for moving player
	la t0, CURRENT_MAP   # Loads CURRENT_MAP's address
	la t1, PLYR_POS      # Loads PLYR_POS's address
	lbu t2,11(t0)        # Loads switch direction
	beqz t2, LEAVE_DOOR_ANIMATION_NEXT_ON_RIGHT # If next map is on the right, go to LEAVE_DOOR_ANIMATION_NEXT_ON_RIGHT
	# Otherwise, next map was on the left and player should move left
		lh t0,0(t1)   # Gets player's current X related to screen
		sh t0,2(t1)   # Stores it on old X

		addi t0,t0,-4  # Adds 4 to player's X
		sh t0,0(t1)    # Stores new X

		la t0, MOVE_X  # Loads MOVE_X
		li t1,-1       # Loads direction (left)
		sb t1,0(t0)    # Stores on MOVE_X
		call UPDATE_STATUS      # Updates player's sprite status

		li a0, 0     # Rendering player operation
		li a1,0     # Rendering full player
		call RENDER_PLAYER
		j CONTINUE_LEAVE_DOOR_ANIMATION
	LEAVE_DOOR_ANIMATION_NEXT_ON_RIGHT:
	# Next map was on the right and player should move right
		lh t0,0(t1)   # Gets player's current X related to screen
		sh t0,2(t1)   # Stores it on old X

		addi t0,t0,4  # Adds 4 to player's X
		sh t0,0(t1)   # Stores new X

		la t0, MOVE_X  # Loads MOVE_X
		li t1,1        # Loads direction (right)
		sb t1,0(t0)    # Stores on MOVE_X
		call UPDATE_STATUS      # Updates player's sprite status

		li a0, 0     # Rendering player operation
		li a1, 0     # Rendering full player
		call RENDER_PLAYER
		# j CONTINUE_LEAVE_DOOR_ANIMATION
	CONTINUE_LEAVE_DOOR_ANIMATION:
	call RENDER_DOOR_FRAMES

	# Switching Frame on Bitmap Display											
	li t0,0xFF200604	# Loads Bitmap Display address
	sw s0,0(t0)         # Stores new frame value (from s0) on Bitmap Display

	li a0, 1     # Rendering player's trail operation
	li a1, 0     # Rendering full player (a1 doesn't really matter when a0 = 1)
	call RENDER_PLAYER

	call RENDER_UI

	#call MUSIC.PLAY

	# Checking direction for moving player to see if loop should stop
	la t0, CURRENT_MAP   # Loads CURRENT_MAP's address
	la t1, PLYR_POS   # Loads PLYR_POS's address	
	lbu t2,11(t0)        # Loads switch direction
	beqz t2, LEAVE_DOOR_ANIMATION_NEXT_ON_RIGHT_2 # If next map is on the right, go to LEAVE_DOOR_ANIMATION_NEXT_ON_RIGHT_2
	# Otherwise, next map is on the left and player should move left
		lh t3,0(t1)           # Gets player's current X related to screen
		li t0,screen_width    # Loads 320 (screen width in pixels)
		li t2,tile_size       # Loads 16 (tile size)
		sub t0,t0,t2          # t0 = 304
		sub t0,t0,t2          # t0 = 288
		addi t0,t0,-8	      # Player should have an offset of 8
		bne t0,t3,CONTINUE_LEAVE_DOOR_ANIMATION_2  # If player's current X != 280, continue loop
		# Otherwise, player's current X = 280, so continue to SWITCH_MAP
			li t2,8           # Loads 8 for player's X offset
			sb t2,6(t1)       # and stores it
			lbu t2,8(t1)      # Gets player's current X related to matrix
			addi t2,t2,-2     # subtracts 1 from it
			sb t2,8(t1)       # and stores it back
			sb t2,9(t1)       # as well as storing on old X
			j END_LEAVE_DOOR_ANIMATION  # Finish procedure 
	
	LEAVE_DOOR_ANIMATION_NEXT_ON_RIGHT_2:
	# Next map is on the right and player should move right
		lh t2,0(t1)           # Gets player's current X related to screen
		li t3,tile_size       # Loads 16 (tile size)
		addi t3,t3,8          # Player should have an offset of 8
		bne t3,t2,CONTINUE_LEAVE_DOOR_ANIMATION_2  # If player's current X != 16, continue loop
		# Otherwise, player's current X = 24, so change their matrix X and X offset and stop loop
			li t0,8           # Loads 8 for player's X offset
			sb t0,6(t1)       # and stores it
			lbu t2,8(t1)      # Gets player's current X related to matrix
			addi t2,t2,1      # adds 1 to it
			sb t2,8(t1)       # and stores it back
			sb t2,9(t1)       # as well as storing on old X
			j END_LEAVE_DOOR_ANIMATION  # Finish procedure 
	
	CONTINUE_LEAVE_DOOR_ANIMATION_2:
		csrr s1,3073    # new time is stored in s1, in order to be compared later		
		j LEAVE_DOOR_ANIMATION	# Returns to beginning of loop

	END_LEAVE_DOOR_ANIMATION:
		# Closing door
		la t1,NEXT_MAP
		lbu t1,9(t1)     # loads "next door"'s number
		slli t1,t1,2     # multiplies it by 4
		la a0, Doors     # Gets Doors address
		lw a0,0(a0)      # gets current map's doors address
		addi a0,a0,1     # skips number of doors
		add a0,a0,t1     # and adds t1 to get the correct door's address
		li t2,1             # Loads 1 (opening/closing)
		sb t2,2(a0)         # and stores it on door's state byte    
		li t2,closing_door  # Gets new counter (related to closing door -- positive, in order to close)
		sb t2,3(a0)         # and stores it on door's counter byte

		csrr s1,3073      # new time is stored in s1, in order to be compared later		
		j GAME_LOOP       # go to GAME_LOOP  
