.text
# ----> Summary: render.s stores rendering related procedures
# 1 - RENDER (Renders image when address is given. It renders byte by byte (slow))
# 2 - RENDER WORD (Renders image when address is given. It renders word by word )
# 3 - RENDER COLOR (Renders a given color on a given space)
# 4 - RENDER PLAYER (Renders player based on its PLAYER_STATUS)
# LAST ONE (5?) - RENDER MAP (Takes a given map matrix and renders tiles acoording to the value stored on it)


#############################     RENDER     ############################
#   Renders image when address is given. It renders byte by byte (slow) #
#     -----------           argument registers           -----------    #
#       a0 = Image Address                                              #
#       a1 = X coordinate where rendering will start (top left)         #
#       a2 = Y coordinate where rendering will start (top left)         #
#       a3 = width of rendering area (usually the size of the sprite)   #
#       a4 = height of rendering area (usually the size of the sprite)  #
#       a5 = frame (0 or 1)                                             #
#       a6 = status of sprite (usually 0 for sprites that are alone)    #
#       a7 = operation (0 if normal printing, 1 cropped print)          #
# -- saved registers (recieved as arguments - only when on crop mode)-- #
#       s1 = X coordinate relative to sprite (top left)                 #
#       s2 = Y coordinate relative to sprite (top left)                 #
#       s3 = sprite width                                               #
#     -----------          temporary registers           -----------    #
#       t0 = bitmap display printing address                            #
#       t1 = image address                                              #
#       t2 = line counter                                               #
#       t3 = column counter                                             #
#       t4 = temporary operations                                       #
#########################################################################
RENDER:
beqz a7,NORMAL
	CROP_MODE:	# When rendering cropped sprite 	
		add a0,a0,s1	# Image address + X on sprite 
		mul t3,s3,s2	# t4 = sprite width * Y on sprite
		add a0,a0,t3	# a0 = Image address + X on sprite + sprite widht * Y on sprite
	NORMAL:		# Executed even if on crop mode
		mul t4,a6,a4	# Sprite offset (for files that have more than one sprite)
		mul t4,t4,a3	# Sprite Line offset (skips the first %width lines)
# not used #	addi a0,a0,8	# Skip image size info
		add a0,a0,t4	# Adds offset to image address
	#Propper rendering

	li t0,0x0FF0	#t0 = 0x0FF0
	add t0,t0,a5	# Rendering Address corresponds to 0x0FF0 + frame
	slli t0,t0,20	# Shifts 20 bits, making printing adress correct (0xFF00 0000 or 0xFF10 0000)
	add t0,t0,a1	# t0 = 0xFF00 0000 + X or 0xFF10 0000 + X
	li t1,320	# t1 = 320
	mul t1,t1,a2	# t1 = 320 * Y 
	add t0,t0,t1	# t0 = 0xFF00 0000 + X + (Y * 320) or 0xFF10 0000 + X + (Y * 320)
	
	mv t2,zero	# t2 = 0 (Resets line counter)
	mv t3,zero	# t3 = 0 (Resets column counter)
	
	PRINT_LINE:	
		lb t4,0(a0)	# loads byte(1 pixel) on t4
		sb t4,0(t0)	# prints 1 pixel from t4
		
		addi t0,t0,1	# increments bitmap address
		addi a0,a0,1	# increments image address
		
		addi t3,t3,1		# increments column counter
		blt t3,a3,PRINT_LINE	# if column counter < width, repeat
		
		addi t0,t0,320	# goes to next line on bitmap display
		sub t0,t0,a3	# goes to right X on bitmap display (current address - width)
		
		beqz a7, NORMAL_RENDER	# If not on crop mode
		CROP_RENDER:
			add a0,a0,s3	# a0 += sprite width	
			sub a0,a0,a3	# a0 -= rendering width
		NORMAL_RENDER: 
			mv t3,zero		# t3 = 0 (Resets column counter)
			addi t2,t2,1		# increments line counter
			bgt a4,t2,PRINT_LINE	# if height > line counter, repeat
			ret

###########################    RENDER WORD    ###########################
#   Renders image when address is given. It renders word by word        #
#     -----------           argument registers           -----------    #
#       a0 = Image Address                                              #
#       a1 = X coordinate where rendering will start (top left)         #
#       a2 = Y coordinate where rendering will start (top left)         #
#       a3 = width of rendering area (usually the size of the sprite)   #
#       a4 = height of rendering area (usually the size of the sprite)  #
#       a5 = frame (0 or 1)                                             #
#       a6 = status of sprite (usually 0 for sprites that are alone)    #
#       a7 = operation (0 if normal printing, 1 cropped print)          #
# -- saved registers (recieved as arguments - only when on crop mode)-- #
#       s1 = X coordinate relative to sprite (top left)                 #
#       s2 = Y coordinate relative to sprite (top left)                 #
#       s3 = sprite width                                               #
#     -----------          temporary registers           -----------    #
#       t0 = bitmap display printing address                            #
#       t1 = image address                                              #
#       t2 = line counter                                               #
#       t3 = column counter                                             #
#       t4 = temporary operations                                       #
#########################################################################
RENDER_WORD:
beqz a7,NORMAL_WORD
	CROP_MODE_WORD:	# When rendering cropped sprite 	
		add a0,a0,s1	# Image address + X on sprite 
		mul t3,s3,s2	# t4 = sprite width * Y on sprite
		add a0,a0,t3	# a0 = Image address + X on sprite + sprite widht * Y on sprite
	NORMAL_WORD:		# Executed even if on crop mode
		mul t4,a6,a4	# Sprite offset (for files that have more than one sprite)
		mul t4,t4,a3	# Sprite Line offset (skips the first %width lines)
# not used #	addi a0,a0,8	# Skip image size info
		add a0,a0,t4	# Adds offset to image address

	#Propper rendering

	li t0,0x0FF0	#t0 = 0x0FF0
	add t0,t0,a5	# Rendering Address corresponds to 0x0FF0 + frame
	slli t0,t0,20	# Shifts 20 bits, making printing adress correct (0xFF00 0000 or 0xFF10 0000)
	add t0,t0,a1	# t0 = 0xFF00 0000 + X or 0xFF10 0000 + X
	li t1,320	# t1 = 320
	mul t1,t1,a2	# t1 = 320 * Y 
	add t0,t0,t1	# t0 = 0xFF00 0000 + X + (Y * 320) or 0xFF10 0000 + X + (Y * 320)
	
	mv t2,zero	# t2 = 0 (Resets line counter)
	mv t3,zero	# t3 = 0 (Resets column counter)
	
	PRINT_LINE_WORD:	
		lb t4,0(a0)	# loads word(4 pixels) on t4
		sb t4,0(t0)	# prints 4 pixels from t4
		
		addi t0,t0,1	# increments bitmap address
		addi a0,a0,1	# increments image address
		
		addi t3,t3,1		# increments column counter
		blt t3,a3,PRINT_LINE_WORD	# if column counter < width, repeat
		
		addi t0,t0,320	# goes to next line on bitmap display
		sub t0,t0,a3	# goes to right X on bitmap display (current address - width)
		
		beqz a7, NORMAL_RENDER_WORD	# If not on crop mode
		CROP_RENDER_WORD:
			add a0,a0,s3	# a0 += sprite width	
			sub a0,a0,a3	# a0 -= rendering width
		NORMAL_RENDER_WORD: 
			mv t3,zero		# t3 = 0 (Resets column counter)
			addi t2,t2,1		# increments line counter
			bgt a4,t2,PRINT_LINE_WORD	# if height > line counter, repeat
			ret



############################## RENDER COLOR #############################
#                Renders a given color on a given space                 #
#     -----------           argument registers           -----------    #
#       a0 = color                                                      #
#       a1 = X coordinate where rendering will start (top left)         #	
#       a2 = Y coordinate where rendering will start (top left)         #
#       a3 = width of printing area (usually the size of the sprite)    #
#       a4 = height of printing area (usually the size of the sprite)   #
#       a5 = frame (0 or 1)                                             #
#       a6 = operation (0 - rendering 4 pixels at once;                 #
#                       1 -  rendering 2 pixels at once)                #	
#     -----------          temporary registers           -----------    #
#       t0 = bitmap display printing address                            #
#       t1 = temporary operations                                       #
#       t2 = line counter                                               #
#       t3 = column counter                                             # 
#########################################################################

RENDER_COLOR:
	li t0,0xFF0	# t0 = 0xFF0
	add t0,t0,a5	# Rendering Address corresponds to 0x0FF0 + frame
	slli t0,t0,20	# Shifts 20 bits, making printing adress correct (0xFF00 0000 or 0xFF10 0000)
	
	add t0,t0,a1	# t0 = 0xFF00 0000 + X or 0xFF10 0000 + X
	
	li t1,320	# t1 = 320
	mul t1,t1,a2	# t1 = 320 * Y 
	add t0,t0,t1	# t0 = 0xFF00 0000 + X + (Y * 320) or 0xFF10 0000 + X + (Y * 320)
	
	mv t2,zero	# t2 = 0 (Resets line counter)
	mv t3,zero	# t3 = 0 (Resets column counter)
	
	slli t1,a0,8	# Shifts 8 bits on a0
	add a0,a0,t1	# a0 now stores two bytes of the same color (e.g.: 0x000000FF -> 0x0000FFFF)
	
	bnez a6, PRINT_LINE_COLOR_HALF # If not printing 4 pixels at once
		slli t1,a0,16	       # Shifts 16 bits on a0
		add a0,a0,t1	       # a0 now stores four bytes of the same color (e.g.: 0x0000FFFF -> 0xFFFFFFFF)
		j PRINT_LINE_COLOR_WORD
		
	PRINT_LINE_COLOR_HALF:	
		sh a0,0(t0)	# Renders two color pixels at once
		addi t0,t0,2	# increments bitmap address by 2 bytes
		
		addi t3,t3,2			# increments column counter
		blt t3,a3,PRINT_LINE_COLOR_HALF	# if column counter < width, repeat
		
		addi t0,t0,320	# goes to next line on bitmap display
		sub t0,t0,a3	# goes to right X on bitmap display (current address - width)
		
		mv t3,zero			# t3 = 0 (resets column counter)
		addi t2,t2,1			# increments line counter
		bgt a4,t2,PRINT_LINE_COLOR_HALF	# if height > line counter, repeat
		ret			
		
	PRINT_LINE_COLOR_WORD:
		sw a0,0(t0)	# Renders four color pixels at once
		addi t0,t0,4	# increments bitmap address by 4 bytes
		
		addi t3,t3,4			# increments column counter
		blt t3,a3,PRINT_LINE_COLOR_WORD	# if column counter < width, repeat
		addi t0,t0,320	# goes to next line on bitmap display
		sub t0,t0,a3	# goes to right X on bitmap display (current address - width)
		
		mv t3,zero			# t3 = 0 (resets column counter)
		addi t2,t2,1			# increments line counter
		bgt a4,t2,PRINT_LINE_COLOR_WORD	# if height > line counter, repeat
		ret
		
##########################    RENDER PLAYER    ##########################
#              Renders player based on its PLAYER_STATUS                #
#     -----------           argument registers           -----------    #
#       a0 = 0 - render player sprite; 1 - render player's trail        #	
#     -----------          temporary registers           -----------    #
#       t0 =  PLYR STATUS                                               #
#       t1 =  HORIZONTAL DIRECTION                                      #
#       t2 =  MOVEX                                                     #
#       t3 =  MOVEY                                                     # 
#		t4 =  VERTICAL DIRECTION                                        #
#		t5 =  ATTACKING STATUS                                          #
#                                                                       #
# 	 ----------------------- description --------------------------
# 		this procedure is similar to a finite state machine, where samus 
# 		can be render according to her PLYR_STATUS
#########################################################################	

RENDER_PLAYER:
	la t0, PLYR_STATUS # Loads PLAYER_STATUS address
	la t2,PLYR_POS	# Loads PLYR_POS address

	# Loading informations for Rendering Sprite
	lh a1, 0(t2)	# Loads top left X coordinate related to sprite
	lbu a2, 4(t2)	# Loads top left Y coordinate related to sprite	
	mv a5, s0		# Gets frame 
	lbu a6, 0(t0)   # Loads Player's sprite status
	mv a7,zero 		# Operation (0 - normal operation)
	
	beqz a0, RENDER_PLAYER_NORMAL # If a0 = 0,  then player will be rendered normally
	j RENDER_PLAYER_TRAIL     # Otherwise (a0 = 1) render player's trail

	RENDER_PLAYER_NORMAL:
		# Loading informations for Checking Sprite
		lbu t1, 1(t0)	# Loads Player's horizontal direction (0 = Right, 1 = Left)
		lbu t2, 4(t0)   # Loads Player's morph ball status
		
		beqz t2, RENDER_PLAYER_STAND # ball mode = 0 ?  RENDER_PLAYER_STAND : RENDER_PLAYER_BALL
		j RENDER_PLAYER_BALL
		
	RENDER_PLAYER_STAND:
		lbu t2, 6(t0)   # Loads Player's MOVE_X value (-1 left, 1 right, 0 not moving on X axis)
		lbu t3, 7(t0)   # Loads Player's MOVE_Y value (-1 up, 1 right, 0 not moving on Y axis)
		lbu t4, 2(t0)	# Loads Player's vertical direction (0 = Normal, 1 = Up)
		lbu t5, 5(t0)	# Loads Player's attacking status (0 - no, 1 - yes)

		beqz t1, RENDER_PLYR_RIGHT # Checks if player is looking right
		j RENDER_PLYR_LEFT	   # If player is looking left

		RENDER_PLYR_RIGHT:
			add t1, t2, t3  # t1 = 0 ? ISN'T MOVING : IS MOVING
			beqz t1,RENDER_IDLE_RIGHT # Checks if player is mooving or not
			j NOT_IDLE_RIGHT	  # If player is moving or not

			RENDER_IDLE_RIGHT:
				li a3, 20  # Sprite's Widht
				mv a6, t5	# Idle sprites have their status set to 1 if player is attacking
				bnez t4, RENDER_IDLE_RIGHT_UP	# If player is looking up

				# Otherwise, render normal idle 
				la a0, Samus_Right_Idle # Loads Player's Image Address 
				li a4, 32  # Sprite's Height
				j START_RENDER_PLAYER # Start rendering player

				RENDER_IDLE_RIGHT_UP:
				addi a2,a2, -6 # Offseting sprite's Y so that it renders in propper place
				la a0, Samus_Right_Idle_Up # Loads Player's Image Address 
				li a4, 38  # Sprite's Height
				j START_RENDER_PLAYER # Start rendering player

			NOT_IDLE_RIGHT:
				bnez t3, RENDER_JUMP_RIGHT
				j NOT_JUMP_RIGHT

				RENDER_JUMP_RIGHT:
					#### STATUS 0,1 when jumping normally go to STATUS 1 of IDLE RIGHT/ ATK
					#### STATUS 2 when jumping normally go to STATUS 1 of MOVE RIGHT/ ATK
					#### STATUS 3 when jumping normally go to STATUS 0 (or 1) of JUMP RIGHT
					
					# CHECK SPIN JUMP?
					
					addi a1,a1, -4 # Offseting sprite's X so that it renders in propper place
					addi a2,a2, -6 # Offseting sprite's Y so that it renders in propper place
					li a4, 32  # Sprite's Height
					mv a6, t5	# Jump sprites have their status set to 1 if player is attacking
					bnez t4, RENDER_JUMP_RIGHT_UP	# If player is looking up
					# Otherwise, render normal jump 
						li a3, 24  # Sprite's Widht
						la a0, Samus_Right_Jump # Loads Player's Image Address 
						j START_RENDER_PLAYER   # Start rendering player

					RENDER_JUMP_RIGHT_UP:
						li a3, 20  # Sprite's Widht
						la a0, Samus_Right_Jump_Up # Loads Player's Image Address 
						j START_RENDER_PLAYER      # Start rendering player

				NOT_JUMP_RIGHT:
					beqz t4, RENDER_MOVEMENT_RIGHT
					j RENDER_MOVEMENT_RIGHT_UP

					RENDER_MOVEMENT_RIGHT:
						li a4, 32  # Sprite's Height
						beqz t5, RENDER_MOVEMENT_RIGHT_NORMAL
						j RENDER_MOVEMENT_RIGHT_ATTACK

						RENDER_MOVEMENT_RIGHT_NORMAL:
							la a0, Samus_Right	   # Loads Player's Image Address 
							li a3, 20              # Sprite's Widht
							j START_RENDER_PLAYER  # Start rendering player

						RENDER_MOVEMENT_RIGHT_ATTACK:
							la a0, Samus_Right_Attack  # Loads Player's Image Address 
							li a3, 28                  # Sprite's Widht
							j START_RENDER_PLAYER      # Start rendering player

					RENDER_MOVEMENT_RIGHT_UP:
						addi a2,a2, -6 # Offseting sprite's X so that it renders in propper place
						li a3, 20      # Sprite's Widht
						li a4, 38      # Sprite's Height
						beqz t5, RENDER_MOVEMENT_RIGHT_UP_NORMAL
						j RENDER_MOVEMENT_RIGHT_UP_ATTACK

						RENDER_MOVEMENT_RIGHT_UP_NORMAL:
							la a0, Samus_Right_Up  # Loads Player's Image Address
							j START_RENDER_PLAYER  # Start rendering player

						RENDER_MOVEMENT_RIGHT_UP_ATTACK:
							la a0, Samus_Right_Up_Attack  # Loads Player's Image Address
							j START_RENDER_PLAYER         # Start rendering player

		RENDER_PLYR_LEFT:
			addi a1,a1, -4 # Offseting sprite's X so that it renders in propper place
			add t1, t2, t3  # t1 will only be 0 if player isn't moving 
			beqz t1,RENDER_IDLE_LEFT # Checks if player is mooving or not
			j NOT_IDLE_LEFT	  # If player is moving or not

			RENDER_IDLE_LEFT:
				li a3, 20  # Sprite's Widht
				mv a6, t5	# Idle sprites have their status set to 1 if player is attacking
				bnez t4, RENDER_IDLE_LEFT_UP	# If player is looking up
					
				# Otherwise, render normal idle 
					la a0, Samus_Left_Idle # Loads Player's Image Address 
					li a4, 32  # Sprite's Height
					j START_RENDER_PLAYER # Start rendering player
				
				RENDER_IDLE_LEFT_UP:
					addi a2,a2, -6 # Offseting sprite's Y so that it renders in propper place
					la a0, Samus_Left_Idle_Up # Loads Player's Image Address 
					li a4, 38  # Sprite's Height
					j START_RENDER_PLAYER # Start rendering player

			NOT_IDLE_LEFT:
				bnez t3, RENDER_JUMP_LEFT
				j NOT_JUMP_LEFT

				RENDER_JUMP_LEFT:
					#### STATUS 0,1 when jumping normally go to STATUS 1 of IDLE LEFT/ ATK
					#### STATUS 2 when jumping normally go to STATUS 1 of MOVE LEFT/ ATK
					#### STATUS 3 when jumping normally go to STATUS 0 (or 1) of JUMP LEFT
					# CHECK SPIN JUMP?
					

					addi a2,a2, -4 # Offseting sprite's X so that it renders in propper place
					li a3, 24  # Sprite's Widht
					li a4, 32  # Sprite's Height
					mv a6, t5	# Jump sprites have their status set to 1 if player is attacking
					bnez t4, RENDER_JUMP_LEFT_UP	# If player is looking up
					
					
					
					# Otherwise, render normal jump 
					la a0, Samus_Left_Jump # Loads Player's Image Address 
					j START_RENDER_PLAYER   # Start rendering player
					
					RENDER_JUMP_LEFT_UP:
						la a0, Samus_Left_Jump_Up # Loads Player's Image Address 
						j START_RENDER_PLAYER      # Start rendering player

				NOT_JUMP_LEFT:
					beqz t4, RENDER_MOVEMENT_LEFT
					j RENDER_MOVEMENT_LEFT_UP

					RENDER_MOVEMENT_LEFT:
						addi a1,a1, -8 # Offseting sprite's X so that it renders in propper place
						li a4, 32      # Sprite's Height
						beqz t5, RENDER_MOVEMENT_LEFT_NORMAL
						j RENDER_MOVEMENT_LEFT_ATTACK
						
						RENDER_MOVEMENT_LEFT_NORMAL:
							la a0, Samus_Left	   # Loads Player's Image Address 
							li a3, 28              # Sprite's Widht
							j START_RENDER_PLAYER  # Start rendering player
						
						RENDER_MOVEMENT_LEFT_ATTACK:
							la a0, Samus_Left_Attack  # Loads Player's Image Address 
							li a3, 28                  # Sprite's Widht
							j START_RENDER_PLAYER      # Start rendering player

					RENDER_MOVEMENT_LEFT_UP:
						addi a2,a2, -6 # Offseting sprite's X so that it renders in propper place
						li a3, 20      # Sprite's Widht
						li a4, 38      # Sprite's Height
						beqz t5, RENDER_MOVEMENT_LEFT_UP_NORMAL
						j RENDER_MOVEMENT_LEFT_UP_ATTACK
						
						RENDER_MOVEMENT_LEFT_UP_NORMAL:
							la a0, Samus_Left_Up  # Loads Player's Image Address
							j START_RENDER_PLAYER  # Start rendering player
						
						RENDER_MOVEMENT_LEFT_UP_ATTACK:
							la a0, Samus_Left_Up_Attack  # Loads Player's Image Address
							j START_RENDER_PLAYER         # Start rendering player
		
		RENDER_PLAYER_BALL:
			la a0, Morph_Ball # Loads morph ball image address
			addi a2, a2, tile_size # Adds 16 to Player's Y
			li a3, 16 # Loads 16 to width of rendering area
			li a4, 16 # Loads 16 to height of rendering area	
			# j START_RENDER_PLAYER

		START_RENDER_PLAYER:
			mv s11, ra	# Moves ra to s11 -- so that we don't need to use the stack
			call RENDER	# Calls RENDER procedure
			mv ra, s11  # Returns s11 to ra -- so that we don't need to use the stack
			ret			# End of procedure
		

	RENDER_PLAYER_TRAIL:
		xori a5,s0,1	# Gets oposite frame
		li a6, 3	# Width (Number of Tiles) = 2
		li a7, 4	# Height (Number of Tiles) = 2

		la t0, PLYR_MATRIX  # Loads PLYR_MATRIX address
		lbu t3, 1(t0) # Loads Player's old X related to matrix (Starting X for rendering (top left, related to Matrix))
		
		lbu t2, 3(t0) # Loads Player's old Y related to matrix (Starting Y for rendering (top left, related to Matrix))

		addi t3,t3,-1
		addi t2,t2,-1


		mv s11, ra	# Moves ra to s11 -- so that we don't need to use the stack
		call SCENE_RENDER	# Calls SCENE_RENDER procedure
		mv ra, s11  # Returns s11 to ra -- so that we don't need to use the stack
		ret			# End of procedure

##########################    RENDER LIFE AND WEAPONS    ##########################
#              Renders life and weapons based on its usages                #
#     -----------           argument registers           -----------    #
#       a0,t0 = PLYR_HEALTH        #	
#		a1 = column
#		a2 = row
# 	    a3 = colors
#		a4 = frame
#		a7 = syscall for 'print integer'
#     -----------          temporary registers           -----------    #
#
# 	 ----------------------- description --------------------------
# 		this procedure is similar to a finite state machine, where samus 
# 		life points can be render according to her PLYR_HEALTH
#########################################################################	

RENDER_LIFE: 
	mv s11, ra	# Moves ra to s11 -- so that we don't need to use the stack
	call RENDER_LIFE_POINTS
	mv ra, s11
	ret
	
RENDER_LIFE_POINTS:
	la t0, PLYR_INFO
	lbu a0, 0(t0)

	#a3 = bgr fundo e bgr frente no a4
	li a1,32 # a1 = column
	li a2,28 # a2 = row 
	li a3,0xc7ff # a3 = colors 
	li a4,1 # a4 = frame
	li a7,101 # syscal for 'print integer'
	ecall
		
	lbu a0, 0(t0)
	
	li a1,32 # a1 = column
	li a2,28 # a2 = row 
	li a3,0xc7ff # a3 = colors 
	li a4,0 # a4 = frame
	li a7,101 #syscal for 'print integer'
	ecall

	ret

###############################          RENDER MAP          ##############################
#    Takes a given map matrix and renders tiles acoording to the value stored on it.      #
#   -- t2 and t3 are recieved as arguments:                                               #
#       > t2: line where rendering will begin (Y related to Matrix)                       #
#       > t3: column where rendering will begin (X related to Matrix)                     #
#   -- the arguments t2 and t3 are related to the full matrix, and not the 20 x 15        # 
#       screen matrix. They'll later be converted to the line and column related to       #
#       the screen sized matrix.                                                          #
#       Obs.: If you aren't rendering a sprite's trail, set t2 and t3 to 0                # 	
#     -------------               argument registers                  -------------       #
#       a0 = Map Matrix Address                                                           #
#       a1 = starting X on Matrix (top left)                                              #
#       a2 = starting Y on Matrix (top left)                                              #	
#       a3 = X offset (0, 4, 8, 12)                                                       #
#       a4 = Y offset (0, 4, 8, 12)                                                       #	 		  
#       a5 = frame (0 or 1)                                                               #
#       a6 = width (Related to Matrix) of rendering area                                  #
#       a7 = height (Related to Matrix) of rendering area                                 #
#     -------------            saved registers (uses stack)           -------------       #
#       s0 = current X and Y address on Matrix                                            #
#       s1 = Matrix Width                                                                 #
#       s2 = Y where line loop will stop                                                  #
#       s3 = X where column loop will stop                                                #			
#     -------------                temporary registers                -------------    	  #
#       t0 = temporary operations (in the begining, it has the address of tile to render) #
#       t1 = tile to be rendered                                                          #				
#       t2 = line counter (and also current Y) related to Matrix                          #
#       t3 = column counter (and also current X) related to Matrix                        #
#       t4 = temporary register for moving info                                           #
#       t5 = temporary register for moving info                                           #
#       t6 = temporary register for moving info                                           #
###########################################################################################
RENDER_MAP:

# Storing Registers on Stack
	addi sp,sp,-16
	sw s3,12(sp)
	sw s2,8(sp)
	sw s1,4(sp)
	sw s0,0(sp)
# End of Stack Operations
	addi t0,a0,3 	# skips first 3 bytes of information (goes to the actual matrix)
	add s0, t0, a1 	# s0 = Matrix Address + Starting X on Matrix
	lbu s1,1(a0)	# s1 = matrix width
	mul t0,s1,a2    # t0 = Matrix Width x Starting Y on Matrix
	add s0, s0, t0	# s0 = Address to current X and Y on Matrix
	
	RENDER_MAP_GetCurrentX:
	add s3,t3,a6 	# s3 will be compared with t3 (column counter) to go to next line
	beqz t3,RENDER_MAP_NoTrailX
	
	sub t3,t3,a1	# t3 now is the column counter related to the screen matrix
	add s3,t3,a6
	add s0, s0, t3 	# s0 = Matrix Address + Current X on Matrix
	j RENDER_MAP_GetCurrentY
	
	RENDER_MAP_NoTrailX:
	beqz a3, RENDER_MAP_GetCurrentY # If there's no X offset
	li t0, m_screen_width
	blt a6,t0 RENDER_MAP_GetCurrentY # If width of rendering area is smaller than the screen's width, ignore
	addi s3,t0,1	# if rendering a full screen (20 wide) with offset, will need to render 21 tiles
		
	RENDER_MAP_GetCurrentY:
	add s2,t2,a7 	# s2 will be compared with t2 (column counter) to go to next line
	beqz t2,RENDER_MAP_NoTrailY
	
	sub t2,t2,a2	# t2 now is the column counter related to the screen matrix
	add s2,t2,a7
	mul t0,s1,t2    # t0 = Matrix Width x Current Y on Matrix
	add s0, s0, t0	# s0 = Address to current X and Y on Matrix
	j RENDER_MAP_LOOP
	
	RENDER_MAP_NoTrailY:
	beqz a4, RENDER_MAP_LOOP # If there's an X offset
	li t0, m_screen_height
	blt a7,t0 RENDER_MAP_LOOP # If height of rendering area is smaller than the screen's height, ignore
	addi s2,t0,1	# if rendering a full screen (15 wide) with offset, will need to render 16 tiles
	
RENDER_MAP_LOOP:
	lbu t1,0(s0)	# loads byte stored on matrix for checking what is the tile
	bnez t1,NotBackground
	j CONTINUE_RENDER_MAP

	NotBackground:
		li t0, 40 # Value where doors start
		bge t1, t0, RENDER_DOOR # If it's a door
		la t0, Tileset # Loads Tileset address to t0
		addi t1,t1,-1  # t1 = Tile Number - 1 (so that if t1 = 1, 0 tiles will be skipped)
		slli t1,t1,8   # t1 = (Tile Number - 1) x 256
		add t0,t0,t1  # t0 will skip (Tile Number - 1) x 256 bytes (Tile Number - 1 tiles) 
		j CONTINUE_RENDER_MAP
	RENDER_DOOR: 
		mv t6,zero   # Resets counter
		la t4, Doors # Loads Doors address
		lw t4,0(t4)	 # Gets the current map's door address
		lbu t5,0(t4) # Gets the number of doors in this map
		addi t4,t4,1 # Starting address of the map's first door
		RENDER_DOOR_LOOP:
			# Checking if current door will be rendered
			lbu tp, 0(t4) # Loads door's X on matrix
			add t0,a1,t3  # Gets current X on map matrix
			bne tp, t0, NEXT_IN_DOOR_LOOP # If door's X isn't the same as current X, skip this door
			lbu tp, 1(t4) # Loads door's Y on matrix
			add t0,a2,t2  # Gets current Y on map matrix
			sub tp,t0,tp  # tp needs to be equal to 0, 1 or 2 in order to be a tile from this door
			li t0,2 # 2 is the threshold to be compared with tp
			bgtu tp,t0, NEXT_IN_DOOR_LOOP # If current Y is above the door's uppermost Y or bellow it's downmost Y, skip this door
			# If none of the conditions on the branches were met, this current door will be rendered
			lbu tp, 2(t4) # Loads door's state
			bge tp,t0, END_RENDER_DOOR_LOOP # If door is open (state = 2 -- >= 2 for containing errors)
			# Otherwise, check the following
				la t0, Tileset # Loads Tileset address to t0
				addi t1,t1,-1  # t1 = Tile Number - 1 (so that if t1 = 1, 0 tiles will be skipped)
				add t1,t1,tp   # t1 will change if door is opening (tp = 1)
				slli t1,t1,8   # t1 = (Tile Number - 1) x 256
				add t0,t0,t1   # t0 will skip (Tile Number - 1) x 256 bytes (Tile Number - 1 tiles) 
				j CONTINUE_RENDER_MAP
			NEXT_IN_DOOR_LOOP:
				addi t4,t4,3 # Going to the next door's address
				addi t6,t6,1 # Iterating counter by 1
				bge t6,t5, END_RENDER_DOOR_LOOP # If all of the map's doors were checked, end loop
				j RENDER_DOOR_LOOP # otherwise, go back to the loop's begining
	END_RENDER_DOOR_LOOP:
	# This is only reached if no door was found (error) or if door is open, so background color will be rendered
		mv t1,zero
		
	CONTINUE_RENDER_MAP:
	# Storing Registers on Stack
	addi sp,sp,-52
	sw s3,48(sp)
	sw s2,44(sp)
	sw s1,40(sp)
	sw a7,36(sp)
	sw a6,32(sp)
	sw a4,28(sp)
	sw a3,24(sp)
	sw a2,20(sp)
	sw a1,16(sp)
	sw a0,12(sp)
	sw t2,8(sp)
	sw t3,4(sp)
	sw ra,0(sp)
	
	# End of Stack Operations
	mv a0, t0 # Moves t0 (storing tile address) to a0
	# Defining rendering coordinates
	li t0, tile_size 	# Tile size = 16
	mul t4,t3,t0		# t4 gets the X value relative to the screen (t3 (current X) * tile size)
	mul t5,t2,t0		# t5 gets the Y value relative to the screen (t2 (current Y) * tile size)
	# Obs.: don't use t4 and t5 until stack is saved, unless it's related to rendering coordinates
	li t6,0
	bnez a3, X_Offset 	# If there's a X offset
	j Check_Y_Offset
	X_Offset:
		bnez t3, TryRightOffset  # If t3 (current colum, i.e., current X) = 0, it's on the left border
		li t6,1			 # t6 = 1: Cropping leftmost tile
		j START_RENDER_MAP  	 # start rendering process
		TryRightOffset:
		li t0, m_screen_width    # screen width related to matrix = 20
		bne t3, t0, NoX_Offset   # If t3 = 20, it's on the right border
		li t6,2			 # t6 = 2: Cropping rightmost tile
		NoX_Offset:
		j START_RENDER_MAP	 # start rendering process
	
	Check_Y_Offset:
	bnez a4, Y_Offset		 # Or a Y offset, go to offset operations
	j START_RENDER_MAP
	
	Y_Offset:
		bnez t2, TryBottomOffset # If t3 (current colum, i.e., current X) = 0, it's on the top border
		li t6,1			 # t6 = 1: Cropping uppermost tile
		j START_RENDER_MAP	 # start rendering process
		TryBottomOffset:
		li t0, m_screen_height   # screen height related to matrix = 15
		bne t2, t0, NoY_Offset   # If t2 = 15, it's on the lower border
		li t6,2			 # t6 = 2: Cropping lowermost tile
		NoY_Offset:
		j START_RENDER_MAP	 # start rendering process
	
	START_RENDER_MAP:
	bnez t1,NormalRender
	# Color Render
#################################### DEBUG 	#####################
	slt a0,zero,s8
###############################################################	
	#	li a0, 0x00 		# Black
		mv a1, t4		# Top Left X
		mv a2, t5		# Top Left Y	
		mv a6, zero
		# a5 doesn't change
		bnez t6, CropColor 
		j NoCropColor
		CropColor:
		li a6, 1
		addi t6,t6,-1
		bnez t6, RightBottomColorCrop
			LeftTopColorCrop:
				li t0, tile_size	
				sub a3,t0, a3		# a3 will hold rendering widht that is equal to the tile size (16) - X offset
				sub a4,t0, a4		# a4 will hold rendering height that is equal to the tile size (16) - Y offset
				j StartColorRender
			RightBottomColorCrop:	
				sub a1,a1,a3		# a1 will shift left the ammount of a3 (currently X offset) 
				sub a2,a2,a4		# a2 will shift up the ammount of a4 (currently Y offset)
				CheckXColor:
				bnez a3, CheckYColor # If X offset (a3) isn't zero, the widht for rendering the cropped tile will be the X offset
				li a3, tile_size	    # otherwise, it'll be the tile size
				CheckYColor:
				bnez a4, EndRightBottomCropColor # If Y offset (a4) isn't zero, the widht for rendering the cropped tile will be the Y offset
				li a4, tile_size	    # otherwise, it'll be the tile size
				EndRightBottomCropColor:
				j StartColorRender
		NoCropColor:
			sub a1,a1,a3		# a1 will shift left the ammount of a3 (currently X offset) 
			sub a2,a2,a4		# a2 will shift up the ammount of a4 (currently Y offset)	
			li a3, tile_size	# Tile Width (Screen)
			li a4, tile_size	# Tile Height (Screen)	
		
		StartColorRender:
		call RENDER_COLOR
		j EndRender
	
	NormalRender:
		# a0 has the tile address
		mv a1, t4		# Top Left X where tile will start rendering
		mv a2, t5		# Top Left Y where tile will start rendering			
		mv a6,zero		# Tiles only have one image, thus their status is allways 0
		# If no offset is taken into account, will skip unecessary parameters  
		bnez t6, Continue_Crop 
		j Skip_Offset
		Continue_Crop : 
		li a7,1			# Cropped Render operations
		addi t6,t6,-1		# After this, t6 = 0 or t6 = 1
		bnez t6, RightBottomCrop
		LeftTopCrop:	 # Will crop tile from the left or from the top
			mv s1, a3		# s1 will store the X offset (where rendering will start from)
			mv s2, a4		# s2 will store the Y offset (where rendering will start from)
			li s3, tile_size	# s3 = 16
			sub a3,s3, s1		# a3 will hold rendering widht that is equal to the tile size (16) - X offset
			sub a4,s3, s2		# a4 will hold rendering height that is equal to the tile size (16) - Y offset
			j Start_NormalRender
		RightBottomCrop: # Will crop tile from the right or bottom
			mv s1,zero		# s1 = 0 (rendering will start from the left)
			mv s2,zero		# s2 = 0 (rendering will start from the top)
			li s3, tile_size	# s3 = 16
			sub a1,a1,a3		# a1 will shift left the ammount of a3 (currently X offset) 
			sub a2,a2,a4		# a2 will shift up the ammount of a4 (currently Y offset)
			CheckX:
			bnez a3, CheckY # If X offset (a3) isn't zero, the widht for rendering the cropped tile will be the X offset
			li a3, tile_size	    # otherwise, it'll be the tile size
			CheckY:
			bnez a4, EndRightBottomCrop # If Y offset (a4) isn't zero, the widht for rendering the cropped tile will be the Y offset
			li a4, tile_size	    # otherwise, it'll be the tile size
			EndRightBottomCrop:
			j Start_NormalRender
		# If no offset is taken into account, a3 and a4 will be overriten with the deffault tile size (16)  
		Skip_Offset:
		sub a1,a1,a3		# a1 will shift left the ammount of a3 (currently X offset) 
		sub a2,a2,a4		# a2 will shift up the ammount of a4 (currently Y offset) 
		li a3, tile_size	# Tile Width (Relative to Screen)
		li a4, tile_size	# Tile Height (Relative to Screen)
		mv a7,zero		# Normal Render operations
		Start_NormalRender:
		call RENDER_WORD
	
	EndRender:
# Procedure finished: Loading Registers from Stack
	lw s3,48(sp)
	lw s2,44(sp)
	lw s1,40(sp)
	lw a7,36(sp)
	lw a6,32(sp)
	lw a4,28(sp)
	lw a3,24(sp)
	lw a2,20(sp)
	lw a1,16(sp)
	lw a0,12(sp)
	lw t2,8(sp)
	lw t3,4(sp)
	lw ra,0(sp)
	addi sp,sp,52
# End of Stack Operations
			
	addi t3,t3,1	# Increments column counter (current X on Matrix)
	addi s0,s0,1	# Goes to next byte
	bge t3,s3,CONTINUE_LINE	# if column counter >= width, repeat
	j RENDER_MAP_LOOP	# if column counter < width, repeat
	CONTINUE_LINE:

		add s0,s0,s1	# s0 = Current Address on Matrix + Matrix Width
		li t0, m_screen_width
		bge s3,t0, MINUS_WIDTH
		sub s0,s0,a6	# s0 = New Current Address on Matrix 
		sub t3,t3,a6	# t3 = 0 (resets column counter)
		j CONTINUE_LINE2
		MINUS_WIDTH:
		sub s0,s0,s3
		mv t3,zero	# t3 = 0 (resets column counter)
		CONTINUE_LINE2:
		
		addi t2,t2,1	# Increments line counter (current Y on Matrix)
		bge t2,s2,CONTINUE_COLUMN # If height > line counter, repeat
		j RENDER_MAP_LOOP	  # Return to beggining of loop
		CONTINUE_COLUMN:
	# Procedure finished: Loading Registers from Stack
		lw s3,12(sp)
		lw s2,8(sp)
		lw s1,4(sp)
		lw s0,0(sp)
		addi sp,sp,16	
	# End of Stack Operations: Return to caller		
		ret


